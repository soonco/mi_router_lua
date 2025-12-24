local L0, L1, L2
L0 = module
L1 = "luci.controller.web.index"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = node
  L0 = L0()
  L1 = L0.target
  if not L1 then
    L1 = alias
    L2 = "web"
    L1 = L1(L2)
    L0.target = L1
    L0.index = true
  end
  L1 = node
  L2 = "web"
  L1 = L1(L2)
  L2 = firstchild
  L2 = L2()
  L1.target = L2
  L2 = _
  L3 = ""
  L2 = L2(L3)
  L1.title = L2
  L1.order = 10
  L1.sysauth = "admin"
  L1.mediaurlbase = "/xiaoqiang/web"
  L1.sysauth_authenticator = "htmlauth"
  L1.index = true
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = L3.getMiscHardwareInfo
  L4 = L4()
  L5 = require
  L6 = "xiaoqiang.common.XQFunction"
  L5 = L5(L6)
  L6 = L5.getNetModeType
  L6 = L6()
  L7 = require
  L8 = "xiaoqiang.XQFeatures"
  L7 = L7(L8)
  L7 = L7.FEATURES
  L8 = entry
  L9 = {}
  L10 = "web"
  L9[1] = L10
  L10 = alias
  L11 = "web"
  L12 = "home"
  L10 = L10(L11, L12)
  L11 = _
  L12 = "\232\183\175\231\148\177\229\153\168\231\138\182\230\128\129"
  L11 = L11(L12)
  L12 = 10
  L13 = 8
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "logout"
  L9[1] = L10
  L9[2] = L11
  L10 = call
  L11 = "action_logout"
  L10 = L10(L11)
  L11 = 11
  L12 = 9
  L8(L9, L10, L11, L12)
  L8 = L4.recovery
  if L8 == 1 then
    L8 = entry
    L9 = {}
    L10 = "web"
    L11 = "home"
    L9[1] = L10
    L9[2] = L11
    L10 = template
    L11 = "web/recovery"
    L10 = L10(L11)
    L11 = _
    L12 = "\232\183\175\231\148\177\229\153\168\231\138\182\230\128\129"
    L11 = L11(L12)
    L12 = 12
    L8(L9, L10, L11, L12)
  elseif L6 == 0 then
    L8 = entry
    L9 = {}
    L10 = "web"
    L11 = "home"
    L9[1] = L10
    L9[2] = L11
    L10 = template
    L11 = "web/index"
    L10 = L10(L11)
    L11 = _
    L12 = "\232\183\175\231\148\177\229\153\168\231\138\182\230\128\129"
    L11 = L11(L12)
    L12 = 12
    L8(L9, L10, L11, L12)
  elseif L6 == 1 then
    L8 = entry
    L9 = {}
    L10 = "web"
    L11 = "home"
    L9[1] = L10
    L9[2] = L11
    L10 = template
    L11 = "web/apindex"
    L10 = L10(L11)
    L11 = _
    L12 = "\232\183\175\231\148\177\229\153\168\231\138\182\230\128\129"
    L11 = L11(L12)
    L12 = 12
    L8(L9, L10, L11, L12)
  elseif L6 == 3 then
    L8 = entry
    L9 = {}
    L10 = "web"
    L11 = "home"
    L9[1] = L10
    L9[2] = L11
    L10 = template
    L11 = "web/apindex"
    L10 = L10(L11)
    L11 = _
    L12 = "\232\183\175\231\148\177\229\153\168\231\138\182\230\128\129"
    L11 = L11(L12)
    L12 = 12
    L8(L9, L10, L11, L12)
  else
    L8 = entry
    L9 = {}
    L10 = "web"
    L11 = "home"
    L9[1] = L10
    L9[2] = L11
    L10 = template
    L11 = "web/apindex"
    L10 = L10(L11)
    L11 = _
    L12 = "\232\183\175\231\148\177\229\153\168\231\138\182\230\128\129"
    L11 = L11(L12)
    L12 = 12
    L8(L9, L10, L11, L12)
  end
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "init"
  L9[1] = L10
  L9[2] = L11
  L10 = alias
  L11 = "web"
  L12 = "init"
  L13 = "guidetoapp"
  L10 = L10(L11, L12, L13)
  L11 = _
  L12 = "\229\136\157\229\167\139\229\140\150\229\188\149\229\175\188"
  L11 = L11(L12)
  L12 = 13
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "init"
  L12 = "hello"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = call
  L11 = "action_hello"
  L10 = L10(L11)
  L11 = _
  L12 = "\230\172\162\232\191\142\231\149\140\233\157\162"
  L11 = L11(L12)
  L12 = 14
  L13 = 9
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "init"
  L12 = "agreement"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/init/agreement"
  L10 = L10(L11)
  L11 = _
  L12 = "\231\148\168\230\136\183\229\141\143\232\174\174"
  L11 = L11(L12)
  L12 = 14
  L13 = 9
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "init"
  L12 = "privacy"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/init/privacy"
  L10 = L10(L11)
  L11 = _
  L12 = "\231\148\168\230\136\183\228\189\147\233\170\140\230\148\185\232\191\155\232\174\161\229\136\146"
  L11 = L11(L12)
  L12 = 14
  L13 = 9
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "init"
  L12 = "guide"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/init/guide"
  L10 = L10(L11)
  L11 = _
  L12 = "\229\188\149\229\175\188\230\168\161\229\188\143"
  L11 = L11(L12)
  L12 = 15
  L13 = 8
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "init"
  L12 = "guidetoapp"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/init/guidetoapp"
  L10 = L10(L11)
  L11 = _
  L12 = "\229\188\149\229\175\188app"
  L11 = L11(L12)
  L12 = 15
  L13 = 9
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "init"
  L12 = "guideuninit"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/init/guidetoapp_uninit"
  L10 = L10(L11)
  L11 = _
  L12 = "\229\188\149\229\175\188app"
  L11 = L11(L12)
  L12 = 15
  L13 = 9
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "init"
  L12 = "bind"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/init/bind"
  L10 = L10(L11)
  L11 = _
  L12 = "\229\188\149\229\175\188app"
  L11 = L11(L12)
  L12 = 15
  L13 = 9
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "setting"
  L9[1] = L10
  L9[2] = L11
  L10 = alias
  L11 = "web"
  L12 = "setting"
  L13 = "upgrade"
  L10 = L10(L11, L12, L13)
  L11 = _
  L12 = "\232\183\175\231\148\177\232\174\190\231\189\174"
  L11 = L11(L12)
  L12 = 20
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "setting"
  L12 = "upgrade"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/upgrade"
  L10 = L10(L11)
  L11 = _
  L12 = "\232\183\175\231\148\177\230\137\139\229\138\168\229\141\135\231\186\167"
  L11 = L11(L12)
  L12 = 21
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "setting"
  L12 = "wifi"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/wifi"
  L10 = L10(L11)
  L11 = _
  L12 = "Wi-Fi\232\174\190\231\189\174"
  L11 = L11(L12)
  L12 = 22
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "setting"
  L12 = "wan"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/wan"
  L10 = L10(L11)
  L11 = _
  L12 = "\229\164\150\231\189\145\232\174\190\231\189\174"
  L11 = L11(L12)
  L12 = 23
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "setting"
  L12 = "proset"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/proset"
  L10 = L10(L11)
  L11 = _
  L12 = "\233\171\152\231\186\167\232\174\190\231\189\174"
  L11 = L11(L12)
  L12 = 24
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "setting"
  L12 = "lannetset"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/lannetset"
  L10 = L10(L11)
  L11 = _
  L12 = "\229\177\128\229\159\159\231\189\145\232\174\190\231\189\174"
  L11 = L11(L12)
  L12 = 25
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "setting"
  L12 = "safe"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/safe"
  L10 = L10(L11)
  L11 = _
  L12 = "\229\174\137\229\133\168\228\184\173\229\191\131"
  L11 = L11(L12)
  L12 = 26
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "prosetting"
  L9[1] = L10
  L9[2] = L11
  L10 = alias
  L11 = "web"
  L12 = "prosetting"
  L13 = "qos"
  L10 = L10(L11, L12, L13)
  L11 = _
  L12 = "\232\183\175\231\148\177\232\174\190\231\189\174"
  L11 = L11(L12)
  L12 = 40
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "prosetting"
  L12 = "dhcpipmacband"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/dhcp_ip_mac"
  L10 = L10(L11)
  L11 = _
  L12 = "DHCP\233\157\153\230\128\129IP\229\136\134\233\133\141"
  L11 = L11(L12)
  L12 = 41
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "prosetting"
  L12 = "dmz"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/dmz"
  L10 = L10(L11)
  L11 = _
  L12 = "DMZ"
  L11 = L11(L12)
  L12 = 42
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "prosetting"
  L12 = "nat"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/nat_dmz"
  L10 = L10(L11)
  L11 = _
  L12 = "\231\171\175\229\143\163\232\189\172\229\143\145"
  L11 = L11(L12)
  L12 = 43
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "prosetting"
  L12 = "upnp"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/upnp"
  L10 = L10(L11)
  L11 = _
  L12 = "upnp"
  L11 = L11(L12)
  L12 = 44
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "prosetting"
  L12 = "ddns"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/ddns"
  L10 = L10(L11)
  L11 = _
  L12 = "DDNS"
  L11 = L11(L12)
  L12 = 45
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "prosetting"
  L12 = "vpn"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/vpn"
  L10 = L10(L11)
  L11 = _
  L12 = "VPN"
  L11 = L11(L12)
  L12 = 46
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "prosetting"
  L12 = "qos"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = call
  L11 = "action_qos"
  L10 = L10(L11)
  L11 = _
  L12 = "\230\153\186\232\131\189\233\153\144\233\128\159QoS"
  L11 = L11(L12)
  L12 = 47
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "prosetting"
  L12 = "iptv"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/setting/iptv"
  L10 = L10(L11)
  L11 = _
  L12 = "iptv"
  L11 = L11(L12)
  L12 = 48
  L8(L9, L10, L11, L12)
  L8 = L7.apps
  L8 = L8.ports_custom
  if L8 then
    L8 = L7.apps
    L8 = L8.ports_custom
    if L8 == "1" then
      L8 = entry
      L9 = {}
      L10 = "web"
      L11 = "prosetting"
      L12 = "networkportcustom"
      L9[1] = L10
      L9[2] = L11
      L9[3] = L12
      L10 = template
      L11 = "web/setting/network_port_custom"
      L10 = L10(L11)
      L11 = _
      L12 = "\231\189\145\229\143\163\232\135\170\229\174\154\228\185\137"
      L11 = L11(L12)
      L12 = 49
      L8(L9, L10, L11, L12)
    end
  end
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "apsetting"
  L9[1] = L10
  L9[2] = L11
  L10 = alias
  L11 = "web"
  L12 = "apsetting"
  L13 = "upgrade"
  L10 = L10(L11, L12, L13)
  L11 = _
  L12 = "\228\184\173\231\187\167\232\174\190\231\189\174"
  L11 = L11(L12)
  L12 = 60
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "apsetting"
  L12 = "upgrade"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/apsetting/upgrade"
  L10 = L10(L11)
  L11 = _
  L12 = "\228\184\173\231\187\167\231\179\187\231\187\159\228\191\161\230\129\175"
  L11 = L11(L12)
  L12 = 61
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "apsetting"
  L12 = "wan"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/apsetting/wan"
  L10 = L10(L11)
  L11 = _
  L12 = "\228\184\173\231\187\167\230\168\161\229\188\143\229\136\135\230\141\162"
  L11 = L11(L12)
  L12 = 62
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "apsetting"
  L12 = "safe"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/apsetting/safe"
  L10 = L10(L11)
  L11 = _
  L12 = "\228\184\173\231\187\167\229\175\134\231\160\129\232\174\190\231\189\174"
  L11 = L11(L12)
  L12 = 63
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "apsetting"
  L12 = "wifi"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = call
  L11 = "action_apwifi"
  L10 = L10(L11)
  L11 = _
  L12 = "\228\184\173\231\187\167Wi-Fi\232\174\190\231\189\174"
  L11 = L11(L12)
  L12 = 64
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "apsetting"
  L12 = "roam"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/apsetting/roam"
  L10 = L10(L11)
  L11 = _
  L12 = "roam"
  L11 = L11(L12)
  L12 = 65
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "apsetting"
  L12 = "lannetset"
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L10 = template
  L11 = "web/apsetting/lannetset"
  L10 = L10(L11)
  L11 = _
  L12 = "lannetset"
  L11 = L11(L12)
  L12 = 65
  L8(L9, L10, L11, L12)
  L8 = L7.apps
  L8 = L8.storage
  if L8 then
    L8 = L7.apps
    L8 = L8.storage
    if L8 == "1" then
      L8 = entry
      L9 = {}
      L10 = "web"
      L11 = "store"
      L9[1] = L10
      L9[2] = L11
      L10 = alias
      L11 = "web"
      L12 = "store"
      L13 = "storesetting"
      L10 = L10(L11, L12, L13)
      L11 = _
      L12 = "\229\173\152\229\130\168\231\138\182\230\128\129"
      L11 = L11(L12)
      L12 = 90
      L8(L9, L10, L11, L12)
      L8 = entry
      L9 = {}
      L10 = "web"
      L11 = "store"
      L12 = "storesetting"
      L9[1] = L10
      L9[2] = L11
      L9[3] = L12
      L10 = template
      L11 = "web/inc/store"
      L10 = L10(L11)
      L11 = _
      L12 = "\229\173\152\229\130\168\232\174\190\231\189\174"
      L11 = L11(L12)
      L12 = 90
      L8(L9, L10, L11, L12)
    end
  end
  L8 = L7.apps
  L8 = L8.docker
  if L8 then
    L8 = L7.apps
    L8 = L8.docker
    if L8 == "1" then
      L8 = entry
      L9 = {}
      L10 = "web"
      L11 = "store"
      L12 = "docker"
      L9[1] = L10
      L9[2] = L11
      L9[3] = L12
      L10 = template
      L11 = "web/inc/docker"
      L10 = L10(L11)
      L11 = _
      L12 = "docker"
      L11 = L11(L12)
      L12 = 90
      L8(L9, L10, L11, L12)
    end
  end
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "syslock"
  L9[1] = L10
  L9[2] = L11
  L10 = template
  L11 = "web/syslock"
  L10 = L10(L11)
  L11 = _
  L12 = "\232\183\175\231\148\177\229\141\135\231\186\167"
  L11 = L11(L12)
  L12 = 100
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "upgrading"
  L9[1] = L10
  L9[2] = L11
  L10 = template
  L11 = "web/syslock"
  L10 = L10(L11)
  L11 = _
  L12 = "\232\183\175\231\148\177\229\141\135\231\186\167"
  L11 = L11(L12)
  L12 = 101
  L13 = 13
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "webinitrdr"
  L9[1] = L10
  L9[2] = L11
  L10 = call
  L11 = "action_webinitrdr"
  L10 = L10(L11)
  L11 = _
  L12 = ""
  L11 = L11(L12)
  L12 = 110
  L13 = 9
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "login"
  L9[1] = L10
  L9[2] = L11
  L10 = template
  L11 = "web/sysauth"
  L10 = L10(L11)
  L11 = _
  L12 = ""
  L11 = L11(L12)
  L12 = 111
  L8(L9, L10, L11, L12)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "ieblock"
  L9[1] = L10
  L9[2] = L11
  L10 = template
  L11 = "web/ieblock"
  L10 = L10(L11)
  L11 = _
  L12 = ""
  L11 = L11(L12)
  L12 = 120
  L13 = 9
  L8(L9, L10, L11, L12, L13)
  L8 = entry
  L9 = {}
  L10 = "web"
  L11 = "topo"
  L9[1] = L10
  L9[2] = L11
  L10 = template
  L11 = "web/topograph"
  L10 = L10(L11)
  L11 = _
  L12 = ""
  L11 = L11(L12)
  L12 = 130
  L13 = 13
  L8(L9, L10, L11, L12, L13)
