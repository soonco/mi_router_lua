local L0, L1, L2
L0 = module
L1 = "xiaoqiang.module.XQNetworkSpeedTest"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQFunction"
L1 = L1(L2)
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = "/usr/bin/upload_speedtest"
  L1 = nil
  L5, L6, L7, L8, L9, L10 = L3(L4)
  for L5, L6 in L2, L3, L4 do
    L7 = _UPVALUE1_
    L7 = L7.isStrNil
    L8 = L6
    L7 = L7(L8)
    if not L7 then
      L8 = L6
      L7 = L6.match
      L9 = "^avg tx:"
      L7 = L7(L8, L9)
      if L7 then
        L8 = L6
        L7 = L6.match
        L9 = "^avg tx:(%S+)"
        L7 = L7(L8, L9)
        L1 = L7
        if L1 then
          L7 = tonumber
          L8 = string
          L8 = L8.format
          L9 = "%.2f"
          L10 = L1 / 8
          L8, L9, L10 = L8(L9, L10)
          L7 = L7(L8, L9, L10)
          L1 = L7
        end
        break
      end
    end
  end
  return L1
end
uploadSpeedTest = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = "/usr/bin/download_speedtest"
  L1 = nil
  L5, L6, L7, L8, L9, L10 = L3(L4)
  for L5, L6 in L2, L3, L4 do
    L7 = _UPVALUE1_
    L7 = L7.isStrNil
    L8 = L6
    L7 = L7(L8)
    if not L7 then
      L8 = L6
      L7 = L6.match
      L9 = "^avg rx:"
      L7 = L7(L8, L9)
      if L7 then
        L8 = L6
        L7 = L6.match
        L9 = "^avg rx:(%S+)"
        L7 = L7(L8, L9)
        L1 = L7
        if L1 then
          L7 = tonumber
          L8 = string
          L8 = L8.format
          L9 = "%.2f"
          L10 = L1 / 8
          L8, L9, L10 = L8(L9, L10)
          L7 = L7(L8, L9, L10)
          L1 = L7
        end
        break
      end
    end
  end
  return L1
end
downloadSpeedTest = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = require
  L3 = "xiaoqiang.XQPreference"
  L2 = L2(L3)
  if A0 and A1 then
    L3 = tonumber
    L4 = A0
    L3 = L3(L4)
    if L3 then
      L3 = tonumber
      L4 = A1
      L3 = L3(L4)
      if L3 then
        L3 = L2.set
        L4 = "UPLOAD_SPEED"
        L5 = tostring
        L6 = A0
        L5, L6 = L5(L6)
        L3(L4, L5, L6)
        L3 = L2.set
        L4 = "DOWNLOAD_SPEED"
        L5 = tostring
        L6 = A1
        L5, L6 = L5(L6)
        L3(L4, L5, L6)
      end
    end
  end
end
saveSpeedTestResult = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0.get
  L3 = "UPLOAD_SPEED"
  L2, L3, L4 = L2(L3)
  L1 = L1(L2, L3, L4)
  L2 = tonumber
  L3 = L0.get
  L4 = "DOWNLOAD_SPEED"
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  if L1 and L2 then
    if 0 < L1 and 0 < L2 then
      L3 = L1
      L4 = L2
      return L3, L4
    elseif L1 == 0 or L2 == 0 then
      L3 = 0
      L4 = 0
      return L3, L4
    else
      L3, L4 = nil, nil
      return L3, L4
    end
  else
    L3, L4 = nil, nil
    return L3, L4
  end
end
getSpeedTestResult = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = {}
  L1 = "/usr/bin/speedtest"
  L8, L9, L10, L11, L12 = L3(L4)
  for L5, L6 in L2, L3, L4 do
    L8 = L6
    if not L7 then
      L8 = L0
      L9 = tonumber
      L11 = L6
      L10 = L6.match
      L12 = "rx:(%S+)"
      L10, L11, L12 = L10(L11, L12)
      L9, L10, L11, L12 = L9(L10, L11, L12)
      L7(L8, L9, L10, L11, L12)
    end
  end
  if 0 < L4 then
    for L8, L9 in L5, L6, L7 do
      L10 = tonumber
      L11 = L9
      L10 = L10(L11)
    end
  end
  if L3 then
    L8, L9, L10, L11, L12 = L6()
    L8 = 6
    L8, L9, L10, L11, L12 = L5(L6, L7, L8)
    L4(L5, L6, L7, L8, L9, L10, L11, L12)
    L8 = 8
    L9 = 11
    L8, L9, L10, L11, L12 = L5(L6, L7)
  end
  return L4, L5
end
speedTest = L2
function L2()
  local L0, L1, L2
  L0 = saveSpeedTestResult
  L1 = 0
  L2 = 0
  L0(L1, L2)
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = "lua /usr/sbin/speed_test.lua"
  L0(L1)
end
asyncSpeedTest = L2
function L2()
  local L0, L1, L2, L3
  L0 = uploadSpeedTest
  L0 = L0()
  L1 = downloadSpeedTest
  L1 = L1()
  L2 = L0
  L3 = L1
  return L2, L3
end
syncSpeedTest = L2
