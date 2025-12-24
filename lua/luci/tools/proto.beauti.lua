--[[
  LuCI 协议工具模块
  
  提供网络协议相关的CBI表单选项辅助函数
  主要用于处理网络接口的MAC地址配置
]]

module("luci.tools.proto", package.seeall)

-- 添加MAC地址选项到CBI表单
-- 支持从WiFi网络或普通接口读取/写入MAC地址
-- @param section CBI section对象
-- @param iface 网络接口对象(可选)
-- @param ... 额外参数传递给taboption
function opt_macaddr(section, iface, ...)
  local Value = luci.cbi.Value
  
  local mac_opt = section:taboption("advanced", Value, "macaddr", ...)
  
  local placeholder
  if iface then
    placeholder = iface:mac()
  end
  mac_opt.placeholder = placeholder
  mac_opt.datatype = "macaddr"
  
  function mac_opt:cfgvalue(section_id)
    local wifinet
    if iface then
      wifinet = iface:get_wifinet()
    end
    
    if wifinet then
      return wifinet:get("macaddr")
    else
      return Value.cfgvalue(self, section_id)
    end
  end
  
  function mac_opt:write(section_id, value)
    local wifinet
    if iface then
      wifinet = iface:get_wifinet()
    end
    
    if wifinet then
      wifinet:set("macaddr", value)
    elseif value then
      Value.write(self, section_id, value)
    else
      Value.remove(self, section_id)
    end
  end
  
  function mac_opt:remove(section_id)
    self:write(section_id, nil)
  end
end
