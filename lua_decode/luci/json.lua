local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "table"
L1 = L1(L2)
L2 = require
L3 = "string"
L2 = L2(L3)
L3 = require
L4 = "coroutine"
L3 = L3(L4)
L4 = assert
L5 = tonumber
L6 = tostring
L7 = error
L8 = type
L9 = pairs
L10 = ipairs
L11 = next
L12 = pcall
L13 = getmetatable
L14 = module
L15 = "luci.json"
L14(L15)
function L14(A0, ...)
  local L2, L3, L4, L5
  L2 = ActiveDecoder
  function L3()
    local L0, L1
    return L0
  end
  L4, L5 = ...
  L2 = L2(L3, L4, L5)
  L2.chunk = A0
  L3 = _UPVALUE0_
  L4 = L2.get
  L5 = L2
  L3, L4 = L3(L4, L5)
  L5 = L4 or L5
  if not L3 or not L4 then
    L5 = nil
  end
  return L5
end
decode = L14
function L14(A0, ...)
  local L2, L3, L4, L5, L6, L7
  L2 = {}
  L3 = Encoder
  L4 = A0
  L5 = 1
  L6, L7 = ...
  L3 = L3(L4, L5, L6, L7)
  L4 = L3
  L3 = L3.source
  L3 = L3(L4)
  L4, L5 = nil, nil
  repeat
    L6 = L3
    L6, L7 = L6()
    L5 = L7
    L4 = L6
    L6 = #L2
    L6 = L6 + 1
    L2[L6] = L4
  until not L4
  if not L5 then
    L6 = _UPVALUE0_
    L6 = L6.concat
    L7 = L2
    L6 = L6(L7)
    if L6 then
      goto lbl_28
    end
  end
  L6 = nil
  ::lbl_28::
  return L6
end
encode = L14
function L14()
  local L0, L1
  L0 = null
  return L0
end
null = L14
L14 = L0.class
L14 = L14()
Encoder = L14
L14 = Encoder
function L15(A0, A1, A2, A3)
  local L4, L5
  A0.data = A1
  L4 = A2 or L4
  if not A2 then
    L4 = 512
  end
  A0.buffersize = L4
  A0.buffer = ""
  A0.fastescape = A3
  L4 = _UPVALUE0_
  L5 = A0
  L4 = L4(L5)
  L5 = Encoder
  L5 = L5.source
  L4.__call = L5
