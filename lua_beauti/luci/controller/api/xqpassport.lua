--[[
小米路由器 Passport (账号认证) API 控制器
提供小米账号登录、绑定、解绑、插件管理等功能

API端点:
  /api/xqpassport/login          - 小米账号登录
  /api/xqpassport/userInfo       - 获取用户信息
  /api/xqpassport/rigister       - 路由器注册
  /api/xqpassport/binded         - 获取绑定信息
  /api/xqpassport/plugin_list    - 获取插件列表
  /api/xqpassport/plugin_enable  - 启用插件
  /api/xqpassport/plugin_disable - 禁用插件
  /api/xqpassport/plugin_detail  - 获取插件详情
  /api/xqpassport/unbound        - 解绑路由器

依赖模块:
  - luci.http: HTTP请求处理
  - xiaoqiang.util.XQErrorUtil: 错误处理工具
  - xiaoqiang.util.XQNetUtil: 网络工具
  - xiaoqiang.util.XQSysUtil: 系统工具
  - xiaoqiang.util.XQDBUtil: 数据库工具
]]

module("luci.controller.api.xqpassport", package.seeall)

local http = require("luci.http")
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")

function index()
    local rootNode = node("api", "xqpassport")
    rootNode.target = firstchild()
    rootNode.title = ""
    rootNode.order = 400
    rootNode.sysauth = "admin"
    rootNode.sysauth_authenticator = "jsonauth"
    rootNode.index = true

    entry({"api", "xqpassport"}, firstchild(), "", 400)
    entry({"api", "xqpassport", "login"}, call("passportLogin"), "", 401, 1)
    entry({"api", "xqpassport", "userInfo"}, call("getUserInfo"), "", 402)
    entry({"api", "xqpassport", "rigister"}, call("routerRegister"), "", 405, 1)
    entry({"api", "xqpassport", "binded"}, call("getBindInfo"), "", 406, 1)
    entry({"api", "xqpassport", "plugin_list"}, call("pluginList"), "", 407)
    entry({"api", "xqpassport", "plugin_enable"}, call("pluginEnable"), "", 408)
    entry({"api", "xqpassport", "plugin_disable"}, call("pluginDisable"), "", 409)
    entry({"api", "xqpassport", "plugin_detail"}, call("pluginDetail"), "", 410)
    entry({"api", "xqpassport", "unbound"}, call("unboundRouter"), "", 411)
end

function getBindInfo()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")

    local uuid = http.formvalue("uuid") or ""
    local forceRefresh = tonumber(http.formvalue("force") or "0")

    local result = {}
    local errorCode = 0

    local bindUserId = XQSysUtil.getPassportBindInfo()

    if bindUserId then
        result.bind = 1
        local userInfo = XQSysUtil.getBindUserInfo()

        if userInfo == nil or forceRefresh ~= 0 then
            userInfo = XQNetUtil.getUserInfo(uuid)
        end

        if userInfo then
            if userInfo.miliaoNick and userInfo.miliaoNick ~= "" then
                userInfo.aliasNick = userInfo.miliaoNick
            end
            result.info = userInfo
        else
            local defaultInfo = {}
            defaultInfo.aliasNick = bindUserId
            defaultInfo.miliaoIcon = ""
            defaultInfo.miliaoIconOrig = ""
            defaultInfo.miliaoNick = ""
            defaultInfo.userId = bindUserId
            result.info = defaultInfo
        end
    else
        result.bind = 0
    end

    result.routerName = XQSysUtil.getRouterName()

    if errorCode ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(errorCode)
    end

    result.code = errorCode
    http.write_json(result)
end

