local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
L0 = require
L1 = "nixio.fs"
L0 = L0(L1)
L1 = require
L2 = "bit"
L1 = L1(L2)
L2 = require
L3 = "luci.sys"
L2 = L2(L3)
L3 = require
L4 = "luci.init"
L3 = L3(L4)
L4 = require
L5 = "luci.util"
L4 = L4(L5)
L5 = require
L6 = "luci.http"
L5 = L5(L6)
L6 = require
L7 = "nixio"
L6 = L6(L7)
L7 = require
L8 = "nixio.util"
L7(L8)
L7 = require
L8 = "xiaoqiang.util.XQSecureUtil"
L7 = L7(L8)
L8 = module
L9 = "luci.dispatcher"
L10 = package
L10 = L10.seeall
L8(L9, L10)
L8 = L4.threadlocal
L8 = L8()
context = L8
L8 = require
L9 = "luci.i18n"
L8 = L8(L9)
i18n = L8
L8 = _M
L8.fs = L0
L8 = {}
authenticator = L8
L8, L9 = nil, nil
function L10(...)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = {}
  L2, L3, L4, L9, L10, L11, L12, L13 = ...
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L1[5] = L6
  L1[6] = L7
  L1[7] = L8
  L1[8] = L9
  L1[9] = L10
  L1[10] = L11
  L1[11] = L12
  L1[12] = L13
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.getenv
  L4 = "SCRIPT_NAME"
  L3 = L3(L4)
  L3 = L3 or L3
  L2[1] = L3
  L3, L4 = nil, nil
  for L8, L9 in L5, L6, L7 do
    L10 = #L2
    L10 = L10 + 1
    L2[L10] = "/;"
    L10 = #L2
    L10 = L10 + 1
    L11 = _UPVALUE0_
    L11 = L11.urlencode
    L12 = L8
    L11 = L11(L12)
    L2[L10] = L11
    L10 = #L2
    L10 = L10 + 1
    L2[L10] = "="
    L10 = #L2
    L10 = L10 + 1
    L11 = _UPVALUE0_
    L11 = L11.urlencode
    L12 = L9
    L11 = L11(L12)
    L2[L10] = L11
  end
  for L9, L10 in L6, L7, L8 do
    L12 = L10
    L11 = L10.match
    L13 = "^[a-zA-Z0-9_%-%.%%/,;]+$"
    L11 = L11(L12, L13)
    if L11 then
      L11 = #L2
      L11 = L11 + 1
      L2[L11] = "/"
      L11 = #L2
      L11 = L11 + 1
      L2[L11] = L10
    end
  end
  return L6(L7, L8)
end
build_url = L10
function L10(A0)
  local L1, L2
  if A0 then
    L1 = A0.title
    L1 = A0.title
    L1 = #L1
    L1 = A0.target
    L1 = A0.hidden
    L1 = type
    L2 = A0.target
    L1 = L1(L2)
    L1 = A0.target
    L1 = L1.type
    L1 = type
    L2 = A0.nodes
    L1 = L1(L2)
    L1 = next
    L2 = A0.nodes
    L1 = L1(L2)
    L1 = not L1
    L1 = L1 and L1
    return L1
  end
  L1 = false
  return L1
