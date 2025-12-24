local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
L0 = module
L1 = "xiaoqiang.module.XQMultiWanPolicy"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "luci.util"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.XQLog"
L2 = L2(L3)
L3 = require
L4 = "luci.model.uci"
L3 = L3(L4)
L3 = L3.cursor
L3 = L3()
L4 = "/usr/sbin/mwan3"
L5 = "wan"
L6 = "wan_2"
L7 = "balanced"
L8 = "wan_wanb"
L9 = "wanb_wan"
L10 = "wan_only"
L11 = "wanb_only"
L12 = {}
L13 = L7
L14 = L8
L15 = L9
L16 = L10
L17 = L11
L12[1] = L13
L12[2] = L14
L12[3] = L15
L12[4] = L16
L12[5] = L17
L13 = "ipv4"
L14 = "ipv6"
L15 = "any"
function L16(A0)
  local L1, L2
  L1 = tonumber
  L2 = A0
  L1 = L1(L2)
  L1 = L1 ~= nil
  return L1
end
isNumStr = L16
function L16()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = false
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get_all
  L4 = "network"
  L5 = _UPVALUE1_
  L2 = L2(L3, L4, L5)
  L0 = L2 or L0
  if not L2 then
    L0 = nil
  end
  if L0 then
    L1 = true
  end
  return L1
end
isWan2Exist = L16
function L16(A0)
  local L1, L2, L3
  L1 = false
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 and (A0 == "WAN1" or A0 == "WAN2") then
    L1 = true
  end
  return L1
end
isValidWanName = L16
function L16(A0)
  local L1, L2, L3
  L1 = false
  L2 = isNumStr
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = tonumber
    L3 = A0
    L2 = L2(L3)
    if 0 <= L2 then
      L2 = tonumber
      L3 = A0
      L2 = L2(L3)
      L3 = _UPVALUE0_
      L3 = #L3
      if L2 < L3 then
        L1 = true
      end
    end
  end
  return L1
end
isValidPolicyCode = L16
function L16(A0)
  local L1, L2, L3
  L1 = ""
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    if A0 == "WAN1" then
      L1 = _UPVALUE1_
    elseif A0 == "WAN2" then
      L1 = _UPVALUE2_
    end
  end
  return L1
end
wanName2Intf = L16
function L16(A0)
  local L1, L2, L3
  L1 = ""
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE1_
    if A0 == L2 then
      L1 = "WAN1"
    else
      L2 = _UPVALUE2_
      if A0 == L2 then
        L1 = "WAN2"
      end
    end
  end
  return L1
end
inft2WanName = L16
function L16(A0)
  local L1, L2, L3, L4, L5, L6, L7
  if not L2 then
    for L5, L6 in L2, L3, L4 do
      if A0 == L6 then
        L1 = L5 - 1
        break
      end
    end
  end
  return L1
