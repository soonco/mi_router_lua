local L0, L1, L2, L3, L4
L0 = module
L1 = "aeslua.ciphermode"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "aeslua.aes"
L0 = L0(L1)
L1 = require
L2 = "aeslua.util"
L1 = L1(L2)
L2 = require
L3 = "aeslua.buffer"
L2 = L2(L3)
L3 = {}
L4 = aeslua
L4.ciphermode = L3
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L3 = iv
  if not L3 then
    L3 = {}
    L4 = 0
    L5 = 0
    L9 = 0
    L10 = 0
    L11 = 0
    L12 = 0
    L13 = 0
    L14 = 0
    L15 = 0
    L16 = 0
    L17 = 0
    L18 = 0
    L19 = 0
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L3[4] = L7
    L3[5] = L8
    L3[6] = L9
    L3[7] = L10
    L3[8] = L11
    L3[9] = L12
    L3[10] = L13
    L3[11] = L14
    L3[12] = L15
    L3[13] = L16
    L3[14] = L17
    L3[15] = L18
    L3[16] = L19
  end
  L4 = _UPVALUE0_
  L4 = L4.expandEncryptionKey
  L5 = A0
  L4 = L4(L5)
  L5 = _UPVALUE1_
  L5 = L5.new
  L5 = L5()
  for L9 = L6, L7, L8 do
    L10 = L9 - 1
    L10 = L10 * 16
    L10 = L10 + 1
    L11 = {}
    L12 = string
    L12 = L12.byte
    L13 = A1
    L14 = L10
    L15 = L10 + 15
    L12, L13, L14, L15, L16, L17, L18, L19 = L12(L13, L14, L15)
    L11[1] = L12
    L11[2] = L13
    L11[3] = L14
    L11[4] = L15
    L11[5] = L16
    L11[6] = L17
    L11[7] = L18
    L11[8] = L19
    L12 = A2
    L13 = L4
    L14 = L11
    L15 = L3
    L12(L13, L14, L15)
    L12 = _UPVALUE1_
    L12 = L12.addString
    L13 = L5
    L14 = string
    L14 = L14.char
    L15 = unpack
    L16 = L11
    L15, L16, L17, L18, L19 = L15(L16)
    L14, L15, L16, L17, L18, L19 = L14(L15, L16, L17, L18, L19)
    L12(L13, L14, L15, L16, L17, L18, L19)
  end
  return L6(L7)
end
L3.encryptString = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L3 = L3.encrypt
  L4 = A0
  L5 = A1
  L6 = 1
  L7 = A1
  L8 = 1
  L3(L4, L5, L6, L7, L8)
end
L3.encryptECB = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3(L4, L5)
  L6 = 1
  L7 = A1
  L8 = 1
  L3(L4, L5, L6, L7, L8)
  for L6 = L3, L4, L5 do
    L7 = A1[L6]
    A2[L6] = L7
  end
end
L3.encryptCBC = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L3 = L3.encrypt
  L4 = A0
  L5 = A2
  L6 = 1
  L7 = A2
  L8 = 1
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L3 = L3.xorIV
  L4 = A1
  L5 = A2
  L3(L4, L5)
end
L3.encryptOFB = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L6 = 1
  L7 = A2
  L8 = 1
  L3(L4, L5, L6, L7, L8)
  L3(L4, L5)
  for L6 = L3, L4, L5 do
    L7 = A1[L6]
    A2[L6] = L7
  end
end
L3.encryptCFB = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L3 = iv
  if not L3 then
    L3 = {}
    L4 = 0
    L5 = 0
    L9 = 0
    L10 = 0
    L11 = 0
    L12 = 0
    L13 = 0
    L14 = 0
    L15 = 0
    L16 = 0
    L17 = 0
    L18 = 0
    L19 = 0
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L3[4] = L7
    L3[5] = L8
    L3[6] = L9
    L3[7] = L10
    L3[8] = L11
    L3[9] = L12
    L3[10] = L13
    L3[11] = L14
    L3[12] = L15
    L3[13] = L16
    L3[14] = L17
    L3[15] = L18
    L3[16] = L19
  end
  L4 = nil
  L5 = _UPVALUE0_
  L5 = L5.decryptOFB
  if A2 ~= L5 then
    L5 = _UPVALUE0_
    L5 = L5.decryptCFB
    if A2 ~= L5 then
      goto lbl_37
    end
  end
  L5 = _UPVALUE1_
  L5 = L5.expandEncryptionKey
  L5 = L5(L6)
  L4 = L5
  goto lbl_42
  ::lbl_37::
  L5 = _UPVALUE1_
  L5 = L5.expandDecryptionKey
  L5 = L5(L6)
  L4 = L5
  ::lbl_42::
  L5 = _UPVALUE2_
  L5 = L5.new
  L5 = L5()
  for L9 = L6, L7, L8 do
    L10 = L9 - 1
    L10 = L10 * 16
    L10 = L10 + 1
    L11 = {}
    L12 = string
    L12 = L12.byte
    L13 = A1
    L14 = L10
    L15 = L10 + 15
    L12, L13, L14, L15, L16, L17, L18, L19 = L12(L13, L14, L15)
    L11[1] = L12
    L11[2] = L13
    L11[3] = L14
    L11[4] = L15
    L11[5] = L16
    L11[6] = L17
    L11[7] = L18
    L11[8] = L19
    L12 = A2
    L13 = L4
    L14 = L11
    L15 = L3
    L12 = L12(L13, L14, L15)
    L3 = L12
    L12 = _UPVALUE2_
    L12 = L12.addString
    L13 = L5
    L14 = string
    L14 = L14.char
    L15 = unpack
    L16 = L11
    L15, L16, L17, L18, L19 = L15(L16)
    L14, L15, L16, L17, L18, L19 = L14(L15, L16, L17, L18, L19)
    L12(L13, L14, L15, L16, L17, L18, L19)
  end
  return L6(L7)
end
L3.decryptString = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L3 = L3.decrypt
  L4 = A0
  L5 = A1
  L6 = 1
  L7 = A1
  L8 = 1
  L3(L4, L5, L6, L7, L8)
  return A2
end
L3.decryptECB = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = {}
  for L7 = L4, L5, L6 do
    L8 = A1[L7]
    L3[L7] = L8
  end
  L7 = 1
  L8 = A1
  L9 = 1
  L4(L5, L6, L7, L8, L9)
  L4(L5, L6)
  return L3
end
L3.decryptCBC = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L3 = L3.encrypt
  L4 = A0
  L5 = A2
  L6 = 1
  L7 = A2
  L8 = 1
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L3 = L3.xorIV
  L4 = A1
  L5 = A2
  L3(L4, L5)
  return A2
end
L3.decryptOFB = L4
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = {}
  for L7 = L4, L5, L6 do
    L8 = A1[L7]
    L3[L7] = L8
  end
  L7 = 1
  L8 = A2
  L9 = 1
  L4(L5, L6, L7, L8, L9)
  L4(L5, L6)
  return L3
end
L3.decryptCFB = L4
return L3
