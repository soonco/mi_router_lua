local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
L0 = require
L1 = "socket"
L0 = L0(L1)
L1 = require
L2 = "socket.url"
L1 = L1(L2)
L2 = require
L3 = "ltn12"
L2 = L2(L3)
L3 = require
L4 = "mime"
L3 = L3(L4)
L4 = require
L5 = "string"
L4 = L4(L5)
L5 = require
L6 = "socket.headers"
L5 = L5(L6)
L6 = _G
L7 = require
L8 = "table"
L7 = L7(L8)
L8 = {}
L0.http = L8
L8 = L0.http
L8.TIMEOUT = 60
L8.PORT = 80
L9 = L0._VERSION
L8.USERAGENT = L9
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  if not A1 then
    L6 = {}
    A1 = L6
  end
  L7 = A0
  L6 = A0.receive
  L6, L7 = L6(L7)
  L5 = L7
  L2 = L6
  if L5 then
    L6 = nil
    L7 = L5
    return L6, L7
  end
  while L2 ~= "" do
    L6 = _UPVALUE0_
    L6 = L6.skip
    L7 = 2
    L8 = _UPVALUE1_
    L8 = L8.find
    L9 = L2
    L10 = "^(.-):%s*(.*)"
    L8, L9, L10 = L8(L9, L10)
    L6, L7 = L6(L7, L8, L9, L10)
    L4 = L7
    L3 = L6
    if not L3 or not L4 then
      L6 = nil
      L7 = "malformed reponse headers"
      return L6, L7
    end
    L6 = _UPVALUE1_
    L6 = L6.lower
    L7 = L3
    L6 = L6(L7)
    L3 = L6
    L7 = A0
    L6 = A0.receive
    L6, L7 = L6(L7)
    L5 = L7
    L2 = L6
    if L5 then
      L6 = nil
      L7 = L5
      return L6, L7
    end
    while true do
      L6 = _UPVALUE1_
      L6 = L6.find
      L7 = L2
      L8 = "^%s"
      L6 = L6(L7, L8)
      if not L6 then
        break
      end
      L6 = L4
      L7 = L2
      L4 = L6 .. L7
      L7 = A0
      L6 = A0.receive
      L6 = L6(L7)
      L2 = L6
      if L5 then
        L6 = nil
        L7 = L5
        return L6, L7
      end
    end
    L6 = A1[L3]
    if L6 then
      L6 = A1[L3]
      L7 = ", "
      L8 = L4
      L6 = L6 .. L7 .. L8
      A1[L3] = L6
    else
      A1[L3] = L4
    end
  end
  return A1