end
policy2Code = L16
function L16(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = ""
  if L2 then
    for L5, L6 in L2, L3, L4 do
      L7 = L5 - 1
      L8 = tonumber
      L9 = A0
      L8 = L8(L9)
      L9 = tonumber
      L10 = L7
      L9 = L9(L10)
      if L8 == L9 then
        L1 = L6
        break
      end
    end
  end
  return L1
end
code2Policy = L16
function L16(A0)
  local L1, L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = string
    L2 = L2.gsub
    L3 = string
    L3 = L3.upper
    L4 = A0
    L3 = L3(L4)
    L4 = ":"
    L5 = "_"
    L2 = L2(L3, L4, L5)
    L1 = L2
  end
  return L1
end
mac2DeviceId = L16
function L16(A0, A1)
  local L2
  while 0 < A1 do
    L2 = A0 % A1
    A0 = A1
    A1 = L2
  end
  return A0
end
gcd = L16
function L16(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if not L3 then
    L3 = _UPVALUE0_
    L3 = L3.isStrNil
    L4 = A1
    L3 = L3(L4)
    if not L3 then
      L3 = _UPVALUE0_
      L3 = L3.isStrNil
      L4 = A2
      L3 = L3(L4)
      if not L3 and A2 == "ipv4" then
        L3 = _UPVALUE0_
        L3 = L3._strformat
        L4 = _UPVALUE1_
        L5 = " add_device "
        L6 = A0
        L7 = " "
        L8 = A1
        L9 = " ipv4"
        L4 = L4 .. L5 .. L6 .. L7 .. L8 .. L9
        L3 = L3(L4)
        L4 = _UPVALUE2_
        L4 = L4.exec
        L5 = L3
        L4(L5)
      end
    end
  end
end
createDevRule = L16
function L16(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE0_
    L1 = L1._strformat
    L2 = _UPVALUE1_
    L3 = " del_device "
    L4 = A0
    L2 = L2 .. L3 .. L4
    L1 = L1(L2)
    L2 = _UPVALUE2_
    L2 = L2.exec
    L3 = L1
    L2(L3)
  end
end
deleteDevRule = L16
function L16()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.foreach
  L3 = "mwan3"
  L4 = "device"
  function L5(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8
    L1 = {}
    L2 = A0[".name"]
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.get
    L5 = "mwan3"
    L6 = L2
    L7 = "mac"
    L3 = L3(L4, L5, L6, L7)
    L3 = L3 or L3
    L1.mac = L3
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.get
    L5 = "mwan3"
    L6 = L2
    L7 = "name"
    L3 = L3(L4, L5, L6, L7)
    L3 = L3 or L3
    L1.oname = L3
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.get
    L5 = "mwan3"
    L6 = L2
    L7 = "manual"
    L3 = L3(L4, L5, L6, L7)
    L3 = L3 or L3
    L1.manual = L3
    L3 = inft2WanName
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.get
    L6 = "mwan3"
    L7 = L2
    L8 = "interface"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    L3 = L3(L4)
    L1.wan = L3
    L3 = table
    L3 = L3.insert
    L4 = _UPVALUE1_
    L5 = L1
    L3(L4, L5)
  end
  L1(L2, L3, L4, L5)
  return L0
end
getAllDevPolicies = L16
function L16(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = mac2DeviceId
  L2 = A0
  L1 = L1(L2)
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L1
  L3 = L3(L4)
  if not L3 then
    L3 = _UPVALUE1_
    L4 = L3
    L3 = L3.get_all
    L5 = "mwan3"
    L6 = L1
    L3 = L3(L4, L5, L6)
    L2 = L3 or L2
    if not L3 then
      L3 = {}
      L2 = L3
    end
    if L2 then
      L3 = L2.interface
      if L3 then
        L3 = inft2WanName
        L4 = L2.interface
        L3 = L3(L4)
        L2.interface = L3
      end
    end
  end
  return L2
end
getDevPolicy = L16
function L16(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12
  L6 = mac2DeviceId
  L7 = A0
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.isStrNil
  L8 = A0
  L7 = L7(L8)
  if not L7 then
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = A3
    L7 = L7(L8)
    if not L7 then
      L7 = _UPVALUE0_
      L7 = L7.isStrNil
      L8 = L6
      L7 = L7(L8)
      if not L7 then
        L7 = isValidWanName
        L8 = A4
        L7 = L7(L8)
        if L7 then
          L7 = isDevPolicyExist
          L8 = A0
          L7 = L7(L8)
          if L7 then
            L7 = deleteDevRule
            L8 = A0
            L7(L8)
          end
          L7 = wanName2Intf
          L8 = A4
          L7 = L7(L8)
          A4 = L7
          L7 = _UPVALUE1_
          L8 = L7
          L7 = L7.set
          L9 = "mwan3"
          L10 = L6
          L11 = "device"
          L7(L8, L9, L10, L11)
          L7 = _UPVALUE1_
          L8 = L7
          L7 = L7.set
          L9 = "mwan3"
          L10 = L6
          L11 = "mac"
          L12 = A0
          L7(L8, L9, L10, L11, L12)
          L7 = _UPVALUE1_
          L8 = L7
          L7 = L7.set
          L9 = "mwan3"
          L10 = L6
          L11 = "interface"
          L12 = A4
          L7(L8, L9, L10, L11, L12)
          L7 = _UPVALUE1_
          L8 = L7
          L7 = L7.set
          L9 = "mwan3"
          L10 = L6
          L11 = "name"
          L12 = A3
          L7(L8, L9, L10, L11, L12)
          L7 = _UPVALUE1_
          L8 = L7
          L7 = L7.set
          L9 = "mwan3"
          L10 = L6
          L11 = "manual"
          L12 = A5 or L12
          if not A5 then
            L12 = "0"
          end
          L7(L8, L9, L10, L11, L12)
          L7 = _UPVALUE1_
          L8 = L7
          L7 = L7.set
          L9 = "mwan3"
          L10 = L6
          L11 = "family"
          L12 = A2 or L12
          if not A2 then
            L12 = "ipv4"
          end
          L7(L8, L9, L10, L11, L12)
          L7 = _UPVALUE1_
          L8 = L7
          L7 = L7.commit
          L9 = "mwan3"
          L7(L8, L9)
          L7 = _UPVALUE0_
          L7 = L7.isStrNil
          L8 = A1
          L7 = L7(L8)
          if not L7 then
            L7 = _UPVALUE0_
            L7 = L7.isStrNil
            L8 = A2
            L7 = L7(L8)
            if not L7 then
              if A2 == "ipv4" then
                L7 = createDevRule
                L8 = A0
                L9 = A1
                L10 = "ipv4"
                L7(L8, L9, L10)
              elseif A2 == "ipv6" then
                L7 = createDevRule
                L8 = A0
                L9 = A1
                L10 = "ipv6"
                L7(L8, L9, L10)
              end
            end
          end
        end
      end
    end
  end
end
setDevPolicy = L16
function L16(A0)
  local L1, L2, L3, L4, L5
  L1 = mac2DeviceId
  L2 = A0
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = A0
    L2 = L2(L3)
    if not L2 then
      L2 = deleteDevRule
      L3 = A0
      L2(L3)
      L2 = _UPVALUE1_
      L3 = L2
      L2 = L2.delete
      L4 = "mwan3"
      L5 = L1
      L2(L3, L4, L5)
      L2 = _UPVALUE1_
      L3 = L2
      L2 = L2.commit
      L4 = "mwan3"
      L2(L3, L4)
    end
  end
end
deleteDevPolicy = L16
function L16(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = mac2DeviceId
  L2 = A0
  L1 = L1(L2)
  L2 = false
  L3 = nil
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = L1
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.get_all
    L6 = "mwan3"
    L7 = L1
    L4 = L4(L5, L6, L7)
    L3 = L4 or L3
    if not L4 then
      L3 = nil
    end
    if L3 ~= nil then
      L2 = true
    end
  end
  return L2
end
isDevPolicyExist = L16
function L16(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "xiaoqiang.XQFeatures"
  L2 = L2(L3)
  L2 = L2.FEATURES
  if A0 then
    L3 = tonumber
    L4 = A0
    L3 = L3(L4)
    if 0 == L3 then
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.set
      L5 = "network"
      L6 = _UPVALUE1_
      L7 = "disabled"
      L8 = 1
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.commit
      L5 = "network"
      L3(L4, L5)
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.set
      L5 = "mwan3"
      L6 = "globals"
      L7 = "enabled"
      L8 = 0
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.commit
      L5 = "mwan3"
      L3(L4, L5)
    else
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.set
      L5 = "network"
      L6 = _UPVALUE1_
      L7 = "disabled"
      L8 = 0
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.commit
      L5 = "network"
      L3(L4, L5)
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.set
      L5 = "mwan3"
      L6 = "globals"
      L7 = "enabled"
      L8 = 1
      L3(L4, L5, L6, L7, L8)
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.commit
      L5 = "mwan3"
      L3(L4, L5)
    end
    if not A1 then
      L3 = L2.system
      L3 = L3.cpe
      if L3 then
        L3 = L2.system
        L3 = L3.cpe
        if L3 == "1" then
          L3 = reloadNetwork
          L3()
      end
      else
        L3 = reconfigRelatedServicesByMode
        L4 = A0
        L3(L4)
      end
      L3 = restartService
      L3()
    end
  end
end
setStatus = L16
function L16()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get_all
  L2 = "network"
  L3 = _UPVALUE1_
  L0 = L0(L1, L2, L3)
  L0 = L0 or L0
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "network"
  L4 = _UPVALUE1_
  L5 = "disabled"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = 0
  if L0 then
    L3 = tonumber
    L4 = L1
    L3 = L3(L4)
    if L3 == 0 then
      L2 = 1
    end
  end
  return L2
end
getStatus = L16
function L16(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L3 = 256
  L4 = 1
  L5 = 1
  L6 = gcd
  L7 = tonumber
  L8 = A0
  L7 = L7(L8)
  L8 = tonumber
  L9 = A1
  L8, L9, L10, L11, L12, L13, L14 = L8(L9)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14)
  L7 = tonumber
  L8 = A0
  L7 = L7(L8)
  L7 = L7 / L6
  L8 = tonumber
  L9 = A1
  L8 = L8(L9)
  L8 = L8 / L6
  if L3 > L7 and L3 > L8 then
    L4 = L7
    L5 = L8
  elseif L3 < L7 and L3 < L8 then
    L9 = math
    L9 = L9.floor
    L10 = L7 / L3
    L10 = L10 + 0.5
    L9 = L9(L10)
    L4 = L9
    L9 = math
    L9 = L9.floor
    L10 = L8 / L3
    L10 = L10 + 0.5
    L9 = L9(L10)
    L5 = L9
  elseif L3 > L7 and L3 < L8 then
    L4 = 1
    L9 = math
    L9 = L9.floor
    L10 = L8 / L7
    L10 = L10 + 0.5
    L9 = L9(L10)
    L5 = L9
    if L3 < L5 then
      L5 = L3
    end
  elseif L3 < L7 and L3 > L8 then
    L9 = math
    L9 = L9.floor
    L10 = L7 / L8
    L10 = L10 + 0.5
    L9 = L9(L10)
    L4 = L9
    if L3 < L4 then
      L4 = L3
    end
    L5 = 1
  end
  L9 = _UPVALUE0_
  L10 = L9
  L9 = L9.set
  L11 = "mwan3"
  L12 = _UPVALUE1_
  L13 = "bandwidth"
  L14 = A0
  L9(L10, L11, L12, L13, L14)
  L9 = _UPVALUE0_
  L10 = L9
  L9 = L9.set
  L11 = "mwan3"
  L12 = _UPVALUE2_
  L13 = "bandwidth"
  L14 = A1
  L9(L10, L11, L12, L13, L14)
  L9 = _UPVALUE0_
  L10 = L9
  L9 = L9.set
  L11 = "mwan3"
  L12 = "wan_m1_wx"
  L13 = "weight"
  L14 = L4
  L9(L10, L11, L12, L13, L14)
  L9 = _UPVALUE0_
  L10 = L9
  L9 = L9.set
  L11 = "mwan3"
  L12 = "wanb_m1_wx"
  L13 = "weight"
  L14 = L5
  L9(L10, L11, L12, L13, L14)
  L9 = _UPVALUE0_
  L10 = L9
  L9 = L9.set
  L11 = "mwan3"
  L12 = "wan6_m1_wx"
  L13 = "weight"
  L14 = L4
  L9(L10, L11, L12, L13, L14)
  L9 = _UPVALUE0_
  L10 = L9
  L9 = L9.set
  L11 = "mwan3"
  L12 = "wanb6_m1_wx"
  L13 = "weight"
  L14 = L5
  L9(L10, L11, L12, L13, L14)
  L9 = _UPVALUE0_
  L10 = L9
  L9 = L9.commit
  L11 = "mwan3"
  L9(L10, L11)
  if not A2 then
    L9 = restartService
    L9()
  end
end
setWeight = L16
function L16()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "mwan3"
  L3 = _UPVALUE1_
  L4 = "bandwidth"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "mwan3"
  L4 = _UPVALUE2_
  L5 = "bandwidth"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = L0
  L3 = L1
  return L2, L3
end
getBandwidth = L16
function L16()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "mwan3"
  L3 = "wan_m1_wx"
  L4 = "weight"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "mwan3"
  L4 = "wanb_m1_wx"
  L5 = "weight"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = L0
  L3 = L1
  return L2, L3
end
getWeight = L16
function L16()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "mwan3"
  L3 = "default_rule"
  L4 = "use_policy"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  L1 = policy2Code
  L2 = L0
  L1 = L1(L2)
  L1 = L1 or L1
  return L1
end
getPolicy = L16
function L16(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = false
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.foreach
  L4 = "network"
  L5 = "interface"
  function L6(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = string
    L1 = L1.sub
    L2 = A0[".name"]
    L3 = 1
    L4 = 3
    L1 = L1(L2, L3, L4)
    if L1 == "vpn" then
      L2 = _UPVALUE0_
      L3 = L2
      L2 = L2.set
      L4 = "network"
      L5 = A0[".name"]
      L6 = "disabled"
      L7 = _UPVALUE1_
      if L7 == 0 then
        L7 = 1
        if L7 then
          goto lbl_21
        end
      end
      L7 = 0
      ::lbl_21::
      L2(L3, L4, L5, L6, L7)
      L2 = true
      _UPVALUE2_ = L2
    end
  end
  L2(L3, L4, L5, L6)
  if L1 then
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.commit
    L4 = "network"
    L2(L3, L4)
  end
end
reconfigVpn = L16
function L16(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  if A0 == 0 then
    L1 = "1"
    if L1 then
      goto lbl_7
    end
  end
  L1 = "0"
  ::lbl_7::
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "miqos"
  L5 = "settings"
  L6 = "force_disabled"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  if L1 ~= L2 then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.set
    L5 = "miqos"
    L6 = "settings"
    L7 = "force_disabled"
    L8 = L1
    L3(L4, L5, L6, L7, L8)
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.commit
    L5 = "miqos"
    L3(L4, L5)
    if L1 == "1" then
      L3 = "0"
      if L3 then
        goto lbl_43
      end
    end
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.get
    L5 = "miqos"
    L6 = "settings"
    L7 = "enabled"
    L3 = L3(L4, L5, L6, L7)
    L3 = L3 or L3
    ::lbl_43::
    L4 = "/etc/init.d/miqos "
    if A0 == 0 then
      L5 = "stop"
      if L5 then
        goto lbl_50
      end
    end
    L5 = "start"
    ::lbl_50::
    L6 = ";"
    L7 = ". /lib/miwifi/miwifi_core_libs.sh; network_accel_hook qos "
    if L3 == "0" then
      L8 = "stop"
      if L8 then
        goto lbl_58
      end
    end
    L8 = "start"
    ::lbl_58::
    L4 = L4 .. L5 .. L6 .. L7 .. L8
    L5 = _UPVALUE1_
    L5 = L5.forkExec
    L6 = L4
    L5(L6)
  end
end
reconfigMiqos = L16
function L16(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = false
  if A0 == 0 then
    L2 = "1"
    if L2 then
      goto lbl_8
    end
  end
  L2 = "0"
  ::lbl_8::
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.foreach
  L5 = "network"
  L6 = "interface"
  function L7(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = A0.wantype
    if L1 == "eth" then
      L1 = A0.proto
      if L1 == "pppoe" then
        L1 = A0.force_disable_ipv6
        L2 = _UPVALUE0_
        if L1 ~= L2 then
          L1 = _UPVALUE1_
          L2 = L1
          L1 = L1.set
          L3 = "network"
          L4 = A0[".name"]
          L5 = "force_disable_ipv6"
          L6 = _UPVALUE0_
          L1(L2, L3, L4, L5, L6)
          L1 = true
          _UPVALUE2_ = L1
        end
      else
        L1 = A0.proto
        if L1 ~= "dhcpv6" then
          L1 = A0.proto
          if L1 ~= "static" then
            goto lbl_48
          end
        end
        L1 = string
        L1 = L1.sub
        L2 = A0[".name"]
        L3 = 1
        L4 = 4
        L1 = L1(L2, L3, L4)
        if L1 == "wan6" then
          L2 = A0.force_disable_ipv6
          L3 = _UPVALUE0_
          if L2 ~= L3 then
            L2 = _UPVALUE1_
            L3 = L2
            L2 = L2.set
            L4 = "network"
            L5 = A0[".name"]
            L6 = "force_disable_ipv6"
            L7 = _UPVALUE0_
            L2(L3, L4, L5, L6, L7)
            L2 = true
            _UPVALUE2_ = L2
          end
        end
      end
    end
    ::lbl_48::
  end
  L3(L4, L5, L6, L7)
  if L1 then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.commit
    L5 = "network"
    L3(L4, L5)
  end
end
reconfigIpv6 = L16
function L16(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "xiaoqiang.util.XQPortServiceUtil"
  L1 = L1(L2)
  L2 = {}
  L3 = tonumber
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = "port_service"
  L7 = "wan"
  L8 = "enable"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L3 = L3(L4)
  L2.enable = L3
  L3 = tonumber
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = "port_service"
  L7 = "wan"
  L8 = "mode"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L3 = L3(L4)
  L4 = L2.enable
  if L4 == A0 or L3 == 3 then
    return
  end
  L2.enable = A0
  L4 = tonumber
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.get
  L7 = "port_service"
  L8 = "wan"
  L9 = "wandt"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  L4 = L4(L5)
  L2.wandt = L4
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = "port_service"
  L7 = "wan"
  L8 = "ports"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L2.ports = L4
  L4 = L1.wanSetConfig
  L5 = L2
  L4(L5)
end
reconfigWandt = L16
function L16(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = 1
  L3 = 1
  L4 = 1
  L5 = 1
  L6 = 0
  L7 = 0
  L8 = _UPVALUE0_
  if L8 == A0 then
    L2 = 0
    L3 = 0
    L4 = 0
  else
    L8 = _UPVALUE1_
    if L8 == A0 then
      L2 = 0
      L3 = 0
    else
      L8 = _UPVALUE2_
      if L8 == A0 then
        L2 = 0
        L3 = 0
      else
        L8 = _UPVALUE3_
        if L8 == A0 then
          L6 = 1
        else
          L8 = _UPVALUE4_
          if L8 == A0 then
            L7 = 1
            L4 = 0
            L5 = 0
          end
        end
      end
    end
  end
  L8 = reconfigMiqos
  L9 = L3
  L8(L9)
  L8 = reconfigVpn
  L9 = L2
  L8(L9)
  if A1 then
    L8 = reconfigIpv6
    L9 = L4
    L8(L9)
  end
  L8 = reconfigWandt
  L9 = L5
  L8(L9)
  if L6 == 1 or L7 == 1 then
    L8 = redailWan
    if L6 == 1 then
      L9 = _UPVALUE5_
      if L9 then
        goto lbl_62
      end
    end
    L9 = _UPVALUE6_
    ::lbl_62::
    L8(L9)
  else
    L8 = reloadNetwork
    L8()
  end
end
reconfigRelatedServicesByPolicy = L16
function L16(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = 1
  L4 = 1
  L5 = 1
  if A0 == 1 then
    L3 = 0
    L4 = 0
    L5 = 0
  end
  L6 = reconfigVpn
  L7 = L3
  L6(L7)
  L6 = reconfigMiqos
  L7 = L4
  L6(L7)
  if A2 then
    L6 = reconfigIpv6
    L7 = L5
    L6(L7)
  end
  if not A1 then
    L6 = reloadNetwork
    L6()
  end
end
reconfigRelatedServicesByMode = L16
function L16(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.forkExec
  L2 = "sleep 1;ifup "
  L3 = A0
  L2 = L2 .. L3
  L1(L2)
end
redailWan = L16
function L16()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = "ubus call network reload"
  L0(L1)
end
reloadNetwork = L16
function L16()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = _UPVALUE1_
  L2 = " restart"
  L1 = L1 .. L2
  L0(L1)
end
restartService = L16
function L16(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = require
  L3 = "xiaoqiang.XQFeatures"
  L2 = L2(L3)
  L2 = L2.FEATURES
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "mwan3"
  L6 = "default_rule"
  L7 = "use_policy"
  L3 = L3(L4, L5, L6, L7)
  L4 = ""
  L5 = 0
  L6 = isValidPolicyCode
  L7 = A0
  L6 = L6(L7)
  if not L6 then
    L6 = 1
    return L6
  end
  L6 = code2Policy
  L7 = A0
  L6 = L6(L7)
  L4 = L6
  if L4 == L3 then
    return L5
  end
  L6 = _UPVALUE1_
  L6 = L6.isStrNil
  L7 = L4
  L6 = L6(L7)
  if not L6 then
    L6 = 0
    L7 = _UPVALUE2_
    if L4 == L7 then
      L6 = 1
    end
    L7 = _UPVALUE3_
    if L4 == L7 then
      L7 = _UPVALUE0_
      L8 = L7
      L7 = L7.set
      L9 = "network"
      L10 = _UPVALUE4_
      L11 = "disabled"
      L12 = 1
      L7(L8, L9, L10, L11, L12)
      L7 = _UPVALUE0_
      L8 = L7
      L7 = L7.commit
      L9 = "network"
      L7(L8, L9)
    else
      L7 = _UPVALUE5_
      if L4 == L7 then
        L7 = _UPVALUE0_
        L8 = L7
        L7 = L7.set
        L9 = "network"
        L10 = _UPVALUE6_
        L11 = "disabled"
        L12 = 1
        L7(L8, L9, L10, L11, L12)
        L7 = _UPVALUE0_
        L8 = L7
        L7 = L7.commit
        L9 = "network"
        L7(L8, L9)
      else
        L7 = _UPVALUE0_
        L8 = L7
        L7 = L7.set
        L9 = "network"
        L10 = _UPVALUE6_
        L11 = "disabled"
        L12 = 0
        L7(L8, L9, L10, L11, L12)
        L7 = _UPVALUE0_
        L8 = L7
        L7 = L7.set
        L9 = "network"
        L10 = _UPVALUE4_
        L11 = "disabled"
        L12 = 0
        L7(L8, L9, L10, L11, L12)
        L7 = _UPVALUE0_
        L8 = L7
        L7 = L7.commit
        L9 = "network"
        L7(L8, L9)
      end
    end
    L7 = _UPVALUE0_
    L8 = L7
    L7 = L7.set
    L9 = "mwan3"
    L10 = "https"
    L11 = "enabled"
    L12 = L6
    L7(L8, L9, L10, L11, L12)
    L7 = _UPVALUE0_
    L8 = L7
    L7 = L7.set
    L9 = "mwan3"
    L10 = "wan_rule"
    L11 = "enabled"
    L12 = L6
    L7(L8, L9, L10, L11, L12)
    L7 = _UPVALUE0_
    L8 = L7
    L7 = L7.set
    L9 = "mwan3"
    L10 = "wanb_rule"
    L11 = "enabled"
    L12 = L6
    L7(L8, L9, L10, L11, L12)
    L7 = _UPVALUE0_
    L8 = L7
    L7 = L7.set
    L9 = "mwan3"
    L10 = "default_rule"
    L11 = "use_policy"
    L12 = L4
    L7(L8, L9, L10, L11, L12)
    L7 = _UPVALUE0_
    L8 = L7
    L7 = L7.commit
    L9 = "mwan3"
    L7(L8, L9)
    if not A1 then
      L7 = L2.system
      L7 = L7.cpe
      if L7 then
        L7 = L2.system
        L7 = L7.cpe
        if L7 == "1" then
          L7 = reconfigRelatedServicesByPolicy
          L8 = L4
          L9 = 1
          L7(L8, L9)
      end
      else
        L7 = reloadNetwork
        L7()
      end
      L7 = restartService
      L7()
    end
  end
  return L5
end
setPolicy = L16
function L16(A0)
  local L1, L2, L3, L4, L5
  L1 = ""
  L2 = _UPVALUE0_
  if A0 ~= L2 then
    L2 = _UPVALUE1_
    if A0 ~= L2 then
      goto lbl_16
    end
  end
  L2 = _UPVALUE2_
  L2 = L2.exec
  L3 = _UPVALUE3_
  L4 = " curr_wan "
  L5 = A0
  L3 = L3 .. L4 .. L5
  L2 = L2(L3)
  L1 = L2
  ::lbl_16::
  L2 = string
  L2 = L2.trim
  L3 = L1
  return L2(L3)
end
getCurrentWan = L16
function L16(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "mwan3"
  L5 = "globals"
  L6 = "enabled"
  L2 = L2(L3, L4, L5, L6)
  if A0 ~= L2 then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.set
    L5 = "mwan3"
    L6 = "globals"
    L7 = "enabled"
    L8 = A0
    L3(L4, L5, L6, L7, L8)
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.commit
    L5 = "mwan3"
    L3(L4, L5)
    if not A1 then
      L3 = restartService
      L3()
    end
  end
end
setEnable = L16
function L16()
  local L0, L1, L2, L3, L4, L5
  L0 = tonumber
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "mwan3"
  L4 = "globals"
  L5 = "enabled"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  return L0(L1)
end
getEnable = L16
