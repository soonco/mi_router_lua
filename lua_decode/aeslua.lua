local L0, L1, L2, L3, L4
L0 = module
L1 = "aeslua"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = {}
L1 = {}
aeslua = L1
L2 = require
L3 = "aeslua.ciphermode"
L2 = L2(L3)
L3 = require
L4 = "aeslua.util"
L3 = L3(L4)
L1.AES128 = 16
L1.AES192 = 24
L1.AES256 = 32
L1.ECBMODE = 1
L1.CBCMODE = 2
L1.OFBMODE = 3
L1.CFBMODE = 4
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = A1
  L3 = _UPVALUE0_
  L3 = L3.AES192
  if A1 == L3 then
    L2 = 32
  end
  L3 = #A0
  if L2 > L3 then
    L3 = ""
    for L7 = L4, L5, L6 do
      L8 = L3
      L9 = string
      L9 = L9.char
      L10 = 0
      L9 = L9(L10)
      L3 = L8 .. L9
    end
    A0 = L4 .. L5
  else
    L3 = string
    L3 = L3.sub
    L3 = L3(L4, L5, L6)
    A0 = L3
  end
  L3 = {}
  L7 = #A0
  L7, L8, L9, L10 = L4(L5, L6, L7)
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L3[4] = L7
  L3[5] = L8
  L3[6] = L9
  L3[7] = L10
  L7 = _UPVALUE1_
  L7 = L7.encryptCBC
  A0 = L4
  L7 = A1
  A0 = L4
  L7 = 1
  L8 = #A0
  L7, L8, L9, L10 = L5(L6, L7, L8)
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  L4[5] = L9
  L4[6] = L10
  return L4
end
L0.pwToKey = L4
function L4(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11
  L4 = assert
  L5 = A0 ~= nil
  L6 = "Empty password."
  L4(L5, L6)
  L4 = assert
  L5 = A0 ~= nil
  L6 = "Empty data."
  L4(L5, L6)
  L4 = A3 or L4
  if not A3 then
    L4 = _UPVALUE0_
    L4 = L4.CBCMODE
  end
  L5 = A2 or L5
  if not A2 then
    L5 = _UPVALUE0_
    L5 = L5.AES128
  end
  L6 = _UPVALUE1_
  L6 = L6.pwToKey
  L7 = A0
  L8 = L5
  L6 = L6(L7, L8)
  L7 = _UPVALUE2_
  L7 = L7.padByteString
  L8 = A1
  L7 = L7(L8)
  L8 = _UPVALUE0_
  L8 = L8.ECBMODE
  if L4 == L8 then
    L8 = _UPVALUE3_
    L8 = L8.encryptString
    L9 = L6
    L10 = L7
    L11 = _UPVALUE3_
    L11 = L11.encryptECB
    return L8(L9, L10, L11)
  else
    L8 = _UPVALUE0_
    L8 = L8.CBCMODE
    if L4 == L8 then
      L8 = _UPVALUE3_
      L8 = L8.encryptString
      L9 = L6
      L10 = L7
      L11 = _UPVALUE3_
      L11 = L11.encryptCBC
      return L8(L9, L10, L11)
    else
      L8 = _UPVALUE0_
      L8 = L8.OFBMODE
      if L4 == L8 then
        L8 = _UPVALUE3_
        L8 = L8.encryptString
        L9 = L6
        L10 = L7
        L11 = _UPVALUE3_
        L11 = L11.encryptOFB
        return L8(L9, L10, L11)
      else
        L8 = _UPVALUE0_
        L8 = L8.CFBMODE
        if L4 == L8 then
          L8 = _UPVALUE3_
          L8 = L8.encryptString
          L9 = L6
          L10 = L7
          L11 = _UPVALUE3_
          L11 = L11.encryptCFB
          return L8(L9, L10, L11)
        else
          L8 = nil
          return L8
        end
      end
    end
  end
end
L1.encrypt = L4
function L4(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11
  L4 = A3 or L4
  if not A3 then
    L4 = _UPVALUE0_
    L4 = L4.CBCMODE
  end
  L5 = A2 or L5
  if not A2 then
    L5 = _UPVALUE0_
    L5 = L5.AES128
  end
  L6 = _UPVALUE1_
  L6 = L6.pwToKey
  L7 = A0
  L8 = L5
  L6 = L6(L7, L8)
  L7 = nil
  L8 = _UPVALUE0_
  L8 = L8.ECBMODE
  if L4 == L8 then
    L8 = _UPVALUE2_
    L8 = L8.decryptString
    L9 = L6
    L10 = A1
    L11 = _UPVALUE2_
    L11 = L11.decryptECB
    L8 = L8(L9, L10, L11)
    L7 = L8
  else
    L8 = _UPVALUE0_
    L8 = L8.CBCMODE
    if L4 == L8 then
      L8 = _UPVALUE2_
      L8 = L8.decryptString
      L9 = L6
      L10 = A1
      L11 = _UPVALUE2_
      L11 = L11.decryptCBC
      L8 = L8(L9, L10, L11)
      L7 = L8
    else
      L8 = _UPVALUE0_
      L8 = L8.OFBMODE
      if L4 == L8 then
        L8 = _UPVALUE2_
        L8 = L8.decryptString
        L9 = L6
        L10 = A1
        L11 = _UPVALUE2_
        L11 = L11.decryptOFB
        L8 = L8(L9, L10, L11)
        L7 = L8
      else
        L8 = _UPVALUE0_
        L8 = L8.CFBMODE
        if L4 == L8 then
          L8 = _UPVALUE2_
          L8 = L8.decryptString
          L9 = L6
          L10 = A1
          L11 = _UPVALUE2_
          L11 = L11.decryptCFB
          L8 = L8(L9, L10, L11)
          L7 = L8
        end
      end
    end
  end
  L8 = _UPVALUE3_
  L8 = L8.unpadByteString
  L9 = L7
  L8 = L8(L9)
  result = L8
  L8 = result
  if L8 == nil then
    L8 = nil
    return L8
  end
  L8 = result
  return L8
end
L1.decrypt = L4
L4 = aeslua
return L4
