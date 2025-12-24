local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50
L0 = module
L1 = "xssFilter"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = pcall
L1 = require
L2 = "iconv"
L0, L1 = L0(L1, L2)
function L2(A0, A1, A2, A3)
  local L4, L5, L6, L7
  L4 = "<code>[HTML tag &lt;"
  L5 = A1
  L6 = "&gt; removed"
  L4 = L4 .. L5 .. L6
  if A2 then
    L5 = L4
    L6 = ": "
    L7 = A2
    L4 = L5 .. L6 .. L7
  end
  L5 = L4
  L6 = "]</code>"
  L5 = L5 .. L6
  return L5
end
REPLACE_TAGS = L2
function L2(A0, A1, A2, A3)
  return A3
end
REMOVE_TAGS = L2
L2 = {}
L3 = "p"
L4 = "h1"
L5 = "h2"
L6 = "h3"
L7 = "h4"
L8 = "h5"
L9 = "h6"
L10 = "ul"
L11 = "ol"
L12 = "li"
L13 = "dl"
L14 = "dt"
L15 = "dd"
L16 = "br"
L17 = "em"
L18 = "strong"
L19 = "i"
L20 = "b"
L21 = "blockquote"
L22 = "pre"
L23 = "code"
L24 = "acronym"
L25 = "abbr"
L26 = "cite"
L27 = "dfn"
L28 = "tt"
L29 = "del"
L30 = "ins"
L31 = "kbd"
L32 = "strike"
L33 = "sub"
L34 = "sup"
L35 = "var"
L36 = "table"
L37 = "tr"
L38 = "thead"
L39 = "caption"
L40 = "tbody"
L41 = "tfoot"
L42 = "big"
L43 = "center"
L44 = "right"
L45 = "left"
L46 = "hr"
L47 = "style"
L48 = "div"
L49 = {}
L49.style = "."
function L50(A0)
  local L1, L2, L3
  L1 = A0.xarg
  L1 = L1.style
  if L1 then
    L1 = A0.xarg
    L1 = L1.style
    L2 = L1
    L1 = L1.find
    L3 = "url"
    L1 = L1(L2, L3)
    if L1 then
      goto lbl_15
    end
  end
  L1 = true
  do return L1 end
  goto lbl_18
  ::lbl_15::
  L1 = nil
  L2 = "'url' not allowed in the value of 'style'"
  do return L1, L2 end
  ::lbl_18::
end
L49._test = L50
L2.span = L49
L49 = {}
L49.colspan = "."
L49.rowspan = "."
L2.th = L49
L49 = {}
L49.colspan = "."
L49.rowspan = "."
L2.td = L49
L2[1] = L3
L2[2] = L4
L2[3] = L5
L2[4] = L6
L2[5] = L7
L2[6] = L8
L2[7] = L9
L2[8] = L10
L2[9] = L11
L2[10] = L12
L2[11] = L13
L2[12] = L14
L2[13] = L15
L2[14] = L16
L2[15] = L17
L2[16] = L18
L2[17] = L19
L2[18] = L20
L2[19] = L21
L2[20] = L22
L2[21] = L23
L2[22] = L24
L2[23] = L25
L2[24] = L26
L2[25] = L27
L2[26] = L28
L2[27] = L29
L2[28] = L30
L2[29] = L31
L2[30] = L32
L2[31] = L33
L2[32] = L34
L2[33] = L35
L2[34] = L36
L2[35] = L37
L2[36] = L38
L2[37] = L39
L2[38] = L40
L2[39] = L41
L2[40] = L42
L2[41] = L43
L2[42] = L44
L2[43] = L45
L2[44] = L46
L2[45] = L47
L2[46] = L48
ALLOWED_TAGS = L2
L2 = {}
L3 = {}
L3.data = "http://"
function L4(A0)
  local L1, L2
  L1 = A0.xarg
  L1 = L1.type
  if L1 == "image/svg+xml" then
    L1 = true
    return L1
  else
    L1 = false
    L2 = "only 'image/svg+xml' is allowed for 'type'"
    return L1, L2
  end
