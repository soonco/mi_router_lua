local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
L0 = _G
L1 = require
L2 = "ltn12"
L1 = L1(L2)
L2 = require
L3 = "mime.core"
L2 = L2(L3)
L3 = require
L4 = "io"
L3 = L3(L4)
L4 = require
L5 = "string"
L4 = L4(L5)
L5 = L2
L6 = {}
L7 = {}
L8 = {}
L5.encodet = L6
L5.decodet = L7
L5.wrapt = L8
function L9(A0)
  local L1
  function L1(A0, A1, A2)
    local L3, L4, L5, L6, L7
    L3 = _UPVALUE0_
    L3 = L3.type
    L4 = A0
    L3 = L3(L4)
    if L3 ~= "string" then
      L3 = "default"
      L4 = A0
      A2 = A1
      A1 = L4
      A0 = L3
    end
    L3 = _UPVALUE1_
    L4 = A0 or L4
    if not A0 then
      L4 = "nil"
    end
    L3 = L3[L4]
    if not L3 then
      L4 = _UPVALUE0_
      L4 = L4.error
      L5 = "unknown key ("
      L6 = _UPVALUE0_
      L6 = L6.tostring
      L7 = A0
      L6 = L6(L7)
      L7 = ")"
      L5 = L5 .. L6 .. L7
      L6 = 3
      L4(L5, L6)
    else
      L4 = L3
      L5 = A1
      L6 = A2
      return L4(L5, L6)
    end
  end
  return L1
end
function L10()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.filter
  L0 = L0.cycle
  L1 = _UPVALUE1_
  L1 = L1.b64
  L2 = ""
  return L0(L1, L2)
end
L6.base64 = L10
function L10(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.filter
  L1 = L1.cycle
  L2 = _UPVALUE1_
  L2 = L2.qp
  L3 = ""
  if A0 == "binary" then
    L4 = "=0D=0A"
    if L4 then
      goto lbl_13
    end
  end
  L4 = "\r\n"
  ::lbl_13::
  return L1(L2, L3, L4)
end
L6["quoted-printable"] = L10
function L10()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.filter
  L0 = L0.cycle
  L1 = _UPVALUE1_
  L1 = L1.unb64
  L2 = ""
  return L0(L1, L2)
end
L7.base64 = L10
function L10()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.filter
  L0 = L0.cycle
  L1 = _UPVALUE1_
  L1 = L1.unqp
  L2 = ""
  return L0(L1, L2)
end
L7["quoted-printable"] = L10
function L10(A0)
  local L1, L2
  if A0 then
    if A0 == "" then
      L1 = "''"
      return L1
    else
      L1 = _UPVALUE0_
      L1 = L1.len
      L2 = A0
      return L1(L2)
    end
  else
    L1 = "nil"
    return L1
  end
end
function L11(A0)
  local L1, L2, L3, L4
  A0 = A0 or A0
  L1 = _UPVALUE0_
  L1 = L1.filter
  L1 = L1.cycle
  L2 = _UPVALUE1_
  L2 = L2.wrp
  L3 = A0
  L4 = A0
  return L1(L2, L3, L4)
end
L8.text = L11
L11 = L8.text
L8.base64 = L11
L11 = L8.text
L8.default = L11
function L11()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L0 = L0.filter
  L0 = L0.cycle
  L1 = _UPVALUE1_
  L1 = L1.qpwrp
  L2 = 76
  L3 = 76
  return L0(L1, L2, L3)
end
L8["quoted-printable"] = L11
L11 = L9
L12 = L6
L11 = L11(L12)
L5.encode = L11
L11 = L9
L12 = L7
L11 = L11(L12)
L5.decode = L11
L11 = L9
L12 = L8
L11 = L11(L12)
L5.wrap = L11
function L11(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.filter
  L1 = L1.cycle
  L2 = _UPVALUE1_
  L2 = L2.eol
  L3 = 0
  L4 = A0
  return L1(L2, L3, L4)
end
L5.normalize = L11
function L11()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.filter
  L0 = L0.cycle
  L1 = _UPVALUE1_
  L1 = L1.dot
  L2 = 2
  return L0(L1, L2)
end
L5.stuff = L11
return L5
