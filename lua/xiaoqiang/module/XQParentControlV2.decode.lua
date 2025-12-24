local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
L0 = module
L1 = "xiaoqiang.module.XQParentControlV2"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = 10080
L1 = require
L2 = "xiaoqiang.common.XQFunction"
L1 = L1(L2)
L2 = require
L3 = "cjson"
L2 = L2(L3)
L3 = require
L4 = "luci.model.uci"
L3 = L3(L4)
L4 = L3.cursor
L4 = L4()
L5 = L3.cursor
L6 = "/etc/mipctl"
L5 = L5(L6)
L6 = nil
L7 = {}
L8 = nil
L9 = "mipctl_user"
L10 = "mipctl_app"
L11 = "mipctl_upg_info"
L12 = 5
L13 = 12
L14 = "/etc/xqDb"
L15 = "pctl_user_stat"
L16 = "pctl_appclass_stat"
function L17()
  local L0, L1, L2, L3, L4, L5
  L0 = os
  L0 = L0.date
  L1 = "!*t"
  L0 = L0(L1)
  L1 = os
  L1 = L1.date
  L2 = "*t"
  L1 = L1(L2)
  L1.isdst = false
  L2 = os
  L2 = L2.difftime
  L3 = os
  L3 = L3.time
  L4 = L1
  L3 = L3(L4)
  L4 = os
  L4 = L4.time
  L5 = L0
  L4, L5 = L4(L5)
  return L2(L3, L4, L5)
end
get_timezone_offset = L17
function L17(A0)
  local L1, L2
  L1 = type
  L2 = A0
  L1 = L1(L2)
  L1 = L1 == "number"
  return L1
