local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
L0 = require
L1 = "os"
L0 = L0(L1)
L1 = require
L2 = "io"
L1 = L1(L2)
L2 = require
L3 = "nixio.fs"
L2 = L2(L3)
L3 = require
L4 = "luci.util"
L3 = L3(L4)
L4 = type
L5 = pairs
L6 = error
L7 = table
L8 = "opkg --force-removal-of-dependent-packages --force-overwrite --nocase"
L9 = "/etc/opkg.conf"
L10 = module
L11 = "luci.model.ipkg"
L10(L11)
function L10(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = ""
  L6, L7, L8, L9, L10, L11, L12, L13 = ...
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  L4[5] = L9
  L4[6] = L10
  L4[7] = L11
  L4[8] = L12
  L4[9] = L13
  for L6, L7 in L3, L4, L5 do
    L8 = L2
    L9 = " '"
    L11 = L7
    L10 = L7.gsub
    L12 = "'"
    L13 = ""
    L10 = L10(L11, L12, L13)
    L11 = "'"
    L2 = L8 .. L9 .. L10 .. L11
  end
  L6 = L2
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L6 = "/tmp/opkg.stderr"
  L6 = _UPVALUE3_
  L6 = L6.readfile
  L7 = "/tmp/opkg.stdout"
  L6 = L6(L7)
  L7 = _UPVALUE3_
  L7 = L7.unlink
  L8 = "/tmp/opkg.stderr"
  L7(L8)
  L7 = _UPVALUE3_
  L7 = L7.unlink
  L8 = "/tmp/opkg.stdout"
  L7(L8)
  L7 = L4
  L8 = L6 or L8
  if not L6 then
    L8 = ""
  end
  L9 = L5 or L9
  if not L5 then
    L9 = ""
  end
  return L7, L8, L9
end
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if L1 ~= "function" then
    L1 = _UPVALUE1_
    L2 = "OPKG: Invalid rawdata given"
    L1(L2)
  end
  L1 = {}
  L2 = {}
  L3 = nil
  for L7 in L4, L5, L6 do
    L9 = L7
    L8 = L7.sub
    L8 = L8(L9, L10, L11)
    if L8 ~= " " then
      L9 = L7
      L8 = L7.match
      L8, L9 = L8(L9, L10)
      if L8 and L9 then
        if L8 == "Package" then
          L10.Package = L9
          L2 = L10
          L1[L9] = L2
        elseif L8 == "Status" then
          L2.Status = L10
          for L13 in L10, L11, L12 do
            L14 = L2.Status
            L14[L13] = true
          end
        else
          L2[L8] = L9
        end
        L3 = L8
      end
    else
      L8 = L2[L3]
      L9 = "\n"
      L8 = L8 .. L9 .. L10
      L2[L3] = L8
    end
  end
  return L1
end
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L3 = " "
  L4 = A0
  L2 = L2 .. L3 .. L4
  if A1 then
    L3 = L2
    L4 = " '"
    L6 = A1
    L5 = A1.gsub
    L7 = "'"
    L8 = ""
    L5 = L5(L6, L7, L8)
    L6 = "'"
    L2 = L3 .. L4 .. L5 .. L6
  end
  L3 = _UPVALUE1_
  L3 = L3.tmpname
  L3 = L3()
  L4 = _UPVALUE1_
  L4 = L4.execute
  L5 = L2
  L6 = " >%s 2>/dev/null" % L3
  L5 = L5 .. L6
  L4(L5)
  L4 = _UPVALUE2_
  L5 = _UPVALUE3_
  L5 = L5.lines
  L6 = L3
  L5, L6, L7, L8 = L5(L6)
  L4 = L4(L5, L6, L7, L8)
  L5 = _UPVALUE1_
  L5 = L5.remove
  L6 = L3
  L5(L6)
  return L4
end
function L13(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "info"
  L3 = A0
  return L1(L2, L3)
end
info = L13
function L13(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "status"
  L3 = A0
  return L1(L2, L3)
end
status = L13
function L13(...)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "install"
  L3 = ...
  return L1(L2, L3)
end
install = L13
function L13(A0)
  local L1, L2
  L1 = status
  L2 = A0
  L1 = L1(L2)
  L1 = L1[A0]
  L2 = L1 or L2
  if L1 then
    L2 = L1.Status
    if L2 then
      L2 = L1.Status
      L2 = L2.installed
    end
  end
  return L2
end
installed = L13
function L13(...)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = "remove"
  L3 = ...
  return L1(L2, L3)
end
remove = L13
function L13()
  local L0, L1
  L0 = _UPVALUE0_
  L1 = "update"
  return L0(L1)
end
update = L13
function L13()
  local L0, L1
  L0 = _UPVALUE0_
  L1 = "upgrade"
  return L0(L1)
end
upgrade = L13
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = _UPVALUE0_
  L3 = L3.popen
  L4 = _UPVALUE1_
  L5 = " "
  L6 = A0
  if A1 then
    L8 = A1
    L7 = A1.gsub
    L9 = "'"
    L10 = ""
    L7 = L7(L8, L9, L10)
    L7 = " '%s'" % L7
    if L7 then
      goto lbl_16
    end
  end
  L7 = ""
  ::lbl_16::
  L4 = L4 .. L5 .. L6 .. L7
  L3 = L3(L4)
  if L3 then
    L4, L5, L6 = nil, nil, nil
    while true do
      L8 = L3
      L7 = L3.read
      L9 = "*l"
      L7 = L7(L8, L9)
      if not L7 then
        break
      end
      L9 = L7
      L8 = L7.match
      L10 = "^(.-) %- (.-) %- (.+)"
      L8, L9, L10 = L8(L9, L10)
      L6 = L10
      L5 = L9
      L4 = L8
      if not L4 then
        L9 = L7
        L8 = L7.match
        L10 = "^(.-) %- (.+)"
        L8, L9 = L8(L9, L10)
        L5 = L9
        L4 = L8
        L6 = ""
      end
      L8 = A2
      L9 = L4
      L10 = L5
      L11 = L6
      L8(L9, L10, L11)
      L4, L5, L6 = nil, nil, nil
    end
    L8 = L3
    L7 = L3.close
    L7(L8)
  end
end
_list = L13
function L13(A0, A1)
  local L2, L3, L4, L5
  L2 = _list
  L3 = "list"
  L4 = A0
  L5 = A1
  L2(L3, L4, L5)
end
list_all = L13
function L13(A0, A1)
  local L2, L3, L4, L5
  L2 = _list
  L3 = "list_installed"
  L4 = A0
  L5 = A1
  L2(L3, L4, L5)
end
list_installed = L13
function L13(A0, A1)
  local L2, L3, L4, L5
  L2 = _list
  L3 = "find"
  L4 = A0
  L5 = A1
  L2(L3, L4, L5)
end
find = L13
function L13()
  local L0, L1, L2, L3, L4, L5
  L0 = "/"
  L1 = _UPVALUE0_
  L1 = L1.open
  L2 = _UPVALUE1_
  L3 = "r"
  L1 = L1(L2, L3)
  if L1 then
    L2 = nil
    repeat
      L4 = L1
      L3 = L1.read
      L5 = "*l"
      L3 = L3(L4, L5)
      L2 = L3
      if L2 then
        L4 = L2
        L3 = L2.match
        L5 = "^%s*option%s+overlay_root%s+"
        L3 = L3(L4, L5)
        if L3 then
          L4 = L2
          L3 = L2.match
          L5 = "^%s*option%s+overlay_root%s+(%S+)"
          L3 = L3(L4, L5)
          L0 = L3
          L3 = _UPVALUE2_
          L3 = L3.stat
          L4 = L0
          L3 = L3(L4)
          if L3 then
            L4 = L3.type
            if L4 == "dir" then
              break
            end
          end
          L0 = "/"
          break
        end
      end
    until not L2
    L4 = L1
    L3 = L1.close
    L3(L4)
  end
  return L0
end
overlay_root = L13
