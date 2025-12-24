local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "luci.controller.url_fw.index"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = "antiy_url_policy"
L1 = "antiy_url_class"
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = node
  L1 = "api"
  L2 = "url_fw"
  L0 = L0(L1, L2)
  L0.sysauth = "admin"
  L0.mediaurlbase = "/xiaoqiang/url_fw"
  L0.sysauth_authenticator = "htmlauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "url_fw"
  L2[1] = L3
  L3 = template
  L4 = "url_fw/home"
  L3 = L3(L4)
  L4 = _
  L5 = ""
  L4 = L4(L5)
  L5 = 1
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "url_fw"
  L5 = "update_status"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "update_status"
  L3 = L3(L4)
  L4 = ""
  L5 = 3
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "url_fw"
  L5 = "get_status"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "get_status"
  L3 = L3(L4)
  L4 = ""
  L5 = 4
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "url_fw"
  L5 = "show_policy"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "show_policy"
  L3 = L3(L4)
  L4 = ""
  L5 = 5
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "url_fw"
  L5 = "update_policy"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "update_policy"
  L3 = L3(L4)
  L4 = ""
  L5 = 6
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "url_fw"
  L5 = "show_whitelist"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "show_whitelist"
  L3 = L3(L4)
  L4 = ""
  L5 = 7
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "url_fw"
  L5 = "add_whitelist"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "add_whitelist"
  L3 = L3(L4)
  L4 = ""
  L5 = 8
  L6 = 1
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "url_fw"
  L5 = "del_whitelist"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "del_whitelist"
  L3 = L3(L4)
  L4 = ""
  L5 = 9
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "url_fw"
  L5 = "overview"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "overview"
  L3 = L3(L4)
  L4 = ""
  L5 = 10
  L1(L2, L3, L4, L5)
end
index = L2
L2 = require
L3 = "luci.http"
L2 = L2(L3)
L3 = require
L4 = "ubus"
L3 = L3(L4)
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "enable"
  L2 = nil
  L3 = "numberstr"
  L0 = L0(L1, L2, L3)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "auto_update"
  L3 = nil
  L4 = "numberstr"
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE1_
  L2 = L2.connect
  L2 = L2()
  if not L2 then
    L3 = _UPVALUE0_
    L3 = L3.write_json
    L4 = {}
    L4.code = -1
    L3(L4)
    return
  end
  L3 = {}
  if L0 == "0" or L0 == "1" then
    L3.enable = L0
  end
  if L1 == "0" or L1 == "1" then
    L3.auto_update = L1
  end
  L5 = L2
  L4 = L2.call
  L6 = "uci"
  L7 = "set"
  L8 = {}
  L9 = _UPVALUE2_
  L8.config = L9
  L8.section = "meta"
  L8.values = L3
  L4(L5, L6, L7, L8)
  L5 = L2
  L4 = L2.call
  L6 = "uci"
  L7 = "commit"
  L8 = {}
  L9 = _UPVALUE2_
  L8.config = L9
  L4(L5, L6, L7, L8)
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = {}
  L5.code = 0
  L4(L5)