end
isInt = L17
function L17(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  L4 = #A3
  if L4 == 0 then
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.delete
    L6 = A0
    L7 = A1
    L8 = A2
    L4(L5, L6, L7, L8)
    L4 = true
    return L4
  else
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.set_list
    L6 = A0
    L7 = A1
    L8 = A2
    L9 = A3
    return L4(L5, L6, L7, L8, L9)
  end
end
setList = L17
function L17(A0)
  local L1, L2
  L1 = A0.temp_ban
  L2 = L1 ~= nil and "1" == L1
  return L2
end
isTempBan = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  if A0 == nil then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = {}
  L3 = "ubus call trafficd hw"
  L4 = L1.exec
  L4 = L4(L5)
  if L5 then
    return L5
  end
  L4 = L5
  for L8, L9 in L5, L6, L7 do
    L2[L9] = true
  end
  for L8, L9 in L5, L6, L7 do
    L10 = L9.hw
    L10 = L2[L10]
    if L10 then
      L10 = L9.assoc
      if 1 == L10 then
        L10 = true
        return L10
      end
    end
  end
  return L5
end
isOnline = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "ubus"
  L1 = L1(L2)
  L2 = L1.connect
  L2 = L2()
  if L2 then
    L4 = L2
    L3 = L2.call
    L5 = "mipctl"
    L6 = "is_allow_access"
    L7 = {}
    L7.user_id = A0
    L3 = L3(L4, L5, L6, L7)
    L5 = L2
    L4 = L2.close
    L4(L5)
    if L3 then
      L4 = L3.result
      return L4
    end
  end
  L3 = true
  return L3
end
allowAccess = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L1 = {}
  L2 = os
  L2 = L2.date
  L3 = "h%Hm%Mu%us%s"
  L2 = L2(L3)
  L3 = tonumber
  L5 = L2
  L4 = L2.sub
  L7 = L2
  L6 = L2.find
  L8 = "h[0-9]+"
  L6, L7, L8, L9, L10, L11, L15, L16, L17, L18, L19, L20 = L6(L7, L8)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L5 = L4
  L4 = L4.sub
  L6 = 2
  L4, L5, L6, L7, L8, L9, L10, L11, L15, L16, L17, L18, L19, L20 = L4(L5, L6)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L4 = L3 * 60
  L5 = tonumber
  L7 = L2
  L6 = L2.sub
  L9 = L2
  L8 = L2.find
  L10 = "m[0-9]+"
  L8, L9, L10, L11, L15, L16, L17, L18, L19, L20 = L8(L9, L10)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L7 = L6
  L6 = L6.sub
  L8 = 2
  L6, L7, L8, L9, L10, L11, L15, L16, L17, L18, L19, L20 = L6(L7, L8)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L4 = L4 + L5
  L5 = tonumber
  L7 = L2
  L6 = L2.sub
  L9 = L2
  L8 = L2.find
  L10 = "u[0-9]+"
  L8, L9, L10, L11, L15, L16, L17, L18, L19, L20 = L8(L9, L10)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L7 = L6
  L6 = L6.sub
  L8 = 2
  L6, L7, L8, L9, L10, L11, L15, L16, L17, L18, L19, L20 = L6(L7, L8)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L6 = tonumber
  L8 = L2
  L7 = L2.sub
  L10 = L2
  L9 = L2.find
  L11 = "s[0-9]+"
  L9, L10, L11, L15, L16, L17, L18, L19, L20 = L9(L10, L11)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L8 = L7
  L7 = L7.sub
  L9 = 2
  L7, L8, L9, L10, L11, L15, L16, L17, L18, L19, L20 = L7(L8, L9)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20)
  L7 = get_timezone_offset
  L7 = L7()
  L8 = 0
  L9 = math
  L9 = L9.floor
  L10 = L6 + L7
  L10 = L10 / 86400
  L9 = L9(L10)
  L10 = 0
  L11 = 1440 - L4
  L15 = "user_time_ban"
  function L16(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
    if L1 == L2 then
      for L4 = L1, L2, L3 do
        L5 = A0.enable
        L6 = L5
        L5 = L5.sub
        L7 = L4
        L8 = L4
        L5 = L5(L6, L7, L8)
        if L5 == "1" then
          L5 = _UPVALUE1_
          L5 = L4 - L5
          L5 = 1440 * L5
          L6 = _UPVALUE2_
          L5 = L5 - L6
          L6, L7 = nil, nil
          L8 = tonumber
          L9 = A0.start
          L8 = L8(L9)
          L6 = L5 + L8
          L8 = math
          L8 = L8.fmod
          L9 = _UPVALUE3_
          L9 = L6 + L9
          L10 = _UPVALUE3_
          L8 = L8(L9, L10)
          L6 = L8
          L8 = tonumber
          L9 = A0["end"]
          L8 = L8(L9)
          L7 = L5 + L8
          L8 = math
          L8 = L8.fmod
          L9 = _UPVALUE3_
          L9 = L7 + L9
          L10 = _UPVALUE3_
          L8 = L8(L9, L10)
          L7 = L8
          if L6 > L7 then
            L8 = _UPVALUE4_
            L8 = L8 + 1
            _UPVALUE4_ = L8
          end
          L8 = table
          L8 = L8.insert
          L9 = _UPVALUE5_
          L10 = {}
          L10.delta = 1
          L10.offst = L6
          L8(L9, L10)
          L8 = table
          L8 = L8.insert
          L9 = _UPVALUE5_
          L10 = {}
          L10.delta = -1
          L10.offst = L7
          L8(L9, L10)
        end
      end
    end
  end
  L12(L13, L14, L15, L16)
  L12(L13, L14)
  for L15 = L12, L13, L14 do
    if L10 <= L11 then
      L16 = L1[L15]
      L16 = L16.offst
      if L11 < L16 and L8 == 0 then
        L16 = os
        L16 = L16.date
        L17 = "%m/%d/%Y-%R-1"
        L18 = L11 * 60
        L18 = L18 + L6
        return L16(L17, L18)
      end
    end
    L16 = L1[L15]
    L10 = L16.offst
    L16 = L1[L15]
    L16 = L16.delta
    L8 = L8 + L16
    if L8 == 0 then
      L16 = L1[L15]
      L16 = L16.offst
      L16 = L16 * 60
      L16 = L6 + L16
      L17 = math
      L17 = L17.floor
      L18 = L16 + L7
      L18 = L18 / 86400
      L17 = L17(L18)
      L18 = os
      L18 = L18.date
      L19 = "%m/%d/%Y-%R-"
      L20 = L1[L15]
      L20 = L20.offst
      L20 = L20 * 60
      L20 = L6 + L20
      L18 = L18(L19, L20)
      L19 = tostring
      L20 = L17 - L9
      L19 = L19(L20)
      L18 = L18 .. L19
      return L18
    end
  end
  return L12(L13, L14)
end
cal_nxt_permit_time = L17
function L17()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.foreach
  L3 = _UPVALUE1_
  L4 = "user"
  function L5(A0)
    local L1, L2, L3, L4
    L1 = {}
    L2 = tonumber
    L3 = A0.user_id
    L2 = L2(L3)
    L1.user_id = L2
    L2 = A0.user_name
    L1.user_name = L2
    L2 = A0.icon_id
    L1.icon = L2
    L2 = isTempBan
    L3 = A0
    L2 = L2(L3)
    if L2 then
      L1.status = -1
    else
      L2 = allowAccess
      L3 = tonumber
      L4 = A0.user_id
      L3, L4 = L3(L4)
      L2 = L2(L3, L4)
      if not L2 then
        L1.status = -1
      else
        L2 = isOnline
        L3 = A0.device
        L2 = L2(L3)
        if L2 then
          L1.status = 1
        else
          L1.status = 0
        end
      end
    end
    L2 = table
    L2 = L2.insert
    L3 = _UPVALUE0_
    L4 = L1
    L2(L3, L4)
  end
  L1(L2, L3, L4, L5)
  return L0
end
getPctlUserList = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = true
  L2 = 0
  L3 = nil
  for L7 = L4, L5, L6 do
    L8 = string
    L8 = L8.byte
    L9 = A0
    L10 = L7
    L11 = L7
    L8 = L8(L9, L10, L11)
    L3 = L8
    if L3 < 128 then
      if not L1 then
        L2 = L2 + 2
      end
      L2 = L2 + 1
      L1 = true
    elseif 192 <= L3 then
      if not L1 then
        L2 = L2 + 2
      end
      L1 = false
    end
  end
  if not L1 then
    L2 = L2 + 2
  end
  return L2
end
calStrWidth = L17
function L17(A0)
  local L1, L2, L3
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 ~= "string" then
    L1 = -1672
    return L1
  end
  L1 = calStrWidth
  L2 = A0
  L1 = L1(L2)
  if 12 < L1 then
    L1 = -1668
    return L1
  end
  L1 = string
  L1 = L1.match
  L2 = A0
  L3 = [[
[^
]+]]
  L1 = L1(L2, L3)
  ret = L1
  L1 = ret
  if L1 ~= A0 then
    L1 = -1663
    return L1
  end
  L1 = 0
  return L1
end
checkUserName = L17
function L17(A0)
  local L1, L2, L3
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 ~= "string" then
    L1 = -1672
    return L1
  end
  L1 = string
  L1 = L1.match
  L2 = A0
  L3 = [[
[^<>:/\|?*%%&^
]+]]
  L1 = L1(L2, L3)
  ret = L1
  L1 = ret
  if L1 ~= A0 then
    L1 = -1672
    return L1
  else
    L1 = 0
    return L1
  end
end
checkName = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = {}
  L2 = 0
  L3 = tonumber
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = _UPVALUE1_
  L7 = "meta"
  L8 = "user_max"
  L4, L5, L6, L7, L8, L12, L13, L14 = L4(L5, L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L4, L5, L6, L7 = nil, nil, nil, nil
  L8 = 0
  if L8 == 0 then
    L8 = L9 or L8
    if not L9 then
    end
  end
  if L8 == 0 then
    L8 = L9 or L8
    if not L9 then
    end
  end
  if L8 ~= 0 then
    return L8
  end
  L4 = A0.user_name
  L5 = A0.icon
  if nil == L3 then
    L8 = -1673
    return L8
  end
  L12 = "user"
  function L13(A0)
    local L1, L2, L3, L4
    L1 = table
    L1 = L1.insert
    L2 = _UPVALUE0_
    L3 = tonumber
    L4 = A0.user_id
    L3, L4 = L3(L4)
    L1(L2, L3, L4)
    L1 = _UPVALUE1_
    L1 = L1 + 1
    _UPVALUE1_ = L1
  end
  L9(L10, L11, L12, L13)
  if L2 == L3 then
    L8 = -1662
    return L8
  end
  L9(L10)
  L6 = L2 + 1
  for L12, L13 in L9, L10, L11 do
    if L12 ~= L13 then
      L6 = L12
      break
    end
  end
  L12 = "user"
  L7 = L9
  L12 = L7
  L13 = "user_id"
  L14 = L6
  L8 = L9 or L8
  if L9 then
    L12 = L7
    L13 = "user_name"
    L14 = L4
    L8 = L9 or L8
    if L9 then
      L12 = L7
      L13 = "icon_id"
      L14 = L5
      L8 = L9
    end
  end
  if not L8 then
    L8 = -1673
    return L8
  end
  L8 = 0
  _UPVALUE2_ = L6
  return L8
end
addUser = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.foreach
  L5 = _UPVALUE1_
  L6 = "user"
  function L7(A0)
    local L1, L2
    L1 = tonumber
    L2 = A0.user_id
    L1 = L1(L2)
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = A0[".name"]
      _UPVALUE1_ = L1
      _UPVALUE2_ = A0
    end
  end
  L3(L4, L5, L6, L7)
  L3 = L1
  L4 = L2
  return L3, L4
end
findUser = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = 0
  L2 = A0.user_id
  L2 = L2 or L2
  _UPVALUE0_ = L2
  L2 = _UPVALUE0_
  L3 = isInt
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L1 = -1672
    return L1
  end
  L3 = findUser
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L1 = -1664
    return L1
  end
  L4 = _UPVALUE1_
  L5 = L4
  L4 = L4.delete
  L6 = _UPVALUE2_
  L7 = L3
  L4 = L4(L5, L6, L7)
  L1 = L4
  L4 = _UPVALUE1_
  L5 = L4
  L4 = L4.foreach
  L6 = _UPVALUE2_
  L7 = "user_time_ban"
  function L8(A0)
    local L1, L2, L3, L4
    L1 = tonumber
    L2 = A0.user_id
    L1 = L1(L2)
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = _UPVALUE1_
      if L1 then
        L1 = _UPVALUE2_
        L2 = L1
        L1 = L1.delete
        L3 = _UPVALUE3_
        L4 = A0[".name"]
        L1 = L1(L2, L3, L4)
        _UPVALUE1_ = L1
      end
    end
  end
  L4(L5, L6, L7, L8)
  L4 = _UPVALUE1_
  L5 = L4
  L4 = L4.foreach
  L6 = _UPVALUE2_
  L7 = "user_class_config"
  function L8(A0)
    local L1, L2, L3, L4
    L1 = tonumber
    L2 = A0.user_id
    L1 = L1(L2)
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = _UPVALUE1_
      if L1 then
        L1 = _UPVALUE2_
        L2 = L1
        L1 = L1.delete
        L3 = _UPVALUE3_
        L4 = A0[".name"]
        L1 = L1(L2, L3, L4)
        _UPVALUE1_ = L1
      end
    end
  end
  L4(L5, L6, L7, L8)
  if not L1 then
    L1 = -1673
    return L1
  end
  L4 = table
  L4 = L4.insert
  L5 = _UPVALUE3_
  L6 = _UPVALUE0_
  L4(L5, L6)
  L4 = nil
  _UPVALUE0_ = L4
  L1 = 0
  return L1
end
delUser = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = 0
  L2 = A0.user_id
  L2 = L2 or L2
  _UPVALUE0_ = L2
  L2 = _UPVALUE0_
  if L1 == 0 then
    L3 = checkUserName
    L4 = A0.user_name
    L3 = L3(L4)
    L1 = L3 or L1
    if not L3 then
    end
  end
  if L1 == 0 then
    L3 = checkName
    L4 = A0.icon
    L3 = L3(L4)
    L1 = L3 or L1
    if not L3 then
    end
  end
  if L1 ~= 0 then
    return L1
  end
  L3 = A0.user_name
  user_name = L3
  L3 = A0.icon
  icon_name = L3
  L3 = isInt
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L1 = -1672
    return L1
  end
  L3 = findUser
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L1 = -1664
    return L1
  end
  L4 = _UPVALUE1_
  L5 = L4
  L4 = L4.set
  L6 = _UPVALUE2_
  L7 = L3
  L8 = "user_name"
  L9 = user_name
  L4 = L4(L5, L6, L7, L8, L9)
  L1 = L4 or L1
  if L4 then
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.set
    L6 = _UPVALUE2_
    L7 = L3
    L8 = "icon_id"
    L9 = icon_name
    L4 = L4(L5, L6, L7, L8, L9)
    L1 = L4
  end
  if not L1 then
    L1 = -1673
    return L1
  end
  L1 = 0
  return L1
end
editUser = L17
function L17()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.foreach
  L3 = _UPVALUE1_
  L4 = "user"
  function L5(A0)
    local L1, L2, L3, L4
    L1 = {}
    L2 = tonumber
    L3 = A0.user_id
    L2 = L2(L3)
    L1.user_id = L2
    L2 = A0.device
    L2 = L2 or L2
    L1.devices = L2
    L2 = table
    L2 = L2.insert
    L3 = _UPVALUE0_
    L4 = L1
    L2(L3, L4)
  end
  L1(L2, L3, L4, L5)
  return L0
end
getDev = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L1 = L1(L2)
  if L2 ~= "table" then
    return L2
  end
  if A0 then
    for L5, L6 in L2, L3, L4 do
      L7 = L1.macaddr
      L8 = L6
      L7 = L7(L8)
      if not L7 then
        L7 = nil
        return L7
      end
      L8 = L6
      L7 = L6.upper
      L7 = L7(L8)
      A0[L5] = L7
    end
  end
  return A0
end
checkDevListFormat = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = 0
  L2 = A0.user_id
  L2 = L2 or L2
  _UPVALUE0_ = L2
  L2 = _UPVALUE0_
  L3 = checkDevListFormat
  L4 = A0.devices
  L3 = L3(L4)
  L4 = isInt
  L5 = L2
  L4 = L4(L5)
  if not L4 or not L3 then
    L1 = -1672
    return L1
  end
  L4 = nil
  L5 = false
  L6 = nil
  L7 = {}
  L8 = tonumber
  L12 = "meta"
  L13 = "dev_per_user"
  L12, L13, L14 = L9(L10, L11, L12, L13)
  L8 = L8(L9, L10, L11, L12, L13, L14)
  if not L8 then
    L1 = -1673
    return L1
  end
  for L12, L13 in L9, L10, L11 do
    L7[L13] = true
  end
  L12 = "user"
  function L13(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = A0.device
    L1 = L1 or L1
    if L2 == L3 then
      _UPVALUE1_ = L2
    else
      for L5, L6 in L2, L3, L4 do
        L7 = _UPVALUE2_
        L7 = L7[L6]
        if L7 then
          L7 = true
          _UPVALUE3_ = L7
        end
      end
    end
  end
  L9(L10, L11, L12, L13)
  if L5 then
    L1 = -1672
    return L1
  end
  if not L4 then
    L1 = -1664
    return L1
  end
  if L8 < L9 then
    L1 = -1665
    return L1
  end
  L12 = "device"
  L13 = L3
  L1 = L9
  if not L1 then
    L1 = -1673
    return L1
  end
  for L12, L13 in L9, L10, L11 do
    L14 = _UPVALUE3_
    L14 = L14 or L14
    _UPVALUE3_ = L14
    L14 = _UPVALUE3_
    L14[L13] = true
  end
  L1 = 0
  return L1
end
setDev = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = {}
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.foreach
  L4 = _UPVALUE1_
  L5 = "user_time_ban"
  function L6(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
    L1 = {}
    L2 = A0.enable
    L3 = L2
    L2 = L2.gsub
    L4 = "."
    function L5(A0)
      local L1, L2, L3, L4
      L1 = table
      L1 = L1.insert
      L2 = _UPVALUE0_
      L3 = tonumber
      L4 = A0
      L3, L4 = L3(L4)
      L1(L2, L3, L4)
      return A0
    end
    L2(L3, L4, L5)
    L2 = tonumber
    L3 = A0.user_id
    L2 = L2(L3)
    L3 = _UPVALUE0_
    if L2 == L3 then
      L2 = table
      L2 = L2.insert
      L3 = _UPVALUE1_
      L4 = {}
      L5 = A0.user_id
      L6 = "_"
      L7 = A0.start
      L8 = "_"
      L9 = A0["end"]
      L10 = "_"
      L11 = estr2num
      L12 = A0.enable
      L11 = L11(L12)
      L5 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
      L4.id = L5
      L5 = tonumber
      L6 = A0.start
      L5 = L5(L6)
      L4.start = L5
      L5 = tonumber
      L6 = A0["end"]
      L5 = L5(L6)
      L4["end"] = L5
      L4.enable = L1
      L2(L3, L4)
    end
  end
  L2(L3, L4, L5, L6)
  return L1
end
getTimeList = L17
function L17(A0)
  local L1, L2
  L1 = isInt
  L2 = A0
  L1 = L1(L2)
  L1 = L1 and 0 <= A0 and A0 <= 2880
  return L1
end
checkMins = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = ""
  if L2 ~= "table" then
    return L2
  end
  for L5, L6 in L2, L3, L4 do
    if L6 == 0 or L6 == 1 then
      L7 = L1
      L8 = tostring
      L9 = L6
      L8 = L8(L9)
      L1 = L7 .. L8
    else
      L7 = nil
      return L7
    end
  end
  return L1
end
toEnableStr = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = 0
  L2 = 1
  for L6 = L3, L4, L5 do
    L8 = A0
    L7 = A0.sub
    L9 = L6
    L10 = L6
    L7 = L7(L8, L9, L10)
    if L7 == "1" then
      L1 = L1 + L2
    end
    L2 = L2 * 2
  end
  return L1
end
estr2num = L17
function L17(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = toEnableStr
  L3 = A1.enable
  L2 = L2(L3)
  L3 = L2 or L3
  if L2 then
    L3 = checkMins
    L4 = A1.start
    L3 = L3(L4)
    if L3 then
      L3 = checkMins
      L4 = A1["end"]
      L3 = L3(L4)
      if L3 then
        L3 = A1.start
        L4 = A1["end"]
        L3 = tostring
        L4 = A0
        L3 = L3(L4)
        L4 = "_"
        L5 = tostring
        L6 = A1.start
        L5 = L5(L6)
        L6 = "_"
        L7 = tostring
        L8 = A1["end"]
        L7 = L7(L8)
        L8 = "_"
        L9 = estr2num
        L10 = L2
        L9 = L9(L10)
        L3 = L3 < L4 and L3
      end
    end
  end
  return L3
end
genBanKey = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L1 = 0
  L2 = {}
  L3 = {}
  L4 = 0
  L5 = A0.user_id
  L5 = L5 or L5
  _UPVALUE0_ = L5
  L5 = _UPVALUE0_
  L6 = A0.time_list
  L7 = isInt
  L8 = L5
  L7 = L7(L8)
  if not L7 or not L6 then
    L1 = -1672
    return L1
  end
  L7 = tonumber
  L8 = _UPVALUE1_
  L8 = L8.get
  L12 = "ban_per_user"
  L8, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21 = L8(L9, L10, L11, L12)
  L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21)
  if not L7 then
    L1 = -1673
    return L1
  end
  L8 = findUser
  L8 = L8(L9)
  if not L8 then
    L1 = -1664
    return L1
  end
  for L12, L13 in L9, L10, L11 do
    L14 = type
    L15 = L13
    L14 = L14(L15)
    if L14 ~= "table" then
      L1 = -1672
      return L1
    end
    L14 = genBanKey
    L15 = L5
    L16 = L13
    L14 = L14(L15, L16)
    L15 = type
    L16 = L13.id
    L15 = L15(L16)
    if L15 == "string" then
      L15 = L13.id
      L3[L15] = true
    end
    if L14 then
      L2[L14] = L13
      L4 = L4 + 1
    end
  end
  L12 = "user_time_ban"
  function L13(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8
    L1 = A0.user_id
    L2 = "_"
    L3 = A0.start
    L4 = "_"
    L5 = A0["end"]
    L6 = "_"
    L7 = estr2num
    L8 = A0.enable
    L7 = L7(L8)
    L1 = L1 .. L2 .. L3 .. L4 .. L5 .. L6 .. L7
    L2 = _UPVALUE0_
    L2 = L2[L1]
    if L2 then
      L2 = _UPVALUE1_
      if L2 == 0 then
        L2 = _UPVALUE2_
        L3 = L2
        L2 = L2.delete
        L4 = _UPVALUE3_
        L5 = A0[".name"]
        L2 = L2(L3, L4, L5)
        if L2 then
          L2 = 0
          if L2 then
            goto lbl_32
          end
        end
        L2 = -1673
        if L2 then
          goto lbl_32
        end
      end
      L2 = _UPVALUE1_
      ::lbl_32::
      _UPVALUE1_ = L2
    else
      L2 = _UPVALUE4_
      L2 = L2[L1]
      if L2 then
        L2 = -1670
        _UPVALUE1_ = L2
      else
        L2 = A0.user_id
        L3 = tostring
        L4 = _UPVALUE5_
        L3 = L3(L4)
        if L2 == L3 then
          L2 = _UPVALUE6_
          L2 = L2 + 1
          _UPVALUE6_ = L2
        end
      end
    end
  end
  L9(L10, L11, L12, L13)
  if L1 ~= 0 then
    return L1
  end
  if L7 < L4 then
    L1 = -1666
    return L1
  end
  for L12, L13 in L9, L10, L11 do
    L14 = checkMins
    L15 = L13.start
    L14 = L14(L15)
    if L14 then
      L14 = checkMins
      L15 = L13["end"]
      L14 = L14(L15)
      if L14 then
        L14 = L13.start
        L15 = L13["end"]
        L14 = toEnableStr
        L15 = L13.enable
        L14 = L14 < L15 and L14
      end
    end
    if L14 then
      L15 = _UPVALUE1_
      L16 = L15
      L15 = L15.add
      L17 = _UPVALUE2_
      L18 = "user_time_ban"
      L15 = L15(L16, L17, L18)
      L1 = L15 or L1
      if L15 then
        L16 = _UPVALUE1_
        L17 = L16
        L16 = L16.set
        L18 = _UPVALUE2_
        L19 = L15
        L20 = "user_id"
        L21 = L5
        L16 = L16(L17, L18, L19, L20, L21)
        L1 = L16 or L1
        if L16 then
          L16 = _UPVALUE1_
          L17 = L16
          L16 = L16.set
          L18 = _UPVALUE2_
          L19 = L15
          L20 = "start"
          L21 = L13.start
          L16 = L16(L17, L18, L19, L20, L21)
          L1 = L16 or L1
          if L16 then
            L16 = _UPVALUE1_
            L17 = L16
            L16 = L16.set
            L18 = _UPVALUE2_
            L19 = L15
            L20 = "end"
            L21 = L13["end"]
            L16 = L16(L17, L18, L19, L20, L21)
            L1 = L16 or L1
            if L16 then
              L16 = _UPVALUE1_
              L17 = L16
              L16 = L16.set
              L18 = _UPVALUE2_
              L19 = L15
              L20 = "enable"
              L21 = L14
              L16 = L16(L17, L18, L19, L20, L21)
              L1 = L16
            end
          end
        end
      end
    end
    if not L14 or not L1 then
      L1 = -1672
      return L1
    end
  end
  L1 = 0
  return L1
end
setTimeList = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get_all
  L3 = _UPVALUE1_
  L4 = "meta"
  L1 = L1(L2, L3, L4)
  L2 = L1 or L2
  if L1 then
    L2 = L1.appinfo_version
  end
  L3 = {}
  if not L2 or L2 ~= A0 then
    L4 = nil
    return L4
  end
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.foreach
  L6 = _UPVALUE1_
  L7 = "app_class"
  function L8(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
    L1 = {}
    L2 = {}
    for L6, L7 in L3, L4, L5 do
      L9 = L7
      L8 = L7.find
      L10 = ":"
      L8, L9 = L8(L9, L10)
      L11 = L7
      L10 = L7.sub
      L12 = 1
      L13 = 1
      L10 = L10(L11, L12, L13)
      if L10 == "_" then
        L10 = table
        L10 = L10.insert
        L11 = L2
        L12 = {}
        L14 = L7
        L13 = L7.sub
        L15 = 1
        L16 = L8 - 1
        L13 = L13(L14, L15, L16)
        L12.name = L13
        L12.enable = false
        L10(L11, L12)
      else
        L10 = table
        L10 = L10.insert
        L11 = L2
        L12 = {}
        L14 = L7
        L13 = L7.sub
        L15 = 1
        L16 = L8 - 1
        L13 = L13(L14, L15, L16)
        L12.name = L13
        L12.enable = true
        L10(L11, L12)
      end
    end
    L1.enable = false
    L1.time_quota = 120
    L1.app_list = L2
    L3[L4] = L1
  end
  L4(L5, L6, L7, L8)
  return L3
end
appCfgTplt = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = type
  L2 = A0
  L1 = L1(L2)
  L2 = nil
  if L1 == "table" then
    L2 = L3
    for L6, L7 in L3, L4, L5 do
      L2[L6] = L7
    end
  else
    L2 = A0
  end
  return L2
end
shallowcopy = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = _UPVALUE1_
  L1 = L1(L2, L3, L4, L5)
  L2 = appCfgTplt
  L3 = L1
  L2 = L2(L3)
  L3 = {}
  if L2 then
    L7 = "user_class_config"
    function L8(A0)
      local L1, L2, L3, L4, L5, L6, L7, L8, L9
      L1 = tonumber
      L1 = L1(L2)
      if L1 == L2 then
        L1 = _UPVALUE1_
        L1 = L1[L2]
        if L2 == "true" then
          if L2 then
            goto lbl_17
          end
        end
        ::lbl_17::
        L1.enable = L2
        L1.time_quota = L2
        for L5 = L2, L3, L4 do
          L6 = A0.app_bitmask
          L7 = L6
          L6 = L6.sub
          L8 = L5
          L9 = L5
          L6 = L6(L7, L8, L9)
          if L6 == "0" then
            L6 = L1.app_list
            L6 = L6[L5]
            L6.enable = false
          else
            L6 = L1.app_list
            L6 = L6[L5]
            L6.enable = true
          end
        end
      end
    end
    L4(L5, L6, L7, L8)
    for L7, L8 in L4, L5, L6 do
      L8.class_name = L7
      L9 = L7.sub
      L9 = L9(L10, L11, L12)
      if L9 ~= "_" then
        L9 = shallowcopy
        L9 = L9(L10)
        L9.app_list = L10
        for L13, L14 in L10, L11, L12 do
          L15 = L14.name
          L16 = L15
          L15 = L15.sub
          L17 = 1
          L18 = 1
          L15 = L15(L16, L17, L18)
          if L15 ~= "_" then
            L15 = table
            L15 = L15.insert
            L16 = L9.app_list
            L17 = L14
            L15(L16, L17)
          end
        end
        L10(L11, L12)
      end
    end
  end
  return L4, L5
end
getApp = L17
function L17(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = {}
  if L4 then
    if not L4 then
      goto lbl_29
    end
    if L4 < 0 then
      goto lbl_29
    end
  end
  if L4 then
    if L4 ~= "table" then
      goto lbl_29
    end
  end
  if L4 then
    ::lbl_29::
    if L4 ~= "boolean" then
      return L4
    end
  end
  if L4 == "boolean" then
    A1.enable = L4
  end
  if L4 then
    A1.time_quota = L4
  end
  if L4 then
    for L7, L8 in L4, L5, L6 do
      L9 = type
      L10 = L8.enable
      L9 = L9(L10)
      if L9 ~= "boolean" then
        L9 = false
        return L9
      end
      L9 = L8.name
      L3[L9] = L8
    end
    for L7, L8 in L4, L5, L6 do
      L9 = L8.name
      if L9 then
        L9 = L8.name
        L9 = L3[L9]
        if L9 then
          L9 = L8.name
          L9 = L3[L9]
          L10 = L8.enable
          L9.enable = L10
      end
      else
        L9 = false
        return L9
      end
    end
  end
  A0[L4] = A1
  return L4
end
setSingleClass = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = ""
  for L5, L6 in L2, L3, L4 do
    L7 = L1
    L8 = L6.enable
    if L8 then
      L8 = "1"
      if L8 then
        goto lbl_14
      end
    end
    L8 = "0"
    ::lbl_14::
    L1 = L7 .. L8
  end
  return L1
end
toEnableStrV2 = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L1 = 0
  L2 = A0.user_id
  L2 = L2 or L2
  _UPVALUE0_ = L2
  L2 = _UPVALUE0_
  L3 = A0.list
  L4 = findUser
  L5 = L2
  L4 = L4(L5)
  L5 = nil
  L6 = {}
  if L4 then
    L5 = L8
    _ = L7
  end
  if not (L2 and L5) or not L3 then
    L1 = -1672
    return L1
  end
  for L10, L11 in L7, L8, L9 do
    L12 = L11.class_name
    if L12 then
      L12 = L11.class_name
      L12 = L5[L12]
    end
    if L12 then
      L13 = setSingleClass
      L14 = L6
      L15 = L12
      L16 = L11
      L13 = L13(L14, L15, L16)
      if L13 then
        goto lbl_49
      end
    end
    L1 = -1672
    do return L1 end
    ::lbl_49::
  end
  L10 = "user_class_config"
  function L11(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9
    L1 = tonumber
    L2 = A0.user_id
    L1 = L1(L2)
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = _UPVALUE1_
      L2 = A0.class_name
      L1 = L1[L2]
      if L1 ~= nil then
        L1 = _UPVALUE1_
        L2 = A0.class_name
        L1 = L1[L2]
        L2 = A0[".name"]
        L3 = _UPVALUE2_
        if L3 then
          L3 = _UPVALUE3_
          L4 = L3
          L3 = L3.set
          L5 = _UPVALUE4_
          L6 = L2
          L7 = "enable"
          L8 = tostring
          L9 = L1.enable
          L8, L9 = L8(L9)
          L3 = L3(L4, L5, L6, L7, L8, L9)
        end
        _UPVALUE2_ = L3
        L3 = _UPVALUE2_
        if L3 then
          L3 = _UPVALUE3_
          L4 = L3
          L3 = L3.set
          L5 = _UPVALUE4_
          L6 = L2
          L7 = "time_quota"
          L8 = L1.time_quota
          L3 = L3(L4, L5, L6, L7, L8)
        end
        _UPVALUE2_ = L3
        L3 = _UPVALUE2_
        if L3 then
          L3 = _UPVALUE3_
          L4 = L3
          L3 = L3.set
          L5 = _UPVALUE4_
          L6 = L2
          L7 = "app_bitmask"
          L8 = toEnableStrV2
          L9 = L1.app_list
          L8, L9 = L8(L9)
          L3 = L3(L4, L5, L6, L7, L8, L9)
        end
        _UPVALUE2_ = L3
        L3 = _UPVALUE1_
        L4 = A0.class_name
        L3[L4] = nil
      end
    end
  end
  L7(L8, L9, L10, L11)
  for L10, L11 in L7, L8, L9 do
    L12 = L11.time_quota
    if L12 ~= -1 then
      L12 = L1 or L12
      if L1 then
        L12 = _UPVALUE1_
        L13 = L12
        L12 = L12.add
        L14 = _UPVALUE2_
        L15 = "user_class_config"
        L12 = L12(L13, L14, L15)
      end
      L1 = L12 or L1
      if L12 then
        L13 = _UPVALUE1_
        L14 = L13
        L13 = L13.set
        L15 = _UPVALUE2_
        L16 = L12
        L17 = "user_id"
        L18 = L2
        L13 = L13(L14, L15, L16, L17, L18)
        L1 = L13 or L1
        if L13 then
          L13 = _UPVALUE1_
          L14 = L13
          L13 = L13.set
          L15 = _UPVALUE2_
          L16 = L12
          L17 = "class_name"
          L18 = L10
          L13 = L13(L14, L15, L16, L17, L18)
          L1 = L13 or L1
          if L13 then
            L13 = _UPVALUE1_
            L14 = L13
            L13 = L13.set
            L15 = _UPVALUE2_
            L16 = L12
            L17 = "enable"
            L18 = tostring
            L19 = L11.enable
            L18, L19 = L18(L19)
            L13 = L13(L14, L15, L16, L17, L18, L19)
            L1 = L13 or L1
            if L13 then
              L13 = _UPVALUE1_
              L14 = L13
              L13 = L13.set
              L15 = _UPVALUE2_
              L16 = L12
              L17 = "time_quota"
              L18 = L11.time_quota
              L13 = L13(L14, L15, L16, L17, L18)
              L1 = L13 or L1
              if L13 then
                L13 = _UPVALUE1_
                L14 = L13
                L13 = L13.set
                L15 = _UPVALUE2_
                L16 = L12
                L17 = "app_bitmask"
                L18 = toEnableStrV2
                L19 = L11.app_list
                L18, L19 = L18(L19)
                L13 = L13(L14, L15, L16, L17, L18, L19)
                L1 = L13
              end
            end
          end
        end
      end
    end
  end
  if not L1 then
    L1 = -1673
    return L1
  end
  L1 = 0
  return L1
end
setApp = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L1 = L1(L2)
  if L2 ~= "table" then
    return L2
  end
  if A0 then
    for L5, L6 in L2, L3, L4 do
      L7 = L1.host
      L8 = L6
      L7 = L7(L8)
      if not L7 then
        L8 = L6
        L7 = L6.match
        L9 = "^[a-zA-Z0-9_.]+$"
        L7 = L7(L8, L9)
        if not L7 then
          L7 = -1669
          return L7
        end
      end
      L7 = string
      L7 = L7.lower
      L8 = L6
      L7 = L7(L8)
      A0[L5] = L7
    end
  end
  return A0
end
checkHostListFormat = L17
function L17(A0)
  local L1, L2, L3
  L1 = findUser
  L2 = A0
  L1, L2 = L1(L2)
  if L2 then
    L3 = L2.host_list
    if L3 then
      goto lbl_10
    end
  end
  L3 = {}
  ::lbl_10::
  return L3
end
getHosts = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = 0
  L2 = A0.user_id
  L2 = L2 or L2
  _UPVALUE0_ = L2
  L2 = _UPVALUE0_
  L3 = checkHostListFormat
  L4 = A0.list
  L3 = L3(L4)
  L4 = isInt
  L5 = L2
  L4 = L4(L5)
  if not L4 then
    L1 = -1672
    return L1
  end
  L4 = type
  L5 = L3
  L4 = L4(L5)
  if L4 ~= "table" then
    L4 = type
    L5 = L3
    L4 = L4(L5)
    L1 = L3 or L1
    if L4 ~= "number" or not L3 then
      L1 = -1672
    end
    return L1
  end
  L4 = findUser
  L5 = L2
  L4, L5 = L4(L5)
  L6 = false
  L7 = {}
  if not L4 then
    L1 = -1664
    return L1
  end
  for L11, L12 in L8, L9, L10 do
    L13 = L7[L12]
    if L13 then
      L6 = true
    end
    L7[L12] = true
  end
  if L6 then
    L1 = -1672
    return L1
  end
  L11 = _UPVALUE2_
  L12 = "meta"
  L13 = "host_per_user"
  L11, L12, L13 = L9(L10, L11, L12, L13)
  if not L8 then
    L1 = -1673
    return L1
  end
  if L8 < L9 then
    L1 = -1667
    return L1
  end
  L11 = L4
  L12 = "host_list"
  L13 = L3
  L1 = L9
  if not L1 then
    L1 = -1673
    return L1
  end
  L1 = 0
  return L1
end
setHosts = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = findUser
  L2 = A0
  L1, L2 = L1(L2)
  L3 = {}
  if not L2 then
    L4 = nil
    return L4
  end
  L4 = isTempBan
  L5 = L2
  L4 = L4(L5)
  L3.deny = L4
  L4 = L3.deny
  if not L4 then
    L4 = allowAccess
    L5 = tonumber
    L6 = L2.user_id
    L5, L6 = L5(L6)
    L4 = L4(L5, L6)
  end
  L3.show = L4
  L4 = cal_nxt_permit_time
  L5 = L2
  L4 = L4(L5)
  L3.nxt_permit = L4
  return L3
end
getTempBan = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = 0
  L2 = A0.user_id
  L2 = L2 or L2
  _UPVALUE0_ = L2
  L2 = _UPVALUE0_
  L3 = A0.deny
  L4 = isInt
  L5 = L2
  L4 = L4(L5)
  if not L4 or L3 == nil then
    L1 = -1672
    return L1
  end
  L4 = findUser
  L5 = L2
  L4, L5 = L4(L5)
  if not L5 then
    L6 = -1664
    return L6
  end
  if L3 then
    L6 = allowAccess
    L7 = tonumber
    L8 = L5.user_id
    L7, L8, L9, L10, L11 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11)
    if not L6 then
      L1 = -1671
      return L1
    end
  end
  L6 = _UPVALUE1_
  L7 = L6
  L6 = L6.set
  L8 = _UPVALUE2_
  L9 = L4
  L10 = "temp_ban"
  if L3 then
    L11 = "1"
    if L11 then
      goto lbl_47
    end
  end
  L11 = "0"
  ::lbl_47::
  L6 = L6(L7, L8, L9, L10, L11)
  L1 = L6
  if not L1 then
    L1 = -1673
    return L1
  end
  L1 = 0
  return L1
end
setTempBan = L17
function L17(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
  L2 = require
  L3 = "ubus"
  L2 = L2(L3)
  L3 = L2.connect
  L3 = L3()
  if L3 then
    L5 = L3
    L4 = L3.call
    L6 = "mipctl"
    L7 = "read_user_state2"
    L8 = {}
    L8.user_id = A0
    L8.date_index = A1
    L4 = L4(L5, L6, L7, L8)
    L6 = L3
    L5 = L3.close
    L5(L6)
    if L4 then
      return L4
    end
  end
  if A1 == 7 then
    L4 = {}
    L5 = {}
    L6 = 0
    L7 = 0
    L8 = 0
    L9 = 0
    L10 = 0
    L11 = 0
    L12 = 0
    L5[1] = L6
    L5[2] = L7
    L5[3] = L8
    L5[4] = L9
    L5[5] = L10
    L5[6] = L11
    L5[7] = L12
    L4.online = L5
    L4.anti_addict = -1
    L4.filting_net = -1
    L5 = os
    L5 = L5.date
    L6 = "%Y-%m-%d"
    L5 = L5(L6)
    L4.cur_date = L5
    L5 = get_timezone_offset
    L5 = L5()
    L6 = tonumber
    L7 = os
    L7 = L7.date
    L8 = "%s"
    L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29)
    L5 = L5 + L6
    L4.timestamp = L5
    L5 = {}
    L4.appclass_stats = L5
    return L4
  else
    L4 = {}
    L5 = {}
    L6 = 0
    L7 = 0
    L8 = 0
    L9 = 0
    L10 = 0
    L11 = 0
    L12 = 0
    L13 = 0
    L14 = 0
    L15 = 0
    L16 = 0
    L17 = 0
    L18 = 0
    L19 = 0
    L20 = 0
    L21 = 0
    L22 = 0
    L23 = 0
    L24 = 0
    L25 = 0
    L26 = 0
    L27 = 0
    L28 = 0
    L29 = 0
    L5[1] = L6
    L5[2] = L7
    L5[3] = L8
    L5[4] = L9
    L5[5] = L10
    L5[6] = L11
    L5[7] = L12
    L5[8] = L13
    L5[9] = L14
    L5[10] = L15
    L5[11] = L16
    L5[12] = L17
    L5[13] = L18
    L5[14] = L19
    L5[15] = L20
    L5[16] = L21
    L5[17] = L22
    L5[18] = L23
    L5[19] = L24
    L5[20] = L25
    L5[21] = L26
    L5[22] = L27
    L5[23] = L28
    L5[24] = L29
    L4.online = L5
    L4.anti_addict = -1
    L4.filting_net = -1
    L5 = os
    L5 = L5.date
    L6 = "%Y-%m-%d"
    L5 = L5(L6)
    L4.cur_date = L5
    L5 = get_timezone_offset
    L5 = L5()
    L6 = tonumber
    L7 = os
    L7 = L7.date
    L8 = "%s"
    L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29 = L7(L8)
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29)
    L5 = L5 + L6
    L4.timestamp = L5
    L5 = {}
    L4.appclass_stats = L5
    return L4
  end
end
getUserStat = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  L2 = nil
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = _UPVALUE1_
  L6 = "meta"
  L7 = "appinfo_version"
  L3 = L3(L4, L5, L6, L7)
  L1.version = L3
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get_all
  L5 = _UPVALUE2_
  L6 = "meta"
  L3 = L3(L4, L5, L6)
  L2 = L3
  if L2 then
    L3 = 1
    if L3 then
      goto lbl_22
    end
  end
  L3 = 0
  ::lbl_22::
  L1.upgraded = L3
  if L2 then
    L3 = L2.date
    L1.date = L3
    L3 = L2.msg
    L3 = L3 or L3
    L1.msg = L3
  end
  if 1 == A0 then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.delete
    L5 = _UPVALUE2_
    L6 = "meta"
    L3(L4, L5, L6)
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.commit
    L5 = _UPVALUE2_
    L3(L4, L5)
  end
  return L1
end
getDPIInfo = L17
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25
  L1 = require
  L2 = "socket"
  L1 = L1(L2)
  L2 = require
  L3 = "posix.fcntl"
  L2 = L2(L3)
  L3 = require
  L4 = "posix.sys.stat"
  L3 = L3(L4)
  L4 = L2.open
  L5 = "/tmp/lock/mipctl_usercfg.lock"
  L6 = L2.O_CREAT
  L7 = L2.O_WRONLY
  L6 = L6 + L7
  L7 = L2.O_TRUNC
  L6 = L6 + L7
  L7 = L3.IRWXU
  L4 = L4(L5, L6, L7)
  L5 = {}
  L6 = L2.F_WRLCK
  L5.l_type = L6
  L6 = L2.SEEK_SET
  L5.l_whence = L6
  L5.l_start = 0
  L5.l_len = 0
  while true do
    L6 = L2.fcntl
    L7 = L4
    L8 = L2.F_SETLK
    L9 = L5
    L6 = L6(L7, L8, L9)
    if L6 ~= nil then
      break
    end
    L6 = L1.sleep
    L7 = 0.1
    L6(L7)
  end
  L6 = 0
  L7 = _UPVALUE0_
  L7 = L7.decode
  L8 = A0
  L7 = L7(L8)
  L8 = nil
  L9 = {}
  L9.mipctl_add_user = L10
  L9.mipctl_del_user = L10
  L9.mipctl_edit_user = L10
  L9.mipctl_set_device = L10
  L9.mipctl_set_filting_net = L10
  L9.mipctl_set_deny_time = L10
  L9.mipctl_set_app_antiaddict = L10
  L9.mipctl_set_temp_deny = L10
  _UPVALUE1_ = L10
  for L13, L14 in L10, L11, L12 do
    if L6 == 0 then
      if L15 then
        L16 = L14
        if L15 then
          goto lbl_81
          L6 = L15 or L6
        end
      end
      L6 = L15 or L6
      if not L15 then
      end
    end
    ::lbl_81::
  end
  if L6 == 0 then
    if L10 then
      if L10 then
        goto lbl_95
        L6 = L10 or L6
      end
    end
    L6 = -1673
  end
  ::lbl_95::
  if L6 ~= 0 then
    L10(L11, L12)
  end
  if L6 == 0 then
    if not L11 then
      L6 = -1674
    else
      L16 = {}
      L17 = _UPVALUE3_
      L16.config = L17
      L12(L13, L14, L15, L16)
      L12(L13)
    end
  end
  if 0 == L6 then
    if L11 then
      for L15, L16 in L12, L13, L14 do
        L17 = _UPVALUE4_
        L18 = L16.user_id
        if L17 == L18 then
          L8 = L16
          break
        end
      end
      for L16, L17 in L13, L14, L15 do
        L8[L16] = L17
      end
    end
  end
  if L11 then
    for L16, L17 in L13, L14, L15 do
      L18 = L17.mac
      L19 = L17.authority
      L19 = L19.wan
      L20 = _UPVALUE6_
      L20 = L20.isStrNil
      L21 = L18
      L20 = L20(L21)
      if not L20 then
        L20 = _UPVALUE5_
        L22 = L18
        L21 = L18.upper
        L21 = L21(L22)
        L20 = L20[L21]
        if L20 and L19 == 0 then
          L20 = require
          L21 = "luci.controller.api.xqsystem"
          L20 = L20(L21)
          L21 = L20._setMacFilter
          L23 = L18
          L22 = L18.upper
          L22 = L22(L23)
          L23, L24 = nil, nil
          L25 = "1"
          L21(L22, L23, L24, L25)
        end
      end
    end
  end
  return L11, L12
end
set = L17
function L17(A0)
  local L1, L2, L3, L4
  L1 = assert
  L2 = io
  L2 = L2.open
  L3 = A0
  L4 = "rb"
  L2, L3, L4 = L2(L3, L4)
  L1 = L1(L2, L3, L4)
  L3 = L1
  L2 = L1.read
  L4 = "*all"
  L2 = L2(L3, L4)
  L4 = L1
  L3 = L1.close
  L3(L4)
  return L2
end
readAll = L17