end
index = L0
function L0()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.template"
  L0 = L0(L1)
  L1 = {}
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = L2.getNetModeType
  L3 = L3()
  if L3 == 1 then
    L4 = L0.render
    L5 = "web/apsetting/wifi"
    L6 = L1
    L4(L5, L6)
  else
    L4 = L0.render
    L5 = "web/setting/wifi"
    L6 = L1
    L4(L5, L6)
  end
end
action_apwifi = L0
function L0()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.template"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQFeatures"
  L1 = L1(L2)
  L1 = L1.FEATURES
  L2 = L1.apps
  L2 = L2.qos
  if L2 == "1" then
    L3 = L0.render
    L4 = "web/setting/qos"
    L5 = {}
    L3(L4, L5)
  else
    L3 = L0.render
    L4 = "web/setting/qos_lite"
    L5 = {}
    L3(L4, L5)
  end
end
action_qos = L0
function L0()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.dispatcher"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.sauth"
  L1 = L1(L2)
  L2 = L0.context
  L2 = L2.authsession
  if L2 then
    L2 = L1.kill
    L3 = L0.context
    L3 = L3.authsession
    L2(L3)
    L2 = L0.context
    L2 = L2.urltoken
    L2.stok = nil
  end
  L2 = luci
  L2 = L2.http
  L2 = L2.redirect
  L3 = luci
  L3 = L3.dispatcher
  L3 = L3.build_url
  L3 = L3()
  L2(L3)
