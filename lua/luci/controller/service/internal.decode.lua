local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
L0 = module
L1 = "luci.controller.service.internal"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = node
  L1 = "service"
  L2 = "internal"
  L0 = L0(L1, L2)
  L1 = firstchild
  L1 = L1()
  L0.target = L1
  L0.title = ""
  L0.order = nil
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "jsonauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "internal"
  L5 = "ccgame"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "turbo_ccgame_call"
  L3 = L3(L4)
  L4 = ""
  L5 = nil
  L6 = 16
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "internal"
  L5 = "ipv6"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "turbo_ipv6_call"
  L3 = L3(L4)
  L4 = ""
  L5 = nil
  L6 = 16
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "internal"
  L5 = "custom_host_get"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "custom_host_get"
  L3 = L3(L4)
  L4 = ""
  L5 = nil
  L6 = 16
  L1(L2, L3, L4, L5, L6)
  L1 = entry
  L2 = {}
  L3 = "service"
  L4 = "internal"
  L5 = "custom_host_set"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "custom_host_set"
  L3 = L3(L4)
  L4 = ""
  L5 = nil
  L6 = 16
  L1(L2, L3, L4, L5, L6)
end
index = L0
L0 = require
L1 = "luci.http"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "service.util.ServiceErrorUtil"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.common.XQFunction"
L3 = L3(L4)
L4 = require
L5 = "cjson"
L4 = L4(L5)
L5 = require
L6 = "luci.util"
L5 = L5(L6)
L6 = require
L7 = "nixio.fs"
L6 = L6(L7)
L7 = require
L8 = "nixio"
L7 = L7(L8)
L8 = require
L9 = "xiaoqiang.XQLog"
L8 = L8(L9)
function L9(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  if not A0 then
    return L3
  end
  for L6 = L3, L4, L5 do
    L8 = A0
    L7 = A0.objects
    L7 = L7(L8)
    L8 = false
    for L12, L13 in L9, L10, L11 do
      if L13 == A1 then
        L14 = true
        return L14
      end
    end
    L9(L10)
    L9(L10)
  end
  return L3
end
check_and_run_ubus_ready = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = tonumber
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "cmd"
  L1 = L1(L2)
  L1 = L1 or L1
  L0 = L0(L1)
  L1 = {}
  L2 = require
  L3 = "turbo.ccgame.ccgame_interface"
  L2 = L2(L3)
  if not L2 then
    L1.code = -1
    L1.msg = "not support ccgame."
  elseif L0 < 0 or 7 < L0 then
    L1.code = -1
    L1.msg = "action id is not valid"
  else
    L3 = {}
    L3.cmdid = L0
    L4 = {}
    L3.data = L4
    L4 = _UPVALUE0_
    L4 = L4.formvalue
    L5 = "ip"
    L4 = L4(L5)
    L5 = _UPVALUE0_
    L5 = L5.formvalue
    L6 = "byvpn"
    L5 = L5(L6)
    L6 = _UPVALUE0_
    L6 = L6.formvalue
    L7 = "game"
    L6 = L6(L7)
    L7 = _UPVALUE0_
    L7 = L7.formvalue
    L8 = "region"
    L7 = L7(L8)
    L8 = _UPVALUE0_
    L8 = L8.formvalue
    L9 = "ubus"
    L8 = L8(L9)
    if L4 then
      L9 = L3.data
      L10 = _UPVALUE1_
      L10 = L10._cmdformat
      L11 = L4
      L10 = L10(L11)
      L9.iplist = L10
    end
    if L5 and L5 ~= "0" then
      L9 = L3.data
      L9.byvpn = "0"
    else
      L9 = L3.data
      L9.byvpn = "1"
    end
    if L6 and L7 then
      L9 = L3.data
      L10 = _UPVALUE1_
      L10 = L10._cmdformat
      L11 = L6
      L10 = L10(L11)
      L9.gameid = L10
      L9 = L3.data
      L10 = _UPVALUE1_
      L10 = L10._cmdformat
      L11 = L7
      L10 = L10(L11)
      L9.regionid = L10
    end
    if L8 then
      L9 = _UPVALUE1_
      L9 = L9._cmdformat
      L10 = L8
      L9 = L9(L10)
      L3.ubus = L9
    end
    L9 = L2.ccgame_call
    L10 = L3
    L9 = L9(L10)
    L1 = L9
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
turbo_ccgame_call = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = tonumber
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "cmd"
  L1 = L1(L2)
  L1 = L1 or L1
  L0 = L0(L1)
  L1 = {}
  if L0 < 0 or 3 < L0 then
    L1.code = -1
    L1.msg = "action id is not valid"
  else
    L2 = require
    L3 = "ubus"
    L2 = L2(L3)
    L3 = L2.connect
    L3 = L3()
    if not L3 then
      L1.code = -1
      L1.msg = "ubus cannot connected."
    else
      L4 = check_and_run_ubus_ready
      L5 = L3
      L6 = "turbo_ipv6"
      L7 = "/etc/init.d/turbo start_ipv6"
      L4 = L4(L5, L6, L7)
      if not L4 then
        L1.code = -1
        L1.msg = "ubus service is not running..."
      else
        L4 = nil
        L5 = "turbo_ipv6"
        L6 = {}
        if L0 == 1 then
          L7 = {}
          L7.provider = "sellon"
          L8 = "matool --method api_call_post --params /device/vip/account '"
          L9 = _UPVALUE1_
          L9 = L9.encode
          L10 = L7
          L9 = L9(L10)
          L10 = "'"
          L8 = L8 .. L9 .. L10
          L9 = pcall
          function L10()
            local L0, L1, L2, L3
            L0 = _UPVALUE0_
            L0 = L0.decode
            L1 = _UPVALUE1_
            L1 = L1.trim
            L2 = _UPVALUE1_
            L2 = L2.exec
            L3 = _UPVALUE2_
            L2, L3 = L2(L3)
            L1, L2, L3 = L1(L2, L3)
            return L0(L1, L2, L3)
          end
          L9, L10 = L9(L10)
          if L9 and L10 then
            L11 = type
            L12 = L10
            L11 = L11(L12)
            if L11 == "table" then
              L11 = L10.code
              if L11 == 0 then
                goto lbl_74
              end
            end
          end
          L1.code = -1
          L1.msg = "active account failed. pls check if account binded or network is connected."
          L4 = nil
          goto lbl_75
          ::lbl_74::
          L4 = "start"
          ::lbl_75::
        elseif L0 == 2 then
          L4 = "stop"
        elseif L0 == 3 then
          L4 = "status"
        elseif L0 == 0 then
          L7 = _UPVALUE3_
          L7 = L7._cmdformat
          L8 = _UPVALUE0_
          L8 = L8.formvalue
          L9 = "ubus"
          L8 = L8(L9)
          L8 = L8 or L8
          L7 = L7(L8)
          L4 = L7
        else
          L4 = nil
          L1.msg = "not supported command."
        end
        if L4 and L4 ~= "" then
          L8 = L3
          L7 = L3.call
          L9 = L5
          L10 = L4
          L11 = L6
          L7 = L7(L8, L9, L10, L11)
          L9 = L3
          L8 = L3.close
          L8(L9)
          if L7 then
            L1 = L7
          else
            L1.code = -1
            L1.msg = "call ubus failed."
          end
        else
          L1.code = -1
        end
      end
    end
  end
  L2 = _UPVALUE0_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
turbo_ipv6_call = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = "/tmp/hosts/custom_hosts"
  L1 = {}
  L1.code = 0
  L1.msg = "OK"
  L2 = _UPVALUE0_
  L2 = L2.access
  L2 = L2(L3)
  if L2 then
    L2 = io
    L2 = L2.open
    L2 = L2(L3, L4)
    hFile = L2
    L2 = {}
    for L6 in L3, L4, L5 do
      L7 = string
      L7 = L7.find
      L8 = L6
      L9 = "^%s*([0-9A-Fa-f.:]+)%s*([^%s]+)%s*"
      L7, L8, L9, L10 = L7(L8, L9)
      if L7 and L9 and L10 then
        L11 = #L2
        L11 = L11 + 1
        L12 = L9
        L13 = " "
        L14 = L10
        L12 = L12 .. L13 .. L14
        L2[L11] = L12
      end
    end
    L3(L4)
    L1.hosts = L2
  else
    L1.code = -1
    L1.msg = "read hosts file failure."
  end
  L2 = _UPVALUE1_
  L2 = L2.write_json
  L2(L3)
end
custom_host_get = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "hosts"
  L0 = L0(L1)
  L0 = L0 or L0
  L1 = {}
  L1.code = 0
  L1.msg = "OK"
  L2 = pcall
  function L3()
    local L0, L1, L2
    L0 = _UPVALUE0_
    L0 = L0.decode
    L1 = _UPVALUE1_
    L1 = L1.trim
    L2 = _UPVALUE2_
    L1, L2 = L1(L2)
    return L0(L1, L2)
  end
  L2, L3 = L2(L3)
  L4 = "/etc/custom_hosts"
  L5 = "/tmp/hosts/custom_hosts"
  if L2 and L3 then
    hFile = L6
    L6(L7, L8)
    for L9, L10 in L6, L7, L8 do
      L11 = string
      L11 = L11.find
      L12 = L10
      L13 = "^%s*([0-9A-Fa-f.:]+)%s*([^%s]+)%s*"
      L11, L12, L13, L14 = L11(L12, L13)
      if L11 and L13 and L14 then
        L15 = hFile
        L16 = L15
        L15 = L15.write
        L17 = L13
        L18 = " "
        L19 = L14
        L20 = "\n"
        L15(L16, L17, L18, L19, L20)
      end
    end
    L6(L7)
    L6(L7, L8)
    L6(L7)
  else
    L1.code = -1
    L1.msg = "parameter hosts lost or foramt invalid."
  end
  L6(L7)
end
custom_host_set = L9
