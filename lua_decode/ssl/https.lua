local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
L0 = require
L1 = "socket"
L0 = L0(L1)
L1 = require
L2 = "ssl"
L1 = L1(L2)
L2 = require
L3 = "ltn12"
L2 = L2(L3)
L3 = require
L4 = "socket.http"
L3 = L3(L4)
L4 = require
L5 = "socket.url"
L4 = L4(L5)
L5 = L0.try
L6 = {}
L6._VERSION = "0.9"
L6._COPYRIGHT = "LuaSec 0.9 - Copyright (C) 2009-2019 PUC-Rio"
L6.PORT = 443
L6.TIMEOUT = 60
L7 = {}
L7.protocol = "any"
L8 = {}
L9 = "all"
L10 = "no_sslv2"
L11 = "no_sslv3"
L12 = "no_tlsv1"
L8[1] = L9
L8[2] = L10
L8[3] = L11
L8[4] = L12
L7.options = L8
L7.verify = "none"
function L8(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.build
  L2 = _UPVALUE0_
  L2 = L2.parse
  L3 = A0
  L4 = {}
  L5 = _UPVALUE1_
  L5 = L5.PORT
  L4.port = L5
  L2, L3, L4, L5 = L2(L3, L4)
  return L1(L2, L3, L4, L5)
end
function L9(A0, A1, A2)
  local L3, L4, L5
  L3 = {}
  L4 = _UPVALUE0_
  L5 = A0
  L4 = L4(L5)
  L3.url = L4
  if A1 then
    L4 = "POST"
    if L4 then
      goto lbl_12
    end
  end
  L4 = "GET"
  ::lbl_12::
  L3.method = L4
  L4 = _UPVALUE1_
  L4 = L4.sink
  L4 = L4.table
  L5 = A2
  L4 = L4(L5)
  L3.sink = L4
  A0 = L3
  if A1 then
    L3 = _UPVALUE1_
    L3 = L3.source
    L3 = L3.string
    L4 = A1
    L3 = L3(L4)
    A0.source = L3
    L3 = {}
    L4 = #A1
    L3["content-length"] = L4
    L3["content-type"] = "application/x-www-form-urlencoded"
    A0.headers = L3
  end
  return A0
end
function L10(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = getmetatable
  L1 = L1(L2)
  L1 = L1.__index
  for L5, L6 in L2, L3, L4 do
    L7 = type
    L8 = L6
    L7 = L7(L8)
    if L7 == "function" then
      function L7(A0, ...)
        local L2, L3, L4
        L2 = _UPVALUE0_
        L3 = A0.sock
        L4 = ...
        return L2(L3, L4)
      end
      A0[L5] = L7
    end
  end
end
function L11(A0)
  local L1, L2, L3, L4, L5, L6
  A0 = A0 or A0
  for L4, L5 in L1, L2, L3 do
    L6 = A0[L4]
    L6 = L6 or L6
    A0[L4] = L6
  end
  A0.mode = "client"
  return L1
end
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = {}
  L3 = type
  L4 = A0
  L3 = L3(L4)
  L3 = L3 == "string"
  if L3 then
    L4 = _UPVALUE0_
    L5 = A0
    L6 = A1
    L7 = L2
    L4 = L4(L5, L6, L7)
    A0 = L4
  else
    L4 = _UPVALUE1_
    L5 = A0.url
    L4 = L4(L5)
    A0.url = L4
  end
  L4 = _UPVALUE2_
  L4 = L4.PROXY
  if not L4 then
    L4 = A0.proxy
    if not L4 then
      goto lbl_33
    end
  end
  L4 = nil
  L5 = "proxy not supported"
  do return L4, L5 end
  goto lbl_46
  ::lbl_33::
  L4 = A0.redirect
  if L4 then
    L4 = nil
    L5 = "redirect not supported"
    return L4, L5
  else
    L4 = A0.create
    if L4 then
      L4 = nil
      L5 = "create function not permitted"
      return L4, L5
    end
  end
  ::lbl_46::
  L4 = _UPVALUE3_
  L5 = A0
  L4 = L4(L5)
  A0.create = L4
  L4 = _UPVALUE2_
  L4 = L4.request
  L5 = A0
  L4, L5, L6, L7 = L4(L5)
  if L4 and L3 then
    L8 = table
    L8 = L8.concat
    L9 = L2
    L8 = L8(L9)
    L9 = L5
    L10 = L6
    L11 = L7
    return L8, L9, L10, L11
  end
  L8 = L4
  L9 = L5
  L10 = L6
  L11 = L7
  return L8, L9, L10, L11
end
L6.request = L12
L6.tcp = L11
return L6
