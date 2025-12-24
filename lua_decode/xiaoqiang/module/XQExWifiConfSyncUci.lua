local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26
L0 = module
L1 = "xiaoqiang.module.XQExWifiConfSyncUci"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.XQLog"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQFunction"
L1 = L1(L2)
L2 = require
L3 = "luci.model.uci"
L2 = L2(L3)
L2 = L2.cursor
L3 = "/tmp/extendwifi/etc/config/"
L2 = L2(L3)
L3 = require
L4 = "luci.model.uci"
L3 = L3(L4)
L3 = L3.cursor
L3 = L3()
L4 = "/tmp/extendwifi/"
L5 = "/etc/config/"
L6 = 0
L7 = 6
L8 = require
L9 = "luci.model.uci"
L8 = L8(L9)
L8 = L8.cursor
L8 = L8()
function L9(A0)
  local L1, L2
  if A0 then
    L1 = next
    L2 = A0
    L1 = L1(L2)
    if L1 ~= nil then
      goto lbl_10
    end
  end
  L1 = nil
  do return L1 end
  ::lbl_10::
  L1 = 0
  return L1
end
function L10()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "hardware"
  L4 = "wanspeed"
  L0 = L0(L1, L2, L3, L4)
  L1 = _UPVALUE1_
  L2 = L1
  L1 = L1.get
  L3 = "misc"
  L4 = "hardware"
  L5 = "wanspeed"
  L1 = L1(L2, L3, L4, L5)
  L0 = L0 or L0
  L1 = L1 or L1
  if L0 == L1 then
    L2 = 1
    return L2
  end
  L2 = 0
  return L2
end
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = "%((%d+)%)$"
  if not A0 then
    L2 = "(1)"
    return L2
  end
  L2 = string
  L2 = L2.find
  L3 = A0
  L4 = L1
  L2, L3, L4 = L2(L3, L4)
  if not (L2 and L3) or not L4 then
    L5 = A0
    L6 = "(1)"
    L5 = L5 .. L6
    return L5
  end
  L5 = tonumber
  L6 = L4
  L5 = L5(L6)
  L5 = L5 + 1
  L6 = string
  L6 = L6.gsub
  L7 = A0
  L8 = L1
  L9 = "("
  L10 = L5
  L11 = ")"
  L9 = L9 .. L10 .. L11
  return L6(L7, L8, L9)
end
function L12()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "merge finish"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.commit
  L2 = "account"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.commit
  L2 = "xiaoqiang"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.commit
  L2 = "network"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.commit
  L2 = "dhcp"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.commit
  L2 = "firewall"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.commit
  L2 = "macfilter"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.commit
  L2 = "system"
  L0(L1, L2)
  L0 = _UPVALUE3_
  L0 = L0.waitExec
  L1 = "ubus"
  L2 = "call"
  L3 = "service"
  L4 = "event"
  L5 = "{ \"type\": \"config.change\", \"data\": { \"package\": \"xiaoqiang\" }}"
  L0(L1, L2, L3, L4, L5)
  L0 = os
  L0 = L0.execute
  L1 = "nvram commit"
  L0(L1)
