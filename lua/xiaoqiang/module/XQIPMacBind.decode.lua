local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "xiaoqiang.module.XQIPMacBind"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "luci.cbi.datatypes"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.XQLog"
L2 = L2(L3)
L3 = require
L4 = "cjson"
L3 = L3(L4)
function L4(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "luci.ip"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = false
    return L2
  end
  L2 = L1.iptonl
  L3 = A0
  L2 = L2(L3)
  L3 = L1.iptonl
  L4 = "1.0.0.0"
  L3 = L3(L4)
  if L2 >= L3 then
    L3 = L1.iptonl
    L4 = "126.0.0.0"
    L3 = L3(L4)
    if L2 <= L3 then
      goto lbl_35
    end
  end
  L3 = L1.iptonl
  L4 = "128.0.0.0"
  L3 = L3(L4)
  if L2 >= L3 then
    L3 = L1.iptonl
    L4 = "223.255.255.255"
    L3 = L3(L4)
    ::lbl_35::
    if L2 <= L3 then
      L3 = true
      return L3
  end
  else
    L3 = false
    return L3
  end
end
function L5(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = L1.macaddr
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = tonumber
    L4 = A0
    L3 = A0.sub
    L5 = 1
    L6 = 2
    L3 = L3(L4, L5, L6)
    L4 = 16
    L2 = L2(L3, L4)
    L3 = L2 % 2
    L3 = L3 == 0
    return L3
  else
    L2 = false
    return L2
  end
end
function L6(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE1_
  L2 = A0
  L1 = L1(L2)
  if L1 == false then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = L1.macaddr
  L3 = A0
  L2 = L2(L3)
  if L2 and A0 ~= "ff:ff:ff:ff:ff:ff" and A0 ~= "00:00:00:00:00:00" then
    L2 = true
    return L2
  else
    L2 = false
    return L2
  end
end
_checkMac = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  for L7, L8 in L4, L5, L6 do
    L9 = string
    L9 = L9.lower
    L10 = _UPVALUE0_
    L10 = L10.macFormat
    L11 = L8.mac
    L10, L11, L12, L13 = L10(L11)
    L9 = L9(L10, L11, L12, L13)
    L1 = L9
    L2 = L8.ip
    L9 = _UPVALUE1_
    L10 = L2
    L9 = L9(L10)
    if L9 then
      L9 = _checkMac
      L10 = L1
      L9 = L9(L10)
      if L9 then
        goto lbl_31
      end
    end
    L9 = _UPVALUE2_
    L9 = L9.log
    L10 = 1
    L11 = "illegal ip address"
    L9(L10, L11)
    L9 = false
    do return L9 end
    ::lbl_31::
  end
  for L7, L8 in L4, L5, L6 do
    L9 = string
    L9 = L9.lower
    L10 = _UPVALUE0_
    L10 = L10.macFormat
    L11 = L8.mac
    L10, L11, L12, L13 = L10(L11)
    L9 = L9(L10, L11, L12, L13)
    L1 = L9
    L2 = L8.ip
    L9 = "/usr/sbin/ipmac_binding add "
    L10 = L1
    L11 = " "
    L12 = L2
    L13 = " > /dev/console"
    L3 = L9 .. L10 .. L11 .. L12 .. L13
    L9 = _UPVALUE2_
    L9 = L9.log
    L10 = 6
    L11 = "add ipmac cmd:"
    L12 = L3
    L11 = L11 .. L12
    L9(L10, L11)
    L9 = os
    L9 = L9.execute
    L10 = L3
    L9(L10)
  end
  return L4
end
addIPMacBindList = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L3 = string
  L3 = L3.lower
  L4 = _UPVALUE0_
  L4 = L4.macFormat
  L5 = A0
  L4, L5, L6, L7 = L4(L5)
  L3 = L3(L4, L5, L6, L7)
  L2 = L3
  L3 = _UPVALUE1_
  L4 = A1
  L3 = L3(L4)
  if L3 then
    L3 = _checkMac
    L4 = L2
    L3 = L3(L4)
    if L3 then
      goto lbl_21
    end
  end
  L3 = false
  do return L3 end
  ::lbl_21::
  L3 = "/usr/sbin/ipmac_binding add "
  L4 = L2
  L5 = " "
  L6 = A1
  L7 = " > /dev/console"
  L3 = L3 .. L4 .. L5 .. L6 .. L7
  cmd = L3
  L3 = _UPVALUE2_
  L3 = L3.log
  L4 = 6
  L5 = "add ipmac cmd:"
  L6 = cmd
  L5 = L5 .. L6
  L3(L4, L5)
  L3 = os
  L3 = L3.execute
  L4 = cmd
  L3(L4)
  L3 = true
  return L3
end
addIPMacBindEntry = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQMacBind"
  L2 = L2(L3)
  L3 = L2.macBindInfo
  L3 = L3()
  L4, L5 = nil, nil
  for L9, L10 in L6, L7, L8 do
    L11 = string
    L11 = L11.lower
    L12 = L10
    L11 = L11(L12)
    L11 = L3[L11]
    if L11 then
      L4 = L11.ip
      L12 = "/usr/sbin/ipmac_binding del "
      L13 = string
      L13 = L13.lower
      L14 = L10
      L13 = L13(L14)
      L14 = " "
      L15 = L4
      L16 = " > /dev/console"
      L5 = L12 .. L13 .. L14 .. L15 .. L16
      L12 = _UPVALUE0_
      L12 = L12.log
      L13 = 6
      L14 = "del ipmac cmd:"
      L15 = L5
      L14 = L14 .. L15
      L12(L13, L14)
      L12 = os
      L12 = L12.execute
      L13 = L5
      L12(L13)
    end
  end
  return L6
end
delIPMacBindingList = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L3 = string
  L3 = L3.lower
  L4 = _UPVALUE0_
  L4 = L4.macFormat
  L5 = A0
  L4, L5, L6, L7 = L4(L5)
  L3 = L3(L4, L5, L6, L7)
  L2 = L3
  L3 = _UPVALUE1_
  L4 = A1
  L3 = L3(L4)
  if L3 then
    L3 = _checkMac
    L4 = L2
    L3 = L3(L4)
    if L3 then
      goto lbl_21
    end
  end
  L3 = false
  do return L3 end
  ::lbl_21::
  L3 = "/usr/sbin/ipmac_binding clearSession "
  L4 = L2
  L5 = " "
  L6 = A1
  L7 = " > /dev/console"
  L3 = L3 .. L4 .. L5 .. L6 .. L7
  cmd = L3
  L3 = _UPVALUE2_
  L3 = L3.log
  L4 = 6
  L5 = "add ipmac cmd:"
  L6 = cmd
  L5 = L5 .. L6
  L3(L4, L5)
  L3 = os
  L3 = L3.execute
  L4 = cmd
  L3(L4)
  L3 = true
  return L3
end
ipMacBindclearOldSession = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L3 = _UPVALUE0_
  L4 = A1
  L3 = L3(L4)
  if L3 then
    L3 = _checkMac
    L4 = A0
    L3 = L3(L4)
    if L3 then
      goto lbl_18
    end
  end
  L3 = _UPVALUE1_
  L3 = L3.log
  L4 = 1
  L5 = "illegal ip address"
  L3(L4, L5)
  L3 = false
  do return L3 end
  ::lbl_18::
  L3 = "/usr/sbin/ipmac_binding del "
  L4 = string
  L4 = L4.lower
  L5 = A0
  L4 = L4(L5)
  L5 = " "
  L6 = A1
  L7 = " > /dev/console"
  L2 = L3 .. L4 .. L5 .. L6 .. L7
  L3 = _UPVALUE1_
  L3 = L3.log
  L4 = 6
  L5 = "del ipmac cmd:"
  L6 = L2
  L5 = L5 .. L6
  L3(L4, L5)
  L3 = os
  L3 = L3.execute
  L4 = L2
  L3(L4)
  L3 = true
  return L3
end
delIPMacBindingEntry = L6
function L6()
  local L0, L1, L2, L3, L4
  L0 = "/usr/sbin/ipmac_binding flush > /dev/console"
  L1 = _UPVALUE0_
  L1 = L1.log
  L2 = 6
  L3 = "clean ipmac binding entry cmd:"
  L4 = L0
  L3 = L3 .. L4
  L1(L2, L3)
  L1 = os
  L1 = L1.execute
  L2 = L0
  L1(L2)
  L1 = true
  return L1
end
flushIPMacBindingList = L6
function L6()
  local L0, L1, L2, L3, L4
  L0 = "/usr/sbin/ipmac_binding reload > /dev/console"
  L1 = _UPVALUE0_
  L1 = L1.log
  L2 = 6
  L3 = "clean ipmac binding entry cmd:"
  L4 = L0
  L3 = L3 .. L4
  L1(L2, L3)
  L1 = os
  L1 = L1.execute
  L2 = L0
  L1(L2)
  L1 = true
  return L1
end
reloadIPMacBindingList = L6
