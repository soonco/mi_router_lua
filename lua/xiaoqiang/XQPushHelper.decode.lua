local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
L0 = module
L1 = "xiaoqiang.XQPushHelper"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "json"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.XQLog"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQFunction"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.util.XQPushUtil"
L3 = L3(L4)
L4 = {}
L5 = "^chuangmi%-plug"
L6 = "^antscam"
L7 = "^yeelink%-light"
L8 = "^lumi%-gateway"
L9 = "^zhimi%-airpurifier"
L10 = "^yunmi%-waterpurifier"
L11 = "^midea%-aircondition"
L12 = "^xiaomirepeater"
L4[1] = L5
L4[2] = L6
L4[3] = L7
L4[4] = L8
L4[5] = L9
L4[6] = L10
L4[7] = L11
L4[8] = L12
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  if A0 then
    for L4, L5 in L1, L2, L3 do
      L7 = A0
      L6 = A0.match
      L8 = L5
      L6 = L6(L7, L8)
      if L6 then
        L6 = true
        return L6
      end
    end
  end
  return L1
end
_exception = L5
function L5(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  if not (A0 and A1) or not A2 then
    return
  end
  L5 = _UPVALUE0_
  L5 = L5._cmdformat
  L6 = A0
  L5 = L5(L6)
  A0 = L5
  L5 = "1"
  if A3 then
    L6 = tostring
    L7 = A3
    L6 = L6(L7)
    L5 = L6
  end
  L6 = string
  L6 = L6.format
  L7 = "matool --method notify --params \"%s\""
  L8 = A0
  L6 = L6(L7, L8)
  if A4 then
    L7 = _UPVALUE0_
    L7 = L7.forkExec
    L8 = L6
    L7(L8)
  else
    L7 = os
    L7 = L7.execute
    L8 = L6
    L7(L8)
  end
  L7 = _UPVALUE1_
  L7 = L7.log
  L8 = 6
  L9 = "matool notify:"
  L10 = A0
  L7(L8, L9, L10)
end
_doPush = L5
function L5(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12
  L4 = "eventservice"
  L5 = {}
  L5.type = A0
  L5.mac = A1
  L5.name = A2
  L5.count = A3
  L6 = require
  L7 = "ubus"
  L6 = L6(L7)
  L7 = L6.connect
  L7 = L7()
  if L7 then
    L9 = L7
    L8 = L7.call
    L10 = L4
    L11 = "fcw_notify"
    L12 = L5
    L8(L9, L10, L11, L12)
    L9 = L7
    L8 = L7.close
    L8(L9)
    L8 = _UPVALUE0_
    L8 = L8.log
    L9 = 6
    L10 = "eventservice notify:"
    L11 = L5
    L8(L9, L10, L11)
  end
end
_doEventServicePush = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    return
  end
  L2 = string
  L2 = L2.format
  L3 = "matool --method reportEvents --params '[%s]'"
  L4 = A0
  L2 = L2(L3, L4)
  L3 = _UPVALUE1_
  L3 = L3.log
  L4 = 4
  L5 = L2
  L3(L4, L5)
  if A1 then
    L3 = _UPVALUE0_
    L3 = L3.forkExec
    L4 = L2
    L3(L4)
  else
    L3 = os
    L3 = L3.execute
    L4 = L2
    L3(L4)
  end
  L3 = _UPVALUE1_
  L3 = L3.log
  L4 = 4
  L5 = "WiFi/LOGIN Authen failed: "
  L6 = A0
  L5 = L5 .. L6
  L3(L4, L5)
end
_matool = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = L0.getRomVersion
  L1 = L1()
  L2 = {}
  L2.type = 1
  L2.ver = L1
  L3 = _doPush
  L4 = _UPVALUE0_
  L4 = L4.encode
  L5 = L2
  L4 = L4(L5)
  L5 = "\231\179\187\231\187\159\229\141\135\231\186\167"
  L6 = "\231\179\187\231\187\159\229\141\135\231\186\167"
  L3(L4, L5, L6)
end
_hookSysUpgraded = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    return
  end
  L2 = _UPVALUE0_
  L2 = L2.macFormat
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L3 = require
  L4 = "luci.model.uci"
  L3 = L3(L4)
  L3 = L3.cursor
  L3 = L3()
  L5 = L3
  L4 = L3.get
  L6 = "misc"
  L7 = "wireless"
  L8 = "guest_2G"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L5 = tonumber
  L6 = os
  L6 = L6.time
  L6, L7, L8, L9, L10, L14, L15, L16, L17, L18, L19, L20, L21, L22 = L6()
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
  L7 = L3
  L6 = L3.get
  L8 = "devicelist"
  L9 = "history"
  L10 = L2
  L6 = L6(L7, L8, L9, L10)
  L7 = false
  L8 = false
  L9 = 0
  if not L6 then
    L7 = true
    L10 = 0
    L14 = "history"
    tb_val = L11
    for L14, L15 in L11, L12, L13 do
      L10 = L10 + 1
    end
    if 512 <= L10 then
      L11(L12, L13)
      return
    end
    L14 = "history"
    L15 = L2
    L16 = L5
    L11(L12, L13, L14, L15, L16)
    if not L11 then
      L14 = "Devicelist write error then exit."
      L12(L13, L14)
      return
    end
  end
  L10 = L3.get
  L14 = L2
  L10 = L10(L11, L12, L13, L14)
  if L10 then
    L8 = true
  end
  if L7 or L8 then
    L14 = L12.dhcpname
    if not L13 then
      L14 = L12.dhcpname
      L15 = L13
      L14 = L13.match
      L16 = "^miwifi"
      L14 = L14(L15, L16)
      if L14 then
        L14 = {}
        L14.type = 23
        L14.name = "\229\176\143\231\177\179\232\183\175\231\148\177\229\153\168"
        L15 = _doPush
        L16 = _UPVALUE2_
        L16 = L16.encode
        L17 = L14
        L16 = L16(L17)
        L17 = "\228\184\173\231\187\167\230\136\144\229\138\159"
        L18 = "\228\184\173\231\187\167\230\136\144\229\138\159"
        L15(L16, L17, L18)
        return
      else
        L15 = L13
        L14 = L13.match
        L16 = "^xiaomirepeater"
        L14 = L14(L15, L16)
        if L14 then
          L14 = {}
          L14.type = 56
          L14.name = "\229\176\143\231\177\179\228\184\173\231\187\167\229\153\168"
          L14.mac = A0
          L15 = _doPush
          L16 = _UPVALUE2_
          L16 = L16.encode
          L17 = L14
          L16 = L16(L17)
          L17 = "\228\184\173\231\187\167\230\136\144\229\138\159"
          L18 = "\228\184\173\231\187\167\230\136\144\229\138\159"
          L15(L16, L17, L18)
          return
        end
      end
    end
    L14 = string
    L14 = L14.lower
    L15 = L12.dhcpname
    L14 = L14(L15)
    if L7 then
      L15 = _exception
      L16 = L14
      L15 = L15(L16)
      if L15 then
        return
      end
    end
    if L13 then
      L15 = string
      L15 = L15.lower
      L16 = L13
      L15 = L15(L16)
      L16 = L15
      L15 = L15.match
      L17 = "android-%S+"
      L15 = L15(L16, L17)
      if L15 then
        L15 = #L13
        if 12 < L15 then
          L16 = L13
          L15 = L13.sub
          L17 = 1
          L18 = 12
          L15 = L15(L16, L17, L18)
        end
      end
    end
    L15 = L12.type
    L15 = L15.c
    if L15 == 2 then
      L15 = L12.type
      L15 = L15.p
      if L15 == 6 then
        goto lbl_207
      end
    end
    L15 = L12.type
    L15 = L15.c
    if L15 == 3 then
      L15 = L12.type
      L15 = L15.p
      if L15 == 2 then
        goto lbl_207
      end
    end
    L15 = L12.type
    L15 = L15.c
    if L15 == 3 then
      L15 = L12.type
      L15 = L15.p
      ::lbl_207::
      if L15 == 7 then
        return
      end
    end
    if L7 then
      L15 = _UPVALUE3_
      L15 = L15.pushSettings
      L15 = L15()
      L16 = L15.auth
      if L16 then
        L16 = L15.level
        if L16 then
          L16 = L15.level
          if 2 <= L16 then
            L16 = _UPVALUE0_
            L16 = L16.isStrNil
            L17 = L12.dhcpname
            L16 = L16(L17)
            if L16 then
              L16 = os
              L16 = L16.execute
              L17 = "sleep 4"
              L16(L17)
              L16 = L11.getDeviceInfo
              L17 = A0
              L16 = L16(L17)
              L16 = string
              L16 = L16.lower
              L17 = L12.dhcpname
              L16 = L16(L17)
              L14 = L16
              if L7 then
                L16 = _exception
                L17 = L14
                L16 = L16(L17)
                if L16 then
                  return
                end
              end
              if L13 then
                L16 = string
                L16 = L16.lower
                L17 = L13
                L16 = L16(L17)
                L17 = L16
                L16 = L16.match
                L18 = "android-%S+"
                L16 = L16(L17, L18)
                if L16 then
                  L16 = #L13
                  if 12 < L16 then
                    L17 = L13
                    L16 = L13.sub
                    L18 = 1
                    L19 = 12
                    L16 = L16(L17, L18, L19)
                  end
                end
              end
            end
            L16 = {}
            L16.type = 3
            L16.mac = A0
            L16.name = L13
            if A1 == L4 then
              L16.type = 27
            end
            L17 = _doPush
            L18 = _UPVALUE2_
            L18 = L18.encode
            L19 = L16
            L18 = L18(L19)
            L19 = "\233\153\140\231\148\159\232\174\190\229\164\135\228\184\138\231\186\191"
            L20 = "\233\153\140\231\148\159\232\174\190\229\164\135\228\184\138\231\186\191"
            L17(L18, L19, L20)
            L17 = L12.flag
            if L17 == 0 then
              L17 = require
              L18 = "xiaoqiang.util.XQDBUtil"
              L17 = L17(L18)
              XQDBUtil = L17
              L17 = XQDBUtil
              L17 = L17.saveDeviceInfo
              L18 = A0
              L19 = L12.dhcpname
              L20 = ""
              L21 = ""
              L22 = ""
              L17(L18, L19, L20, L21, L22)
            end
            L17 = _UPVALUE1_
            L17 = L17.log
            L18 = 6
            L19 = "New Device Connect."
            L20 = L12
            L17(L18, L19, L20)
          end
        end
      end
    elseif L8 then
      L15 = _UPVALUE1_
      L15 = L15.log
      L16 = 6
      L17 = "Special Device Connect."
      L18 = L12
      L15(L16, L17, L18)
      L15 = require
      L16 = "xiaoqiang.util.XQDBUtil"
      L15 = L15(L16)
      L16 = L15.vip_device_pre_push
      L17 = A0
      L18 = L13
      L19 = "online"
      L16(L17, L18, L19)
    end
  end
end
_hookWifiConnect = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    return
  else
    L3 = _UPVALUE0_
    L3 = L3.macFormat
    L4 = A0
    L3 = L3(L4)
    A0 = L3
  end
  L3 = require
  L4 = "xiaoqiang.util.XQDeviceUtil"
  L3 = L3(L4)
  L4 = L3.getDeviceInfo
  L5 = A0
  L4 = L4(L5)
  L5 = A2
  L6 = string
  L6 = L6.lower
  L7 = L4.dhcpname
  L6 = L6(L7)
  L7 = _exception
  L8 = L6
  L7 = L7(L8)
  if L7 then
    return
  end
  L7 = L4.type
  L7 = L7.c
  if L7 == 2 then
    L7 = L4.type
    L7 = L7.p
    if L7 == 6 then
      goto lbl_55
    end
  end
  L7 = L4.type
  L7 = L7.c
  if L7 == 3 then
    L7 = L4.type
    L7 = L7.p
    if L7 == 2 then
      goto lbl_55
    end
  end
  L7 = L4.type
  L7 = L7.c
  if L7 == 3 then
    L7 = L4.type
    L7 = L7.p
    ::lbl_55::
    if L7 == 7 then
      return
    end
  end
  L7 = {}
  L7.type = 60
  L7.mac = A0
  L7.name = L5
  L7.sns = A1
  L8 = _doPush
  L9 = _UPVALUE1_
  L9 = L9.encode
  L10 = L7
  L9 = L9(L10)
  L10 = "Guest wifi"
  L11 = "Guest wifi"
  L8(L9, L10, L11)
end
_guestWifiConnectPush = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    return
  end
  L1 = _UPVALUE0_
  L1 = L1.macFormat
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = L1.getDeviceInfo
  L3 = A0
  L2 = L2(L3)
  L3 = L2.name
  L4 = string
  L4 = L4.lower
  L5 = L2.dhcpname
  L4 = L4(L5)
  if L3 then
    L5 = string
    L5 = L5.lower
    L6 = L3
    L5 = L5(L6)
    L6 = L5
    L5 = L5.match
    L7 = "android-%S+"
    L5 = L5(L6, L7)
    if L5 then
      L5 = #L3
      if 12 < L5 then
        L6 = L3
        L5 = L3.sub
        L7 = 1
        L8 = 12
        L5 = L5(L6, L7, L8)
        L3 = L5
      end
    end
  end
  L6 = A0
  L5 = A0.gsub
  L7 = ":"
  L8 = ""
  L5 = L5(L6, L7, L8)
  L6 = require
  L7 = "luci.model.uci"
  L6 = L6(L7)
  L6 = L6.cursor
  L6 = L6()
  L7 = tonumber
  L8 = os
  L8 = L8.time
  L8, L9, L10, L11, L12, L13 = L8()
  L7 = L7(L8, L9, L10, L11, L12, L13)
  L9 = L6
  L8 = L6.get
  L10 = "devicelist"
  L11 = "notify"
  L12 = L5
  L8 = L8(L9, L10, L11, L12)
  if L8 then
    L9 = _UPVALUE1_
    L9 = L9.log
    L10 = 6
    L11 = "Special Device DisConnect."
    L12 = L2
    L9(L10, L11, L12)
    L9 = require
    L10 = "xiaoqiang.util.XQDBUtil"
    L9 = L9(L10)
    L10 = L9.vip_device_pre_push
    L11 = A0
    L12 = L3
    L13 = "offline"
    L10(L11, L12, L13)
  end
end
_hookWifiDisconnect = L5
function L5()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L0 = L0.log
  L1 = 6
  L2 = "All download finished"
  L0(L1, L2)
  L0 = {}
  L0.type = 5
  L1 = _doPush
  L2 = _UPVALUE1_
  L2 = L2.encode
  L3 = L0
  L2 = L2(L3)
  L3 = "\228\184\139\232\189\189\229\174\140\230\136\144"
  L4 = "\228\184\139\232\189\189\229\174\140\230\136\144"
  L1(L2, L3, L4)
end
_hookAllDownloadFinished = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = A0
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L2 = ""
  end
  L3 = _UPVALUE1_
  L3 = L3.log
  L4 = 6
  L5 = "Intelligent Scene:"
  L6 = A0
  L7 = " finished!"
  L5 = L5 .. L6 .. L7
  L3(L4, L5)
  L3 = {}
  L3.type = 6
  L3.name = A0
  L3.actions = A1
  L4 = _doPush
  L5 = _UPVALUE2_
  L5 = L5.encode
  L6 = L3
  L5 = L5(L6)
  L6 = "\230\153\186\232\131\189\229\156\186\230\153\175"
  L7 = "\230\153\186\232\131\189\229\156\186\230\153\175"
  L4(L5, L6, L7)
end
_hookIntelligentScene = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6
  if A0 and A1 then
    L2 = _UPVALUE0_
    L2 = L2.log
    L3 = 6
    L4 = "network detect finished!"
    L2(L3, L4)
    L2 = {}
    L2.type = 7
    L2.lan = A0
    L2.wan = A1
    L3 = _doPush
    L4 = _UPVALUE1_
    L4 = L4.encode
    L5 = L2
    L4 = L4(L5)
    L5 = "\231\189\145\231\187\156\230\163\128\230\181\139"
    L6 = "\231\189\145\231\187\156\230\163\128\230\181\139"
    L3(L4, L5, L6)
  end
end
_hookDetectFinished = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6
  if A0 and A1 then
    L2 = _UPVALUE0_
    L2 = L2.log
    L3 = 6
    L4 = "cachecenter event!"
    L2(L3, L4)
    L2 = {}
    L2.type = 13
    L2.hitcount = A0
    L2.timesaver = A1
    L3 = _doPush
    L4 = _UPVALUE1_
    L4 = L4.encode
    L5 = L2
    L4 = L4(L5)
    L5 = "\229\138\160\233\128\159\231\155\184\229\133\179"
    L6 = "\229\138\160\233\128\159\231\155\184\229\133\179"
    L3(L4, L5, L6)
  end
end
_hookCachecenterEvent = L5
function L5(A0)
  local L1, L2, L3, L4, L5
  L1 = tonumber
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = _UPVALUE0_
    L1 = L1.log
    L2 = 6
    L3 = "download event!"
    L1(L2, L3)
    L1 = {}
    L1.type = 17
    L2 = tonumber
    L3 = A0
    L2 = L2(L3)
    L1.count = L2
    L2 = _doPush
    L3 = _UPVALUE1_
    L3 = L3.encode
    L4 = L1
    L3 = L3(L4)
    L4 = "\228\184\139\232\189\189\229\174\140\230\136\144"
    L5 = "\228\184\139\232\189\189\229\174\140\230\136\144"
    L2(L3, L4, L5)
  end
end
_hookDownloadEvent = L5
function L5(A0)
  local L1, L2, L3, L4, L5
  L1 = tonumber
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = _UPVALUE0_
    L1 = L1.log
    L2 = 6
    L3 = "upload event!"
    L1(L2, L3)
    L1 = {}
    L1.type = 18
    L2 = tonumber
    L3 = A0
    L2 = L2(L3)
    L1.count = L2
    L2 = _doPush
    L3 = _UPVALUE1_
    L3 = L3.encode
    L4 = L1
    L3 = L3(L4)
    L4 = "\228\184\138\228\188\160\229\174\140\230\136\144"
    L5 = "\228\184\138\228\188\160\229\174\140\230\136\144"
    L2(L3, L4, L5)
  end
end
_hookUploadEvent = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = tonumber
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = tonumber
    L3 = A1
    L2 = L2(L3)
    if L2 then
      L2 = _UPVALUE0_
      L2 = L2.log
      L3 = 6
      L4 = "upload event!"
      L2(L3, L4)
      L2 = {}
      L2.type = 19
      L3 = tonumber
      L4 = A0
      L3 = L3(L4)
      L2.page = L3
      L3 = tonumber
      L4 = A1
      L3 = L3(L4)
      L2.all = L3
      L3 = _doPush
      L4 = _UPVALUE1_
      L4 = L4.encode
      L5 = L2
      L4 = L4(L5)
      L5 = "\229\185\191\229\145\138\232\191\135\230\187\164"
      L6 = "\229\185\191\229\145\138\232\191\135\230\187\164"
      L3(L4, L5, L6)
    end
  end
end
_hookADFilterEvent = L5
function L5(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.log
  L2 = 6
  L3 = "Unknown Feed"
  L1(L2, L3)
  L1 = {}
  L1.type = 999
  L1.data = A0
  L2 = _doPush
  L3 = _UPVALUE1_
  L3 = L3.encode
  L4 = L1
  L3 = L3(L4)
  L4 = "\230\150\176\230\182\136\230\129\175"
  L5 = "\230\156\170\229\174\154\228\185\137"
  L2(L3, L4, L5)
end
_hookDefault = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = _UPVALUE0_
  L1 = L1.log
  L2 = 6
  L3 = "New ROM version detected"
  L1(L2, L3)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQConfigs"
  L2 = L2(L3)
  L3 = L1.get
  L4 = L2.PREF_ROUTER_NAME
  L5 = ""
  L3 = L3(L4, L5)
  L4 = require
  L5 = "xiaoqiang.util.XQSysUtil"
  L4 = L4(L5)
  L5 = L4.getChannel
  L5 = L5()
  L6 = {}
  L6.type = 14
  L6.name = L3
  L6.version = A0
  L6.channel = L5
  L7 = _doPush
  L8 = _UPVALUE1_
  L8 = L8.encode
  L9 = L6
  L8 = L8(L9)
  L9 = "\229\143\145\231\142\176\230\150\176\231\137\136\230\156\172"
  L10 = "\229\143\145\231\142\176\230\150\176\231\137\136\230\156\172"
  L7(L8, L9, L10)
end
_hookNewRomVersionDetected = L5
function L5()
  local L0, L1, L2, L3, L4
  L0 = {}
  L0.type = 29
  L1 = _doPush
  L2 = _UPVALUE0_
  L2 = L2.encode
  L3 = L0
  L2 = L2(L3)
  L3 = "\228\191\161\233\129\147\229\143\175\228\187\165\228\188\152\229\140\150"
  L4 = "\228\191\161\233\129\147\229\143\175\228\187\165\228\188\152\229\140\150"
  L1(L2, L3, L4)
end
_hookWifiImproveNotify = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
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
  L2 = "xiaoqiang.module.XQAntiRubNetwork"
  L1 = L1(L2)
  L2 = tonumber
  L3 = os
  L3 = L3.time
  L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16 = L3()
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16)
  L3 = _UPVALUE1_
  L3 = L3.pushSettings
  L3 = L3()
  L4 = L1.wifiAuthenFailedAction
  L5 = A0
  L4 = L4(L5)
  L5 = os
  L5 = L5.execute
  L6 = "xqled attack_alert"
  L5(L6)
  if L4 then
    L5 = L3.auth
    if L5 then
      L5 = _UPVALUE1_
      L5 = L5.getwifiauthfailedserialtimes
      L6 = A0
      L5 = L5(L6)
      if 5 <= L5 then
        L5 = _UPVALUE1_
        L5 = L5.setwifiauthfailedserialtimes
        L6 = A0
        L7 = 0
        L5(L6, L7)
        L5 = L3.level
        if L5 then
          L5 = L3.level
          if L5 == 2 then
            L5 = {}
            L5.type = 51
            L5.mac = A0
            L5.count = L4
            L6 = {}
            L6.eventID = 1001
            L7 = {}
            L7.mac = A0
            L7.count = L4
            L6.payload = L7
            L7 = _matool
            L8 = _UPVALUE2_
            L8 = L8.encode
            L9 = L6
            L8, L9, L10, L11, L12, L13, L14, L15, L16 = L8(L9)
            L7(L8, L9, L10, L11, L12, L13, L14, L15, L16)
            L7 = "MWIFI_"
            L9 = A0
            L8 = A0.gsub
            L10 = ":"
            L11 = ""
            L8 = L8(L9, L10, L11)
            L7 = L7 .. L8
            L8 = _UPVALUE1_
            L8 = L8.getTimestamp
            L9 = L7
            L8 = L8(L9)
            L9 = L2 - L8
            if 7200 < L9 then
              L9 = _UPVALUE1_
              L9 = L9.setTimestamp
              L10 = L7
              L11 = L2
              L9 = L9(L10, L11)
              if not L9 then
                return
              end
              L9 = _doPush
              L10 = _UPVALUE2_
              L10 = L10.encode
              L11 = L5
              L10 = L10(L11)
              L11 = "WiFi\229\175\134\231\160\129\233\148\153\232\175\175"
              L12 = "\230\156\137\233\163\142\233\153\169"
              L9(L10, L11, L12)
            end
        end
        else
          L5 = L3.level
          if L5 then
            L5 = L3.level
            if L5 == 3 then
              L5 = require
              L6 = "xiaoqiang.util.XQWifiUtil"
              L5 = L5(L6)
              L6 = L5.editWiFiMacfilterList
              L7 = 0
              L8 = {}
              L9 = A0
              L8[1] = L9
              L9 = 0
              L6(L7, L8, L9)
              L6 = require
              L7 = "luci.model.uci"
              L6 = L6(L7)
              L6 = L6.cursor
              L6 = L6()
              L8 = L6
              L7 = L6.get
              L9 = "misc"
              L10 = "hardware"
              L11 = "model"
              L7 = L7(L8, L9, L10, L11)
              L7 = L7 or L7
              if L7 then
                L8 = string
                L8 = L8.lower
                L9 = L7
                L8 = L8(L9)
                L7 = L8
              end
              L9 = L6
              L8 = L6.get
              L10 = "xiaoqiang"
              L11 = "common"
              L12 = "NETMODE"
              L8 = L8(L9, L10, L11, L12)
              L8 = L8 or L8
              L9 = _UPVALUE0_
              L9 = L9.isMeshCap
              L9 = L9()
              if L9 then
                L9 = _UPVALUE0_
                L9 = L9.forkExec
                L10 = "/sbin/notice_tbus_device_maclist.sh"
                L9(L10)
              end
              L9 = {}
              L9.type = 52
              L9.mac = A0
              L9.count = L4
              L10 = {}
              L10.eventID = 1002
              L11 = {}
              L11.mac = A0
              L11.count = L4
              L10.payload = L11
              L11 = _matool
              L12 = _UPVALUE2_
              L12 = L12.encode
              L13 = L10
              L12, L13, L14, L15, L16 = L12(L13)
              L11(L12, L13, L14, L15, L16)
              L11 = "HWIFI_"
              L13 = A0
              L12 = A0.gsub
              L14 = ":"
              L15 = ""
              L12 = L12(L13, L14, L15)
              L11 = L11 .. L12
              L12 = _UPVALUE1_
              L12 = L12.getTimestamp
              L13 = L11
              L12 = L12(L13)
              L13 = L2 - L12
              if 7200 < L13 then
                L13 = _UPVALUE1_
                L13 = L13.setTimestamp
                L14 = L11
                L15 = L2
                L13 = L13(L14, L15)
                if not L13 then
                  return
                end
                L13 = _doPush
                L14 = _UPVALUE2_
                L14 = L14.encode
                L15 = L9
                L14 = L14(L15)
                L15 = "WiFi\229\175\134\231\160\129\233\148\153\232\175\175"
                L16 = "\229\188\186\229\136\182\230\139\137\233\187\145"
                L13(L14, L15, L16)
              end
            end
          end
        end
      end
    end
  end
end
_hookWifiAuthenFailed = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
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
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQAntiRubNetwork"
  L2 = L2(L3)
  L3 = tonumber
  L4 = os
  L4 = L4.time
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13 = L4()
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13)
  L4 = _UPVALUE1_
  L4 = L4.pushSettings
  L4 = L4()
  L5 = L2.LoginAuthenFailedAction
  L6 = A0
  L5 = L5(L6)
  if L5 then
    L6 = os
    L6 = L6.execute
    L7 = "xqled attack_alert"
    L6(L7)
    L6 = require
    L7 = "luci.cbi.datatypes"
    L6 = L6(L7)
    L7 = _UPVALUE0_
    L7 = L7.getFeature
    L8 = "0"
    L9 = "system"
    L10 = "dt_spec"
    L7 = L7(L8, L9, L10)
    if A0 then
      L8 = L6.macaddr
      L9 = A0
      L8 = L8(L9)
      if L8 then
        if L7 == "0" then
          L8 = os
          L8 = L8.execute
          L9 = "/usr/sbin/ban_admin ban "
          L10 = A0
          L9 = L9 .. L10
          L8(L9)
        else
          L8 = _UPVALUE1_
          L8 = L8.setBanLoginTimeStamp
          L9 = A0
          L8(L9)
        end
      end
    end
  end
  if L5 then
    L6 = L4.auth
    if L6 then
      L6 = _UPVALUE0_
      L6 = L6.isMeshMode
      L6 = L6()
      if L6 then
        L6 = L1.getAllWifiConnetDeviceDict
        L6 = L6()
        L7 = L6[A0]
        if not L7 then
          return
        end
      end
      L6 = L4.level
      if L6 then
        L6 = L4.level
        if L6 == 2 then
          L6 = {}
          L6.type = 53
          L6.mac = A0
          L6.count = L5
          L7 = {}
          L7.eventID = 1003
          L8 = {}
          L8.mac = A0
          L8.count = L5
          L7.payload = L8
          L8 = _matool
          L9 = _UPVALUE2_
          L9 = L9.encode
          L10 = L7
          L9, L10, L11, L12, L13 = L9(L10)
          L8(L9, L10, L11, L12, L13)
          L8 = "MLOGIN_"
          L10 = A0
          L9 = A0.gsub
          L11 = ":"
          L12 = ""
          L9 = L9(L10, L11, L12)
          L8 = L8 .. L9
          L9 = _UPVALUE1_
          L9 = L9.getTimestamp
          L10 = L8
          L9 = L9(L10)
          L10 = L3 - L9
          if 7200 < L10 then
            L10 = _doPush
            L11 = _UPVALUE2_
            L11 = L11.encode
            L12 = L6
            L11 = L11(L12)
            L12 = "\231\174\161\231\144\134\229\145\152\229\175\134\231\160\129\233\148\153\232\175\175"
            L13 = "\230\156\137\233\163\142\233\153\169"
            L10(L11, L12, L13)
            L10 = _UPVALUE1_
            L10 = L10.setTimestamp
            L11 = L8
            L12 = L3
            L10(L11, L12)
          end
      end
      else
        L6 = L4.level
        if L6 then
          L6 = L4.level
          if L6 == 3 then
            L6 = L1.editWiFiMacfilterList
            L7 = 0
            L8 = {}
            L9 = A0
            L8[1] = L9
            L9 = 0
            L6(L7, L8, L9)
            L6 = _UPVALUE0_
            L6 = L6.isMeshCap
            L6 = L6()
            if L6 then
              L6 = _UPVALUE0_
              L6 = L6.forkExec
              L7 = "/sbin/notice_tbus_device_maclist.sh"
              L6(L7)
            end
            L6 = {}
            L6.type = 54
            L6.mac = A0
            L6.count = L5
            L7 = {}
            L7.eventID = 1004
            L8 = {}
            L8.mac = A0
            L8.count = L5
            L7.payload = L8
            L8 = _matool
            L9 = _UPVALUE2_
            L9 = L9.encode
            L10 = L7
            L9 = L9(L10)
            L10 = true
            L8(L9, L10)
            L8 = "HLOGIN_"
            L10 = A0
            L9 = A0.gsub
            L11 = ":"
            L12 = ""
            L9 = L9(L10, L11, L12)
            L8 = L8 .. L9
            L9 = _UPVALUE1_
            L9 = L9.getTimestamp
            L10 = L8
            L9 = L9(L10)
            L10 = L3 - L9
            if 7200 < L10 then
              L10 = _doPush
              L11 = _UPVALUE2_
              L11 = L11.encode
              L12 = L6
              L11 = L11(L12)
              L12 = "\231\174\161\231\144\134\229\145\152\229\175\134\231\160\129\233\148\153\232\175\175"
              L13 = "\229\188\186\229\136\182\230\139\137\233\187\145"
              L10(L11, L12, L13)
              L10 = _UPVALUE1_
              L10 = L10.setTimestamp
              L11 = L8
              L12 = L3
              L10(L11, L12)
            end
          end
        end
      end
    end
  end
end
_hookLoginAuthenFailed = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
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
  L2 = "xiaoqiang.util.XQWifiUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.module.XQAntiRubNetwork"
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.pushSettings
  L3 = L3()
  L4 = L2.wifiBlacklistedAction
  L5 = A0
  L4 = L4(L5)
  L5 = L1.getWiFiMacfilterModel
  L5 = L5()
  if L4 then
    L6 = L3.auth
    if L6 then
      L6 = {}
      L6.eventID = 1005
      L7 = {}
      L7.mac = A0
      L7.count = L4
      L6.payload = L7
      if L5 and L5 == 2 then
        L6.eventID = 1001
      end
      L7 = _matool
      L8 = _UPVALUE2_
      L8 = L8.encode
      L9 = L6
      L8, L9 = L8(L9)
      L7(L8, L9)
    end
  end
end
_hookWifiBlacklisted = L5
function L5()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.module.XQMessageBox"
  L0 = L0(L1)
  L1 = L0.addMessage
  L2 = {}
  L2.type = 3
  L3 = {}
  L2.data = L3
  L1(L2)
  L1 = _doPush
  L2 = "{\"type\":55}"
  L3 = "5G WiFi\229\151\157\229\177\129\228\186\134"
  L4 = "5G WiFi\229\151\157\229\177\129\228\186\134"
  L1(L2, L3, L4)
end
_hook5GWifiCrashed = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "cjson"
  L2 = L2(L3)
  L3 = tonumber
  L4 = A0.type
  L3 = L3(L4)
  L4 = nil
  if L3 == 14 then
    L4 = 1
  elseif L3 == 15 then
    L4 = 2
  elseif L3 == 16 then
    L4 = 3
  end
  L5 = {}
  L5.msgtype = L4
  L5.msg = A0
  L6 = L2.encode
  L7 = L5
  L6 = L6(L7)
  L7 = _UPVALUE0_
  L7 = L7.log
  L8 = 4
  L9 = "push to cap data_j="
  L10 = L6
  L7(L8, L9, L10)
  L7 = L1.forkExec
  L8 = string
  L8 = L8.format
  L9 = "ubus call xq_info_sync_mqtt whc_common_push \"%s\""
  L10 = L1._cmdformat
  L11 = L6
  L10, L11 = L10(L11)
  L8, L9, L10, L11 = L8(L9, L10, L11)
  L7(L8, L9, L10, L11)
end
push_to_cap = L5
function L5(A0)
  local L1, L2, L3, L4, L5
  L1 = 0
  L2 = _UPVALUE0_
  L2 = L2.isMeshRe
  L2 = L2()
  if L2 then
    L1 = 1
  end
  L2 = tonumber
  L3 = A0.type
  L2 = L2(L3)
  if L2 == 1 then
    L3 = _hookWifiConnect
    L4 = A0.data
    L4 = L4.mac
    L5 = A0.data
    L5 = L5.dev
    L3(L4, L5)
  elseif L2 == 2 then
    L3 = _hookWifiDisconnect
    L4 = A0.data
    L4 = L4.mac
    L3(L4)
  elseif L2 == 3 then
    L3 = _hookSysUpgraded
    L3()
  elseif L2 == 4 then
    L3 = _hookAllDownloadFinished
    L3()
  elseif L2 == 5 then
    L3 = _hookIntelligentScene
    L4 = A0.data
    L4 = L4.name
    L5 = A0.data
    L5 = L5.list
    L3(L4, L5)
  elseif L2 == 6 then
    L3 = _hookDetectFinished
    L4 = A0.data
    L4 = L4.lan
    L5 = A0.data
    L5 = L5.wan
    L3(L4, L5)
  elseif L2 == 7 then
    L3 = _hookCachecenterEvent
    L4 = A0.data
    L4 = L4.hit_count
    L5 = A0.data
    L5 = L5.timesaver
    L3(L4, L5)
  elseif L2 == 8 then
    L3 = _hookNewRomVersionDetected
    L4 = A0.data
    L4 = L4.version
    L3(L4)
  elseif L2 == 9 then
    L3 = _hookDownloadEvent
    L4 = A0.data
    L4 = L4.count
    L3(L4)
  elseif L2 == 10 then
    L3 = _hookUploadEvent
    L4 = A0.data
    L4 = L4.count
    L3(L4)
  elseif L2 == 11 then
    L3 = _hookADFilterEvent
    L4 = A0.data
    L4 = L4.filter_page
    L5 = A0.data
    L5 = L5.filter_all
    L3(L4, L5)
  elseif L2 == 13 then
    L3 = _hookWifiImproveNotify
    L3()
  elseif L2 == 14 then
    if L1 == 1 then
      L3 = push_to_cap
      L4 = A0
      L3(L4)
    else
      L3 = _hookWifiAuthenFailed
      L4 = A0.data
      L4 = L4.mac
      L3(L4)
    end
  elseif L2 == 15 then
    if L1 == 1 then
      L3 = push_to_cap
      L4 = A0
      L3(L4)
    else
      L3 = _hookWifiBlacklisted
      L4 = A0.data
      L4 = L4.mac
      L3(L4)
    end
  elseif L2 == 16 then
    if L1 == 1 then
      L3 = push_to_cap
      L4 = A0
      L3(L4)
    end
    L3 = _hookLoginAuthenFailed
    L4 = A0.data
    L4 = L4.mac
    L3(L4)
  elseif L2 == 50 then
    L3 = _hook5GWifiCrashed
    L3()
  else
    L3 = _hookDefault
    L4 = A0.data
    L3(L4)
  end
  L3 = true
  return L3
end
push_request_lua = L5
function L5(A0)
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
  L1 = L1.decode
  L2 = A0
  L1 = L1(L2)
  L2 = push_request_lua
  L3 = L1
  return L2(L3)
end
push_request = L5
