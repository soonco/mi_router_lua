local L0, L1, L2, L3, L4, L5, L6, L7
L0 = require
L1 = "table"
L0 = L0(L1)
L1 = require
L2 = "nixio"
L1 = L1(L2)
L2 = type
L3 = ipairs
L4 = setmetatable
L5 = require
L6 = "nixio.util"
L5(L6)
L5 = module
L6 = "nixio.fs"
function L7(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L2 = A0
  L3 = {}
  L4 = _UPVALUE1_
  L4 = L4.fs
  L3.__index = L4
  L1(L2, L3)
end
L5(L6, L7)
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2.open
  L3 = A0
  L4 = "r"
  L2, L3, L4 = L2(L3, L4)
  L5 = nil
  if not L2 then
    L6 = nil
    L7 = L3
    L8 = L4
    return L6, L7, L8
  end
  L7 = L2
  L6 = L2.readall
  L8 = A1
  L6, L7, L8 = L6(L7, L8)
  L4 = L8
  L3 = L7
  L5 = L6
  L7 = L2
  L6 = L2.close
  L6(L7)
  L6 = L5
  L7 = L3
  L8 = L4
  return L6, L7, L8
end
readfile = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2.open
  L3 = A0
  L4 = "w"
  L2, L3, L4, L5 = L2(L3, L4)
  if not L2 then
    L6 = nil
    L7 = L3
    L8 = L4
    return L6, L7, L8
  end
  L7 = L2
  L6 = L2.writeall
  L8 = A1
  L6, L7, L8 = L6(L7, L8)
  L4 = L8
  L3 = L7
  L5 = L6
  L7 = L2
  L6 = L2.close
  L6(L7)
  L6 = L5
  L7 = L3
  L8 = L4
  return L6, L7, L8
end
writefile = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L3 = _UPVALUE0_
  L3 = L3.open
  L4 = A0
  L5 = "r"
  L3, L4, L5 = L3(L4, L5)
  if not L3 then
    L6 = nil
    L7 = L4
    L8 = L5
    return L6, L7, L8
  end
  L6 = _UPVALUE0_
  L6 = L6.open
  L7 = A1
  L8 = "w"
  L6, L7, L8 = L6(L7, L8)
  if not L6 then
    L9 = nil
    L10 = L7
    L11 = L8
    return L9, L10, L11
  end
  L10 = L3
  L9 = L3.copy
  L11 = L6
  L12 = A2
  L9, L10, L11, L12 = L9(L10, L11, L12)
  L14 = L3
  L13 = L3.close
  L13(L14)
  L14 = L6
  L13 = L6.close
  L13(L14)
  L13 = L9
  L14 = L10
  L15 = L11
  L16 = L12
  return L13, L14, L15, L16
end
datacopy = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = _UPVALUE0_
  L2 = L2.fs
  L2 = L2.lstat
  L3 = A0
  L2, L3, L4, L5 = L2(L3)
  if not L2 then
    L6 = nil
    L7 = L3
    L8 = L4
    return L6, L7, L8
  end
  L6 = L2.type
  if L6 == "dir" then
    L6 = _UPVALUE0_
    L6 = L6.fs
    L6 = L6.stat
    L7 = A1
    L8 = _UPVALUE1_
    L6 = L6(L7, L8)
    if L6 ~= "dir" then
      L6 = _UPVALUE0_
      L6 = L6.fs
      L6 = L6.mkdir
      L7 = A1
      L6, L7, L8 = L6(L7)
      L4 = L8
      L3 = L7
      L5 = L6
    else
      L2 = true
    end
  else
    L6 = L2.type
    if L6 == "lnk" then
      L6 = _UPVALUE0_
      L6 = L6.fs
      L6 = L6.symlink
      L7 = _UPVALUE0_
      L7 = L7.fs
      L7 = L7.readlink
      L8 = A0
      L7 = L7(L8)
      L8 = A1
      L6, L7, L8 = L6(L7, L8)
      L4 = L8
      L3 = L7
      L5 = L6
    else
      L6 = L2.type
      if L6 == "reg" then
        L6 = datacopy
        L7 = A0
        L8 = A1
        L6, L7, L8 = L6(L7, L8)
        L4 = L8
        L3 = L7
        L5 = L6
      end
    end
  end
  if not L5 then
    L6 = nil
    L7 = L3
    L8 = L4
    return L6, L7, L8
  end
  L6 = _UPVALUE0_
  L6 = L6.fs
  L6 = L6.utimes
  L7 = A1
  L8 = L2.atime
  L9 = L2.mtime
  L6(L7, L8, L9)
  L6 = _UPVALUE0_
  L6 = L6.fs
  L6 = L6.lchown
  if L6 then
    L6 = _UPVALUE0_
    L6 = L6.fs
    L6 = L6.lchown
    L7 = A1
    L8 = L2.uid
    L9 = L2.gid
    L6(L7, L8, L9)
  end
  L6 = L2.type
  if L6 ~= "lnk" then
    L6 = _UPVALUE0_
    L6 = L6.fs
    L6 = L6.chmod
    L7 = A1
    L8 = L2.modedec
    L6(L7, L8)
  end
  L6 = true
  return L6
end
copy = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L2 = L2.fs
  L2 = L2.rename
  L3 = A0
  L4 = A1
  L2, L3, L4 = L2(L3, L4)
  if not L2 then
    L5 = _UPVALUE0_
    L5 = L5.const
    L5 = L5.EXDEV
    if L3 == L5 then
      L5 = copy
      L6 = A0
      L7 = A1
      L5, L6, L7 = L5(L6, L7)
      L4 = L7
      L3 = L6
      L2 = L5
      if L2 then
        L5 = _UPVALUE0_
        L5 = L5.fs
        L5 = L5.unlink
        L6 = A0
        L5, L6, L7 = L5(L6)
        L4 = L7
        L3 = L6
        L2 = L5
      end
    end
  end
  L5 = L2
  L6 = L3
  L7 = L4
  return L5, L6, L7
end
move = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L2 = L2.fs
  L2 = L2.stat
  L3 = A0
  L4 = "type"
  L2 = L2(L3, L4)
  if L2 == "dir" then
    L2 = true
    return L2
  else
    L2 = _UPVALUE0_
    L2 = L2.fs
    L2 = L2.mkdir
    L3 = A0
    L4 = A1
    L2, L3, L4 = L2(L3, L4)
    if not L2 then
      L5 = _UPVALUE0_
      L5 = L5.const
      L5 = L5.ENOENT
      if L3 == L5 then
        L5 = mkdirr
        L6 = _UPVALUE0_
        L6 = L6.fs
        L6 = L6.dirname
        L7 = A0
        L6 = L6(L7)
        L7 = A1
        L5, L6, L7 = L5(L6, L7)
        L4 = L7
        L3 = L6
        L2 = L5
        if L2 then
          L5 = _UPVALUE0_
          L5 = L5.fs
          L5 = L5.mkdir
          L6 = A0
          L7 = A1
          L5, L6, L7 = L5(L6, L7)
          L4 = L7
          L3 = L6
          L2 = L5
        end
      end
    end
    L5 = L2
    L6 = L3
    L7 = L4
    return L5, L6, L7
  end
end
mkdirr = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L3 = _UPVALUE0_
  L3 = L3.fs
  L3 = L3.lstat
  L4 = A1
  L5 = "type"
  L3 = L3(L4, L5)
  if L3 ~= "dir" then
    L4 = A0
    L5 = A1
    L6 = A2
    return L4(L5, L6)
  else
    L4 = true
    L5 = _UPVALUE0_
    L5 = L5.const
    L5 = L5.sep
    L6, L7, L8, L9, L10 = nil, nil, nil, nil, nil
    if A2 then
      L10 = L13
      L9 = L12
      L8 = L11
      if L4 then
      end
      if not L9 then
      end
      L7 = L10 or L7
      if not L10 then
      end
      L6 = L12
      L4 = L11
    end
    for L14 in L11, L12, L13 do
      if A2 then
        L15 = _UPVALUE1_
        L16 = A0
        L17 = A1
        L18 = L5
        L19 = L14
        L17 = L17 .. L18 .. L19
        L18 = A2
        L19 = L5
        L20 = L14
        L18 = L18 .. L19 .. L20
        L15, L16, L17 = L15(L16, L17, L18)
        L10 = L17
        L9 = L16
        L8 = L15
      else
        L15 = _UPVALUE1_
        L16 = A0
        L17 = A1
        L18 = L5
        L19 = L14
        L17 = L17 .. L18 .. L19
        L15, L16, L17 = L15(L16, L17)
        L10 = L17
        L9 = L16
        L8 = L15
      end
      L15 = L4 or L15
      if L4 then
        L15 = L8
      end
      L16 = L9 or L16
      if not L9 then
        L16 = L6
      end
      L7 = L10 or L7
      if not L10 then
      end
      L6 = L16
      L4 = L15
    end
    if not A2 then
      L10 = L13
      L9 = L12
      L8 = L11
      if L4 then
      end
      if not L9 then
      end
      L7 = L10 or L7
      if not L10 then
      end
      L6 = L12
      L4 = L11
    end
    return L11, L12, L13
  end
end
function L6(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L3 = copy
  L4 = A0
  L5 = A1
  return L2(L3, L4, L5)
end
copyr = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2.fs
  L2 = L2.rename
  L3 = A0
  L4 = A1
  L2, L3, L4 = L2(L3, L4)
  if not L2 then
    L5 = _UPVALUE0_
    L5 = L5.const
    L5 = L5.EXDEV
    if L3 == L5 then
      L5 = _UPVALUE1_
      L6 = copy
      L7 = A0
      L8 = A1
      L5, L6, L7 = L5(L6, L7, L8)
      L4 = L7
      L3 = L6
      L2 = L5
      if L2 then
        L5 = _UPVALUE1_
        L6 = _UPVALUE0_
        L6 = L6.fs
        L6 = L6.remove
        L7 = A0
        L5, L6, L7 = L5(L6, L7)
        L4 = L7
        L3 = L6
        L2 = L5
      end
    end
  end
  L5 = L2
  L6 = L3
  L7 = L4
  return L5, L6, L7
end
mover = L6
function L6(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = _UPVALUE1_
  L2 = L2.fs
  L2 = L2.remove
  L3 = A0
  return L1(L2, L3)
end
remover = L6
