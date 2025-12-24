--[[
================================================================================
Lua-cURL 实现模块 (Lua-cURL Implementation Module)
================================================================================

功能说明：
  本模块是 Lua-cURL 库的核心实现，提供了对 libcurl 的高级封装。
  它实现了三种主要的 cURL 对象类型：
  
  1. Easy  - 单个 HTTP 请求处理
  2. Multi - 多个并发请求处理
  3. Form  - HTTP 表单数据构建
  4. Share - 多个 Easy 之间共享数据

版本信息：
  - 库名称: Lua-cURL
  - 版本: 0.3.13
  - 许可证: MIT
  - 版权: Copyright (c) 2014-2021 Alexey Melnichuk

主要功能：
  - HTTP/HTTPS 请求（GET、POST、PUT 等）
  - 文件上传/下载
  - 表单数据提交
  - Cookie 管理
  - 代理支持
  - 多路复用并发请求
  - SSL/TLS 安全连接

================================================================================
--]]

-- 模块元信息
local moduleInfo = {}
moduleInfo._NAME = "Lua-cURL"
moduleInfo._VERSION = "0.3.13"
moduleInfo._LICENSE = "MIT"
moduleInfo._COPYRIGHT = "Copyright (c) 2014-2021 Alexey Melnichuk"

--[[
================================================================================
                              辅助函数
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: extractPointer(str)
--------------------------------------------------------------------------------
功能: 从字符串中提取指针地址

参数:
  str - 包含指针信息的字符串

返回值:
  string - 提取的指针地址（十六进制）

说明:
  用于从 tostring() 结果中提取对象的内存地址，
  支持两种格式：
  - "xxx (0x12345678)" - 括号内的地址
  - "xxx: 12345678"    - 冒号后的地址
--------------------------------------------------------------------------------
--]]
local function extractPointer(str)
    local pointer = string.match(str, "%((.-)%)")
    if not pointer then
        pointer = string.match(str, ": (%x+)$")
    end
    return pointer
end

--[[
--------------------------------------------------------------------------------
函数: copyTable(source, dest)
--------------------------------------------------------------------------------
功能: 复制表内容

参数:
  source - 源表
  dest   - 目标表（可选，默认创建新表）

返回值:
  table - 包含源表内容的目标表
--------------------------------------------------------------------------------
--]]
local function copyTable(source, dest)
    dest = dest or {}
    for key, value in pairs(source) do
        dest[key] = value
    end
    return dest
end

--[[
--------------------------------------------------------------------------------
函数: createMethodWrapper(methodName)
--------------------------------------------------------------------------------
功能: 创建方法包装器

参数:
  methodName - 要包装的方法名称

返回值:
  function - 包装后的方法函数

说明:
  包装底层 handle 的方法，使其返回包装对象而非底层 handle。
  如果方法返回底层 handle 本身，则返回包装对象；
  否则返回原始返回值。
--------------------------------------------------------------------------------
--]]
local function createMethodWrapper(methodName)
    local function wrapper(self, ...)
        local handle = self._handle
        local method = handle[methodName]
        local result, err = method(handle, ...)
        
        if result == self._handle then
            return self
        end
        return result, err
    end
    return wrapper
end

--[[
--------------------------------------------------------------------------------
函数: createSetoptWrapper(optionName, valueMap)
--------------------------------------------------------------------------------
功能: 创建 setopt 方法的包装器

参数:
  optionName - 选项名称（如 "proxytype"）
  valueMap   - 值映射表（将字符串映射到常量）

返回值:
  function - 包装后的 setopt 方法

说明:
  用于创建支持字符串参数的 setopt 方法。
  例如：setopt_proxytype("HTTP") 会被转换为对应的常量值。
--------------------------------------------------------------------------------
--]]
local function createSetoptWrapper(optionName, valueMap)
    local methodName = "setopt_" .. optionName
    local baseWrapper = createMethodWrapper(methodName)
    
    local function wrapper(self, value)
        if type(value) == "string" then
            value = valueMap[value]
        end
        return baseWrapper(self, value)
    end
    return wrapper
end

