local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
L0 = require
L1 = "math"
L0 = L0(L1)
L1 = require
L2 = "string"
L1 = L1(L2)
L2 = require
L3 = "table"
L2 = L2(L3)
L3 = _G
L4 = module
L5 = "json"
L4(L5)
L4, L5, L6, L7, L8, L9, L10, L11, L12, L13 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  if A0 == nil then
    L1 = "null"
    return L1
  end
  L1 = _UPVALUE0_
  L1 = L1.type
  L2 = A0
  L1 = L1(L2)
  if L1 == "string" then
    L2 = "\""
    L3 = _UPVALUE1_
    L4 = A0
    L3 = L3(L4)
    L4 = "\""
    L2 = L2 .. L3 .. L4
    return L2
  end
  if L1 == "number" or L1 == "boolean" then
    L2 = _UPVALUE0_
    L2 = L2.tostring
    L3 = A0
    return L2(L3)
  end
  if L1 == "table" then
    L2 = {}
    L3 = _UPVALUE2_
    L4 = A0
    L3, L4 = L3(L4)
    if L3 then
      for L8 = L5, L6, L7 do
        L9 = _UPVALUE3_
        L9 = L9.insert
        L10 = L2
        L11 = encode
        L12 = A0[L8]
        L11, L12, L13, L14, L15, L16 = L11(L12)
        L9(L10, L11, L12, L13, L14, L15, L16)
      end
    else
      for L8, L9 in L5, L6, L7 do
        L10 = _UPVALUE4_
        L11 = L8
        L10 = L10(L11)
        if L10 then
          L10 = _UPVALUE4_
          L11 = L9
          L10 = L10(L11)
          if L10 then
            L10 = _UPVALUE3_
            L10 = L10.insert
            L11 = L2
            L12 = "\""
            L13 = _UPVALUE1_
            L14 = L8
            L13 = L13(L14)
            L14 = "\":"
            L15 = encode
            L16 = L9
            L15 = L15(L16)
            L12 = L12 .. L13 .. L14 .. L15
            L10(L11, L12)
          end
        end
      end
    end
    if L3 then
      L8 = ","
      return L5
    else
      L8 = ","
      return L5
    end
  end
  if L1 == "function" then
    L2 = null
    if A0 == L2 then
      L2 = "null"
      return L2
    end
  end
  L2 = _UPVALUE0_
  L2 = L2.assert
  L3 = false
  L4 = "encode attempt to encode unsupported type "
  L8 = A0
  L4 = L4 .. L5 .. L6 .. L7
  L2(L3, L4)
end
encode = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7
  A1 = A1 and A1 or A1
  L2 = _UPVALUE0_
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  A1 = L2
  L2 = _UPVALUE1_
  L2 = L2.assert
  L3 = _UPVALUE2_
  L3 = L3.len
  L4 = A0
  L3 = L3(L4)
  L3 = A1 <= L3
  L4 = "Unterminated JSON encoded object found at position in ["
  L5 = A0
  L6 = "]"
  L4 = L4 .. L5 .. L6
  L2(L3, L4)
  L2 = _UPVALUE2_
  L2 = L2.sub
  L3 = A0
  L4 = A1
  L5 = A1
  L2 = L2(L3, L4, L5)
  if L2 == "{" then
    L3 = _UPVALUE3_
    L4 = A0
    L5 = A1
    return L3(L4, L5)
  end
  if L2 == "[" then
    L3 = _UPVALUE4_
    L4 = A0
    L5 = A1
    return L3(L4, L5)
  end
  L3 = _UPVALUE2_
  L3 = L3.find
  L4 = "+-0123456789.e"
  L5 = L2
  L6 = 1
  L7 = true
  L3 = L3(L4, L5, L6, L7)
  if L3 then
    L3 = _UPVALUE5_
    L4 = A0
    L5 = A1
    return L3(L4, L5)
  end
  if L2 == "\"" or L2 == "'" then
    L3 = _UPVALUE6_
    L4 = A0
    L5 = A1
    return L3(L4, L5)
  end
  L3 = _UPVALUE2_
  L3 = L3.sub
  L4 = A0
  L5 = A1
  L6 = A1 + 1
  L3 = L3(L4, L5, L6)
  if L3 == "/*" then
    L3 = decode
    L4 = A0
    L5 = _UPVALUE7_
    L6 = A0
    L7 = A1
    L5, L6, L7 = L5(L6, L7)
    return L3(L4, L5, L6, L7)
  end
  L3 = _UPVALUE8_
  L4 = A0
  L5 = A1
  return L3(L4, L5)
