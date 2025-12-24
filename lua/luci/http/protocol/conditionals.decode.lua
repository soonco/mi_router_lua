local L0, L1, L2
L0 = module
L1 = "luci.http.protocol.conditionals"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.http.protocol.date"
L0 = L0(L1)
function L1(A0)
  local L1, L2, L3, L4, L5
  if A0 ~= nil then
    L1 = string
    L1 = L1.format
    L2 = "\"%x-%x-%x\""
    L3 = A0.ino
    L4 = A0.size
    L5 = A0.mtime
    return L1(L2, L3, L4, L5)
  end
end
mk_etag = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = A0.headers
  L3 = mk_etag
  L3 = L3(L4)
  if L4 == "string" then
    for L7 in L4, L5, L6 do
      if (L7 == "*" or L7 == L3) and A1 ~= nil then
        L8 = true
        return L8
      end
    end
    return L4, L5
  end
  return L4
end
if_match = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = A0.headers
  L3 = type
  L4 = L2["If-Modified-Since"]
  L3 = L3(L4)
  if L3 == "string" then
    L3 = _UPVALUE0_
    L3 = L3.to_unix
    L4 = L2["If-Modified-Since"]
    L3 = L3(L4)
    if A1 ~= nil then
      L4 = A1.mtime
      if not (L3 < L4) then
        goto lbl_18
      end
    end
    L4 = true
    do return L4 end
    ::lbl_18::
    L4 = false
    L5 = 304
    L6 = {}
    L7 = mk_etag
    L8 = A1
    L7 = L7(L8)
    L6.ETag = L7
    L7 = _UPVALUE0_
    L7 = L7.to_http
    L8 = os
    L8 = L8.time
    L8 = L8()
    L7 = L7(L8)
    L6.Date = L7
    L7 = _UPVALUE0_
    L7 = L7.to_http
    L8 = A1.mtime
    L7 = L7(L8)
    L6["Last-Modified"] = L7
    return L4, L5, L6
  end
  L3 = true
  return L3
end
if_modified_since = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = A0.headers
  L3 = mk_etag
  L4 = A1
  L3 = L3(L4)
  L4 = A0.env
  if L4 then
    L4 = A0.env
    L4 = L4.REQUEST_METHOD
    if L4 then
      goto lbl_13
    end
  end
  L4 = "GET"
  ::lbl_13::
  if L5 == "string" then
    for L8 in L5, L6, L7 do
      if (L8 == "*" or L8 == L3) and A1 ~= nil then
        if L4 == "GET" or L4 == "HEAD" then
          L9 = false
          L10 = 304
          L11 = {}
          L11.ETag = L3
          L12 = _UPVALUE0_
          L12 = L12.to_http
          L13 = os
          L13 = L13.time
          L13 = L13()
          L12 = L12(L13)
          L11.Date = L12
          L12 = _UPVALUE0_
          L12 = L12.to_http
          L13 = A1.mtime
          L12 = L12(L13)
          L11["Last-Modified"] = L12
          return L9, L10, L11
        else
          L9 = false
          L10 = 412
          return L9, L10
        end
      end
    end
  end
  return L5
end
if_none_match = L1
function L1(A0, A1)
  local L2, L3
  L2 = false
  L3 = 412
  return L2, L3
end
if_range = L1
function L1(A0, A1)
  local L2, L3, L4, L5
  L2 = A0.headers
  L3 = type
  L4 = L2["If-Unmodified-Since"]
  L3 = L3(L4)
  if L3 == "string" then
    L3 = _UPVALUE0_
    L3 = L3.to_unix
    L4 = L2["If-Unmodified-Since"]
    L3 = L3(L4)
    if A1 ~= nil then
      L4 = A1.mtime
      if L3 <= L4 then
        L4 = false
        L5 = 412
        return L4, L5
      end
    end
  end
  L3 = true
  return L3
end
if_unmodified_since = L1
