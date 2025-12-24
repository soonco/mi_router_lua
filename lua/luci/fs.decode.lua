local L0, L1, L2, L3, L4, L5, L6, L7
L0 = require
L1 = "io"
L0 = L0(L1)
L1 = require
L2 = "os"
L1 = L1(L2)
L2 = require
L3 = "luci.ltn12"
L2 = L2(L3)
L3 = require
L4 = "nixio.fs"
L3 = L3(L4)
L4 = require
L5 = "nixio.util"
L4 = L4(L5)
L5 = type
L6 = module
L7 = "luci.fs"
L6(L7)
L6 = L3.access
access = L6
function L6(...)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.glob
  L2, L3, L4, L5, L6 = ...
  L1, L2, L3 = L1(L2, L3, L4, L5, L6)
  if L1 then
    L4 = _UPVALUE1_
    L4 = L4.consume
    L5 = L1
    return L4(L5)
  else
    L4 = nil
    L5 = L2
    L6 = L3
    return L4, L5, L6
  end
end
glob = L6
function L6(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.stat
  L2 = A0
  L3 = "type"
  L1 = L1(L2, L3)
  L1 = L1 == "reg"
  return L1
end
isfile = L6
function L6(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.stat
  L2 = A0
  L3 = "type"
  L1 = L1(L2, L3)
  L1 = L1 == "dir"
  return L1
end
isdirectory = L6
L6 = L3.readfile
readfile = L6
L6 = L3.writefile
writefile = L6
L6 = L3.datacopy
copy = L6
L6 = L3.move
rename = L6
function L6(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.stat
  L2 = A0
  L3 = "mtime"
  return L1(L2, L3)
end
mtime = L6
function L6(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = _UPVALUE0_
  L3 = L3.utimes
  L4 = A0
  L5 = A2
  L6 = A1
  return L3(L4, L5, L6)
end
utime = L6
L6 = L3.basename
basename = L6
L6 = L3.dirname
dirname = L6
function L6(...)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.dir
  L2, L3, L4, L5, L6 = ...
  L1, L2, L3 = L1(L2, L3, L4, L5, L6)
  if L1 then
    L4 = _UPVALUE1_
    L4 = L4.consume
    L5 = L1
    L4 = L4(L5)
    L5 = #L4
    L5 = L5 + 1
    L4[L5] = "."
    L5 = #L4
    L5 = L5 + 1
    L4[L5] = ".."
    return L4
  else
    L4 = nil
    L5 = L2
    L6 = L3
    return L4, L5, L6
  end
end
dir = L6
function L6(A0, A1)
  local L2, L3
  if A1 then
    L2 = _UPVALUE0_
    L2 = L2.mkdirr
    L3 = A0
    L2 = L2(L3)
    if L2 then
      goto lbl_13
    end
  end
  L2 = _UPVALUE0_
  L2 = L2.mkdir
  L3 = A0
  L2 = L2(L3)
  ::lbl_13::
  return L2
end
mkdir = L6
L6 = L3.rmdir
rmdir = L6
L6 = {}
L6.reg = "regular"
L6.dir = "directory"
L6.lnk = "link"
L6.chr = "character device"
L6.blk = "block device"
L6.fifo = "fifo"
L6.sock = "socket"
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L2 = L2.stat
  L3 = A0
  L2, L3, L4 = L2(L3)
  if L2 then
    L5 = L2.modestr
    L2.mode = L5
    L5 = _UPVALUE1_
    L6 = L2.type
    L5 = L5[L6]
    L5 = L5 or L5
    L2.type = L5
  end
  if A1 and L2 then
    L5 = L2[A1]
    if L5 then
      goto lbl_24
    end
  end
  L5 = L2
  ::lbl_24::
  L6 = L3
  L7 = L4
  return L5, L6, L7
end
stat = L7
L7 = L3.chmod
chmod = L7
function L7(A0, A1, A2)
  local L3, L4, L5
  if A2 then
    L3 = _UPVALUE0_
    L3 = L3.symlink
    L4 = A0
    L5 = A1
    L3 = L3(L4, L5)
    if L3 then
      goto lbl_15
    end
  end
  L3 = _UPVALUE0_
  L3 = L3.link
  L4 = A0
  L5 = A1
  L3 = L3(L4, L5)
  ::lbl_15::
  return L3
end
link = L7
L7 = L3.unlink
unlink = L7
L7 = L3.readlink
readlink = L7
