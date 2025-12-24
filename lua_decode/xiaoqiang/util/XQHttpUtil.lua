local L0, L1, L2, L3
L0 = module
L1 = "xiaoqiang.util.XQHttpUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.XQLog"
L1 = L1(L2)
L2 = require
L3 = "cURL"
L2 = L2(L3)
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L3 = _UPVALUE0_
  L3 = L3.easy
  L3 = L3()
  L4 = ""
  L5 = {}
  L6 = {}
  L7 = {}
  L7.code = 0
  L7.headers = ""
  L7.status = ""
  L7.res = ""
  L8 = false
  L9 = ""
  if A2 then
    if L10 == "table" then
      L4 = ""
      for L13, L14 in L10, L11, L12 do
        L15 = L4
        L16 = L13
        L17 = "="
        L18 = L14
        L19 = ";path=/;domain=.xiaomi.com;"
        L4 = L15 .. L16 .. L17 .. L18 .. L19
      end
    end
  end
  if not L10 then
    L13 = "?"
    if L11 then
      A0 = L10
    else
      L13 = A1
      A0 = L11 .. L12 .. L13
    end
  end
  if not L10 then
    L10(L11, L12)
  end
  L10(L11, L12)
  L13 = L5
  L10(L11, L12, L13)
  L13 = L6
  L10(L11, L12, L13)
  L9 = L11
  L8 = L10
  if true == L8 then
    L7.code = L10
    L7.res = L10
    L13 = -3
    L7.status = L10
    L7.headers = L6
  else
    L7.status = L9
  end
  L10(L11)
  L10(L11, L12)
  return L7
end
httpGetRequest = L3
function L3(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L4 = _UPVALUE0_
  L4 = L4.easy
  L4 = L4()
  L5 = ""
  L6 = {}
  L7 = {}
  L8 = {}
  L9 = {}
  L9.code = ""
  L9.res = ""
  L10 = false
  L11 = ""
  if A2 then
    if L12 == "table" then
      L5 = ""
      for L15, L16 in L12, L13, L14 do
        L17 = L5
        L18 = L15
        L19 = "="
        L20 = L16
        L21 = ";path=/;domain=.xiaomi.com;"
        L5 = L17 .. L18 .. L19 .. L20 .. L21
      end
    end
  end
  if not L12 then
    L15 = A3
    L12(L13, L14)
  end
  if not L12 then
    L12(L13, L14)
  end
  L12(L13, L14)
  L12(L13, L14)
  L12(L13, L14)
  L12(L13, L14)
  L15 = L7
  L12(L13, L14, L15)
  L15 = L8
  L12(L13, L14, L15)
  L11 = L13
  L10 = L12
  if true == L10 then
    L9.code = L12
    L9.res = L12
    L15 = -3
    L9.status = L12
    L9.headers = L8
  else
    L9.status = L11
  end
  L12(L13)
  L12(L13, L14)
  return L9
end
httpPostRequest = L3
