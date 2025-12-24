local L0, L1, L2, L3, L4, L5
L0 = module
L1 = "xiaoqiang.module.XQTopology"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "cjson"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQFunction"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQConfigs"
L2 = L2(L3)
L3 = require
L4 = "luci.util"
L3 = L3(L4)
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L1 = require
  L2 = "xiaoqiang.util.XQCryptoUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = {}
  L3.ip = ""
  L4 = A0.router_name
  if not L4 then
    L4 = A0.hostname
    L4 = L4 or L4
  end
  L3.name = L4
  L4 = A0.locale
  L4 = L4 or L4
  L3.locale = L4
  L3.hardware = ""
  L3.channel = ""
  L4 = tonumber
  L5 = A0.is_ap
  L5 = L5 or L5
  L4 = L4(L5)
  L3.mode = L4
  L4 = A0.version
  L4 = L4 or L4
  L3.version = L4
  L3.ssid = ""
  L3.color = 100
  L4 = L2.isSupportNewTopo
  L4 = L4()
  if L4 == 1 then
    L4 = A0.signal
    L4 = L4 or L4
    L3.signal = L4
    L4 = A0.link_type
    L4 = L4 or L4
    L3.link_type = L4
    L4 = A0.internet
    L4 = L4 or L4
    L3.internet = L4
    L4 = A0.onlines
    if L4 ~= nil then
      L4 = L1.binaryBase64Dec
      L5 = A0.router_name
      L4 = L4(L5)
      L4 = L4 or L4
      L3.name = L4
      L4 = A0.onlines
      L3.onlines = L4
    end
  end
  L4 = string
  L4 = L4.lower
  L5 = L3.name
  L4 = L4(L5)
  L5 = L4
  L4 = L4.match
  L6 = "^xiaomirepeater"
  L4 = L4(L5, L6)
  if L4 then
    L3.name = "\229\176\143\231\177\179\228\184\173\231\187\167\229\153\168"
  end
  L4 = A0.description
  function L5(A0)
    local L1, L2
    L1 = _UPVALUE1_
    L1 = L1.decode
    L2 = A0
    L1 = L1(L2)
    _UPVALUE0_ = L1
  end
  L6 = _UPVALUE1_
  L6 = L6.isStrNil
  L7 = A0.description
  L6 = L6(L7)
  if not L6 then
    L6 = pcall
    L7 = L5
    L6 = L6(L7, L8)
    if L6 then
      L6 = L4.hardware
      L3.hardware = L6
      L6 = L4.channel
      L3.channel = L6
      L6 = L4.color
      L3.color = L6
      L6 = L4.ssid
      L3.ssid = L6
      L6 = L4.ip
      L3.ip = L6
      L6 = L4.locale
      L3.locale = L6
    end
  end
  L6 = {}
  L7 = _UPVALUE1_
  L7 = L7.isStrNil
  L7 = L7(L8)
  if L7 then
    L7 = A0.ip_list
    if L7 then
      L7 = A0.ip_list
      L7 = #L7
      if 0 < L7 then
        L7 = A0.ifname
        L7 = L7 or L7
        for L11, L12 in L8, L9, L10 do
          L14 = L7
          L13 = L7.match
          L15 = "wl"
          L13 = L13(L14, L15)
          if L13 then
            L14 = L7
            L13 = L7.match
            L15 = "wl"
            L13 = L13(L14, L15)
            if not L13 then
              goto lbl_156
            end
            L13 = tonumber
            L14 = A0.assoc
            L13 = L13(L14)
            if L13 ~= 1 then
              goto lbl_156
            end
          end
          L13 = L12.ageing_timer
          if L13 <= 300 then
            L13 = L12.tx_bytes
            if L13 == 0 then
              L13 = L12.rx_bytes
              if L13 == 0 then
                goto lbl_156
              end
            end
            L13 = L12.ip
            L3.ip = L13
            break
          end
          ::lbl_156::
        end
      end
    end
  end
  L7 = A0.child
  if L7 then
    L7 = A0.child
    L7 = #L7
    if 0 < L7 then
      L7 = 0
      for L11, L12 in L8, L9, L10 do
        L13 = L12.is_ap
        if L13 ~= nil then
          L13 = L12.is_ap
          if L13 ~= 0 then
            L13 = table
            L13 = L13.insert
            L14 = L6
            L15 = _recursive
            L16 = L12
            L15, L16 = L15(L16)
            L13(L14, L15, L16)
        end
        else
          L13 = L12.assoc
          if L13 ~= nil then
            L13 = L12.assoc
            if L13 ~= 0 then
              L7 = L7 + 1
            end
          end
        end
      end
      if 1 == L8 then
        if 0 == L8 then
          L3.onlines = L7
        end
      end
      if 0 < L8 then
        L3.leafs = L6
      end
    end
  end
  return L3
