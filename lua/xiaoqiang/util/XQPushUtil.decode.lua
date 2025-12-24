local L0, L1, L2
L0 = module
L1 = "xiaoqiang.util.XQPushUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
function L1()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.auth = true
  L1.quiet = false
  L1.level = 2
  L3 = L0
  L2 = L0.get_all
  L4 = "devicelist"
  L5 = "settings"
  L2 = L2(L3, L4, L5)
  L4 = L0
  L3 = L0.get_all
  L5 = "devicelist"
  L3 = L3(L4, L5, L6)
  L5 = L0
  L4 = L0.get_all
  L4 = L4(L5, L6, L7)
  L5 = 0
  if L3 then
    for L9, L10 in L6, L7, L8 do
      if L9 then
        L11 = tonumber
        L12 = L10
        L11 = L11(L12)
        if L11 then
          L12 = L9
          L11 = L9.match
          L13 = "^%."
          L11 = L11(L12, L13)
          if not L11 then
            L11 = tonumber
            L12 = L10
            L11 = L11(L12)
            L5 = L5 + L11
          end
        end
      end
    end
  end
  if L4 then
    for L9, L10 in L6, L7, L8 do
      if L9 then
        L11 = tonumber
        L12 = L10
        L11 = L11(L12)
        if L11 then
          L12 = L9
          L11 = L9.match
          L13 = "^%."
          L11 = L11(L12, L13)
          if not L11 then
            L11 = tonumber
            L12 = L10
            L11 = L11(L12)
            L5 = L5 + L11
          end
        end
      end
    end
  end
  L1.count = L5
  if L2 then
    if L6 == 0 then
      L1.auth = false
    else
      L1.auth = true
    end
    if L6 == 1 then
      if L6 then
        goto lbl_91
      end
    end
    ::lbl_91::
    L1.quiet = L6
    L1.level = L6
  end
  return L1
end
pushSettings = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get_all
  L5 = "devicelist"
  L6 = "settings"
  L3 = L3(L4, L5, L6)
  if L3 then
    L3[A0] = A1
  else
    L4 = {}
    L3 = L4
    L3[A0] = A1
  end
  L5 = L2
  L4 = L2.section
  L6 = "devicelist"
  L7 = "core"
  L8 = "settings"
  L9 = L3
  L4(L5, L6, L7, L8, L9)
  L5 = L2
  L4 = L2.commit
  L6 = "devicelist"
  L4(L5, L6)
end
pushConfig = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "devicelist"
  L5 = "timestamp"
  L6 = A0
  L2 = L2(L3, L4, L5, L6)
  L3 = tonumber
  L4 = L2
  L3 = L3(L4)
  L3 = L3 or L3
  return L3
end
getTimestamp = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  if not A0 or not A1 then
    return
  end
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get_all
  L5 = "devicelist"
  L6 = "timestamp"
  L3 = L3(L4, L5, L6)
  if not L3 then
    L4 = {}
    L3 = L4
  end
  L3[A0] = A1
  L5 = L2
  L4 = L2.section
  L6 = "devicelist"
  L7 = "record"
  L8 = "timestamp"
  L9 = L3
  L4(L5, L6, L7, L8, L9)
  L5 = L2
  L4 = L2.commit
  L6 = "devicelist"
  L4 = L4(L5, L6)
  if not L4 then
    L4 = false
    return L4
  end
  L4 = true
  return L4
end
setTimestamp = L1
function L1()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get_all
  L3 = "devicelist"
  L4 = "authfail"
  L1 = L1(L2, L3, L4)
  L2 = L1 or L2
  if not L1 then
    L2 = {}
  end
  return L2
