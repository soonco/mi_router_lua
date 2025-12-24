--[[
    小米路由器 UPnP 工具模块
    提供 UPnP（通用即插即用）功能的管理
    
    主要功能:
    - 获取 UPnP 状态
    - 开启/关闭 UPnP
    - 获取 UPnP 端口映射列表
]]

module("xiaoqiang.util.XQUPnPUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local xssFilter = require("xssFilter").new()
local luci_util = require("luci.util")

--[[
    获取 UPnP 服务状态
    
    @return true 表示 UPnP 已启用，false 表示已禁用
]]
function getUPnPStatus()
    local result = os.execute(XQConfigs.UPNP_STATUS)
    
    if result == 0 then
        return true
    else
        return false
    end
end

--[[
    开启或关闭 UPnP 服务
    
    @param enable true 表示开启，false 表示关闭
    @return 命令执行结果
]]
function switchUPnP(enable)
    if enable then
        os.execute("[ -f /etc/config/upnpd ] && sed -i 's/disable_upnp/enable_upnp/g' /etc/config/upnpd")
        return os.execute(XQConfigs.UPNP_ENABLE)
    else
        os.execute("[ -f /etc/config/upnpd ] && sed -i 's/enable_upnp/disable_upnp/g' /etc/config/upnpd")
        return os.execute(XQConfigs.UPNP_DISABLE)
    end
end

--[[
    获取 UPnP 端口映射列表
    
    @return 端口映射列表，每项包含 protocol、rport、ip、cport、time、name
            如果 UPnP 未启用或无映射则返回 nil
]]
function getUPnPList()
    local status = getUPnPStatus()
    
    if status then
        local lease_file_path = luci_util.exec(XQConfigs.UPNP_LEASE_FILE)
        
        if lease_file_path then
            lease_file_path = luci_util.trim(lease_file_path)
            
            local file = io.open(lease_file_path)
            if file then
                local upnp_list = {}
                
                for line in file:lines() do
                    if not XQFunction.isStrNil(line) then
                        local entry = {}
                        local filtered_line = xssFilter:filter(line)
                        local parts = luci_util.split(filtered_line, ":", 5)
                        
                        if #parts == 6 then
                            entry.protocol = parts[1]
                            entry.rport = parts[2]
                            entry.ip = parts[3]
                            entry.cport = parts[4]
                            entry.time = parts[5]
                            
                            if parts[6] == "(null)" then
                                entry.name = "未知程序"
                            else
                                entry.name = parts[6]
                            end
                            
                            table.insert(upnp_list, entry)
                        end
                    end
                end
                
                file:close()
                return upnp_list
            end
        end
    end
    
    return nil
end