end
_recursive = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = 0
  for L5, L6 in L2, L3, L4 do
    if L7 == 1 then
      L1 = L1 + 1
    end
    child = L7
    if L7 then
      for L10, L11 in L7, L8, L9 do
        L12 = L11.leafs
        if L12 then
          L13 = _UPVALUE0_
          L14 = L12
          L13 = L13(L14)
          L1 = L1 + L13
        else
          L13 = L11.mode
          if L13 == 1 then
            L1 = L1 + 1
          end
        end
      end
    end
  end
  return L1
end
function L5()
  local L0, L1, L2, L3
  L0 = {}
  L1 = nil
  L2 = _UPVALUE0_
  L2 = L2.exec
  L3 = "ubus -t5 call xq_info_sync_mqtt child_list"
  L2 = L2(L3)
  L1 = L2
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    return L0
  end
  L2 = _UPVALUE2_
  L2 = L2.decode
  L3 = L1
  L2 = L2(L3)
  L0 = L2
  return L0
end
meshChildList = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQLanWanUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQWifiUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQDeviceUtil"
  L3 = L3(L4)
  L4 = L2.getWifiStatus
  L5 = 1
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = false
  L6 = {}
  L7 = L1.getLanIp
  L7 = L7()
  L6.ip = L7
  L7 = L0.getRouterName
  L7 = L7()
  L6.name = L7
  L7 = L0.getRouterLocale
  L7 = L7()
  L6.locale = L7
  L7 = L0.getHardware
  L7 = L7()
  L6.hardware = L7
  L7 = L0.getChannel
  L7 = L7()
  L6.channel = L7
  L7 = _UPVALUE0_
  L7 = L7.getNetModeType
  L7 = L7()
  L6.mode = L7
  L7 = L0.getColor
  L7 = L7()
  L6.color = L7
  L7 = L4.ssid
  L7 = L7 or L7
  L6.ssid = L7
  L7 = ""
  L8 = L0.isSupportNewTopo
  L8 = L8()
  if L8 == 1 then
    L8 = _UPVALUE0_
    L8 = L8.isMeshCap
    L8 = L8()
    if L8 then
      L8 = _UPVALUE1_
      L8 = L8.trim
      L13, L14, L15, L16, L17 = L9(L10)
      L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16, L17)
      L8 = L8 or L8
      L6.onlines = L8
      L8 = _UPVALUE1_
      L8 = L8.exec
      L8 = L8(L9)
      L7 = L8
      L5 = true
  end
  else
    L8 = _UPVALUE1_
    L8 = L8.exec
    L8 = L8(L9)
    L7 = L8
  end
  L8 = _UPVALUE0_
  L8 = L8.isStrNil
  L8 = L8(L9)
  if L8 then
    return L6
  else
    L8 = _UPVALUE2_
    L8 = L8.decode
    L8 = L8(L9)
    L7 = L8
  end
  if L5 and L7 then
    L8 = next
    L8 = L8(L9)
    if L8 == nil then
      L8 = _UPVALUE1_
      L8 = L8.exec
      L8 = L8(L9)
      L7 = L8
      L8 = _UPVALUE0_
      L8 = L8.isStrNil
      L8 = L8(L9)
      if L8 then
        return L6
      else
        L8 = _UPVALUE2_
        L8 = L8.decode
        L8 = L8(L9)
        L7 = L8
      end
    end
  end
  L8 = {}
  for L12, L13 in L9, L10, L11 do
    L14 = L13.is_ap
    if L14 ~= nil then
      L14 = L13.is_ap
      if L14 ~= 0 then
        L14 = L13.assoc
        if L14 ~= 0 then
          L14 = table
          L14 = L14.insert
          L15 = L8
          L16 = _recursive
          L17 = L13
          L16, L17 = L16(L17)
          L14(L15, L16, L17)
        end
      end
    end
  end
  if 0 < L10 then
    L6.leafs = L8
    for L13, L14 in L10, L11, L12 do
      L15 = L14.mode
      if L15 == 1 then
        L15 = L14.leafs
        if L15 then
          L15 = _UPVALUE3_
          L16 = L14.leafs
          L15 = L15(L16)
        end
      end
    end
  end
  L6.renumber = L9
  return L6