end
action_logout = L0
function L0()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = L0.getInitInfo
  L1 = L1()
  if L1 then
    L1 = luci
    L1 = L1.http
    L1 = L1.redirect
    L2 = luci
    L2 = L2.dispatcher
    L2 = L2.build_url
    L2, L3 = L2()
    L1(L2, L3)
  else
    L1 = L0.setSysPasswordDefault
    L1()
  end
  L1 = require
  L2 = "luci.template"
  L1 = L1(L2)
  L2 = L1.render
  L3 = "web/init/hello"
  L2(L3)
end
action_hello = L0
function L0()
  local L0, L1, L2, L3
  L0 = {}
  L0.code = 0
  L1 = {}
  L2 = _
  L3 = "\228\189\160\232\191\158\230\142\165\231\154\132\232\183\175\231\148\177\229\153\168\232\191\152\230\156\170\229\136\157\229\167\139\229\140\150"
  L2 = L2(L3)
  L1.s1 = L2
  L2 = _
  L3 = "\232\175\183\231\168\141\229\128\153\239\188\140\228\188\154\232\135\170\229\138\168\228\184\186\228\189\160\232\183\179\232\189\172\229\136\176\229\188\149\229\175\188\233\161\181\233\157\162..."
  L2 = L2(L3)
  L1.s2 = L2
  L2 = _
  L3 = "\229\166\130\230\158\156\230\156\170\232\131\189\232\183\179\232\189\172\239\188\140\232\175\183\231\155\180\230\142\165\232\174\191\233\151\174"
  L2 = L2(L3)
  L1.s3 = L2
  L2 = _
  L3 = "\230\172\162\232\191\142\228\189\191\231\148\168\229\176\143\231\177\179\232\183\175\231\148\177\229\153\168"
  L2 = L2(L3)
  L1.s4 = L2
  L0.data = L1
  L1 = luci
  L1 = L1.http
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
action_webinitrdr = L0
