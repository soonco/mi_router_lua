local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
L0 = module
L1 = "xiaoqiang.module.XQTimeMachine"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "luci.util"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.XQLog"
L2 = L2(L3)
L3 = require
L4 = "luci.model.uci"
L3 = L3(L4)
L3 = L3.cursor
L3 = L3()
L4 = "/tmp/etc/storage"
L5 = "/etc/config/timemachine"
L6 = "/usr/sbin/timemachine.sh"
L7 = 7
function L8()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = _UPVALUE1_
  L2 = " start"
  L1 = L1 .. L2
  L0(L1)
end
function L9()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = _UPVALUE1_
  L2 = " stop"
  L1 = L1 .. L2
  L0(L1)
end
function L10(A0)
  local L1, L2, L3, L4
  L1 = string
  L1 = L1.format
  L2 = "block info | grep '"
  L3 = A0
  L4 = "' | awk -F ':' '{print $1}' | awk -F '/' '{print $3}'"
  L2 = L2 .. L3 .. L4
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.trim
  L3 = _UPVALUE0_
  L3 = L3.exec
  L4 = L1
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  return L2
end
function L11()
  local L0, L1, L2, L3
  L0 = 0
  L1 = _UPVALUE0_
  L1 = L1.exec
  L2 = "block info"
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L0 = 1
  end
  return L0
end
function L12(A0)
  local L1, L2, L3, L4
  L1 = 0
  L2 = _UPVALUE0_
  L2 = L2.exec
  L3 = "block info | grep "
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L1 = 1
  end
  return L1
end
function L13(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L4 = 0
  L5 = require
  L6 = "xiaoqiang.module.XQStorage"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = "timemachine"
  L9 = "config"
  L10 = "enabled"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "timemachine"
  L10 = "config"
  L11 = "uuid"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L8 = _UPVALUE0_
  L9 = L8
  L8 = L8.get
  L10 = "timemachine"
  L11 = "config"
  L12 = "size"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L9 = _UPVALUE0_
  L10 = L9
  L9 = L9.get
  L11 = "timemachine"
  L12 = "config"
  L13 = "password"
  L9 = L9(L10, L11, L12, L13)
  L9 = L9 or L9
  L10 = L5.getStorageUuidByMountPath
  L11 = A1
  L10 = L10(L11)
  L11 = tonumber
  L12 = A0
  L11 = L11(L12)
  if L11 then
    L11 = tonumber
    L12 = A0
    L11 = L11(L12)
    if L11 == 0 then
      L11 = _UPVALUE0_
      L12 = L11
      L11 = L11.set
      L13 = "timemachine"
      L14 = "config"
      L15 = "enabled"
      L16 = A0
      L11(L12, L13, L14, L15, L16)
      L11 = _UPVALUE0_
      L12 = L11
      L11 = L11.commit
      L13 = "timemachine"
      L11(L12, L13)
      L11 = _UPVALUE1_
      L11 = L11.log
      L12 = _UPVALUE2_
      L13 = "TimeMachine stopTimeMachineServic"
      L11(L12, L13)
      L11 = _UPVALUE3_
      L11()
    elseif L6 ~= A0 or L8 ~= A2 or L7 ~= L10 or L9 ~= A3 then
      L11 = _UPVALUE4_
      L11 = L11.isStrNil
      L12 = L10
      L11 = L11(L12)
      if L11 then
        L4 = 1589
        return L4
      end
      L11 = _UPVALUE0_
      L12 = L11
      L11 = L11.set
      L13 = "timemachine"
      L14 = "config"
      L15 = "uuid"
      L16 = L10
      L11(L12, L13, L14, L15, L16)
      L11 = _UPVALUE0_
      L12 = L11
      L11 = L11.set
      L13 = "timemachine"
      L14 = "config"
      L15 = "enabled"
      L16 = A0
      L11(L12, L13, L14, L15, L16)
      L11 = _UPVALUE0_
      L12 = L11
      L11 = L11.set
      L13 = "timemachine"
      L14 = "config"
      L15 = "path"
      L16 = A1
      L11(L12, L13, L14, L15, L16)
      L11 = _UPVALUE0_
      L12 = L11
      L11 = L11.set
      L13 = "timemachine"
      L14 = "config"
      L15 = "size"
      L16 = A2
      L11(L12, L13, L14, L15, L16)
      L11 = _UPVALUE0_
      L12 = L11
      L11 = L11.set
      L13 = "timemachine"
      L14 = "config"
      L15 = "password"
      L16 = A3
      L11(L12, L13, L14, L15, L16)
      L11 = _UPVALUE0_
      L12 = L11
      L11 = L11.commit
      L13 = "timemachine"
      L11(L12, L13)
      L11 = _UPVALUE1_
      L11 = L11.log
      L12 = _UPVALUE2_
      L13 = "TimeMachine startTimeMachineService"
      L11(L12, L13)
      L11 = _UPVALUE5_
      L11()
    end
  else
    L4 = 1523
  end
  return L4
end
setTimeMachineInfo = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "timemachine"
  L4 = "config"
  L5 = "uuid"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = _UPVALUE1_
  L2 = L2()
  L3 = _UPVALUE2_
  L3 = L3.isStrNil
  L4 = L1
  L3 = L3(L4)
  if L3 then
    if L2 == 0 then
      L0.bindStatus = "0"
    else
      L0.bindStatus = "1"
    end
  else
    L3 = _UPVALUE3_
    L4 = L1
    L3 = L3(L4)
    if L2 == 0 then
      L0.bindStatus = "2"
    elseif L3 == 0 then
      L0.bindStatus = "4"
    else
      L0.bindStatus = "3"
    end
  end
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "timemachine"
  L6 = "config"
  L7 = "enabled"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L0.enabled = L3
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "timemachine"
  L6 = "config"
  L7 = "path"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L0.path = L3
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "timemachine"
  L6 = "config"
  L7 = "size"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L0.size = L3
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "timemachine"
  L6 = "config"
  L7 = "password"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L0.password = L3
  return L0
end
getTimeMachineInfo = L13