end
topologicalGraph = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.macFormat
  L3 = A0.hw
  L2 = L2(L3)
  L1.mac = L2
  L1.mac5G = ""
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0.description
  L2 = L2(L3)
  if L2 then
    L2 = nil
    return L2
  end
  L2 = pcall
  L3 = _UPVALUE1_
  L3 = L3.decode
  L4 = A0.description
  L2, L3 = L2(L3, L4)
  if L2 and L3 then
    L4 = L3.hardware
    if not L4 then
      goto lbl_42
    end
    L4 = string
    L4 = L4.lower
    L4 = L4(L5)
    if L4 == "r01" then
      goto lbl_42
    end
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L4 = L4(L5)
    if not L4 then
      goto lbl_42
    end
  end
  L4 = nil
  do return L4 end
  ::lbl_42::
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L4 = L4(L5)
  if not L4 then
    L4 = L3.bssid1
    L1.mac = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L4 = L4(L5)
  if not L4 then
    L4 = L3.bssid2
    L1.mac5G = L4
  end
  L4 = L3.hardware
  if L4 then
    L4 = string
    L4 = L4.lower
    L4 = L4(L5)
    if L4 == "r01" then
      L4 = _UPVALUE0_
      L4 = L4.isStrNil
      L4 = L4(L5)
      if L4 then
        L1.needConvert = true
      else
        L4 = _UPVALUE0_
        L4 = L4.macFormat
        L4 = L4(L5)
        L1.mac = L4
      end
    end
  end
  L4 = {}
  if L5 then
    if 0 < L5 then
      for L9, L10 in L6, L7, L8 do
        L12 = L5
        L11 = L5.match
        L13 = "wl"
        L11 = L11(L12, L13)
        if L11 then
          L12 = L5
          L11 = L5.match
          L13 = "wl"
          L11 = L11(L12, L13)
          if not L11 then
            goto lbl_121
          end
          L11 = tonumber
          L12 = A0.assoc
          L11 = L11(L12)
          if L11 ~= 1 then
            goto lbl_121
          end
        end
        L11 = L10.ageing_timer
        if L11 <= 300 then
          L11 = L10.tx_bytes
          if L11 ~= 0 then
            break
          end
          L11 = L10.rx_bytes
          if L11 ~= 0 then
            break
          end
        end
        ::lbl_121::
      end
    end
  end
  if L5 then
    if 0 < L5 then
      for L8, L9 in L5, L6, L7 do
        L10 = L9.is_ap
        if L10 ~= nil then
          L10 = L9.is_ap
          if L10 ~= 0 then
            L10 = _simpleRecursive
            L11 = L9
            L10 = L10(L11)
            if L10 then
              L11 = table
              L11 = L11.insert
              L12 = L4
              L13 = L10
              L11(L12, L13)
            end
          end
        end
      end
      if 0 < L5 then
        L1.leafs = L4
      end
    end
  end
  return L1
end
_simpleRecursive = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = L0.getWifiBssid
  L1, L2 = L1()
  L3 = {}
  L3.mac = L1
  L4 = L2 or L4
  if not L2 then
    L4 = ""
  end
  L3.mac5G = L4
  L4 = _UPVALUE0_
  L4 = L4.exec
  L5 = "ubus call trafficd hw '{\"tree\":true}'"
  L4 = L4(L5)
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L5 = L5(L6)
  if L5 then
    return L3
  else
    L5 = _UPVALUE2_
    L5 = L5.decode
    L5 = L5(L6)
    L4 = L5
  end
  L5 = {}
  for L9, L10 in L6, L7, L8 do
    L11 = L10.is_ap
    if L11 ~= nil then
      L11 = L10.is_ap
      if L11 ~= 0 then
        L11 = _simpleRecursive
        L12 = L10
        L11 = L11(L12)
        if L11 then
          L12 = table
          L12 = L12.insert
          L13 = L5
          L14 = L11
          L12(L13, L14)
        end
      end
    end
  end
  if 0 < L6 then
    L3.leafs = L5
  end
  return L3
end
simpleTopoGraph = L5