end
L14.__init__ = L15
L14 = Encoder
function L15(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.create
  L2 = A0.dispatch
  L1 = L1(L2)
  function L2()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE0_
    L0 = L0.resume
    L1 = _UPVALUE1_
    L2 = _UPVALUE2_
    L3 = _UPVALUE2_
    L3 = L3.data
    L4 = true
    L0, L1 = L0(L1, L2, L3, L4)
    if L0 then
      return L1
    else
      L2 = nil
      L3 = L1
      return L2, L3
    end
  end
  return L2
end
L14.source = L15
L14 = Encoder
function L15(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = A0.parsers
  L4 = _UPVALUE0_
  L5 = A1
  L4 = L4(L5)
  L3 = L3[L4]
  L4 = L3
  L5 = A0
  L6 = A1
  L4(L5, L6)
  if A2 then
    L4 = A0.buffer
    L4 = #L4
    if 0 < L4 then
      L4 = _UPVALUE1_
      L4 = L4.yield
      L5 = A0.buffer
      L4(L5)
    end
    L4 = _UPVALUE1_
    L4 = L4.yield
    L4()
  end
end
L14.dispatch = L15
L14 = Encoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = A0.buffersize
  if L2 < 2 then
    L2 = _UPVALUE0_
    L2 = L2.yield
    L3 = A1
    L2(L3)
  else
    L2 = A0.buffer
    L2 = #L2
    L3 = #A1
    L2 = L2 + L3
    L3 = A0.buffersize
    if L2 > L3 then
      L2 = 0
      L3 = A0.buffersize
      L4 = A0.buffer
      L4 = #L4
      L3 = L3 - L4
      L4 = _UPVALUE0_
      L4 = L4.yield
      L5 = A0.buffer
      L7 = A1
      L6 = A1.sub
      L8 = L2 + 1
      L9 = L3
      L6 = L6(L7, L8, L9)
      L5 = L5 .. L6
      L4(L5)
      L2 = L3
      while true do
        L4 = #A1
        L4 = L4 - L2
        L5 = A0.buffersize
        if not (L4 > L5) then
          break
        end
        L4 = A0.buffersize
        L3 = L2 + L4
        L4 = _UPVALUE0_
        L4 = L4.yield
        L6 = A1
        L5 = A1.sub
        L7 = L2 + 1
        L8 = L3
        L5, L6, L7, L8, L9 = L5(L6, L7, L8)
        L4(L5, L6, L7, L8, L9)
        L2 = L3
      end
      L5 = A1
      L4 = A1.sub
      L6 = L2 + 1
      L4 = L4(L5, L6)
      A0.buffer = L4
    else
      L2 = A0.buffer
      L3 = A1
      L2 = L2 .. L3
      A0.buffer = L2
    end
  end
end
L14.put = L15
L14 = Encoder
function L15(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.put
  L3 = "null"
  L1(L2, L3)
end
L14.parse_nil = L15
L14 = Encoder
function L15(A0, A1)
  local L2, L3, L4
  L3 = A0
  L2 = A0.put
  if A1 then
    L4 = "true"
    if L4 then
      goto lbl_8
    end
  end
  L4 = "false"
  ::lbl_8::
  L2(L3, L4)
end
L14.parse_bool = L15
L14 = Encoder
function L15(A0, A1)
  local L2, L3, L4, L5
  L3 = A0
  L2 = A0.put
  L4 = _UPVALUE0_
  L5 = A1
  L4, L5 = L4(L5)
  L2(L3, L4, L5)
end
L14.parse_number = L15
L14 = Encoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = A0.fastescape
  if L2 then
    L3 = A0
    L2 = A0.put
    L4 = "\""
    L6 = A1
    L5 = A1.gsub
    L7 = "\\"
    L8 = "\\\\"
    L5 = L5(L6, L7, L8)
    L6 = L5
    L5 = L5.gsub
    L7 = "\""
    L8 = "\\\""
    L5 = L5(L6, L7, L8)
    L6 = "\""
    L4 = L4 .. L5 .. L6
    L2(L3, L4)
  else
    L3 = A0
    L2 = A0.put
    L4 = "\""
    L6 = A1
    L5 = A1.gsub
    L7 = "[%c\\\"]"
    function L8(A0)
      local L1, L2
      L2 = A0
      L1 = A0.byte
      L1 = L1(L2)
      L1 = "\\u00%02x" % L1
      return L1
    end
    L5 = L5(L6, L7, L8)
    L6 = "\""
    L4 = L4 .. L5 .. L6
    L2(L3, L4)
  end
end
L14.parse_string = L15
L14 = Encoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = null
  if A1 == L2 then
    L2 = A0.put
    return L2(L3, L4)
  end
  L2 = _UPVALUE0_
  L2 = L2(L3)
  if L2 == "table" then
    L2 = #A1
    if L2 == 0 then
      L2 = _UPVALUE1_
      L2 = L2(L3)
      if L2 then
        L2 = A0.put
        L2(L3, L4)
        L2 = true
        for L6, L7 in L3, L4, L5 do
          if not L2 then
            L9 = A0
            L8 = A0.put
            L10 = ","
            L8 = L8(L9, L10)
            L2 = L8
          end
          L2 = L2 and L2
          L9 = A0
          L8 = A0.parse_string
          L10 = _UPVALUE3_
          L11 = L6
          L10, L11 = L10(L11)
          L8(L9, L10, L11)
          L9 = A0
          L8 = A0.put
          L10 = ":"
          L8(L9, L10)
          L9 = A0
          L8 = A0.dispatch
          L10 = L7
          L8(L9, L10)
        end
        L3(L4, L5)
    end
  end
  else
    L2 = A0.put
    L2(L3, L4)
    L2 = true
    if L3 == "table" then
      for L6 = L3, L4, L5 do
        if not L2 then
          L8 = A0
          L7 = A0.put
          L9 = ","
          L7 = L7(L8, L9)
          L2 = L7
        end
        L2 = L2 and L2
        L8 = A0
        L7 = A0.dispatch
        L9 = A1[L6]
        L7(L8, L9)
      end
    else
      for L6 in L3, L4, L5 do
        if not L2 then
          L8 = A0
          L7 = A0.put
          L9 = ","
          L7 = L7(L8, L9)
          L2 = L7
        end
        L2 = L2 and L2
        L8 = A0
        L7 = A0.dispatch
        L9 = L6
        L7(L8, L9)
      end
    end
    L3(L4, L5)
  end
end
L14.parse_iter = L15
L14 = Encoder
L15 = {}
L16 = Encoder
L16 = L16.parse_nil
L15["nil"] = L16
L16 = Encoder
L16 = L16.parse_iter
L15.table = L16
L16 = Encoder
L16 = L16.parse_number
L15.number = L16
L16 = Encoder
L16 = L16.parse_string
L15.string = L16
L16 = Encoder
L16 = L16.parse_bool
L15.boolean = L16
L16 = Encoder
L16 = L16.parse_iter
L15["function"] = L16
L14.parsers = L15
L14 = L0.class
L14 = L14()
Decoder = L14
L14 = Decoder
function L15(A0, A1)
  local L2, L3
  A0.cnull = A1
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  L3 = Decoder
  L3 = L3.sink
  L2.__call = L3
end
L14.__init__ = L15
L14 = Decoder
function L15(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.create
  L2 = A0.dispatch
  L1 = L1(L2)
  function L2(...)
    local L1, L2, L3, L4
    L1 = _UPVALUE0_
    L1 = L1.resume
    L2 = _UPVALUE1_
    L3 = _UPVALUE2_
    L4 = ...
    return L1(L2, L3, L4)
  end
  return L2
end
L14.sink = L15
L14 = Decoder
function L15(A0)
  local L1
  L1 = A0.data
  return L1
end
L14.get = L15
L14 = Decoder
function L15(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11
  L6 = false
  while A1 do
    while A1 do
      L7 = #A1
      if not (L7 < 1) then
        break
      end
      L8 = A0
      L7 = A0.fetch
      L7 = L7(L8)
      A1 = L7
    end
    L7 = _UPVALUE0_
    L8 = not A3 or L8
    L9 = "Unexpected EOS"
    L7(L8, L9)
    if not A1 then
      break
    end
    L8 = A1
    L7 = A1.sub
    L9 = 1
    L10 = 1
    L7 = L7(L8, L9, L10)
    L8 = A0.parsers
    L8 = L8[L7]
    if not L8 then
      L9 = L7
      L8 = L7.match
      L10 = "%s"
      L8 = L8(L9, L10)
      if L8 then
        L8 = A0.parse_space
        if L8 then
          goto lbl_52
        end
      end
      L9 = L7
      L8 = L7.match
      L10 = "[0-9-]"
      L8 = L8(L9, L10)
      if L8 then
        L8 = A0.parse_number
        if L8 then
          goto lbl_52
        end
      end
      L8 = _UPVALUE1_
      L9 = "Unexpected char '%s'" % L7
      L8 = L8(L9)
    end
    ::lbl_52::
    L9 = L8
    L10 = A0
    L11 = A1
    L9, L10 = L9(L10, L11)
    L4 = L10
    A1 = L9
    L9 = A0.parse_space
    if L8 ~= L9 then
      L9 = _UPVALUE0_
      L10 = not L6
      L11 = "Scope violation: Too many objects"
      L9(L10, L11)
      L5 = L4
      L6 = true
      if A3 then
        L9 = A1
        L10 = L5
        return L9, L10
      end
    end
  end
  L7 = _UPVALUE0_
  L8 = not A2
  L9 = A2
  L7(L8, L9)
  L7 = _UPVALUE0_
  L8 = L6
  L9 = "Unexpected EOS"
  L7(L8, L9)
  A0.data = L5
end
L14.dispatch = L15
L14 = Decoder
function L15(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.yield
  L1, L2, L3 = L1()
  L4 = _UPVALUE1_
  L5 = L2 or L5
  if not L2 then
    L5 = not L3
  end
  L6 = L3
  L4(L5, L6)
  return L2
end
L14.fetch = L15
L14 = Decoder
function L15(A0, A1, A2)
  local L3, L4, L5, L6
  while true do
    L3 = #A1
    if not (A2 > L3) then
      break
    end
    L4 = A0
    L3 = A0.fetch
    L3 = L3(L4)
    L4 = _UPVALUE0_
    L5 = L3
    L6 = "Unexpected EOS"
    L4(L5, L6)
    L4 = A1
    L5 = L3
    A1 = L4 .. L5
  end
  return A1
end
L14.fetch_atleast = L15
L14 = Decoder
function L15(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L4 = A1
  L3 = A1.find
  L5 = A2
  L3 = L3(L4, L5)
  while not L3 do
    L5 = A0
    L4 = A0.fetch
    L4 = L4(L5)
    L5 = _UPVALUE0_
    L6 = L4
    L7 = "Unexpected EOS"
    L5(L6, L7)
    L5 = A1
    L6 = L4
    A1 = L5 .. L6
    L6 = A1
    L5 = A1.find
    L7 = A2
    L5 = L5(L6, L7)
    L3 = L5
  end
  L4 = A1
  L5 = L3
  return L4, L5
end
L14.fetch_until = L15
L14 = Decoder
function L15(A0, A1)
  local L2, L3, L4, L5
  L3 = A1
  L2 = A1.find
  L4 = "[^%s]"
  L2 = L2(L3, L4)
  while not L2 do
    L4 = A0
    L3 = A0.fetch
    L3 = L3(L4)
    A1 = L3
    if not A1 then
      L3 = nil
      return L3
    end
    L4 = A1
    L3 = A1.find
    L5 = "[^%s]"
    L3 = L3(L4, L5)
    L2 = L3
  end
  L4 = A1
  L3 = A1.sub
  L5 = L2
  return L3(L4, L5)
end
L14.parse_space = L15
L14 = Decoder
function L15(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8
  L5 = A0
  L4 = A0.fetch_atleast
  L6 = A1
  L7 = #A2
  L4 = L4(L5, L6, L7)
  A1 = L4
  L4 = _UPVALUE0_
  L6 = A1
  L5 = A1.sub
  L7 = 1
  L8 = #A2
  L5 = L5(L6, L7, L8)
  L5 = L5 == A2
  L6 = "Invalid character sequence"
  L4(L5, L6)
  L5 = A1
  L4 = A1.sub
  L6 = #A2
  L6 = L6 + 1
  L4 = L4(L5, L6)
  L5 = A3
  return L4, L5
end
L14.parse_literal = L15
L14 = Decoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6
  L3 = A0
  L2 = A0.parse_literal
  L4 = A1
  L5 = "null"
  L6 = A0.cnull
  L6 = L6 and L6
  return L2(L3, L4, L5, L6)
end
L14.parse_null = L15
L14 = Decoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6
  L3 = A0
  L2 = A0.parse_literal
  L4 = A1
  L5 = "true"
  L6 = true
  return L2(L3, L4, L5, L6)
end
L14.parse_true = L15
L14 = Decoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6
  L3 = A0
  L2 = A0.parse_literal
  L4 = A1
  L5 = "false"
  L6 = false
  return L2(L3, L4, L5, L6)
end
L14.parse_false = L15
L14 = Decoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L3 = A0
  L2 = A0.fetch_until
  L4 = A1
  L5 = "[^0-9eE.+-]"
  L2, L3 = L2(L3, L4, L5)
  L4 = _UPVALUE0_
  L6 = L2
  L5 = L2.sub
  L7 = 1
  L8 = L3 - 1
  L5, L6, L7, L8 = L5(L6, L7, L8)
  L4 = L4(L5, L6, L7, L8)
  L5 = _UPVALUE1_
  L6 = L4
  L7 = "Invalid number specification"
  L5(L6, L7)
  L6 = L2
  L5 = L2.sub
  L7 = L3
  L5 = L5(L6, L7)
  L6 = L4
  return L5, L6
end
L14.parse_number = L15
L14 = Decoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = ""
  L3 = nil
  L4 = _UPVALUE0_
  L6 = A1
  L5 = A1.sub
  L7 = 1
  L8 = 1
  L5 = L5(L6, L7, L8)
  L5 = L5 == "\""
  L6 = "Expected \""
  L4(L5, L6)
  L5 = A1
  L4 = A1.sub
  L6 = 2
  L4 = L4(L5, L6)
  A1 = L4
  while true do
    L5 = A1
    L4 = A1.find
    L6 = "[\\\"]"
    L4 = L4(L5, L6)
    if L4 then
      L5 = L2
      L7 = A1
      L6 = A1.sub
      L8 = 1
      L9 = L4 - 1
      L6 = L6(L7, L8, L9)
      L2 = L5 .. L6
      L6 = A1
      L5 = A1.sub
      L7 = L4
      L8 = L4
      L5 = L5(L6, L7, L8)
      if L5 == "\"" then
        L7 = A1
        L6 = A1.sub
        L8 = L4 + 1
        L6 = L6(L7, L8)
        A1 = L6
        break
      elseif L5 == "\\" then
        L7 = A0
        L6 = A0.parse_escape
        L9 = A1
        L8 = A1.sub
        L10 = L4
        L8, L9, L10 = L8(L9, L10)
        L6, L7 = L6(L7, L8, L9, L10)
        L3 = L7
        A1 = L6
        L6 = L2
        L7 = L3
        L2 = L6 .. L7
      end
    else
      L5 = L2
      L6 = A1
      L2 = L5 .. L6
      L6 = A0
      L5 = A0.fetch
      L5 = L5(L6)
      A1 = L5
      L5 = _UPVALUE0_
      L6 = A1
      L7 = "Unexpected EOS while parsing a string"
      L5(L6, L7)
    end
  end
  L4 = A1
  L5 = L2
  return L4, L5
end
L14.parse_string = L15
L14 = Decoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = ""
  L4 = A0
  L3 = A0.fetch_atleast
  L6 = A1
  L5 = A1.sub
  L7 = 2
  L5 = L5(L6, L7)
  L6 = 1
  L3 = L3(L4, L5, L6)
  A1 = L3
  L4 = A1
  L3 = A1.sub
  L5 = 1
  L6 = 1
  L3 = L3(L4, L5, L6)
  L5 = A1
  L4 = A1.sub
  L6 = 2
  L4 = L4(L5, L6)
  A1 = L4
  if L3 == "\"" then
    L4 = A1
    L5 = "\""
    return L4, L5
  elseif L3 == "\\" then
    L4 = A1
    L5 = "\\"
    return L4, L5
  elseif L3 == "u" then
    L5 = A0
    L4 = A0.fetch_atleast
    L6 = A1
    L7 = 4
    L4 = L4(L5, L6, L7)
    A1 = L4
    L5 = A1
    L4 = A1.sub
    L6 = 1
    L7 = 2
    L4 = L4(L5, L6, L7)
    L6 = A1
    L5 = A1.sub
    L7 = 3
    L8 = 4
    L5 = L5(L6, L7, L8)
    L6 = _UPVALUE0_
    L7 = L4
    L8 = 16
    L6 = L6(L7, L8)
    L7 = _UPVALUE0_
    L8 = L5
    L9 = 16
    L7 = L7(L8, L9)
    L5 = L7
    L4 = L6
    L6 = _UPVALUE1_
    L7 = L4 or L7
    if L4 then
      L7 = L5
    end
    L8 = "Invalid Unicode character"
    L6(L7, L8)
    L7 = A1
    L6 = A1.sub
    L8 = 5
    L6 = L6(L7, L8)
    if L4 == 0 then
      L7 = _UPVALUE2_
      L7 = L7.char
      L8 = L5
      L7 = L7(L8)
      if L7 then
        goto lbl_72
      end
    end
    L7 = ""
    ::lbl_72::
    return L6, L7
  elseif L3 == "/" then
    L4 = A1
    L5 = "/"
    return L4, L5
  elseif L3 == "b" then
    L4 = A1
    L5 = "\b"
    return L4, L5
  elseif L3 == "f" then
    L4 = A1
    L5 = "\f"
    return L4, L5
  elseif L3 == "n" then
    L4 = A1
    L5 = "\n"
    return L4, L5
  elseif L3 == "r" then
    L4 = A1
    L5 = "\r"
    return L4, L5
  elseif L3 == "t" then
    L4 = A1
    L5 = "\t"
    return L4, L5
  else
    L4 = _UPVALUE3_
    L5 = "Unexpected escaping sequence '\\%s'" % L3
    L4(L5)
  end
end
L14.parse_escape = L15
L14 = Decoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L3 = A1
  L2 = A1.sub
  L4 = 2
  L2 = L2(L3, L4)
  A1 = L2
  L2 = {}
  L3 = 1
  L5 = A0
  L4 = A0.parse_delimiter
  L6 = A1
  L7 = "%]"
  L4, L5 = L4(L5, L6, L7)
  if L5 then
    L6 = L4
    L7 = L2
    return L6, L7
  end
  repeat
    L7 = A0
    L6 = A0.dispatch
    L8 = L4
    L9 = nil
    L10 = true
    L6, L7 = L6(L7, L8, L9, L10)
    L5 = L7
    L4 = L6
    L6 = _UPVALUE0_
    L6 = L6.insert
    L7 = L2
    L8 = L3
    L9 = L5
    L6(L7, L8, L9)
    L3 = L3 + 1
    L7 = A0
    L6 = A0.parse_delimiter
    L8 = L4
    L9 = ",%]"
    L6, L7 = L6(L7, L8, L9)
    L5 = L7
    L4 = L6
    L6 = _UPVALUE1_
    L7 = L5
    L8 = "Delimiter expected"
    L6(L7, L8)
  until L5 == "]"
  L6 = L4
  L7 = L2
  return L6, L7
end
L14.parse_array = L15
L14 = Decoder
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L3 = A1
  L2 = A1.sub
  L4 = 2
  L2 = L2(L3, L4)
  A1 = L2
  L2 = {}
  L3 = nil
  L5 = A0
  L4 = A0.parse_delimiter
  L6 = A1
  L7 = "}"
  L4, L5 = L4(L5, L6, L7)
  if L5 then
    L6 = L4
    L7 = L2
    return L6, L7
  end
  repeat
    L7 = A0
    L6 = A0.parse_space
    L8 = L4
    L6 = L6(L7, L8)
    L4 = L6
    L6 = _UPVALUE0_
    L7 = L4
    L8 = "Unexpected EOS"
    L6(L7, L8)
    L7 = A0
    L6 = A0.parse_string
    L8 = L4
    L6, L7 = L6(L7, L8)
    L3 = L7
    L4 = L6
    L7 = A0
    L6 = A0.parse_delimiter
    L8 = L4
    L9 = ":"
    L6, L7 = L6(L7, L8, L9)
    L5 = L7
    L4 = L6
    L6 = _UPVALUE0_
    L7 = L5
    L8 = "Separator expected"
    L6(L7, L8)
    L7 = A0
    L6 = A0.dispatch
    L8 = L4
    L9 = nil
    L10 = true
    L6, L7 = L6(L7, L8, L9, L10)
    L5 = L7
    L4 = L6
    L2[L3] = L5
    L7 = A0
    L6 = A0.parse_delimiter
    L8 = L4
    L9 = ",}"
    L6, L7 = L6(L7, L8, L9)
    L5 = L7
    L4 = L6
    L6 = _UPVALUE0_
    L7 = L5
    L8 = "Delimiter expected"
    L6(L7, L8)
  until L5 == "}"
  L6 = L4
  L7 = L2
  return L6, L7
end
L14.parse_object = L15
L14 = Decoder
function L15(A0, A1, A2)
  local L3, L4, L5, L6
  while true do
    L4 = A0
    L3 = A0.fetch_atleast
    L5 = A1
    L6 = 1
    L3 = L3(L4, L5, L6)
    A1 = L3
    L4 = A1
    L3 = A1.sub
    L5 = 1
    L6 = 1
    L3 = L3(L4, L5, L6)
    L5 = L3
    L4 = L3.match
    L6 = "%s"
    L4 = L4(L5, L6)
    if L4 then
      L5 = A0
      L4 = A0.parse_space
      L6 = A1
      L4 = L4(L5, L6)
      A1 = L4
      L4 = _UPVALUE0_
      L5 = A1
      L6 = "Unexpected EOS"
      L4(L5, L6)
    else
      L5 = L3
      L4 = L3.match
      L6 = "[%s]" % A2
      L4 = L4(L5, L6)
      if L4 then
        L5 = A1
        L4 = A1.sub
        L6 = 2
        L4 = L4(L5, L6)
        L5 = L3
        return L4, L5
      else
        L4 = A1
        L5 = nil
        return L4, L5
      end
    end
  end
end
L14.parse_delimiter = L15
L14 = Decoder
L15 = {}
L16 = Decoder
L16 = L16.parse_string
L15["\""] = L16
L16 = Decoder
L16 = L16.parse_true
L15.t = L16
L16 = Decoder
L16 = L16.parse_false
L15.f = L16
L16 = Decoder
L16 = L16.parse_null
L15.n = L16
L16 = Decoder
L16 = L16.parse_array
L15["["] = L16
L16 = Decoder
L16 = L16.parse_object
L15["{"] = L16
L14.parsers = L15
L14 = L0.class
L15 = Decoder
L14 = L14(L15)
ActiveDecoder = L14
L14 = ActiveDecoder
function L15(A0, A1, A2)
  local L3, L4, L5
  L3 = Decoder
  L3 = L3.__init__
  L4 = A0
  L5 = A2
  L3(L4, L5)
  A0.source = A1
  A0.chunk = nil
  L3 = _UPVALUE0_
  L4 = A0
  L3 = L3(L4)
  L4 = A0.get
  L3.__call = L4
end
L14.__init__ = L15
L14 = ActiveDecoder
function L15(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L4 = A0.chunk
  if not L4 then
    L4 = A0.source
    L4, L5 = L4()
    L2 = L5
    L1 = L4
  else
    L1 = A0.chunk
  end
  L5 = A0
  L4 = A0.dispatch
  L6 = L1
  L7 = L2
  L8 = true
  L4, L5 = L4(L5, L6, L7, L8)
  L3 = L5
  A0.chunk = L4
  return L3
end
L14.get = L15
L14 = ActiveDecoder
function L15(A0)
  local L1, L2, L3, L4, L5
  L1 = A0.source
  L1, L2 = L1()
  L3 = _UPVALUE0_
  L4 = L1 or L4
  if not L1 then
    L4 = not L2
  end
  L5 = L2
  L3(L4, L5)
  return L1
end
L14.fetch = L15
