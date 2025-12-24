local L0, L1, L2, L3, L4
L0 = module
L1 = "xiaoqiang.module.XQDMZModule"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "luci.model.uci"
L2 = L2(L3)
L2 = L2.cursor
L2 = L2()
L3 = {}
L3.vlan1hwname = "et0"
L3.vlan2hwname = "et0"
L3.vlan3hwname = "et0"
L3.vlan1ports = "2 5*"
L3.vlan2ports = "4 5"
L3.vlan3ports = "0 5*"
DMZ_NVRAM = L3
L3 = {}
L4 = {}
L4.device = "eth0"
L4.vlan = 1
L4.ports = "2 5*"
L3.eth0_1 = L4
L4 = {}
L4.device = "eth0"
L4.vlan = 3
L4.ports = "0 5*"
L3.eth0_3 = L4
L4 = {}
L4.ifname = "eth0.3"
L4.proto = "static"
L4.ipaddr = ""
L4.netmask = "255.255.255.0"
L3.dmz = L4
DMZ_NETWORK_CONFIGS = L3
L3 = {}
L4 = {}
L4.name = "dmz"
L4.network = "dmz"
L4.input = "REJECT"
L4.output = "ACCEPT"
L4.forward = "REJECT"
L3.zonedmz = L4
L4 = {}
L4.src = "dmz"
L4.proto = "tcpudp"
L4.dest_port = 53
L4.target = "ACCEPT"
L3.dmzdns = L4
L4 = {}
L4.src = "dmz"
L4.proto = "udp"
L4.dest_port = 67
L4.target = "ACCEPT"
L3.dmzdhcp = L4
L4 = {}
L4.src = "dmz"
L4.dest = "wan"
L3.dmztowan = L4
L4 = {}
L4.src = "lan"
L4.dest = "dmz"
L3.lantodmz = L4
L4 = {}
L4.src = "wan"
L4.proto = "tcp"
L4.target = "DNAT"
L4.dest = "lan"
L4.dest_ip = ""
L3.dmz = L4
L4 = {}
L4.src = "wan"
L4.proto = "udp"
L4.target = "DNAT"
L4.dest = "lan"
L4.src_port = "!67"
L4.dest_ip = ""
L3.dmzudp = L4
DMZ_FIREWALL_CONFIGS = L3
L3 = {}
L4 = {}
L4.interface = "dmz"
L4.start = 100
L4.limit = 150
L4.leasetime = "12h"
L4.force = 1
L3.dmz = L4
DMZ_DHCP_CONFIGS = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "firewall"
  L6 = "dmz"
  L7 = "dest_ip"
  L3 = L3(L4, L5, L6, L7)
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if not L4 then
    L4 = ".%d+$"
    if A1 == "255.255.0.0" then
      L4 = ".%d+.%d+$"
    end
    L6 = A0
    L5 = A0.gsub
    L7 = L4
    L8 = ""
    L5 = L5(L6, L7, L8)
    L6 = L5
    L8 = L3
    L7 = L3.match
    L9 = L4
    L7 = L7(L8, L9)
    L3 = L6 .. L7
    L7 = L2
    L6 = L2.set
    L8 = "firewall"
    L9 = "dmz"
    L10 = "dest_ip"
    L11 = L3
    L6(L7, L8, L9, L10, L11)
    L7 = L2
    L6 = L2.set
    L8 = "firewall"
    L9 = "dmzudp"
    L10 = "dest_ip"
    L11 = L3
    L6(L7, L8, L9, L10, L11)
    L7 = L2
    L6 = L2.commit
    L8 = "firewall"
    L6(L7, L8)
  end
