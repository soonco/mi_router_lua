local L0, L1, L2, L3, L4
L0 = module
L1 = "xiaoqiang.module.XQFirewall"
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
L3 = "xiaoqiang.module.XQDMZModule"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.module.XQPortForward"
L3 = L3(L4)
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "xiaoqiang.XQLog"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L4 = L1
  L3 = L1.foreach
  L5 = "firewall"
  L6 = "rule"
  function L7(A0)
    local L1, L2, L3, L4
    L1 = A0.name
    if L1 == "Allow-IPv4-Ping" then
      L1 = A0.target
      if L1 == "DROP" then
        L1 = 0
        ignorewanpingv4 = L1
      else
        L1 = 1
        ignorewanpingv4 = L1
      end
    else
      L1 = A0.name
      if L1 == "Allow-IPv6-Ping" then
        L1 = A0.target
        if L1 == "DROP" then
          L1 = 0
          ignorewanpingv6 = L1
        else
          L1 = 1
          ignorewanpingv6 = L1
        end
      else
        L1 = _UPVALUE0_
        L1 = L1.log
        L2 = 1
        L3 = "s.name="
        L4 = A0.name
        L3 = L3 .. L4
        L1(L2, L3)
      end
    end
  end
  L3(L4, L5, L6, L7)
  L3 = ignorewanpingv4
  L3 = L3 and L3
  ignorewanping = L3
  L3 = ignorewanping
  L2.wanping_firewall = L3
end
FirewallWANPing = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "@defaults[0]"
  L6 = "fw_enable"
  L2 = L2(L3, L4, L5, L6)
  L1.firewall_enable = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "@defaults[0]"
  L6 = "spi_rule"
  L2 = L2(L3, L4, L5, L6)
  L1.spi_firewall = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "@defaults[0]"
  L6 = "dos_enable"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.dos_firewall = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "@defaults[0]"
  L6 = "ignore_wan_ping"
  L2 = L2(L3, L4, L5, L6)
  L1.wanping_firewall = L2
  return L1
end
FirewallInfo = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = setDoSFirewallFw
  L3 = A0
  L2(L3)
  L3 = L1
  L2 = L1.set
  L4 = "firewall"
  L5 = "@defaults[0]"
  L6 = "dos_enable"
  L7 = A0
  L2(L3, L4, L5, L6, L7)
  L3 = L1
  L2 = L1.commit
  L4 = "firewall"
  L2(L3, L4)
end
setDoSFirewall = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  if A0 == 1 then
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "syn_flood"
    L8 = "1"
    L3(L4, L5, L6, L7, L8)
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "rst_flood"
    L8 = "1"
    L3(L4, L5, L6, L7, L8)
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "icmp_flood"
    L8 = "1"
    L3(L4, L5, L6, L7, L8)
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "udp_flood"
    L8 = "1"
    L3(L4, L5, L6, L7, L8)
  elseif A0 == 0 then
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "syn_flood"
    L8 = "0"
    L3(L4, L5, L6, L7, L8)
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "rst_flood"
    L8 = "0"
    L3(L4, L5, L6, L7, L8)
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "icmp_flood"
    L8 = "0"
    L3(L4, L5, L6, L7, L8)
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "udp_flood"
    L8 = "0"
    L3(L4, L5, L6, L7, L8)
  else
    L3 = L1.log
    L4 = 1
    L5 = "dos="
    L6 = A0
    L5 = L5 .. L6
    L3(L4, L5)
  end
  L4 = L2
  L3 = L2.commit
  L5 = "firewall"
  L3(L4, L5)
