local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
L0 = module
L1 = "xiaoqiang.module.XQExWifiConfSyncUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "socket.http"
L0 = L0(L1)
L1 = require
L2 = "cjson"
L1 = L1(L2)
L2 = require
L3 = "luci.http"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.util.XQCryptoUtil"
L3 = L3(L4)
L4 = require
L5 = "xiaoqiang.XQLog"
L4 = L4(L5)
L5 = "a2ffa5c9be07488bbb04a3a47d3c5f6a"
L6 = 1002
L7 = 9998
L8 = 6
L9 = {}
L9.ERROR_INTERNAL = 1639
L9.ERROR_PEER_INFO = 1640
L9.ERROR_CONFIG_TRANS = 1641
L9.ERROR_INVALID_MODE = 1642
function L10(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L3 = 0
  L8 = string
  L8 = L8.upper
  L9 = A0
  L8 = L8(L9)
  L4 = L8
  L8 = _UPVALUE0_
  L8 = L8.urlencode
  L9 = L4
  L8 = L8(L9)
  L5 = L8
  L8 = os
  L8 = L8.time
  L8 = L8()
  L6 = L8
  L8 = math
  L8 = L8.randomseed
  L9 = L6
  L8(L9)
  L8 = math
  L8 = L8.random
  L9 = _UPVALUE1_
  L10 = _UPVALUE2_
  L8 = L8(L9, L10)
  L7 = L8
  L8 = L3
  L9 = "_"
  L10 = L4
  L11 = "_"
  L12 = L6
  L13 = "_"
  L14 = L7
  L1 = L8 .. L9 .. L10 .. L11 .. L12 .. L13 .. L14
  L8 = L3
  L9 = "_"
  L10 = L5
  L11 = "_"
  L12 = L6
  L13 = "_"
  L14 = L7
  L2 = L8 .. L9 .. L10 .. L11 .. L12 .. L13 .. L14
  L8 = L1
  L9 = L2
  return L8, L9
end
function L11(A0, A1)
  local L2, L3, L4, L5
  if not A1 then
    L3 = _UPVALUE0_
    L3 = L3.log
    L4 = _UPVALUE1_
    L5 = "please generate nonce first!"
    L3(L4, L5)
    L3 = nil
    return L3
  end
  L3 = _UPVALUE2_
  L3 = L3.sha1
  L4 = A0
  L5 = _UPVALUE3_
  L4 = L4 .. L5
  L3 = L3(L4)
  L2 = L3
  L3 = _UPVALUE2_
  L3 = L3.sha1
  L4 = A1
  L5 = L2
  L4 = L4 .. L5
  L3 = L3(L4)
  L2 = L3
  return L2
end
function L12(A0)
  local L1, L2, L3, L4, L5, L6
  L2 = A0
  L1 = A0.seek
  L1 = L1(L2)
  L3 = A0
  L2 = A0.seek
  L4 = "end"
  L2 = L2(L3, L4)
  L4 = A0
  L3 = A0.seek
  L5 = "set"
  L6 = L1
  L3(L4, L5, L6)
  return L2
end
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L6 = {}
  L7, L8, L9, L10 = nil, nil, nil, nil
  L11 = _UPVALUE0_
  L12 = A1
  L11, L12 = L11(L12)
  L5 = L12
  L4 = L11
  L11 = _UPVALUE1_
  L12 = A2
  L13 = L4
  L11 = L11(L12, L13)
  L3 = L11
  L11 = "username=admin&password="
  L12 = L3
  L13 = "&logtype=2&nonce="
  L14 = L5
  L11 = L11 .. L12 .. L13 .. L14
  L12 = _UPVALUE2_
  L12 = L12.log
  L13 = _UPVALUE3_
  L14 = "login request: "
  L14 = L14 .. L15
  L12(L13, L14)
  L12 = _UPVALUE4_
  L12 = L12.request
  L13 = {}
  L14 = "http://"
  L14 = L14 .. L15 .. L16
  L13.url = L14
  L13.method = "POST"
  L14 = {}
  L14["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8"
  L14["Content-Length"] = L15
  L13.headers = L14
  L14 = ltn12
  L14 = L14.source
  L14 = L14.string
  L14 = L14(L15)
  L13.source = L14
  L14 = ltn12
  L14 = L14.sink
  L14 = L14.table
  L14 = L14(L15)
  L13.sink = L14
  L12, L13, L14 = L12(L13)
  if not (L12 and L13) or not L14 then
    L15(L16, L17)
    return L15
  end
  if L12 ~= 1 or L13 ~= 200 then
    L18 = L12
    L19 = " status: "
    L20 = L13
    L15(L16, L17)
    return L15
  end
  if L15 == "table" then
    for L18, L19 in L15, L16, L17 do
      L20 = _UPVALUE5_
      L20 = L20.decode
      L21 = L19
      L20 = L20(L21)
      L7 = L20
    end
  end
  if not L7 then
    L8 = L7.url
    L9 = L7.token
    L10 = L7.code
  end
  if L10 == 0 then
    return L9
  end
  return L15
end
account_login = L13
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  if not (A0 and A1) or not A2 then
    L5 = _UPVALUE0_
    L5 = L5.log
    L6 = _UPVALUE1_
    L7 = "invalid input parameters!"
    L5(L6, L7)
    L5 = _UPVALUE2_
    L5 = L5.ERROR_INTERNAL
    return L5
  end
  L5 = _UPVALUE0_
  L5 = L5.log
  L6 = _UPVALUE1_
  L7 = "get config from peer: "
  L8 = A0
  L7 = L7 .. L8 .. L9 .. L10
  L5(L6, L7)
  L5 = io
  L5 = L5.open
  L6 = A2
  L7 = "wb"
  L5 = L5(L6, L7)
  if not L5 then
    L6 = _UPVALUE0_
    L6 = L6.log
    L7 = _UPVALUE1_
    L8 = "file open failed: "
    L8 = L8 .. L9
    L6(L7, L8)
    L6 = _UPVALUE2_
    L6 = L6.ERROR_INTERNAL
    return L6
  end
  L6 = _UPVALUE3_
  L6 = L6.request
  L7 = {}
  L8 = "http://"
  L12 = "/api/misystem/extendwifi_config_pull"
  L8 = L8 .. L9 .. L10 .. L11 .. L12
  L7.url = L8
  L7.method = "GET"
  L8 = ltn12
  L8 = L8.sink
  L8 = L8.file
  L8 = L8(L9)
  L7.sink = L8
  L6, L7, L8 = L6(L7)
  if not (L6 and L7) or not L8 then
    L9(L10, L11)
    return L9
  end
  if L6 ~= 1 or L7 ~= 200 then
    L12 = L6
    L13 = " status: "
    L14 = L7
    L9(L10, L11)
    return L9
  end
  if L9 == "table" then
    for L12, L13 in L9, L10, L11 do
      if L12 == "Content-Checksum" then
        L4 = L13
      end
    end
  end
  if not L9 then
    L12 = "config file open failed!"
    L10(L11, L12)
    return L10
  end
  if L4 ~= L11 then
    L12 = _UPVALUE1_
    L13 = "config file checksum failed!"
    L11(L12, L13)
    L12 = L9
    L11(L12)
    return L11
  end
  L12 = _UPVALUE1_
  L13 = "config file checksum ok!"
  L11(L12, L13)
  L12 = L9
  L11(L12)
  L12 = _UPVALUE1_
  L13 = "everything seems ok with config get!"
  L11(L12, L13)
  return L11
end
config_get = L13
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
  L3 = {}
  L4, L5, L6, L7, L8, L9 = nil, nil, nil, nil, nil, nil
  if not (A0 and A1) or not A2 then
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = _UPVALUE1_
    L12 = "invalid input parameters!"
    L10(L11, L12)
    L10 = _UPVALUE2_
    L10 = L10.ERROR_INTERNAL
    return L10
  end
  L10 = _UPVALUE0_
  L10 = L10.log
  L11 = _UPVALUE1_
  L12 = "post config to peer: "
  L13 = A0
  L14 = " "
  L15 = A2
  L12 = L12 .. L13 .. L14 .. L15
  L10(L11, L12)
  L10 = io
  L10 = L10.open
  L11 = A2
  L12 = "rb"
  L10 = L10(L11, L12)
  if not L10 then
    L11 = _UPVALUE0_
    L11 = L11.log
    L12 = _UPVALUE1_
    L13 = "file open failed: "
    L14 = A2
    L13 = L13 .. L14
    L11(L12, L13)
    L11 = _UPVALUE2_
    L11 = L11.ERROR_INTERNAL
    return L11
  end
  L11 = _UPVALUE3_
  L11 = L11.md5File
  L12 = A2
  L11 = L11(L12)
  if not L11 then
    L12 = io
    L12 = L12.close
    L12()
    L12 = _UPVALUE0_
    L12 = L12.log
    L13 = _UPVALUE1_
    L14 = "file calculate checksum failed: "
    L15 = A2
    L14 = L14 .. L15
    L12(L13, L14)
    L12 = _UPVALUE2_
    L12 = L12.ERROR_INTERNAL
    return L12
  end
  L12 = _UPVALUE4_
  L13 = L10
  L12 = L12(L13)
  L14 = L10
  L13 = L10.read
  L15 = "*a"
  L13 = L13(L14, L15)
  L14 = "config"
  L15 = "config.tar.gz"
  L16 = "-----------------------------7004473821227421780129388645"
  L17 = "Content-Disposition: form-data; name=\""
  L18 = L14
  L19 = "\"; filename=\""
  L20 = L15
  L21 = "\"\r\n"
  L17 = L17 .. L18 .. L19 .. L20 .. L21
  L18 = "Content-Type: application/octetstream\r\n\r\n"
  L19 = "--"
  L20 = L16
  L21 = "\r\n"
  L22 = L17
  L26 = L16
  L27 = "--\r\n"
  L19 = L19 .. L20 .. L21 .. L22 .. L23 .. L24 .. L25 .. L26 .. L27
  L20 = _UPVALUE5_
  L20 = L20.request
  L21 = {}
  L22 = "http://"
  L26 = "/api/misystem/extendwifi_config_push?checksum="
  L27 = L11
  L22 = L22 .. L23 .. L24 .. L25 .. L26 .. L27
  L21.url = L22
  L21.method = "POST"
  L22 = {}
  L22["Content-Type"] = L23
  L22["Content-Length"] = L23
  L21.headers = L22
  L22 = ltn12
  L22 = L22.source
  L22 = L22.string
  L22 = L22(L23)
  L21.source = L22
  L22 = ltn12
  L22 = L22.sink
  L22 = L22.table
  L22 = L22(L23)
  L21.sink = L22
  L20, L21, L22 = L20(L21)
  L23(L24)
  if not (L20 and L21) or not L22 then
    L23(L24, L25)
    return L23
  end
  if L20 ~= 1 or L21 ~= 200 then
    L26 = L20
    L27 = " status: "
    L28 = L21
    L23(L24, L25)
    return L23
  end
  if L23 == "table" then
    for L26, L27 in L23, L24, L25 do
      L28 = _UPVALUE6_
      L28 = L28.decode
      L29 = L27
      L28 = L28(L29)
      L4 = L28
    end
  end
  if L4 then
    L5 = L4.code
    L6 = L4.ssid_24g
    L7 = L4.password_24g
    L8 = L4.ssid_5g
    L9 = L4.password_5g
  end
  if L5 ~= 0 then
    if L5 then
      L26 = L5
      L23(L24, L25)
    end
    return L23
  end
  if L6 then
    L26 = L6
    L23(L24, L25)
  end
  if L7 then
    L26 = L7
    L23(L24, L25)
  end
  if L8 then
    L26 = L8
    L23(L24, L25)
  end
  if L9 then
    L26 = L9
    L23(L24, L25)
  end
  L23(L24, L25)
  L26 = L8
  L27 = L9
  return L23, L24, L25, L26, L27
end
config_post = L13
function L13(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L4 = {}
  L5, L6, L7 = nil, nil, nil
  if not A0 or not A1 then
    L8 = _UPVALUE0_
    L8 = L8.log
    L9 = _UPVALUE1_
    L10 = "invalid input parameters!"
    L8(L9, L10)
    L8 = 1
    return L8
  end
  if not A2 and A3 then
    L5 = "reboot=yes"
  elseif A2 and not A3 then
    L5 = "wifi=off"
  else
    L8 = _UPVALUE0_
    L8 = L8.log
    L9 = _UPVALUE1_
    L10 = "invalid input parameters, wifi: "
    L10 = L10 .. L11 .. L12 .. L13
    L8(L9, L10)
    L8 = 1
    return L8
  end
  L8 = _UPVALUE2_
  L8 = L8.request
  L9 = {}
  L10 = "http://"
  L14 = "/api/misystem/extendwifi_config_fini?"
  L15 = L5
  L10 = L10 .. L11 .. L12 .. L13 .. L14 .. L15
  L9.url = L10
  L9.method = "GET"
  L10 = ltn12
  L10 = L10.sink
  L10 = L10.table
  L10 = L10(L11)
  L9.sink = L10
  L8, L9, L10 = L8(L9)
  if not (L8 and L9) or not L10 then
    L11(L12, L13)
    return L11
  end
  if L8 ~= 1 or L9 ~= 200 then
    L14 = L8
    L15 = " status: "
    L16 = L9
    L11(L12, L13)
    return L11
  end
  if L11 == "table" then
    for L14, L15 in L11, L12, L13 do
      L16 = _UPVALUE3_
      L16 = L16.decode
      L17 = L15
      L16 = L16(L17)
      L6 = L16
    end
  end
  if L6 then
    L7 = L6.code
  end
  if L7 ~= 0 then
    if L7 then
      L14 = L7
      L11(L12, L13)
    end
    return L11
  end
  L11(L12, L13)
  return L11
end
config_finish = L13
