local L0, L1, L2, L3, L4
L0 = require
L1 = "slaxml"
L0 = L0(L1)
L1 = require
L2 = "string"
L1 = L1(L2)
L2 = require
L3 = "table"
L2 = L2(L3)
L3 = module
L4 = "slaxdom"
L3(L4)
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  if not A2 then
    L3 = {}
    A2 = L3
  end
  L3 = A2.simple
  L3 = not L3
  L4 = _UPVALUE0_
  L4 = L4.insert
  L5 = _UPVALUE0_
  L5 = L5.remove
  L6 = {}
  L7 = {}
  L7.type = "document"
  L7.name = "#doc"
  L8 = {}
  L7.kids = L8
  L8 = L7
  L9 = _UPVALUE1_
  L10 = L9
  L9 = L9.parser
  L11 = {}
  function L12(A0, A1)
    local L2, L3, L4, L5, L6, L7
    L2 = {}
    L2.type = "element"
    L2.name = A0
    L3 = {}
    L2.kids = L3
    L3 = _UPVALUE0_
    if L3 then
      L3 = {}
      if L3 then
        goto lbl_13
      end
    end
    L3 = nil
    ::lbl_13::
    L2.el = L3
    L3 = {}
    L2.attr = L3
    L2.nsURI = A1
    L3 = _UPVALUE0_
    if L3 then
      L3 = _UPVALUE1_
      if L3 then
        goto lbl_24
      end
    end
    L3 = nil
    ::lbl_24::
    L2.parent = L3
    L3 = _UPVALUE1_
    L4 = _UPVALUE2_
    if L3 == L4 then
      L3 = _UPVALUE2_
      L3 = L3.root
      if L3 then
        L3 = error
        L4 = "Encountered element '%s' when the document already has a root '%s' element"
        L5 = L4
        L4 = L4.format
        L6 = A0
        L7 = _UPVALUE2_
        L7 = L7.root
        L7 = L7.name
        L4, L5, L6, L7 = L4(L5, L6, L7)
        L3(L4, L5, L6, L7)
      end
      L3 = _UPVALUE2_
      L3.root = L2
    end
    L3 = _UPVALUE3_
    L4 = _UPVALUE1_
    L4 = L4.kids
    L5 = L2
    L3(L4, L5)
    L3 = _UPVALUE1_
    L3 = L3.el
    if L3 then
      L3 = _UPVALUE3_
      L4 = _UPVALUE1_
      L4 = L4.el
      L5 = L2
      L3(L4, L5)
    end
    _UPVALUE1_ = L2
    L3 = _UPVALUE3_
    L4 = _UPVALUE4_
    L5 = L2
    L3(L4, L5)
  end
  L11.startElement = L12
  function L12(A0, A1, A2)
    local L3, L4, L5, L6, L7
    L3 = _UPVALUE0_
    if L3 then
      L3 = _UPVALUE0_
      L3 = L3.type
      if L3 == "element" then
        goto lbl_15
      end
    end
    L3 = error
    L4 = "Encountered an attribute %s=%s but I wasn't inside an element"
    L5 = L4
    L4 = L4.format
    L6 = A0
    L7 = A1
    L4, L5, L6, L7 = L4(L5, L6, L7)
    L3(L4, L5, L6, L7)
    ::lbl_15::
    L3 = {}
    L3.type = "attribute"
    L3.name = A0
    L3.nsURI = A2
    L3.value = A1
    L4 = _UPVALUE1_
    if L4 then
      L4 = _UPVALUE0_
      if L4 then
        goto lbl_27
      end
    end
    L4 = nil
    ::lbl_27::
    L3.parent = L4
    L4 = _UPVALUE1_
    if L4 then
      L4 = _UPVALUE0_
      L4 = L4.attr
      L4[A0] = A1
    end
    L4 = _UPVALUE2_
    L5 = _UPVALUE0_
    L5 = L5.attr
    L6 = L3
    L4(L5, L6)
  end
  L11.attribute = L12
  function L12(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = _UPVALUE0_
    L1 = L1.name
    if L1 == A0 then
      L1 = _UPVALUE0_
      L1 = L1.type
      if L1 == "element" then
        goto lbl_19
      end
    end
    L1 = error
    L2 = "Received a close element notification for '%s' but was inside a '%s' %s"
    L3 = L2
    L2 = L2.format
    L4 = A0
    L5 = _UPVALUE0_
    L5 = L5.name
    L6 = _UPVALUE0_
    L6 = L6.type
    L2, L3, L4, L5, L6 = L2(L3, L4, L5, L6)
    L1(L2, L3, L4, L5, L6)
    ::lbl_19::
    L1 = _UPVALUE1_
    L2 = _UPVALUE2_
    L1(L2)
    L1 = _UPVALUE2_
    L2 = _UPVALUE2_
    L2 = #L2
    L1 = L1[L2]
    _UPVALUE0_ = L1
  end
  L11.closeElement = L12
  function L12(A0)
    local L1, L2, L3, L4, L5
    L1 = _UPVALUE0_
    L1 = L1.type
    if L1 ~= "document" then
      L1 = _UPVALUE0_
      L1 = L1.type
      if L1 ~= "element" then
        L1 = error
        L2 = "Received a text notification '%s' but was inside a %s"
        L3 = L2
        L2 = L2.format
        L4 = A0
        L5 = _UPVALUE0_
        L5 = L5.type
        L2, L3, L4, L5 = L2(L3, L4, L5)
        L1(L2, L3, L4, L5)
      end
      L1 = _UPVALUE1_
      L2 = _UPVALUE0_
      L2 = L2.kids
      L3 = {}
      L3.type = "text"
      L3.name = "#text"
      L3.value = A0
      L4 = _UPVALUE2_
      if L4 then
        L4 = _UPVALUE0_
        if L4 then
          goto lbl_31
        end
      end
      L4 = nil
      ::lbl_31::
      L3.parent = L4
      L1(L2, L3)
    end
  end
  L11.text = L12
  function L12(A0)
    local L1, L2, L3, L4
    L1 = _UPVALUE0_
    L2 = _UPVALUE1_
    L2 = L2.kids
    L3 = {}
    L3.type = "comment"
    L3.name = "#comment"
    L3.value = A0
    L4 = _UPVALUE2_
    if L4 then
      L4 = _UPVALUE1_
      if L4 then
        goto lbl_15
      end
    end
    L4 = nil
    ::lbl_15::
    L3.parent = L4
    L1(L2, L3)
  end
  L11.comment = L12
  function L12(A0, A1)
    local L2, L3, L4, L5
    L2 = _UPVALUE0_
    L3 = _UPVALUE1_
    L3 = L3.kids
    L4 = {}
    L4.type = "pi"
    L4.name = A0
    L4.value = A1
    L5 = _UPVALUE2_
    if L5 then
      L5 = _UPVALUE1_
      if L5 then
        goto lbl_15
      end
    end
    L5 = nil
    ::lbl_15::
    L4.parent = L5
    L2(L3, L4)
  end
  L11.pi = L12
  L9 = L9(L10, L11)
  L11 = L9
  L10 = L9.parse
  L12 = A1
  L13 = A2
  L10(L11, L12, L13)
  return L7
end
L0.dom = L3
return L0
