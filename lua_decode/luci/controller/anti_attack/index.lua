local L0, L1, L2, L3, L4
L0 = module
L1 = "luci.controller.anti_attack.index"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = "firewall_cpp"
L1 = "anti_attack"
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = node
  L1 = "api"
  L2 = "anti_attack"
  L0 = L0(L1, L2)
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "htmlauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "anti_attack"
  L5 = "get_status"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "get_status_api"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "anti_attack"
  L5 = "set_rpfilter"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "set_rpfilter_api"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "anti_attack"
  L5 = "set_dos"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "set_dos_api"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "anti_attack"
  L5 = "set_scan"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "set_scan_api"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
  L1 = node
  L2 = "api"
  L3 = "gateway_security"
  L1 = L1(L2, L3)
  L0 = L1
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "htmlauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "gateway_security"
  L5 = "overview"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "overview"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
end
index = L2
L2 = require
L3 = "luci.http"
L2 = L2(L3)
L3 = require
L4 = "ubus"
L3 = L3(L4)
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.connect
  L1 = L1()
  if not L1 then
    L2 = -1
    return L2
  end
  L3 = L1
  L2 = L1.call
  L4 = "uci"
  L5 = "set"
  L6 = {}
  L7 = _UPVALUE1_
  L6.config = L7
  L7 = _UPVALUE2_
  L6.section = L7
  L7 = {}
  if A0 then
    L8 = "1"
    if L8 then
      goto lbl_23
    end
  end
  L8 = "0"
  ::lbl_23::
  L7.rpfilter_enable = L8
  L6.values = L7
  L2(L3, L4, L5, L6)
  L3 = L1
  L2 = L1.call
  L4 = "uci"
  L5 = "commit"
  L6 = {}
  L7 = _UPVALUE1_
  L6.config = L7
  L2(L3, L4, L5, L6)
  L2 = 0
  return L2
end
set_rpfilter = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "enable"
  L2 = nil
  L3 = "numberstr"
  L0 = L0(L1, L2, L3)
  if L0 == "1" or L0 == "0" then
    if L0 == "1" then
      L1 = true
      if L1 then
        goto lbl_17
        L0 = L1 or L0
      end
    end
    L0 = false
    ::lbl_17::
    L1 = _UPVALUE0_
    L1 = L1.write_json
    L2 = {}
    L3 = set_rpfilter
    L4 = L0
    L3 = L3(L4)
    L2.code = L3
    L1(L2)
  else
    L1 = _UPVALUE0_
    L1 = L1.write_json
    L2 = {}
    L2.code = -1
    L1(L2)
  end
end
set_rpfilter_api = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.connect
  L1 = L1()
  if not L1 then
    L2 = -1
    return L2
  end
  L3 = L1
  L2 = L1.call
  L4 = "uci"
  L5 = "set"
  L6 = {}
  L7 = _UPVALUE1_
  L6.config = L7
  L7 = _UPVALUE2_
  L6.section = L7
  L7 = {}
  if A0 then
    L8 = "1"
    if L8 then
      goto lbl_23
    end
  end
  L8 = "0"
  ::lbl_23::
  L7.dos_enable = L8
  L6.values = L7
  L2(L3, L4, L5, L6)
  L3 = L1
  L2 = L1.call
  L4 = "uci"
  L5 = "commit"
  L6 = {}
  L7 = _UPVALUE1_
  L6.config = L7
  L2(L3, L4, L5, L6)
  L2 = 0
  return L2
end
set_dos = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "enable"
  L2 = nil
  L3 = "numberstr"
  L0 = L0(L1, L2, L3)
  if L0 == "1" or L0 == "0" then
    if L0 == "1" then
      L1 = true
      if L1 then
        goto lbl_17
        L0 = L1 or L0
      end
    end
    L0 = false
    ::lbl_17::
    L1 = _UPVALUE0_
    L1 = L1.write_json
    L2 = {}
    L3 = set_dos
    L4 = L0
    L3 = L3(L4)
    L2.code = L3
    L1(L2)
  else
    L1 = _UPVALUE0_
    L1 = L1.write_json
    L2 = {}
    L2.code = -1
    L1(L2)
  end
end
set_dos_api = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.connect
  L1 = L1()
  if not L1 then
    L2 = -1
    return L2
  end
  L3 = L1
  L2 = L1.call
  L4 = "uci"
  L5 = "set"
  L6 = {}
  L7 = _UPVALUE1_
  L6.config = L7
  L7 = _UPVALUE2_
  L6.section = L7
  L7 = {}
  if A0 then
    L8 = "1"
    if L8 then
      goto lbl_23
    end
  end
  L8 = "0"
  ::lbl_23::
  L7.scan_enable = L8
  L6.values = L7
  L2(L3, L4, L5, L6)
  L3 = L1
  L2 = L1.call
  L4 = "uci"
  L5 = "commit"
  L6 = {}
  L7 = _UPVALUE1_
  L6.config = L7
  L2(L3, L4, L5, L6)
  L2 = 0
  return L2
