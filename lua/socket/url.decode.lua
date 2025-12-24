local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23
L0 = require
L1 = "string"
L0 = L0(L1)
L1 = _G
L2 = require
L3 = "table"
L2 = L2(L3)
L3 = require
L4 = "socket"
L3 = L3(L4)
L4 = {}
L3.url = L4
L4 = L3.url
L4._VERSION = "URL 1.0.3"
function L5(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.gsub
  L2 = A0
  L3 = "([^A-Za-z0-9_])"
  function L4(A0)
    local L1, L2, L3, L4
    L1 = _UPVALUE0_
    L1 = L1.format
    L2 = "%%%02x"
    L3 = _UPVALUE0_
    L3 = L3.byte
    L4 = A0
    L3, L4 = L3(L4)
    return L1(L2, L3, L4)
  end
  L1 = L1(L2, L3, L4)
  return L1
end
L4.escape = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  for L5, L6 in L2, L3, L4 do
    L7 = A0[L5]
    L1[L7] = 1
  end
  return L1
end
L6 = L5
L7 = {}
L8 = "-"
L9 = "_"
L10 = "."
L11 = "!"
L12 = "~"
L13 = "*"
L14 = "'"
L15 = "("
L16 = ")"
L17 = ":"
L18 = "@"
L19 = "&"
L20 = "="
L21 = "+"
L22 = "$"
L23 = ","
L7[1] = L8
L7[2] = L9
L7[3] = L10
L7[4] = L11
L7[5] = L12
L7[6] = L13
L7[7] = L14
L7[8] = L15
L7[9] = L16
L7[10] = L17
L7[11] = L18
L7[12] = L19
L7[13] = L20
L7[14] = L21
L7[15] = L22
L7[16] = L23
L6 = L6(L7)
function L7(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.gsub
  L2 = A0
  L3 = "([^A-Za-z0-9_])"
  function L4(A0)
    local L1, L2, L3, L4
    L1 = _UPVALUE0_
    L1 = L1[A0]
    if L1 then
      return A0
    else
      L1 = _UPVALUE1_
      L1 = L1.format
      L2 = "%%%02x"
      L3 = _UPVALUE1_
      L3 = L3.byte
      L4 = A0
      L3, L4 = L3(L4)
      return L1(L2, L3, L4)
    end
  end
  return L1(L2, L3, L4)
end
function L8(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.gsub
  L2 = A0
  L3 = "%%(%x%x)"
  function L4(A0)
    local L1, L2, L3, L4
    L1 = _UPVALUE0_
    L1 = L1.char
    L2 = _UPVALUE1_
    L2 = L2.tonumber
    L3 = A0
    L4 = 16
    L2, L3, L4 = L2(L3, L4)
    return L1(L2, L3, L4)
  end
  L1 = L1(L2, L3, L4)
  return L1
end
L4.unescape = L8
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L2 = L2.sub
  L3 = A1
  L4 = 1
  L5 = 1
  L2 = L2(L3, L4, L5)
  if L2 == "/" then
    return A1
  end
  L2 = _UPVALUE0_
  L2 = L2.gsub
  L3 = A0
  L4 = "[^/]*$"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L3 = L2
  L4 = A1
  L2 = L3 .. L4
  L3 = _UPVALUE0_
  L3 = L3.gsub
  L4 = L2
  L5 = "([^/]*%./)"
  function L6(A0)
    local L1
    if A0 ~= "./" then
      return A0
    else
      L1 = ""
      return L1
    end
  end
  L3 = L3(L4, L5, L6)
  L2 = L3
  L3 = _UPVALUE0_
  L3 = L3.gsub
  L4 = L2
  L5 = "/%.$"
  L6 = "/"
  L3 = L3(L4, L5, L6)
  L2 = L3
  L3 = nil
  while L3 ~= L2 do
    L3 = L2
    L4 = _UPVALUE0_
    L4 = L4.gsub
    L5 = L3
    L6 = "([^/]*/%.%./)"
    function L7(A0)
      local L1
      if A0 ~= "../../" then
        L1 = ""
        return L1
      else
        return A0
      end
    end
    L4 = L4(L5, L6, L7)
    L2 = L4
  end
  L4 = _UPVALUE0_
  L4 = L4.gsub
  L5 = L3
  L6 = "([^/]*/%.%.)$"
  function L7(A0)
    local L1
    if A0 ~= "../.." then
      L1 = ""
      return L1
    else
      return A0
    end
  end
  L4 = L4(L5, L6, L7)
  L2 = L4
  return L2
end
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = {}
  if not A1 then
  end
  for L6, L7 in L3, L4, L5 do
    L2[L6] = L7
  end
  if not A0 or A0 == "" then
    return L3, L4
  end
  function L6(A0)
    local L1
    L1 = _UPVALUE0_
    L1.fragment = A0
    L1 = ""
    return L1
  end
  A0 = L3
  function L6(A0)
    local L1
    L1 = _UPVALUE0_
    L1.scheme = A0
    L1 = ""
    return L1
  end
  A0 = L3
  function L6(A0)
    local L1
    L1 = _UPVALUE0_
    L1.authority = A0
    L1 = ""
    return L1
  end
  A0 = L3
  function L6(A0)
    local L1
    L1 = _UPVALUE0_
    L1.query = A0
    L1 = ""
    return L1
  end
  A0 = L3
  function L6(A0)
    local L1
    L1 = _UPVALUE0_
    L1.params = A0
    L1 = ""
    return L1
  end
  A0 = L3
  if A0 ~= "" then
    L2.path = A0
  end
  if not L3 then
    return L2
  end
  L6 = "^([^@]*)@"
  function L7(A0)
    local L1
    L1 = _UPVALUE0_
    L1.userinfo = A0
    L1 = ""
    return L1
  end
  L6 = ":([^:%]]*)$"
  function L7(A0)
    local L1
    L1 = _UPVALUE0_
    L1.port = A0
    L1 = ""
    return L1
  end
  if L3 ~= "" then
    L6 = "^%[(.+)%]$"
    L2.host = L4
  end
  if not L4 then
    return L2
  end
  L6 = L4
  L7 = ":([^:]*)$"
  function L8(A0)
    local L1
    L1 = _UPVALUE0_
    L1.password = A0
    L1 = ""
    return L1
  end
  L2.user = L4
  return L2
end
L4.parse = L9
function L9(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.parse_path
  L2 = A0.path
  L2 = L2 or L2
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.build_path
  L3 = L1
  L2 = L2(L3)
  L3 = A0.params
  if L3 then
    L3 = L2
    L4 = ";"
    L5 = A0.params
    L2 = L3 .. L4 .. L5
  end
  L3 = A0.query
  if L3 then
    L3 = L2
    L4 = "?"
    L5 = A0.query
    L2 = L3 .. L4 .. L5
  end
  L3 = A0.authority
  L4 = A0.host
  if L4 then
    L3 = A0.host
    L4 = _UPVALUE1_
    L4 = L4.find
    L5 = L3
    L6 = ":"
    L4 = L4(L5, L6)
    if L4 then
      L4 = "["
      L5 = L3
      L6 = "]"
      L3 = L4 .. L5 .. L6
    end
    L4 = A0.port
    if L4 then
      L4 = L3
      L5 = ":"
      L6 = A0.port
      L3 = L4 .. L5 .. L6
    end
    L4 = A0.userinfo
    L5 = A0.user
    if L5 then
      L4 = A0.user
      L5 = A0.password
      if L5 then
        L5 = L4
        L6 = ":"
        L7 = A0.password
        L4 = L5 .. L6 .. L7
      end
    end
    if L4 then
      L5 = L4
      L6 = "@"
      L7 = L3
      L3 = L5 .. L6 .. L7
    end
  end
  if L3 then
    L4 = "//"
    L5 = L3
    L6 = L2
    L2 = L4 .. L5 .. L6
  end
  L4 = A0.scheme
  if L4 then
    L4 = A0.scheme
    L5 = ":"
    L6 = L2
    L2 = L4 .. L5 .. L6
  end
  L4 = A0.fragment
  if L4 then
    L4 = L2
    L5 = "#"
    L6 = A0.fragment
    L2 = L4 .. L5 .. L6
  end
  return L2
end
L4.build = L9
function L9(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.type
  L3 = A0
  L2 = L2(L3)
  if L2 == "table" then
    base_parsed = A0
    L2 = _UPVALUE1_
    L2 = L2.build
    L3 = base_parsed
    L2 = L2(L3)
    A0 = L2
  else
    L2 = _UPVALUE1_
    L2 = L2.parse
    L3 = A0
    L2 = L2(L3)
    base_parsed = L2
  end
  L2 = _UPVALUE1_
  L2 = L2.parse
  L3 = A1
  L2 = L2(L3)
  L3 = base_parsed
  if not L3 then
    return A1
  elseif not L2 then
    return A0
  else
    L3 = L2.scheme
    if L3 then
      return A1
    else
      L3 = base_parsed
      L3 = L3.scheme
      L2.scheme = L3
      L3 = L2.authority
      if not L3 then
        L3 = base_parsed
        L3 = L3.authority
        L2.authority = L3
        L3 = L2.path
        if not L3 then
          L3 = base_parsed
          L3 = L3.path
          L2.path = L3
          L3 = L2.params
          if not L3 then
            L3 = base_parsed
            L3 = L3.params
            L2.params = L3
            L3 = L2.query
            if not L3 then
              L3 = base_parsed
              L3 = L3.query
              L2.query = L3
            end
          end
        else
          L3 = _UPVALUE2_
          L4 = base_parsed
          L4 = L4.path
          L4 = L4 or L4
          L5 = L2.path
          L3 = L3(L4, L5)
          L2.path = L3
        end
      end
      L3 = _UPVALUE1_
      L3 = L3.build
      L4 = L2
      return L3(L4)
    end
  end
end
L4.absolute = L9
function L9(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  A0 = A0 or A0
  function L5(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L1 = L1.insert
    L2 = _UPVALUE1_
    L3 = A0
    L1(L2, L3)
  end
  L2(L3, L4, L5)
  for L5 = L2, L3, L4 do
    L6 = _UPVALUE2_
    L6 = L6.unescape
    L7 = L1[L5]
    L6 = L6(L7)
    L1[L5] = L6
  end
  L5 = 1
  if L2 == "/" then
    L1.is_absolute = 1
  end
  L5 = -1
  if L2 == "/" then
    L1.is_directory = 1
  end
  return L1
end
L4.parse_path = L9
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = ""
  L3 = #A0
  if A1 then
    for L7 = L4, L5, L6 do
      L8 = L2
      L9 = A0[L7]
      L2 = L8 .. L9
      L8 = L2
      L9 = "/"
      L2 = L8 .. L9
    end
    if 0 < L3 then
      L2 = L4 .. L5
      if L4 then
        L2 = L4 .. L5
      end
    end
  else
    for L7 = L4, L5, L6 do
      L8 = L2
      L9 = _UPVALUE0_
      L10 = A0[L7]
      L9 = L9(L10)
      L2 = L8 .. L9
      L8 = L2
      L9 = "/"
      L2 = L8 .. L9
    end
    if 0 < L3 then
      L2 = L4 .. L5
      if L4 then
        L2 = L4 .. L5
      end
    end
  end
  if L4 then
    L2 = L4 .. L5
  end
  return L2
end
L4.build_path = L9
return L4
