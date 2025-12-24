local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
L0 = require
L1 = "io"
L0 = L0(L1)
L1 = require
L2 = "os"
L1 = L1(L2)
L2 = require
L3 = "table"
L2 = L2(L3)
L3 = require
L4 = "nixio"
L3 = L3(L4)
L4 = require
L5 = "nixio.fs"
L4 = L4(L5)
L5 = require
L6 = "luci.model.uci"
L5 = L5(L6)
L6 = {}
L7 = require
L8 = "luci.util"
L7 = L7(L8)
L6.util = L7
L7 = require
L8 = "luci.ip"
L7 = L7(L8)
L6.ip = L7
L7 = tonumber
L8 = ipairs
L9 = pairs
L10 = pcall
L11 = type
L12 = next
L13 = setmetatable
L14 = require
L15 = select
L16 = module
L17 = "luci.sys"
L16(L17)
function L16(...)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.execute
  L2 = ...
  L1 = L1(L2)
  L1 = L1 / 256
  return L1
end
call = L16
L16 = L6.util
L16 = L16.exec
exec = L16
function L16()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = {}
  L1 = {}
  L2 = "fs"
  L6 = "percent"
  L7 = "mountpoint"
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L1[5] = L6
  L1[6] = L7
  L2 = _UPVALUE0_
  L2 = L2.util
  L2 = L2.execi
  L2 = L2(L3)
  if not L2 then
    return
  else
    L3()
  end
  for L6 in L3, L4, L5 do
    L7 = {}
    L8 = 1
    for L12 in L9, L10, L11 do
      L13 = L1[L8]
      L7[L13] = L12
      L8 = L8 + 1
    end
    if L9 then
      if not L9 then
        L8 = 2
        L6 = L9
        for L12 in L9, L10, L11 do
          L13 = L1[L8]
          L7[L13] = L12
          L8 = L8 + 1
        end
      end
      L9(L10, L11)
    end
  end
  return L0
end
mounts = L16
L16 = L3.getenv
getenv = L16
function L16(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if L1 == "string" then
    L1 = #A0
    if 0 < L1 then
      L1 = _UPVALUE1_
      L1 = L1.writefile
      L2 = "/proc/sys/kernel/hostname"
      L3 = A0
      L1(L2, L3)
      return A0
  end
  else
    L1 = _UPVALUE2_
    L1 = L1.uname
    L1 = L1()
    L1 = L1.nodename
    return L1
  end
end
hostname = L16
function L16(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  if not A2 then
    if A1 then
      L3 = _UPVALUE0_
      L3 = L3.popen
      if L3 then
        goto lbl_12
      end
    end
    L3 = _UPVALUE1_
    L3 = L3.util
    L3 = L3.exec
    ::lbl_12::
    L4 = L3
    L5 = "wget -qO- '"
    L7 = A0
    L6 = A0.gsub
    L8 = "'"
    L9 = ""
    L6 = L6(L7, L8, L9)
    L7 = "'"
    L5 = L5 .. L6 .. L7
    return L4(L5)
  else
    L3 = _UPVALUE2_
    L3 = L3.execute
    L4 = {}
    L6 = A2
    L5 = A2.gsub
    L7 = "'"
    L8 = ""
    L5 = L5(L6, L7, L8)
    L7 = A0
    L6 = A0.gsub
    L8 = "'"
    L9 = ""
    L6, L7, L8, L9 = L6(L7, L8, L9)
    L4[1] = L5
    L4[2] = L6
    L4[3] = L7
    L4[4] = L8
    L4[5] = L9
    L4 = "wget -qO '%s' '%s'" % L4
    return L3(L4)
  end
end
httpget = L16
function L16()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L0 = L0.sysinfo
  L0 = L0()
  L1 = L0.loads
  L1 = L1[1]
  L2 = L0.loads
  L2 = L2[2]
  L3 = L0.loads
  L3 = L3[3]
  return L1, L2, L3
end
loadavg = L16
function L16()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.execute
  L1 = "reboot >/dev/null 2>&1"
  return L0(L1)
end
reboot = L16
function L16()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = _UPVALUE0_
  L0 = L0.readfile
  L1 = "/proc/cpuinfo"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.readfile
  L2 = "/proc/meminfo"
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L4 = L1
  L3 = L1.match
  L5 = "MemTotal:%s*(%d+)"
  L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15 = L3(L4, L5)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15)
  L3 = _UPVALUE1_
  L5 = L1
  L4 = L1.match
  L6 = [[

Cached:%s*(%d+)]]
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15 = L4(L5, L6)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15)
  L4 = _UPVALUE1_
  L6 = L1
  L5 = L1.match
  L7 = "MemFree:%s*(%d+)"
  L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15 = L5(L6, L7)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15)
  L5 = _UPVALUE1_
  L7 = L1
  L6 = L1.match
  L8 = "Buffers:%s*(%d+)"
  L6, L7, L8, L9, L10, L11, L12, L13, L14, L15 = L6(L7, L8)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14, L15)
  L6 = _UPVALUE1_
  L8 = L0
  L7 = L0.match
  L9 = [[
[Bb]ogo[Mm][Ii][Pp][Ss].-: ([^
]+)]]
  L7, L8, L9, L10, L11, L12, L13, L14, L15 = L7(L8, L9)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
  L6 = L6 or L6
  L8 = L0
  L7 = L0.match
  L9 = [[
system type	+: ([^
]+)]]
  L7 = L7(L8, L9)
  if not L7 then
    L8 = L0
    L7 = L0.match
    L9 = [[
Processor	+: ([^
]+)]]
    L7 = L7(L8, L9)
    if not L7 then
      L8 = L0
      L7 = L0.match
      L9 = [[
model name	+: ([^
]+)]]
      L7 = L7(L8, L9)
    end
  end
  L8 = _UPVALUE2_
  L8 = L8.util
  L8 = L8.pcdata
  L9 = _UPVALUE0_
  L9 = L9.readfile
  L10 = "/tmp/sysinfo/model"
  L9, L10, L11, L12, L13, L14, L15 = L9(L10)
  L8 = L8(L9, L10, L11, L12, L13, L14, L15)
  if not L8 then
    L9 = L0
    L8 = L0.match
    L10 = [[
machine	+: ([^
]+)]]
    L8 = L8(L9, L10)
    if not L8 then
      L9 = L0
      L8 = L0.match
      L10 = [[
Hardware	+: ([^
]+)]]
      L8 = L8(L9, L10)
      if not L8 then
        L8 = _UPVALUE2_
        L8 = L8.util
        L8 = L8.pcdata
        L9 = _UPVALUE0_
        L9 = L9.readfile
        L10 = "/proc/diag/model"
        L9, L10, L11, L12, L13, L14, L15 = L9(L10)
        L8 = L8(L9, L10, L11, L12, L13, L14, L15)
        if not L8 then
          L8 = _UPVALUE3_
          L8 = L8.uname
          L8 = L8()
          L8 = L8.machine
          L8 = L8 or L8
        end
      end
    end
  end
  L9 = L7
  L10 = L8
  L11 = L2
  L12 = L3
  L13 = L5
  L14 = L4
  L15 = L6
  return L9, L10, L11, L12, L13, L14, L15
