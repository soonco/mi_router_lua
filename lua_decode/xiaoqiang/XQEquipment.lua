local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
L0 = module
L1 = "xiaoqiang.XQEquipment"
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
L3 = "luci.util"
L2 = L2(L3)
L3 = {}
L4 = {}
L5 = {}
L5.from = "300000"
L5.to = "3FFFFF"
L5.company = "Broadlink Pty Ltd"
L5.icon = "device_list_intelligent.png"
L6 = {}
L6.c = 1
L6.p = 1
L6.n = "\230\153\186\232\131\189\231\186\162\229\164\150"
L5.type = L6
L5.priority = 2
L6 = {}
L6.from = "100000"
L6.to = "1FFFFF"
L6.company = "Broadlink Pty Ltd"
L6.icon = "device_list_intelligent_plugin.png"
L7 = {}
L7.c = 1
L7.p = 2
L7.n = "\230\153\186\232\131\189\230\143\146\229\186\167"
L6.type = L7
L6.priority = 2
L4[1] = L5
L4[2] = L6
L3.B4430D = L4
L4 = {}
L5 = {}
L5.rule = "^mitv"
L5.company = "Xiaomi"
L5.icon = "device_mitv.png"
L6 = {}
L6.c = 3
L6.p = 4
L6.n = "\229\176\143\231\177\179\231\148\181\232\167\134"
L5.type = L6
L5.priority = 1
L6 = {}
L6.rule = "^mibox"
L6.company = "Xiaomi"
L6.icon = "device_mibox.png"
L7 = {}
L7.c = 3
L7.p = 5
L7.n = "\229\176\143\231\177\179\231\155\146\229\173\144"
L6.type = L7
L6.priority = 1
L7 = {}
L7.rule = "^miwifi%-r1d"
L7.company = "Xiaomi"
L7.icon = "device_miwifi_r1d.png"
L8 = {}
L8.c = 3
L8.p = 8
L8.n = "\229\176\143\231\177\179\232\183\175\231\148\177\229\153\168"
L7.type = L8
L7.priority = 1
L8 = {}
L8.rule = "^miwifi%-r1cm"
L8.company = "Xiaomi"
L8.icon = "device_miwifi_r1c.png"
L9 = {}
L9.c = 3
L9.p = 9
L9.n = "\229\176\143\231\177\179\232\183\175\231\148\177\229\153\168mini"
L8.type = L9
L8.priority = 1
L9 = {}
L9.rule = "^miwifi%-r1cq"
L9.company = "Xiaomi"
L9.icon = "device_miwifi_r1c.png"
L10 = {}
L10.c = 3
L10.p = 10
L10.n = "\229\176\143\231\177\179\232\183\175\231\148\177\229\153\168mini2"
L9.type = L10
L9.priority = 1
L10 = {}
L10.rule = "^miwifi%-tiny"
L10.company = "Xiaomi"
L10.icon = "device_mirouter_wifi.png"
L11 = {}
L11.c = 3
L11.p = 11
L11.n = "\229\176\143\231\177\179\233\154\143\232\186\171WiFi"
L10.type = L11
L10.priority = 1
L11 = {}
L11.rule = "^xiaomirepeater"
L11.company = "Xiaomi"
L11.icon = "device_list_miwifi_repeater.png"
L12 = {}
L12.c = 3
L12.p = 12
L12.n = "\229\176\143\231\177\179Wi-Fi\230\148\190\229\164\167\229\153\168"
L11.type = L12
L11.priority = 1
L12 = {}
L12.rule = "^broadlink_sp2"
L12.company = "Broadlink Pty Ltd"
L12.icon = "device_list_intelligent_plugin.png"
L13 = {}
L13.c = 1
L13.p = 2
L13.n = "\230\153\186\232\131\189\230\143\146\229\186\167"
L12.type = L13
L12.priority = 1
L13 = {}
L13.rule = "^broadlink_rm2"
L13.company = "Broadlink Pty Ltd"
L13.icon = "device_list_intelligent.png"
L14 = {}
L14.c = 1
L14.p = 1
L14.n = "\230\153\186\232\131\189\231\186\162\229\164\150"
L13.type = L14
L13.priority = 1
L14 = {}
L14.rule = "^antscam"
L14.company = "\228\186\145\232\154\129"
L14.icon = "device_list_intelligent_camera.png"
L15 = {}
L15.c = 2
L15.p = 6
L15.n = "\229\176\143\232\154\129\230\153\186\232\131\189\230\145\132\229\131\143\230\156\186"
L14.type = L15
L14.priority = 1
L15 = {}
L15.rule = "^xiaomi%.ir"
L15.company = "Xiaomi"
L15.icon = "device_list_lq.png"
L16 = {}
L16.c = 3
L16.p = 7
L16.n = "\230\153\186\232\131\189\231\186\162\229\164\150"
L15.type = L16
L15.priority = 1
L16 = {}
L16.rule = "chuangmi%-plug"
L16.company = "Chuangmi"
L16.icon = "device_list_intelligent_plugin.png"
L17 = {}
L17.c = 3
L17.p = 2
L17.n = "\230\153\186\232\131\189\230\143\146\229\186\167"
L16.type = L17
L16.priority = 1
L17 = {}
L17.rule = "^zhimi%-airpurifier"
L17.company = "zhimi"
L17.icon = "device_list_airpurifier.png"
L18 = {}
L18.c = 3
L18.p = 11
L18.n = "\231\169\186\230\176\148\229\135\128\229\140\150\229\153\168"
L17.type = L18
L17.priority = 1
L18 = {}
L18.rule = "^xl_miner"
L18.company = "xunlei"
L18.icon = "device_list_xlminer.png"
L19 = {}
L19.c = 4
L19.p = 1
L19.n = "\232\191\133\233\155\183\231\159\191\230\156\186"
L18.type = L19
L18.priority = 1
L4[1] = L5
L4[2] = L6
L4[3] = L7
L4[4] = L8
L4[5] = L9
L4[6] = L10
L4[7] = L11
L4[8] = L12
L4[9] = L13
L4[10] = L14
L4[11] = L15
L4[12] = L16
L4[13] = L17
L4[14] = L18
function L5(A0, A1)
  local L2, L3
  L2 = {}
  L2.name = ""
  L2.icon = ""
  L3 = {}
  L3.c = 0
  L3.p = 0
  L3.n = ""
  L2.type = L3
  L2.priority = 2
  return L2