function unboundRouter()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")

    local result = {}
    local errorCode = 0

    local uuid = http.formvalue("uuid")
    local password = http.formvalue("password")

    if uuid == nil or uuid == "" then
        uuid = XQSysUtil.getBindUUID()
    end

    if password ~= nil then
        local loginResult = XQNetUtil.xiaomiLogin(uuid, password)

        if loginResult then
            if loginResult.code == 0 then
                local bindUserId = XQSysUtil.getPassportBindInfo()

                if bindUserId then
                    local dismissResult = XQNetUtil.dismissAccount(nil, uuid)

                    if dismissResult then
                        local dismissCode = tonumber(dismissResult.code)
                        if dismissCode == 0 or dismissCode == 3001 or dismissCode == 3002 then
                            XQSysUtil.setPassportBound(false, uuid)
                        end
                    else
                        errorCode = 1550
                    end
                end
            else
                errorCode = 1556
            end
        else
            errorCode = 1557
        end
    end

    if errorCode ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(errorCode)
    else
        http.header("Set-Cookie", "psp=admin|||2|||0;path=/;")
    end

    result.code = errorCode
    http.write_json(result)
end

function passportLogin()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")

    local result = {}
    local errorCode = 0

    local uuid = http.formvalue("uuid")
    local password = http.formvalue("password")
    local encrypt = http.formvalue("encrypt")

    local loginResult = XQNetUtil.xiaomiLogin(uuid, password)

    if loginResult then
        if loginResult.code == 0 then
            local bindUserId = XQSysUtil.getPassportBindInfo()

            if bindUserId then
                if loginResult.uuid == bindUserId then
                    local adminList = XQNetUtil.getAdminList()

                    if adminList then
                        if type(adminList) == "table" then
                            local adminCode = tonumber(adminList.code)

                            if adminCode == 0 then
                                errorCode = 0
                                http.header("Set-Cookie", "psp=" .. loginResult.uuid .. "|||" .. 1 .. "|||" .. loginResult.token .. ";path=/;")
                            elseif adminCode == 401 then
                                errorCode = 1551
                            else
                                errorCode = 1549
                                XQSysUtil.setPassportBound(false, loginResult.uuid)
                                http.header("Set-Cookie", "psp=admin|||2|||0;path=/;")
                            end
                        end
                    else
                        errorCode = 1551
                        if adminList and adminList.msg then
                            result.errorDetail = adminList.msg
                        end
                    end
                else
                    errorCode = 1548
                end
            else
                XQDBUtil.setBindUUID(loginResult.uuid)
            end

            result.token = loginResult.token
            result.uuid = loginResult.uuid
        end
    else
        if loginResult then
            if loginResult.code ~= 0 then
                if loginResult.code == 1 then
                    errorCode = 1564
                elseif loginResult.code == 2 then
                    errorCode = 1565
                else
                    errorCode = 1566
                end
            end
        else
            errorCode = 1538
        end
    end

    if errorCode ~= 0 then
        local XQFunction = require("xiaoqiang.common.XQFunction")
        XQFunction.forkExec("/usr/sbin/ntpsetclock 99999 log >/dev/null 2>&1")
        result.msg = XQErrorUtil.getErrorMessage(errorCode)
    end

    result.code = errorCode
    http.write_json(result)
end

function routerAdminList()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")

    local result = {}
    local errorCode = 0

    local uuid = http.formvalue("uuid") or ""

    local bindUserId = XQSysUtil.getPassportBindInfo()

    if not bindUserId then
        errorCode = 1542
    else
        local adminList = XQNetUtil.getAdminList(uuid)

        if adminList then
            local adminCode = tonumber(adminList.code)
            if adminCode == 0 then
                result.list = adminList.adminList
            end
        else
            if adminList then
                local adminCode = tonumber(adminList.code)
                if adminCode == 401 then
                    errorCode = 1581
                end
            else
                errorCode = 1543
            end
        end
    end

    if errorCode ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(errorCode)
    end

    result.code = errorCode
    http.write_json(result)
end

function routerRegister()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")
    local XQDBUtil = require("xiaoqiang.util.XQDBUtil")

    local result = {}
    local errorCode = 0

    local uuid = http.formvalue("uuid")

    local registerResult = XQNetUtil.routerRegister(uuid)
    local passportInfo = XQNetUtil.getPassport(uuid)

    if registerResult then
        local registerCode = tonumber(registerResult.code)
        if registerCode == 0 then
            result.deviceID = registerResult.id
            XQSysUtil.setPassportBound(true, passportInfo.uuid)
        end
    else
        XQSysUtil.setPassportBound(false, nil)
        errorCode = 1541
    end

    if errorCode ~= 0 then
        local XQFunction = require("xiaoqiang.common.XQFunction")
        XQFunction.forkExec("/usr/sbin/ntpsetclock 99999 log >/dev/null 2>&1")
        result.msg = XQErrorUtil.getErrorMessage(errorCode)
    else
        http.header("Set-Cookie", "psp=" .. uuid .. "|||" .. 1 .. "|||" .. passportInfo.token .. ";path=/;")
    end

    result.code = errorCode
    http.write_json(result)