--[[
================================================================================
                           响应缓冲区管理
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: createResponseBuffer()
--------------------------------------------------------------------------------
功能: 创建响应数据缓冲区

返回值:
  table - 响应缓冲区对象

说明:
  用于在 Multi 模式下收集多个 Easy 请求的响应数据。
  缓冲区按 Easy handle 分组存储数据。

缓冲区结构：
  - resp: 记录每个 handle 的最新响应码
  - _: 存储每个 handle 的数据队列
  - append: 添加数据的方法
  - next: 获取下一条数据的方法
--------------------------------------------------------------------------------
--]]
local function createResponseBuffer()
    local buffer = {}
    buffer.resp = {}  -- 响应码缓存
    buffer._ = {}     -- 数据存储
    
    --[[
    函数: buffer.append(handle, dataType, data)
    功能: 向缓冲区添加数据
    参数:
      handle   - Easy handle
      dataType - 数据类型（"data"、"header"、"done"、"error"、"response"）
      data     - 数据内容
    --]]
    function buffer.append(self, handle, dataType, data)
        local responseCode = assert(handle:getinfo_response_code())
        
        if not self._[handle] then
            self._[handle] = {}
        end
        
        local handleData = self._[handle]
        local lastResponse = self.resp[handle]
        
        if lastResponse ~= responseCode then
            handleData[#handleData + 1] = { "response", responseCode }
            self.resp[handle] = responseCode
        end
        
        handleData[#handleData + 1] = { dataType, data }
    end
    
    --[[
    函数: buffer.next()
    功能: 获取缓冲区中的下一条数据
    返回值:
      handle, dataEntry - Easy handle 和数据条目
    --]]
    function buffer.next(self)
        for handle, dataQueue in pairs(self._) do
            local entry = table.remove(dataQueue, 1)
            if entry then
                return handle, entry
            end
        end
    end
    
    return buffer
end

--[[
================================================================================
                           Multi 迭代器
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: createMultiIterator(multi, performFunc)
--------------------------------------------------------------------------------
功能: 创建 Multi 请求的迭代器

参数:
  multi       - Multi 对象
  performFunc - perform 方法

返回值:
  function - 迭代器函数

说明:
  用于迭代处理 Multi 中所有 Easy 请求的响应。
  迭代器会自动处理：
  - 设置 write/header 回调
  - 执行请求
  - 收集响应数据
  - 处理完成和错误状态
--------------------------------------------------------------------------------
--]]
local function createMultiIterator(multi, performFunc)
    local lcurl_safe = require("lcurl.safe")
    local responseBuffer = createResponseBuffer()
    
    local function setupCallbacks(easyHandles)
        local count = easyHandles.n or 0
        if count == 0 then
            return 0
        end
        
        for _, easy in pairs(easyHandles) do
            if _ ~= "n" then
                easy:setopt_writefunction(function(data)
                    responseBuffer:append(easy, "data", data)
                end)
                
                easy:setopt_headerfunction(function(header)
                    responseBuffer:append(easy, "header", header)
                end)
            end
        end
        
        multi._easy_mark = true
        return count
    end
    
    local handleCount = setupCallbacks(multi._easy)
    if handleCount == 0 then
        return nil
    end
    
    assert(performFunc(multi))
    
    local function iterator()
        local runningCount = performFunc(multi)
        
        while true do
            local handle, entry = responseBuffer:next()
            if entry then
                local data = entry[2]
                local dataType = entry[1]
                return data, dataType, handle
            end
            
            if runningCount == 0 then
                break
            end
            
            multi:wait()
            runningCount = assert(performFunc(multi))
            
            if runningCount <= runningCount then
                while true do
                    local easy, ok, err = assert(multi:info_read())
                    
                    if easy == 0 then
                        break
                    end
                    
                    if ok then
                        local responseCode = easy:getinfo_response_code()
                        ok = responseCode or ok
                        responseBuffer:append(easy, "done", ok)
                    else
                        responseBuffer:append(easy, "error", err)
                    end
                    
                    multi:remove_handle(easy)
                    easy:unsetopt_headerfunction()
                    easy:unsetopt_writefunction()
                end
            end
        end
    end
    
    return iterator
end

--[[
================================================================================
                           表单数据处理
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: addFormField(form, name, value)
--------------------------------------------------------------------------------
功能: 向表单添加字段

参数:
  form  - Form 对象
  name  - 字段名称
  value - 字段值（字符串或表）

返回值:
  form 对象或 nil, error

说明:
  支持多种字段类型：
  - 字符串值：直接添加
  - stream：流式数据（需要 length）
  - file：文件上传
  - data：内存数据
  - 数组第一个元素：内容数据
--------------------------------------------------------------------------------
--]]
local function addFormField(form, name, value)
    local valueType = type(value)
    
    if valueType == "string" then
        return form:add_content(name, value)
    end
    
    assert(type(name) == "string")
    assert(valueType == "table")
    assert(value.name == nil)
    assert(value.type == nil)
    assert(value.headers == nil)
    
    if value.stream then
        local streamType = type(value.stream)
        
        if streamType == "function" then
            assert(type(value.length) == "number")
            return form:add_stream(
                name,
                value.name,
                value.type,
                value.headers,
                value.length,
                value.stream
            )
        end
        
        if streamType == "table" or streamType == "userdata" then
            local length = value.length
            if not length then
                length = assert(value.stream:length())
            end
            assert(type(length) == "number")
            return form:add_stream(
                name,
                value.name,
                value.type,
                value.headers,
                length,
                value.stream
            )
        end
        
        error("Unsupported stream type: " .. streamType)
    end
    
    if value.file then
        assert(type(value.file) == "string")
        return form:add_file(
            name,
            value.file,
            value.type,
            value.filename,
            value.headers
        )
    end
    
    if value.data then
        assert(type(value.data) == "string")
        assert(type(value.name) == "string")
        return form:add_buffer(
            name,
            value.name,
            value.data,
            value.type,
            value.headers
        )
    end
    
    local content = value[1]
    if content then
        assert(type(content) == "string")
        if value.type then
            return form:add_content(name, content, value.type, value.headers)
        end
        return form:add_content(name, content, value.headers)
    end
    
    return form
end

--[[
--------------------------------------------------------------------------------
函数: addFormFields(form, fields)
--------------------------------------------------------------------------------
功能: 批量添加表单字段

参数:
  form   - Form 对象
  fields - 字段表

返回值:
  form 对象或 nil, error
--------------------------------------------------------------------------------
--]]
local function addFormFields(form, fields)
    for name, value in pairs(fields) do
        local ok, err = addFormField(form, name, value)
        if not ok then
            return nil, err
        end
    end
    return form
end

--[[
================================================================================
                           类工厂函数
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: createClass(constructor, typeName)
--------------------------------------------------------------------------------
功能: 创建包装类

参数:
  constructor - 底层对象构造函数
  typeName    - 类型名称

返回值:
  table - 类定义表

说明:
  创建一个包装类，用于封装底层 lcurl 对象。
  包装类提供：
  - new() 构造函数
  - handle() 获取底层 handle
  - __index 元方法自动代理底层方法
--------------------------------------------------------------------------------
--]]
local function createClass(constructor, typeName)
    local class = {}
    class.__type = typeName or "LcURL Unknown"
    
    function class.__index(self, key)
        local method = class[key]
        if not method then
            local handleMethod = self._handle[key]
            if handleMethod then
                method = createMethodWrapper(key)
                class[key] = method
            end
        end
        return method
    end
    
    function class.new(cls, ...)
        local handle, err = constructor()
        if not handle then
            return nil, err
        end
        
        local instance = setmetatable({ _handle = handle }, cls)
        
        if cls.__init then
            return cls.__init(instance, ...)
        end
        return instance
    end
    
    function class.handle(self)
        return self._handle
    end
    
    return class
end

--[[
================================================================================
                           Easy 类扩展
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: initEasyClass(cURL, lcurl)
--------------------------------------------------------------------------------
功能: 初始化 Easy 类

参数:
  cURL  - cURL 模块表
  lcurl - 底层 lcurl 库

说明:
  为 Easy 类添加以下功能：
  - perform: 执行请求
  - post: POST 表单数据
  - setopt_share: 设置共享对象
  - setopt_proxytype: 设置代理类型
  - setopt_httpauth: 设置 HTTP 认证
  - setopt_ssh_auth_types: 设置 SSH 认证类型
--------------------------------------------------------------------------------
--]]
local function initEasyClass(cURL, lcurl)
    local Easy = createClass(lcurl.easy, "LcURL Easy")
    
    local basePerform = createMethodWrapper("perform")
    local baseSetoptShare = createMethodWrapper("setopt_share")
    local baseSetoptReadfunction = createMethodWrapper("setopt_readfunction")
    
    local easyMethods = {}
    
    local READFUNCTION_MARKER = {}
    
    function easyMethods._call_readfunction(self, ...)
        if self._rd_ud == READFUNCTION_MARKER then
            return self._rd_fn(...)
        end
        return self._rd_fn(self._rd_ud, ...)
    end
    
    function easyMethods.setopt_readfunction(self, func, ...)
        assert(func)
        
        local argCount = select("#", ...)
        if argCount == 0 then
            if type(func) == "function" then
                self._rd_fn = func
                self._rd_ud = READFUNCTION_MARKER
            else
                self._rd_fn = assert(func.read)
                self._rd_ud = func
            end
        else
            self._rd_fn = func
            self._ud_fn = (...)
        end
        
        return baseSetoptReadfunction(self, func, ...)
    end
    
    function easyMethods.perform(self, options)
        if not options then
            options = {}
        end
        
        local errorHandler = options.errorfunction
        
        if options.readfunction then
            local ok, err = self:setopt_readfunction(options.readfunction)
            if not ok then
                return errorHandler(err)
            end
        end
        
        if options.writefunction then
            local ok, err = self:setopt_writefunction(options.writefunction)
            if not ok then
                return errorHandler(err)
            end
        end
        
        if options.headerfunction then
            local ok, err = self:setopt_headerfunction(options.headerfunction)
            if not ok then
                return errorHandler(err)
            end
        end
        
        local ok, err = basePerform(self)
        if not ok then
            return errorHandler(err)
        end
        
        return self
    end
    
    function easyMethods.post(self, fields)
        local form = cURL.form()
        local ok = true
        local err = nil
        
        for name, value in pairs(fields) do
            if type(value) == "string" then
                ok, err = form:add_content(name, value)
            else
                assert(type(value) == "table")
                
                if value.stream_length then
                    local length = assert(tonumber(value.stream_length))
                    assert(value.file)
                    
                    if value.stream then
                        ok, err = form:add_stream(
                            name,
                            value.file,
                            value.type,
                            value.headers,
                            length,
                            value.stream
                        )
                    else
                        ok, err = form:add_stream(
                            name,
                            value.file,
                            value.type,
                            value.headers,
                            length,
                            self._call_readfunction,
                            self
                        )
                    end
                elseif value.data then
                    ok, err = form:add_buffer(
                        name,
                        value.file,
                        value.data,
                        value.type,
                        value.headers
                    )
                else
                    ok, err = form:add_file(
                        name,
                        value.file,
                        value.type,
                        value.filename,
                        value.headers
                    )
                end
            end
            
            if not ok then
                break
            end
        end
        
        if not ok then
            return nil, err
        end
        
        return self
    end
    
    function easyMethods.setopt_share(self, share)
        return baseSetoptShare(self, share:handle())
    end
    
    easyMethods.setopt_proxytype = createSetoptWrapper("proxytype", {
        HTTP = lcurl.PROXY_HTTP,
        HTTP_1_0 = lcurl.PROXY_HTTP_1_0,
        SOCKS4 = lcurl.PROXY_SOCKS4,
        SOCKS5 = lcurl.PROXY_SOCKS5,
        SOCKS4A = lcurl.PROXY_SOCKS4A,
        SOCKS5_HOSTNAME = lcurl.PROXY_SOCKS5_HOSTNAME,
        HTTPS = lcurl.PROXY_HTTPS
    })
    
    easyMethods.setopt_httpauth = createSetoptWrapper("httpauth", {
        NONE = lcurl.AUTH_NONE,
        BASIC = lcurl.AUTH_BASIC,
        DIGEST = lcurl.AUTH_DIGEST,
        GSSNEGOTIATE = lcurl.AUTH_GSSNEGOTIATE,
        NEGOTIATE = lcurl.AUTH_NEGOTIATE,
        NTLM = lcurl.AUTH_NTLM,
        DIGEST_IE = lcurl.AUTH_DIGEST_IE,
        GSSAPI = lcurl.AUTH_GSSAPI,
        NTLM_WB = lcurl.AUTH_NTLM_WB,
        ONLY = lcurl.AUTH_ONLY,
        ANY = lcurl.AUTH_ANY,
        ANYSAFE = lcurl.AUTH_ANYSAFE,
        BEARER = lcurl.AUTH_BEARER
    })
    
    easyMethods.setopt_ssh_auth_types = createSetoptWrapper("ssh_auth_types", {
        NONE = lcurl.SSH_AUTH_NONE,
        ANY = lcurl.SSH_AUTH_ANY,
        PUBLICKEY = lcurl.SSH_AUTH_PUBLICKEY,
        PASSWORD = lcurl.SSH_AUTH_PASSWORD,
        HOST = lcurl.SSH_AUTH_HOST,
        GSSAPI = lcurl.SSH_AUTH_GSSAPI,
        KEYBOARD = lcurl.SSH_AUTH_KEYBOARD,
        AGENT = lcurl.SSH_AUTH_AGENT,
        DEFAULT = lcurl.SSH_AUTH_DEFAULT
    })
    
    for name, method in pairs(easyMethods) do
        Easy[name] = method
    end
    
    return Easy
end

--[[
================================================================================
                           Multi 类扩展
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: initMultiClass(cURL, lcurl, Easy)
--------------------------------------------------------------------------------
功能: 初始化 Multi 类

参数:
  cURL  - cURL 模块表
  lcurl - 底层 lcurl 库
  Easy  - Easy 类

说明:
  为 Multi 类添加以下功能：
  - add_handle: 添加 Easy handle
  - remove_handle: 移除 Easy handle
  - perform: 执行所有请求
  - info_read: 读取完成信息
--------------------------------------------------------------------------------
--]]
local function initMultiClass(cURL, lcurl, Easy)
    local Multi = createClass(lcurl.multi, "LcURL Multi")
    
    local basePerform = createMethodWrapper("perform")
    local baseAddHandle = createMethodWrapper("add_handle")
    local baseRemoveHandle = createMethodWrapper("remove_handle")
    
    function Multi.__init(self)
        self._easy = { n = 0 }
        return self
    end
    
    function Multi.perform(self)
        return createMultiIterator(self, basePerform)
    end
    
    function Multi.add_handle(self, easy)
        assert(self._easy.n >= 0)
        
        local handle = easy:handle()
        
        if self._easy[handle] then
            return self
        end
        
        local ok, err = baseAddHandle(self, handle)
        if not ok then
            return nil, err
        end
        
        self._easy.n = self._easy.n + 1
        self._easy[handle] = easy
        self._easy_mark = nil
        
        return self
    end
    
    function Multi.remove_handle(self, easy)
        local handle = easy:handle()
        
        if self._easy[handle] then
            self._easy.n = self._easy.n - 1
            self._easy[handle] = nil
        end
        
        assert(self._easy.n >= 0)
        return baseRemoveHandle(self, handle)
    end
    
    function Multi.info_read(self, ...)
        while true do
            local handle = self:handle()
            local easy, ok, err = handle:info_read(...)
            
            if not easy then
                return nil, ok
            end
            
            if easy == 0 then
                return easy
            end
            
            local easyWrapper = self._easy[easy]
            if easyWrapper then
                if (...) then
                    self._easy.n = self._easy.n - 1
                    self._easy[easy] = nil
                end
                return easyWrapper, ok, err
            end
        end
    end
    
    return Multi
end

--[[
================================================================================
                           Share 类扩展
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: initShareClass(cURL, lcurl)
--------------------------------------------------------------------------------
功能: 初始化 Share 类

参数:
  cURL  - cURL 模块表
  lcurl - 底层 lcurl 库

说明:
  Share 类用于在多个 Easy 之间共享数据，如：
  - Cookie
  - DNS 缓存
  - SSL 会话
--------------------------------------------------------------------------------
--]]
local function initShareClass(cURL, lcurl)
    local Share = createClass(lcurl.share, "LcURL Share")
    
    Share.setopt_share = createSetoptWrapper("share", {
        COOKIE = lcurl.LOCK_DATA_COOKIE,
        DNS = lcurl.LOCK_DATA_DNS,
        SSL_SESSION = lcurl.LOCK_DATA_SSL_SESSION
    })
    
    return Share
end

--[[
================================================================================
                           初始化函数（简化版）
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: initSimpleAPI(cURL, lcurl)
--------------------------------------------------------------------------------
功能: 初始化简化 API

参数:
  cURL  - cURL 模块表
  lcurl - 底层 lcurl 库

说明:
  添加以下简化函数：
  - easy_init(): 创建 Easy 对象
  - multi_init(): 创建 Multi 对象
  - share_init(): 创建 Share 对象
--------------------------------------------------------------------------------
--]]
local function initSimpleAPI(cURL, lcurl, Easy, Multi, Share)
    assert(cURL.easy_init == nil)
    function cURL.easy_init()
        return Easy:new()
    end
    
    assert(cURL.multi_init == nil)
    function cURL.multi_init()
        return Multi:new()
    end
    
    assert(cURL.share_init == nil)
    function cURL.share_init()
        return Share:new()
    end
end

--[[
================================================================================
                           Form 类扩展
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: initFormClass(cURL, lcurl)
--------------------------------------------------------------------------------
功能: 初始化 Form 类

参数:
  cURL  - cURL 模块表
  lcurl - 底层 lcurl 库

说明:
  Form 类用于构建 HTTP 表单数据，支持：
  - 普通字段
  - 文件上传
  - 流式数据
  - 内存数据
--------------------------------------------------------------------------------
--]]
local function initFormClass(cURL, lcurl)
    local Form = createClass(lcurl.form, "LcURL Form")
    
    function Form.__init(self, fields)
        if fields then
            return self:add(fields)
        end
        return self
    end
    
    function Form.add(self, fields)
        return addFormFields(self, fields)
    end
    
    function Form.__tostring(self)
        local ptr = extractPointer(tostring(self._handle))
        return string.format("%s %s (%s)", moduleInfo._NAME, "Form", ptr)
    end
    
    return Form
end

--[[
================================================================================
                           完整 Easy 类（带 setopt）
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: initFullEasyClass(cURL, lcurl)
--------------------------------------------------------------------------------
功能: 初始化完整的 Easy 类（包含 setopt 支持）

参数:
  cURL  - cURL 模块表
  lcurl - 底层 lcurl 库

说明:
  扩展 Easy 类，添加：
  - setopt: 通用选项设置方法
  - setopt_httppost: 设置 HTTP POST 表单
  - setopt_stream_depends: 设置流依赖（HTTP/2）
--------------------------------------------------------------------------------
--]]
local function initFullEasyClass(cURL, lcurl)
    local Easy = createClass(lcurl.easy, "LcURL Easy")
    
    function Easy.__init(self, options)
        if options then
            return self:setopt(options)
        end
        return self
    end
    
    local basePerform = createMethodWrapper("perform")
    
    function Easy.perform(self, options)
        if options then
            local ok, err = self:setopt(options)
            if not ok then
                return nil, err
            end
        end
        return basePerform(self)
    end
    
    local baseSetoptHttppost = createMethodWrapper("setopt_httppost")
    
    function Easy.setopt_httppost(self, form)
        return baseSetoptHttppost(self, form:handle())
    end
    
    if lcurl.OPT_STREAM_DEPENDS then
        local baseSetoptStreamDepends = createMethodWrapper("setopt_stream_depends")
        
        function Easy.setopt_stream_depends(self, easy)
            return baseSetoptStreamDepends(self, easy:handle())
        end
        
        local baseSetoptStreamDependsE = createMethodWrapper("setopt_stream_depends_e")
        
        function Easy.setopt_stream_depends_e(self, easy)
            return baseSetoptStreamDependsE(self, easy:handle())
        end
    end
    
    local baseSetopt = createMethodWrapper("setopt")
    
    local optionHandlers = {
        [lcurl.OPT_HTTPPOST or true] = "setopt_httppost",
        [lcurl.OPT_STREAM_DEPENDS or true] = "setopt_stream_depends",
        [lcurl.OPT_STREAM_DEPENDS_E or true] = "setopt_stream_depends_e",
        [true] = nil
    }
    
    function Easy.setopt(self, option, value)
        if type(option) == "table" then
            local opts = option
            local newOpts = nil
            
            local httppost = opts.httppost or opts[lcurl.OPT_HTTPPOST]
            if httppost and httppost._handle then
                if not newOpts then
                    newOpts = copyTable(opts)
                end
                
                if newOpts.httppost then
                    newOpts.httppost = httppost:handle()
                end
                if newOpts[lcurl.OPT_HTTPPOST] then
                    newOpts[lcurl.OPT_HTTPPOST] = httppost:handle()
                end
            end
            
            local streamDepends = opts.stream_depends or opts[lcurl.OPT_STREAM_DEPENDS]
            if streamDepends and streamDepends._handle then
                if not newOpts then
                    newOpts = copyTable(opts)
                end
                
                if newOpts.stream_depends then
                    newOpts.stream_depends = streamDepends:handle()
                end
                if newOpts[lcurl.OPT_STREAM_DEPENDS] then
                    newOpts[lcurl.OPT_STREAM_DEPENDS] = streamDepends:handle()
                end
            end
            
            local streamDependsE = opts.stream_depends_e or opts[lcurl.OPT_STREAM_DEPENDS_E]
            if streamDependsE and streamDependsE._handle then
                if not newOpts then
                    newOpts = copyTable(opts)
                end
                
                if newOpts.stream_depends_e then
                    newOpts.stream_depends_e = streamDependsE:handle()
                end
                if newOpts[lcurl.OPT_STREAM_DEPENDS_E] then
                    newOpts[lcurl.OPT_STREAM_DEPENDS_E] = streamDependsE:handle()
                end
            end
            
            return baseSetopt(self, newOpts or opts)
        end
        
        local handler = optionHandlers[option]
        if handler then
            return self[handler](self, value)
        end
        
        return baseSetopt(self, option, value)
    end
    
    function Easy.__tostring(self)
        local ptr = extractPointer(tostring(self._handle))
        return string.format("%s %s (%s)", moduleInfo._NAME, "Easy", ptr)
    end
    
    return Easy
end

--[[
================================================================================
                           完整 Multi 类
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: initFullMultiClass(cURL, lcurl)
--------------------------------------------------------------------------------
功能: 初始化完整的 Multi 类

参数:
  cURL  - cURL 模块表
  lcurl - 底层 lcurl 库

说明:
  扩展 Multi 类，添加：
  - iperform: 迭代执行
  - setopt: 通用选项设置
  - setopt_socketfunction: 设置 socket 回调
--------------------------------------------------------------------------------
--]]
local function initFullMultiClass(cURL, lcurl)
    local Multi = createClass(lcurl.multi, "LcURL Multi")
    
    local baseAddHandle = createMethodWrapper("add_handle")
    local baseRemoveHandle = createMethodWrapper("remove_handle")
    
    function Multi.__init(self, options)
        self._easy = { n = 0 }
        if options then
            self:setopt(options)
        end
        return self
    end
    
    function Multi.iperform(self)
        return createMultiIterator(self, self.perform)
    end
    
    function Multi.add_handle(self, easy)
        assert(self._easy.n >= 0)
        
        local handle = easy:handle()
        
        if self._easy[handle] then
            return nil, lcurl.error(
                lcurl.ERROR_MULTI,
                lcurl.E_MULTI_ADDED_ALREADY or lcurl.E_MULTI_BAD_EASY_HANDLE
            )
        end
        
        local ok, err = baseAddHandle(self, handle)
        if not ok then
            return nil, err
        end
        
        self._easy.n = self._easy.n + 1
        self._easy[handle] = easy
        self._easy_mark = nil
        
        return self
    end
    
    function Multi.remove_handle(self, easy)
        local handle = easy:handle()
        
        if self._easy[handle] then
            self._easy.n = self._easy.n - 1
            self._easy[handle] = nil
        end
        
        assert(self._easy.n >= 0)
        return baseRemoveHandle(self, handle)
    end
    
    function Multi.info_read(self, ...)
        while true do
            local handle = self:handle()
            local easy, ok, err = handle:info_read(...)
            
            if not easy then
                return nil, ok
            end
            
            if easy == 0 then
                return easy
            end
            
            local easyWrapper = self._easy[easy]
            if easyWrapper then
                if (...) then
                    self._easy.n = self._easy.n - 1
                    self._easy[easy] = nil
                end
                return easyWrapper, ok, err
            end
        end
    end
    
    local function createSocketCallback(...)
        local argCount = select("#", ...)
        local callback, context, hasContext
        
        if argCount >= 2 then
            hasContext = true
            callback, context = assert(...)
        else
            callback = assert(...)
            if type(callback) ~= "function" then
                hasContext = true
                context = callback
                callback = assert(callback.socket)
            end
        end
        
        if hasContext then
            return function(easy, ...)
                return callback(context, ...)
            end
        end
        
        return function(easy, ...)
            return callback(...)
        end
    end
    
    local function createSocketWrapper(multi, callback)
        local weakRef = setmetatable({ value = multi }, { __mode = "v" })
        
        return function(handle, ...)
            local easy = weakRef.value._easy[handle]
            if easy then
                return callback(easy, ...)
            end
            return 0
        end
    end
    
    local baseSetoptSocketfunction = createMethodWrapper("setopt_socketfunction")
    
    function Multi.setopt_socketfunction(self, ...)
        local callback = createSocketCallback(...)
        return baseSetoptSocketfunction(self, createSocketWrapper(self, callback))
    end
    
    local baseSetopt = createMethodWrapper("setopt")
    
    function Multi.setopt(self, option, value)
        if type(option) == "table" then
            local opts = option
            
            local socketfunc = opts.socketfunction or opts[lcurl.OPT_SOCKETFUNCTION]
            if socketfunc then
                local newOpts = copyTable(opts)
                local wrapper = createSocketWrapper(self, socketfunc)
                
                if newOpts.socketfunction then
                    newOpts.socketfunction = wrapper
                end
                if newOpts[lcurl.OPT_SOCKETFUNCTION] then
                    newOpts[lcurl.OPT_SOCKETFUNCTION] = wrapper
                end
                
                return baseSetopt(self, newOpts)
            end
            
            return baseSetopt(self, opts)
        end
        
        if option == lcurl.OPT_SOCKETFUNCTION then
            return self:setopt_socketfunction(value)
        end
        
        return baseSetopt(self, option, value)
    end
    
    function Multi.__tostring(self)
        local ptr = extractPointer(tostring(self._handle))
        return string.format("%s %s (%s)", moduleInfo._NAME, "Multi", ptr)
    end
    
    return Multi
end

--[[
================================================================================
                           模块初始化
================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: initModule(lcurl)
--------------------------------------------------------------------------------
功能: 初始化 cURL 模块

参数:
  lcurl - 底层 lcurl 库

返回值:
  table - 初始化后的 cURL 模块

说明:
  这是模块的主入口函数，负责：
  1. 创建模块表
  2. 初始化所有类（Form、Easy、Multi、Share）
  3. 设置工厂函数（form、easy、multi）
  4. 继承底层 lcurl 的常量
--------------------------------------------------------------------------------
--]]
local function initModule(lcurl)
    local cURL = copyTable(moduleInfo)
    
    local Form = initFormClass(cURL, lcurl)
    local Easy = initFullEasyClass(cURL, lcurl)
    local Multi = initFullMultiClass(cURL, lcurl)
    
    setmetatable(cURL, { __index = lcurl })
    
    function cURL.form(...)
        return Form:new(...)
    end
    
    function cURL.easy(...)
        return Easy:new(...)
    end
    
    function cURL.multi(...)
        return Multi:new(...)
    end
    
    return cURL
end

return initModule