end
set_scan = L4
function L4()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "enable"
  L2 = nil
  L3 = "numberstr"
  L0 = L0(L1, L2, L3)
  if L0 == "1" or L0 == "0" then
    if L0 == "1" then
      L1 = true
      if L1 then
        goto lbl_17
        L0 = L1 or L0
      end
    end
    L0 = false
    ::lbl_17::
    L1 = _UPVALUE0_
    L1 = L1.write_json
    L2 = {}
    L3 = set_scan
    L4 = L0
    L3 = L3(L4)
    L2.code = L3
    L1(L2)
  else
    L1 = _UPVALUE0_
    L1 = L1.write_json
    L2 = {}
    L2.code = -1
    L1(L2)
  end
end
set_scan_api = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1.connect
  L1 = L1()
  if not L1 then
    L0.code = -1
    return L0
  end
  L3 = L1
  L2 = L1.call
  L4 = "uci"
  L5 = "get"
  L6 = {}
  L7 = _UPVALUE1_
  L6.config = L7
  L7 = _UPVALUE2_
  L6.section = L7
  L2 = L2(L3, L4, L5, L6)
  L2 = L2.values
  if not L2 then
    L0.code = -1
    return L0
  end
  L0.code = 0
  L3 = L2.dos_enable
  if L3 == "1" then
    L3 = L2.disable
    if L3 ~= "1" then
      L3 = 1
      if L3 then
        goto lbl_34
      end
    end
  end
  L3 = 0
  ::lbl_34::
  L0.dos = L3
  L3 = L2.scan_enable
  if L3 == "1" then
    L3 = L2.disable
    if L3 ~= "1" then
      L3 = 1
      if L3 then
        goto lbl_45
      end
    end
  end
  L3 = 0
  ::lbl_45::
  L0.scan = L3
  L3 = L2.rpfilter_enable
  if L3 == "1" then
    L3 = L2.disable
    if L3 ~= "1" then
      L3 = 1
      if L3 then
        goto lbl_56
      end
    end
  end
  L3 = 0
  ::lbl_56::
  L0.rpfilter = L3
  return L0
end
get_status = L4
function L4()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.write_json
  L1 = get_status
  L1 = L1()
  L0(L1)
end
get_status_api = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.XQFeatures"
  L0 = L0(L1)
  L0 = L0.FEATURES
  L1 = {}
  L2 = 0
  L3 = 0
  L4 = get_status
  L4 = L4()
  L5 = {}
  L6 = L4.dos
  L5.enable = L6
  L1.dos = L5
  L5 = L4.dos
  L3 = L3 + L5
  L2 = L2 + 1
  L5 = {}
  L6 = L4.scan
  L5.enable = L6
  L1.scan = L5
  L5 = L4.scan
  L3 = L3 + L5
  L2 = L2 + 1
  L5 = L0.system
  if L5 then
    L5 = L0.system
    L5 = L5.ipmaccheck
    if L5 == "1" then
      L5 = require
      L6 = "xiaoqiang.module.XQMacBind"
      L5 = L5(L6)
      L5 = L5.getIPMACCheckEnable
      L5 = L5()
      L6 = {}
      L6.enable = L5
      L1.arp_bind = L6
      L3 = L3 + L5
      L2 = L2 + 1
    end
  end
  L5 = L0.apps
  if L5 then
    L5 = L0.apps
    L5 = L5.local_gw_security
    if L5 == "1" then
      L5 = require
      L6 = "luci.model.uci"
      L5 = L5(L6)
      L5 = L5.cursor
      L5 = L5()
      L6 = tonumber
      L8 = L5
      L7 = L5.get
      L9 = "local_gw_security"
      L10 = "settings"
      L11 = "enabled"
      L7 = L7(L8, L9, L10, L11)
      L7 = L7 or L7
      L6 = L6(L7)
      L7 = {}
      L7.enable = L6
      L1.fake_gateway = L7
      L3 = L3 + L6
      L2 = L2 + 1
    end
  end
  L5 = {}
  L5.protected = L3
  L5.total = L2
  L1.meta = L5
  L5 = L1
  L6 = 0 < L3
  return L5, L6
end
_overview = L4
function L4()
  local L0, L1, L2
  L0 = _overview
  L0 = L0()
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
overview = L4
