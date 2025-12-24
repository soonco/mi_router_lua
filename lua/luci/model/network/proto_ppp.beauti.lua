--[[
LuCI PPP协议族注册模块 (luci.model.network.proto_ppp)

本模块向网络模型注册PPP (Point-to-Point Protocol) 系列协议，
包括PPP、PPTP、PPPoE、PPPoA、3G和L2TP等协议类型。

注册的协议:
- ppp: 基础PPP拨号协议
- pptp: PPTP VPN协议
- pppoe: PPPoE宽带拨号协议
- pppoa: PPPoA (ATM上的PPP) 协议
- 3g: 3G/UMTS/GPRS/EV-DO移动网络协议
- l2tp: L2TP VPN协议

每个协议类继承自network.protocol基类，并重写以下方法:
- get_i18n(): 获取协议的国际化显示名称
- ifname(): 获取虚拟接口名称
- opkg_package(): 获取协议所需的软件包名称
- is_installed(): 检查协议是否已安装
- is_floating(): 是否是浮动协议(不绑定物理接口)
- is_virtual(): 是否是虚拟协议
- get_interfaces(): 获取关联的物理接口
- contains_interface(): 检查是否包含指定接口

依赖模块:
- luci.model.network: 网络模型核心模块
- nixio.fs: 文件系统操作

作者: LuCI开发团队
]]--

local network_model = luci.model.network

-- PPP协议列表
local PPP_PROTOCOLS = {
    "ppp",      -- 基础PPP协议
    "pptp",     -- PPTP VPN
    "pppoe",    -- PPPoE宽带拨号
    "pppoa",    -- PPPoA (ATM)
    "3g",       -- 3G移动网络
    "l2tp"      -- L2TP VPN
}

-- 为每个PPP协议注册协议类
for _, protocol_name in ipairs(PPP_PROTOCOLS) do
    
    -- 注册协议并获取协议类
    local proto_class = network_model:register_protocol(protocol_name)
    
    -- 获取协议的国际化显示名称
    -- @param self 协议实例
    -- @return 翻译后的协议名称
    function proto_class.get_i18n(self)
        if protocol_name == "ppp" then
            return luci.i18n.translate("PPP")
        elseif protocol_name == "pptp" then
            return luci.i18n.translate("PPtP")
        elseif protocol_name == "3g" then
            return luci.i18n.translate("UMTS/GPRS/EV-DO")
        elseif protocol_name == "pppoe" then
            return luci.i18n.translate("PPPoE")
        elseif protocol_name == "pppoa" then
            return luci.i18n.translate("PPPoATM")
        elseif protocol_name == "l2tp" then
            return luci.i18n.translate("L2TP")
        end
    end
    
    -- 获取虚拟接口名称
    -- PPP接口名格式: 协议名-配置节名
    -- @param self 协议实例
    -- @return 接口名称字符串
    function proto_class.ifname(self)
        return protocol_name .. "-" .. self.sid
    end
    
    -- 获取协议所需的OPKG软件包名称
    -- @param self 协议实例
    -- @return 软件包名称
    function proto_class.opkg_package(self)
        if protocol_name == "ppp" then
            return "ppp"
        elseif protocol_name == "3g" then
            return "comgt"
        elseif protocol_name == "pptp" then
            return "ppp-mod-pptp"
        elseif protocol_name == "pppoe" then
            return "ppp-mod-pppoe"
        elseif protocol_name == "pppoa" then
            return "ppp-mod-pppoa"
        elseif protocol_name == "l2tp" then
            return "xl2tpd"
        end
    end
    
    -- 检查协议是否已安装
    -- 通过检查相关文件是否存在来判断
    -- @param self 协议实例
    -- @return true表示已安装，false表示未安装
    function proto_class.is_installed(self)
        if protocol_name == "pppoa" then
            -- PPPoA: 检查pppd插件
            local iter = nixio.fs.glob("/usr/lib/pppd/*/pppoatm.so")
            return iter() ~= nil
        elseif protocol_name == "pppoe" then
            -- PPPoE: 检查rp-pppoe插件
            local iter = nixio.fs.glob("/usr/lib/pppd/*/rp-pppoe.so")
            return iter() ~= nil
        elseif protocol_name == "pptp" then
            -- PPTP: 检查pptp插件
            local iter = nixio.fs.glob("/usr/lib/pppd/*/pptp.so")
            return iter() ~= nil
        elseif protocol_name == "3g" then
            -- 3G: 检查netifd协议脚本
            return nixio.fs.access("/lib/netifd/proto/3g.sh")
        elseif protocol_name == "l2tp" then
            -- L2TP: 检查netifd协议脚本
            return nixio.fs.access("/lib/netifd/proto/l2tp.sh")
        else
            -- 默认PPP: 检查基础协议脚本
            return nixio.fs.access("/lib/netifd/proto/ppp.sh")
        end
    end
    
    -- 检查是否是浮动协议
    -- 浮动协议不绑定到特定物理接口
    -- PPPoE是唯一非浮动的PPP协议(需要绑定以太网接口)
    -- @param self 协议实例
    -- @return true表示是浮动协议
    function proto_class.is_floating(self)
        return protocol_name ~= "pppoe"
    end
    
    -- 检查是否是虚拟协议
    -- 所有PPP协议都是虚拟协议
    -- @param self 协议实例
    -- @return true
    function proto_class.is_virtual(self)
        return true
    end
    
    -- 获取关联的物理接口列表
    -- 浮动协议返回nil，非浮动协议调用基类方法
    -- @param self 协议实例
    -- @return 接口列表或nil
    function proto_class.get_interfaces(self)
        if self:is_floating() then
            return nil
        else
            -- 调用基类的get_interfaces方法
            return network_model.protocol.get_interfaces(self)
        end
    end
    
    -- 检查是否包含指定接口
    -- @param self 协议实例
    -- @param interface 要检查的接口
    -- @return true表示包含该接口
    function proto_class.contains_interface(self, interface)
        if self:is_floating() then
            -- 浮动协议: 比较虚拟接口名
            local ifname = network_model:ifnameof(interface)
            return ifname == self:ifname()
        else
            -- 非浮动协议: 调用基类方法
            return network_model.protocol.contains_interface(self, interface)
        end
    end
    
    -- 注册虚拟接口模式
    -- 用于识别PPP虚拟接口名称
    network_model:register_pattern_virtual("^" .. protocol_name .. "-%w")
    
end
