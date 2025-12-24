local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "luci.sauth"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0(L1)
L0 = require
L1 = "luci.sys"
L0(L1)
L0 = require
L1 = "luci.config"
L0(L1)
L0 = require
L1 = "nixio"
L0 = L0(L1)
L1 = require
L2 = "nixio.util"
L1(L2)
L1 = require
L2 = "nixio.fs"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.XQLog"
L2 = L2(L3)
L3 = luci
L3 = L3.config
L4 = luci
L4 = L4.config
L4 = L4.sauth
L4 = L4 or L4
L3.sauth = L4
L3 = luci
L3 = L3.config
L3 = L3.sauth
L3 = L3.sessionpath
sessionpath = L3
L3 = tonumber
L4 = luci
L4 = L4.config
L4 = L4.sauth
L4 = L4.sessiontime
L3 = L3(L4)
L3 = L3 or L3
sessiontime = L3
function L3()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.mkdir
  L1 = sessionpath
  L2 = 700
  L0(L1, L2)
  L0 = sane
  L0 = L0()
  if not L0 then
    L0 = error
    L1 = "Security Exception: Session path is not sane!"
    L0(L1)
  end
end
prepare = L3
function L3(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.readfile
  L2 = sessionpath
  L3 = "/"
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1 = L1(L2)
  return L1
end
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = luci
  L2 = L2.sys
  L2 = L2.uniqueid
  L3 = 16
  L2 = L2(L3)
  L3 = sessionpath
  L4 = "/"
  L5 = L2
  L3 = L3 .. L4 .. L5
  L4 = sessionpath
  L5 = "/"
  L6 = A0
  L4 = L4 .. L5 .. L6
  L5 = _UPVALUE0_
  L5 = L5.open
  L6 = L3
  L7 = "w"
  L8 = 600
  L5 = L5(L6, L7, L8)
  L7 = L5
  L6 = L5.writeall
  L8 = A1
  L6(L7, L8)
  L7 = L5
  L6 = L5.close
  L6(L7)
  L6 = _UPVALUE1_
  L6 = L6.rename
  L7 = L3
  L8 = L4
  L6(L7, L8)
end
function L5(A0)
  local L1, L2, L3
  L1 = #A0
  L2 = A0
  L1 = A0.match
  L3 = "^[a-fA-F0-9]+$"
  L1 = L1(L2, L3)
  L1 = not L1
  L1 = A0 and L1
  return L1
end
function L6(A0, A1)
  local L2, L3, L4, L5
  L2 = sane
  L2 = L2()
  if not L2 then
    L2 = prepare
    L2()
  end
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE1_
    L2 = L2.log
    L3 = 3
    L4 = "Security Exception: Session ID is invalid! sauth.write"
    L2(L3, L4)
    return
  end
  L2 = type
  L3 = A1
  L2 = L2(L3)
  if L2 ~= "table" then
    L2 = _UPVALUE1_
    L2 = L2.log
    L3 = 3
    L4 = "Security Exception: Session data invalid! sauth.write"
    L2(L3, L4)
    return
  end
  L2 = luci
  L2 = L2.sys
  L2 = L2.uptime
  L2 = L2()
  A1.atime = L2
  L2 = _UPVALUE2_
  L3 = A0
  L4 = luci
  L4 = L4.util
  L4 = L4.get_bytecode
  L5 = A1
  L4, L5 = L4(L5)
  L2(L3, L4, L5)
end
write = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6
  if A0 then
    L1 = #A0
    if L1 ~= 0 then
      goto lbl_8
    end
  end
  L1 = nil
  do return L1 end
  ::lbl_8::
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE1_
    L1 = L1.log
    L2 = 3
    L3 = "Security Exception: Session ID is invalid! sauth.read"
    L1(L2, L3)
    L1 = nil
    return L1
  end
  L1 = sane
  L2 = sessionpath
  L3 = "/"
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1 = L1(L2)
  if not L1 then
    L1 = nil
    return L1
  end
  L1 = _UPVALUE2_
  L2 = A0
  L1 = L1(L2)
  L2 = loadstring
  L3 = L1
  L2 = L2(L3)
  L3 = setfenv
  L4 = L2
  L5 = {}
  L3(L4, L5)
  L3 = L2
  L3 = L3()
  L4 = type
  L5 = L3
  L4 = L4(L5)
  if L4 ~= "table" then
    L4 = _UPVALUE1_
    L4 = L4.log
    L5 = 3
    L6 = "Security Exception: Session data invalid! sauth.read"
    L4(L5, L6)
    L4 = nil
    return L4
  end
  L4 = L3.atime
  if L4 then
    L4 = L3.atime
    L5 = sessiontime
    L4 = L4 + L5
    L5 = luci
    L5 = L5.sys
    L5 = L5.uptime
    L5 = L5()
    if L4 < L5 then
      L4 = kill
      L5 = A0
      L4(L5)
      L4 = nil
      return L4
    end
  end
  L4 = write
  L5 = A0
  L6 = L3
  L4(L5, L6)
  return L3
end
read = L6
function L6(A0)
  local L1, L2, L3, L4
  L1 = luci
  L1 = L1.sys
  L1 = L1.process
  L1 = L1.info
  L2 = "uid"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.stat
  L3 = A0 or L3
  if not A0 then
    L3 = sessionpath
  end
  L4 = "uid"
  L2 = L2(L3, L4)
  L1 = L1 == L2
  return L1
end
sane = L6
function L6(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE1_
    L1 = L1.log
    L2 = 3
    L3 = "Security Exception: Session ID is invalid! sauth.kill"
    L1(L2, L3)
  else
    L1 = _UPVALUE2_
    L1 = L1.unlink
    L2 = sessionpath
    L3 = "/"
    L4 = A0
    L2 = L2 .. L3 .. L4
    L1(L2)
  end
end
kill = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = sane
  L0 = L0()
  if L0 then
    L0 = nil
    for L4 in L1, L2, L3 do
      L5 = _UPVALUE1_
      L6 = L4
      L5 = L5(L6)
      if L5 then
        L5 = read
        L6 = L4
        L5(L6)
      end
    end
  end
end
reap = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = sane
  L1 = L1()
  if L1 then
    L1 = nil
    for L5 in L2, L3, L4 do
      L6 = _UPVALUE1_
      L7 = L5
      L6 = L6(L7)
      if L6 then
        L6 = read
        L7 = L5
        L6 = L6(L7)
        if A0 then
          if L6 then
            L7 = L6.ip
            if L7 == A0 then
              return L6
            end
          end
        elseif L6 then
          L7 = L6.ip
          if not L7 then
            return L6
          end
        end
      end
    end
  end
  L1 = nil
  return L1
end
available = L6
function L6()
  local L0, L1, L2, L3
  L0 = os
  L0 = L0.execute
  L1 = string
  L1 = L1.format
  L2 = "rm -rf %s"
  L3 = sessionpath
  L1, L2, L3 = L1(L2, L3)
  L0(L1, L2, L3)
end
killall = L6