end
L3._test = L4
L2.object = L3
EXTRA_TAGS = L2
L2 = {}
L2.class = "."
L2.alt = "."
L2.title = "."
GENERIC_ATTRIBUTES = L2
L2 = {}
L3 = {}
L4 = {}
L3.__metatable = L4
L3.__index = L2
function L4(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = setmetatable
  L4 = {}
  L5 = _UPVALUE0_
  L3 = L3(L4, L5)
  L5 = L3
  L4 = L3.init
  L6 = A0
  L4(L5, L6)
  L4 = _UPVALUE1_
  if L4 then
    L4 = _UPVALUE2_
    L4 = L4.new
    L5 = "UTF8"
    L6 = "UTF8"
    L4 = L4(L5, L6)
    L3.utf8_converter = L4
  end
  L4 = A2 or L4
  if not A2 then
    L4 = REPLACE_TAGS
  end
  L3.tags_handler = L4
  return L3
end
new = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  if not A1 then
  end
  A0.allowed_tags = L3
  for L6, L7 in L3, L4, L5 do
    L8 = A0.allowed_tags
    L9 = A0.allowed_tags
    L9 = L9[L7]
    L9 = L9 or L9
    L8[L7] = L9
  end
  if not A2 then
  end
  A0.generic_attributes = L3
end
L2.init = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  function L1(A0)
    local L1, L2, L3, L4, L5
    L1 = {}
    L2 = string
    L2 = L2.gsub
    L3 = A0
    L4 = "(%w+)=([\"'])(.-)%2"
    function L5(A0, A1, A2)
      local L3
      L3 = _UPVALUE0_
      L3[A0] = A2
    end
    L2(L3, L4, L5)
    return L1
  end
  L2 = {}
  L3 = {}
  L4 = table
  L4 = L4.insert
  L5 = L2
  L6 = L3
  L4(L5, L6)
  L4, L5, L6, L7, L8 = nil, nil, nil, nil, nil
  L9 = 1
  L10 = 1
  while true do
    L11 = string
    L11 = L11.find
    L12 = A0
    L13 = "<(%/?)(%w+)(.-)(%/?)>"
    L14 = L9
    L11, L12, L13, L14, L15, L16 = L11(L12, L13, L14)
    L8 = L16
    L7 = L15
    L6 = L14
    L5 = L13
    L10 = L12
    L4 = L11
    if not L4 then
      break
    end
    L11 = string
    L11 = L11.sub
    L12 = A0
    L13 = L9
    L14 = L4 - 1
    L11 = L11(L12, L13, L14)
    L12 = table
    L12 = L12.insert
    L13 = L3
    L14 = L11
    L12(L13, L14)
    if L8 == "/" then
      L12 = table
      L12 = L12.insert
      L13 = L3
      L14 = {}
      L14.label = L6
      L15 = L1
      L16 = L7
      L15 = L15(L16)
      L14.xarg = L15
      L14.empty = 1
      L12(L13, L14)
    elseif L5 == "" then
      L12 = {}
      L12.label = L6
      L13 = L1
      L14 = L7
      L13 = L13(L14)
      L12.xarg = L13
      L3 = L12
      L12 = table
      L12 = L12.insert
      L13 = L2
      L14 = L3
      L12(L13, L14)
    else
      L12 = table
      L12 = L12.remove
      L13 = L2
      L12 = L12(L13)
      L13 = #L2
      L3 = L2[L13]
      L13 = #L2
      if L13 < 1 then
        L13 = error
        L14 = "nothing to close with "
        L15 = L6
        L14 = L14 .. L15
        L13(L14)
      end
      L13 = L12.label
      if L13 ~= L6 then
        L13 = error
        L14 = "trying to close "
        L15 = L12.label
        L16 = " with "
        L17 = L6
        L14 = L14 .. L15 .. L16 .. L17
        L13(L14)
      end
      L13 = table
      L13 = L13.insert
      L14 = L3
      L15 = L12
      L13(L14, L15)
    end
    L9 = L10 + 1
  end
  L11 = string
  L11 = L11.sub
  L12 = A0
  L13 = L9
  L11 = L11(L12, L13)
  L12 = string
  L12 = L12.find
  L13 = L11
  L14 = "^%s*$"
  L12 = L12(L13, L14)
  if not L12 then
    L12 = table
    L12 = L12.insert
    L13 = L2.n
    L13 = L2[L13]
    L14 = L11
    L12(L13, L14)
  end
  L12 = #L2
  if 1 < L12 then
    L12 = error
    L13 = "unclosed "
    L14 = L2.n
    L14 = L2[L14]
    L14 = L14.label
    L13 = L13 .. L14
    L12(L13)
  end
  L12 = L2[1]
  return L12
end
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  A1 = A1 or A1
  if L2 == "string" then
    L2[1] = L3
    A1 = L2
  end
  for L5, L6 in L2, L3, L4 do
    L8 = A0
    L7 = A0.find
    L9 = L6
    L7 = L7(L8, L9)
    if L7 then
      L7 = true
      return L7
    end
  end
end
function L6()
  local L0, L1
  L0 = true
  return L0
end
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = A0.utf8_converter
  if L2 then
    L2 = A0.utf8_converter
    L3 = L2
    L2 = L2.iconv
    L4 = A1
    L2, L3 = L2(L3, L4)
    err = L3
    out = L2
    L2 = err
    if L2 then
      A1 = "[Invalid UTF8 - removed by XSSFilter]"
    end
  end
  L2 = pcall
  L3 = _UPVALUE0_
  L4 = "<xml>"
  L5 = A1
  L6 = "</xml>"
  L4 = L4 .. L5 .. L6
  L2, L3 = L2(L3, L4)
  if not L2 then
    L4 = nil
    L5 = "XSSFilter could not parse (X)HTML:\n"
    L7 = A1
    L6 = A1.gsub
    L8 = "<"
    L9 = "&lt;"
    L6 = L6(L7, L8, L9)
    L7 = L6
    L6 = L6.gsub
    L8 = ">"
    L9 = "&gt;"
    L6 = L6(L7, L8, L9)
    L5 = L5 .. L6
    return L4, L5
  end
  L4 = ""
  function L5(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
    for L4, L5 in L1, L2, L3 do
      L6 = type
      L7 = L5
      L6 = L6(L7)
      if L6 == "string" then
        L6 = _UPVALUE0_
        L7 = L5
        L6 = L6 .. L7
        _UPVALUE0_ = L6
      else
        L6 = type
        L7 = L5
        L6 = L6(L7)
        if L6 == "table" then
          L6 = _UPVALUE1_
          L6 = L6.allowed_tags
          L7 = L5.label
          L6 = L6[L7]
          if not L6 then
            L7 = _UPVALUE0_
            L8 = _UPVALUE1_
            L8 = L8.tags_handler
            L12 = L5[1]
            L8 = L8(L9, L10, L11, L12)
            L7 = L7 .. L8
            _UPVALUE0_ = L7
          else
            L7 = L6._test
            L7 = L7 or L7
            L8 = L5
            L7, L8 = L7(L8)
            if not L7 then
              L12 = L5.label
              L13 = L8
              L14 = L5[1]
              _UPVALUE0_ = L9
            else
              _UPVALUE0_ = L9
              for L12, L13 in L9, L10, L11 do
                L14 = L6[L12]
                if not L14 then
                  L14 = _UPVALUE1_
                  L14 = L14.generic_attributes
                  L14 = L14[L12]
                  L14 = L14 or L14
                end
                L15 = _UPVALUE3_
                L16 = L13
                L17 = L14
                L15 = L15(L16, L17)
                if L15 then
                  L15 = _UPVALUE0_
                  L16 = " "
                  L17 = L12
                  L18 = "=\""
                  L20 = L13
                  L19 = L13.gsub
                  L21 = "\""
                  L22 = "&quot;"
                  L19 = L19(L20, L21, L22)
                  L20 = "\""
                  L15 = L15 .. L16 .. L17 .. L18 .. L19 .. L20
                  _UPVALUE0_ = L15
                end
              end
              if L9 then
                _UPVALUE0_ = L9
              else
                _UPVALUE0_ = L9
                L9(L10)
                L12 = ">"
                _UPVALUE0_ = L9
              end
            end
          end
        else
          L6 = error
          L7 = "XSSFilter: Unexpected type of field in parsed XML"
          L6(L7)
        end
      end
    end
  end
  xml2string = L5
  L5 = xml2string
  L6 = L3[2]
  L5(L6)
  return L4
end
L2.filter = L7
function L7(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8
  L5 = A0
  L4 = A0.tags_handler
  L6 = A1
  L7 = A2
  L8 = A3
  L4, L5 = L4(L5, L6, L7, L8)
  if not L4 then
    L6 = error
    L7 = L5
    L6(L7)
  end
  L6 = L4 or L6
  if not L4 then
    L6 = ""
  end
  return L6
end
L2.call_tags_handler = L7