end
getAuthenFailedTimesDict = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    return
  else
    L1 = _UPVALUE0_
    L1 = L1.macFormat
    L2 = A0
    L1 = L1(L2)
    A0 = L1
  end
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L4 = L1
  L3 = L1.get_all
  L5 = "devicelist"
  L6 = "authfailserial"
  L3 = L3(L4, L5, L6)
  if not L3 then
    L4 = L1
    L3 = L1.section
    L5 = "devicelist"
    L6 = "record"
    L7 = "authfailserial"
    L8 = {}
    L3(L4, L5, L6, L7, L8)
    L4 = L1
    L3 = L1.commit
    L5 = "devicelist"
    L3(L4, L5)
    L3 = 0
    return L3
  else
    L4 = L1
    L3 = L1.get
    L5 = "devicelist"
    L6 = "authfailserial"
    L7 = L2
    L3 = L3(L4, L5, L6, L7)
    if L3 then
      L4 = tonumber
      L5 = L3
      L4 = L4(L5)
      if L4 then
        L4 = tonumber
        L5 = L3
        return L4(L5)
    end
    else
      L4 = 0
      return L4
    end
  end
end
getwifiauthfailedserialtimes = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = tonumber
    L3 = A1
    L2 = L2(L3)
    if L2 then
      goto lbl_14
    end
  end
  do return end
  goto lbl_19
  ::lbl_14::
  L2 = _UPVALUE0_
  L2 = L2.macFormat
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  ::lbl_19::
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = A0
  L3 = A0.gsub
  L5 = ":"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L5 = L2
  L4 = L2.get_all
  L6 = "devicelist"
  L7 = "authfailserial"
  L4 = L4(L5, L6, L7)
  if not L4 then
    L5 = {}
    L4 = L5
  end
  L4[L3] = A1
  L6 = L2
  L5 = L2.section
  L7 = "devicelist"
  L8 = "record"
  L9 = "authfailserial"
  L10 = L4
  L5(L6, L7, L8, L9, L10)
  L6 = L2
  L5 = L2.commit
  L7 = "devicelist"
  L5(L6, L7)
end
setwifiauthfailedserialtimes = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    return
  else
    L1 = _UPVALUE0_
    L1 = L1.macFormat
    L2 = A0
    L1 = L1(L2)
    A0 = L1
  end
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L4 = L1
  L3 = L1.get_all
  L5 = "devicelist"
  L6 = "authfail"
  L3 = L3(L4, L5, L6)
  if not L3 then
    L4 = L1
    L3 = L1.section
    L5 = "devicelist"
    L6 = "record"
    L7 = "authfail"
    L8 = {}
    L3(L4, L5, L6, L7, L8)
    L4 = L1
    L3 = L1.commit
    L5 = "devicelist"
    L3(L4, L5)
    L3 = 0
    return L3
  else
    L4 = L1
    L3 = L1.get
    L5 = "devicelist"
    L6 = "authfail"
    L7 = L2
    L3 = L3(L4, L5, L6, L7)
    if L3 then
      L4 = tonumber
      L5 = L3
      L4 = L4(L5)
      if L4 then
        L4 = tonumber
        L5 = L3
        return L4(L5)
    end
    else
      L4 = 0
      return L4
    end
  end
end
getAuthenFailedTimes = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = tonumber
    L3 = A1
    L2 = L2(L3)
    if L2 then
      goto lbl_14
    end
  end
  do return end
  goto lbl_19
  ::lbl_14::
  L2 = _UPVALUE0_
  L2 = L2.macFormat
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  ::lbl_19::
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = A0
  L3 = A0.gsub
  L5 = ":"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L5 = L2
  L4 = L2.get_all
  L6 = "devicelist"
  L7 = "authfail"
  L4 = L4(L5, L6, L7)
  if not L4 then
    L5 = {}
    L4 = L5
  end
  L4[L3] = A1
  L6 = L2
  L5 = L2.section
  L7 = "devicelist"
  L8 = "record"
  L9 = "authfail"
  L10 = L4
  L5(L6, L7, L8, L9, L10)
  L6 = L2
  L5 = L2.commit
  L7 = "devicelist"
  L5(L6, L7)
end
setAuthenFailedTimes = L1
function L1()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get_all
  L3 = "devicelist"
  L4 = "wififrequency"
  L1 = L1(L2, L3, L4)
  L2 = L1 or L2
  if not L1 then
    L2 = {}
  end
  return L2