end
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "xiaoqiang config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.get
  L2 = "xiaoqiang"
  L3 = "common"
  L4 = "ROUTER_NAME"
  L0 = L0(L1, L2, L3, L4)
  L1 = _UPVALUE2_
  L2 = L1
  L1 = L1.get
  L3 = "xiaoqiang"
  L4 = "common"
  L5 = "ROUTER_NAME_PENDING"
  L1 = L1(L2, L3, L4, L5)
  L2 = _UPVALUE2_
  L3 = L2
  L2 = L2.get
  L4 = "xiaoqiang"
  L5 = "common"
  L6 = "ROUTER_LOCALE"
  L2 = L2(L3, L4, L5, L6)
  L3 = _UPVALUE2_
  L4 = L3
  L3 = L3.get
  L5 = "xiaoqiang"
  L6 = "common"
  L7 = "PRIVACY"
  L3 = L3(L4, L5, L6, L7)
  L4 = _UPVALUE2_
  L5 = L4
  L4 = L4.get
  L6 = "xiaoqiang"
  L7 = "common"
  L8 = "NETMODE"
  L4 = L4(L5, L6, L7, L8)
  L5 = _UPVALUE2_
  L6 = L5
  L5 = L5.get
  L7 = "xiaoqiang"
  L8 = "common"
  L9 = "BANDWIDTH"
  L5 = L5(L6, L7, L8, L9)
  L6 = _UPVALUE2_
  L7 = L6
  L6 = L6.get
  L8 = "xiaoqiang"
  L9 = "common"
  L10 = "BANDWIDTH2"
  L6 = L6(L7, L8, L9, L10)
  L7 = _UPVALUE2_
  L8 = L7
  L7 = L7.get
  L9 = "xiaoqiang"
  L10 = "common"
  L11 = "MANUAL"
  L7 = L7(L8, L9, L10, L11)
  L8 = _UPVALUE3_
  L8 = L8._strformat
  L9 = _UPVALUE2_
  L10 = L9
  L9 = L9.get
  L11 = "account"
  L12 = "common"
  L13 = "admin"
  L9, L10, L11, L12, L13, L14, L15 = L9(L10, L11, L12, L13)
  L8 = L8(L9, L10, L11, L12, L13, L14, L15)
  L9 = _UPVALUE4_
  L10 = L0
  L9 = L9(L10)
  L9 = L9 or L9
  if L9 then
    L10 = _UPVALUE5_
    L11 = L10
    L10 = L10.set
    L12 = "xiaoqiang"
    L13 = "common"
    L14 = "ROUTER_NAME"
    L15 = L9
    L10(L11, L12, L13, L14, L15)
  end
  if L1 then
    L10 = _UPVALUE5_
    L11 = L10
    L10 = L10.set
    L12 = "xiaoqiang"
    L13 = "common"
    L14 = "ROUTER_NAME_PENDING"
    L15 = L1
    L10(L11, L12, L13, L14, L15)
  end
  if L2 then
    L10 = _UPVALUE5_
    L11 = L10
    L10 = L10.set
    L12 = "xiaoqiang"
    L13 = "common"
    L14 = "ROUTER_LOCALE"
    L15 = L2
    L10(L11, L12, L13, L14, L15)
  end
  if L3 then
    L10 = _UPVALUE5_
    L11 = L10
    L10 = L10.set
    L12 = "xiaoqiang"
    L13 = "common"
    L14 = "PRIVACY"
    L15 = L3
    L10(L11, L12, L13, L14, L15)
  end
  if L4 then
    L10 = _UPVALUE5_
    L11 = L10
    L10 = L10.set
    L12 = "xiaoqiang"
    L13 = "common"
    L14 = "NETMODE"
    L15 = L4
    L10(L11, L12, L13, L14, L15)
  end
  L10 = _UPVALUE6_
  if L10 == 1 then
    if L5 then
      L10 = _UPVALUE5_
      L11 = L10
      L10 = L10.set
      L12 = "xiaoqiang"
      L13 = "common"
      L14 = "BANDWIDTH"
      L15 = L5
      L10(L11, L12, L13, L14, L15)
    end
    if L6 then
      L10 = _UPVALUE5_
      L11 = L10
      L10 = L10.set
      L12 = "xiaoqiang"
      L13 = "common"
      L14 = "BANDWIDTH2"
      L15 = L6
      L10(L11, L12, L13, L14, L15)
    end
    if L7 then
      L10 = _UPVALUE5_
      L11 = L10
      L10 = L10.set
      L12 = "xiaoqiang"
      L13 = "common"
      L14 = "MANUAL"
      L15 = L7
      L10(L11, L12, L13, L14, L15)
    end
  end
  L10 = _UPVALUE5_
  L11 = L10
  L10 = L10.set
  L12 = "account"
  L13 = "common"
  L14 = "admin"
  L15 = L8
  L10(L11, L12, L13, L14, L15)
  L10 = os
  L10 = L10.execute
  L11 = "nvram set Router_unconfigured=0 > /dev/null 2>&1"
  L10(L11)