end

function getUserInfo()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")

    local result = {}
    local errorCode = 0

    local uuid = http.formvalue("uuid") or ""

    local userInfo = XQNetUtil.getUserInfo(uuid)

    if userInfo then
        result.userInfo = userInfo
    else
        errorCode = 1539
    end

    if errorCode ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(errorCode)
    end

    result.code = errorCode
    http.write_json(result)
end

function pluginList()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")

    local result = {}

    local uuid = http.formvalue("uuid") or ""

    local pluginListResult = XQNetUtil.pluginList(uuid)

    if pluginListResult then
        local pluginCode = tonumber(pluginListResult.code)
        if pluginCode == 0 then
            result.code = 0
            result.list = pluginListResult
        end
    else
        if pluginListResult then
            local pluginCode = tonumber(pluginListResult.code)
            if pluginCode == 401 then
                result.code = 1581
            end
        else
            if pluginListResult then
                local pluginCode = tonumber(pluginListResult.code)
                if pluginCode == 3001 then
                    result.code = 1580
                end
            else
                result.code = 1544
            end
        end
    end

    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end

    http.write_json(result)
end

function pluginEnable()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")

    local result = {}

    local uuid = http.formvalue("uuid") or ""
    local pluginId = http.formvalue("pluginId")

    local enableResult = XQNetUtil.pluginEnable(uuid, pluginId)

    if enableResult then
        local enableCode = tonumber(enableResult.code)
        if enableCode == 0 then
            result.code = 0
        end
    else
        if enableResult then
            local enableCode = tonumber(enableResult.code)
            if enableCode == 401 then
                result.code = 1581
            end
        else
            if enableResult then
                local enableCode = tonumber(enableResult.code)
                if enableCode == 3001 then
                    result.code = 1580
                end
            else
                result.code = 1545
            end
        end
    end

    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end

    http.write_json(result)
end

function pluginDisable()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")

    local result = {}

    local uuid = http.formvalue("uuid") or ""
    local pluginId = http.formvalue("pluginId")

    local disableResult = XQNetUtil.pluginDisable(uuid, pluginId)

    if disableResult then
        local disableCode = tonumber(disableResult.code)
        if disableCode == 0 then
            result.code = 0
        end
    else
        if disableResult then
            local disableCode = tonumber(disableResult.code)
            if disableCode == 401 then
                result.code = 1581
            end
        else
            if disableResult then
                local disableCode = tonumber(disableResult.code)
                if disableCode == 3001 then
                    result.code = 1580
                end
            else
                result.code = 1546
            end
        end
    end

    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end

    http.write_json(result)
end

function pluginDetail()
    local XQNetUtil = require("xiaoqiang.util.XQNetUtil")

    local result = {}

    local uuid = http.formvalue("uuid") or ""
    local pluginId = http.formvalue("pluginId")

    local detailResult = XQNetUtil.pluginDetail(uuid, pluginId)

    if detailResult then
        local detailCode = tonumber(detailResult.code)
        if detailCode == 0 then
            result.code = 0
            result.detail = detailResult
        end
    else
        if detailResult then
            local detailCode = tonumber(detailResult.code)
            if detailCode == 401 then
                result.code = 1581
            end
        else
            if detailResult then
                local detailCode = tonumber(detailResult.code)
                if detailCode == 3001 then
                    result.code = 1580
                end
            else
                result.code = 1547
            end
        end
    end

    if result.code ~= 0 then
        result.msg = XQErrorUtil.getErrorMessage(result.code)
    end

    http.write_json(result)
end