end
getWifiAuthenFailedFrequencyDict = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    return
  else
    L1 = _UPVALUE0_
    L1 = L1.macFormat
    L2 = A0
    L1 = L1(L2)
    A0 = L1
  end
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L4 = L1
  L3 = L1.get_all
  L5 = "devicelist"
  L6 = "wififrequency"
  L3 = L3(L4, L5, L6)
  if not L3 then
    L4 = L1
    L3 = L1.section
    L5 = "devicelist"
    L6 = "record"
    L7 = "wififrequency"
    L8 = {}
    L3(L4, L5, L6, L7, L8)
    L4 = L1
    L3 = L1.commit
    L5 = "devicelist"
    L3(L4, L5)
    L3 = 0
    return L3
  else
    L4 = L1
    L3 = L1.get
    L5 = "devicelist"
    L6 = "wififrequency"
    L7 = L2
    L3 = L3(L4, L5, L6, L7)
    if L3 then
      L4 = tonumber
      L5 = L3
      L4 = L4(L5)
      if L4 then
        L4 = tonumber
        L5 = L3
        return L4(L5)
    end
    else
      L4 = 0
      return L4
    end
  end
end
getWifiAuthenFailedFrequency = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = tonumber
    L3 = A1
    L2 = L2(L3)
    if L2 then
      goto lbl_14
    end
  end
  do return end
  goto lbl_19
  ::lbl_14::
  L2 = _UPVALUE0_
  L2 = L2.macFormat
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  ::lbl_19::
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = A0
  L3 = A0.gsub
  L5 = ":"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L5 = L2
  L4 = L2.get_all
  L6 = "devicelist"
  L7 = "wififrequency"
  L4 = L4(L5, L6, L7)
  if not L4 then
    L5 = {}
    L4 = L5
  end
  L4[L3] = A1
  L6 = L2
  L5 = L2.section
  L7 = "devicelist"
  L8 = "record"
  L9 = "wififrequency"
  L10 = L4
  L5(L6, L7, L8, L9, L10)
  L6 = L2
  L5 = L2.commit
  L7 = "devicelist"
  L5(L6, L7)
end
setWifiAuthenFailedFrequency = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    return
  else
    L1 = _UPVALUE0_
    L1 = L1.macFormat
    L2 = A0
    L1 = L1(L2)
    A0 = L1
  end
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L4 = L1
  L3 = L1.get_all
  L5 = "devicelist"
  L6 = "loginauthfail"
  L3 = L3(L4, L5, L6)
  if not L3 then
    L4 = L1
    L3 = L1.section
    L5 = "devicelist"
    L6 = "record"
    L7 = "loginauthfail"
    L8 = {}
    L3(L4, L5, L6, L7, L8)
    L4 = L1
    L3 = L1.commit
    L5 = "devicelist"
    L3(L4, L5)
    L3 = 0
    return L3
  else
    L4 = L1
    L3 = L1.get
    L5 = "devicelist"
    L6 = "loginauthfail"
    L7 = L2
    L3 = L3(L4, L5, L6, L7)
    if L3 then
      L4 = tonumber
      L5 = L3
      L4 = L4(L5)
      if L4 then
        L4 = tonumber
        L5 = L3
        return L4(L5)
    end
    else
      L4 = 0
      return L4
    end
  end
end
getLoginAuthenFailedTimes = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = tonumber
    L3 = A1
    L2 = L2(L3)
    if L2 then
      goto lbl_14
    end
  end
  do return end
  goto lbl_19
  ::lbl_14::
  L2 = _UPVALUE0_
  L2 = L2.macFormat
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  ::lbl_19::
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = A0
  L3 = A0.gsub
  L5 = ":"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L5 = L2
  L4 = L2.get_all
  L6 = "devicelist"
  L7 = "loginauthfail"
  L4 = L4(L5, L6, L7)
  if not L4 then
    L5 = {}
    L4 = L5
  end
  L4[L3] = A1
  L6 = L2
  L5 = L2.section
  L7 = "devicelist"
  L8 = "record"
  L9 = "loginauthfail"
  L10 = L4
  L5(L6, L7, L8, L9, L10)
  L6 = L2
  L5 = L2.commit
  L7 = "devicelist"
  L5(L6, L7)