end
setDoSFirewallFw = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.foreach
  L5 = "firewall"
  L6 = "rule"
  function L7(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = A0.name
    if L1 ~= "Allow-IPv4-Ping" then
      L1 = A0.name
      if L1 ~= "Allow-IPv6-Ping" then
        goto lbl_36
      end
    end
    L1 = _UPVALUE0_
    if L1 == 1 then
      L1 = _UPVALUE1_
      L2 = L1
      L1 = L1.set
      L3 = "firewall"
      L4 = A0[".name"]
      L5 = "target"
      L6 = "DROP"
      L1(L2, L3, L4, L5, L6)
    else
      L1 = _UPVALUE0_
      if L1 == 0 then
        L1 = _UPVALUE1_
        L2 = L1
        L1 = L1.set
        L3 = "firewall"
        L4 = A0[".name"]
        L5 = "target"
        L6 = "ACCEPT"
        L1(L2, L3, L4, L5, L6)
      else
        L1 = _UPVALUE2_
        L1 = L1.log
        L2 = 1
        L3 = "ignorewanping="
        L4 = _UPVALUE0_
        L3 = L3 .. L4
        L1(L2, L3)
      end
    end
    ::lbl_36::
  end
  L3(L4, L5, L6, L7)
  L4 = L2
  L3 = L2.commit
  L5 = "firewall"
  L3(L4, L5)
end
setWANPingFirewallFw = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  if A0 == 1 then
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "ignore_wan_ping"
    L8 = "1"
    L3(L4, L5, L6, L7, L8)
  elseif A0 == 0 then
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "ignore_wan_ping"
    L8 = "0"
    L3(L4, L5, L6, L7, L8)
  else
    L3 = L1.log
    L4 = 1
    L5 = "ignorewanping="
    L6 = A0
    L5 = L5 .. L6
    L3(L4, L5)
  end
  L4 = L2
  L3 = L2.commit
  L5 = "firewall"
  L3(L4, L5)
  L3 = setWANPingFirewallFw
  L4 = A0
  L3(L4)
end
setWANPingFirewall = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  if A0 == 1 then
    L2 = tonumber
    L4 = L1
    L3 = L1.get
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "ignore_wan_ping"
    L3 = L3(L4, L5, L6, L7)
    L3 = L3 or L3
    L2 = L2(L3)
    L3 = tonumber
    L5 = L1
    L4 = L1.get
    L6 = "firewall"
    L7 = "@defaults[0]"
    L8 = "dos_enable"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    L3 = L3(L4)
    L4 = setWANPingFirewallFw
    L5 = L2
    L4(L5)
    L4 = setDoSFirewallFw
    L5 = L3
    L4(L5)
  else
    L2 = setWANPingFirewallFw
    L3 = A0
    L2(L3)
    L2 = setDoSFirewallFw
    L3 = A0
    L2(L3)
  end
  L3 = L1
  L2 = L1.set
  L4 = "firewall"
  L5 = "@defaults[0]"
  L6 = "fw_enable"
  L7 = A0
  L2(L3, L4, L5, L6, L7)
  L3 = L1
  L2 = L1.commit
  L4 = "firewall"
  L2(L3, L4)
end
setFirewallEnable = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  if A0 == 1 then
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "spi_rule"
    L8 = "1"
    L3(L4, L5, L6, L7, L8)
  elseif A0 == 0 then
    L4 = L2
    L3 = L2.set
    L5 = "firewall"
    L6 = "@defaults[0]"
    L7 = "spi_rule"
    L8 = "0"
    L3(L4, L5, L6, L7, L8)
  else
    L3 = L1.log
    L4 = 1
    L5 = "spi="
    L6 = A0
    L5 = L5 .. L6
    L3(L4, L5)
  end
  L4 = L2
  L3 = L2.commit
  L5 = "firewall"
  L3(L4, L5)
end
setSPIFirewall = L4
function L4(A0)
  local L1, L2
  if A0 then
    L1 = type
    L2 = A0
    L1 = L1(L2)
    if L1 == "number" then
      if A0 == 1 then
        L1 = "tcp"
        return L1
      elseif A0 == 2 then
        L1 = "udp"
        return L1
      elseif A0 == 3 then
        L1 = "tcpudp"
        return L1
      else
        L1 = "tcp"
        return L1
      end
    end
  end
  L1 = nil
  return L1
end
numberToProto = L4
function L4()
  local L0, L1, L2
  L0 = " /etc/init.d/firewall reload; "
  L1 = _UPVALUE0_
  L1 = L1.forkExec
  L2 = L0
  L1(L2)
end
reload = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.XQFeatures"
  L1 = L1(L2)
  L1 = L1.FEATURES
  L3 = L0
  L2 = L0.get
  L4 = "upnpd"
  L5 = "config"
  L6 = "enable_upnp"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = " /etc/init.d/firewall restart; "
  L4 = L1.system
  L4 = L4.multiwan
  if L4 then
    L4 = L1.system
    L4 = L4.multiwan
    if L4 == "1" then
      L4 = " /usr/sbin/mwan3 restart; "
      L6 = L0
      L5 = L0.get
      L7 = "mwan3"
      L8 = "globals"
      L9 = "enabled"
      L5 = L5(L6, L7, L8, L9)
      L5 = L5 or L5
      if L5 == "1" then
        L6 = L3
        L7 = L4
        L3 = L6 .. L7
      end
    end
  end
  if L2 == "1" then
    L4 = L3
    L5 = _UPVALUE0_
    L5 = L5.UPNP_DISABLE
    L6 = _UPVALUE0_
    L6 = L6.UPNP_ENABLE
    L3 = L4 .. L5 .. L6
  end
  L4 = _UPVALUE1_
  L4 = L4.forkExec
  L5 = L3
  L4(L5)
end
restart = L4
function L4()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.getDMZInfo
  return L0()
end
getDMZInfo = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = _UPVALUE0_
  L3 = L3.setDMZ
  L4 = A0
  L5 = A1
  L6 = A2
  return L3(L4, L5, L6)
end
setDMZ = L4
function L4(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.unsetDMZ
  L2 = A0
  L1(L2)
end
unsetDMZ = L4
function L4(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.dmzReload
  L2 = A0
  L1(L2)
end
dmzReload = L4
function L4(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2.hookLanIPChangeEvent
  L3 = A0
  L4 = A1
  L2(L3, L4)
end
hookDMZLanIPChangeEvent = L4
function L4()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.VSInfo
  return L0()
end
VSInfo = L4
function L4(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12
  L6 = _UPVALUE0_
  L6 = L6.setVSRules
  L7 = A0
  L8 = A1
  L9 = A2
  L10 = A3
  L11 = A4
  L12 = A5
  return L6(L7, L8, L9, L10, L11, L12)
end
setVSRules = L4
function L4(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = _UPVALUE0_
  L5 = L5.setVSRangeRules
  L6 = A0
  L7 = A1
  L8 = A2
  L9 = A3
  L10 = A4
  return L5(L6, L7, L8, L9, L10)
end
setVSRangeRules = L4
function L4(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12
  L6 = _UPVALUE0_
  L6 = L6.deleteVSRule
  L7 = A0
  L8 = A1
  L9 = A2
  L10 = A3
  L11 = A4
  L12 = A5
  return L6(L7, L8, L9, L10, L11, L12)
end
deleteVSRule = L4
function L4()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.PTInfo
  return L0()
end
PTInfo = L4
function L4(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = _UPVALUE0_
  L5 = L5.setPTRules
  L6 = A0
  L7 = A1
  L8 = A2
  L9 = A3
  L10 = A4
  return L5(L6, L7, L8, L9, L10)
end
setPTRules = L4
function L4(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = _UPVALUE0_
  L5 = L5.trigger_add
  L6 = A0
  L7 = A1
  L8 = A2
  L9 = A3
  L10 = A4
  L5(L6, L7, L8, L9, L10)
end
trigger_add = L4
function L4(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = _UPVALUE0_
  L5 = L5.deletePTRule
  L6 = A0
  L7 = A1
  L8 = A2
  L9 = A3
  L10 = A4
  return L5(L6, L7, L8, L9, L10)
end
deletePTRule = L4
function L4(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = _UPVALUE0_
  L5 = L5.trigger_del
  L6 = A0
  L7 = A1
  L8 = A2
  L9 = A3
  L10 = A4
  L5(L6, L7, L8, L9, L10)
end
trigger_del = L4
function L4(A0, A1, A2, A3, A4, A5, A6, A7)
  local L8, L9, L10, L11, L12, L13, L14, L15, L16
  L8 = _UPVALUE0_
  L8 = L8.setALGFirewall
  L9 = A0
  L10 = A1
  L11 = A2
  L12 = A3
  L13 = A4
  L14 = A5
  L15 = A6
  L16 = A7
  return L8(L9, L10, L11, L12, L13, L14, L15, L16)
end
setALGFirewall = L4
function L4()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.ALGInfo
  return L0()
end
ALGInfo = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = {}
  L4 = {}
  L6 = L2
  L5 = L2.get
  L7 = "macfilter"
  L8 = A0
  L9 = "mode"
  L5 = L5(L6, L7, L8, L9)
  L7 = L2
  L6 = L2.get
  L8 = "macfilter"
  L9 = A0
  L10 = "enable"
  L6 = L6(L7, L8, L9, L10)
  if L5 == nil or L6 == "0" then
    return L3
  end
  L8 = L2
  L7 = L2.foreach
  L9 = "macfilter"
  L10 = L5
  function L11(A0)
    local L1, L2, L3, L4, L5
    L1 = string
    L1 = L1.gsub
    L2 = A0[".name"]
    L3 = "_"
    L4 = ":"
    L1 = L1(L2, L3, L4)
    L2 = string
    L2 = L2.sub
    L3 = L1
    L4 = 1
    L5 = 17
    L2 = L2(L3, L4, L5)
    L1 = L2
    L2 = string
    L2 = L2.match
    L3 = _UPVALUE0_
    L4 = "black"
    L2 = L2(L3, L4)
    if L2 then
      L3 = _UPVALUE1_
      L4 = _UPVALUE2_
      L3[L4] = false
    else
      L3 = _UPVALUE1_
      L4 = _UPVALUE2_
      L3[L4] = true
    end
    L3 = _UPVALUE1_
    L4 = string
    L4 = L4.upper
    L5 = L1
    L4 = L4(L5)
    L3.mac = L4
    L3 = table
    L3 = L3.insert
    L4 = _UPVALUE3_
    L5 = _UPVALUE1_
    L3(L4, L5)
    L3 = {}
    _UPVALUE1_ = L3
  end
  L7(L8, L9, L10, L11)
  return L3
end
getMacfilterInfoList = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = {}
  if A0 then
    L3 = L4
    for L7, L8 in L4, L5, L6 do
      L9 = L8.mac
      L2[L9] = L8
    end
  else
    L7 = "filter"
    function L8(A0)
      local L1, L2, L3, L4, L5, L6, L7
      if L1 == "filter" then
        _UPVALUE0_ = L1
        for L4, L5 in L1, L2, L3 do
          L6 = _UPVALUE1_
          L7 = L5.mac
          L6[L7] = L5
        end
      end
    end
    L4(L5, L6, L7, L8)
  end
  return L2
end
getMacfilterInfoDict = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.foreach
  L4 = "macfilter"
  L5 = "black"
  function L6(A0)
    local L1, L2, L3, L4, L5
    L1 = string
    L1 = L1.gsub
    L2 = A0[".name"]
    L3 = "_"
    L4 = ":"
    L1 = L1(L2, L3, L4)
    L2 = string
    L2 = L2.sub
    L3 = L1
    L4 = 1
    L5 = 17
    L2 = L2(L3, L4, L5)
    L1 = L2
    L2 = {}
    L2.mac = L1
    L3 = A0.name
    if L3 == nil then
      L3 = ""
      if L3 then
        goto lbl_23
      end
    end
    L3 = A0.name
    ::lbl_23::
    L2.rulename = L3
    L3 = A0.web_del
    if L3 == "0" then
      L3 = "0"
      if L3 then
        goto lbl_31
      end
    end
    L3 = "1"
    ::lbl_31::
    L2.web_del = L3
    L3 = table
    L3 = L3.insert
    L4 = _UPVALUE0_
    L5 = L2
    L3(L4, L5)
  end
  L2(L3, L4, L5, L6)
  return L1
end
getBlackMacfilterInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.foreach
  L4 = "macfilter"
  L5 = "white"
  function L6(A0)
    local L1, L2, L3, L4, L5
    L1 = string
    L1 = L1.gsub
    L2 = A0[".name"]
    L3 = "_"
    L4 = ":"
    L1 = L1(L2, L3, L4)
    L2 = string
    L2 = L2.sub
    L3 = L1
    L4 = 1
    L5 = 17
    L2 = L2(L3, L4, L5)
    L1 = L2
    L2 = A0.ismesh
    if L2 ~= "1" then
      L2 = {}
      L2.mac = L1
      L3 = A0.name
      if L3 == nil then
        L3 = ""
        if L3 then
          goto lbl_26
        end
      end
      L3 = A0.name
      ::lbl_26::
      L2.rulename = L3
      L3 = A0.web_del
      if L3 == "0" then
        L3 = "0"
        if L3 then
          goto lbl_34
        end
      end
      L3 = "1"
      ::lbl_34::
      L2.web_del = L3
      L3 = table
      L3 = L3.insert
      L4 = _UPVALUE0_
      L5 = L2
      L3(L4, L5)
    end
  end
  L2(L3, L4, L5, L6)
  return L1
end
getWhiteMacfilterInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = {}
  L3 = {}
  L5 = L0
  L4 = L0.get
  L6 = "macfilter"
  L7 = "wan"
  L8 = "enable"
  L4 = L4(L5, L6, L7, L8)
  L1.wanenable = L4
  L5 = L0
  L4 = L0.get
  L6 = "macfilter"
  L7 = "wan"
  L8 = "mode"
  L4 = L4(L5, L6, L7, L8)
  L1.wan = L4
  L4 = getWhiteMacfilterInfo
  L4 = L4()
  L3 = L4
  L4 = getBlackMacfilterInfo
  L4 = L4()
  L2 = L4
  L4 = {}
  L4.mode = L1
  L4.blacklist = L2
  L4.whitelist = L3
  return L4
end
getMacfilterInfo = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = require
  L5 = "xiaoqiang.XQLog"
  L4 = L4(L5)
  L5 = nil
  L6 = 0
  if A1 == nil or A0 == nil or A2 == nil then
    L7 = 1523
    return L7
  end
  if A1 == "0" then
    L7 = "white"
    if L7 then
      goto lbl_25
    end
  end
  L7 = "black"
  ::lbl_25::
  L9 = L3
  L8 = L3.get
  L10 = "macfilter"
  L11 = A2
  L12 = "enable"
  L8 = L8(L9, L10, L11, L12)
  oldenable = L8
  L9 = L3
  L8 = L3.get
  L10 = "macfilter"
  L11 = A2
  L12 = "mode"
  L8 = L8(L9, L10, L11, L12)
  oldmode = L8
  L8 = oldenable
  if L8 == A0 then
    L8 = oldmode
    if L8 == L7 then
      L8 = 0
      return L8
    end
  end
  L9 = L3
  L8 = L3.set
  L10 = "macfilter"
  L11 = A2
  L12 = "enable"
  L13 = A0
  L8(L9, L10, L11, L12, L13)
  L9 = L3
  L8 = L3.set
  L10 = "macfilter"
  L11 = A2
  L12 = "mode"
  L13 = L7
  L8(L9, L10, L11, L12, L13)
  L9 = L3
  L8 = L3.commit
  L10 = "macfilter"
  L8(L9, L10)
  L8 = L4.log
  L9 = 4
  L10 = "uci commit macfilter enable="
  L11 = A0
  L12 = " filter="
  L13 = A2
  L14 = " mode="
  L15 = L7
  L10 = L10 .. L11 .. L12 .. L13 .. L14 .. L15
  L8(L9, L10)
  L8 = "/usr/sbin/macfilter enable "
  L9 = A0
  L10 = " "
  L11 = L7
  L12 = " "
  L13 = A2
  L5 = L8 .. L9 .. L10 .. L11 .. L12 .. L13
  L8 = L4.log
  L9 = 4
  L10 = "set macfilter enable: "
  L11 = L5
  L10 = L10 .. L11
  L8(L9, L10)
  if L5 then
    L8 = os
    L8 = L8.execute
    L9 = L5
    L8 = L8(L9)
    L6 = L8
  end
  return L6
end
setmacfilterenablemode = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L3 = require
  L4 = "uci"
  L3 = L3(L4)
  L4 = L3.cursor
  L4 = L4()
  L5 = A0
  L6 = nil
  L7 = require
  L8 = "luci.util"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.XQLog"
  L8 = L8(L9)
  L9 = "0"
  L10 = L8.log
  L11 = 6
  L12 = "@@@ section "
  L13 = A0
  L14 = " mac "
  L15 = A2
  L12 = L12 .. L13 .. L14 .. L15
  L10(L11, L12)
  if A1 then
    L10 = string
    L10 = L10.sub
    L11 = A1
    L12 = 1
    L13 = 6
    L10 = L10(L11, L12, L13)
    if L10 == "tr069_" then
      L10 = L7.split
      L11 = A1
      L12 = "_"
      L10 = L10(L11, L12)
      L10 = L10[3]
      L9 = L10 or L9
      if not L10 then
        L9 = "0"
      end
    end
  end
  L11 = L4
  L10 = L4.foreach
  L12 = "macfilter"
  L13 = A0
  function L14(A0)
    local L1, L2, L3, L4, L5
    L2 = A0[".type"]
    L3 = _UPVALUE0_
    if L2 == L3 then
      L2 = string
      L2 = L2.gsub
      L3 = A0[".name"]
      L4 = "_"
      L5 = ":"
      L2 = L2(L3, L4, L5)
      L1 = L2
      L2 = _UPVALUE1_
      L2 = L2.split
      L3 = A0[".name"]
      L4 = "_"
      L2 = L2(L3, L4)
      L2 = L2[8]
      L2 = L2 or L2
      L3 = _UPVALUE2_
      if L3 ~= L1 then
        L3 = _UPVALUE3_
        if L3 ~= L2 then
          goto lbl_38
        end
      end
      L3 = A0[".name"]
      _UPVALUE4_ = L3
      L3 = _UPVALUE5_
      if L3 then
        L3 = _UPVALUE5_
        if L3 ~= "" then
          L3 = _UPVALUE5_
          A0.name = L3
          return
        end
      end
    end
    ::lbl_38::
  end
  L10(L11, L12, L13, L14)
  return L6
end
checkMacfiltertable = L4
function L4(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = require
  L6 = "xiaoqiang.XQLog"
  L5 = L5(L6)
  L6 = require
  L7 = "luci.cbi.datatypes"
  L6 = L6(L7)
  if A2 == "0" then
    L7 = "add"
    if L7 then
      goto lbl_18
    end
  end
  L7 = "del"
  ::lbl_18::
  L9 = L4
  L8 = L4.get
  L10 = "macfilter"
  L11 = "wan"
  L12 = "mode"
  L8 = L8(L9, L10, L11, L12)
  L10 = L4
  L9 = L4.get
  L11 = "macfilter"
  L12 = "wan"
  L13 = L8
  L14 = "num"
  L13 = L13 .. L14
  L9 = L9(L10, L11, L12, L13)
  L10 = tonumber
  L11 = L9
  L10 = L10(L11)
  L9 = L10
  if A3 ~= "" and A3 == "1" then
    if L8 == "white" then
      L7 = "add"
    else
      L7 = "del"
    end
  end
  if A3 ~= "" and A3 == "0" then
    if L8 == "black" then
      L7 = "add"
    else
      L7 = "del"
    end
  end
  L10 = _UPVALUE0_
  L10 = L10.isStrNil
  L11 = A0
  L10 = L10(L11)
  if not L10 then
    L10 = L6.macaddr
    L11 = A0
    L10 = L10(L11)
    if L10 then
      goto lbl_65
    end
  end
  L10 = false
  do return L10 end
  ::lbl_65::
  L10 = checkMacfiltertable
  L11 = L8
  L12 = A1
  L13 = A0
  L10 = L10(L11, L12, L13)
  if L10 == nil and L7 == "del" then
    L11 = L5.log
    L12 = 6
    L13 = "del mac fail, "
    L14 = A0
    L15 = " not found"
    L13 = L13 .. L14 .. L15
    L11(L12, L13)
    L11 = false
    return L11
  end
  if L10 ~= nil and L7 == "add" then
    L11 = L5.log
    L12 = 6
    L13 = "update macfilter "
    L14 = A0
    L15 = " name "
    L16 = A1
    L13 = L13 .. L14 .. L15 .. L16
    L11(L12, L13)
    L11 = true
    return L11
  end
  if L10 == nil and L7 == "add" then
    L11 = string
    L11 = L11.gsub
    L12 = A0
    L13 = "%:"
    L14 = "_"
    L11 = L11(L12, L13, L14)
    if L8 == "black" then
      L12 = "white"
      if L12 then
        goto lbl_113
      end
    end
    L12 = "black"
    ::lbl_113::
    L13 = tonumber
    L15 = L4
    L14 = L4.get
    L16 = "macfilter"
    L17 = "wan"
    L18 = L12
    L19 = "num"
    L18 = L18 .. L19
    L14 = L14(L15, L16, L17, L18)
    L14 = L14 or L14
    L13 = L13(L14)
    L15 = L4
    L14 = L4.get_all
    L16 = "macfilter"
    L17 = L11
    L14 = L14(L15, L16, L17)
    if L14 then
      L15 = L14[".type"]
      if L15 == L12 and 0 < L13 then
        L16 = L4
        L15 = L4.set
        L17 = "macfilter"
        L18 = "wan"
        L19 = L12
        L20 = "num"
        L19 = L19 .. L20
        L20 = L13 - 1
        L15(L16, L17, L18, L19, L20)
      end
    end
    L15 = L5.log
    L16 = 6
    L17 = "add macfilter rule mac "
    L18 = A0
    L17 = L17 .. L18
    L15(L16, L17)
    L16 = L4
    L15 = L4.set
    L17 = "macfilter"
    L18 = L11
    L19 = L8
    L15(L16, L17, L18, L19)
    if A1 and A1 ~= nil then
      L16 = L4
      L15 = L4.set
      L17 = "macfilter"
      L18 = L11
      L19 = "name"
      L20 = A1
      L15(L16, L17, L18, L19, L20)
    end
    L9 = L9 + 1
    L16 = L4
    L15 = L4.set
    L17 = "macfilter"
    L18 = "wan"
    L19 = L8
    L20 = "num"
    L19 = L19 .. L20
    L20 = L9
    L15(L16, L17, L18, L19, L20)
    L16 = L4
    L15 = L4.commit
    L17 = "macfilter"
    L15(L16, L17)
  end
  if L10 ~= nil and L7 == "del" then
    L12 = L4
    L11 = L4.delete
    L13 = "macfilter"
    L14 = L10
    L11 = L11(L12, L13, L14)
    if L11 then
      L9 = L9 - 1
      L12 = L4
      L11 = L4.set
      L13 = "macfilter"
      L14 = "wan"
      L15 = L8
      L16 = "num"
      L15 = L15 .. L16
      L16 = L9
      L11(L12, L13, L14, L15, L16)
      L12 = L4
      L11 = L4.commit
      L13 = "macfilter"
      L11(L12, L13)
      L11 = L5.log
      L12 = 6
      L13 = "del macfilter "
      L14 = L10
      L13 = L13 .. L14
      L11(L12, L13)
    end
  end
  L11 = "/usr/sbin/macfilter "
  L12 = L7
  L13 = " "
  L14 = L8
  L15 = " "
  L16 = A0
  L11 = L11 .. L12 .. L13 .. L14 .. L15 .. L16
  if A1 then
    L12 = L11
    L13 = " rulename="
    L14 = A1
    L11 = L12 .. L13 .. L14
  end
  L12 = os
  L12 = L12.execute
  L13 = L11
  L12 = L12(L13)
  if L12 == 0 then
    L12 = true
    return L12
  end
  L12 = false
  return L12
end
setMacFilter = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.foreach
  L4 = "ipfilter"
  L5 = "black_v4"
  function L6(A0)
    local L1, L2, L3, L4, L5
    L1 = string
    L1 = L1.gsub
    L2 = A0[".name"]
    L3 = "_"
    L4 = "."
    L1 = L1(L2, L3, L4)
    L2 = {}
    L2.addr = L1
    L3 = A0.name
    if L3 == nil then
      L3 = ""
      if L3 then
        goto lbl_16
      end
    end
    L3 = A0.name
    ::lbl_16::
    L2.rulename = L3
    L3 = table
    L3 = L3.insert
    L4 = _UPVALUE0_
    L5 = L2
    L3(L4, L5)
  end
  L2(L3, L4, L5, L6)
  L3 = L0
  L2 = L0.foreach
  L4 = "ipfilter"
  L5 = "black_v6"
  function L6(A0)
    local L1, L2, L3, L4, L5
    L1 = string
    L1 = L1.gsub
    L2 = A0[".name"]
    L3 = "_"
    L4 = ":"
    L1 = L1(L2, L3, L4)
    L2 = {}
    L2.addr = L1
    L3 = A0.name
    if L3 == nil then
      L3 = ""
      if L3 then
        goto lbl_16
      end
    end
    L3 = A0.name
    ::lbl_16::
    L2.rulename = L3
    L3 = table
    L3 = L3.insert
    L4 = _UPVALUE0_
    L5 = L2
    L3(L4, L5)
  end
  L2(L3, L4, L5, L6)
  return L1
end
getBlackIpfilterInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.foreach
  L4 = "ipfilter"
  L5 = "white_v4"
  function L6(A0)
    local L1, L2, L3, L4, L5
    L1 = string
    L1 = L1.gsub
    L2 = A0[".name"]
    L3 = "_"
    L4 = "."
    L1 = L1(L2, L3, L4)
    L2 = {}
    L2.addr = L1
    L3 = A0.name
    if L3 == nil then
      L3 = ""
      if L3 then
        goto lbl_16
      end
    end
    L3 = A0.name
    ::lbl_16::
    L2.rulename = L3
    L3 = table
    L3 = L3.insert
    L4 = _UPVALUE0_
    L5 = L2
    L3(L4, L5)
  end
  L2(L3, L4, L5, L6)
  L3 = L0
  L2 = L0.foreach
  L4 = "ipfilter"
  L5 = "white_v6"
  function L6(A0)
    local L1, L2, L3, L4, L5
    L1 = string
    L1 = L1.gsub
    L2 = A0[".name"]
    L3 = "_"
    L4 = ":"
    L1 = L1(L2, L3, L4)
    L2 = {}
    L2.addr = L1
    L3 = A0.name
    if L3 == nil then
      L3 = ""
      if L3 then
        goto lbl_16
      end
    end
    L3 = A0.name
    ::lbl_16::
    L2.rulename = L3
    L3 = table
    L3 = L3.insert
    L4 = _UPVALUE0_
    L5 = L2
    L3(L4, L5)
  end
  L2(L3, L4, L5, L6)
  return L1
end
getWhiteIpfilterInfo = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = {}
  L3 = {}
  L5 = L0
  L4 = L0.get
  L6 = "ipfilter"
  L7 = "wan"
  L8 = "enable"
  L4 = L4(L5, L6, L7, L8)
  L1.wanenable = L4
  L5 = L0
  L4 = L0.get
  L6 = "ipfilter"
  L7 = "wan"
  L8 = "mode"
  L4 = L4(L5, L6, L7, L8)
  L1.wan = L4
  L4 = getWhiteIpfilterInfo
  L4 = L4()
  L3 = L4
  L4 = getBlackIpfilterInfo
  L4 = L4()
  L2 = L4
  L4 = {}
  L4.mode = L1
  L4.blacklist = L2
  L4.whitelist = L3
  return L4
end
getIpfilterInfo = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L4 = require
  L5 = "xiaoqiang.XQLog"
  L4 = L4(L5)
  L5 = nil
  L6 = 0
  if A1 == nil or A0 == nil or A2 == nil then
    L7 = 1523
    return L7
  end
  if A1 == "0" then
    L7 = "white"
    if L7 then
      goto lbl_25
    end
  end
  L7 = "black"
  ::lbl_25::
  L9 = L3
  L8 = L3.get
  L10 = "ipfilter"
  L11 = A2
  L12 = "enable"
  L8 = L8(L9, L10, L11, L12)
  oldenable = L8
  L9 = L3
  L8 = L3.get
  L10 = "ipfilter"
  L11 = A2
  L12 = "mode"
  L8 = L8(L9, L10, L11, L12)
  oldmode = L8
  L8 = oldenable
  if L8 == A0 then
    L8 = oldmode
    if L8 == L7 then
      L8 = 0
      return L8
    end
  end
  L9 = L3
  L8 = L3.set
  L10 = "ipfilter"
  L11 = A2
  L12 = "enable"
  L13 = A0
  L8(L9, L10, L11, L12, L13)
  L9 = L3
  L8 = L3.set
  L10 = "ipfilter"
  L11 = A2
  L12 = "mode"
  L13 = L7
  L8(L9, L10, L11, L12, L13)
  L9 = L3
  L8 = L3.commit
  L10 = "ipfilter"
  L8(L9, L10)
  L8 = L4.log
  L9 = 4
  L10 = "uci commit ipfilter enable="
  L11 = A0
  L12 = " filter="
  L13 = A2
  L14 = " mode="
  L15 = L7
  L10 = L10 .. L11 .. L12 .. L13 .. L14 .. L15
  L8(L9, L10)
  L8 = "/usr/sbin/ipfilter enable "
  L9 = A0
  L10 = " "
  L11 = L7
  L12 = " "
  L13 = A2
  L5 = L8 .. L9 .. L10 .. L11 .. L12 .. L13
  L8 = L4.log
  L9 = 4
  L10 = "set ipfilter enable: "
  L11 = L5
  L10 = L10 .. L11
  L8(L9, L10)
  if L5 then
    L8 = os
    L8 = L8.execute
    L9 = L5
    L8 = L8(L9)
    L6 = L8
  end
  return L6
end
setipfilterenablemode = L4
function L4(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L5 = require
  L6 = "uci"
  L5 = L5(L6)
  L6 = L5.cursor
  L6 = L6()
  L7 = A1
  L8 = A4
  L7 = L7 .. L8
  L8 = nil
  L9 = require
  L10 = "xiaoqiang.XQLog"
  L9 = L9(L10)
  L10 = L9.log
  L11 = 6
  L12 = "@@@ section "
  L13 = A0
  L14 = " ipaddr "
  L15 = A3
  L16 = " postfix "
  L17 = A4
  L12 = L12 .. L13 .. L14 .. L15 .. L16 .. L17
  L10(L11, L12)
  L11 = L6
  L10 = L6.foreach
  L12 = "ipfilter"
  L13 = A0
  function L14(A0)
    local L1, L2, L3, L4, L5
    L2 = A0[".type"]
    L3 = _UPVALUE0_
    if L2 == L3 then
      L2 = _UPVALUE1_
      if L2 == "_v6" then
        L2 = string
        L2 = L2.gsub
        L3 = A0[".name"]
        L4 = "_"
        L5 = "%:"
        L2 = L2(L3, L4, L5)
        L1 = L2
      else
        L2 = string
        L2 = L2.gsub
        L3 = A0[".name"]
        L4 = "_"
        L5 = "%."
        L2 = L2(L3, L4, L5)
        L1 = L2
      end
      L2 = _UPVALUE2_
      if L2 == L1 then
        L2 = A0[".name"]
        _UPVALUE3_ = L2
        L2 = _UPVALUE4_
        if L2 then
          L2 = _UPVALUE4_
          if L2 ~= "" then
            L2 = _UPVALUE4_
            A0.name = L2
            return
          end
        end
      end
    end
  end
  L10(L11, L12, L13, L14)
  return L8
end
checkIpfiltertable = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  if A0 then
    L2 = L1.port
    L3 = A0
    L2 = L2(L3)
    if L2 then
      L2 = true
      return L2
    else
      L3 = A0
      L2 = A0.match
      L4 = "(%d+)-(%d+)"
      L2, L3 = L2(L3, L4)
      if L2 then
        L4 = L1.port
        L5 = L2
        L4 = L4(L5)
        if L4 then
          L4 = L1.port
          L5 = L3
          L4 = L4(L5)
          if L4 then
            L4 = tonumber
            L5 = L2
            L4 = L4(L5)
            L5 = tonumber
            L6 = L3
            L5 = L5(L6)
            if L4 < L5 then
              L4 = true
              return L4
            end
          end
        end
      end
    end
  end
  L2 = false
  return L2
end
checkPort = L4
function L4(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L6 = uci
  L6 = L6.cursor
  L6 = L6()
  L7 = require
  L8 = "xiaoqiang.XQLog"
  L7 = L7(L8)
  L8 = require
  L9 = "luci.cbi.datatypes"
  L8 = L8(L9)
  if A5 == "0" then
    L9 = "set"
    if L9 then
      goto lbl_16
    end
  end
  L9 = "del"
  ::lbl_16::
  if A3 == "0" then
    L10 = "black"
    if L10 then
      goto lbl_22
    end
  end
  L10 = "white"
  ::lbl_22::
  L12 = L6
  L11 = L6.get
  L13 = "ipfilter"
  L14 = "wan"
  L15 = L10
  L16 = "num"
  L15 = L15 .. L16
  L11 = L11(L12, L13, L14, L15)
  L12 = tonumber
  L13 = L11
  L12 = L12(L13)
  L11 = L12
  L12 = checkIpfiltertable
  L13 = L10
  L14 = "_v4"
  L13 = L13 .. L14
  L14 = L10
  L15 = A4
  L16 = A1
  L17 = "_v4"
  L12 = L12(L13, L14, L15, L16, L17)
  if L12 == nil and L9 == "del" then
    L13 = L7.log
    L14 = 6
    L15 = "del ip fail, "
    L16 = A1
    L17 = " not found"
    L15 = L15 .. L16 .. L17
    L13(L14, L15)
    L13 = false
    return L13
  end
  if L12 ~= nil and L9 == "set" then
    L13 = L7.log
    L14 = 6
    L15 = "update ipfilter "
    L16 = L12
    L17 = " name "
    L18 = A4
    L15 = L15 .. L16 .. L17 .. L18
    L13(L14, L15)
    L13 = true
    return L13
  end
  if L12 == nil and L9 == "set" then
    L13 = string
    L13 = L13.gsub
    L14 = A1
    L15 = "%."
    L16 = "_"
    L13 = L13(L14, L15, L16)
    if L10 == "black" then
      L14 = "white"
      if L14 then
        goto lbl_85
      end
    end
    L14 = "black"
    ::lbl_85::
    L15 = tonumber
    L17 = L6
    L16 = L6.get
    L18 = "ipfilter"
    L19 = "wan"
    L20 = L14
    L21 = "num"
    L20 = L20 .. L21
    L16 = L16(L17, L18, L19, L20)
    L16 = L16 or L16
    L15 = L15(L16)
    L17 = L6
    L16 = L6.get_all
    L18 = "ipfilter"
    L19 = L13
    L16 = L16(L17, L18, L19)
    if L16 then
      L17 = L16[".type"]
      L18 = L14
      L19 = "_v4"
      L18 = L18 .. L19
      if L17 == L18 and 0 < L15 then
        L18 = L6
        L17 = L6.set
        L19 = "ipfilter"
        L20 = "wan"
        L21 = L14
        L22 = "num"
        L21 = L21 .. L22
        L22 = L15 - 1
        L17(L18, L19, L20, L21, L22)
      end
    end
    L17 = L7.log
    L18 = 6
    L19 = "add ipfilter rule ip "
    L20 = A1
    L19 = L19 .. L20
    L17(L18, L19)
    L18 = L6
    L17 = L6.set
    L19 = "ipfilter"
    L20 = L13
    L21 = L10
    L22 = "_v4"
    L21 = L21 .. L22
    L17(L18, L19, L20, L21)
    if A4 then
      L18 = L6
      L17 = L6.set
      L19 = "ipfilter"
      L20 = L13
      L21 = "name"
      L22 = A4
      L17(L18, L19, L20, L21, L22)
    end
    if A2 then
      L18 = L6
      L17 = L6.set
      L19 = "ipfilter"
      L20 = L13
      L21 = "export"
      L22 = A2
      L17(L18, L19, L20, L21, L22)
    end
    if A0 then
      L18 = L6
      L17 = L6.set
      L19 = "ipfilter"
      L20 = L13
      L21 = "proto"
      L22 = A0
      L17(L18, L19, L20, L21, L22)
    end
    L11 = L11 + 1
    L18 = L6
    L17 = L6.set
    L19 = "ipfilter"
    L20 = "wan"
    L21 = L10
    L22 = "num"
    L21 = L21 .. L22
    L22 = L11
    L17(L18, L19, L20, L21, L22)
    L18 = L6
    L17 = L6.commit
    L19 = "ipfilter"
    L17(L18, L19)
  end
  if L12 ~= nil and L9 == "del" then
    L14 = L6
    L13 = L6.delete
    L15 = "ipfilter"
    L16 = L12
    L13(L14, L15, L16)
    L11 = L11 - 1
    L14 = L6
    L13 = L6.set
    L15 = "ipfilter"
    L16 = "wan"
    L17 = L10
    L18 = "num"
    L17 = L17 .. L18
    L18 = L11
    L13(L14, L15, L16, L17, L18)
    L14 = L6
    L13 = L6.commit
    L15 = "ipfilter"
    L13(L14, L15)
    L13 = L7.log
    L14 = 6
    L15 = "del ipfilter "
    L16 = L12
    L15 = L15 .. L16
    L13(L14, L15)
  end
  L13 = _UPVALUE0_
  L13 = L13.isStrNil
  L14 = A1
  L13 = L13(L14)
  if not L13 then
    L13 = L8.ipaddr
    L14 = A1
    L13 = L13(L14)
    if L13 then
      L13 = "/usr/sbin/ipfilter "
      L14 = L9
      L15 = " "
      L16 = L10
      L17 = " ipv4"
      L18 = " "
      L19 = A1
      L13 = L13 .. L14 .. L15 .. L16 .. L17 .. L18 .. L19
      if A0 then
        L14 = L13
        L15 = " "
        L16 = A0
        L13 = L14 .. L15 .. L16
      end
      if A2 then
        L14 = L13
        L15 = " "
        L16 = A2
        L13 = L14 .. L15 .. L16
      end
      L14 = os
      L14 = L14.execute
      L15 = L13
      L14 = L14(L15)
      if L14 == 0 then
        L14 = true
        return L14
      end
    end
  end
  L13 = false
  return L13
end
setIpFilter = L4
function L4(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L6 = uci
  L6 = L6.cursor
  L6 = L6()
  L7 = require
  L8 = "xiaoqiang.XQLog"
  L7 = L7(L8)
  L8 = require
  L9 = "luci.cbi.datatypes"
  L8 = L8(L9)
  if A5 == "0" then
    L9 = "set"
    if L9 then
      goto lbl_16
    end
  end
  L9 = "del"
  ::lbl_16::
  if A3 == "0" then
    L10 = "black"
    if L10 then
      goto lbl_22
    end
  end
  L10 = "white"
  ::lbl_22::
  L12 = L6
  L11 = L6.get
  L13 = "ipfilter"
  L14 = "wan"
  L15 = L10
  L16 = "num"
  L15 = L15 .. L16
  L11 = L11(L12, L13, L14, L15)
  L12 = tonumber
  L13 = L11
  L12 = L12(L13)
  L11 = L12
  L12 = checkIpfiltertable
  L13 = L10
  L14 = "_v6"
  L13 = L13 .. L14
  L14 = L10
  L15 = A4
  L16 = A1
  L17 = "_v6"
  L12 = L12(L13, L14, L15, L16, L17)
  if L12 == nil and L9 == "del" then
    L13 = L7.log
    L14 = 6
    L15 = "del ip fail, "
    L16 = A1
    L17 = " not found"
    L15 = L15 .. L16 .. L17
    L13(L14, L15)
    L13 = false
    return L13
  end
  if L12 ~= nil and L9 == "set" then
    L13 = L7.log
    L14 = 6
    L15 = "update ipfilter "
    L16 = L12
    L17 = " name "
    L18 = A4
    L15 = L15 .. L16 .. L17 .. L18
    L13(L14, L15)
    L13 = true
    return L13
  end
  if L12 == nil and L9 == "set" then
    L13 = string
    L13 = L13.gsub
    L14 = A1
    L15 = ":"
    L16 = "_"
    L13 = L13(L14, L15, L16)
    L14 = L7.log
    L15 = 6
    L16 = "add ipfilter rule ip "
    L17 = A1
    L16 = L16 .. L17
    L14(L15, L16)
    L15 = L6
    L14 = L6.set
    L16 = "ipfilter"
    L17 = L13
    L18 = L10
    L19 = "_v6"
    L18 = L18 .. L19
    L14(L15, L16, L17, L18)
    if A4 then
      L15 = L6
      L14 = L6.set
      L16 = "ipfilter"
      L17 = L13
      L18 = "name"
      L19 = A4
      L14(L15, L16, L17, L18, L19)
    end
    if A2 then
      L15 = L6
      L14 = L6.set
      L16 = "ipfilter"
      L17 = L13
      L18 = "export"
      L19 = A2
      L14(L15, L16, L17, L18, L19)
    end
    if A0 then
      L15 = L6
      L14 = L6.set
      L16 = "ipfilter"
      L17 = L13
      L18 = "proto"
      L19 = A0
      L14(L15, L16, L17, L18, L19)
    end
    L11 = L11 + 1
    L15 = L6
    L14 = L6.set
    L16 = "ipfilter"
    L17 = "wan"
    L18 = L10
    L19 = "num"
    L18 = L18 .. L19
    L19 = L11
    L14(L15, L16, L17, L18, L19)
    L15 = L6
    L14 = L6.commit
    L16 = "ipfilter"
    L14(L15, L16)
  end
  if L12 ~= nil and L9 == "del" then
    L14 = L6
    L13 = L6.delete
    L15 = "ipfilter"
    L16 = L12
    L13(L14, L15, L16)
    L11 = L11 - 1
    L14 = L6
    L13 = L6.set
    L15 = "ipfilter"
    L16 = "wan"
    L17 = L10
    L18 = "num"
    L17 = L17 .. L18
    L18 = L11
    L13(L14, L15, L16, L17, L18)
    L14 = L6
    L13 = L6.commit
    L15 = "ipfilter"
    L13(L14, L15)
    L13 = L7.log
    L14 = 6
    L15 = "del ipfilter "
    L16 = L12
    L15 = L15 .. L16
    L13(L14, L15)
  end
  L13 = _UPVALUE0_
  L13 = L13.isStrNil
  L14 = A1
  L13 = L13(L14)
  if not L13 then
    L13 = L8.ipaddr
    L14 = A1
    L13 = L13(L14)
    if L13 then
      L13 = "/usr/sbin/ipfilter "
      L14 = L9
      L15 = " "
      L16 = L10
      L17 = " ipv6 "
      L18 = A1
      L13 = L13 .. L14 .. L15 .. L16 .. L17 .. L18
      if A0 then
        L14 = L13
        L15 = " "
        L16 = A0
        L13 = L14 .. L15 .. L16
      end
      if A2 then
        L14 = L13
        L15 = " "
        L16 = A2
        L13 = L14 .. L15 .. L16
      end
      L14 = os
      L14 = L14.execute
      L15 = L13
      L14 = L14(L15)
      if L14 == 0 then
        L14 = true
        return L14
      end
    end
  end
  L13 = false
  return L13
end
setIpv6Filter = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = tonumber
  L4 = L1
  L3 = L1.get
  L5 = "ipfilter"
  L6 = "wan"
  L7 = "maxrulenum"
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2 = L2(L3, L4, L5, L6, L7)
  L2 = L2 or L2
  L3 = tostring
  L4 = A0
  L3 = L3(L4)
  if L3 == "0" then
    L4 = L1
    L3 = L1.get
    L5 = "ipfilter"
    L6 = "wan"
    L7 = "blacknum"
    L3 = L3(L4, L5, L6, L7)
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    L3 = L4
    if L2 <= L3 then
      L4 = 1
      return L4
    end
  else
    L3 = tostring
    L4 = A0
    L3 = L3(L4)
    if L3 == "1" then
      L4 = L1
      L3 = L1.get
      L5 = "ipfilter"
      L6 = "wan"
      L7 = "whitenum"
      L3 = L3(L4, L5, L6, L7)
      L4 = tonumber
      L5 = L3
      L4 = L4(L5)
      L3 = L4
      if L2 <= L3 then
        L4 = 1
        return L4
      end
    end
  end
  L3 = 0
  return L3
end
checkAddMaxIPNumItem = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = false
  L4 = #A0
  L5 = {}
  L6 = tonumber
  L10 = "pt"
  L11 = "maxrulenum"
  L10, L11, L12, L13, L14 = L7(L8, L9, L10, L11)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14)
  L6 = L6 or L6
  L10 = "porttrigger"
  function L11(A0)
    local L1, L2, L3
    L1 = A0.app_name
    if L1 == "Port Trigger" then
      L1 = table
      L1 = L1.insert
      L2 = _UPVALUE0_
      L3 = A0.tgport
      L1(L2, L3)
    end
  end
  L7(L8, L9, L10, L11)
  if 0 < L4 then
    L10 = ";"
    L10, L11, L12, L13, L14 = L8(L9, L10)
    for L10, L11 in L7, L8, L9 do
      L4 = #L11
      if 0 < L4 then
        L12 = table
        L12 = L12.insert
        L13 = L5
        L14 = L11
        L12(L13, L14)
      end
    end
  end
  if L6 < L7 then
    return L7
  end
  return L7
end
checkAddMaxPTNumItem = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = tonumber
  L5 = L1
  L4 = L1.get
  L6 = "firewall"
  L7 = "vs"
  L8 = "maxrulenum"
  L4, L5, L6, L7, L8 = L4(L5, L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8)
  L3 = L3 or L3
  L5 = L1
  L4 = L1.get
  L6 = "firewall"
  L7 = "vs"
  L8 = "rule_num"
  L4 = L4(L5, L6, L7, L8)
  L5 = tonumber
  L6 = L4
  L5 = L5(L6)
  L4 = L5
  if L3 < L4 then
    L5 = 1
    return L5
  end
  L5 = 0
  return L5
end
checkAddMaxVSNumItem = L4
function L4()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.portForwardInfo
  return L0()
end
portForwardInfo = L4
function L4(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.portForwards
  L2 = A0
  return L1(L2)
end
portForwards = L4
function L4(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = _UPVALUE0_
  L5 = L5.setPortForward
  L6 = A0
  L7 = A1
  L8 = A2
  L9 = A3
  L10 = A4
  return L5(L6, L7, L8, L9, L10)
end
setPortForward = L4
function L4(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = _UPVALUE0_
  L5 = L5.setRangePortForward
  L6 = A0
  L7 = A1
  L8 = A2
  L9 = A3
  L10 = A4
  return L5(L6, L7, L8, L9, L10)
end
setRangePortForward = L4
function L4()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.deleteAllPortForward
  return L0()
end
deleteAllPortForward = L4
function L4(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2.deletePortForward
  L3 = A0
  L4 = A1
  return L2(L3, L4)
end
deletePortForward = L4
function L4(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2.hookLanIPChangeEvent
  L3 = A0
  L4 = A1
  L2(L3, L4)
end
hookPortForwardLanIPChangeEvent = L4