end
decode = L14
function L14()
  local L0, L1
  L0 = null
  return L0
end
null = L14
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.len
  L4 = A0
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.assert
  L5 = _UPVALUE0_
  L5 = L5.sub
  L6 = A0
  L7 = A1
  L8 = A1
  L5 = L5(L6, L7, L8)
  L5 = L5 == "["
  L6 = "decode_scanArray called but array does not start at position "
  L7 = A1
  L8 = " in string:\n"
  L9 = A0
  L6 = L6 .. L7 .. L8 .. L9
  L4(L5, L6)
  A1 = A1 + 1
  repeat
    L4 = _UPVALUE2_
    L5 = A0
    L6 = A1
    L4 = L4(L5, L6)
    A1 = L4
    L4 = _UPVALUE1_
    L4 = L4.assert
    L5 = L3 >= A1
    L6 = "JSON String ended unexpectedly scanning array."
    L4(L5, L6)
    L4 = _UPVALUE0_
    L4 = L4.sub
    L5 = A0
    L6 = A1
    L7 = A1
    L4 = L4(L5, L6, L7)
    if L4 == "]" then
      L5 = L2
      L6 = A1 + 1
      return L5, L6
    end
    if L4 == "," then
      L5 = _UPVALUE2_
      L6 = A0
      L7 = A1 + 1
      L5 = L5(L6, L7)
      A1 = L5
    end
    L5 = _UPVALUE1_
    L5 = L5.assert
    L6 = L3 >= A1
    L7 = "JSON String ended unexpectedly scanning array."
    L5(L6, L7)
    L5 = decode
    L6 = A0
    L7 = A1
    L5, L6 = L5(L6, L7)
    A1 = L6
    object = L5
    L5 = _UPVALUE3_
    L5 = L5.insert
    L6 = L2
    L7 = object
    L5(L6, L7)
    L5 = false
  until L5