end
identifyDevice = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  if not L4 then
    A0 = L4
    L10, L11, L12, L13, L14, L15, L16, L17 = L5(L6, L7, L8)
    if L6 then
      if L7 == "table" then
        if L5 then
          for L10, L11 in L7, L8, L9 do
            L12 = tonumber
            L13 = L11.from
            L14 = 16
            L12 = L12(L13, L14)
            L13 = tonumber
            L14 = L11.to
            L15 = 16
            L13 = L13(L14, L15)
            if L5 >= L12 and L5 <= L13 then
              L14 = {}
              L2 = L14
              L14 = {}
              L14.c = 0
              L14.p = 0
              L14.n = ""
              L15 = 2
              L16 = L11.type
              if L16 then
                L14 = L11.type
              end
              L16 = L11.priority
              if L16 then
                L16 = tonumber
                L17 = L11.priority
                L16 = L16(L17)
                L15 = L16
              end
              L16 = L11.company
              L2.name = L16
              L16 = L11.icon
              L2.icon = L16
              L2.type = L14
              L2.priority = L15
            end
          end
        end
    end
    else
      if not L8 then
        L10 = _UPVALUE3_
        L10 = L10.OUI_ZIP_FILEPATH
        L11 = " -C /tmp >/dev/null 2>/dev/null"
        L8(L9)
      end
      if L8 then
        L10 = string
        L10 = L10.gsub
        L11 = A0
        L12 = ":"
        L13 = "-"
        L10 = L10(L11, L12, L13)
        L11 = 1
        L12 = 8
        L10, L11, L12, L13, L14, L15, L16, L17 = L9(L10, L11, L12)
        L10 = "sed -n '/"
        L11 = L4
        L12 = "/p' "
        L13 = _UPVALUE3_
        L13 = L13.OUI_FILEPATH
        L10 = L10 .. L11 .. L12 .. L13
        L10, L11, L12, L13, L14, L15, L16, L17 = L9(L10)
        L10 = L8
        if not L9 then
          L10 = _UPVALUE2_
          L10 = L10.split
          L11 = L8
          L12 = L4
          L10 = L10(L11, L12)
          L10 = L10[2]
          L11 = L9
          L10 = L9.match
          L12 = "ICON:(%S+)"
          L10 = L10(L11, L12)
          L11 = {}
          L2 = L11
          if L10 then
            L12 = L9
            L11 = L9.match
            L13 = "(.+)ICON:%S+"
            L11 = L11(L12, L13)
            L11 = L11 or L11
            L2.name = L11
            L2.icon = L10
          else
            L2.name = L9
            L2.icon = ""
          end
          L11 = {}
          L11.c = 0
          L11.p = 0
          L11.n = ""
          L2.type = L11
          L2.priority = 2
        end
      end
    end
  end
  if not L4 then
    A1 = L4
    for L7, L8 in L4, L5, L6 do
      L10 = A1
      L11 = L8.rule
      if L9 then
        L9.c = 0
        L9.p = 0
        L9.n = ""
        L10 = 2
        L11 = {}
        L3 = L11
        L11 = L8.type
        if L11 then
        end
        L11 = L8.priority
        if L11 then
          L11 = tonumber
          L12 = L8.priority
          L11 = L11(L12)
          L10 = L11
        end
        L11 = L8.company
        L3.name = L11
        L11 = L8.icon
        L3.icon = L11
        L3.type = L9
        L3.priority = L10
        break
      end
    end
  end
  if L2 and L3 then
    if L4 < L5 then
      return L2
    else
      return L3
    end
  elseif not L2 and not L3 then
    L4.name = ""
    L4.icon = ""
    L5.c = 0
    L5.p = 0
    L5.n = ""
    L4.type = L5
    L4.priority = 2
    return L4
  else
    if not L2 then
    end
    return L4
  end
end
identifyDeviceOld = L5