end
setLoginAuthenFailedTimes = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    return
  else
    L1 = _UPVALUE0_
    L1 = L1.macFormat
    L2 = A0
    L1 = L1(L2)
    A0 = L1
  end
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L4 = L1
  L3 = L1.get_all
  L5 = "devicelist"
  L6 = "loginfrequency"
  L3 = L3(L4, L5, L6)
  if not L3 then
    L4 = L1
    L3 = L1.section
    L5 = "devicelist"
    L6 = "record"
    L7 = "loginfrequency"
    L8 = {}
    L3(L4, L5, L6, L7, L8)
    L4 = L1
    L3 = L1.commit
    L5 = "devicelist"
    L3(L4, L5)
    L3 = 0
    return L3
  else
    L4 = L1
    L3 = L1.get
    L5 = "devicelist"
    L6 = "loginfrequency"
    L7 = L2
    L3 = L3(L4, L5, L6, L7)
    if L3 then
      L4 = tonumber
      L5 = L3
      L4 = L4(L5)
      if L4 then
        L4 = tonumber
        L5 = L3
        return L4(L5)
    end
    else
      L4 = 0
      return L4
    end
  end
end
getLoginAuthenFailedFrequency = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = tonumber
    L3 = A1
    L2 = L2(L3)
    if L2 then
      goto lbl_14
    end
  end
  do return end
  goto lbl_19
  ::lbl_14::
  L2 = _UPVALUE0_
  L2 = L2.macFormat
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  ::lbl_19::
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = A0
  L3 = A0.gsub
  L5 = ":"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L5 = L2
  L4 = L2.get_all
  L6 = "devicelist"
  L7 = "loginfrequency"
  L4 = L4(L5, L6, L7)
  if not L4 then
    L5 = {}
    L4 = L5
  end
  L4[L3] = A1
  L6 = L2
  L5 = L2.section
  L7 = "devicelist"
  L8 = "record"
  L9 = "loginfrequency"
  L10 = L4
  L5(L6, L7, L8, L9, L10)
  L6 = L2
  L5 = L2.commit
  L7 = "devicelist"
  L5(L6, L7)
end
setLoginAuthenFailedFrequency = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    L2 = 0
    return L1, L2
  else
    L1 = _UPVALUE0_
    L1 = L1.macFormat
    L2 = A0
    L1 = L1(L2)
    A0 = L1
  end
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L4 = L1
  L3 = L1.get
  L5 = "devicelist"
  L6 = "notify"
  L7 = L2
  L3 = L3(L4, L5, L6, L7)
  if L3 then
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    if L4 then
      L4 = true
      L5 = tonumber
      L6 = L3
      L5, L6, L7 = L5(L6)
      return L4, L5, L6, L7
    end
  end
  L4 = false
  L5 = 0
  return L4, L5