end
update_status = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = _UPVALUE0_
  L0 = L0.connect
  L0 = L0()
  if not L0 then
    return
  end
  L2 = L0
  L1 = L0.call
  L3 = "uci"
  L4 = "get"
  L5 = {}
  L6 = _UPVALUE1_
  L5.config = L6
  L1 = L1(L2, L3, L4, L5)
  L1 = L1.values
  if L1 then
    L2 = L1.meta
    if L2 then
      L2 = L1.meta
      L2 = L2.enable
      if L2 then
        L2 = L1.meta
        L2 = L2.auto_update
        if L2 then
          L2 = require
          L3 = "xiaoqiang.common.XQConfigs"
          L2 = L2(L3)
          L3 = require
          L4 = "luci.util"
          L3 = L3(L4)
          L4 = tonumber
          L5 = L3.exec
          L6 = L2.XQ_ROM_BUILDTIME
          L5, L6, L7, L8, L9 = L5(L6)
          L4 = L4(L5, L6, L7, L8, L9)
          L5 = tonumber
          L6 = L1.meta
          L6 = L6.update_ts
          L5 = L5(L6)
          L5 = L5 or L5
          L6 = {}
          L7 = tonumber
          L8 = L1.meta
          L8 = L8.enable
          L7 = L7(L8)
          L6.enable = L7
          L7 = tonumber
          L8 = L1.meta
          L8 = L8.auto_update
          L7 = L7(L8)
          L6.auto_update = L7
          L7 = math
          L7 = L7.max
          L8 = L4
          L9 = L5
          L7 = L7(L8, L9)
          L6.update_ts = L7
          return L6
        end
      end
    end
  end
end
function L5()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0()
  if L0 then
    L0.code = 0
  else
    L1 = {}
    L1.code = -1
    L0 = L1
  end
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
get_status = L5
function L5(A0)
  local L1
  L1 = A0 == "reject" or A0 == "alarm" or A0 == "log" or A0 == "ignored"
  return L1
end
check_policy = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "luci.i18n"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "lang"
  L3 = nil
  L4 = "commonstr"
  L1 = L1(L2, L3, L4)
  if L1 then
    L2 = L0.setlanguage
    L3 = L1
    L2(L3)
  end
  L2 = _UPVALUE1_
  L2 = L2.connect
  L2 = L2()
  if not L2 then
    return
  end
  L4 = L2
  L3 = L2.call
  L5 = "uci"
  L7.config = L8
  L7.type = "class"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3.values
  L5 = L2
  L4 = L2.call
  L9 = _UPVALUE3_
  L8.config = L9
  L4 = L4(L5, L6, L7, L8)
  L4 = L4.values
  L5 = {}
  for L9, L10 in L6, L7, L8 do
    L11 = L4[L9]
    if L11 then
      L11 = L4[L9]
      L11 = L11.policy
      if L11 then
        L11 = check_policy
        L12 = L4[L9]
        L12 = L12.policy
        L11 = L11(L12)
        if L11 then
          L11 = table
          L11 = L11.insert
          L12 = L5
          L13 = {}
          L13.tag = L9
          L14 = L0.translate
          L15 = L3[L9]
          L15 = L15.name
          L14 = L14(L15)
          L13.name = L14
          L14 = L4[L9]
          L14 = L14.policy
          L13.policy = L14
          L11(L12, L13)
      end
    end
    else
      L11 = table
      L11 = L11.insert
      L12 = L5
      L13 = {}
      L13.tag = L9
      L14 = L0.translate
      L15 = L3[L9]
      L15 = L15.name
      L14 = L14(L15)
      L13.name = L14
      L13.policy = "reject"
      L11(L12, L13)
    end
  end
  return L5
end
function L6()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0()
  if not L0 then
    L1 = _UPVALUE1_
    L1 = L1.write_json
    L2 = {}
    L2.code = -1
    L1(L2)
    return
  end
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = {}
  L2.list = L0
  L2.code = 0
  L1(L2)
end
show_policy = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "tag"
  L2 = nil
  L3 = "commonstr"
  L0 = L0(L1, L2, L3)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "policy"
  L3 = nil
  L4 = "commonstr"
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE1_
  L2 = L2.connect
  L2 = L2()
  if L0 and L1 then
    L3 = check_policy
    L4 = L1
    L3 = L3(L4)
    if L3 and L2 then
      goto lbl_33
    end
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = {}
  L4.code = -1
  L3(L4)
  do return end
  ::lbl_33::
  L4 = L2
  L3 = L2.call
  L5 = "uci"
  L6 = "add"
  L7 = {}
  L8 = _UPVALUE2_
  L7.config = L8
  L7.type = "class"
  L7.name = L0
  L3(L4, L5, L6, L7)
  L4 = L2
  L3 = L2.call
  L5 = "uci"
  L6 = "set"
  L7 = {}
  L8 = _UPVALUE2_
  L7.config = L8
  L7.section = L0
  L8 = {}
  L8.policy = L1
  L7.values = L8
  L3(L4, L5, L6, L7)
  L4 = L2
  L3 = L2.call
  L5 = "uci"
  L6 = "commit"
  L7 = {}
  L8 = _UPVALUE2_
  L7.config = L8
  L3(L4, L5, L6, L7)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = {}
  L4.code = 0
  L3(L4)
