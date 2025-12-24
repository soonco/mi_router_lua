local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57, L58
L0 = require
L1 = "posix.bit32"
L0 = L0(L1)
L1 = {}
L5 = "dirent"
L6 = "errno"
L7 = "fcntl"
L11 = "grp"
L12 = "libgen"
L13 = "poll"
L14 = "pwd"
L15 = "sched"
L16 = "signal"
L17 = "stdio"
L18 = "stdlib"
L19 = "sys.msg"
L20 = "sys.resource"
L21 = "sys.socket"
L22 = "sys.stat"
L23 = "sys.statvfs"
L24 = "sys.time"
L25 = "sys.times"
L26 = "sys.utsname"
L27 = "sys.wait"
L28 = "syslog"
L29 = "termio"
L30 = "time"
L31 = "unistd"
L32 = "utime"
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
L3[17] = L20
L3[18] = L21
L3[19] = L22
L3[20] = L23
L3[21] = L24
L3[22] = L25
L3[23] = L26
L3[24] = L27
L3[25] = L28
L3[26] = L29
L3[27] = L30
L3[28] = L31
L3[29] = L32
for L5, L6 in L2, L3, L4 do
  L7 = require
  L7 = L7(L8)
  for L11, L12 in L8, L9, L10 do
    if L11 ~= "version" then
      L13 = assert
      L14 = L1[L11]
      L14 = L14 == nil
      L15 = "posix namespace clash: "
      L16 = L6
      L17 = "."
      L18 = L11
      L15 = L15 .. L16 .. L17 .. L18
      L13(L14, L15)
      L1[L11] = L12
    end
  end
end
L1.version = L2
L5 = L1.checktable
L6 = L1.toomanyargerror
L7 = {}
L7.sub = L8
L11 = L1.getegid
L12 = L1.geteuid
L13 = L1.getgid
L14 = L1.getuid
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = _UPVALUE0_
  L2 = L2()
  L3 = _UPVALUE1_
  L3 = L3()
  L4 = _UPVALUE2_
  L4 = L4()
  if L4 == L2 then
    L4 = _UPVALUE3_
    L4 = L4()
    if L4 == L3 then
      L4 = _UPVALUE4_
      L5 = A0
      L6 = A1
      return L4(L5, L6)
    end
  end
  L4 = _UPVALUE5_
  L5 = A0
  L4 = L4(L5)
  if not L4 then
    return
  end
  if L2 == 0 then
    L5 = string
    L5 = L5.match
    L6 = A1
    L7 = "x"
    L5 = L5(L6, L7)
    if L5 then
      L5 = string
      L5 = L5.match
      L6 = L4.st_mode
      L7 = "x"
      L5 = L5(L6, L7)
      if not L5 then
        goto lbl_42
      end
    end
    L5 = 0
    return L5
  end
  ::lbl_42::
  L5 = string
  L5 = L5.gsub
  L6 = A1
  L7 = "[^rwx]"
  L8 = ""
  L5 = L5(L6, L7, L8)
  A1 = L5
  if A1 == "" then
    L5 = 0
    return L5
  end
  L5 = L4.st_mode
  L6 = L5
  L5 = L5.sub
  L7 = 1
  L8 = 3
  L5 = L5(L6, L7, L8)
  L6 = L4.st_uid
  if L2 == L6 then
    L6 = L4.st_mode
    L7 = L6
    L6 = L6.sub
    L8 = 7
    L9 = 9
    L6 = L6(L7, L8, L9)
    L5 = L6
  else
    L6 = L4.st_gid
    if L3 ~= L6 then
      L6 = set
      L6 = L6.new
      L7 = posix
      L7 = L7.getgroups
      L7, L8, L9 = L7()
      L6 = L6(L7, L8, L9)
      L7 = L6
      L6 = L6.member
      L8 = L4.st_gid
      L6 = L6(L7, L8)
      if not L6 then
        goto lbl_88
      end
    end
    L6 = L4.st_mode
    L7 = L6
    L6 = L6.sub
    L8 = 4
    L9 = 6
    L6 = L6(L7, L8, L9)
    L5 = L6
  end
  ::lbl_88::
  L6 = string
  L6 = L6.gsub
  L7 = L5
  L8 = "[^rwx]"
  L9 = ""
  L6 = L6(L7, L8, L9)
  L5 = L6
  L6 = string
  L6 = L6.gsub
  L7 = "[^"
  L8 = L5
  L9 = "]"
  L7 = L7 .. L8 .. L9
  L8 = A1
  L6 = L6(L7, L8)
  if L6 == "" then
    L6 = 0
    return L6
  end
  L6 = _UPVALUE6_
  L7 = EACCESS
  L6(L7)
