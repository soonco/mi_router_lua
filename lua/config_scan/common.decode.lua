local L0, L1, L2
L0 = module
L1 = "config_scan.common"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = "/usr/lib/lua/config_scan"
SCAN_SCRIPTS_DIR = L0
L0 = 0
WORK_STATUS_WAIT = L0
L0 = 1
WORK_STATUS_RUNNING = L0
L0 = 2
WORK_STATUS_DONE = L0
function L0(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "posix"
  L1 = L1(L2)
  L2 = A0 / 1000
  L3 = {}
  L3.tv_sec = L2
  L4 = L2 % 1
  L4 = L4 * 1000000000
  L3.tv_nsec = L4
  L4 = L1.nanosleep
  L5 = L3
  L4(L5)
end
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = A0
  L3 = "/meta"
  L2 = L2 .. L3
  L3 = require
  L4 = "nixio"
  L3 = L3(L4)
  L4 = L3.fs
  L4 = L4.mkdir
  L4(L5)
  L4 = L3.open
  L4 = L4(L5, L6)
  L5(L6, L7)
  L5(L6)
  if not A1 then
    return
  end
  for L8, L9 in L5, L6, L7 do
    L10 = require
    L11 = "config_scan."
    L12 = L9.name
    L11 = L11 .. L12
    L10 = L10(L11)
    L11 = A0
    L12 = "/"
    L13 = L9.name
    L11 = L11 .. L12 .. L13
    L12 = L3.fs
    L12 = L12.mkdir
    L13 = L11
    L12(L13)
    L12 = L10.prepare
    L13 = L11
    L12(L13)
  end
end
prepare_status = L1
function L1(A0, A1)
  local L2, L3, L4, L5
  L2 = nixio
  L2 = L2.open
  L3 = A0
  L4 = "/score"
  L3 = L3 .. L4
  L4 = "w"
  L2 = L2(L3, L4)
  L4 = L2
  L3 = L2.write
  L5 = A1
  L3(L4, L5)
  L4 = L2
  L3 = L2.close
  L3(L4)
end
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L2 = A0
  L3 = "/meta"
  L2 = L2 .. L3
  L3 = 0
  L4 = 0
  for L8, L9 in L5, L6, L7 do
    L10 = L9.weight
    L4 = L4 + L10
  end
  L6(L7)
  L7(L8, L9)
  L7(L8, L9)
  for L10, L11 in L7, L8, L9 do
    L12 = require
    L13 = "config_scan."
    L14 = L11.name
    L13 = L13 .. L14
    L12 = L12(L13)
    L13 = A0
    L14 = "/"
    L15 = L11.name
    L13 = L13 .. L14 .. L15
    L14 = L5.fs
    L14 = L14.mkdir
    L15 = L13
    L14(L15)
    L14 = coroutine
    L14 = L14.create
    function L15()
      local L0, L1
      L0 = _UPVALUE0_
      L0 = L0.scan
      L1 = _UPVALUE1_
      return L0(L1)
    end
    L14 = L14(L15)
    L15 = L11.weight
    L15 = L15 / L4
    L16 = 0
    while true do
      L17 = coroutine
      L17 = L17.status
      L18 = L14
      L17 = L17(L18)
      if L17 == "dead" then
        break
      end
      L17 = coroutine
      L17 = L17.resume
      L18 = L14
      L17, L18 = L17(L18)
      L16 = L15 * L18
      L19 = _UPVALUE0_
      L20 = L2
      L21 = L3 + L16
      L19(L20, L21)
      L19 = coroutine
      L19 = L19.yield
      L20 = L3 + L16
      L19(L20)
    end
    L3 = L3 + L16
  end
  L10 = "set"
  L7(L8, L9, L10)
  L7(L8, L9)
  L7(L8)
  return L3
end
scan_submod = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = A0
  L3 = "/meta"
  L2 = L2 .. L3
  L3 = 0
  L4 = require
  L5 = "nixio"
  L4 = L4(L5)
  L5 = L4.fs
  L5 = L5.mkdir
  L6 = L2
  L5(L6)
  L5 = L4.open
  L6 = L2
  L7 = "/status"
  L6 = L6 .. L7
  L7 = "w"
  L5 = L5(L6, L7)
  L7 = L5
  L6 = L5.write
  L8 = WORK_STATUS_RUNNING
  L6(L7, L8)
  L6 = L4.open
  L7 = L2
  L8 = "/score"
  L7 = L7 .. L8
  L8 = "w"
  L6 = L6(L7, L8)
  L8 = L6
  L7 = L6.write
  L9 = L3
  L7(L8, L9)
  L7 = _UPVALUE0_
  L8 = math
  L8 = L8.random
  L9 = 200
  L8 = L8(L9)
  L8 = 200 + L8
  L7(L8)
  L7 = A1
  L7 = L7()
  L3 = L7
  L8 = L6
  L7 = L6.seek
  L9 = 0
  L10 = "set"
  L7(L8, L9, L10)
  L8 = L6
  L7 = L6.write
  L9 = L3
  L7(L8, L9)
  L8 = L6
  L7 = L6.close
  L7(L8)
  L8 = L5
  L7 = L5.seek
  L9 = 0
  L10 = "set"
  L7(L8, L9, L10)
  L8 = L5
  L7 = L5.write
  L9 = WORK_STATUS_DONE
  L7(L8, L9)
  L8 = L5
  L7 = L5.close
  L7(L8)
  return L3
end
scan_leaf = L2