end
L10 = L0.sourcet
function L11(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.setmetatable
  L3 = {}
  function L4()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.getfd
    return L0(L1)
  end
  L3.getfd = L4
  function L4()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.dirty
    return L0(L1)
  end
  L3.dirty = L4
  L4 = {}
  function L5()
    local L0, L1, L2, L3, L4, L5, L6, L7
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.receive
    L0, L1 = L0(L1)
    if L1 then
      L2 = nil
      L3 = L1
      return L2, L3
    end
    L2 = _UPVALUE1_
    L2 = L2.tonumber
    L3 = _UPVALUE2_
    L3 = L3.gsub
    L4 = L0
    L5 = ";.*"
    L6 = ""
    L3 = L3(L4, L5, L6)
    L4 = 16
    L2 = L2(L3, L4)
    if not L2 then
      L3 = nil
      L4 = "invalid chunk size"
      return L3, L4
    end
    if 0 < L2 then
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.receive
      L5 = L2
      L3, L4, L5 = L3(L4, L5)
      if L3 then
        L6 = _UPVALUE0_
        L7 = L6
        L6 = L6.receive
        L6(L7)
      end
      L6 = L3
      L7 = L4
      return L6, L7
    else
      L3 = _UPVALUE4_
      L4 = _UPVALUE0_
      L5 = _UPVALUE3_
      L3, L4 = L3(L4, L5)
      L1 = L4
      _UPVALUE3_ = L3
      L3 = _UPVALUE3_
      if not L3 then
        L3 = nil
        L4 = L1
        return L3, L4
      end
    end
  end
  L4.__call = L5
  return L2(L3, L4)
end
L10["http-chunked"] = L11
L10 = L0.sinkt
function L11(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.setmetatable
  L2 = {}
  function L3()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.getfd
    return L0(L1)
  end
  L2.getfd = L3
  function L3()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.dirty
    return L0(L1)
  end
  L2.dirty = L3
  L3 = {}
  function L4(A0, A1, A2)
    local L3, L4, L5, L6, L7, L8
    if not A1 then
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.send
      L5 = "0\r\n\r\n"
      return L3(L4, L5)
    end
    L3 = _UPVALUE1_
    L3 = L3.format
    L4 = "%X\r\n"
    L5 = _UPVALUE1_
    L5 = L5.len
    L6 = A1
    L5, L6, L7, L8 = L5(L6)
    L3 = L3(L4, L5, L6, L7, L8)
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.send
    L6 = L3
    L7 = A1
    L8 = "\r\n"
    L6 = L6 .. L7 .. L8
    return L4(L5, L6)
  end
  L3.__call = L4
  return L1(L2, L3)
end
L10["http-chunked"] = L11
L10 = {}
L11 = {}
L10.__index = L11
function L11(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = _UPVALUE0_
  L3 = L3.try
  L4 = A2 or L4
  if not A2 then
    L4 = _UPVALUE0_
    L4 = L4.tcp
  end
  L4, L5, L6, L7, L8, L9 = L4()
  L3 = L3(L4, L5, L6, L7, L8, L9)
  L4 = _UPVALUE1_
  L4 = L4.setmetatable
  L5 = {}
  L5.c = L3
  L6 = _UPVALUE2_
  L4 = L4(L5, L6)
  L5 = _UPVALUE0_
  L5 = L5.newtry
  function L6()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.close
    L0(L1)
  end
  L5 = L5(L6)
  L4.try = L5
  L5 = L4.try
  L7 = L3
  L6 = L3.settimeout
  L8 = _UPVALUE3_
  L8 = L8.TIMEOUT
  L6, L7, L8, L9 = L6(L7, L8)
  L5(L6, L7, L8, L9)
  L5 = L4.try
  L7 = L3
  L6 = L3.connect
  L8 = A0
  L9 = A1 or L9
  if not A1 then
    L9 = _UPVALUE3_
    L9 = L9.PORT
  end
  L6, L7, L8, L9 = L6(L7, L8, L9)
  L5(L6, L7, L8, L9)
  return L4
end
L8.open = L11
L11 = L10.__index
function L12(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _UPVALUE0_
  L3 = L3.format
  L4 = "%s %s HTTP/1.1\r\n"
  L5 = A1 or L5
  if not A1 then
    L5 = "GET"
  end
  L6 = A2
  L3 = L3(L4, L5, L6)
  L4 = A0.try
  L5 = A0.c
  L6 = L5
  L5 = L5.send
  L7 = L3
  L5, L6, L7 = L5(L6, L7)
  return L4(L5, L6, L7)
end
L11.sendrequestline = L12
L11 = L10.__index
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = _UPVALUE0_
  L2 = L2.canonic
  L3 = "\r\n"
  for L7, L8 in L4, L5, L6 do
    L9 = L2[L7]
    L9 = L9 or L9
    L10 = ": "
    L11 = L8
    L12 = "\r\n"
    L13 = L3
    L3 = L9 .. L10 .. L11 .. L12 .. L13
  end
  L7 = L3
  L7, L8, L9, L10, L11, L12, L13 = L5(L6, L7)
  L4(L5, L6, L7, L8, L9, L10, L11, L12, L13)
  return L4
end
L11.sendheaders = L12
L11 = L10.__index
function L12(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10
  if not A2 then
    L4 = _UPVALUE0_
    L4 = L4.source
    L4 = L4.empty
    L4 = L4()
    A2 = L4
  end
  if not A3 then
    L4 = _UPVALUE0_
    L4 = L4.pump
    A3 = L4.step
  end
  L4 = "http-chunked"
  L5 = A1["content-length"]
  if L5 then
    L4 = "keep-open"
  end
  L5 = A0.try
  L6 = _UPVALUE0_
  L6 = L6.pump
  L6 = L6.all
  L7 = A2
  L8 = _UPVALUE1_
  L8 = L8.sink
  L9 = L4
  L10 = A0.c
  L8 = L8(L9, L10)
  L9 = A3
  L6, L7, L8, L9, L10 = L6(L7, L8, L9)
  return L5(L6, L7, L8, L9, L10)
end
L11.sendbody = L12
L11 = L10.__index
function L12(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = A0.try
  L2 = A0.c
  L3 = L2
  L2 = L2.receive
  L4 = 5
  L2, L3, L4, L5, L6 = L2(L3, L4)
  L1 = L1(L2, L3, L4, L5, L6)
  if L1 ~= "HTTP/" then
    L2 = nil
    L3 = L1
    return L2, L3
  end
  L2 = A0.try
  L3 = A0.c
  L4 = L3
  L3 = L3.receive
  L5 = "*l"
  L6 = L1
  L3, L4, L5, L6 = L3(L4, L5, L6)
  L2 = L2(L3, L4, L5, L6)
  L1 = L2
  L2 = _UPVALUE0_
  L2 = L2.skip
  L3 = 2
  L4 = _UPVALUE1_
  L4 = L4.find
  L5 = L1
  L6 = "HTTP/%d*%.%d* (%d%d%d)"
  L4, L5, L6 = L4(L5, L6)
  L2 = L2(L3, L4, L5, L6)
  L3 = A0.try
  L4 = _UPVALUE2_
  L4 = L4.tonumber
  L5 = L2
  L4 = L4(L5)
  L5 = L1
  return L3(L4, L5)
end
L11.receivestatusline = L12
L11 = L10.__index
function L12(A0)
  local L1, L2, L3
  L1 = A0.try
  L2 = _UPVALUE0_
  L3 = A0.c
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
L11.receiveheaders = L12
L11 = L10.__index
function L12(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12
  if not A2 then
    L4 = _UPVALUE0_
    L4 = L4.sink
    L4 = L4.null
    L4 = L4()
    A2 = L4
  end
  if not A3 then
    L4 = _UPVALUE0_
    L4 = L4.pump
    A3 = L4.step
  end
  L4 = _UPVALUE1_
  L4 = L4.tonumber
  L5 = A1["content-length"]
  L4 = L4(L5)
  L5 = A1["transfer-encoding"]
  L6 = "default"
  if L5 and L5 ~= "identity" then
    L6 = "http-chunked"
  else
    L7 = _UPVALUE1_
    L7 = L7.tonumber
    L8 = A1["content-length"]
    L7 = L7(L8)
    if L7 then
      L6 = "by-length"
    end
  end
  L7 = A0.try
  L8 = _UPVALUE0_
  L8 = L8.pump
  L8 = L8.all
  L9 = _UPVALUE2_
  L9 = L9.source
  L10 = L6
  L11 = A0.c
  L12 = L4
  L9 = L9(L10, L11, L12)
  L10 = A2
  L11 = A3
  L8, L9, L10, L11, L12 = L8(L9, L10, L11)
  return L7(L8, L9, L10, L11, L12)
end
L11.receivebody = L12
L11 = L10.__index
function L12(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  L4 = _UPVALUE0_
  L4 = L4.source
  L4 = L4.rewind
  L5 = _UPVALUE1_
  L5 = L5.source
  L6 = "until-closed"
  L7 = A0.c
  L5, L6, L7, L8, L9 = L5(L6, L7)
  L4 = L4(L5, L6, L7, L8, L9)
  L5 = L4
  L6 = A1
  L5(L6)
  L5 = A0.try
  L6 = _UPVALUE0_
  L6 = L6.pump
  L6 = L6.all
  L7 = L4
  L8 = A2
  L9 = A3
  L6, L7, L8, L9 = L6(L7, L8, L9)
  return L5(L6, L7, L8, L9)
end
L11.receive09body = L12
L11 = L10.__index
function L12(A0)
  local L1, L2
  L1 = A0.c
  L2 = L1
  L1 = L1.close
  return L1(L2)
end
L11.close = L12
function L11(A0)
  local L1, L2, L3, L4, L5
  L1 = A0
  L2 = A0.proxy
  if not L2 then
    L2 = _UPVALUE0_
    L2 = L2.PROXY
    if not L2 then
      L2 = {}
      L3 = _UPVALUE1_
      L3 = L3.try
      L4 = A0.path
      L5 = "invalid path 'nil'"
      L3 = L3(L4, L5)
      L2.path = L3
      L3 = A0.params
      L2.params = L3
      L3 = A0.query
      L2.query = L3
      L3 = A0.fragment
      L2.fragment = L3
      L1 = L2
    end
  end
  L2 = _UPVALUE2_
  L2 = L2.build
  L3 = L1
  return L2(L3)
end
function L12(A0)
  local L1, L2, L3
  L1 = A0.proxy
  if not L1 then
    L1 = _UPVALUE0_
    L1 = L1.PROXY
  end
  if L1 then
    L2 = _UPVALUE1_
    L2 = L2.parse
    L3 = L1
    L2 = L2(L3)
    L1 = L2
    L2 = L1.host
    L3 = L1.port
    L3 = L3 or L3
    return L2, L3
  else
    L2 = A0.host
    L3 = A0.port
    return L2, L3
  end
end
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = A0.host
  L2 = A0.port
  if L2 then
    L2 = L1
    L1 = L2 .. L3 .. L4
  end
  L2 = {}
  L2["user-agent"] = L3
  L2.host = L1
  L2.connection = "close, TE"
  L2.te = "trailers"
  if L3 then
    if L3 then
      L6 = ":"
      L7 = A0.password
      L2.authorization = L3
    end
  end
  for L6, L7 in L3, L4, L5 do
    L8 = _UPVALUE3_
    L8 = L8.lower
    L9 = L6
    L8 = L8(L9)
    L2[L8] = L7
  end
  return L2
end
L14 = {}
L14.host = ""
L15 = L8.PORT
L14.port = L15
L14.path = "/"
L14.scheme = "http"
function L15(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = A0.url
  if L1 then
    L1 = _UPVALUE0_
    L1 = L1.parse
    L1 = L1(L2, L3)
    if L1 then
      goto lbl_12
    end
  end
  L1 = {}
  ::lbl_12::
  for L5, L6 in L2, L3, L4 do
    L1[L5] = L6
  end
  if L2 == "" then
    L1.port = 80
  end
  L3 = L3 and L3
  L5 = _UPVALUE2_
  L5 = L5.tostring
  L6 = L1.host
  L5 = L5(L6)
  L6 = "'"
  L2(L3, L4)
  L1.uri = L2
  L1.port = L3
  L1.host = L2
  L1.headers = L2
  return L1
end
function L16(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = A2.location
  if L3 then
    L3 = _UPVALUE0_
    L3 = L3.gsub
    L4 = A2.location
    L5 = "%s"
    L6 = ""
    L3 = L3(L4, L5, L6)
    L3 = L3 ~= ""
  end
  return L3
end
function L17(A0, A1)
  local L2
  L2 = A0.method
  if L2 == "HEAD" then
    L2 = nil
    return L2
  end
  if A1 == 204 or A1 == 304 then
    L2 = nil
    return L2
  end
  if 100 <= A1 and A1 < 200 then
    L2 = nil
    return L2
  end
  L2 = 1
  return L2
end
L18, L19 = nil, nil
function L19(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = _UPVALUE0_
  L3 = {}
  L4 = _UPVALUE1_
  L4 = L4.absolute
  L5 = A0.url
  L6 = A1
  L4 = L4(L5, L6)
  L3.url = L4
  L4 = A0.source
  L3.source = L4
  L4 = A0.sink
  L3.sink = L4
  L4 = A0.headers
  L3.headers = L4
  L4 = A0.proxy
  L3.proxy = L4
  L4 = A0.nredirects
  L4 = L4 or L4
  L4 = L4 + 1
  L3.nredirects = L4
  L4 = A0.create
  L3.create = L4
  L2, L3, L4, L5 = L2(L3)
  if not L4 then
    L6 = {}
    L4 = L6
  end
  L6 = L4.location
  L6 = L6 or L6
  L4.location = L6
  L6 = L2
  L7 = L3
  L8 = L4
  L9 = L5
  return L6, L7, L8, L9
end
function L18(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.open
  L3 = L1.host
  L4 = L1.port
  L5 = L1.create
  L2 = L2(L3, L4, L5)
  L4 = L2
  L3 = L2.sendrequestline
  L5 = L1.method
  L6 = L1.uri
  L3(L4, L5, L6)
  L4 = L2
  L3 = L2.sendheaders
  L5 = L1.headers
  L3(L4, L5)
  L3 = L1.source
  if L3 then
    L4 = L2
    L3 = L2.sendbody
    L5 = L1.headers
    L6 = L1.source
    L7 = L1.step
    L3(L4, L5, L6, L7)
  end
  L4 = L2
  L3 = L2.receivestatusline
  L3, L4 = L3(L4)
  if not L3 then
    L6 = L2
    L5 = L2.receive09body
    L7 = L4
    L8 = L1.sink
    L9 = L1.step
    L5(L6, L7, L8, L9)
    L5 = 1
    L6 = 200
    return L5, L6
  end
  L5 = nil
  while L3 == 100 do
    L7 = L2
    L6 = L2.receiveheaders
    L6 = L6(L7)
    L5 = L6
    L7 = L2
    L6 = L2.receivestatusline
    L6, L7 = L6(L7)
    L4 = L7
    L3 = L6
  end
  L7 = L2
  L6 = L2.receiveheaders
  L6 = L6(L7)
  L5 = L6
  L6 = _UPVALUE2_
  L7 = L1
  L8 = L3
  L9 = L5
  L6 = L6(L7, L8, L9)
  if L6 then
    L6 = L1.source
    if not L6 then
      L7 = L2
      L6 = L2.close
      L6(L7)
      L6 = _UPVALUE3_
      L7 = A0
      L8 = L5.location
      return L6(L7, L8)
    end
  end
  L6 = _UPVALUE4_
  L7 = L1
  L8 = L3
  L6 = L6(L7, L8)
  if L6 then
    L7 = L2
    L6 = L2.receivebody
    L8 = L5
    L9 = L1.sink
    L10 = L1.step
    L6(L7, L8, L9, L10)
  end
  L7 = L2
  L6 = L2.close
  L6(L7)
  L6 = 1
  L7 = L3
  L8 = L5
  L9 = L4
  return L6, L7, L8, L9
end
function L20(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = {}
  L3 = {}
  L3.url = A0
  L4 = _UPVALUE0_
  L4 = L4.sink
  L4 = L4.table
  L5 = L2
  L4 = L4(L5)
  L3.sink = L4
  if A1 then
    L4 = _UPVALUE0_
    L4 = L4.source
    L4 = L4.string
    L5 = A1
    L4 = L4(L5)
    L3.source = L4
    L4 = {}
    L5 = _UPVALUE1_
    L5 = L5.len
    L6 = A1
    L5 = L5(L6)
    L4["content-length"] = L5
    L4["content-type"] = "application/x-www-form-urlencoded"
    L3.headers = L4
    L3.method = "POST"
  end
  L4 = _UPVALUE2_
  L4 = L4.skip
  L5 = 1
  L6 = _UPVALUE3_
  L7 = L3
  L6, L7, L8, L9, L10 = L6(L7)
  L4, L5, L6 = L4(L5, L6, L7, L8, L9, L10)
  L7 = _UPVALUE4_
  L7 = L7.concat
  L8 = L2
  L7 = L7(L8)
  L8 = L4
  L9 = L5
  L10 = L6
  return L7, L8, L9, L10
end
L21 = L0.protect
function L22(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2.type
  L3 = A0
  L2 = L2(L3)
  if L2 == "string" then
    L2 = _UPVALUE1_
    L3 = A0
    L4 = A1
    return L2(L3, L4)
  else
    L2 = _UPVALUE2_
    L3 = A0
    return L2(L3)
  end
end
L21 = L21(L22)
L8.request = L21
return L8
