--[[
  小米路由器控制器工具模块
  
  功能说明:
  - 通过ubus与trafficd服务通信
  - 管理设备网络访问权限
  - 支持IP和MAC地址级别的权限控制
  - WiFi MAC过滤控制
  
  权限类型:
  - lan: LAN网络访问权限
  - wan: WAN网络访问权限 (上网权限)
  - admin: 管理后台访问权限
  - pridisk: 私有磁盘访问权限
  
  主要函数:
  - ippermission(): 基于IP地址设置权限
  - permission(): 基于MAC地址设置权限
  - wifimacfilter(): WiFi MAC地址过滤
]]

module("xiaoqiang.util.XQController", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local json = require("json")

-- 通过ubus发送消息到trafficd服务
-- @param data 要发送的数据表
local function _ubusSend(data)
    local json_str = json.encode(data)
    
    -- 构建ubus命令
    local cmd = "ubus send trafficd \"" .. XQFunction._cmdformat(json_str) .. "\""
    
    os.execute(cmd)
end

-- 基于IP地址设置网络访问权限
-- @param ipaddr IP地址
-- @param lan LAN访问权限 (0=禁止, 1=允许)
-- @param wan WAN访问权限 (0=禁止, 1=允许)
-- @param admin 管理后台访问权限 (0=禁止, 1=允许)
-- @param pridisk 私有磁盘访问权限 (0=禁止, 1=允许)
function ippermission(ipaddr, lan, wan, admin, pridisk)
    -- 参数验证
    if XQFunction.isStrNil(ipaddr) then
        return
    end
    
    local data = {
        api = 1,            -- API版本
        ipaddr = ipaddr,    -- IP地址
        lan = lan,          -- LAN权限
        wan = wan,          -- WAN权限
        admin = admin,      -- 管理权限
        pridisk = pridisk   -- 私有磁盘权限
    }
    
    _ubusSend(data)
end

-- 基于MAC地址设置网络访问权限
-- @param mac MAC地址
-- @param lan LAN访问权限 (0=禁止, 1=允许)
-- @param wan WAN访问权限 (0=禁止, 1=允许)
-- @param admin 管理后台访问权限 (0=禁止, 1=允许)
-- @param pridisk 私有磁盘访问权限 (0=禁止, 1=允许)
function permission(mac, lan, wan, admin, pridisk)
    -- 参数验证
    if XQFunction.isStrNil(mac) then
        return
    end
    
    local data = {
        api = 1,            -- API版本
        mac = mac,          -- MAC地址
        lan = lan,          -- LAN权限
        wan = wan,          -- WAN权限
        admin = admin,      -- 管理权限
        pridisk = pridisk   -- 私有磁盘权限
    }
    
    _ubusSend(data)
end

-- WiFi MAC地址过滤控制
-- @param mac MAC地址 (可选，用于单个设备控制)
-- @param enable 是否启用过滤 (当mac为nil时使用)
-- @param model 过滤模式 ("whitelist"=白名单, "blacklist"=黑名单)
-- @param option 操作选项 ("add"=添加, "del"=删除)
function wifimacfilter(mac, enable, model, option)
    local data = {
        api = 2,            -- API版本
        mac = "",           -- MAC地址
        enable = "",        -- 启用状态
        model = "",         -- 过滤模式
        option = ""         -- 操作选项
    }
    
    if mac then
        -- 单个设备控制
        data.mac = mac
        data.model = model
        data.option = option
    else
        -- 全局开关控制
        data.mac = nil
        if enable then
            data.enable = 1
        else
            data.enable = nil
        end
        data.model = model
    end
    
    -- 注意：原代码未调用_ubusSend，可能是未完成的功能
end