end
hookLanIPChangeEvent = L3
function L3(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  if A0 == 1 then
    L3 = L1
    L2 = L1.delete
    L4 = "firewall"
    L5 = "zonedmz"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.delete
    L4 = "firewall"
    L5 = "dmzdns"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.delete
    L4 = "firewall"
    L5 = "dmzdhcp"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.delete
    L4 = "firewall"
    L5 = "dmztowan"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.delete
    L4 = "firewall"
    L5 = "lantodmz"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.delete
    L4 = "firewall"
    L5 = "dmz"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.commit
    L4 = "firewall"
    L2(L3, L4)
    L3 = L1
    L2 = L1.delete
    L4 = "dhcp"
    L5 = "dmz"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.commit
    L4 = "dhcp"
    L2(L3, L4)
    L3 = L1
    L2 = L1.delete
    L4 = "network"
    L5 = "dmz"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.delete
    L4 = "network"
    L5 = "eth0_3"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.commit
    L4 = "network"
    L2(L3, L4)
    L2 = _UPVALUE0_
    L2 = L2.nvramSet
    L3 = "vlan3hwname"
    L4 = nil
    L2(L3, L4)
    L2 = _UPVALUE0_
    L2 = L2.nvramSet
    L3 = "vlan3ports"
    L4 = nil
    L2(L3, L4)
    L2 = _UPVALUE0_
    L2 = L2.nvramSet
    L3 = "vlan2ports"
    L4 = "4 5"
    L2(L3, L4)
    L2 = _UPVALUE0_
    L2 = L2.nvramSet
    L3 = "vlan1ports"
    L4 = "0 2 5*"
    L2(L3, L4)
    L2 = _UPVALUE0_
    L2 = L2.nvramCommit
    L2()
  elseif A0 == 0 then
    L3 = L1
    L2 = L1.delete
    L4 = "firewall"
    L5 = "dmz"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.delete
    L4 = "firewall"
    L5 = "dmzudp"
    L2(L3, L4, L5)
    L3 = L1
    L2 = L1.commit
    L4 = "firewall"
    L2(L3, L4)
    L2 = _UPVALUE0_
    L2 = L2.isMeshMode
    L2 = L2()
    if not L2 then
      L2 = _UPVALUE0_
      L2 = L2.setNetMode
      L3 = nil
      L2(L3)
    end
    L2 = _UPVALUE0_
    L2 = L2.nvramCommit
    L2()
  end
end
unsetDMZ = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = DMZ_FIREWALL_CONFIGS
  L3 = L3.dmz
  L4 = DMZ_FIREWALL_CONFIGS
  L4 = L4.dmzudp
  L6 = L2
  L5 = L2.get
  L7 = "network"
  L8 = "lan"
  L9 = "ipaddr"
  L5 = L5(L6, L7, L8, L9)
  L7 = L2
  L6 = L2.get
  L8 = "network"
  L9 = "lan"
  L10 = "netmask"
  L6 = L6(L7, L8, L9, L10)
  L7 = ".%d+$"
  if L6 == "255.255.0.0" then
    L7 = ".%d+.%d+$"
  end
  L9 = L5
  L8 = L5.gsub
  L10 = L7
  L11 = ""
  L8 = L8(L9, L10, L11)
  L10 = A0
  L9 = A0.gsub
  L11 = L7
  L12 = ""
  L9 = L9(L10, L11, L12)
  if L8 ~= L9 or L5 == A0 then
    L10 = 2
    return L10
  end
  L3.dest_ip = A0
  L4.dest_ip = A0
  L11 = L2
  L10 = L2.section
  L12 = "firewall"
  L13 = "redirect"
  L14 = "dmz"
  L15 = L3
  L10(L11, L12, L13, L14, L15)
  L11 = L2
  L10 = L2.section
  L12 = "firewall"
  L13 = "redirect"
  L14 = "dmzudp"
  L15 = L4
  L10(L11, L12, L13, L14, L15)
  L11 = L2
  L10 = L2.commit
  L12 = "firewall"
  L10(L11, L12)
  L10 = _UPVALUE0_
  L10 = L10.isStrNil
  L11 = A1
  L10 = L10(L11)
  if not L10 then
    L10 = require
    L11 = "xiaoqiang.util.XQLanWanUtil"
    L10 = L10(L11)
    L11 = L10.addBind
    L12 = A1
    L13 = A0
    L11 = L11(L12, L13)
    if L11 == 0 then
      L12 = L10.saveBindInfo
      L12()
    end
    return L11
  end
  L10 = 0
  return L10
end
_setSimpleDMZ = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "luci.util"
  L3 = L3(L4)
  L5 = L2
  L4 = L2.get
  L6 = "network"
  L7 = "lan"
  L4 = L4(L5, L6, L7, L8)
  L5 = L3.split
  L6 = A0
  L7 = "."
  L5 = L5(L6, L7)
  L5[4] = 1
  L6 = table
  L6 = L6.concat
  L7 = L5
  L6 = L6(L7, L8)
  L5 = L6
  L7 = L4
  L6 = L4.gsub
  L6 = L6(L7, L8, L9)
  L7 = A0.gsub
  L7 = L7(L8, L9, L10)
  if L6 == L7 or L4 == A0 then
    return L8
  end
  for L11, L12 in L8, L9, L10 do
    L13 = _UPVALUE0_
    L13 = L13.nvramSet
    L14 = L11
    L15 = L12
    L13(L14, L15)
  end
  L8()
  L10.ipaddr = L5
  L12 = L2
  L11 = L2.section
  L13 = "network"
  L14 = "switch_vlan"
  L15 = "eth0_1"
  L16 = L8
  L11(L12, L13, L14, L15, L16)
  L12 = L2
  L11 = L2.section
  L13 = "network"
  L14 = "switch_vlan"
  L15 = "eth0_3"
  L16 = L9
  L11(L12, L13, L14, L15, L16)
  L12 = L2
  L11 = L2.section
  L13 = "network"
  L14 = "interface"
  L15 = "dmz"
  L16 = L10
  L11(L12, L13, L14, L15, L16)
  L12 = L2
  L11 = L2.commit
  L13 = "network"
  L11(L12, L13)
  L11 = DMZ_FIREWALL_CONFIGS
  L11 = L11.zonedmz
  L12 = DMZ_FIREWALL_CONFIGS
  L12 = L12.dmzdns
  L13 = DMZ_FIREWALL_CONFIGS
  L13 = L13.dmzdhcp
  L14 = DMZ_FIREWALL_CONFIGS
  L14 = L14.dmztowan
  L15 = DMZ_FIREWALL_CONFIGS
  L15 = L15.lantodmz
  L16 = DMZ_FIREWALL_CONFIGS
  L16 = L16.dmz
  L16.dest_ip = A0
  L18 = L2
  L17 = L2.section
  L19 = "firewall"
  L20 = "zone"
  L21 = "zonedmz"
  L22 = L11
  L17(L18, L19, L20, L21, L22)
  L18 = L2
  L17 = L2.section
  L19 = "firewall"
  L20 = "rule"
  L21 = "dmzdns"
  L22 = L12
  L17(L18, L19, L20, L21, L22)
  L18 = L2
  L17 = L2.section
  L19 = "firewall"
  L20 = "rule"
  L21 = "dmzdhcp"
  L22 = L13
  L17(L18, L19, L20, L21, L22)
  L18 = L2
  L17 = L2.section
  L19 = "firewall"
  L20 = "forwarding"
  L21 = "dmztowan"
  L22 = L14
  L17(L18, L19, L20, L21, L22)
  L18 = L2
  L17 = L2.section
  L19 = "firewall"
  L20 = "forwarding"
  L21 = "lantodmz"
  L22 = L15
  L17(L18, L19, L20, L21, L22)
  L18 = L2
  L17 = L2.section
  L19 = "firewall"
  L20 = "redirect"
  L21 = "dmz"
  L22 = L16
  L17(L18, L19, L20, L21, L22)
  L18 = L2
  L17 = L2.commit
  L19 = "firewall"
  L17(L18, L19)
  L17 = DMZ_DHCP_CONFIGS
  L17 = L17.dmz
  L19 = L2
  L18 = L2.section
  L20 = "dhcp"
  L21 = "dhcp"
  L22 = "dmz"
  L23 = L17
  L18(L19, L20, L21, L22, L23)
  L18 = _UPVALUE0_
  L18 = L18.isStrNil
  L19 = A1
  L18 = L18(L19)
  if not L18 then
    L18 = require
    L19 = "xiaoqiang.util.XQLanWanUtil"
    L18 = L18(L19)
    L19 = L18.addBind
    L20 = A1
    L21 = A0
    L19 = L19(L20, L21)
    if L19 == 0 then
      L20 = L18.saveBindInfo
      L20()
    end
    return L19
  end
  L18 = 0
  return L18
end
_setComplexDMZ = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "firewall"
  L4 = "dmz"
  L5 = "dest_ip"
  L1 = L1(L2, L3, L4, L5)
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "dmz"
  L6 = "enabled"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  if L2 == "1" and L1 then
    L3 = true
    return L3
  else
    L3 = false
    return L3
  end
end
moduleOn = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.module.XQPortForward"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = L0.moduleOn
  L3 = L3()
  if L3 then
    L2.status = 2
  else
    L3 = moduleOn
    L3 = L3()
    if L3 then
      L3 = 1
      if L3 then
        goto lbl_24
      end
    end
    L3 = 0
    ::lbl_24::
    L2.status = L3
    L3 = L2.status
    if L3 == 1 then
      L4 = L1
      L3 = L1.get
      L5 = "firewall"
      L6 = "dmz"
      L7 = "dest_ip"
      L3 = L3(L4, L5, L6, L7)
      L3 = L3 or L3
      L2.ip = L3
    end
  end
  L4 = L1
  L3 = L1.get
  L5 = "network"
  L6 = "lan"
  L7 = "ipaddr"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2.lanip = L3
  L4 = L1
  L3 = L1.get
  L5 = "network"
  L6 = "lan"
  L7 = "netmask"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2.lanmask = L3
  return L2
end
getDMZInfo = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = require
  L4 = "xiaoqiang.XQFeatures"
  L3 = L3(L4)
  L3 = L3.FEATURES
  L4 = require
  L5 = "xiaoqiang.module.XQPortForward"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A1
  L5 = L5(L6)
  if L5 then
    L5 = 2
    return L5
  end
  L5 = L3.apps
  L5 = L5.natpro
  if L5 then
    L5 = L3.apps
    L5 = L5.natpro
    if L5 == "1" then
      L5 = L4.VSOn
      L5 = L5()
      if not L5 then
        L5 = L4.PTOn
        L5 = L5()
      end
      if L5 then
        L5 = 5
        return L5
      end
  end
  else
    L5 = L4.moduleOn
    L5 = L5()
    if L5 then
      L5 = 4
      return L5
    end
  end
  if A0 == 0 then
    L5 = _setSimpleDMZ
    L6 = A1
    L7 = A2
    return L5(L6, L7)
  elseif A0 == 1 then
    L5 = _setComplexDMZ
    L6 = A1
    L7 = A2
    return L5(L6, L7)
  else
    L5 = 3
    return L5
  end
end
setDMZ = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = " /etc/init.d/firewall restart; "
  if A0 == 0 then
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.get
    L4 = "upnpd"
    L5 = "config"
    L6 = "enable_upnp"
    L2 = L2(L3, L4, L5, L6)
    L2 = L2 or L2
    if L2 then
      L3 = L1
      L4 = _UPVALUE1_
      L4 = L4.UPNP_DISABLE
      L5 = _UPVALUE1_
      L5 = L5.UPNP_ENABLE
      L1 = L3 .. L4 .. L5
    end
    L3 = L1
    L4 = _UPVALUE1_
    L4 = L4.FORK_RESTART_DNSMASQ
    L1 = L3 .. L4
    L3 = _UPVALUE2_
    L3 = L3.forkExec
    L4 = L1
    L3(L4)
  elseif A0 == 1 then
    L2 = _UPVALUE2_
    L2 = L2.forkReboot
    L2()
  end
end
dmzReload = L3