end
node_visible = L10
function L10(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = {}
  if A0 then
    L2, L3 = nil, nil
    for L7, L8 in L4, L5, L6 do
      L9 = node_visible
      L10 = L8
      L9 = L9(L10)
      if L9 then
        L9 = #L1
        L9 = L9 + 1
        L1[L9] = L7
      end
    end
  end
  return L1
end
node_childs = L10
function L10(A0)
  local L1, L2, L3
  L1 = luci
  L1 = L1.http
  L1 = L1.status
  L2 = 404
  L3 = "Not Found"
  L1(L2, L3)
  A0 = A0 or A0
  L1 = require
  L2 = "luci.template"
  L1(L2)
  L1 = luci
  L1 = L1.util
  L1 = L1.copcall
  L2 = luci
  L2 = L2.template
  L2 = L2.render
  L3 = "error404"
  L1 = L1(L2, L3)
  if not L1 then
    L1 = luci
    L1 = L1.http
    L1 = L1.prepare_content
    L2 = "text/plain"
    L1(L2)
    L1 = luci
    L1 = L1.http
    L1 = L1.write
    L2 = A0
    L1(L2)
  end
  L1 = false
  return L1
end
error404 = L10
function L10(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = L1.log
  L3 = 3
  L4 = "Internal Server Error"
  L5 = A0
  L2(L3, L4, L5)
  A0 = "Internal Server Error"
  L2 = context
  L2 = L2.template_header_sent
  if not L2 then
    L2 = luci
    L2 = L2.http
    L2 = L2.status
    L3 = 500
    L4 = "Internal Server Error"
    L2(L3, L4)
    L2 = luci
    L2 = L2.http
    L2 = L2.prepare_content
    L3 = "text/plain"
    L2(L3)
    L2 = luci
    L2 = L2.http
    L2 = L2.write
    L3 = A0
    L2(L3)
  else
    L2 = require
    L3 = "luci.template"
    L2(L3)
    L2 = luci
    L2 = L2.util
    L2 = L2.copcall
    L3 = luci
    L3 = L3.template
    L3 = L3.render
    L4 = "error500"
    L5 = {}
    L5.message = A0
    L2 = L2(L3, L4, L5)
    if not L2 then
      L2 = luci
      L2 = L2.http
      L2 = L2.prepare_content
      L3 = "text/plain"
      L2(L3)
      L2 = luci
      L2 = L2.http
      L2 = L2.write
      L3 = A0
      L2(L3)
    end
  end
  L2 = false
  return L2
end
error500 = L10
function L10(A0, A1)
  local L2, L3, L4
  L2 = tonumber
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = luci
    L2 = L2.http
    L2 = L2.status
    L3 = tonumber
    L4 = A0
    L3 = L3(L4)
    L4 = "Not Found"
    L2(L3, L4)
    L2 = require
    L3 = "luci.template"
    L2(L3)
    L2 = luci
    L2 = L2.util
    L2 = L2.copcall
    L3 = luci
    L3 = L3.template
    L3 = L3.render
    L4 = "error404"
    L2 = L2(L3, L4)
    if not L2 then
      L2 = luci
      L2 = L2.http
      L2 = L2.prepare_content
      L3 = "text/plain"
      L2(L3)
      L2 = luci
      L2 = L2.http
      L2 = L2.write
      L3 = A1
      L2(L3)
    end
    L2 = false
    return L2
  end
end
errorpage = L10
function L10(A0, A1, A2)
end
empower = L10
function L10(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = luci
  L2 = L2.http
  L2 = L2.getenv
  L3 = "HTTP_X_FORWARDED_FOR"
  L2 = L2(L3)
  L3 = L1.isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L3 = luci
    L3 = L3.http
    L3 = L3.getenv
    L4 = "REMOTE_ADDR"
    L3 = L3(L4)
    L2 = L3 or L2
    if not L3 then
      L2 = ""
    end
  end
  L3 = nil
  if A0 then
    L4 = luci
    L4 = L4.sys
    L4 = L4.net
    L4 = L4.ip4mac_ex
    L5 = L2
    L4 = L4(L5)
    L3 = L4 or L3
    if not L4 then
      L3 = ""
    end
  else
    L4 = luci
    L4 = L4.sys
    L4 = L4.net
    L4 = L4.ip4mac
    L5 = L2
    L4 = L4(L5)
    L3 = L4 or L3
    if not L4 then
      L3 = ""
    end
  end
  L4 = L1.macFormat
  L5 = L3
  return L4(L5)
end
getremotemac = L10
function L10()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.XQPushHelper"
  L0 = L0(L1)
  L1 = {}
  L1.type = 16
  L2 = {}
  L3 = getremotemac
  L3 = L3()
  L2.mac = L3
  L1.data = L2
  L2 = L0.push_request_lua
  L3 = L1
  L2(L3)
end
loginAuthenFailed = L10
L10 = authenticator
function L11(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = luci
  L4 = L4.http
  L4 = L4.xqformvalue
  L5 = "username"
  L4 = L4(L5)
  L4 = L4 or L4
  L5 = luci
  L5 = L5.http
  L5 = L5.xqformvalue
  L6 = "password"
  L5 = L5(L6)
  L6 = luci
  L6 = L6.http
  L6 = L6.xqformvalue
  L7 = "nonce"
  L6 = L6(L7)
  if L6 then
    L7 = _UPVALUE0_
    L7 = L7.checkNonce
    L8 = L6
    L9 = getremotemac
    L9, L10, L11, L12, L13, L14 = L9()
    L7 = L7(L8, L9, L10, L11, L12, L13, L14)
    if L7 then
      L7 = _UPVALUE0_
      L7 = L7.checkUser
      L8 = L4
      L9 = L6
      L10 = L5
      L7 = L7(L8, L9, L10)
      if L7 then
        L7 = empower
        L8 = "1"
        L9 = "1"
        L10 = nil
        L7(L8, L9, L10)
        L7 = "2"
        L8 = luci
        L8 = L8.http
        L8 = L8.header
        L9 = "Set-Cookie"
        L10 = "psp="
        L11 = L4
        L12 = "|||"
        L13 = L7
        L14 = "|||0;path=/;"
        L10 = L10 .. L11 .. L12 .. L13 .. L14
        L8(L9, L10)
        L8 = L4
        L9 = L7
        return L8, L9
      else
        L7 = loginAuthenFailed
        L7()
      end
    else
      L7 = context
      L8 = {}
      L7.path = L8
      L7 = luci
      L7 = L7.http
      L7 = L7.write
      L8 = "{\"code\":1582,\"msg\":\"Invalid nonce\"}"
      L7(L8)
      L7 = false
      return L7
    end
  else
    L7 = _UPVALUE0_
    L7 = L7.checkPlaintextPwd
    L8 = L4
    L9 = L5
    L7 = L7(L8, L9)
    if L7 then
      L7 = empower
      L8 = "1"
      L9 = "1"
      L10 = nil
      L7(L8, L9, L10)
      L7 = "2"
      L8 = luci
      L8 = L8.http
      L8 = L8.header
      L9 = "Set-Cookie"
      L10 = "psp="
      L11 = L4
      L12 = "|||"
      L13 = L7
      L14 = "|||0;path=/;"
      L10 = L10 .. L11 .. L12 .. L13 .. L14
      L8(L9, L10)
      L8 = L4
      L9 = L7
      return L8, L9
    else
      L7 = context
      L8 = {}
      L7.path = L8
      L7 = luci
      L7 = L7.http
      L7 = L7.write
      L8 = "{\"code\":401,\"msg\":\"Invalid token\"}"
      L7(L8)
      L7 = false
      return L7
    end
  end
  L7 = context
  L8 = {}
  L7.path = L8
  L7 = luci
  L7 = L7.http
  L7 = L7.write
  L8 = "{\"code\":401,\"msg\":\"not auth\"}"
  L7(L8)
  L7 = false
  return L7
end
L10.jsonauth = L11
L10 = authenticator
function L11(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = luci
  L4 = L4.http
  L4 = L4.xqformvalue
  L5 = "redirectKey"
  L4 = L4(L5)
  L5 = L3.getPassportBindInfo
  L5 = L5()
  if L4 then
    L6 = _UPVALUE0_
    L6 = L6.checkRedirectKey
    L7 = L4
    L6 = L6(L7)
    if L6 then
      if L6 == "1" and L5 then
        L7 = require
        L8 = "xiaoqiang.util.XQDBUtil"
        L7 = L7(L8)
        L8 = L3.getBindUUID
        L8 = L8()
        L9 = L7.fetchPassport
        L10 = L8
        L9 = L9(L10)
        L9 = L9[1]
        if L9 then
          L10 = luci
          L10 = L10.http
          L10 = L10.header
          L11 = "Set-Cookie"
          L12 = "psp="
          L13 = L8
          L14 = "|||1|||"
          L15 = L9.token
          L16 = ";path=/;"
          L12 = L12 .. L13 .. L14 .. L15 .. L16
          L10(L11, L12)
          L10 = A2
          L11 = L6
          return L10, L11
        end
      elseif L6 == "2" then
        L7 = luci
        L7 = L7.http
        L7 = L7.header
        L8 = "Set-Cookie"
        L9 = "psp=admin|||2|||0;path=/;"
        L7(L8, L9)
        L7 = "admin"
        L8 = L6
        return L7, L8
      end
    end
  end
  L6 = require
  L7 = "luci.i18n"
  L6(L7)
  L6 = require
  L7 = "luci.template"
  L6(L7)
  L6 = context
  L7 = {}
  L6.path = L7
  L6 = luci
  L6 = L6.template
  L6 = L6.render
  L7 = "web/sysauth"
  L8 = {}
  L8.duser = A2
  L9 = user
  L8.fuser = L9
  L6(L7, L8)
  L6 = false
  return L6
end
L10.htmlauth = L11
L10 = authenticator
function L11(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = luci
  L3 = L3.http
  L3 = L3.xqformvalue
  L4 = "username"
  L3 = L3(L4)
  L4 = luci
  L4 = L4.http
  L4 = L4.xqformvalue
  L5 = "password"
  L4 = L4(L5)
  L5 = luci
  L5 = L5.http
  L5 = L5.xqformvalue
  L6 = "nonce"
  L5 = L5(L6)
  if L5 then
    L6 = _UPVALUE0_
    L6 = L6.checkNonce
    L7 = L5
    L8 = getremotemac
    L8, L9 = L8()
    L6 = L6(L7, L8, L9)
    if L6 then
      L6 = _UPVALUE0_
      L6 = L6.checkUser
      L7 = L3
      L8 = L5
      L9 = L4
      L6 = L6(L7, L8, L9)
      if L6 then
        L6 = empower
        L7 = "1"
        L8 = "1"
        L9 = nil
        L6(L7, L8, L9)
        L6 = L3
        L7 = "2"
        return L6, L7
      end
    end
  end
  L6 = loginAuthenFailed
  L6()
  L6 = require
  L7 = "luci.i18n"
  L6(L7)
  L6 = require
  L7 = "luci.template"
  L6(L7)
  L6 = context
  L7 = {}
  L6.path = L7
  L6 = luci
  L6 = L6.template
  L6 = L6.render
  L7 = "mobile/sysauth"
  L8 = {}
  L8.duser = A2
  L8.fuser = L3
  L6(L7, L8)
  L6 = false
  return L6
end
L10.htmlauth_moblie = L11
function L10(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = luci
  L3 = L3.http
  L3 = L3.getenv
  L4 = "REQUEST_URI"
  L3 = L3(L4)
  L4 = L1.sysLockStatus
  L4 = L4()
  if L4 == 1 then
    L4 = L2.isUpgrading
    L4 = L4()
    if L4 then
      L4 = require
      L5 = "luci.i18n"
      L4(L5)
      L4 = require
      L5 = "luci.template"
      L4(L5)
      L4 = type
      L5 = A0
      L4 = L4(L5)
      if L4 == "string" and A0 == "htmlauth" then
        L4 = context
        L5 = {}
        L4.path = L5
        L4 = luci
        L4 = L4.http
        L4 = L4.redirect
        L5 = luci
        L5 = L5.dispatcher
        L5 = L5.build_url
        L6 = "web"
        L7 = "upgrading"
        L5, L6, L7 = L5(L6, L7)
        L4(L5, L6, L7)
      else
        L4 = type
        L5 = A0
        L4 = L4(L5)
        if L4 == "string" and A0 == "jsonauth" then
          L4 = context
          L5 = {}
          L4.path = L5
          L4 = luci
          L4 = L4.http
          L4 = L4.write
          L5 = "{\"code\":403,\"msg\":\"system locked\"}"
          L4(L5)
        else
          L4 = L1.sysUnlock
          L4()
          L4 = false
          return L4
        end
      end
      L4 = true
      return L4
    else
      L5 = L3
      L4 = L3.match
      L6 = "/api/service/"
      L4 = L4(L5, L6)
      if not L4 then
        L5 = L3
        L4 = L3.match
        L6 = "/api%-third%-party/"
        L4 = L4(L5, L6)
        if not L4 then
          L4 = L1.sysUnlock
          L4()
        end
      end
    end
  end
  L4 = false
  return L4
end
check_show_syslock = L10
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L4 = A0
  L3 = A0.getenv
  L5 = "REQUEST_URI"
  L3 = L3(L4, L5)
  if L3 and A1 then
    L4 = type
    L5 = A1
    L4 = L4(L5)
    if L4 == "string" then
      L4 = luci
      L4 = L4.util
      L4 = L4.split
      L5 = L3
      L6 = "?"
      L4 = L4(L5, L6)
      L5 = L2.log
      L6 = 6
      L7 = A1
      L8 = ":"
      L9 = L4[1]
      L7 = L7 .. L8 .. L9
      L5(L6, L7)
      L5 = L4[2]
      if L5 then
        L5 = L2.log
        L6 = 7
        L7 = L4[2]
        L5(L6, L7)
      end
    end
  end
end
http_request_log = L10
function L10(A0)
  local L1, L2, L3
  if A0 == nil then
    L1 = false
    return L1
  end
  L1 = _UPVALUE0_
  L1 = L1.band
  L2 = A0
  L3 = 1
  L1 = L1(L2, L3)
  if L1 == 1 then
    L1 = true
    return L1
  else
    L1 = false
    return L1
  end
end
_noauthAccessAllowed = L10
function L10(A0)
  local L1, L2, L3
  if A0 == nil then
    L1 = false
    return L1
  end
  L1 = _UPVALUE0_
  L1 = L1.band
  L2 = A0
  L3 = 2
  L1 = L1(L2, L3)
  if L1 == 2 then
    L1 = true
    return L1
  else
    L1 = false
    return L1
  end
end
_remoteAccessForbidden = L10
function L10(A0)
  local L1, L2, L3
  if A0 == nil then
    L1 = false
    return L1
  end
  L1 = _UPVALUE0_
  L1 = L1.band
  L2 = A0
  L3 = 4
  L1 = L1(L2, L3)
  if L1 == 4 then
    L1 = true
    return L1
  else
    L1 = false
    return L1
  end
end
_syslockAccessAllowed = L10
function L10(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = L1.getInitInfo
  L2 = L2()
  if L2 then
    L2 = true
    return L2
  else
    if A0 == nil then
      L2 = false
      return L2
    end
    L2 = _UPVALUE0_
    L2 = L2.band
    L3 = A0
    L4 = 8
    L2 = L2(L3, L4)
    if L2 == 8 then
      L2 = true
      return L2
    else
      L2 = false
      return L2
    end
  end
end
_noinitAccessAllowed = L10
function L10(A0)
  local L1, L2, L3
  if A0 == nil then
    L1 = false
    return L1
  end
  L1 = _UPVALUE0_
  L1 = L1.band
  L2 = A0
  L3 = 16
  L1 = L1(L2, L3)
  if L1 == 16 then
    L1 = true
    return L1
  else
    L1 = false
    return L1
  end
end
_sdkFilter = L10
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  if not A0 then
    L2 = true
    return L2
  end
  if A0 == "htmlauth" then
    L2 = _noauthAccessAllowed
    L3 = A1
    L2 = L2(L3)
    if not L2 then
      L2 = require
      L3 = "xiaoqiang.common.XQFunction"
      L2 = L2(L3)
      L3 = getremotemac
      L3 = L3()
      L4 = require
      L5 = "luci.model.uci"
      L4 = L4(L5)
      L4 = L4.cursor
      L4 = L4()
      L5 = tonumber
      L7 = L4
      L6 = L4.get
      L8 = "webfilter"
      L9 = "admin"
      L10 = "enable"
      L6 = L6(L7, L8, L9, L10)
      L6 = L6 or L6
      L5 = L5(L6)
      if L5 == 1 then
        L6 = L2.isStrNil
        L7 = L3
        L6 = L6(L7)
        if not L6 then
          L6 = false
          L8 = L4
          L7 = L4.foreach
          L9 = "webfilter"
          L10 = "adminwhite"
          function L11(A0)
            local L1, L2, L3, L4
            L1 = A0[".type"]
            if L1 == "adminwhite" then
              L1 = string
              L1 = L1.gsub
              L2 = A0[".name"]
              L3 = "_"
              L4 = ":"
              L1 = L1(L2, L3, L4)
              if L1 then
                L2 = string
                L2 = L2.lower
                L3 = _UPVALUE0_
                L2 = L2(L3)
                if L1 == L2 then
                  L2 = true
                  _UPVALUE1_ = L2
                end
              end
            end
          end
          L7(L8, L9, L10, L11)
          return L6
        end
      end
    end
  end
  L2 = true
  return L2
end
_webAccessAllowed = L10
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = _UPVALUE0_
  L2 = L2.urldecode
  L3 = A0.getenv
  L3 = L3(L4, L5)
  L3 = L3 or L3
  L2 = L2(L3, L4)
  if L2 ~= "/mipctl" then
    L3 = http_request_log
    L3(L4, L5)
  end
  L3 = _G
  L3._ = L4
  L3 = _G
  L3.translate = L4
  L3 = luci
  L3 = L3.http
  L3 = L3.context
  L3.request = A0
  L3 = {}
  L4.request = L3
  L4.urltoken = L5
  if A1 then
    for L7, L8 in L4, L5, L6 do
      L9 = #L3
      L9 = L9 + 1
      L3[L9] = L8
    end
  end
  for L8 in L5, L6, L7 do
    L9, L10 = nil, nil
    if L4 then
      L12 = L8
      L11 = L8.match
      L13 = ";(%w+)=([a-fA-F0-9]*)"
      L11, L12 = L11(L12, L13)
      L10 = L12
      L9 = L11
    end
    if L9 then
      L11 = context
      L11 = L11.urltoken
      L11[L9] = L10
    else
      L11 = #L3
      L11 = L11 + 1
      L3[L11] = L8
    end
  end
  L7()
  if L2 ~= "/mipctl" then
    L8 = A0
    L9 = "finished"
    L7(L8, L9)
  end
end
httpdispatch = L10
function L10(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35
  L1 = context
  L1.path = A0
  L2 = require
  L3 = "luci.config"
  L2 = L2(L3)
  L3 = assert
  L4 = L2.main
  L5 = "/etc/config/luci seems to be corrupt, unable to find section 'main'"
  L3(L4, L5)
  L3 = L2.main
  L3 = L3.lang
  L3 = L3 or L3
  L4 = require
  L5 = "luci.i18n"
  L4 = L4(L5)
  L4 = L4.setlanguage
  L5 = L3
  L4(L5)
  L4 = L1.tree
  L5 = nil
  if not L4 then
    L6 = createtree
    L6 = L6()
    L4 = L6
  end
  L6 = {}
  L7 = {}
  L1.args = L7
  L8 = L1.requestargs
  L8 = L8 or L8
  L1.requestargs = L8
  L8 = nil
  L9 = L1.urltoken
  L10 = {}
  L11 = {}
  for L15, L16 in L12, L13, L14 do
    L17 = #L10
    L17 = L17 + 1
    L10[L17] = L16
    L17 = #L11
    L17 = L17 + 1
    L11[L17] = L16
    L17 = L4.nodes
    L4 = L17[L16]
    L8 = L15
    if not L4 then
      break
    end
    L17 = _UPVALUE0_
    L17 = L17.update
    L18 = L6
    L19 = L4
    L17(L18, L19)
    L17 = L4.leaf
    if L17 then
      break
    end
  end
  if L4 then
    if L12 then
      for L15 = L12, L13, L14 do
        L17 = A0[L15]
        L7[L16] = L17
        L17 = A0[L15]
        L11[L16] = L17
      end
    end
  end
  L1.requestpath = L12
  L1.path = L10
  if L12 then
    L12(L13)
  end
  if L4 then
    if L12 then
      goto lbl_106
    end
  end
  ::lbl_106::
  if not L12 then
    L17 = L13
    if not L14 then
      for L17, L18 in L14, L15, L16 do
        L20 = L17
        L19 = L17.sub
        L21 = 1
        L22 = 1
        L19 = L19(L20, L21, L22)
        if L19 ~= "." then
          L19 = pcall
          L20 = L12.Template
          L21 = _UPVALUE1_
          L21 = L21.basename
          L22 = L18
          L21 = L21(L22)
          L21 = "themes/%s/header" % L21
          L19 = L19(L20, L21)
          if L19 then
          end
        end
      end
      L14(L15, L16)
    end
    L17 = {}
    L18 = luci
    L18 = L18.http
    L18 = L18.write
    L17.write = L18
    function L18(A0)
      local L1, L2, L3, L4
      L1 = _UPVALUE0_
      L1 = L1.Template
      L2 = A0
      L1 = L1(L2)
      L2 = L1
      L1 = L1.render
      L3 = getfenv
      L4 = 2
      L3, L4 = L3(L4)
      L1(L2, L3, L4)
    end
    L17.include = L18
    L18 = i18n
    L18 = L18.translate
    L17.translate = L18
    function L18(A0, A1)
      local L2
      L2 = _UPVALUE0_
      L2 = L2.context
      L2 = L2.viewns
      L2 = L2[A0]
      if L2 == nil then
        L2 = _UPVALUE0_
        L2 = L2.context
        L2 = L2.viewns
        L2[A0] = A1
      end
    end
    L17.export = L18
    L18 = _UPVALUE0_
    L18 = L18.striptags
    L17.striptags = L18
    L18 = _UPVALUE0_
    L18 = L18.pcdata
    L17.pcdata = L18
    L17.media = L13
    L18 = _UPVALUE1_
    L18 = L18.basename
    L19 = L13
    L18 = L18(L19)
    L17.theme = L18
    L18 = luci
    L18 = L18.config
    L18 = L18.main
    L18 = L18.resourcebase
    L17.resource = L18
    function L18(...)
      local L1, L2
      L1 = _UPVALUE0_
      L2 = ...
      return L1(L2)
    end
    L17.ifattr = L18
    function L18(...)
      local L1, L2, L3
      L1 = _UPVALUE0_
      L2 = true
      L3 = ...
      return L1(L2, L3)
    end
    L17.attr = L18
    L18 = {}
    function L19(A0, A1)
      local L2, L3, L4
      if A1 == "controller" then
        L2 = build_url
        return L2()
      elseif A1 == "REQUEST_URI" then
        L2 = build_url
        L3 = unpack
        L4 = _UPVALUE0_
        L4 = L4.requestpath
        L3, L4 = L3(L4)
        return L2(L3, L4)
      else
        L2 = rawget
        L3 = A0
        L4 = A1
        L2 = L2(L3, L4)
        if not L2 then
          L2 = _G
          L2 = L2[A1]
        end
        return L2
      end
    end
    L18.__index = L19
    L15.viewns = L16
  end
  L12 = L12 ~= false
  L6.dependent = L12
  L13 = not L13 or L13
  L17 = "/"
  L17 = "has no parent node so the access to this location has been denied.\n"
  L18 = "This is a software bug, please report this message at "
  L19 = "http://luci.subsignal.org/trac/newticket"
  L12(L13, L14)
  if L12 then
    if L13 then
      L14(L15, L16)
      return
    end
  end
  if not L13 then
    L13(L14, L15)
    return
  end
  if not L13 then
    if L13 then
      return
    end
  end
  if not L13 then
    L13(L14, L15)
    return
  end
  L15 = (L13 == "127.0.0.1" or L13 == "::1") and L14 == "localhost"
  L17 = L6.flag
  if L16 and not L15 then
    L17 = "xiaoqiang.util.XQSDKUtil"
    L17 = L16.checkPermission
    L18 = getremotemac
    L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35 = L18()
    L17 = L17(L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35)
    if not L17 then
      L17 = context
      L18 = {}
      L17.path = L18
      L17 = luci
      L17 = L17.http
      L17 = L17.write
      L18 = "{\"code\":1500,\"msg\":\"Permission denied\"}"
      L17(L18)
      return
    end
  end
  if not L15 then
    L17 = L6.flag
    if not L16 then
      if L16 then
        L17 = "luci.sauth"
        L17 = require
        L18 = "xiaoqiang.util.XQCryptoUtil"
        L17 = L17(L18)
        L18 = require
        L19 = "xiaoqiang.util.XQSysUtil"
        L18 = L18(L19)
        L19 = L18.getPassportBindInfo
        L19 = L19()
        L20 = type
        L21 = L6.sysauth_authenticator
        L20 = L20(L21)
        if L20 == "function" then
          L20 = L6.sysauth_authenticator
          if L20 then
            goto lbl_359
          end
        end
        L20 = authenticator
        L21 = L6.sysauth_authenticator
        L20 = L20[L21]
        ::lbl_359::
        L21 = type
        L22 = L6.sysauth
        L21 = L21(L22)
        L21 = L21 == "string" and L21
        if L21 then
          L22 = {}
          L23 = L6.sysauth
          L22[1] = L23
          if L22 then
            goto lbl_376
          end
        end
        L22 = L6.sysauth
        ::lbl_376::
        L23 = L1.urltoken
        L23 = L23.stok
        L24 = L16.read
        L25 = L23
        L24 = L24(L25)
        L25 = nil
        if L24 then
          L26 = L1.urltoken
          L26 = L26.stok
          L27 = L24.token
          if L26 == L27 then
            L26 = L24.ip
            if L26 then
              L26 = L24.ip
              if L26 then
                L26 = L24.ip
                if L26 == L13 then
                  L25 = L24.user
                end
              end
            end
          end
        else
          L26 = _UPVALUE2_
          L26 = L26.getenv
          L27 = "HTTP_AUTH_USER"
          L26 = L26(L27)
          L27 = _UPVALUE2_
          L27 = L27.getenv
          L28 = "HTTP_AUTH_PASS"
          L27 = L27(L28)
          if L26 and L27 then
            L28 = luci
            L28 = L28.sys
            L28 = L28.user
            L28 = L28.checkpasswd
            L29 = L26
            L30 = L27
            L28 = L28(L29, L30)
            if L28 then
              L28 = require
              L29 = "xiaoqiang.XQLog"
              L28 = L28(L29)
              L29 = L28.log
              L30 = 4
              L31 = "Native Luci: HTTP_AUTH_USER & HTTP_AUTH_PASS"
              L29(L30, L31)
            end
          end
        end
        L26 = _UPVALUE0_
        L26 = L26.contains
        L27 = L22
        L28 = L25
        L26 = L26(L27, L28)
        if not L26 then
          if L20 then
            L26 = L1.urltoken
            L26.stok = nil
            L26 = L20
            L27 = nil
            L28 = L22
            L29 = L21
            L26, L27 = L26(L27, L28, L29)
            if L26 then
              L28 = _UPVALUE0_
              L28 = L28.contains
              L29 = L22
              L30 = L26
              L28 = L28(L29, L30)
              if L28 then
                goto lbl_455
              end
            end
            do return end
            goto lbl_501
            ::lbl_455::
            L28 = L23 or L28
            if not L23 then
              L28 = luci
              L28 = L28.sys
              L28 = L28.uniqueid
              L29 = 16
              L28 = L28(L29)
            end
            L29 = L27 or L29
            if not L27 then
              L29 = "2"
            end
            L30 = luci
            L30 = L30.sys
            L30 = L30.uniqueid
            L31 = 16
            L30 = L30(L31)
            L31 = L16.reap
            L31()
            L31 = L16.write
            L32 = L30
            L33 = {}
            L33.user = L26
            L33.token = L30
            L33.ltype = L29
            L33.ip = L13
            L34 = luci
            L34 = L34.sys
            L34 = L34.uniqueid
            L35 = 16
            L34 = L34(L35)
            L33.secret = L34
            L31(L32, L33)
            L31 = L1.urltoken
            L31.stok = L30
            L1.authsession = L30
            L1.authuser = L26
          else
            L26 = luci
            L26 = L26.http
            L26 = L26.status
            L27 = 403
            L28 = "Forbidden"
            L26(L27, L28)
            return
          end
        else
          L1.authsession = L23
          L1.authuser = L25
        end
      end
    end
  end
  ::lbl_501::
  if L16 then
    L17 = L6.setgroup
    L16(L17)
  end
  if L16 then
    L17 = L6.setuser
    L16(L17)
  end
  if L4 then
    L17 = type
    L18 = L4.target
    L17 = L17(L18)
    if L17 == "function" then
    else
      L17 = type
      L18 = L4.target
      L17 = L17(L18)
      if L17 == "table" then
        L17 = L4.target
      end
    end
  end
  if L4 then
    L17 = L4.index
    if not L17 then
      L17 = type
      L18 = L16
      L17 = L17(L18)
      if L17 ~= "function" then
        goto lbl_552
      end
    end
    L1.dispatched = L4
    L17 = L1.requested
    L17 = L17 or L17
    L1.requested = L17
  end
  ::lbl_552::
  if L4 then
    L17 = L4.index
    if L17 then
      L17 = require
      L18 = "luci.template"
      L17 = L17(L18)
      L18 = _UPVALUE0_
      L18 = L18.copcall
      L19 = L17.render
      L20 = "indexer"
      L21 = {}
      L18 = L18(L19, L20, L21)
      if L18 then
        L18 = true
        return L18
      end
    end
  end
  L17 = type
  L18 = L16
  L17 = L17(L18)
  if L17 == "function" then
    L17 = _UPVALUE0_
    L17 = L17.copcall
    function L18()
      local L0, L1, L2, L3, L4, L5
      L0 = getfenv
      L1 = _UPVALUE0_
      L0 = L0(L1)
      L1 = require
      L2 = _UPVALUE1_
      L2 = L2.module
      L1 = L1(L2)
      L2 = setmetatable
      L3 = {}
      L4 = {}
      function L5(A0, A1)
        local L2, L3, L4
        L2 = rawget
        L3 = A0
        L4 = A1
        L2 = L2(L3, L4)
        if not L2 then
          L2 = _UPVALUE0_
          L2 = L2[A1]
          if not L2 then
            L2 = _UPVALUE1_
            L2 = L2[A1]
          end
        end
        return L2
      end
      L4.__index = L5
      L2 = L2(L3, L4)
      L3 = setfenv
      L4 = _UPVALUE0_
      L5 = L2
      L3(L4, L5)
    end
    L17(L18)
    L17, L18 = nil, nil
    L19 = type
    L20 = L4.target
    L19 = L19(L20)
    if L19 == "table" then
      L19 = _UPVALUE0_
      L19 = L19.copcall
      L20 = L16
      L21 = L4.target
      L22 = unpack
      L23 = L7
      L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35 = L22(L23)
      L19, L20 = L19(L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35)
      L18 = L20
      L17 = L19
    else
      L19 = _UPVALUE0_
      L19 = L19.copcall
      L20 = L16
      L21 = unpack
      L22 = L7
      L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35 = L21(L22)
      L19, L20 = L19(L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35)
      L18 = L20
      L17 = L19
    end
    L19 = assert
    L20 = L17
    L21 = "Failed to execute "
    L22 = type
    L23 = L4.target
    L22 = L22(L23)
    if L22 == "function" then
      L22 = "function"
      if L22 then
        goto lbl_623
      end
    end
    L22 = L4.target
    L22 = L22.type
    L22 = L22 or L22
    ::lbl_623::
    L23 = " dispatcher target for entry '/"
    L24 = table
    L24 = L24.concat
    L25 = A0
    L26 = "/"
    L24 = L24(L25, L26)
    L25 = "'.\n"
    L26 = "The called action terminated with an exception:\n"
    L27 = tostring
    L28 = L18 or L28
    if not L18 then
      L28 = "(unknown)"
    end
    L27 = L27(L28)
    L21 = L21 .. L22 .. L23 .. L24 .. L25 .. L26 .. L27
    L19(L20, L21)
  else
    L17 = node
    L17 = L17()
    if L17 then
      L18 = L17.target
      if L18 then
        goto lbl_653
      end
    end
    L18 = error404
    L19 = "No root node was registered, this usually happens if no module was installed.\n"
    L20 = "Install luci-mod-admin-full and retry. "
    L21 = "If the module is already installed, try removing the /tmp/luci-indexcache file."
    L19 = L19 .. L20 .. L21
    L18(L19)
    goto lbl_665
    ::lbl_653::
    L18 = error404
    L19 = "No page is registered at '/"
    L20 = table
    L20 = L20.concat
    L21 = A0
    L22 = "/"
    L20 = L20(L21, L22)
    L21 = "'.\n"
    L22 = "If this url belongs to an extension, make sure it is properly installed.\n"
    L23 = "If the extension was recently installed, try removing the /tmp/luci-indexcache file."
    L19 = L19 .. L20 .. L21 .. L22 .. L23
    L18(L19)
  end
  ::lbl_665::
end
dispatch = L10
function L10()
  local L0, L1, L2, L3, L4
  L0 = luci
  L0 = L0.util
  L0 = L0.libpath
  L0 = L0()
  L1 = "/controller/"
  L0 = L0 .. L1
  L1 = {}
  L2 = ".lua"
  L3 = ".lua.gz"
  L1[1] = L2
  L1[2] = L3
  L2 = createindex_plain
  L3 = L0
  L4 = L1
  L2(L3, L4)
end
createindex = L10
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  _UPVALUE0_ = L2
  if not L2 then
    _UPVALUE1_ = L2
    for L5, L6 in L2, L3, L4 do
      L7 = _UPVALUE1_
      L7 = L7.add
      L8 = A0
      L9 = "*"
      L10 = L6
      L8 = L8 .. L9 .. L10
      L7(L8)
      L7 = _UPVALUE1_
      L7 = L7.add
      L8 = A0
      L9 = "*/*"
      L10 = L6
      L8 = L8 .. L9 .. L10
      L7(L8)
    end
  end
  L2()
  for L5, L6 in L2, L3, L4 do
    L7 = _UPVALUE0_
    L8 = L6[2]
    L9 = L6[1]
    L7[L8] = L9
  end
end
createindex_fastindex = L10
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    L8 = _UPVALUE0_
    L8 = L8.util
    L8 = L8.consume
    L12 = L7
    L8(L9, L10)
    L8 = _UPVALUE0_
    L8 = L8.util
    L8 = L8.consume
    L12 = L7
    L8(L9, L10)
  end
  if L3 then
    if L3 then
      for L8, L9 in L5, L6, L7 do
        L12 = "mtime"
        if not (L10 and L4 < L10) or not L10 then
        end
      end
      if L3 > L4 then
        L8 = indexcache
        L6 = L6 == L7
        L5(L6, L7)
        _UPVALUE3_ = L5
        return L5
      end
    end
  end
  _UPVALUE3_ = L3
  for L6, L7 in L3, L4, L5 do
    L8 = "luci.controller."
    L12 = #L7
    L12 = "."
    L8 = L8 .. L9
    for L12, L13 in L9, L10, L11 do
      L15 = L8
      L14 = L8.gsub
      L16 = L13
      L17 = "$"
      L16 = L16 .. L17
      L17 = ""
      L14 = L14(L15, L16, L17)
      L8 = L14
    end
    L11 = L9 ~= true
    L12 = "Invalid controller file found\n"
    L13 = "The file '"
    L14 = L7
    L15 = "' contains an invalid module line.\n"
    L16 = "Please verify whether the module name is set to '"
    L17 = L8
    L18 = "' - It must correspond to the file path!"
    L12 = L12 .. L13 .. L14 .. L15 .. L16 .. L17 .. L18
    L10(L11, L12)
    L12 = type
    L13 = L10
    L12 = L12(L13)
    L12 = L12 == "function"
    L13 = "Invalid controller file found\n"
    L14 = "The file '"
    L15 = L7
    L16 = "' contains no index() function.\n"
    L17 = "Please make sure that the controller contains a valid "
    L18 = "index function and verify the spelling!"
    L13 = L13 .. L14 .. L15 .. L16 .. L17 .. L18
    L11(L12, L13)
    L11[L8] = L10
  end
  if L3 then
    L8, L12, L13, L14, L15, L16, L17, L18 = L6(L7)
    L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18)
    L4(L5)
  end
end
createindex_plain = L10
function L10()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = _UPVALUE0_
  if not L0 then
    L0 = createindex
    L0()
  end
  L0 = context
  L1 = {}
  L2 = {}
  L1.nodes = L2
  L1.inreq = true
  L2 = {}
  L3 = setmetatable
  L5.__mode = "v"
  L3 = L3(L4, L5)
  L0.treecache = L3
  L0.tree = L1
  L0.modifiers = L2
  L3 = require
  L3 = L3(L4)
  L3 = L3.loadc
  L3(L4)
  L3 = setmetatable
  L5.__index = L6
  L3 = L3(L4, L5)
  for L7, L8 in L4, L5, L6 do
    L3._NAME = L7
    L9 = setfenv
    L10 = L8
    L11 = L3
    L9(L10, L11)
    L9 = L8
    L9()
  end
  for L8, L9 in L5, L6, L7 do
    L10 = L9.module
    L3._NAME = L10
    L10 = setfenv
    L11 = L9.func
    L12 = L3
    L10(L11, L12)
    L10 = L9.func
    L10()
  end
  return L1
end
createtree = L10
function L10(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = context
  L2 = L2.modifiers
  L3 = context
  L3 = L3.modifiers
  L3 = #L3
  L3 = L3 + 1
  L4 = {}
  L4.func = A0
  L5 = A1 or L5
  if not A1 then
    L5 = 0
  end
  L4.order = L5
  L5 = getfenv
  L6 = 2
  L5 = L5(L6)
  L5 = L5._NAME
  L4.module = L5
  L2[L3] = L4
end
modifier = L10
function L10(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10
  L5 = node
  L6 = unpack
  L7 = A0
  L6, L7, L8, L9, L10 = L6(L7)
  L5 = L5(L6, L7, L8, L9, L10)
  L5.nodes = nil
  L5.module = nil
  L5.title = A2
  L5.order = A3
  L5.flag = A4
  L6 = setmetatable
  L7 = L5
  L8 = {}
  L9 = _create_node
  L10 = A1
  L9 = L9(L10)
  L8.__index = L9
  L6(L7, L8)
  return L5
end
assign = L10
function L10(A0, A1, A2, A3, A4)
  local L5, L6, L7
  L5 = node
  L6 = unpack
  L7 = A0
  L6, L7 = L6(L7)
  L5 = L5(L6, L7)
  L5.target = A1
  L5.title = A2
  L5.order = A3
  L5.flag = A4
  L6 = getfenv
  L7 = 2
  L6 = L6(L7)
  L6 = L6._NAME
  L5.module = L6
  return L5
end
entry = L10
function L10(...)
  local L1, L2, L3
  L1 = _create_node
  L2 = {}
  L3 = ...
  L2[1] = L3
  return L1(L2)
end
get = L10
function L10(...)
  local L1, L2, L3
  L1 = _create_node
  L2 = {}
  L3 = ...
  L2[1] = L3
  L1 = L1(L2)
  L2 = getfenv
  L3 = 2
  L2 = L2(L3)
  L2 = L2._NAME
  L1.module = L2
  L1.auto = nil
  return L1
end
node = L10
function L10(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = #A0
  if L1 == 0 then
    L1 = context
    L1 = L1.tree
    return L1
  end
  L1 = table
  L1 = L1.concat
  L2 = A0
  L3 = "."
  L1 = L1(L2, L3)
  L2 = context
  L2 = L2.treecache
  L2 = L2[L1]
  if not L2 then
    L3 = table
    L3 = L3.remove
    L4 = A0
    L3 = L3(L4)
    L4 = _create_node
    L5 = A0
    L4 = L4(L5)
    L5 = {}
    L6 = {}
    L5.nodes = L6
    L5.auto = true
    L2 = L5
    L5 = L4.inreq
    if L5 then
      L5 = context
      L5 = L5.path
      L6 = #A0
      L6 = L6 + 1
      L5 = L5[L6]
      if L5 == L3 then
        L2.inreq = true
      end
    end
    L5 = L4.nodes
    L5[L3] = L2
    L5 = context
    L5 = L5.treecache
    L5[L1] = L2
  end
  return L2
end
_create_node = L10
function L10()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = {}
  L1 = unpack
  L2 = context
  L2 = L2.path
  L1, L2, L3, L4, L5, L9, L10, L11, L12 = L1(L2)
  L0[1] = L1
  L0[2] = L2
  L0[3] = L3
  L0[4] = L4
  L0[5] = L5
  L0[6] = L6
  L0[7] = L7
  L0[8] = L8
  L0[9] = L9
  L0[10] = L10
  L0[11] = L11
  L0[12] = L12
  L1 = table
  L1 = L1.concat
  L2 = L0
  L3 = "."
  L1 = L1(L2, L3)
  L2 = context
  L2 = L2.treecache
  L2 = L2[L1]
  L3 = nil
  if L2 then
    L4 = L2.nodes
    if L4 then
      L4 = next
      L5 = L2.nodes
      L4 = L4(L5)
      if L4 then
        L4, L5 = nil, nil
        for L9, L10 in L6, L7, L8 do
          if L3 then
            L11 = L10.order
            L11 = L11 or L11
            L12 = L2.nodes
            L12 = L12[L3]
            L12 = L12.order
            L12 = L12 or L12
            if not (L11 < L12) then
              goto lbl_46
            end
          end
          L3 = L9
          ::lbl_46::
        end
      end
    end
  end
  L4 = assert
  L5 = L3 ~= nil
  L4(L5, L6)
  L4 = #L0
  L4 = L4 + 1
  L0[L4] = L3
  L4 = dispatch
  L5 = L0
  L4(L5)
end
_firstchild = L10
function L10()
  local L0, L1
  L0 = {}
  L0.type = "firstchild"
  L1 = _firstchild
  L0.target = L1
  return L0
end
firstchild = L10
function L10(...)
  local L1, L2
  L1 = {}
  L2 = ...
  L1[1] = L2
  function L2(...)
    local L1, L2, L3, L4, L5, L6, L7
    L4, L5, L6, L7 = ...
    L2[1] = L3
    L2[2] = L4
    L2[3] = L5
    L2[4] = L6
    L2[5] = L7
    for L4, L5 in L1, L2, L3 do
      L6 = _UPVALUE0_
      L7 = _UPVALUE0_
      L7 = #L7
      L7 = L7 + 1
      L6[L7] = L5
    end
    L1(L2)
  end
  return L2
end
alias = L10
function L10(A0, ...)
  local L2, L3
  L2 = {}
  L3 = ...
  L2[1] = L3
  function L3(...)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
    L1 = _UPVALUE0_
    L1 = L1.clone
    L1 = L1(L2)
    for L5 = L2, L3, L4 do
      L6 = table
      L6 = L6.remove
      L7 = L1
      L8 = 1
      L6(L7, L8)
    end
    for L5, L6 in L2, L3, L4 do
      L7 = table
      L7 = L7.insert
      L8 = L1
      L9 = L5
      L10 = L6
      L7(L8, L9, L10)
    end
    L5, L6, L7, L8, L9, L10 = ...
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L3[4] = L7
    L3[5] = L8
    L3[6] = L9
    L3[7] = L10
    for L5, L6 in L2, L3, L4 do
      L7 = #L1
      L7 = L7 + 1
      L1[L7] = L6
    end
    L2(L3)
  end
  return L3
end
rewrite = L10
function L10(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = getfenv
  L2 = L2()
  L3 = A0.name
  L2 = L2[L3]
  L3 = assert
  L4 = L2 ~= nil
  L5 = "Cannot resolve function \""
  L6 = A0.name
  L7 = "\". Is it misspelled or local?"
  L5 = L5 .. L6 .. L7
  L3(L4, L5)
  L3 = assert
  L4 = type
  L5 = L2
  L4 = L4(L5)
  L4 = L4 == "function"
  L5 = "The symbol \""
  L6 = A0.name
  L7 = "\" does not refer to a function but data "
  L8 = "of type \""
  L9 = type
  L10 = L2
  L9 = L9(L10)
  L10 = "\"."
  L5 = L5 .. L6 .. L7 .. L8 .. L9 .. L10
  L3(L4, L5)
  L3 = A0.argv
  L3 = #L3
  if 0 < L3 then
    L3 = L2
    L4 = unpack
    L5 = A0.argv
    L4 = L4(L5)
    L5, L6, L7, L8, L9, L10 = ...
    return L3(L4, L5, L6, L7, L8, L9, L10)
  else
    L3 = L2
    L4, L5, L6, L7, L8, L9, L10 = ...
    return L3(L4, L5, L6, L7, L8, L9, L10)
  end
end
function L11(A0, ...)
  local L2, L3, L4
  L2 = {}
  L2.type = "call"
  L3 = {}
  L4 = ...
  L3[1] = L4
  L2.argv = L3
  L2.name = A0
  L3 = _UPVALUE0_
  L2.target = L3
  return L2
end
call = L11
function L11(A0, ...)
  local L2, L3
  L2 = require
  L3 = "luci.template"
  L2 = L2(L3)
  L2 = L2.render
  L3 = A0.view
  L2(L3)
end
function L12(A0)
  local L1, L2
  L1 = {}
  L1.type = "template"
  L1.view = A0
  L2 = _UPVALUE0_
  L1.target = L2
  return L1
end
template = L12
function L12(A0, ...)
  local L2, L3, L4, L5, L6, L7
  L2 = {}
  L3, L4, L5, L6, L7 = ...
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L2[4] = L6
  L2[5] = L7
  L3 = #L2
  if 0 < L3 then
    L3 = A0.targets
    L3 = L3[2]
    if L3 then
      goto lbl_13
    end
  end
  L3 = A0.targets
  L3 = L3[1]
  ::lbl_13::
  L4 = setfenv
  L5 = L3.target
  L6 = A0.env
  L4(L5, L6)
  L5 = L3
  L4 = L3.target
  L6 = unpack
  L7 = L2
  L6, L7 = L6(L7)
  L4(L5, L6, L7)
end
function L13(A0, A1)
  local L2, L3, L4, L5
  L2 = {}
  L2.type = "arcombine"
  L3 = getfenv
  L3 = L3()
  L2.env = L3
  L3 = _UPVALUE0_
  L2.target = L3
  L3 = {}
  L4 = A0
  L5 = A1
  L3[1] = L4
  L3[2] = L5
  L2.targets = L3
  return L2
end
arcombine = L13
L13 = i18n
L13 = L13.translate
translate = L13
function L13(A0)
  local L1, L2
  L1 = translate
  L2 = A0
  return L1(L2)
end
_ = L13