end
function L14()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "network lan config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.get
  L2 = "network"
  L3 = "lan"
  L4 = "proto"
  L0 = L0(L1, L2, L3, L4)
  L1 = _UPVALUE2_
  L2 = L1
  L1 = L1.get
  L3 = "network"
  L4 = "lan"
  L5 = "ipaddr"
  L1 = L1(L2, L3, L4, L5)
  L2 = _UPVALUE2_
  L3 = L2
  L2 = L2.get
  L4 = "network"
  L5 = "lan"
  L6 = "netmask"
  L2 = L2(L3, L4, L5, L6)
  L3 = _UPVALUE3_
  L4 = L3
  L3 = L3.set
  L5 = "network"
  L6 = "lan"
  L7 = "proto"
  L8 = L0
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE3_
  L4 = L3
  L3 = L3.set
  L5 = "network"
  L6 = "lan"
  L7 = "ipaddr"
  L8 = L1
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE3_
  L4 = L3
  L3 = L3.set
  L5 = "network"
  L6 = "lan"
  L7 = "netmask"
  L8 = L2
  L3(L4, L5, L6, L7, L8)
end
function L15()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "network wan config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L0 = L0._strformat
  L1 = _UPVALUE3_
  L2 = L1
  L1 = L1.get
  L3 = "network"
  L4 = "wan"
  L5 = "proto"
  L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L1(L2, L3, L4, L5)
  L0 = L0(L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L1 = nil
  if L0 == "pppoe" then
    L2 = _UPVALUE3_
    L3 = L2
    L2 = L2.get
    L4 = "network"
    L5 = "wan"
    L6 = "mru"
    L2 = L2(L3, L4, L5, L6)
    L1 = L2
  else
    L2 = _UPVALUE3_
    L3 = L2
    L2 = L2.get
    L4 = "network"
    L5 = "wan"
    L6 = "mtu"
    L2 = L2(L3, L4, L5, L6)
    L1 = L2
  end
  L2 = _UPVALUE3_
  L3 = L2
  L2 = L2.get
  L4 = "network"
  L5 = "wan"
  L6 = "special"
  L2 = L2(L3, L4, L5, L6)
  L3 = _UPVALUE3_
  L4 = L3
  L3 = L3.get
  L5 = "network"
  L6 = "wan"
  L7 = "service"
  L3 = L3(L4, L5, L6, L7)
  L4 = _UPVALUE3_
  L5 = L4
  L4 = L4.get
  L6 = "network"
  L7 = "wan"
  L8 = "username"
  L4 = L4(L5, L6, L7, L8)
  L5 = _UPVALUE3_
  L6 = L5
  L5 = L5.get
  L7 = "network"
  L8 = "wan"
  L9 = "password"
  L5 = L5(L6, L7, L8, L9)
  L6 = _UPVALUE3_
  L7 = L6
  L6 = L6.get_list
  L8 = "network"
  L9 = "wan"
  L10 = "dns"
  L6 = L6(L7, L8, L9, L10)
  L7 = _UPVALUE3_
  L8 = L7
  L7 = L7.get
  L9 = "network"
  L10 = "wan"
  L11 = "peerdns"
  L7 = L7(L8, L9, L10, L11)
  L8 = _UPVALUE2_
  L8 = L8._strformat
  L9 = _UPVALUE3_
  L10 = L9
  L9 = L9.get
  L11 = "network"
  L12 = "wan"
  L13 = "ipaddr"
  L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L9(L10, L11, L12, L13)
  L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L9 = _UPVALUE2_
  L9 = L9._strformat
  L10 = _UPVALUE3_
  L11 = L10
  L10 = L10.get
  L12 = "network"
  L13 = "wan"
  L14 = "netmask"
  L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L10(L11, L12, L13, L14)
  L9 = L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L10 = _UPVALUE2_
  L10 = L10._strformat
  L11 = _UPVALUE3_
  L12 = L11
  L11 = L11.get
  L13 = "network"
  L14 = "wan"
  L15 = "gateway"
  L11, L12, L13, L14, L15, L16, L17, L18, L19 = L11(L12, L13, L14, L15)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L11 = _UPVALUE3_
  L12 = L11
  L11 = L11.get
  L13 = "network"
  L14 = "wan"
  L15 = "macaddr"
  L11 = L11(L12, L13, L14, L15)
  L12 = _UPVALUE2_
  L12 = L12._strformat
  L13 = _UPVALUE3_
  L14 = L13
  L13 = L13.get
  L15 = "xiaoqiang"
  L16 = "common"
  L17 = "WAN_SPEED"
  L13, L14, L15, L16, L17, L18, L19 = L13(L14, L15, L16, L17)
  L12 = L12(L13, L14, L15, L16, L17, L18, L19)
  L13 = _UPVALUE4_
  L14 = L13
  L13 = L13.set
  L15 = "network"
  L16 = "wan"
  L17 = "proto"
  L18 = L0
  L13(L14, L15, L16, L17, L18)
  L13 = _UPVALUE5_
  L14 = L6
  L13 = L13(L14)
  if L13 ~= nil then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set_list
    L15 = "network"
    L16 = "wan"
    L17 = "dns"
    L18 = L6
    L13(L14, L15, L16, L17, L18)
  end
  if L7 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set
    L15 = "network"
    L16 = "wan"
    L17 = "peerdns"
    L18 = L7
    L13(L14, L15, L16, L17, L18)
  end
  if L8 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set
    L15 = "network"
    L16 = "wan"
    L17 = "ipaddr"
    L18 = L8
    L13(L14, L15, L16, L17, L18)
  end
  if L9 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set
    L15 = "network"
    L16 = "wan"
    L17 = "netmask"
    L18 = L9
    L13(L14, L15, L16, L17, L18)
  end
  if L10 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set
    L15 = "network"
    L16 = "wan"
    L17 = "gateway"
    L18 = L10
    L13(L14, L15, L16, L17, L18)
  end
  if L1 then
    if L0 == "pppoe" then
      L13 = _UPVALUE4_
      L14 = L13
      L13 = L13.set
      L15 = "network"
      L16 = "wan"
      L17 = "mru"
      L18 = L1
      L13(L14, L15, L16, L17, L18)
    else
      L13 = _UPVALUE4_
      L14 = L13
      L13 = L13.set
      L15 = "network"
      L16 = "wan"
      L17 = "mtu"
      L18 = L1
      L13(L14, L15, L16, L17, L18)
    end
  end
  if L2 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set
    L15 = "network"
    L16 = "wan"
    L17 = "special"
    L18 = L2
    L13(L14, L15, L16, L17, L18)
  end
  if L3 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set
    L15 = "network"
    L16 = "wan"
    L17 = "service"
    L18 = L3
    L13(L14, L15, L16, L17, L18)
  end
  if L4 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set
    L15 = "network"
    L16 = "wan"
    L17 = "username"
    L18 = L4
    L13(L14, L15, L16, L17, L18)
  end
  if L5 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set
    L15 = "network"
    L16 = "wan"
    L17 = "password"
    L18 = L5
    L13(L14, L15, L16, L17, L18)
  end
  if L11 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.set
    L15 = "network"
    L16 = "wan"
    L17 = "macaddr"
    L18 = L11
    L13(L14, L15, L16, L17, L18)
  end
  if L12 and L12 ~= 0 then
    L13 = _UPVALUE4_
    L14 = L13
    L13 = L13.get
    L15 = "misc"
    L16 = "hardware"
    L17 = "wanspeed"
    L13 = L13(L14, L15, L16, L17)
    L13 = L13 or L13
    if L12 == "10" and L13 == "1000" then
    elseif L12 == "1000" and L13 == "100" then
    else
      L14 = _UPVALUE4_
      L15 = L14
      L14 = L14.set
      L16 = "xiaoqiang"
      L17 = "common"
      L18 = "WAN_SPEED"
      L19 = L12
      L14(L15, L16, L17, L18, L19)
      L14 = os
      L14 = L14.execute
      L15 = "phyhelper mode set \""
      L16 = _UPVALUE2_
      L16 = L16._strformat
      L17 = L12
      L16 = L16(L17)
      L17 = "\"> /dev/null 2>&1"
      L15 = L15 .. L16 .. L17
      L14(L15)
    end
  end
end
function L16()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "network config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L0()
  L0 = _UPVALUE3_
  L0()
end
function L17()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "dhcp config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.get
  L2 = "dhcp"
  L3 = "lan"
  L4 = "start"
  L0 = L0(L1, L2, L3, L4)
  L1 = _UPVALUE2_
  L2 = L1
  L1 = L1.get
  L3 = "dhcp"
  L4 = "lan"
  L5 = "limit"
  L1 = L1(L2, L3, L4, L5)
  L2 = _UPVALUE2_
  L3 = L2
  L2 = L2.get
  L4 = "dhcp"
  L5 = "lan"
  L6 = "leasetime"
  L2 = L2(L3, L4, L5, L6)
  L3 = _UPVALUE2_
  L4 = L3
  L3 = L3.get
  L5 = "dhcp"
  L6 = "lan"
  L7 = "ignore"
  L3 = L3(L4, L5, L6, L7)
  L4 = _UPVALUE3_
  L5 = L4
  L4 = L4.set
  L6 = "dhcp"
  L7 = "lan"
  L8 = "start"
  L9 = L0
  L4(L5, L6, L7, L8, L9)
  L4 = _UPVALUE3_
  L5 = L4
  L4 = L4.set
  L6 = "dhcp"
  L7 = "lan"
  L8 = "limit"
  L9 = L1
  L4(L5, L6, L7, L8, L9)
  L4 = _UPVALUE3_
  L5 = L4
  L4 = L4.set
  L6 = "dhcp"
  L7 = "lan"
  L8 = "leasetime"
  L9 = L2
  L4(L5, L6, L7, L8, L9)
  if L3 then
    L4 = _UPVALUE3_
    L5 = L4
    L4 = L4.set
    L6 = "dhcp"
    L7 = "lan"
    L8 = "ignore"
    L9 = L3
    L4(L5, L6, L7, L8, L9)
  end
end
function L18()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "network guest config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.get_all
  L2 = "network"
  L3 = "guest"
  L0 = L0(L1, L2, L3)
  L1 = _UPVALUE3_
  L2 = L0
  L1 = L1(L2)
  if L1 ~= nil then
    L1 = _UPVALUE4_
    L2 = L1
    L1 = L1.section
    L3 = "network"
    L4 = "interface"
    L5 = "guest"
    L6 = L0
    L1(L2, L3, L4, L5, L6)
  end
end
function L19()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "dhcp guest config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.get_all
  L2 = "dhcp"
  L3 = "guest"
  L0 = L0(L1, L2, L3)
  L1 = _UPVALUE3_
  L2 = L0
  L1 = L1(L2)
  if L1 ~= nil then
    L1 = _UPVALUE4_
    L2 = L1
    L1 = L1.section
    L3 = "dhcp"
    L4 = "dhcp"
    L5 = "guest"
    L6 = L0
    L1(L2, L3, L4, L5, L6)
  end
end
function L20()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "firewall guest config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.get_all
  L2 = "firewall"
  L3 = "guest_forward"
  L0 = L0(L1, L2, L3)
  L1 = _UPVALUE2_
  L2 = L1
  L1 = L1.get_all
  L3 = "firewall"
  L4 = "guest_zone"
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE2_
  L3 = L2
  L2 = L2.get_all
  L4 = "firewall"
  L5 = "guest_dns"
  L2 = L2(L3, L4, L5)
  L3 = _UPVALUE2_
  L4 = L3
  L3 = L3.get_all
  L5 = "firewall"
  L6 = "guest_dhcp"
  L3 = L3(L4, L5, L6)
  L4 = _UPVALUE3_
  L5 = L0
  L4 = L4(L5)
  if L4 ~= nil then
    L4 = _UPVALUE4_
    L5 = L4
    L4 = L4.section
    L6 = "firewall"
    L7 = "forwarding"
    L8 = "guest_forward"
    L9 = L0
    L4(L5, L6, L7, L8, L9)
  end
  L4 = _UPVALUE3_
  L5 = L1
  L4 = L4(L5)
  if L4 ~= nil then
    L4 = _UPVALUE4_
    L5 = L4
    L4 = L4.section
    L6 = "firewall"
    L7 = "zone"
    L8 = "guest_zone"
    L9 = L1
    L4(L5, L6, L7, L8, L9)
  end
  L4 = _UPVALUE3_
  L5 = L2
  L4 = L4(L5)
  if L4 ~= nil then
    L4 = _UPVALUE4_
    L5 = L4
    L4 = L4.section
    L6 = "firewall"
    L7 = "rule"
    L8 = "guest_dns"
    L9 = L2
    L4(L5, L6, L7, L8, L9)
  end
  L4 = _UPVALUE3_
  L5 = L3
  L4 = L4(L5)
  if L4 ~= nil then
    L4 = _UPVALUE4_
    L5 = L4
    L4 = L4.section
    L6 = "firewall"
    L7 = "rule"
    L8 = "guest_dhcp"
    L9 = L3
    L4(L5, L6, L7, L8, L9)
  end
end
function L21()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "guest config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L0()
  L0 = _UPVALUE3_
  L0()
  L0 = _UPVALUE4_
  L0()
end
function L22()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "macfilter config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.get
  L2 = "macfilter"
  L3 = "mode"
  L4 = "admin"
  L0 = L0(L1, L2, L3, L4)
  if L0 ~= "whitelist" then
    return
  end
  L1 = _UPVALUE3_
  L2 = L1
  L1 = L1.set
  L3 = "macfilter"
  L4 = "mode"
  L5 = "admin"
  L6 = L0
  L1(L2, L3, L4, L5, L6)
  L1 = _UPVALUE2_
  L2 = L1
  L1 = L1.foreach
  L3 = "macfilter"
  L4 = "mac"
  function L5(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.section
    L3 = "macfilter"
    L4 = "mac"
    L5 = nil
    L6 = A0
    L1(L2, L3, L4, L5, L6)
  end
  L1(L2, L3, L4, L5)
end
function L23()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "timezone config"
  L0(L1, L2)
  L0, L1 = nil, nil
  L2 = _UPVALUE2_
  L3 = L2
  L2 = L2.foreach
  L4 = "system"
  L5 = "system"
  function L6(A0)
    local L1
    L1 = A0.timezone
    _UPVALUE0_ = L1
    L1 = A0.timezoneindex
    _UPVALUE1_ = L1
  end
  L2(L3, L4, L5, L6)
  L2 = _UPVALUE3_
  L3 = L2
  L2 = L2.foreach
  L4 = "system"
  L5 = "system"
  function L6(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = _UPVALUE0_
    if L1 then
      L1 = _UPVALUE1_
      L2 = L1
      L1 = L1.set
      L3 = "system"
      L4 = A0[".name"]
      L5 = "timezone"
      L6 = _UPVALUE0_
      L1(L2, L3, L4, L5, L6)
    end
    L1 = _UPVALUE2_
    if L1 then
      L1 = _UPVALUE1_
      L2 = L1
      L1 = L1.set
      L3 = "system"
      L4 = A0[".name"]
      L5 = "timezoneindex"
      L6 = _UPVALUE2_
      L1(L2, L3, L4, L5, L6)
    end
  end
  L2(L3, L4, L5, L6)
end
function L24()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "qos config"
  L0(L1, L2)
  L0 = _UPVALUE2_
  if L0 ~= 1 then
    L0 = _UPVALUE0_
    L0 = L0.log
    L1 = _UPVALUE1_
    L2 = "wan speed not compat, don't do qos config!"
    L0(L1, L2)
    return
  end
  L0 = _UPVALUE3_
  L1 = _UPVALUE4_
  L2 = "miqos"
  L0 = L0 .. L1 .. L2
  L1 = _UPVALUE3_
  L2 = _UPVALUE4_
  L3 = "miqos_default"
  L1 = L1 .. L2 .. L3
  L2 = os
  L2 = L2.execute
  L3 = "cp -f "
  L4 = L0
  L5 = " "
  L6 = _UPVALUE4_
  L7 = " >/dev/null 2>&1"
  L3 = L3 .. L4 .. L5 .. L6 .. L7
  L2(L3)
  L2 = os
  L2 = L2.execute
  L3 = "cp -f "
  L4 = L1
  L5 = " "
  L6 = _UPVALUE4_
  L7 = " >/dev/null 2>&1"
  L3 = L3 .. L4 .. L5 .. L6 .. L7
  L2(L3)
end
function L25()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = _UPVALUE1_
  L2 = "wireless guest disable"
  L0(L1, L2)
  L0 = _UPVALUE2_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "iface_guest_2g_name"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  L1 = _UPVALUE2_
  L2 = L1
  L1 = L1.get_all
  L3 = "wireless"
  L4 = L0
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE3_
  L3 = L1
  L2 = L2(L3)
  if L2 ~= nil then
    L2 = _UPVALUE2_
    L3 = L2
    L2 = L2.delete
    L4 = "wireless"
    L5 = L0
    L2(L3, L4, L5)
    L2 = _UPVALUE2_
    L3 = L2
    L2 = L2.commit
    L4 = "wireless"
    L2(L3, L4)
  end
end
function L26()
  local L0, L1
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = _UPVALUE1_
  L1 = L1()
  _UPVALUE0_ = L1
  L1 = _UPVALUE2_
  L1()
  L1 = _UPVALUE3_
  L1()
  L1 = _UPVALUE4_
  L1()
  L1 = _UPVALUE5_
  L1()
  L1 = _UPVALUE6_
  L1()
  L1 = _UPVALUE7_
  L1()
  L1 = L0.extendwifi_tranlate_wireless_config
  L1()
  L1 = _UPVALUE8_
  L1()
  L1 = 0
  return L1
end
config_merge = L26
function L26()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L4 = _UPVALUE0_
  L4 = L4.log
  L5 = _UPVALUE1_
  L6 = "get hotspot info"
  L4(L5, L6)
  L4 = _UPVALUE2_
  L5 = L4
  L4 = L4.get
  L6 = "misc"
  L7 = "wireless"
  L8 = "ifname_2G"
  L4 = L4(L5, L6, L7, L8)
  L5 = _UPVALUE2_
  L6 = L5
  L5 = L5.get
  L7 = "misc"
  L8 = "wireless"
  L9 = "ifname_5G"
  L5 = L5(L6, L7, L8, L9)
  L6 = _UPVALUE2_
  L7 = L6
  L6 = L6.foreach
  L8 = "wireless"
  L9 = "wifi-iface"
  function L10(A0)
    local L1, L2
    L1 = A0.ifname
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = A0.ssid
      _UPVALUE1_ = L1
      L1 = A0.key
      _UPVALUE2_ = L1
    end
    L1 = A0.ifname
    L2 = _UPVALUE3_
    if L1 == L2 then
      L1 = A0.ssid
      _UPVALUE4_ = L1
      L1 = A0.key
      _UPVALUE5_ = L1
    end
  end
  L6(L7, L8, L9, L10)
  if L0 then
    L6 = _UPVALUE0_
    L6 = L6.log
    L7 = _UPVALUE1_
    L8 = "ssid_24g: "
    L9 = L0
    L8 = L8 .. L9
    L6(L7, L8)
  end
  if L1 then
    L6 = _UPVALUE0_
    L6 = L6.log
    L7 = _UPVALUE1_
    L8 = "passwd_24g: "
    L9 = L1
    L8 = L8 .. L9
    L6(L7, L8)
  end
  if L2 then
    L6 = _UPVALUE0_
    L6 = L6.log
    L7 = _UPVALUE1_
    L8 = "ssid_5g: "
    L9 = L2
    L8 = L8 .. L9
    L6(L7, L8)
  end
  if L3 then
    L6 = _UPVALUE0_
    L6 = L6.log
    L7 = _UPVALUE1_
    L8 = "passwd_5g: "
    L9 = L3
    L8 = L8 .. L9
    L6(L7, L8)
  end
  L6 = L0
  L7 = L1
  L8 = L2
  L9 = L3
  return L6, L7, L8, L9
end
hotspot_info = L26
function L26()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "hardware"
  L4 = "model"
  L0 = L0(L1, L2, L3, L4)
  if L0 then
    L1 = string
    L1 = L1.lower
    L2 = L0
    L1 = L1(L2)
    L0 = L1
    return L0
  end
  L1 = nil
  return L1
end
hardware_info = L26