end
update_policy = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = _UPVALUE0_
  L0 = L0.connect
  L0 = L0()
  if not L0 then
    L1 = _UPVALUE1_
    L1 = L1.write_json
    L2 = {}
    L2.code = -1
    L1(L2)
    return
  end
  L2 = L0
  L1 = L0.call
  L6 = _UPVALUE2_
  L5.config = L6
  L5.section = "whitelist"
  L5.option = "entry"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 and L1
  L2 = {}
  if L1 then
    for L6, L7 in L3, L4, L5 do
      L8 = string
      L8 = L8.find
      L9 = L7
      L10 = "%[%d+%]"
      L8, L9 = L8(L9, L10)
      if L8 and L9 then
        L10 = table
        L10 = L10.insert
        L11 = L2
        L12 = {}
        L13 = tonumber
        L14 = string
        L14 = L14.sub
        L15 = L7
        L16 = L8 + 1
        L17 = L9 - 1
        L14, L15, L16, L17 = L14(L15, L16, L17)
        L13 = L13(L14, L15, L16, L17)
        L12.utc = L13
        L13 = string
        L13 = L13.sub
        L14 = L7
        L15 = L9 + 1
        L13 = L13(L14, L15)
        L12.url = L13
        L10(L11, L12)
      end
    end
  end
  L4.whitelist = L2
  L4.code = 0
  L3(L4)
end
show_whitelist = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = L1.waitExec
  L2 = L2(L3, L4)
  res = L4
  _ = L3
  _ = L2
  L2 = A0.match
  L2 = L2(L3, L4)
  A0 = L2 or A0
  if not L2 then
  end
  L2 = {}
  for L6 in L3, L4, L5 do
    L7, L8 = nil, nil
    L10 = L6
    L9 = L6.match
    L11 = "([^%s]+) [^%s]+ [^%s]+ [^%s]+ ([^%s]+) [^%s]+"
    L9, L10 = L9(L10, L11)
    L8 = L10
    L7 = L9
    if L7 == A0 then
      return L8
    end
  end
  return L3