end
L16 = _DEBUG
if L16 ~= false then
  function L16(...)
    local L1, L2, L3, L4, L5
    L1 = {}
    L2, L3, L4, L5 = ...
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L2 = _UPVALUE0_
    L3 = "euidaccess"
    L4 = 1
    L5 = L1[1]
    L2(L3, L4, L5)
    L2 = _UPVALUE0_
    L3 = "euidaccess"
    L4 = 2
    L5 = L1[2]
    L2(L3, L4, L5)
    L2 = #L1
    if 2 < L2 then
      L2 = _UPVALUE1_
      L3 = "euidaccess"
      L4 = 2
      L5 = #L1
      L2(L3, L4, L5)
    end
    L2 = _UPVALUE2_
    L3, L4, L5 = ...
    return L2(L3, L4, L5)
  end
  L1.euidaccess = L16
else
  L1.euidaccess = L15
end
L16 = require
L17 = "posix.bit32"
L16 = L16(L17)
L17 = require
L18 = "posix.fcntl"
L17 = L17(L18)
L18 = require
L19 = "posix.stdlib"
L18 = L18(L19)
L19 = require
L20 = "posix.unistd"
L19 = L19(L20)
L20 = L16.bor
L21 = L17.open
L22 = L17.O_RDWR
L23 = L17.O_NOCTTY
L24 = L18.grantpt
L25 = L18.openpt
L26 = L18.ptsname
L27 = L18.unlockpt
L28 = L19.close
function L29(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L7 = _UPVALUE0_
  L8 = _UPVALUE1_
  L9 = _UPVALUE2_
  L10 = _UPVALUE3_
  L8, L9, L10, L11 = L8(L9, L10)
  L7, L8 = L7(L8, L9, L10, L11)
  L3 = L8
  L4 = L7
  if L4 then
    L7 = _UPVALUE4_
    L8 = L4
    L7, L8 = L7(L8)
    L3 = L8
    L2 = L7
    if L2 then
      L7 = _UPVALUE5_
      L8 = L4
      L7, L8 = L7(L8)
      L3 = L8
      L2 = L7
      if L2 then
        L7 = _UPVALUE6_
        L8 = L4
        L7, L8 = L7(L8)
        L3 = L8
        L6 = L7
        if L6 then
          L7 = _UPVALUE7_
          L8 = L6
          L9 = _UPVALUE1_
          L10 = _UPVALUE2_
          L11 = _UPVALUE3_
          L9, L10, L11 = L9(L10, L11)
          L7, L8 = L7(L8, L9, L10, L11)
          L3 = L8
          L5 = L7
          if L5 then
            L7 = L4
            L8 = L5
            L9 = L6
            return L7, L8, L9
          end
        end
      end
    end
    L7 = _UPVALUE8_
    L8 = L4
    L7(L8)
  end
  L7 = nil
  L8 = L3
  return L7, L8
end
L30 = _DEBUG
if L30 ~= false then
  function L30(...)
    local L1, L2, L3, L4, L5
    L1 = {}
    L2, L3, L4, L5 = ...
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L2 = #L1
    if 0 < L2 then
      L2 = _UPVALUE0_
      L3 = "openpty"
      L4 = 0
      L5 = #L1
      L2(L3, L4, L5)
    end
    L2 = _UPVALUE1_
    L3, L4, L5 = ...
    return L2(L3, L4, L5)
  end
  L1.openpty = L30
else
  L1.openpty = L29
end
L30 = table
L30 = L30.unpack
L30 = L30 or L30
L31 = L1._exit
L32 = L1.errno
L33 = L1.execp
L34 = L1.fork
L35 = L1.wait
function L36(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2, L3 = L2()
  if L2 == nil then
    L4 = L2
    L5 = L3
    return L4, L5
  elseif L2 == 0 then
    L4 = type
    L5 = A0
    L4 = L4(L5)
    if L4 == "string" then
      L4 = {}
      L5 = "/bin/sh"
      L6 = "-c"
      L7 = A0
      L8 = ...
      L4[1] = L5
      L4[2] = L6
      L4[3] = L7
      L4[4] = L8
      A0 = L4
    end
    L4 = type
    L5 = A0
    L4 = L4(L5)
    if L4 == "table" then
      L4 = _UPVALUE1_
      L5 = _UPVALUE2_
      L6 = A0
      L5, L6, L7, L8 = L5(L6)
      L4(L5, L6, L7, L8)
      L4 = _UPVALUE3_
      L4, L5 = L4()
      L6 = _UPVALUE4_
      L7 = L5
      L6(L7)
    else
      L4 = _UPVALUE4_
      L5 = A0
      L6, L7, L8 = ...
      L5 = L5(L6, L7, L8)
      L5 = L5 or L5
      L4(L5)
    end
  else
    L4 = _UPVALUE5_
    L5 = L2
    L4, L5, L6 = L4(L5)
    L7 = L6
    L8 = L5
    return L7, L8
  end
end
L37 = _DEBUG
if L37 ~= false then
  function L37(A0, ...)
    local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
    L2 = {}
    L3 = A0
    L7, L8, L9, L10, L11, L12 = ...
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
    L3 = type
    L3 = L3(L4)
    if L3 ~= "string" and L3 ~= "table" and L3 ~= "function" then
      L7 = "string, table or function"
      L8 = A0
      L4(L5, L6, L7, L8)
    end
    for L7 = L4, L5, L6 do
      L8 = type
      L9 = L2[L7]
      L8 = L8(L9)
      if L8 ~= "string" then
        L8 = type
        L9 = L2[L7]
        L8 = L8(L9)
        if L8 ~= "nil" then
          L8 = _UPVALUE0_
          L9 = "spawn"
          L10 = L7
          L11 = "string or nil"
          L12 = L2[L7]
          L8(L9, L10, L11, L12)
        end
      end
    end
    L7, L8, L9, L10, L11, L12 = ...
    return L4(L5, L6, L7, L8, L9, L10, L11, L12)
  end
  L1.spawn = L37
else
  L1.spawn = L36
end
L37 = L1.spawn
L1.system = L37
L37 = L1.close
L38 = L1.dup
L39 = L1.dup2
L40 = L1.fork
L41 = L1.pipe
L42 = L1.wait
L43 = L1.STDIN_FILENO
L44 = L1.STDOUT_FILENO
function L45(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  A1 = A1 or A1
  L2, L3, L4, L5 = nil, nil, nil, nil
  L6 = #A0
  if 1 < L6 then
    L6 = A1
    L6, L7 = L6()
    L4 = L7
    L3 = L6
    if not L3 then
      L6 = die
      L7 = "error opening pipe"
      L6(L7)
    end
    L6 = _UPVALUE1_
    L6 = L6()
    L2 = L6
    if L2 == nil then
      L6 = die
      L7 = "error forking"
      L6(L7)
    elseif L2 == 0 then
      L6 = _UPVALUE2_
      L7 = L3
      L8 = _UPVALUE3_
      L6 = L6(L7, L8)
      if not L6 then
        L6 = die
        L7 = "error dup2-ing"
        L6(L7)
      end
      L6 = _UPVALUE4_
      L7 = L3
      L6(L7)
      L6 = _UPVALUE4_
      L7 = L4
      L6(L7)
      L6 = os
      L6 = L6.exit
      L7 = _UPVALUE5_
      L8 = _UPVALUE6_
      L8 = L8.sub
      L9 = A0
      L10 = 2
      L8 = L8(L9, L10)
      L9 = A1
      L7, L8, L9, L10 = L7(L8, L9)
      L6(L7, L8, L9, L10)
    else
      L6 = _UPVALUE7_
      L7 = _UPVALUE8_
      L6 = L6(L7)
      L5 = L6
      if not L5 then
        L6 = die
        L7 = "error dup-ing"
        L6(L7)
      end
      L6 = _UPVALUE2_
      L7 = L4
      L8 = _UPVALUE8_
      L6 = L6(L7, L8)
      if not L6 then
        L6 = die
        L7 = "error dup2-ing"
        L6(L7)
      end
      L6 = _UPVALUE4_
      L7 = L3
      L6(L7)
      L6 = _UPVALUE4_
      L7 = L4
      L6(L7)
    end
  end
  L6 = _UPVALUE9_
  L7 = A0[1]
  L6 = L6(L7)
  if not L6 then
    L7 = die
    L8 = "error in fork or wait"
    L7(L8)
  end
  L7 = _UPVALUE4_
  L8 = _UPVALUE8_
  L7(L8)
  L7 = #A0
  if 1 < L7 then
    L7 = _UPVALUE4_
    L8 = L4
    L7(L8)
    L7 = _UPVALUE10_
    L8 = L2
    L7(L8)
    L7 = _UPVALUE2_
    L8 = L5
    L9 = _UPVALUE8_
    L7 = L7(L8, L9)
    if not L7 then
      L7 = die
      L8 = "error dup2-ing"
      L7(L8)
    end
    L7 = _UPVALUE4_
    L8 = L5
    L7(L8)
  end
  return L6
end
L46 = _DEBUG
if L46 ~= false then
  function L46(...)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = {}
    L2, L3, L4, L5, L6, L7 = ...
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L1[5] = L6
    L1[6] = L7
    L2 = _UPVALUE0_
    L3 = "pipeline"
    L4 = 1
    L5 = L1[1]
    L2(L3, L4, L5)
    L2 = type
    L3 = L1[2]
    L2 = L2(L3)
    L3 = L1[2]
    if L3 ~= nil then
      L3 = type
      L4 = L1[2]
      L3 = L3(L4)
      if L3 ~= "function" then
        L3 = _UPVALUE1_
        L4 = "pipeline"
        L5 = 2
        L6 = "function or nil"
        L7 = L1[2]
        L3(L4, L5, L6, L7)
      end
    end
    L3 = #L1
    if 2 < L3 then
      L3 = _UPVALUE2_
      L4 = "pipeline"
      L5 = 2
      L6 = #L1
      L3(L4, L5, L6)
    end
    L3 = _UPVALUE3_
    L4, L5, L6, L7 = ...
    return L3(L4, L5, L6, L7)
  end
  L1.pipeline = L46
else
  L1.pipeline = L45
end
L46 = L1.close
L47 = L1.fork
L48 = L1.pipe
L49 = L1.read
L50 = L1.wait
L51 = L1.write
L52 = L1.BUFSIZ
L53 = L1.STDIN_FILENO
function L54(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2, L3 = L2()
  if not L2 then
    L4 = die
    L5 = "error opening pipe"
    L4(L5)
  end
  L4 = table
  L4 = L4.insert
  L5 = A0
  function L6()
    local L0, L1, L2, L3
    while true do
      L0 = _UPVALUE0_
      L1 = _UPVALUE1_
      L2 = _UPVALUE2_
      L0 = L0(L1, L2)
      if not L0 then
        break
      end
      L1 = #L0
      if L1 == 0 then
        break
      end
      L1 = _UPVALUE3_
      L2 = _UPVALUE4_
      L3 = L0
      L1(L2, L3)
    end
    L0 = _UPVALUE5_
    L1 = _UPVALUE4_
    L0(L1)
  end
  L4(L5, L6)
  L4 = _UPVALUE6_
  L4 = L4()
  if L4 == nil then
    L5 = die
    L6 = "error forking"
    L5(L6)
  elseif L4 == 0 then
    L5 = os
    L5 = L5.exit
    L6 = _UPVALUE7_
    L7 = A0
    L8 = A1
    L6, L7, L8 = L6(L7, L8)
    L5(L6, L7, L8)
  else
    L5 = _UPVALUE5_
    L6 = L3
    L5(L6)
    function L5()
      local L0, L1, L2
      L0 = _UPVALUE0_
      L1 = _UPVALUE1_
      L2 = _UPVALUE2_
      L0 = L0(L1, L2)
      if L0 then
        L1 = #L0
        if L1 ~= 0 then
          goto lbl_15
        end
      end
      L1 = _UPVALUE3_
      L2 = _UPVALUE4_
      L1(L2)
      L1 = nil
      do return L1 end
      ::lbl_15::
      return L0
    end
    return L5
  end
end
pipeline_iterator = L54
L54 = _DEBUG
if L54 ~= false then
  function L54(...)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = {}
    L2, L3, L4, L5, L6, L7 = ...
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L1[5] = L6
    L1[6] = L7
    L2 = _UPVALUE0_
    L3 = "pipeline_iterator"
    L4 = 1
    L5 = L1[1]
    L2(L3, L4, L5)
    L2 = type
    L3 = L1[2]
    L2 = L2(L3)
    L3 = L1[2]
    if L3 ~= nil then
      L3 = type
      L4 = L1[2]
      L3 = L3(L4)
      if L3 ~= "function" then
        L3 = _UPVALUE1_
        L4 = "pipeline_iterator"
        L5 = 2
        L6 = "function or nil"
        L7 = L1[2]
        L3(L4, L5, L6, L7)
      end
    end
    L3 = #L1
    if 2 < L3 then
      L3 = _UPVALUE2_
      L4 = "pipeline_iterator"
      L5 = 2
      L6 = #L1
      L3(L4, L5, L6)
    end
    L3 = pipeline_iterator
    L4, L5, L6, L7 = ...
    return L3(L4, L5, L6, L7)
  end
  L1.pipeline_iterator = L54
end
function L54(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = ""
  for L6 in L3, L4, L5 do
    L7 = L2
    L8 = L6
    L2 = L7 .. L8
  end
  return L2
end
L55 = _DEBUG
if L55 ~= false then
  function L55(...)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = {}
    L2, L3, L4, L5, L6, L7 = ...
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L1[5] = L6
    L1[6] = L7
    L2 = _UPVALUE0_
    L3 = "pipeline_slurp"
    L4 = 1
    L5 = L1[1]
    L2(L3, L4, L5)
    L2 = type
    L3 = L1[2]
    L2 = L2(L3)
    L3 = L1[2]
    if L3 ~= nil then
      L3 = type
      L4 = L1[2]
      L3 = L3(L4)
      if L3 ~= "function" then
        L3 = _UPVALUE1_
        L4 = "pipeline_slurp"
        L5 = 2
        L6 = "function or nil"
        L7 = L1[2]
        L3(L4, L5, L6, L7)
      end
    end
    L3 = #L1
    if 2 < L3 then
      L3 = _UPVALUE2_
      L4 = "pipeline_slurp"
      L5 = 2
      L6 = #L1
      L3(L4, L5, L6)
    end
    L3 = _UPVALUE3_
    L4, L5, L6, L7 = ...
    return L3(L4, L5, L6, L7)
  end
  L1.pipeline_slurp = L55
end
function L55(A0, A1)
  local L2, L3, L4
  L2 = 0
  L3 = 0
  L4 = A0.sec
  if L4 then
    L4 = A0.sec
    L2 = L2 + L4
  end
  L4 = A1.sec
  if L4 then
    L4 = A1.sec
    L2 = L2 + L4
  end
  L4 = A0.usec
  if L4 then
    L4 = A0.usec
    L3 = L3 + L4
  end
  L4 = A1.usec
  if L4 then
    L4 = A1.usec
    L3 = L3 + L4
  end
  if 1000000 < L3 then
    L2 = L2 + 1
    L3 = L3 - 1000000
  end
  L4 = {}
  L4.sec = L2
  L4.usec = L3
  return L4
end
L56 = _DEBUG
if L56 ~= false then
  function L56(...)
    local L1, L2, L3, L4, L5
    L1 = {}
    L2, L3, L4, L5 = ...
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L2 = _UPVALUE0_
    L3 = "timeradd"
    L4 = 1
    L5 = L1[1]
    L2(L3, L4, L5)
    L2 = _UPVALUE0_
    L3 = "timeradd"
    L4 = 2
    L5 = L1[2]
    L2(L3, L4, L5)
    L2 = #L1
    if 2 < L2 then
      L2 = _UPVALUE1_
      L3 = "timeradd"
      L4 = 2
      L5 = #L1
      L2(L3, L4, L5)
    end
    L2 = _UPVALUE2_
    L3, L4, L5 = ...
    return L2(L3, L4, L5)
  end
  L1.timeradd = L56
end
function L56(A0, A1)
  local L2, L3, L4, L5
  L2 = {}
  L3 = A0.sec
  L3 = L3 or L3
  L2.sec = L3
  L3 = A0.usec
  L3 = L3 or L3
  L2.usec = L3
  L3 = {}
  L4 = A1.sec
  L4 = L4 or L4
  L3.sec = L4
  L4 = A1.usec
  L4 = L4 or L4
  L3.usec = L4
  L4 = L2.sec
  L5 = L3.sec
  if L4 ~= L5 then
    L4 = L2.sec
    L5 = L3.sec
    L4 = L4 - L5
    return L4
  else
    L4 = L2.usec
    L5 = L3.usec
    L4 = L4 - L5
    return L4
  end
end
L57 = _DEBUG
if L57 ~= false then
  function L57(...)
    local L1, L2, L3, L4, L5
    L1 = {}
    L2, L3, L4, L5 = ...
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L2 = _UPVALUE0_
    L3 = "timercmp"
    L4 = 1
    L5 = L1[1]
    L2(L3, L4, L5)
    L2 = _UPVALUE0_
    L3 = "timercmp"
    L4 = 2
    L5 = L1[2]
    L2(L3, L4, L5)
    L2 = #L1
    if 2 < L2 then
      L2 = _UPVALUE1_
      L3 = "timercmp"
      L4 = 2
      L5 = #L1
      L2(L3, L4, L5)
    end
    L2 = _UPVALUE2_
    L3, L4, L5 = ...
    return L2(L3, L4, L5)
  end
  L1.timercmp = L57
end
function L57(A0, A1)
  local L2, L3, L4
  L2 = 0
  L3 = 0
  L4 = A0.sec
  if L4 then
    L2 = A0.sec
  end
  L4 = A1.sec
  if L4 then
    L4 = A1.sec
    L2 = L2 - L4
  end
  L4 = A0.usec
  if L4 then
    L3 = A0.usec
  end
  L4 = A1.usec
  if L4 then
    L4 = A1.usec
    L3 = L3 - L4
  end
  if L3 < 0 then
    L2 = L2 - 1
    L3 = L3 + 1000000
  end
  L4 = {}
  L4.sec = L2
  L4.usec = L3
  return L4
end
L58 = _DEBUG
if L58 ~= false then
  function L58(...)
    local L1, L2, L3, L4, L5
    L1 = {}
    L2, L3, L4, L5 = ...
    L1[1] = L2
    L1[2] = L3
    L1[3] = L4
    L1[4] = L5
    L2 = _UPVALUE0_
    L3 = "timersub"
    L4 = 1
    L5 = L1[1]
    L2(L3, L4, L5)
    L2 = _UPVALUE0_
    L3 = "timersub"
    L4 = 2
    L5 = L1[2]
    L2(L3, L4, L5)
    L2 = #L1
    if 2 < L2 then
      L2 = _UPVALUE1_
      L3 = "timersub"
      L4 = 2
      L5 = #L1
      L2(L3, L4, L5)
    end
    L2 = _UPVALUE2_
    L3, L4, L5 = ...
    return L2(L3, L4, L5)
  end
  L1.timersub = L58
end
return L1