end
function L5(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L2 = L2.assert
  L3 = _UPVALUE1_
  L3 = L3.sub
  L4 = A0
  L5 = A1
  L6 = A1 + 1
  L3 = L3(L4, L5, L6)
  L3 = L3 == "/*"
  L4 = "decode_scanComment called but comment does not start at position "
  L5 = A1
  L4 = L4 .. L5
  L2(L3, L4)
  L2 = _UPVALUE1_
  L2 = L2.find
  L3 = A0
  L4 = "*/"
  L5 = A1 + 2
  L2 = L2(L3, L4, L5)
  L3 = _UPVALUE0_
  L3 = L3.assert
  L4 = L2 ~= nil
  L5 = "Unterminated comment in string at "
  L6 = A1
  L5 = L5 .. L6
  L3(L4, L5)
  L3 = L2 + 2
  return L3
end
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = {}
  L2["true"] = true
  L2["false"] = false
  L2.null = nil
  L3 = {}
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  for L7, L8 in L4, L5, L6 do
    L9 = _UPVALUE1_
    L9 = L9.sub
    L10 = A0
    L11 = A1
    L12 = _UPVALUE1_
    L12 = L12.len
    L13 = L8
    L12 = L12(L13)
    L12 = A1 + L12
    L12 = L12 - 1
    L9 = L9(L10, L11, L12)
    if L9 == L8 then
      L9 = L2[L8]
      L10 = _UPVALUE1_
      L10 = L10.len
      L11 = L8
      L10 = L10(L11)
      L10 = A1 + L10
      return L9, L10
    end
  end
  L7 = A0
  L8 = " at starting position "
  L9 = A1
  L4(L5, L6)
end
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = A1 + 1
  L3 = _UPVALUE0_
  L3 = L3.len
  L4 = A0
  L3 = L3(L4)
  L4 = "+-0123456789.e"
  while true do
    L5 = _UPVALUE0_
    L5 = L5.find
    L6 = L4
    L7 = _UPVALUE0_
    L7 = L7.sub
    L8 = A0
    L9 = L2
    L10 = L2
    L7 = L7(L8, L9, L10)
    L8 = 1
    L9 = true
    L5 = L5(L6, L7, L8, L9)
    if not (L5 and L2 <= L3) then
      break
    end
    L2 = L2 + 1
  end
  L5 = "return "
  L6 = _UPVALUE0_
  L6 = L6.sub
  L7 = A0
  L8 = A1
  L9 = L2 - 1
  L6 = L6(L7, L8, L9)
  L5 = L5 .. L6
  L6 = _UPVALUE1_
  L6 = L6.loadstring
  L7 = L5
  L6 = L6(L7)
  L7 = _UPVALUE1_
  L7 = L7.assert
  L8 = L6
  L9 = "Failed to scan number [ "
  L10 = L5
  L11 = "] in JSON string at position "
  L12 = A1
  L13 = " : "
  L14 = L2
  L9 = L9 .. L10 .. L11 .. L12 .. L13 .. L14
  L7(L8, L9)
  L7 = L6
  L7 = L7()
  L8 = L2
  return L7, L8
end
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.len
  L4 = A0
  L3 = L3(L4)
  L4, L5 = nil, nil
  L6 = _UPVALUE1_
  L6 = L6.assert
  L7 = _UPVALUE0_
  L7 = L7.sub
  L8 = A0
  L9 = A1
  L10 = A1
  L7 = L7(L8, L9, L10)
  L7 = L7 == "{"
  L8 = "decode_scanObject called but object does not start at position "
  L9 = A1
  L10 = " in string:\n"
  L11 = A0
  L8 = L8 .. L9 .. L10 .. L11
  L6(L7, L8)
  A1 = A1 + 1
  repeat
    L6 = _UPVALUE2_
    L7 = A0
    L8 = A1
    L6 = L6(L7, L8)
    A1 = L6
    L6 = _UPVALUE1_
    L6 = L6.assert
    L7 = L3 >= A1
    L8 = "JSON string ended unexpectedly while scanning object."
    L6(L7, L8)
    L6 = _UPVALUE0_
    L6 = L6.sub
    L7 = A0
    L8 = A1
    L9 = A1
    L6 = L6(L7, L8, L9)
    if L6 == "}" then
      L7 = L2
      L8 = A1 + 1
      return L7, L8
    end
    if L6 == "," then
      L7 = _UPVALUE2_
      L8 = A0
      L9 = A1 + 1
      L7 = L7(L8, L9)
      A1 = L7
    end
    L7 = _UPVALUE1_
    L7 = L7.assert
    L8 = L3 >= A1
    L9 = "JSON string ended unexpectedly scanning object."
    L7(L8, L9)
    L7 = decode
    L8 = A0
    L9 = A1
    L7, L8 = L7(L8, L9)
    A1 = L8
    L4 = L7
    L7 = _UPVALUE1_
    L7 = L7.assert
    L8 = L3 >= A1
    L9 = "JSON string ended unexpectedly searching for value of key "
    L10 = L4
    L9 = L9 .. L10
    L7(L8, L9)
    L7 = _UPVALUE2_
    L8 = A0
    L9 = A1
    L7 = L7(L8, L9)
    A1 = L7
    L7 = _UPVALUE1_
    L7 = L7.assert
    L8 = L3 >= A1
    L9 = "JSON string ended unexpectedly searching for value of key "
    L10 = L4
    L9 = L9 .. L10
    L7(L8, L9)
    L7 = _UPVALUE1_
    L7 = L7.assert
    L8 = _UPVALUE0_
    L8 = L8.sub
    L9 = A0
    L10 = A1
    L11 = A1
    L8 = L8(L9, L10, L11)
    L8 = L8 == ":"
    L9 = "JSON object key-value assignment mal-formed at "
    L10 = A1
    L9 = L9 .. L10
    L7(L8, L9)
    L7 = _UPVALUE2_
    L8 = A0
    L9 = A1 + 1
    L7 = L7(L8, L9)
    A1 = L7
    L7 = _UPVALUE1_
    L7 = L7.assert
    L8 = L3 >= A1
    L9 = "JSON string ended unexpectedly searching for value of key "
    L10 = L4
    L9 = L9 .. L10
    L7(L8, L9)
    L7 = decode
    L8 = A0
    L9 = A1
    L7, L8 = L7(L8, L9)
    A1 = L8
    L5 = L7
    L2[L4] = L5
    L7 = false
  until L7
end
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L2 = _UPVALUE0_
  L2 = L2.assert
  L3 = A1
  L4 = "decode_scanString(..) called without start position"
  L2(L3, L4)
  L2 = _UPVALUE1_
  L2 = L2.sub
  L3 = A0
  L4 = A1
  L5 = A1
  L2 = L2(L3, L4, L5)
  L3 = _UPVALUE0_
  L3 = L3.assert
  L4 = L2 == "'" or L2 == "\""
  L5 = "decode_scanString called for a non-string"
  L3(L4, L5)
  L3 = false
  L4 = A1 + 1
  L5 = false
  L6 = _UPVALUE1_
  L6 = L6.len
  L7 = A0
  L6 = L6(L7)
  repeat
    L7 = _UPVALUE1_
    L7 = L7.sub
    L8 = A0
    L9 = L4
    L10 = L4
    L7 = L7(L8, L9, L10)
    if not L3 then
      if L7 == "\\" then
        L3 = true
      else
        L5 = L7 == L2
      end
    else
      L3 = false
    end
    L4 = L4 + 1
    L8 = _UPVALUE0_
    L8 = L8.assert
    L9 = L6 + 1
    L9 = L4 <= L9
    L10 = "String decoding failed: unterminated string at position "
    L11 = L4
    L10 = L10 .. L11
    L8(L9, L10)
  until L5
  L7 = "return "
  L8 = _UPVALUE1_
  L8 = L8.sub
  L9 = A0
  L10 = A1
  L11 = L4 - 1
  L8 = L8(L9, L10, L11)
  L7 = L7 .. L8
  L8 = _UPVALUE0_
  L8 = L8.loadstring
  L9 = L7
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.assert
  L10 = L8
  L11 = "Failed to load string [ "
  L12 = L7
  L13 = "] in JSON4Lua.decode_scanString at position "
  L14 = A1
  L15 = " : "
  L16 = L4
  L11 = L11 .. L12 .. L13 .. L14 .. L15 .. L16
  L9(L10, L11)
  L9 = L8
  L9 = L9()
  L10 = L4
  return L9, L10
end
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = " \n\r\t"
  L3 = _UPVALUE0_
  L3 = L3.len
  L4 = A0
  L3 = L3(L4)
  while true do
    L4 = _UPVALUE0_
    L4 = L4.find
    L5 = L2
    L6 = _UPVALUE0_
    L6 = L6.sub
    L7 = A0
    L8 = A1
    L9 = A1
    L6 = L6(L7, L8, L9)
    L7 = 1
    L8 = true
    L4 = L4(L5, L6, L7, L8)
    if not (L4 and A1 <= L3) then
      break
    end
    A1 = A1 + 1
  end
  return A1
end
function L11(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.gsub
  L2 = A0
  L3 = "\\"
  L4 = "\\\\"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = _UPVALUE0_
  L1 = L1.gsub
  L2 = A0
  L3 = "\""
  L4 = "\\\""
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = _UPVALUE0_
  L1 = L1.gsub
  L2 = A0
  L3 = "'"
  L4 = "\\'"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = _UPVALUE0_
  L1 = L1.gsub
  L2 = A0
  L3 = "\n"
  L4 = "\\n"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = _UPVALUE0_
  L1 = L1.gsub
  L2 = A0
  L3 = "\t"
  L4 = "\\t"
  L1 = L1(L2, L3, L4)
  A0 = L1
  return A0
end
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = 0
  for L5, L6 in L2, L3, L4 do
    L7 = _UPVALUE0_
    L7 = L7.type
    L8 = L5
    L7 = L7(L8)
    if L7 == "number" then
      L7 = _UPVALUE1_
      L7 = L7.floor
      L8 = L5
      L7 = L7(L8)
      if L7 == L5 and 1 <= L5 then
        L7 = _UPVALUE2_
        L8 = L6
        L7 = L7(L8)
        if not L7 then
          L7 = false
          return L7
        end
        L7 = _UPVALUE1_
        L7 = L7.max
        L8 = L1
        L9 = L5
        L7 = L7(L8, L9)
        L1 = L7
    end
    elseif L5 == "n" then
      L7 = _UPVALUE3_
      L7 = L7.getn
      L8 = A0
      L7 = L7(L8)
      if L6 ~= L7 then
        L7 = false
        return L7
      end
    else
      L7 = _UPVALUE2_
      L8 = L6
      L7 = L7(L8)
      if L7 then
        L7 = false
        return L7
      end
    end
  end
  return L2, L3
end
function L13(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.type
  L2 = A0
  L1 = L1(L2)
  L2 = L1 == "string" or L1 == "boolean" or L1 == "number" or L1 == "nil" or L1 == "table"
  return L2
end
