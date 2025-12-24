local L0, L1, L2, L3, L4, L5
L0 = require
L1 = "string"
L0 = L0(L1)
L1 = require
L2 = "table"
L1 = L1(L2)
L2 = _G
L3 = module
L4 = "slaxml"
L3(L4)
L3 = {}
L3.VERSION = "0.5.1"
L4 = {}
function L5(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = print
  L3 = _UPVALUE0_
  L3 = L3.format
  L4 = "<?%s %s?>"
  L5 = A0
  L6 = A1
  L3, L4, L5, L6 = L3(L4, L5, L6)
  L2(L3, L4, L5, L6)
end
L4.pi = L5
function L5(A0)
  local L1, L2, L3, L4
  L1 = print
  L2 = _UPVALUE0_
  L2 = L2.format
  L3 = "<!-- %s -->"
  L4 = A0
  L2, L3, L4 = L2(L3, L4)
  L1(L2, L3, L4)
end
L4.comment = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = print
  L3 = _UPVALUE0_
  L3 = L3.format
  L4 = "<%s%s>"
  L5 = A0
  if A1 then
    L6 = " ("
    L7 = A1
    L8 = ")"
    L6 = L6 .. L7 .. L8
    if L6 then
      goto lbl_15
    end
  end
  L6 = ""
  ::lbl_15::
  L3, L4, L5, L6, L7, L8 = L3(L4, L5, L6)
  L2(L3, L4, L5, L6, L7, L8)
end
L4.startElement = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = print
  L4 = _UPVALUE0_
  L4 = L4.format
  L5 = "  %s=%q%s"
  L6 = A0
  L7 = A1
  if A2 then
    L8 = " ("
    L9 = A2
    L10 = ")"
    L8 = L8 .. L9 .. L10
    if L8 then
      goto lbl_16
    end
  end
  L8 = ""
  ::lbl_16::
  L4, L5, L6, L7, L8, L9, L10 = L4(L5, L6, L7, L8)
  L3(L4, L5, L6, L7, L8, L9, L10)
end
L4.attribute = L5
function L5(A0)
  local L1, L2, L3, L4
  L1 = print
  L2 = _UPVALUE0_
  L2 = L2.format
  L3 = "  text: %q"
  L4 = A0
  L2, L3, L4 = L2(L3, L4)
  L1(L2, L3, L4)
end
L4.text = L5
function L5(A0, A1)
  local L2, L3, L4, L5
  L2 = print
  L3 = _UPVALUE0_
  L3 = L3.format
  L4 = "</%s>"
  L5 = A0
  L3, L4, L5 = L3(L4, L5)
  L2(L3, L4, L5)
end
L4.closeElement = L5
L3._call = L4
function L4(A0, A1)
  local L2, L3
  L2 = {}
  L3 = A1 or L3
  if not A1 then
    L3 = A0._call
  end
  L2._call = L3
  L3 = _UPVALUE0_
  L3 = L3.parse
  L2.parse = L3
  return L2
end
L3.parser = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38
  if not A2 then
    L3 = {}
    L3.stripWhitespace = false
    A2 = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.find
  L4 = _UPVALUE0_
  L4 = L4.sub
  L5 = _UPVALUE0_
  L5 = L5.gsub
  L6 = _UPVALUE0_
  L6 = L6.char
  L7 = _UPVALUE1_
  L7 = L7.insert
  L8 = _UPVALUE1_
  L8 = L8.remove
  L9, L10, L11, L12, L13, L14, L15 = nil, nil, nil, nil, nil, nil, nil
  L16 = 1
  L17 = "text"
  L18 = 1
  L19 = {}
  L20 = {}
  L21 = nil
  L22 = {}
  L23 = {}
  L23.lt = "<"
  L23.gt = ">"
  L23.amp = "&"
  L23.quot = "\""
  L23.apos = "'"
  function L24(A0, A1, A2)
    local L3, L4
    L3 = _UPVALUE0_
    L3 = L3[A2]
    if not L3 then
      if A1 == "#" then
        L3 = _UPVALUE1_
        L4 = A2
        L3 = L3(L4)
        if L3 then
          goto lbl_13
        end
      end
      L3 = A0
    end
    ::lbl_13::
    return L3
  end
  function L25(A0)
    local L1, L2, L3, L4
    L1 = _UPVALUE0_
    L2 = A0
    L3 = "(&(#?)([%d%a]+);)"
    L4 = _UPVALUE1_
    return L1(L2, L3, L4)
  end
  function L26()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE0_
    L1 = _UPVALUE1_
    if L0 > L1 then
      L0 = _UPVALUE2_
      L0 = L0._call
      L0 = L0.text
      if L0 then
        L0 = _UPVALUE3_
        L1 = _UPVALUE4_
        L2 = _UPVALUE1_
        L3 = _UPVALUE0_
        L3 = L3 - 1
        L0 = L0(L1, L2, L3)
        L1 = _UPVALUE5_
        L1 = L1.stripWhitespace
        if L1 then
          L1 = _UPVALUE6_
          L2 = L0
          L3 = "^%s+"
          L4 = ""
          L1 = L1(L2, L3, L4)
          L0 = L1
          L1 = _UPVALUE6_
          L2 = L0
          L3 = "%s+$"
          L4 = ""
          L1 = L1(L2, L3, L4)
          L0 = L1
          L1 = #L0
          if L1 == 0 then
            L0 = nil
          end
        end
        if L0 then
          L1 = _UPVALUE2_
          L1 = L1._call
          L1 = L1.text
          L2 = _UPVALUE7_
          L3 = L0
          L2, L3, L4 = L2(L3)
          L1(L2, L3, L4)
        end
      end
    end
  end
  function L27()
    local L0, L1, L2, L3
    L0 = _UPVALUE4_
    L1 = _UPVALUE5_
    L2 = "^<%?([:%a_][:%w_.-]*) ?(.-)%?>"
    L3 = _UPVALUE6_
    L0, L1, L2, L3 = L0(L1, L2, L3)
    _UPVALUE3_ = L3
    _UPVALUE2_ = L2
    _UPVALUE1_ = L1
    _UPVALUE0_ = L0
    L0 = _UPVALUE0_
    if L0 then
      L0 = _UPVALUE7_
      L0()
      L0 = _UPVALUE8_
      L0 = L0._call
      L0 = L0.pi
      if L0 then
        L0 = _UPVALUE8_
        L0 = L0._call
        L0 = L0.pi
        L1 = _UPVALUE2_
        L2 = _UPVALUE3_
        L0(L1, L2)
      end
      L0 = _UPVALUE1_
      L0 = L0 + 1
      _UPVALUE6_ = L0
      L0 = _UPVALUE6_
      _UPVALUE9_ = L0
      L0 = true
      return L0
    end
  end
  function L28()
    local L0, L1, L2, L3
    L0 = _UPVALUE3_
    L1 = _UPVALUE4_
    L2 = "^<!%-%-(.-)%-%->"
    L3 = _UPVALUE5_
    L0, L1, L2 = L0(L1, L2, L3)
    _UPVALUE2_ = L2
    _UPVALUE1_ = L1
    _UPVALUE0_ = L0
    L0 = _UPVALUE0_
    if L0 then
      L0 = _UPVALUE6_
      L0()
      L0 = _UPVALUE7_
      L0 = L0._call
      L0 = L0.comment
      if L0 then
        L0 = _UPVALUE7_
        L0 = L0._call
        L0 = L0.comment
        L1 = _UPVALUE2_
        L0(L1)
      end
      L0 = _UPVALUE1_
      L0 = L0 + 1
      _UPVALUE5_ = L0
      L0 = _UPVALUE5_
      _UPVALUE8_ = L0
      L0 = true
      return L0
    end
  end
  function L29(A0)
    local L1, L2, L3, L4, L5
    for L4 = L1, L2, L3 do
      L5 = _UPVALUE0_
      L5 = L5[L4]
      L5 = L5[A0]
      if L5 then
        L5 = _UPVALUE0_
        L5 = L5[L4]
        L5 = L5[A0]
        return L5
      end
    end
    L4 = A0
    L4, L5 = L2(L3, L4)
    L1(L2, L3, L4, L5)
  end
  function L30()
    local L0, L1, L2, L3, L4, L5
    L3 = _UPVALUE5_
    _UPVALUE2_ = L2
    _UPVALUE1_ = L1
    _UPVALUE0_ = L0
    if L0 then
      L0[2] = nil
      L0()
      _UPVALUE5_ = L0
      L3 = _UPVALUE5_
      _UPVALUE8_ = L2
      _UPVALUE1_ = L1
      _UPVALUE0_ = L0
      if L0 then
        L0[1] = L1
        L0[2] = L1
        _UPVALUE2_ = L0
        _UPVALUE5_ = L0
      else
        L0[1] = L1
        for L3 = L0, L1, L2 do
          L4 = _UPVALUE10_
          L4 = L4[L3]
          L4 = L4["!"]
          if L4 then
            L4 = _UPVALUE6_
            L5 = _UPVALUE10_
            L5 = L5[L3]
            L5 = L5["!"]
            L4[2] = L5
            break
          end
        end
      end
      _UPVALUE11_ = L0
      L0(L1, L2)
      return L0
    end
  end
  function L31()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE3_
    L1 = _UPVALUE4_
    L2 = "^%s+([:%a_][:%w_.-]*)%s*=%s*"
    L3 = _UPVALUE5_
    L0, L1, L2 = L0(L1, L2, L3)
    _UPVALUE2_ = L2
    _UPVALUE1_ = L1
    _UPVALUE0_ = L0
    L0 = _UPVALUE0_
    if L0 then
      L0 = _UPVALUE1_
      L0 = L0 + 1
      _UPVALUE6_ = L0
      L0 = _UPVALUE3_
      L1 = _UPVALUE4_
      L2 = "^\"([^<\"]*)\""
      L3 = _UPVALUE6_
      L0, L1, L2 = L0(L1, L2, L3)
      _UPVALUE7_ = L2
      _UPVALUE1_ = L1
      _UPVALUE0_ = L0
      L0 = _UPVALUE0_
      if L0 then
        L0 = _UPVALUE1_
        L0 = L0 + 1
        _UPVALUE5_ = L0
        L0 = _UPVALUE8_
        L1 = _UPVALUE7_
        L0 = L0(L1)
        _UPVALUE7_ = L0
      else
        L0 = _UPVALUE3_
        L1 = _UPVALUE4_
        L2 = "^'([^<']*)'"
        L3 = _UPVALUE6_
        L0, L1, L2 = L0(L1, L2, L3)
        _UPVALUE7_ = L2
        _UPVALUE1_ = L1
        _UPVALUE0_ = L0
        L0 = _UPVALUE0_
        if L0 then
          L0 = _UPVALUE1_
          L0 = L0 + 1
          _UPVALUE5_ = L0
          L0 = _UPVALUE8_
          L1 = _UPVALUE7_
          L0 = L0(L1)
          _UPVALUE7_ = L0
        end
      end
    end
    L0 = _UPVALUE2_
    if L0 then
      L0 = _UPVALUE7_
      if L0 then
        L0 = {}
        L1 = _UPVALUE2_
        L2 = _UPVALUE7_
        L0[1] = L1
        L0[2] = L2
        L1 = _UPVALUE9_
        L1 = L1.match
        L2 = _UPVALUE2_
        L3 = "^([^:]+):([^:]+)$"
        L1, L2 = L1(L2, L3)
        if L1 then
          if L1 == "xmlns" then
            L3 = _UPVALUE10_
            L4 = _UPVALUE10_
            L4 = #L4
            L3 = L3[L4]
            L4 = _UPVALUE7_
            L3[L2] = L4
          else
            L0[1] = L2
            L3 = _UPVALUE11_
            L4 = L1
            L3 = L3(L4)
            L0[3] = L3
          end
        else
          L3 = _UPVALUE2_
          if L3 == "xmlns" then
            L3 = _UPVALUE10_
            L4 = _UPVALUE10_
            L4 = #L4
            L3 = L3[L4]
            L4 = _UPVALUE7_
            L3["!"] = L4
            L3 = _UPVALUE12_
            L4 = _UPVALUE7_
            L3[2] = L4
          end
        end
        L3 = _UPVALUE13_
        L3 = L3 + 1
        _UPVALUE13_ = L3
        L3 = _UPVALUE14_
        L4 = _UPVALUE13_
        L3[L4] = L0
        L3 = true
        return L3
      end
    end
  end
  function L32()
    local L0, L1, L2, L3
    L0 = _UPVALUE3_
    L1 = _UPVALUE4_
    L2 = "^<!%[CDATA%[(.-)%]%]>"
    L3 = _UPVALUE5_
    L0, L1, L2 = L0(L1, L2, L3)
    _UPVALUE2_ = L2
    _UPVALUE1_ = L1
    _UPVALUE0_ = L0
    L0 = _UPVALUE0_
    if L0 then
      L0 = _UPVALUE6_
      L0()
      L0 = _UPVALUE7_
      L0 = L0._call
      L0 = L0.text
      if L0 then
        L0 = _UPVALUE7_
        L0 = L0._call
        L0 = L0.text
        L1 = _UPVALUE2_
        L0(L1)
      end
      L0 = _UPVALUE1_
      L0 = L0 + 1
      _UPVALUE5_ = L0
      L0 = _UPVALUE5_
      _UPVALUE8_ = L0
      L0 = true
      return L0
    end
  end
  function L33()
    local L0, L1, L2, L3, L4, L5, L6
    L3 = _UPVALUE5_
    _UPVALUE2_ = L2
    _UPVALUE1_ = L1
    _UPVALUE0_ = L0
    if L0 then
      _UPVALUE6_ = L0
      _UPVALUE5_ = L0
      _UPVALUE7_ = L0
      if L0 then
        L3, L4, L5, L6 = L1(L2)
        L0(L1, L2, L3, L4, L5, L6)
      end
      if L0 then
        for L3 = L0, L1, L2 do
          L4 = _UPVALUE8_
          L4 = L4._call
          L4 = L4.attribute
          L5 = _UPVALUE9_
          L5 = L5.unpack
          L6 = _UPVALUE12_
          L6 = L6[L3]
          L5, L6 = L5(L6)
          L4(L5, L6)
        end
      end
      if L0 == "/" then
        L0(L1)
        if L0 then
          L3, L4, L5, L6 = L1(L2)
          L0(L1, L2, L3, L4, L5, L6)
        end
      end
      return L0
    end
  end
  function L34()
    local L0, L1, L2, L3, L4
    L3 = _UPVALUE6_
    L3 = L0(L1, L2, L3)
    _UPVALUE3_ = L3
    _UPVALUE2_ = L2
    _UPVALUE1_ = L1
    _UPVALUE0_ = L0
    if L0 then
      _UPVALUE7_ = L0
      for L3 = L0, L1, L2 do
        L4 = _UPVALUE8_
        L4 = L4[L3]
        L4 = L4["!"]
        if L4 then
          L4 = _UPVALUE8_
          L4 = L4[L3]
          L4 = L4["!"]
          _UPVALUE7_ = L4
          break
        end
      end
    else
      L3 = _UPVALUE6_
      L3 = L0(L1, L2, L3)
      _UPVALUE2_ = L3
      _UPVALUE3_ = L2
      _UPVALUE1_ = L1
      _UPVALUE0_ = L0
      if L0 then
        _UPVALUE7_ = L0
      end
    end
    if L0 then
      L0()
      if L0 then
        L0(L1, L2)
      end
      _UPVALUE6_ = L0
      _UPVALUE12_ = L0
      L0(L1)
      return L0
    end
  end
  while true do
    L35 = #A1
    if not (L16 < L35) then
      break
    end
    if L17 == "text" then
      L35 = L27
      L35 = L35()
      if not L35 then
        L35 = L28
        L35 = L35()
        if not L35 then
          L35 = L32
          L35 = L35()
          if not L35 then
            L35 = L34
            L35 = L35()
            if not L35 then
              L35 = L30
              L35 = L35()
              if L35 then
                L17 = "attributes"
              else
                L35 = L3
                L36 = A1
                L37 = "^[^<]+"
                L38 = L16
                L35, L36 = L35(L36, L37, L38)
                L10 = L36
                L9 = L35
                L35 = L10 or L35
                if not L9 or not L10 then
                  L35 = L16
                end
                L16 = L35 + 1
              end
            end
          end
        end
      end
    elseif L17 == "attributes" then
      L35 = L31
      L35 = L35()
      if not L35 then
        L35 = L33
        L35 = L35()
        if not L35 then
          L35 = error
          L36 = "Was in an element and couldn't find attributes or the close."
          L35(L36)
        end
      end
    end
  end
end
L3.parse = L4
return L3