end
ip_to_mac = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "url"
  L2 = nil
  L3 = "commonstr"
  L0 = L0(L1, L2, L3)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "session"
  L3 = nil
  L4 = "commonstr"
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE1_
  L2 = L2.connect
  L2 = L2()
  if not (L0 and L1) or not L2 then
    L3 = _UPVALUE0_
    L3 = L3.write_json
    L4 = {}
    L4.code = -1
    L3(L4)
    return
  end
  L4 = L2
  L3 = L2.call
  L5 = "antiy_url"
  L6 = "verifySession"
  L7 = {}
  L7.session = L1
  L7.url = L0
  L3 = L3(L4, L5, L6, L7)
  if L3 then
    L4 = L3.code
    if L4 then
      L4 = L3.code
      if 0 == L4 then
        goto lbl_49
      end
    end
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = {}
  L5.code = 0
  L4(L5)
  do return end
  ::lbl_49::
  L5 = L2
  L4 = L2.call
  L6 = "uci"
  L7 = "add"
  L8 = {}
  L9 = _UPVALUE2_
  L8.config = L9
  L8.type = "whitelist"
  L8.name = "whitelist"
  L9 = {}
  L10 = {}
  L11 = "["
  L12 = tostring
  L13 = os
  L13 = L13.time
  L13, L14 = L13()
  L12 = L12(L13, L14)
  L13 = "]"
  L14 = L0
  L11 = L11 .. L12 .. L13 .. L14
  L10[1] = L11
  L9.entry = L10
  L8.values = L9
  L4(L5, L6, L7, L8)
  L5 = L2
  L4 = L2.call
  L6 = "uci"
  L7 = "commit"
  L8 = {}
  L9 = _UPVALUE2_
  L8.config = L9
  L4(L5, L6, L7, L8)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = L4.waitExec
  L6 = "milog.sh"
  L7 = "-m"
  L8 = string
  L8 = L8.format
  L9 = "{\"tag\":\"sec_risk_web\",\"type\":\"whitelist\",\"mac\":\"%s\",\"url\":\"%s\"}"
  L10 = ip_to_mac
  L11 = _UPVALUE0_
  L11 = L11.getenv
  L12 = "X_REAL_IP"
  L11 = L11(L12)
  if not L11 then
    L11 = _UPVALUE0_
    L11 = L11.getenv
    L12 = "REMOTE_ADDR"
    L11 = L11(L12)
  end
  L10 = L10(L11)
  L11 = L0
  L8, L9, L10, L11, L12, L13, L14 = L8(L9, L10, L11)
  L5(L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L5 = L4.waitExec
  L6 = "antiy_url_firewall"
  L5(L6)
  L5 = _UPVALUE0_
  L5 = L5.write_json
  L6 = {}
  L6.code = 0
  L5(L6)
end
add_whitelist = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = require
  L1 = "cjson"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "url"
  L3 = nil
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE1_
  L2 = L2.connect
  L2 = L2()
  if not L1 or not L2 then
    L3 = _UPVALUE0_
    L3 = L3.write_json
    L4.code = -1
    L3(L4)
    return
  end
  L3 = L0.decode
  L3 = L3(L4)
  L1 = L3
  L3 = L2.call
  L7 = {}
  L8 = _UPVALUE2_
  L7.config = L8
  L7.section = "whitelist"
  L7.option = "entry"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 and L3
  for L7, L8 in L4, L5, L6 do
    L9 = -1
    for L13, L14 in L10, L11, L12 do
      L15 = string
      L15 = L15.find
      L16 = L14
      L17 = "%[%d+%]"
      L15, L16 = L15(L16, L17)
      if L15 and L16 then
        L17 = string
        L17 = L17.sub
        L18 = L14
        L19 = L16 + 1
        L17 = L17(L18, L19)
        if L8 == L17 then
          L9 = L13
          break
        end
      end
    end
    if L9 == -1 then
      L11.code = -1
      L10(L11)
      return
    end
    L10(L11, L12)
  end
  if 0 == L4 then
    L3 = ""
  end
  L7 = "set"
  L8 = {}
  L9 = _UPVALUE2_
  L8.config = L9
  L8.section = "whitelist"
  L9 = {}
  L9.entry = L3
  L8.values = L9
  L4(L5, L6, L7, L8)
  L7 = "commit"
  L8 = {}
  L9 = _UPVALUE2_
  L8.config = L9
  L4(L5, L6, L7, L8)
  L5.code = 0
  L4(L5)
end
del_whitelist = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = {}
  for L4, L5 in L1, L2, L3 do
    L0[L4] = L5
  end
  for L7, L8 in L4, L5, L6 do
    L9 = L8.policy
    if L9 ~= "ignored" then
    end
  end
  L0.policy = L3
  L0.total = L1
  if L4 ~= 1 or not L2 then
  end
  L0.protected = L4
  L4.meta = L0
  L5 = 0 < L5
  return L4, L5
end
_overview = L6
function L6()
  local L0, L1, L2
  L0 = _overview
  L0 = L0()
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
overview = L6
