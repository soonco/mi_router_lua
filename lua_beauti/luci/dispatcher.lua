-- ============================================================================
-- LuCI 核心调度器模块
-- 负责 URL 路由、认证、权限控制和请求分发
-- 这是 LuCI Web 框架的核心组件
-- ============================================================================

-- 加载依赖模块
local fs = require("nixio.fs")
local bit = require("bit")
local sys = require("luci.sys")
local init = require("luci.init")
local util = require("luci.util")
local http = require("luci.http")
local nixio = require("nixio")
require("nixio.util")
local XQSecureUtil = require("xiaoqiang.util.XQSecureUtil")

-- 定义模块
module("luci.dispatcher", package.seeall)

-- 创建线程本地上下文
context = util.threadlocal()

-- 国际化模块
i18n = require("luci.i18n")

-- 将文件系统模块挂载到 _M
_M.fs = fs

-- 认证器表，存储各种认证方式
authenticator = {}

-- ============================================================================
-- URL 构建函数
-- ============================================================================

-- 构建 URL 路径
-- @param ... - 路径组件
-- @return string - 完整的 URL 路径
function build_url(...)
    local path = {...}
    local url = {}
    
    -- 获取脚本名称作为基础路径
    url[1] = http.getenv("SCRIPT_NAME") or ""
    
    -- 添加 URL 令牌参数
    for key, value in pairs(context.urltoken or {}) do
        url[#url + 1] = "/;"
        url[#url + 1] = http.urlencode(key)
        url[#url + 1] = "="
        url[#url + 1] = http.urlencode(value)
    end
    
    -- 添加路径组件
    for _, component in ipairs(path) do
        -- 验证路径组件格式
        if component:match("^[a-zA-Z0-9_%-%.%%/,;]+$") then
            url[#url + 1] = "/"
            url[#url + 1] = component
        end
    end
    
    return table.concat(url)
end

-- ============================================================================
-- 节点可见性检查函数
-- ============================================================================

-- 检查节点是否可见
-- @param node table - 路由节点
-- @return boolean - 是否可见
function node_visible(node)
    if node then
        local hasTitle = node.title and #node.title > 0
        local hasTarget = node.target
        local isHidden = node.hidden
        local targetType = type(node.target)
        local hasChildren = type(node.nodes) == "table" and next(node.nodes) ~= nil
        
        return hasTitle and hasTarget and not isHidden
    end
    return false
end

-- 获取节点的可见子节点列表
-- @param node table - 父节点
-- @return table - 可见子节点名称列表
function node_childs(node)
    local childs = {}
    if node then
        for name, child in pairs(node.nodes or {}) do
            if node_visible(child) then
                childs[#childs + 1] = name
            end
        end
    end
    return childs
end

-- ============================================================================
-- 错误处理函数
-- ============================================================================

-- 显示 404 错误页面
-- @param message string - 错误消息
-- @return boolean - 始终返回 false
function error404(message)
    luci.http.status(404, "Not Found")
    message = message or "Not Found"
    
    require("luci.template")
    
    -- 尝试渲染 404 模板
    local ok = luci.util.copcall(luci.template.render, "error404")
    if not ok then
        luci.http.prepare_content("text/plain")
        luci.http.write(message)
    end
    
    return false
end

-- 显示 500 错误页面
-- @param message string - 错误消息
-- @return boolean - 始终返回 false
function error500(message)
    local XQLog = require("xiaoqiang.XQLog")
    XQLog.log(3, "Internal Server Error", message)
    
    message = "Internal Server Error"
    
    -- 检查是否已发送模板头
    if not context.template_header_sent then
        luci.http.status(500, "Internal Server Error")
        luci.http.prepare_content("text/plain")
        luci.http.write(message)
    else
        require("luci.template")
        local ok = luci.util.copcall(luci.template.render, "error500", { message = message })
        if not ok then
            luci.http.prepare_content("text/plain")
            luci.http.write(message)
        end
    end
    
    return false
end

-- 显示自定义错误页面
-- @param code number - HTTP 状态码
-- @param message string - 错误消息
-- @return boolean - 始终返回 false
function errorpage(code, message)
    if tonumber(code) then
        luci.http.status(tonumber(code), "Not Found")
        require("luci.template")
        
        local ok = luci.util.copcall(luci.template.render, "error404")
        if not ok then
            luci.http.prepare_content("text/plain")
            luci.http.write(message)
        end
        return false
    end
end

-- 授权函数（占位符）
function empower(a, b, c)
end

-- ============================================================================
-- 远程客户端信息获取函数
-- ============================================================================

-- 获取远程客户端的 MAC 地址
-- @param useExtended boolean - 是否使用扩展方法
-- @return string - MAC 地址
function getremotemac(useExtended)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    -- 获取客户端 IP 地址
    local ip = luci.http.getenv("HTTP_X_FORWARDED_FOR")
    if XQFunction.isStrNil(ip) then
        ip = luci.http.getenv("REMOTE_ADDR") or ""
    end
    
    -- 根据 IP 获取 MAC 地址
    local mac
    if useExtended then
        mac = luci.sys.net.ip4mac_ex(ip) or ""
    else
        mac = luci.sys.net.ip4mac(ip) or ""
    end
    
    return XQFunction.macFormat(mac)
end

-- 登录认证失败处理
-- 发送推送通知
function loginAuthenFailed()
    local XQPushHelper = require("xiaoqiang.XQPushHelper")
    local pushData = {
        type = 16,
        data = {
            mac = getremotemac()
        }
    }
    XQPushHelper.push_request_lua(pushData)
end

-- ============================================================================
-- 认证器实现
-- ============================================================================

-- JSON 认证器
-- 用于 API 接口的认证
-- @param validator - 验证器
-- @param accs table - 允许的用户列表
-- @param default string - 默认用户
-- @return string, string - 用户名和登录类型，或 false
authenticator.jsonauth = function(validator, accs, default)
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    -- 获取表单参数
    local username = luci.http.xqformvalue("username") or ""
    local password = luci.http.xqformvalue("password")
    local nonce = luci.http.xqformvalue("nonce")
    
    if nonce then
        -- 使用 nonce 方式认证
        if XQSecureUtil.checkNonce(nonce, getremotemac()) then
            if XQSecureUtil.checkUser(username, nonce, password) then
                empower("1", "1", nil)
                local loginType = "2"
                luci.http.header("Set-Cookie", "psp=" .. username .. "|||" .. loginType .. "|||0;path=/;")
                return username, loginType
            else
                loginAuthenFailed()
            end
        else
            -- nonce 无效
            context.path = {}
            luci.http.write('{"code":1582,"msg":"Invalid nonce"}')
            return false
        end
    else
        -- 使用明文密码认证
        if XQSecureUtil.checkPlaintextPwd(username, password) then
            empower("1", "1", nil)
            local loginType = "2"
            luci.http.header("Set-Cookie", "psp=" .. username .. "|||" .. loginType .. "|||0;path=/;")
            return username, loginType
        else
            context.path = {}
            luci.http.write('{"code":401,"msg":"Invalid token"}')
            return false
        end
    end
    
    -- 认证失败
    context.path = {}
    luci.http.write('{"code":401,"msg":"not auth"}')
    return false
end

-- HTML 认证器
-- 用于 Web 页面的认证，支持重定向
-- @param validator - 验证器
-- @param accs table - 允许的用户列表
-- @param default string - 默认用户
-- @return string, string - 用户名和登录类型，或 false
authenticator.htmlauth = function(validator, accs, default)
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    -- 获取重定向密钥
    local redirectKey = luci.http.xqformvalue("redirectKey")
    local bindInfo = XQSysUtil.getPassportBindInfo()
    
    if redirectKey then
        local keyType = XQSecureUtil.checkRedirectKey(redirectKey)
        if keyType then
            if keyType == "1" and bindInfo then
                -- 小米账号绑定认证
                local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
                local uuid = XQSysUtil.getBindUUID()
                local passport = XQDBUtil.fetchPassport(uuid)
                passport = passport[1]
                
                if passport then
                    luci.http.header("Set-Cookie", "psp=" .. uuid .. "|||1|||" .. passport.token .. ";path=/;")
                    return default, keyType
                end
            elseif keyType == "2" then
                -- 本地管理员认证
                luci.http.header("Set-Cookie", "psp=admin|||2|||0;path=/;")
                return "admin", keyType
            end
        end
    end
    
    -- 显示登录页面
    require("luci.i18n")
    require("luci.template")
    context.path = {}
    luci.template.render("web/sysauth", { duser = default, fuser = user })
    return false
end

-- 移动端 HTML 认证器
-- @param validator - 验证器
-- @param accs table - 允许的用户列表
-- @param default string - 默认用户
-- @return string, string - 用户名和登录类型，或 false
authenticator.htmlauth_moblie = function(validator, accs, default)
    local username = luci.http.xqformvalue("username")
    local password = luci.http.xqformvalue("password")
    local nonce = luci.http.xqformvalue("nonce")
    
    if nonce then
        if XQSecureUtil.checkNonce(nonce, getremotemac()) then
            if XQSecureUtil.checkUser(username, nonce, password) then
                empower("1", "1", nil)
                return username, "2"
            end
        end
    end
    
    loginAuthenFailed()
    
    -- 显示移动端登录页面
    require("luci.i18n")
    require("luci.template")
    context.path = {}
    luci.template.render("mobile/sysauth", { duser = default, fuser = username })
    return false
end

-- ============================================================================
-- 系统锁定检查函数
-- ============================================================================

-- 检查是否显示系统锁定页面
-- @param authType string - 认证类型
-- @return boolean - 是否被锁定
function check_show_syslock(authType)
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local requestUri = luci.http.getenv("REQUEST_URI")
    
    local lockStatus = XQFunction.sysLockStatus()
    
    if lockStatus == 1 then
        -- 检查是否正在升级
        if XQSysUtil.isUpgrading() then
            require("luci.i18n")
            require("luci.template")
            
            if type(authType) == "string" and authType == "htmlauth" then
                -- HTML 认证：重定向到升级页面
                context.path = {}
                luci.http.redirect(luci.dispatcher.build_url("web", "upgrading"))
            elseif type(authType) == "string" and authType == "jsonauth" then
                -- JSON 认证：返回锁定错误
                context.path = {}
                luci.http.write('{"code":403,"msg":"system locked"}')
            else
                XQFunction.sysUnlock()
                return false
            end
            return true
        else
            -- 检查是否是服务 API 或第三方 API
            if not requestUri:match("/api/service/") and not requestUri:match("/api%-third%-party/") then
                XQFunction.sysUnlock()
            end
        end
    end
    
    return false
end

-- HTTP 请求日志记录
-- @param request - HTTP 请求对象
-- @param authType string - 认证类型
function http_request_log(request, authType)
    local XQLog = require("xiaoqiang.XQLog")
    local uri = request:getenv("REQUEST_URI")
    
    if uri and authType then
        if type(authType) == "string" then
            local parts = luci.util.split(uri, "?")
            XQLog.log(6, authType .. ":" .. parts[1])
            if parts[2] then
                XQLog.log(7, parts[2])
            end
        end
    end
end

-- ============================================================================
-- 权限标志检查函数
-- ============================================================================

-- 检查是否允许无认证访问
-- @param flag number - 权限标志
-- @return boolean
function _noauthAccessAllowed(flag)
    if flag == nil then
        return false
    end
    return bit.band(flag, 1) == 1
end

-- 检查是否禁止远程访问
-- @param flag number - 权限标志
-- @return boolean
function _remoteAccessForbidden(flag)
    if flag == nil then
        return false
    end
    return bit.band(flag, 2) == 2
end

-- 检查是否允许系统锁定时访问
-- @param flag number - 权限标志
-- @return boolean
function _syslockAccessAllowed(flag)
    if flag == nil then
        return false
    end
    return bit.band(flag, 4) == 4
end

-- 检查是否允许未初始化时访问
-- @param flag number - 权限标志
-- @return boolean
function _noinitAccessAllowed(flag)
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    
    -- 如果已初始化，允许访问
    if XQSysUtil.getInitInfo() then
        return true
    end
    
    if flag == nil then
        return false
    end
    return bit.band(flag, 8) == 8
end

-- 检查是否需要 SDK 过滤
-- @param flag number - 权限标志
-- @return boolean
function _sdkFilter(flag)
    if flag == nil then
        return false
    end
    return bit.band(flag, 16) == 16
end

-- 检查 Web 访问是否允许
-- @param authType string - 认证类型
-- @param flag number - 权限标志
-- @return boolean
function _webAccessAllowed(authType, flag)
    if not authType then
        return true
    end
    
    if authType == "htmlauth" then
        if not _noauthAccessAllowed(flag) then
            local XQFunction = require("xiaoqiang.common.XQFunction")
            local mac = getremotemac()
            local uci = require("luci.model.uci").cursor()
            
            -- 检查 Web 过滤是否启用
            local webFilterEnabled = tonumber(uci:get("webfilter", "admin", "enable") or 0)
            
            if webFilterEnabled == 1 then
                if not XQFunction.isStrNil(mac) then
                    local allowed = false
                    
                    -- 检查白名单
                    uci:foreach("webfilter", "adminwhite", function(section)
                        if section[".type"] == "adminwhite" then
                            local whiteMac = string.gsub(section[".name"], "_", ":")
                            if whiteMac and string.lower(mac) == whiteMac then
                                allowed = true
                            end
                        end
                    end)
                    
                    return allowed
                end
            end
        end
    end
    
    return true
end

-- ============================================================================
-- HTTP 请求分发函数
-- ============================================================================

-- HTTP 请求分发入口
-- @param request - HTTP 请求对象
-- @param prefix - URL 前缀
function httpdispatch(request, prefix)
    local uri = http.urldecode(request:getenv("REQUEST_URI") or "")
    
    -- 记录请求日志（排除 mipctl）
    if uri ~= "/mipctl" then
        http_request_log(request, "finished")
    end
    
    -- 设置全局翻译函数
    _G._ = i18n.translate
    _G.translate = i18n.translate
    
    -- 设置 HTTP 上下文
    luci.http.context.request = request
    
    -- 解析请求路径
    local pathInfo = {}
    context.request = pathInfo
    context.urltoken = {}
    
    -- 处理前缀
    if prefix then
        for _, component in ipairs(prefix) do
            pathInfo[#pathInfo + 1] = component
        end
    end
    
    -- 解析 URL 路径和令牌
    for segment in uri:gmatch("[^/]+") do
        local tokenKey, tokenValue
        if segment then
            tokenKey, tokenValue = segment:match(";(%w+)=([a-fA-F0-9]*)")
        end
        
        if tokenKey then
            context.urltoken[tokenKey] = tokenValue
        else
            pathInfo[#pathInfo + 1] = segment
        end
    end
    
    -- 调用调度函数
    dispatch(pathInfo)
    
    -- 记录完成日志
    if uri ~= "/mipctl" then
        http_request_log(request, "finished")
    end
end

-- ============================================================================
-- 核心调度函数
-- ============================================================================

-- 调度请求到对应的处理器
-- @param path table - 请求路径组件
function dispatch(path)
    context.path = path
    
    -- 加载配置
    local config = require("luci.config")
    assert(config.main, "/etc/config/luci seems to be corrupt, unable to find section 'main'")
    
    -- 设置语言
    local lang = config.main.lang or "auto"
    require("luci.i18n").setlanguage(lang)
    
    -- 获取或创建路由树
    local tree = context.tree
    if not tree then
        tree = createtree()
    end
    
    -- 收集节点配置
    local nodeConfig = {}
    local args = {}
    context.args = args
    context.requestargs = context.requestargs or args
    
    -- 遍历路径查找目标节点
    local currentNode = tree
    local requestPath = {}
    local fullPath = {}
    
    for i, segment in ipairs(path) do
        requestPath[#requestPath + 1] = segment
        fullPath[#fullPath + 1] = segment
        
        local nextNode = currentNode.nodes and currentNode.nodes[segment]
        if not nextNode then
            break
        end
        
        -- 合并节点配置
        util.update(nodeConfig, nextNode)
        currentNode = nextNode
        
        -- 检查是否是叶子节点
        if currentNode.leaf then
            break
        end
    end
    
    -- 设置上下文
    context.requestpath = requestPath
    context.path = fullPath
    
    -- 检查节点是否存在
    if not currentNode then
        error404("Page not found")
        return
    end
    
    -- 检查初始化状态
    if not _noinitAccessAllowed(nodeConfig.flag) then
        -- 重定向到初始化向导
        return
    end
    
    -- 检查远程访问权限
    local remoteIp = luci.http.getenv("REMOTE_ADDR")
    local serverName = luci.http.getenv("SERVER_NAME")
    local isLocalAccess = (remoteIp == "127.0.0.1" or remoteIp == "::1") and serverName == "localhost"
    
    -- SDK 权限检查
    if _sdkFilter(nodeConfig.flag) and not isLocalAccess then
        local XQSDKUtil = require("xiaoqiang.util.XQSDKUtil")
        if not XQSDKUtil.checkPermission(getremotemac()) then
            context.path = {}
            luci.http.write('{"code":1500,"msg":"Permission denied"}')
            return
        end
    end
    
    -- 认证检查
    if not isLocalAccess and nodeConfig.sysauth then
        local sauth = require("luci.sauth")
        local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
        local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
        local bindInfo = XQSysUtil.getPassportBindInfo()
        
        -- 获取认证器
        local authFunc
        if type(nodeConfig.sysauth_authenticator) == "function" then
            authFunc = nodeConfig.sysauth_authenticator
        else
            authFunc = authenticator[nodeConfig.sysauth_authenticator]
        end
        
        -- 获取允许的用户列表
        local allowedUsers
        if type(nodeConfig.sysauth) == "string" then
            allowedUsers = { nodeConfig.sysauth }
        else
            allowedUsers = nodeConfig.sysauth
        end
        
        -- 检查会话
        local sessionToken = context.urltoken.stok
        local session = sauth.read(sessionToken)
        local authUser = nil
        
        if session then
            if context.urltoken.stok == session.token then
                if session.ip and session.ip == remoteIp then
                    authUser = session.user
                end
            end
        else
            -- 检查 HTTP 基本认证
            local httpUser = sys.getenv("HTTP_AUTH_USER")
            local httpPass = sys.getenv("HTTP_AUTH_PASS")
            
            if httpUser and httpPass then
                if luci.sys.user.checkpasswd(httpUser, httpPass) then
                    local XQLog = require("xiaoqiang.XQLog")
                    XQLog.log(4, "Native Luci: HTTP_AUTH_USER & HTTP_AUTH_PASS")
                end
            end
        end
        
        -- 验证用户
        if not util.contains(allowedUsers, authUser) then
            if authFunc then
                context.urltoken.stok = nil
                local user, loginType = authFunc(nil, allowedUsers, allowedUsers[1])
                
                if user and util.contains(allowedUsers, user) then
                    -- 认证成功，创建会话
                    local newToken = sessionToken or luci.sys.uniqueid(16)
                    loginType = loginType or "2"
                    local secret = luci.sys.uniqueid(16)
                    
                    sauth.reap()
                    sauth.write(newToken, {
                        user = user,
                        token = newToken,
                        ltype = loginType,
                        ip = remoteIp,
                        secret = secret
                    })
                    
                    context.urltoken.stok = newToken
                    context.authsession = newToken
                    context.authuser = user
                else
                    return
                end
            else
                luci.http.status(403, "Forbidden")
                return
            end
        else
            context.authsession = sessionToken
            context.authuser = authUser
        end
    end
    
    -- 设置用户和组
    if nodeConfig.setgroup then
        nixio.setgid(nodeConfig.setgroup)
    end
    if nodeConfig.setuser then
        nixio.setuid(nodeConfig.setuser)
    end
    
    -- 执行目标处理器
    context.dispatched = currentNode
    context.requested = context.requested or currentNode
    
    -- 检查是否是索引页
    if currentNode.index then
        require("luci.template")
        local ok = util.copcall(luci.template.render, "indexer", {})
        if ok then
            return true
        end
    end
    
    -- 执行目标函数
    local target = currentNode.target
    if type(target) == "function" then
        -- 设置执行环境
        util.copcall(function()
            local env = getfenv(target)
            local module = require(currentNode.module)
            local newEnv = setmetatable({}, {
                __index = function(t, k)
                    return rawget(t, k) or env[k] or module[k]
                end
            })
            setfenv(target, newEnv)
        end)
        
        -- 调用目标函数
        local ok, err
        if type(currentNode.target) == "table" then
            ok, err = util.copcall(target, currentNode.target, unpack(args))
        else
            ok, err = util.copcall(target, unpack(args))
        end
        
        assert(ok, "Failed to execute dispatcher target: " .. tostring(err or "(unknown)"))
    else
        -- 没有找到目标处理器
        local rootNode = node()
        if rootNode and rootNode.target then
            error404("No page is registered at '/" .. table.concat(path, "/") .. "'.")
        else
            error404("No root node was registered.")
        end
    end
end

-- ============================================================================
-- 路由树创建函数
-- ============================================================================

-- 创建控制器索引
function createindex()
    local libPath = luci.util.libpath() .. "/controller/"
    local suffixes = { ".lua", ".lua.gz" }
    createindex_plain(libPath, suffixes)
end

-- 创建路由树
-- @return table - 路由树根节点
function createtree()
    if not _M.index then
        createindex()
    end
    
    -- 初始化路由树
    local tree = { nodes = {}, inreq = true }
    local modifiers = {}
    local treecache = setmetatable({}, { __mode = "v" })
    
    context.treecache = treecache
    context.tree = tree
    context.modifiers = modifiers
    
    -- 加载控制器模块
    local cloader = require("luci.cloader")
    cloader.loadc()
    
    -- 创建执行环境
    local env = setmetatable({}, { __index = _G })
    
    -- 执行所有控制器的 index 函数
    for moduleName, indexFunc in pairs(_M.index or {}) do
        env._NAME = moduleName
        setfenv(indexFunc, env)
        indexFunc()
    end
    
    -- 执行修改器
    for _, modifier in ipairs(modifiers) do
        env._NAME = modifier.module
        setfenv(modifier.func, env)
        modifier.func()
    end
    
    return tree
end

-- ============================================================================
-- 路由节点操作函数
-- ============================================================================

-- 注册修改器
-- @param func function - 修改器函数
-- @param order number - 执行顺序
function modifier(func, order)
    local modifiers = context.modifiers
    modifiers[#modifiers + 1] = {
        func = func,
        order = order or 0,
        module = getfenv(2)._NAME
    }
end

-- 分配路由别名
-- @param path table - 路径
-- @param target table - 目标路径
-- @param title string - 标题
-- @param order number - 排序
-- @param flag number - 权限标志
-- @return table - 节点
function assign(path, target, title, order, flag)
    local n = node(unpack(path))
    n.nodes = nil
    n.module = nil
    n.title = title
    n.order = order
    n.flag = flag
    
    setmetatable(n, { __index = _create_node(target) })
    return n
end

-- 注册路由入口
-- @param path table - 路径
-- @param target table|function - 目标处理器
-- @param title string - 标题
-- @param order number - 排序
-- @param flag number - 权限标志
-- @return table - 节点
function entry(path, target, title, order, flag)
    local n = node(unpack(path))
    n.target = target
    n.title = title
    n.order = order
    n.flag = flag
    n.module = getfenv(2)._NAME
    return n
end

-- 获取路由节点
-- @param ... - 路径组件
-- @return table - 节点
function get(...)
    return _create_node({...})
end

-- 获取或创建路由节点
-- @param ... - 路径组件
-- @return table - 节点
function node(...)
    local n = _create_node({...})
    n.module = getfenv(2)._NAME
    n.auto = nil
    return n
end

-- 创建节点（内部函数）
-- @param path table - 路径
-- @return table - 节点
function _create_node(path)
    if #path == 0 then
        return context.tree
    end
    
    local key = table.concat(path, ".")
    local cached = context.treecache[key]
    
    if not cached then
        local name = table.remove(path)
        local parent = _create_node(path)
        
        local newNode = {
            nodes = {},
            auto = true
        }
        
        -- 检查是否在请求路径中
        if parent.inreq then
            local nextPath = context.path[#path + 1]
            if nextPath == name then
                newNode.inreq = true
            end
        end
        
        parent.nodes[name] = newNode
        context.treecache[key] = newNode
        cached = newNode
    end
    
    return cached
end

-- ============================================================================
-- 目标处理器工厂函数
-- ============================================================================

-- 跳转到第一个子节点（内部函数）
function _firstchild()
    local path = { unpack(context.path) }
    local key = table.concat(path, ".")
    local node = context.treecache[key]
    
    local firstChild = nil
    
    if node and node.nodes and next(node.nodes) then
        for name, child in pairs(node.nodes) do
            if firstChild then
                local childOrder = child.order or 0
                local firstOrder = node.nodes[firstChild].order or 0
                if childOrder < firstOrder then
                    firstChild = name
                end
            else
                firstChild = name
            end
        end
    end
    
    assert(firstChild ~= nil, "No child node found")
    
    path[#path + 1] = firstChild
    dispatch(path)
end

-- 创建第一个子节点目标
-- @return table - 目标对象
function firstchild()
    return {
        type = "firstchild",
        target = _firstchild
    }
end

-- 创建别名目标
-- @param ... - 目标路径
-- @return function - 目标函数
function alias(...)
    local targetPath = {...}
    
    return function(...)
        local args = {...}
        for _, arg in ipairs(args) do
            targetPath[#targetPath + 1] = arg
        end
        dispatch(targetPath)
    end
end

-- 创建重写目标
-- @param n number - 要移除的路径组件数量
-- @param ... - 新路径组件
-- @return function - 目标函数
function rewrite(n, ...)
    local newPath = {...}
    
    return function(...)
        local path = util.clone(context.path)
        
        -- 移除指定数量的组件
        for i = 1, n do
            table.remove(path, 1)
        end
        
        -- 插入新组件
        for i, component in ipairs(newPath) do
            table.insert(path, i, component)
        end
        
        -- 添加额外参数
        local args = {...}
        for _, arg in ipairs(args) do
            path[#path + 1] = arg
        end
        
        dispatch(path)
    end
end

-- 调用函数目标（内部函数）
local function _call(target, ...)
    local env = getfenv()
    local func = env[target.name]
    
    assert(func ~= nil, 'Cannot resolve function "' .. target.name .. '". Is it misspelled or local?')
    assert(type(func) == "function", 'The symbol "' .. target.name .. '" does not refer to a function.')
    
    if #target.argv > 0 then
        return func(unpack(target.argv), ...)
    else
        return func(...)
    end
end

-- 创建函数调用目标
-- @param name string - 函数名
-- @param ... - 函数参数
-- @return table - 目标对象
function call(name, ...)
    return {
        type = "call",
        argv = {...},
        name = name,
        target = _call
    }
end

-- 模板渲染目标（内部函数）
local function _template(target, ...)
    local template = require("luci.template")
    template.render(target.view)
end

-- 创建模板渲染目标
-- @param view string - 模板名称
-- @return table - 目标对象
function template(view)
    return {
        type = "template",
        view = view,
        target = _template
    }
end

-- 组合目标（内部函数）
local function _arcombine(target, ...)
    local args = {...}
    local selectedTarget
    
    if #args > 0 and target.targets[2] then
        selectedTarget = target.targets[2]
    else
        selectedTarget = target.targets[1]
    end
    
    setfenv(selectedTarget.target, target.env)
    selectedTarget.target(selectedTarget, unpack(args))
end

-- 创建组合目标
-- @param target1 table - 无参数时的目标
-- @param target2 table - 有参数时的目标
-- @return table - 目标对象
function arcombine(target1, target2)
    return {
        type = "arcombine",
        env = getfenv(),
        target = _arcombine,
        targets = { target1, target2 }
    }
end

-- ============================================================================
-- 国际化辅助函数
-- ============================================================================

-- 翻译函数别名
translate = i18n.translate

-- 翻译函数简写
function _(text)
    return translate(text)
end
