local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "xiaoqiang.module.XQAntiRubNetwork"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "nixio"
L0 = L0(L1)
L1 = require
L2 = "nixio.fs"
L1 = L1(L2)
L2 = require
L3 = "luci.sys"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.common.XQFunction"
L3 = L3(L4)
L4 = "/tmp/authenfailed-cache"
L5 = {}
L5.interval = 60
L5.blackltd = 30
L5.wifi = 30
L5.wifib = 5
L5.llogin = 5
L5.hlogin = 5
function L6(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.process
  L1 = L1.info
  L2 = "uid"
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.stat
  L3 = A0 or L3
  if not A0 then
    L3 = _UPVALUE2_
  end
  L4 = "uid"
  L2 = L2(L3, L4)
  L1 = L1 == L2
  return L1
end
_sane = L6
function L6()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.mkdir
  L1 = _UPVALUE1_
  L2 = 700
  L0(L1, L2)
  L0 = _sane
  L0 = L0()
  if not L0 then
    L0 = false
    return L0
  end
end
_prepare = L6
function L6(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.readfile
  L2 = _UPVALUE1_
  L3 = "/"
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1 = L1(L2)
  return L1
end
_read = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  if A0 then
    L2 = #A0
    if L2 ~= 0 then
      goto lbl_8
    end
  end
  L2 = nil
  do return L2 end
  ::lbl_8::
  L2 = A1
  if not L2 then
    L3 = _UPVALUE0_
    L2 = L3.interval
  end
  L3 = _sane
  L4 = _UPVALUE1_
  L5 = "/"
  L6 = A0
  L4 = L4 .. L5 .. L6
  L3 = L3(L4)
  if not L3 then
    L3 = nil
    return L3
  end
  L3 = _read
  L4 = A0
  L3 = L3(L4)
  L4 = loadstring
  L5 = L3
  L4 = L4(L5)
  L5 = setfenv
  L6 = L4
  L7 = {}
  L5(L6, L7)
  L5 = L4
  L5 = L5()
  L6 = type
  L7 = L5
  L6 = L6(L7)
  if L6 ~= "table" then
    L6 = nil
    return L6
  end
  L6 = _UPVALUE2_
  L6 = L6.uptime
  L6 = L6()
  L7 = L5.atime
  L6 = L6 - L7
  L6 = L6 or L6
  if L2 < L6 then
    L7 = L2 * 2
    if L6 < L7 then
      L5.expired = true
      L5.old = false
      L7 = kill
      L8 = A0
      L7(L8)
  end
  else
    L7 = L2 * 2
    if L6 > L7 then
      L5.expired = true
      L5.old = true
      L7 = kill
      L8 = A0
      L7(L8)
    else
      L5.expired = false
      L5.old = false
    end
  end
  return L5
end
read = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2.uniqueid
  L3 = 16
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L4 = "/"
  L5 = L2
  L3 = L3 .. L4 .. L5
  L4 = _UPVALUE1_
  L5 = "/"
  L6 = A0
  L4 = L4 .. L5 .. L6
  L5 = _UPVALUE2_
  L5 = L5.open
  L6 = L3
  L7 = "w"
  L8 = 600
  L5 = L5(L6, L7, L8)
  L7 = L5
  L6 = L5.writeall
  L8 = A1
  L6(L7, L8)
  L7 = L5
  L6 = L5.close
  L6(L7)
  L6 = _UPVALUE3_
  L6 = L6.rename
  L7 = L3
  L8 = L4
  L6(L7, L8)
end
_write = L6
function L6(A0, A1)
  local L2, L3, L4, L5
  L2 = _sane
  L2 = L2()
  if not L2 then
    L2 = _prepare
    L2()
  end
  L2 = type
  L3 = A1
  L2 = L2(L3)
  if L2 ~= "table" then
    return
  end
  L2 = _write
  L3 = A0
  L4 = luci
  L4 = L4.util
  L4 = L4.get_bytecode
  L5 = A1
  L4, L5 = L4(L5)
  L2(L3, L4, L5)
end
write = L6
function L6(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.unlink
    L2 = _UPVALUE1_
    L3 = "/"
    L4 = A0
    L2 = L2 .. L3 .. L4
    L1(L2)
  end
end
kill = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = _sane
  L0 = L0()
  if L0 then
    L0 = nil
    for L4 in L1, L2, L3 do
      L5 = read
      L6 = L4
      L5(L6)
    end
  end
end
reap = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = A1
    L2 = L2(L3)
    if not L2 then
      goto lbl_15
    end
  end
  do return end
  goto lbl_20
  ::lbl_15::
  L2 = _UPVALUE0_
  L2 = L2.macFormat
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  ::lbl_20::
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
  if A1 == "login" then
    L5 = L2
    L4 = L2.get_all
    L6 = "devicelist"
    L7 = "login_ignore"
    L4 = L4(L5, L6, L7)
    if not L4 then
      L5 = L2
      L4 = L2.section
      L6 = "devicelist"
      L7 = "record"
      L8 = "login_ignore"
      L9 = {}
      L4(L5, L6, L7, L8, L9)
      L5 = L2
      L4 = L2.commit
      L6 = "devicelist"
      L4(L5, L6)
      L4 = false
      return L4
    else
      L5 = L2
      L4 = L2.get
      L6 = "devicelist"
      L7 = "login_ignore"
      L8 = L3
      L4 = L4(L5, L6, L7, L8)
      if L4 then
        L5 = true
        return L5
      else
        L5 = false
        return L5
      end
    end
  elseif A1 == "wifi" then
    L5 = L2
    L4 = L2.get_all
    L6 = "devicelist"
    L7 = "wifi_ignore"
    L4 = L4(L5, L6, L7)
    if not L4 then
      L5 = L2
      L4 = L2.section
      L6 = "devicelist"
      L7 = "record"
      L8 = "wifi_ignore"
      L9 = {}
      L4(L5, L6, L7, L8, L9)
      L5 = L2
      L4 = L2.commit
      L6 = "devicelist"
      L4(L5, L6)
      L4 = false
      return L4
    else
      L5 = L2
      L4 = L2.get
      L6 = "devicelist"
      L7 = "wifi_ignore"
      L8 = L3
      L4 = L4(L5, L6, L7, L8)
      if L4 then
        L5 = true
        return L5
      else
        L5 = false
        return L5
      end
    end
  end
end
isIgnored = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = A1
    L2 = L2(L3)
    if not L2 then
      goto lbl_15
    end
  end
  do return end
  goto lbl_20
  ::lbl_15::
  L2 = _UPVALUE0_
  L2 = L2.macFormat
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  ::lbl_20::
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
  if A1 == "login" then
    L5 = L2
    L4 = L2.get_all
    L6 = "devicelist"
    L7 = "login_ignore"
    L4 = L4(L5, L6, L7)
    if not L4 then
      L5 = L2
      L4 = L2.section
      L6 = "devicelist"
      L7 = "record"
      L8 = "login_ignore"
      L9 = {}
      L9[L3] = "1"
      L4(L5, L6, L7, L8, L9)
      L5 = L2
      L4 = L2.commit
      L6 = "devicelist"
      L4(L5, L6)
    else
      L5 = L2
      L4 = L2.set
      L6 = "devicelist"
      L7 = "login_ignore"
      L8 = L3
      L9 = "1"
      L4(L5, L6, L7, L8, L9)
      L5 = L2
      L4 = L2.commit
      L6 = "devicelist"
      L4(L5, L6)
    end
  elseif A1 == "wifi" then
    L5 = L2
    L4 = L2.get_all
    L6 = "devicelist"
    L7 = "wifi_ignore"
    L4 = L4(L5, L6, L7)
    if not L4 then
      L5 = L2
      L4 = L2.section
      L6 = "devicelist"
      L7 = "record"
      L8 = "wifi_ignore"
      L9 = {}
      L9[L3] = "1"
      L4(L5, L6, L7, L8, L9)
      L5 = L2
      L4 = L2.commit
      L6 = "devicelist"
      L4(L5, L6)
    else
      L5 = L2
      L4 = L2.set
      L6 = "devicelist"
      L7 = "wifi_ignore"
      L8 = L3
      L9 = "1"
      L4(L5, L6, L7, L8, L9)
      L5 = L2
      L4 = L2.commit
      L6 = "devicelist"
      L4(L5, L6)
    end
  end
end
ignoreDevice = L6
function L6(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = "WIFI-"
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L1 = L1 .. L2
  L2 = {}
  L2.mac = A0
  L2.count = 1
  L2.warning = false
  L3 = _UPVALUE1_
  L3 = L3.uptime
  L3 = L3()
  L2.atime = L3
  L3 = write
  L4 = L1
  L5 = L2
  L3(L4, L5)
end
setWifiAuthenFailedCache = L6
function L6(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = "WIFI-"
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L1 = L1 .. L2
  L2 = read
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L3 = L2.expired
    if not L3 then
      L3 = L2.count
      L3 = L3 + 1
      L2.count = L3
      L3 = write
      L4 = L1
      L5 = L2
      L3(L4, L5)
    end
  end
  if L2 then
    L3 = L2.expired
    if L3 then
      L3 = L2.old
      if not L3 then
        L3 = L2.count
        L4 = _UPVALUE1_
        L4 = L4.wifi
        if L3 >= L4 then
          L2.warning = true
        end
      end
    end
  end
  return L2
end
getWifiAuthenFailedCache = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "xiaoqiang.util.XQPushUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = nil
    return L2
  else
    L2 = _UPVALUE0_
    L2 = L2.macFormat
    L3 = A0
    L2 = L2(L3)
    A0 = L2
  end
  L2 = isIgnored
  L3 = A0
  L4 = "wifi"
  L2 = L2(L3, L4)
  if L2 then
    L2 = nil
    return L2
  end
  L2 = L1.pushSettings
  L2 = L2()
  L3 = L1.getAuthenFailedTimes
  L4 = A0
  L3 = L3(L4)
  L4 = L2.auth
  if L4 then
    L4 = getWifiAuthenFailedCache
    L5 = A0
    L4 = L4(L5)
    if not L4 then
      L5 = setWifiAuthenFailedCache
      L6 = A0
      L5(L6)
    else
      L5 = math
      L5 = L5.floor
      L6 = L4.count
      L6 = L6 / 6
      L5 = L5(L6)
      L6 = L4.expired
      if L6 then
        L6 = L4.warning
        if L6 then
          L6 = L1.setAuthenFailedTimes
          L7 = A0
          L8 = L3 + L5
          L6(L7, L8)
          L6 = L1.setWifiAuthenFailedFrequency
          L7 = A0
          L8 = L5
          L6(L7, L8)
          L6 = L1.setwifiauthfailedserialtimes
          L7 = A0
          L8 = L1.getwifiauthfailedserialtimes
          L9 = A0
          L8 = L8(L9)
          L8 = L8 + 1
          L6(L7, L8)
          return L5
      end
      else
        L6 = L4.expired
        if L6 then
          L6 = L4.warning
          if not L6 then
            L6 = L1.setAuthenFailedTimes
            L7 = A0
            L8 = L3 + L5
            L6(L7, L8)
            L6 = L1.setwifiauthfailedserialtimes
            L7 = A0
            L8 = 0
            L6(L7, L8)
          end
        end
      end
    end
  end
  L4 = nil
  return L4
end
wifiAuthenFailedAction = L6
function L6(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = "BLACKLISTED-"
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L1 = L1 .. L2
  L2 = {}
  L2.mac = A0
  L2.count = 1
  L2.warning = false
  L3 = _UPVALUE1_
  L3 = L3.uptime
  L3 = L3()
  L2.atime = L3
  L3 = write
  L4 = L1
  L5 = L2
  L3(L4, L5)
end
setWifiBlacklistedCache = L6
function L6(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = "BLACKLISTED-"
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L1 = L1 .. L2
  L2 = read
  L3 = L1
  L4 = 15
  L2 = L2(L3, L4)
  if L2 then
    L3 = L2.expired
    if not L3 then
      L3 = L2.count
      L3 = L3 + 1
      L2.count = L3
      L3 = write
      L4 = L1
      L5 = L2
      L3(L4, L5)
    end
  end
  if L2 then
    L3 = L2.expired
    if L3 then
      L3 = L2.old
      if not L3 then
        L3 = L2.count
        L4 = _UPVALUE1_
        L4 = L4.wifib
        if L3 >= L4 then
          L2.warning = true
        end
      end
    end
  end
  return L2
end
getWifiBlacklistedCache = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "xiaoqiang.util.XQPushUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = nil
    return L2
  else
    L2 = _UPVALUE0_
    L2 = L2.macFormat
    L3 = A0
    L2 = L2(L3)
    A0 = L2
  end
  L2 = isIgnored
  L3 = A0
  L4 = "wifi"
  L2 = L2(L3, L4)
  if L2 then
    L2 = nil
    return L2
  end
  L2 = L1.pushSettings
  L2 = L2()
  L3 = L1.getAuthenFailedTimes
  L4 = A0
  L3 = L3(L4)
  L4 = L2.auth
  if L4 then
    L4 = getWifiBlacklistedCache
    L5 = A0
    L4 = L4(L5)
    if not L4 then
      L5 = setWifiBlacklistedCache
      L6 = A0
      L5(L6)
    else
      L5 = math
      L5 = L5.floor
      L6 = L4.count
      L6 = L6 / 4
      L5 = L5(L6)
      L6 = L4.expired
      if L6 then
        L6 = L4.warning
        if L6 then
          L6 = L1.setAuthenFailedTimes
          L7 = A0
          L8 = L3 + L5
          L6(L7, L8)
          return L5
      end
      else
        L6 = L4.expired
        if L6 then
          L6 = L4.warning
          if not L6 then
            L6 = L1.setAuthenFailedTimes
            L7 = A0
            L8 = L3 + L5
            L6(L7, L8)
          end
        end
      end
    end
  end
  L4 = nil
  return L4
end
wifiBlacklistedAction = L6
function L6(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = "LOGIN-"
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L1 = L1 .. L2
  L2 = {}
  L2.mac = A0
  L2.count = 1
  L2.warning = false
  L3 = _UPVALUE1_
  L3 = L3.uptime
  L3 = L3()
  L2.atime = L3
  L3 = write
  L4 = L1
  L5 = L2
  L3(L4, L5)
end
setLoginAuthenFailedCache = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1, L2 = nil, nil
    return L1, L2
  end
  L1 = require
  L2 = "xiaoqiang.util.XQPushUtil"
  L1 = L1(L2)
  L2 = tonumber
  L3 = L1.pushSettings
  L3 = L3()
  L3 = L3.level
  L2 = L2(L3)
  L3 = "LOGIN-"
  L5 = A0
  L4 = A0.gsub
  L6 = ":"
  L7 = ""
  L4 = L4(L5, L6, L7)
  L3 = L3 .. L4
  L4 = read
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L5 = L4.expired
    if not L5 then
      L5 = L4.count
      L5 = L5 + 1
      L4.count = L5
      L5 = write
      L6 = L3
      L7 = L4
      L5(L6, L7)
    end
  end
  if L4 then
    L5 = L4.count
    L6 = _UPVALUE1_
    L6 = L6.llogin
    if L5 >= L6 then
      L5 = L4.expired
      if not L5 then
        L4.warning = true
        return L4
      end
    end
  end
  if L4 then
    L5 = L4.expired
    if L5 then
      L5 = L4.old
      if not L5 then
        if L2 == 2 then
          L5 = L4.count
          L6 = _UPVALUE1_
          L6 = L6.llogin
          if L5 >= L6 then
            goto lbl_72
          end
        end
        if L2 == 3 then
          L5 = L4.count
          L6 = _UPVALUE1_
          L6 = L6.hlogin
          ::lbl_72::
          if L5 >= L6 then
            L4.warning = true
          end
        end
      end
    end
  end
  return L4
end
getLoginAuthenFailedCache = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "xiaoqiang.util.XQPushUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = nil
    return L2
  else
    L2 = _UPVALUE0_
    L2 = L2.macFormat
    L3 = A0
    L2 = L2(L3)
    A0 = L2
  end
  L2 = isIgnored
  L3 = A0
  L4 = "login"
  L2 = L2(L3, L4)
  if L2 then
    L2 = nil
    return L2
  end
  L2 = L1.pushSettings
  L2 = L2()
  L3 = L1.getLoginAuthenFailedTimes
  L4 = A0
  L3 = L3(L4)
  L4 = getLoginAuthenFailedCache
  L5 = A0
  L4 = L4(L5)
  if not L4 then
    L5 = setLoginAuthenFailedCache
    L6 = A0
    L5(L6)
  else
    L5 = L4.warning
    if L5 then
      L5 = L1.setLoginAuthenFailedTimes
      L6 = A0
      L7 = L4.count
      L7 = L3 + L7
      L5(L6, L7)
      L5 = L1.setLoginAuthenFailedFrequency
      L6 = A0
      L7 = L4.count
      L5(L6, L7)
      L5 = L4.count
      return L5
    else
      L5 = L4.expired
      if L5 then
        L5 = L4.warning
        if not L5 then
          L5 = L1.setLoginAuthenFailedTimes
          L6 = A0
          L7 = L4.count
          L7 = L3 + L7
          L5(L6, L7)
        end
      end
    end
  end
  L5 = nil
  return L5
end
LoginAuthenFailedAction = L6