end
specialNotify = L1
function L1(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    L3 = tonumber
    L4 = A2
    L3 = L3(L4)
    if L3 then
      L3 = false
      return L3
  end
  else
    L3 = _UPVALUE0_
    L3 = L3.macFormat
    L4 = A0
    L3 = L3(L4)
    A0 = L3
  end
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L5 = A0
  L4 = A0.gsub
  L6 = ":"
  L7 = ""
  L4 = L4(L5, L6, L7)
  L6 = L3
  L5 = L3.get_all
  L7 = "devicelist"
  L8 = "notify"
  L5 = L5(L6, L7, L8)
  if not L5 then
    L6 = L3
    L5 = L3.section
    L7 = "devicelist"
    L8 = "record"
    L9 = "notify"
    L10 = {}
    L5(L6, L7, L8, L9, L10)
    L6 = L3
    L5 = L3.commit
    L7 = "devicelist"
    L5 = L5(L6, L7)
    if not L5 then
      L5 = false
      return L5
    end
  end
  if A1 then
    L6 = L3
    L5 = L3.get
    L7 = "devicelist"
    L8 = "notify"
    L9 = L4
    L5 = L5(L6, L7, L8, L9)
    if not L5 then
      L7 = L3
      L6 = L3.set
      L8 = "devicelist"
      L9 = "notify"
      L10 = L4
      L11 = 1
      L6(L7, L8, L9, L10, L11)
      L7 = L3
      L6 = L3.commit
      L8 = "devicelist"
      L6 = L6(L7, L8)
      if not L6 then
        L6 = false
        return L6
      end
    else
      L7 = L3
      L6 = L3.set
      L8 = "devicelist"
      L9 = "notify"
      L10 = L4
      L11 = A2
      L6(L7, L8, L9, L10, L11)
      L7 = L3
      L6 = L3.commit
      L8 = "devicelist"
      L6 = L6(L7, L8)
      if not L6 then
        L6 = false
        return L6
      end
    end
  else
    L6 = L3
    L5 = L3.delete
    L7 = "devicelist"
    L8 = "notify"
    L9 = L4
    L5(L6, L7, L8, L9)
    L6 = L3
    L5 = L3.commit
    L7 = "devicelist"
    L5 = L5(L6, L7)
    if not L5 then
      L5 = false
      return L5
    end
  end
  L5 = true
  return L5
end
setSpecialNotify = L1
function L1()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = {}
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = L1.get_all
  L2 = L2(L3, L4, L5)
  if L2 then
    for L6, L7 in L3, L4, L5 do
      L8 = tonumber
      L9 = L7
      L8 = L8(L9)
      if L8 then
        L0[L6] = 1
      end
    end
  end
  return L0
end
notifyDict = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  if A0 then
    L2 = tonumber
    L4 = L1
    L3 = L1.get
    L5 = "devicelist"
    L6 = "admin"
    L7 = A0
    L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
    return L2(L3, L4, L5, L6, L7)
  end
  L2 = nil
  return L2
end
getAdminDevice = L1
function L1()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = {}
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = L1.get_all
  L2 = L2(L3, L4, L5)
  if L2 then
    for L6, L7 in L3, L4, L5 do
      L8 = tonumber
      L9 = L7
      L8 = L8(L9)
      if L8 then
        L8 = tonumber
        L9 = L7
        L8 = L8(L9)
        L0[L6] = L8
      end
    end
  end
  return L0
end
getAdminDevices = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get_all
  L5 = "devicelist"
  L6 = "admin"
  L3 = L3(L4, L5, L6)
  if not L3 then
    L4 = L2
    L3 = L2.section
    L5 = "devicelist"
    L6 = "record"
    L7 = "admin"
    L8 = {}
    L3(L4, L5, L6, L7, L8)
    L4 = L2
    L3 = L2.commit
    L5 = "devicelist"
    L3(L4, L5)
  end
  L4 = L2
  L3 = L2.get
  L5 = "devicelist"
  L6 = "admin"
  L7 = A0
  L3 = L3(L4, L5, L6, L7)
  if L3 then
    L3 = tonumber
    L4 = A1
    L3 = L3(L4)
    if L3 then
      L4 = L2
      L3 = L2.set
      L5 = "devicelist"
      L6 = "admin"
      L7 = A0
      L8 = A1
      L3(L4, L5, L6, L7, L8)
    end
  else
    L4 = L2
    L3 = L2.set
    L5 = "devicelist"
    L6 = "admin"
    L7 = A0
    L8 = A1 or L8
    if not A1 then
      L8 = "0"
    end
    L3(L4, L5, L6, L7, L8)
  end
  L4 = L2
  L3 = L2.commit
  L5 = "devicelist"
  L3(L4, L5)
end
setAdminDevice = L1