end
sysinfo = L16
function L16()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.util
  L0 = L0.exec
  L1 = "logread"
  return L0(L1)
end
syslog = L16
function L16()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.util
  L0 = L0.exec
  L1 = "dmesg"
  return L0(L1)
end
dmesg = L16
function L16(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.readfile
  L2 = "/dev/urandom"
  L3 = A0
  L1 = L1(L2, L3)
  L2 = L1 or L2
  if L1 then
    L2 = _UPVALUE1_
    L2 = L2.bin
    L2 = L2.hexlify
    L3 = L1
    L2 = L2(L3)
  end
  return L2
end
uniqueid = L16
function L16()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.sysinfo
  L0 = L0()
  L0 = L0.uptime
  return L0
end
uptime = L16
L16 = {}
net = L16
L16 = net
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  if L5 then
    for L8 in L5, L6, L7 do
      L9 = {}
      for L13 in L10, L11, L12 do
        L14 = #L9
        L14 = L14 + 1
        L9[L14] = L13
      end
      if L10 ~= "IP" then
        L10["IP address"] = L11
        L10["HW type"] = L11
        L10.Flags = L11
        L10["HW address"] = L11
        L10.Mask = L11
        L10.Device = L11
        if A0 then
          L11(L12)
        else
          L1 = L1 or L1
          L1[L11] = L10
        end
      end
    end
  end
  return L1
end
L16.arptable = L17
function L16(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L8 = _UPVALUE0_
  L8 = L8.cursor
  L8 = L8()
  L9 = {}
  L10 = {}
  function L11(A0, ...)
    local L2, L3, L4, L5, L6
    L2 = _UPVALUE0_
    L3 = A0
    L4, L5, L6 = ...
    L2 = L2(L3, L4, L5, L6)
    if L2 then
      L3 = _UPVALUE1_
      L3 = L3[L2]
      if not L3 then
        L3 = _UPVALUE1_
        L4 = {}
        L3[L2] = L4
      end
      L3 = _UPVALUE1_
      L3 = L3[L2]
      L4 = _UPVALUE0_
      L5 = 1
      L6 = ...
      L4 = L4(L5, L6)
      if not L4 then
        L4 = _UPVALUE1_
        L4 = L4[L2]
        L4 = L4[1]
      end
      L3[1] = L4
      L3 = _UPVALUE1_
      L3 = L3[L2]
      L4 = _UPVALUE0_
      L5 = 2
      L6 = ...
      L4 = L4(L5, L6)
      if not L4 then
        L4 = _UPVALUE1_
        L4 = L4[L2]
        L4 = L4[2]
      end
      L3[2] = L4
      L3 = _UPVALUE1_
      L3 = L3[L2]
      L4 = _UPVALUE0_
      L5 = 3
      L6 = ...
      L4 = L4(L5, L6)
      if not L4 then
        L4 = _UPVALUE1_
        L4 = L4[L2]
        L4 = L4[3]
      end
      L3[3] = L4
      L3 = _UPVALUE1_
      L3 = L3[L2]
      L4 = _UPVALUE0_
      L5 = 4
      L6 = ...
      L4 = L4(L5, L6)
      if not L4 then
        L4 = _UPVALUE1_
        L4 = L4[L2]
        L4 = L4[4]
      end
      L3[4] = L4
    end
  end
  if L12 then
    for L15 in L12, L13, L14 do
      L17 = L15
      L16 = L15.match
      L18 = "^([%d%.]+)%s+%S+%s+%S+%s+([a-fA-F0-9:]+)%s+"
      L16, L17 = L16(L17, L18)
      L5 = L17
      L6 = L16
      if L6 and L5 then
        L16 = L11
        L17 = A0
        L19 = L5
        L18 = L5.upper
        L18 = L18(L19)
        L19 = L6
        L20, L21 = nil, nil
        L16(L17, L18, L19, L20, L21)
      end
    end
  end
  if L12 then
    for L15 in L12, L13, L14 do
      L17 = L15
      L16 = L15.match
      L18 = "^([a-f0-9]%S+) (%S+)"
      L16, L17 = L16(L17, L18)
      L6 = L17
      L5 = L16
      if L5 and L6 then
        L16 = L11
        L17 = A0
        L19 = L5
        L18 = L5.upper
        L18 = L18(L19)
        L19 = L6
        L20, L21 = nil, nil
        L16(L17, L18, L19, L20, L21)
      end
    end
  end
  if L12 then
    for L15 in L12, L13, L14 do
      L17 = L15
      L16 = L15.match
      L18 = "^%d+ (%S+) (%S+) (%S+)"
      L16, L17, L18 = L16(L17, L18)
      L7 = L18
      L6 = L17
      L5 = L16
      if L5 and L6 then
        L16 = L11
        L17 = A0
        L19 = L5
        L18 = L5.upper
        L18 = L18(L19)
        L19 = L6
        L20 = nil
        L21 = L7 ~= "*" and L21
        L16(L17, L18, L19, L20, L21)
      end
    end
  end
  L15 = "host"
  function L16(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
    for L4 in L1, L2, L3 do
      L5 = _UPVALUE1_
      L6 = _UPVALUE2_
      L8 = L4
      L7 = L4.upper
      L7 = L7(L8)
      L8 = A0.ip
      L9 = nil
      L10 = A0.name
      L5(L6, L7, L8, L9, L10)
    end
  end
  L12(L13, L14, L15, L16)
  L15, L16, L17, L18, L19, L20, L21, L22 = L13()
  for L15, L16 in L12, L13, L14 do
    L17 = L16.name
    if L17 ~= "lo" then
      L17 = L16.name
      L18 = L16.name
      L18 = L9[L18]
      L18 = L18 or L18
      L9[L17] = L18
      L17 = L16.family
      if L17 == "packet" then
        L17 = L16.addr
        if L17 then
          L17 = L16.addr
          L17 = #L17
          if L17 == 17 then
            L17 = L16.name
            L17 = L9[L17]
            L18 = L16.addr
            L19 = L18
            L18 = L18.upper
            L18 = L18(L19)
            L17[1] = L18
        end
      end
      else
        L17 = L16.family
        if L17 == "inet" then
          L17 = L16.name
          L17 = L9[L17]
          L18 = L16.addr
          L17[2] = L18
        else
          L17 = L16.family
          if L17 == "inet6" then
            L17 = L16.name
            L17 = L9[L17]
            L18 = L16.addr
            L17[3] = L18
          end
        end
      end
    end
  end
  for L15, L16 in L12, L13, L14 do
    L17 = L16[A0]
    if L17 then
      L17 = L16[2]
      if not L17 then
        L17 = L16[3]
        if not L17 then
          goto lbl_181
        end
      end
      L17 = L11
      L18 = A0
      L19 = L16[1]
      L20 = L16[2]
      L21 = L16[3]
      L22 = L16[4]
      L17(L18, L19, L20, L21, L22)
    end
    ::lbl_181::
  end
  for L15, L16 in L12, L13, L14 do
    L17 = A1
    L18 = L16[1]
    L19 = L16[2]
    L20 = L16[3]
    L21 = L16[4]
    L17(L18, L19, L20, L21)
  end
end
L17 = net
function L18(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = _UPVALUE0_
    L2 = 1
    function L3(A0, A1, A2, A3)
      local L4, L5, L6, L7, L8, L9
      if not A3 then
        L4 = _UPVALUE0_
        L4 = L4.getnameinfo
        L5 = A1 or L5
        if not A1 then
          L5 = A2
        end
        L6 = nil
        L7 = 100
        L4 = L4(L5, L6, L7)
        A3 = L4 or A3
        if not L4 then
          A3 = A1
        end
      end
      if A3 and A3 ~= A0 then
        L4 = _UPVALUE1_
        L5 = A0
        L6 = A3 or L6
        if not A3 then
          L6 = _UPVALUE0_
          L6 = L6.getnameinfo
          L7 = A1 or L7
          if not A1 then
            L7 = A2
          end
          L8 = nil
          L9 = 100
          L6 = L6(L7, L8, L9)
          L6 = L6 or L6
        end
        L4(L5, L6)
      end
    end
    L1(L2, L3)
  else
    L1 = {}
    L2 = _UPVALUE0_
    L3 = 1
    function L4(A0, A1, A2, A3)
      local L4, L5, L6, L7, L8, L9, L10, L11
      if not A3 then
        L4 = _UPVALUE0_
        L4 = L4.getnameinfo
        L5 = A1 or L5
        if not A1 then
          L5 = A2
        end
        L6 = nil
        L7 = 100
        L4 = L4(L5, L6, L7)
        A3 = L4 or A3
        if not L4 then
          A3 = A1
        end
      end
      if A3 and A3 ~= A0 then
        L4 = _UPVALUE1_
        L5 = _UPVALUE1_
        L5 = #L5
        L5 = L5 + 1
        L6 = {}
        L7 = A0
        L8 = A3 or L8
        if not A3 then
          L8 = _UPVALUE0_
          L8 = L8.getnameinfo
          L9 = A1 or L9
          if not A1 then
            L9 = A2
          end
          L10 = nil
          L11 = 100
          L8 = L8(L9, L10, L11)
          L8 = L8 or L8
        end
        L6[1] = L7
        L6[2] = L8
        L4[L5] = L6
      end
    end
    L2(L3, L4)
    return L1
  end
end
L17.mac_hints = L18
L17 = net
function L18(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = _UPVALUE0_
    L2 = 2
    function L3(A0, A1, A2, A3)
      local L4, L5, L6, L7
      if not A3 then
        L4 = _UPVALUE0_
        L4 = L4.getnameinfo
        L5 = A1
        L6 = nil
        L7 = 100
        L4 = L4(L5, L6, L7)
        A3 = L4 or A3
        if not L4 then
          A3 = A0
        end
      end
      if A3 and A3 ~= A1 then
        L4 = _UPVALUE1_
        L5 = A1
        L6 = A3
        L4(L5, L6)
      end
    end
    L1(L2, L3)
  else
    L1 = {}
    L2 = _UPVALUE0_
    L3 = 2
    function L4(A0, A1, A2, A3)
      local L4, L5, L6, L7, L8
      if not A3 then
        L4 = _UPVALUE0_
        L4 = L4.getnameinfo
        L5 = A1
        L6 = nil
        L7 = 100
        L4 = L4(L5, L6, L7)
        A3 = L4 or A3
        if not L4 then
          A3 = A0
        end
      end
      if A3 and A3 ~= A1 then
        L4 = _UPVALUE1_
        L5 = _UPVALUE1_
        L5 = #L5
        L5 = L5 + 1
        L6 = {}
        L7 = A1
        L8 = A3
        L6[1] = L7
        L6[2] = L8
        L4[L5] = L6
      end
    end
    L2(L3, L4)
    return L1
  end
end
L17.ipv4_hints = L18
L17 = net
function L18(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = _UPVALUE0_
    L2 = 3
    function L3(A0, A1, A2, A3)
      local L4, L5, L6, L7
      if not A3 then
        L4 = _UPVALUE0_
        L4 = L4.getnameinfo
        L5 = A2
        L6 = nil
        L7 = 100
        L4 = L4(L5, L6, L7)
        A3 = L4 or A3
        if not L4 then
          A3 = A0
        end
      end
      if A3 and A3 ~= A2 then
        L4 = _UPVALUE1_
        L5 = A2
        L6 = A3
        L4(L5, L6)
      end
    end
    L1(L2, L3)
  else
    L1 = {}
    L2 = _UPVALUE0_
    L3 = 3
    function L4(A0, A1, A2, A3)
      local L4, L5, L6, L7, L8
      if not A3 then
        L4 = _UPVALUE0_
        L4 = L4.getnameinfo
        L5 = A2
        L6 = nil
        L7 = 100
        L4 = L4(L5, L6, L7)
        A3 = L4 or A3
        if not L4 then
          A3 = A0
        end
      end
      if A3 and A3 ~= A2 then
        L4 = _UPVALUE1_
        L5 = _UPVALUE1_
        L5 = #L5
        L5 = L5 + 1
        L6 = {}
        L7 = A2
        L8 = A3
        L6[1] = L7
        L6[2] = L8
        L4[L5] = L6
      end
    end
    L2(L3, L4)
    return L1
  end
end
L17.ipv6_hints = L18
L17 = net
function L18(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = {}
  if L2 then
    for L5 in L2, L3, L4 do
      L7 = L5
      L6 = L5.match
      L6 = L6(L7, L8)
      L5 = L6
      L6 = _parse_mixed_record
      L7 = L5
      L6, L7 = L6(L7, L8)
      if L8 ~= "TIME_WAIT" then
        L6.layer3 = L8
        L6.layer4 = L8
        for L11 = L8, L9, L10 do
          L6[L11] = nil
        end
        if A0 then
          L8(L9)
        else
          L1[L8] = L6
        end
      end
    end
  elseif L2 then
    for L5 in L2, L3, L4 do
      L7 = L5
      L6 = L5.match
      L6 = L6(L7, L8)
      L5 = L6
      L6 = _parse_mixed_record
      L7 = L5
      L6, L7 = L6(L7, L8)
      if L8 ~= "TIME_WAIT" then
        L6.layer3 = "ipv4"
        L6.layer4 = L8
        for L11 = L8, L9, L10 do
          L6[L11] = nil
        end
        if A0 then
          L8(L9)
        else
          L1[L8] = L6
        end
      end
    end
  else
    return L2
  end
  return L1
end
L17.conntrack = L18
L17 = net
function L18()
  local L0, L1, L2
  L1 = net
  L1 = L1.routes
  function L2(A0)
    local L1, L2
    L1 = A0.dest
    L2 = L1
    L1 = L1.prefix
    L1 = L1(L2)
    if L1 == 0 then
      L1 = _UPVALUE0_
      if L1 then
        L1 = _UPVALUE0_
        L1 = L1.metric
        L2 = A0.metric
        if not (L1 > L2) then
          goto lbl_15
        end
      end
      _UPVALUE0_ = A0
    end
    ::lbl_15::
  end
  L1(L2)
  return L0
end
L17.defaultroute = L18
L17 = net
function L18()
  local L0, L1, L2, L3
  L1 = net
  L1 = L1.routes6
  function L2(A0)
    local L1, L2
    L1 = A0.dest
    L2 = L1
    L1 = L1.prefix
    L1 = L1(L2)
    if L1 == 0 then
      L1 = A0.device
      if L1 ~= "lo" then
        L1 = _UPVALUE0_
        if L1 then
          L1 = _UPVALUE0_
          L1 = L1.metric
          L2 = A0.metric
          if not (L1 > L2) then
            goto lbl_18
          end
        end
        _UPVALUE0_ = A0
      end
    end
    ::lbl_18::
  end
  L1(L2)
  if not L0 then
    L1 = _UPVALUE0_
    L1 = L1.ip
    L1 = L1.IPv6
    L2 = "2000::/3"
    L1 = L1(L2)
    L2 = net
    L2 = L2.routes6
    function L3(A0)
      local L1, L2, L3
      L1 = A0.dest
      L2 = L1
      L1 = L1.equal
      L3 = _UPVALUE0_
      L1 = L1(L2, L3)
      if L1 then
        L1 = _UPVALUE1_
        if L1 then
          L1 = _UPVALUE1_
          L1 = L1.metric
          L2 = A0.metric
          if not (L1 > L2) then
            goto lbl_16
          end
        end
        _UPVALUE1_ = A0
      end
      ::lbl_16::
    end
    L2(L3)
  end
  return L0
end
L17.defaultroute6 = L18
L17 = net
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L4, L5, L6, L7 = L2()
  for L4, L5 in L1, L2, L3 do
    L6 = L5.family
    if L6 == "packet" then
      L6 = #L0
      L6 = L6 + 1
      L7 = L5.name
      L0[L6] = L7
    end
  end
  return L0
end
L17.devices = L18
L17 = net
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L4, L5, L6, L7 = L2()
  for L4, L5 in L1, L2, L3 do
    L6 = L5.family
    if L6 == "packet" then
      L6 = L5.data
      L7 = L6.rx_bytes
      L6[1] = L7
      L7 = L6.rx_packets
      L6[2] = L7
      L7 = L6.rx_errors
      L6[3] = L7
      L7 = L6.rx_dropped
      L6[4] = L7
      L6[5] = 0
      L6[6] = 0
      L6[7] = 0
      L7 = L6.multicast
      L6[8] = L7
      L7 = L6.tx_bytes
      L6[9] = L7
      L7 = L6.tx_packets
      L6[10] = L7
      L7 = L6.tx_errors
      L6[11] = L7
      L7 = L6.tx_dropped
      L6[12] = L7
      L6[13] = 0
      L7 = L6.collisions
      L6[14] = L7
      L6[15] = 0
      L6[16] = 0
      L7 = L5.name
      L0[L7] = L6
    end
  end
  return L0
end
L17.deviceinfo = L18
L17 = net
function L18(A0)
  local L1, L2, L3
  L2 = net
  L2 = L2.arptable
  function L3(A0)
    local L1, L2
    L1 = A0["IP address"]
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = A0["HW address"]
      _UPVALUE1_ = L1
    end
  end
  L2(L3)
  return L1
end
L17.ip4mac = L18
L17 = net
function L18(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L2 = "ubus"
  L1 = L1(L2)
  L2 = L1.connect
  L2 = L2()
  L4 = L2
  L3 = L2.call
  L5 = "trafficd"
  L6 = "ip"
  L7 = {}
  L7.ip = A0
  L3 = L3(L4, L5, L6, L7)
  if L3 then
    L4 = L3.hw
    if L4 then
      goto lbl_18
    end
  end
  L4 = nil
  ::lbl_18::
  return L4
end
L17.ip4mac_ex = L18
L17 = net
function L18(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L1 = {}
  for L5 in L2, L3, L4 do
    L7 = L5
    L6 = L5.match
    L8 = "([^%s]+)\t([A-F0-9]+)\t([A-F0-9]+)\t([A-F0-9]+)\t"
    L9 = "(%d+)\t(%d+)\t(%d+)\t([A-F0-9]+)\t(%d+)\t(%d+)\t(%d+)"
    L8 = L8 .. L9
    L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16 = L6(L7, L8)
    if L6 then
      L17 = _UPVALUE1_
      L17 = L17.ip
      L17 = L17.Hex
      L18 = L8
      L19 = 32
      L20 = _UPVALUE1_
      L20 = L20.ip
      L20 = L20.FAMILY_INET4
      L17 = L17(L18, L19, L20)
      L8 = L17
      L17 = _UPVALUE1_
      L17 = L17.ip
      L17 = L17.Hex
      L18 = L13
      L19 = 32
      L20 = _UPVALUE1_
      L20 = L20.ip
      L20 = L20.FAMILY_INET4
      L17 = L17(L18, L19, L20)
      L13 = L17
      L17 = _UPVALUE1_
      L17 = L17.ip
      L17 = L17.Hex
      L18 = L7
      L20 = L13
      L19 = L13.prefix
      L21 = L13
      L19 = L19(L20, L21)
      L20 = _UPVALUE1_
      L20 = L20.ip
      L20 = L20.FAMILY_INET4
      L17 = L17(L18, L19, L20)
      L7 = L17
      L17 = {}
      L17.dest = L7
      L17.gateway = L8
      L18 = _UPVALUE2_
      L19 = L12
      L18 = L18(L19)
      L17.metric = L18
      L18 = _UPVALUE2_
      L19 = L10
      L18 = L18(L19)
      L17.refcount = L18
      L18 = _UPVALUE2_
      L19 = L11
      L18 = L18(L19)
      L17.usecount = L18
      L18 = _UPVALUE2_
      L19 = L14
      L18 = L18(L19)
      L17.mtu = L18
      L18 = _UPVALUE2_
      L19 = window
      L18 = L18(L19)
      L17.window = L18
      L18 = _UPVALUE2_
      L19 = L16
      L18 = L18(L19)
      L17.irtt = L18
      L18 = _UPVALUE2_
      L19 = L9
      L20 = 16
      L18 = L18(L19, L20)
      L17.flags = L18
      L17.device = L6
      if A0 then
        L18 = A0
        L19 = L17
        L18(L19)
      else
        L18 = #L1
        L18 = L18 + 1
        L1[L18] = L17
      end
    end
  end
  return L1
end
L17.routes = L18
L17 = net
function L18(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L1 = _UPVALUE0_
  L1 = L1.access
  L1 = L1(L2, L3)
  if L1 then
    L1 = {}
    for L5 in L2, L3, L4 do
      L7 = L5
      L6 = L5.match
      L8 = "([a-f0-9]+) ([a-f0-9]+) "
      L9 = "([a-f0-9]+) ([a-f0-9]+) "
      L10 = "([a-f0-9]+) ([a-f0-9]+) "
      L11 = "([a-f0-9]+) ([a-f0-9]+) "
      L12 = "([a-f0-9]+) +([^%s]+)"
      L8 = L8 .. L9 .. L10 .. L11 .. L12
      L6, L7, L8, L9, L10, L11, L12, L13, L14, L15 = L6(L7, L8)
      if L6 and L7 and L8 and L9 and L10 and L11 and L12 and L13 and L14 and L15 then
        L16 = _UPVALUE2_
        L16 = L16.ip
        L16 = L16.Hex
        L17 = L8
        L18 = _UPVALUE3_
        L19 = L9
        L20 = 16
        L18 = L18(L19, L20)
        L19 = _UPVALUE2_
        L19 = L19.ip
        L19 = L19.FAMILY_INET6
        L20 = false
        L16 = L16(L17, L18, L19, L20)
        L8 = L16
        L16 = _UPVALUE2_
        L16 = L16.ip
        L16 = L16.Hex
        L17 = L6
        L18 = _UPVALUE3_
        L19 = L7
        L20 = 16
        L18 = L18(L19, L20)
        L19 = _UPVALUE2_
        L19 = L19.ip
        L19 = L19.FAMILY_INET6
        L20 = false
        L16 = L16(L17, L18, L19, L20)
        L6 = L16
        L16 = _UPVALUE2_
        L16 = L16.ip
        L16 = L16.Hex
        L17 = L10
        L18 = 128
        L19 = _UPVALUE2_
        L19 = L19.ip
        L19 = L19.FAMILY_INET6
        L20 = false
        L16 = L16(L17, L18, L19, L20)
        L10 = L16
        L16 = {}
        L16.source = L8
        L16.dest = L6
        L16.nexthop = L10
        L17 = _UPVALUE3_
        L18 = L11
        L19 = 16
        L17 = L17(L18, L19)
        L16.metric = L17
        L17 = _UPVALUE3_
        L18 = L12
        L19 = 16
        L17 = L17(L18, L19)
        L16.refcount = L17
        L17 = _UPVALUE3_
        L18 = L13
        L19 = 16
        L17 = L17(L18, L19)
        L16.usecount = L17
        L17 = _UPVALUE3_
        L18 = L14
        L19 = 16
        L17 = L17(L18, L19)
        L16.flags = L17
        L16.device = L15
        L16.metric_raw = L11
        if A0 then
          L17 = A0
          L18 = L16
          L17(L18)
        else
          L17 = #L1
          L17 = L17 + 1
          L1[L17] = L16
        end
      end
    end
    return L1
  end
end
L17.routes6 = L18
L17 = net
function L18(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.execute
  L2 = "ping -c1 '"
  L4 = A0
  L3 = A0.gsub
  L5 = "'"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L4 = "' >/dev/null 2>&1"
  L2 = L2 .. L3 .. L4
  return L1(L2)
end
L17.pingtest = L18
L17 = {}
process = L17
L17 = process
function L18(A0)
  local L1, L2
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.getuid
  L2 = L2()
  L1.uid = L2
  L2 = _UPVALUE0_
  L2 = L2.getgid
  L2 = L2()
  L1.gid = L2
  L2 = L1 or L2
  if A0 or not L1 then
    L2 = L1[A0]
  end
  return L2
end
L17.info = L18
L17 = process
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = {}
  L1 = nil
  L2 = _UPVALUE0_
  L2 = L2.util
  L2 = L2.execi
  L2 = L2(L3)
  if not L2 then
    return
  end
  for L6 in L3, L4, L5 do
    L8 = L6
    L7 = L6.match
    L9 = "^ *(%d+) +(%d+) +(%S.-%S) +([RSDZTW][W ][<N ]) +(%d+) +(%d+%%) +(%d+%%) +(.+)"
    L7, L8, L9, L10, L11, L12, L13, L14 = L7(L8, L9)
    L15 = _UPVALUE1_
    L16 = L7
    L15 = L15(L16)
    if L15 then
      L16 = {}
      L16.PID = L7
      L16.PPID = L8
      L16.USER = L9
      L16.STAT = L10
      L16.VSZ = L11
      L16["%MEM"] = L12
      L16["%CPU"] = L13
      L16.COMMAND = L14
      L0[L15] = L16
    end
  end
  return L0
end
L17.list = L18
L17 = process
function L18(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.setgid
  L2 = A0
  return L1(L2)
end
L17.setgroup = L18
L17 = process
function L18(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.setuid
  L2 = A0
  return L1(L2)
end
L17.setuser = L18
L17 = process
L18 = L3.kill
L17.signal = L18
L17 = {}
user = L17
L17 = user
L18 = L3.getpw
L17.getuser = L18
L17 = user
function L18(A0)
  local L1, L2, L3, L4
  if A0 then
    L2 = A0
    L1 = A0.lower
    L1 = L1(L2)
    if L1 == "admin" then
      A0 = "root"
    end
  end
  L1 = _UPVALUE0_
  L1 = L1.getsp
  if L1 then
    L1 = _UPVALUE0_
    L1 = L1.getsp
    L2 = A0
    L1 = L1(L2)
    if L1 then
      goto lbl_22
    end
  end
  L1 = _UPVALUE0_
  L1 = L1.getpw
  L2 = A0
  L1 = L1(L2)
  ::lbl_22::
  L2 = L1 or L2
  if L1 then
    L2 = L1.pwdp
    L2 = L2 or L2
  end
  if L2 then
    L3 = #L2
    if not (L3 < 1) and L2 ~= "!" and L2 ~= "x" then
      goto lbl_41
    end
  end
  L3 = nil
  L4 = L1
  do return L3, L4 end
  goto lbl_44
  ::lbl_41::
  L3 = L2
  L4 = L1
  do return L3, L4 end
  ::lbl_44::
end
L17.getpasswd = L18
L17 = user
function L18(A0, A1)
  local L2, L3, L4, L5, L6
  if A0 then
    L3 = A0
    L2 = A0.lower
    L2 = L2(L3)
    if L2 == "admin" then
      A0 = "root"
    end
  end
  L2 = user
  L2 = L2.getpasswd
  L3 = A0
  L2, L3 = L2(L3)
  if L3 then
    L4 = L2 == nil
    return L4
  end
  L4 = false
  return L4
end
L17.checkpasswd = L18
L17 = user
function L18(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  if A0 then
    L3 = A0
    L2 = A0.lower
    L2 = L2(L3)
    if L2 == "admin" then
      A0 = "root"
    end
  end
  if A1 then
    L3 = A1
    L2 = A1.gsub
    L4 = "'"
    L5 = "'\"'\"'"
    L2 = L2(L3, L4, L5)
    A1 = L2
  end
  if A0 then
    L3 = A0
    L2 = A0.gsub
    L4 = "'"
    L5 = "'\"'\"'"
    L2 = L2(L3, L4, L5)
    A0 = L2
  end
  L2 = _UPVALUE0_
  L2 = L2.execute
  L3 = "(echo '"
  L4 = A1
  L5 = "'; sleep 1; echo '"
  L6 = A1
  L7 = "') | "
  L8 = "passwd '"
  L9 = A0
  L10 = "' >/dev/null 2>&1"
  L3 = L3 .. L4 .. L5 .. L6 .. L7 .. L8 .. L9 .. L10
  return L2(L3)
end
L17.setpasswd = L18
L17 = {}
wifi = L17
L17 = wifi
function L18(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = _UPVALUE0_
  L2 = _UPVALUE1_
  L3 = "iwinfo"
  L1, L2 = L1(L2, L3)
  if A0 then
    L3 = 0
    L4 = _UPVALUE2_
    L4 = L4.cursor_state
    L4 = L4()
    L6 = A0
    L5 = A0.match
    L7 = "^(%w+)%.network(%d+)"
    L5, L6 = L5(L6, L7)
    if L5 and L6 then
      A0 = L5
      L7 = _UPVALUE3_
      L8 = L6
      L7 = L7(L8)
      L6 = L7
      L8 = L4
      L7 = L4.foreach
      L9 = "wireless"
      L10 = "wifi-iface"
      function L11(A0)
        local L1, L2
        L1 = A0.device
        L2 = _UPVALUE0_
        if L1 == L2 then
          L1 = _UPVALUE1_
          L1 = L1 + 1
          _UPVALUE1_ = L1
          L1 = _UPVALUE1_
          L2 = _UPVALUE2_
          if L1 == L2 then
            L1 = A0.ifname
            L1 = L1 or L1
            _UPVALUE3_ = L1
            L1 = false
            return L1
          end
        end
      end
      L7(L8, L9, L10, L11)
    else
      L8 = L4
      L7 = L4.get
      L9 = "wireless"
      L10 = A0
      L7 = L7(L8, L9, L10)
      if L7 == "wifi-device" then
        L8 = L4
        L7 = L4.foreach
        L9 = "wireless"
        L10 = "wifi-iface"
        function L11(A0)
          local L1, L2
          L1 = A0.device
          L2 = _UPVALUE0_
          if L1 == L2 then
            L1 = A0.ifname
            if L1 then
              L1 = A0.ifname
              _UPVALUE0_ = L1
              L1 = false
              return L1
            end
          end
        end
        L7(L8, L9, L10, L11)
      end
    end
    L7 = L1 or L7
    if L1 then
      L7 = L2.type
      L8 = A0
      L7 = L7(L8)
    end
    if L7 then
      L8 = L2[L7]
      if L8 then
        goto lbl_56
      end
    end
    L8 = {}
    ::lbl_56::
    L9 = _UPVALUE4_
    L10 = {}
    L11 = {}
    function L12(A0, A1)
      local L2, L3
      if A1 == "ifname" then
        L2 = _UPVALUE0_
        return L2
      else
        L2 = _UPVALUE1_
        L2 = L2[A1]
        if L2 then
          L2 = _UPVALUE1_
          L2 = L2[A1]
          L3 = _UPVALUE0_
          return L2(L3)
        end
      end
    end
    L11.__index = L12
    return L9(L10, L11)
  end
end
L17.getiwinfo = L18
L17 = {}
init = L17
L17 = init
L17.dir = "/etc/init.d/"
L17 = init
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  for L4 in L1, L2, L3 do
    L5 = #L0
    L5 = L5 + 1
    L6 = _UPVALUE0_
    L6 = L6.basename
    L7 = L4
    L6 = L6(L7)
    L0[L5] = L6
  end
  return L0
end
L17.names = L18
L17 = init
function L18(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.access
  L2 = init
  L2 = L2.dir
  L3 = A0
  L2 = L2 .. L3
  L1 = L1(L2)
  if L1 then
    L1 = call
    L2 = {}
    L3 = init
    L3 = L3.dir
    L4 = A0
    L2[1] = L3
    L2[2] = L4
    L2 = "env -i sh -c 'source %s%s enabled; exit ${START:-255}' >/dev/null" % L2
    return L1(L2)
  end
end
L17.index = L18
function L17(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L2 = L2.access
  L3 = init
  L3 = L3.dir
  L4 = A1
  L3 = L3 .. L4
  L2 = L2(L3)
  if L2 then
    L2 = call
    L3 = {}
    L4 = init
    L4 = L4.dir
    L5 = A1
    L6 = A0
    L3[1] = L4
    L3[2] = L5
    L3[3] = L6
    L3 = "env -i %s%s %s >/dev/null" % L3
    return L2(L3)
  end
end
L18 = init
function L19(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "enabled"
  L3 = A0
  L1 = L1(L2, L3)
  L1 = L1 == 0
  return L1
end
L18.enabled = L19
L18 = init
function L19(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "enable"
  L3 = A0
  L1 = L1(L2, L3)
  L1 = L1 == 1
  return L1
end
L18.enable = L19
L18 = init
function L19(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "disable"
  L3 = A0
  L1 = L1(L2, L3)
  L1 = L1 == 0
  return L1
end
L18.disable = L19
L18 = init
function L19(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "start"
  L3 = A0
  L1 = L1(L2, L3)
  L1 = L1 == 0
  return L1
end
L18.start = L19
L18 = init
function L19(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "stop"
  L3 = A0
  L1 = L1(L2, L3)
  L1 = L1 == 0
  return L1
end
L18.stop = L19
function L18(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  A1 = A1 or A1
  L2 = {}
  L3 = {}
  L7 = A0
  L7 = "\n"
  L7, L8, L12, L13, L14, L15, L16, L17, L18, L19 = L5(L6, L7)
  for L7, L8 in L4, L5, L6 do
    L12 = L8
    L12 = A1
    L13 = nil
    L14 = true
    L12, L13, L14, L15, L16, L17, L18, L19 = L10(L11, L12, L13, L14)
    for L12, L13 in L9, L10, L11 do
      L15 = L13
      L14 = L13.match
      L16 = [[
([^%s][^:=]*) *([:=]*) *"*([^
"]*)"*]]
      L14, L15, L16 = L14(L15, L16)
      if L14 then
        if L15 == "" then
          L17 = _UPVALUE2_
          L17 = L17.insert
          L18 = L3
          L19 = L14
          L17(L18, L19)
        else
          L2[L14] = L16
        end
      end
    end
  end
  return L4, L5
end
_parse_mixed_record = L18
