local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24
L0 = module
L1 = "xiaoqiang.module.XQStorage"
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
L5 = "/etc/init.d/samba"
L6 = "/usr/sbin/storage"
L7 = "/usr/sbin/swap"
function L8()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = _UPVALUE1_
  L2 = " restart"
  L1 = L1 .. L2
  L0(L1)
end
function L9()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = _UPVALUE1_
  L2 = " restart"
  L1 = L1 .. L2
  L0(L1)
end
function L10()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = _UPVALUE1_
  L2 = " stop"
  L1 = L1 .. L2
  L0(L1)
end
function L11()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = _UPVALUE1_
  L2 = " start"
  L1 = L1 .. L2
  L0(L1)
end
function L12(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.forkExec
  L2 = _UPVALUE1_
  L3 = " del_swap "
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1(L2)
end
function L13(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.forkExec
  L2 = _UPVALUE1_
  L3 = " add_swap "
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1(L2)
end
function L14(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.exec
  L2 = _UPVALUE1_
  L3 = " umount "
  L4 = A0
  L2 = L2 .. L3 .. L4
  return L1(L2)
end
function L15()
  local L0, L1, L2, L3
  L0 = math
  L0 = L0.ceil
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.exec
  L3 = "free|grep Swap|awk '{print $2}'"
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  L1 = L1 / 1024
  L0 = L0(L1)
  L0 = L0 or L0
  return L0
end
function L16()
  local L0, L1, L2, L3
  L0 = math
  L0 = L0.modf
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.exec
  L3 = "free|grep Swap|awk '{print $3}'"
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  L1 = L1 / 1024
  L0 = L0(L1)
  L0 = L0 or L0
  return L0
end
function L17()
  local L0, L1, L2, L3
  L0 = math
  L0 = L0.modf
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.exec
  L3 = "free|grep Mem|awk '{print $3}'"
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  L1 = L1 / 1024
  L0 = L0(L1)
  L0 = L0 or L0
  return L0
end
function L18()
  local L0, L1, L2, L3
  L0 = math
  L0 = L0.modf
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.exec
  L3 = "free|grep Mem|awk '{print $7}'"
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  L1 = L1 / 1024
  L0 = L0(L1)
  L0 = L0 or L0
  return L0
end
function L19(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.exec
  L2 = _UPVALUE1_
  L3 = " used "
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1 = L1(L2)
  L3 = L1
  L2 = L1.sub
  L4 = 1
  L5 = #L1
  L5 = L5 - 1
  L2 = L2(L3, L4, L5)
  L1 = L2
  L2 = tonumber
  L3 = L1
  L4 = ".0"
  L3 = L3 .. L4
  L2 = L2(L3)
  L2 = L2 or L2
  return L2
end
function L20(A0)
  local L1, L2, L3
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
  end
  return L1
end
function L21(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get_all
  L3 = "storage"
  L4 = A0
  L1 = L1(L2, L3, L4)
  L1 = L1 or L1
  return L1
end
function L22(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L2 = L1.uuid
    if L2 then
      goto lbl_10
    end
  end
  L2 = nil
  ::lbl_10::
  return L2
end
function L23(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L2 = L1.target
    if L2 then
      goto lbl_10
    end
  end
  L2 = nil
  ::lbl_10::
  return L2
end
function L24(A0)
  local L1, L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.load
  L4 = _UPVALUE1_
  L2(L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.foreach
  L4 = "storage"
  L5 = "partition"
  function L6(A0)
    local L1, L2
    L1 = A0.uuid
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = A0[".name"]
      _UPVALUE1_ = L1
    end
  end
  L2(L3, L4, L5, L6)
  if L1 then
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.get_all
    L4 = "storage"
    L5 = L1
    L2 = L2(L3, L4, L5)
    if L2 then
      goto lbl_23
    end
  end
  L2 = nil
  ::lbl_23::
  return L2
end
getStorageInfoByUuid = L24
function L24(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = nil
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.load
  L4 = _UPVALUE2_
  L2(L3, L4)
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.foreach
  L4 = "storage"
  L5 = "partition"
  function L6(A0)
    local L1, L2
    L1 = A0.uuid
    L2 = _UPVALUE0_
    if L1 == L2 then
      L2 = A0.target
      _UPVALUE1_ = L2
    end
  end
  L2(L3, L4, L5, L6)
  return L1
end
getStorageMountPathByUuid = L24
function L24(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = nil
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.load
  L4 = _UPVALUE2_
  L2(L3, L4)
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.foreach
  L4 = "storage"
  L5 = "partition"
  function L6(A0)
    local L1, L2
    L1 = A0.target
    L2 = _UPVALUE0_
    if L1 == L2 then
      L2 = A0.uuid
      _UPVALUE1_ = L2
    end
  end
  L2(L3, L4, L5, L6)
  return L1
end
getStorageUuidByMountPath = L24
function L24(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = tonumber
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "swap"
  L6 = "swap0"
  L7 = "granularity"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2 = L2(L3)
  L3 = math
  L3 = L3.modf
  L4 = tonumber
  L5 = A1
  L4 = L4(L5)
  L4 = L4 / L2
  L3 = L3(L4)
  A1 = L3
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "swap"
  L6 = "swap0"
  L7 = "uuid"
  L3 = L3(L4, L5, L6, L7)
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = "swap"
  L7 = "swap0"
  L8 = "size"
  L4 = L4(L5, L6, L7, L8)
  L5 = getStorageMountPathByUuid
  L6 = L3
  L5 = L5(L6)
  if A0 ~= L3 or L4 ~= A1 then
    L6 = _UPVALUE1_
    L6 = L6.isStrNil
    L7 = L5
    L6 = L6(L7)
    if not L6 then
      L6 = _UPVALUE2_
      L7 = L5
      L6(L7)
    end
    L6 = _UPVALUE0_
    L7 = L6
    L6 = L6.set
    L8 = "swap"
    L9 = "swap0"
    L10 = "uuid"
    L11 = A0
    L6(L7, L8, L9, L10, L11)
    L6 = _UPVALUE0_
    L7 = L6
    L6 = L6.set
    L8 = "swap"
    L9 = "swap0"
    L10 = "size"
    L11 = A1
    L6(L7, L8, L9, L10, L11)
    L6 = _UPVALUE0_
    L7 = L6
    L6 = L6.commit
    L8 = "swap"
    L6(L7, L8)
    L6 = _UPVALUE3_
    L6()
  end
  L6 = 0
  return L6
end
setSwapInfo = L24
function L24(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = 1502
    return L1
  end
  L1 = _UPVALUE1_
  L2 = L1
  L1 = L1.get
  L3 = "swap"
  L4 = "swap0"
  L5 = "uuid"
  L1 = L1(L2, L3, L4, L5)
  L2 = getStorageMountPathByUuid
  L3 = A0
  L2 = L2(L3)
  if L1 == A0 then
    L3 = _UPVALUE0_
    L3 = L3.isStrNil
    L4 = L2
    L3 = L3(L4)
    if not L3 then
      L3 = _UPVALUE2_
      L4 = L2
      L3(L4)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.delete
      L5 = "swap"
      L6 = "swap0"
      L7 = "uuid"
      L3(L4, L5, L6, L7)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.delete
      L5 = "swap"
      L6 = "swap0"
      L7 = "size"
      L3(L4, L5, L6, L7)
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.commit
      L5 = "swap"
      L3(L4, L5)
  end
  else
    L3 = 1523
    return L3
  end
  L3 = 0
  return L3
end
delSwap = L24
function L24()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "swap"
  L4 = "swap0"
  L5 = "uuid"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L0.uuid = L1
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "swap"
  L4 = "swap0"
  L5 = "size"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L0.size = L1
  L0.exist = 0
  L1 = getStorageMountPathByUuid
  L2 = L0.uuid
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L0.exist = 1
  end
  return L0
end
getSwapInfo = L24
function L24()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = 0
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "misc"
  L4 = "hardware"
  L5 = "memsize"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = string
  L2 = L2.upper
  L3 = string
  L3 = L3.sub
  L4 = L1
  L5 = string
  L5 = L5.len
  L6 = L1
  L5 = L5(L6)
  L5 = L5 - 1
  L3, L4, L5, L6, L7, L8, L9 = L3(L4, L5)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9)
  if L2 == "MB" then
    L3 = tonumber
    L4 = string
    L4 = L4.sub
    L5 = L1
    L6 = 0
    L7 = string
    L7 = L7.len
    L8 = L1
    L7 = L7(L8)
    L7 = L7 - 2
    L4, L5, L6, L7, L8, L9 = L4(L5, L6, L7)
    L3 = L3(L4, L5, L6, L7, L8, L9)
    L0 = L3
  elseif L2 == "GB" then
    L3 = tonumber
    L4 = string
    L4 = L4.sub
    L5 = L1
    L6 = 0
    L7 = string
    L7 = L7.len
    L8 = L1
    L7 = L7(L8)
    L7 = L7 - 2
    L4, L5, L6, L7, L8, L9 = L4(L5, L6, L7)
    L3 = L3(L4, L5, L6, L7, L8, L9)
    L0 = L3 * 1024
  elseif L2 == "KB" then
    L3 = math
    L3 = L3.modf
    L4 = tonumber
    L5 = string
    L5 = L5.sub
    L6 = L1
    L7 = 0
    L8 = string
    L8 = L8.len
    L9 = L1
    L8 = L8(L9)
    L8 = L8 - 2
    L5, L6, L7, L8, L9 = L5(L6, L7, L8)
    L4 = L4(L5, L6, L7, L8, L9)
    L4 = L4 / 1024
    L3 = L3(L4)
    L0 = L3
  end
  return L0
end
getMemTotal = L24
function L24()
  local L0, L1, L2
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1()
  L0.swaptotal = L1
  L1 = _UPVALUE1_
  L1 = L1()
  L0.swapused = L1
  L1 = getMemTotal
  L1 = L1()
  L0.memtotal = L1
  L1 = _UPVALUE2_
  L1 = L1()
  L2 = _UPVALUE3_
  L2 = L2()
  L1 = L1 - L2
  L0.memused = L1
  return L0
end
getMemInfo = L24
function L24(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = tostring
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "samba"
  L4 = "globles"
  L5 = "enabled"
  L1 = L1(L2, L3, L4, L5)
  if A0 ~= L1 then
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.set
    L4 = "samba"
    L5 = "globles"
    L6 = "enabled"
    L7 = A0
    L2(L3, L4, L5, L6, L7)
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.commit
    L4 = "samba"
    L2(L3, L4)
    L2 = _UPVALUE1_
    L2()
  end
  L2 = 0
  return L2
end
setSambaStatus = L24
function L24()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "samba"
  L3 = "globles"
  L4 = "enabled"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  return L0
end
getSambaStatus = L24
function L24(A0)
  local L1, L2, L3, L4, L5
  L1 = 0
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = 1502
    return L2
  end
  L2 = tostring
  L3 = A0
  L2 = L2(L3)
  A0 = L2
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.load
  L4 = _UPVALUE2_
  L2(L3, L4)
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.get_all
  L4 = "storage"
  L5 = A0
  L2 = L2(L3, L4, L5)
  if L2 then
    L3 = _UPVALUE3_
    L4 = A0
    L3(L4)
  else
    L1 = 1523
  end
  return L1
end
umountStorageDevice = L24
function L24()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.load
  L2 = _UPVALUE1_
  L0(L1, L2)
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.foreach
  L2 = "storage"
  L3 = "device"
  function L4(A0)
    local L1, L2, L3
    L1 = A0[".name"]
    L2 = _UPVALUE0_
    L3 = L1
    L2(L3)
  end
  L0(L1, L2, L3, L4)
  L0 = 0
  return L0
end
umountAllStorageDevices = L24
function L24()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.load
  L3 = _UPVALUE1_
  L1(L2, L3)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.foreach
  L3 = "storage"
  L4 = "device"
  function L5(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
    L1 = {}
    L2 = {}
    L3 = A0[".name"]
    L1.sid = L3
    L4 = _UPVALUE0_
    L4 = L4.get
    L8 = "vendor"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    L1.vendor = L4
    L4 = _UPVALUE0_
    L4 = L4.get
    L8 = "model"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    L1.model = L4
    L4 = _UPVALUE0_
    L4 = L4.get
    L8 = "partition"
    L4 = L4(L5, L6, L7, L8)
    L4 = L4 or L4
    if L4 ~= "" then
      for L8, L9 in L5, L6, L7 do
        L10 = {}
        L11 = _UPVALUE0_
        L12 = L11
        L11 = L11.foreach
        L13 = "storage"
        L14 = "partition"
        function L15(A0)
          local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
          L1 = A0[".name"]
          L2 = _UPVALUE0_
          L3 = L2
          L2 = L2.get
          L4 = "storage"
          L5 = L1
          L6 = "target"
          L2 = L2(L3, L4, L5, L6)
          L2 = L2 or L2
          L3 = _UPVALUE1_
          if L3 == L1 and L2 ~= "" then
            L3 = _UPVALUE2_
            L3.name = L1
            L3 = _UPVALUE2_
            L3.path = L2
            L3 = _UPVALUE2_
            L4 = _UPVALUE0_
            L5 = L4
            L4 = L4.get
            L6 = "storage"
            L7 = L1
            L8 = "label"
            L4 = L4(L5, L6, L7, L8)
            L4 = L4 or L4
            L3.label = L4
            L3 = _UPVALUE2_
            L4 = _UPVALUE0_
            L5 = L4
            L4 = L4.get
            L6 = "storage"
            L7 = L1
            L8 = "uuid"
            L4 = L4(L5, L6, L7, L8)
            L4 = L4 or L4
            L3.uuid = L4
            L3 = _UPVALUE2_
            L4 = string
            L4 = L4.upper
            L5 = _UPVALUE0_
            L6 = L5
            L5 = L5.get
            L7 = "storage"
            L8 = L1
            L9 = "type"
            L5 = L5(L6, L7, L8, L9)
            L5 = L5 or L5
            L4 = L4(L5)
            L3.fstype = L4
            L3 = _UPVALUE0_
            L4 = L3
            L3 = L3.get
            L5 = "storage"
            L6 = L1
            L7 = "size"
            L3 = L3(L4, L5, L6, L7)
            L3 = L3 or L3
            L4 = tonumber
            L5 = L3
            L6 = ".0"
            L5 = L5 .. L6
            L4 = L4(L5)
            L4 = L4 / 2
            L5 = _UPVALUE2_
            L6 = string
            L6 = L6.format
            L7 = "%.1f"
            L8 = L4 / 1048576
            L6 = L6(L7, L8)
            L7 = "GB"
            L6 = L6 .. L7
            L5.capacity = L6
            L5 = _UPVALUE3_
            L6 = L1
            L5 = L5(L6)
            L6 = _UPVALUE2_
            L7 = string
            L7 = L7.format
            L8 = "%.1f"
            L9 = L5 / 1048576
            L7 = L7(L8, L9)
            L8 = "GB"
            L7 = L7 .. L8
            L6.used = L7
            L6 = L4 - L5
            L7 = _UPVALUE2_
            L8 = string
            L8 = L8.format
            L9 = "%.1f"
            L10 = L6 / 1048576
            L8 = L8(L9, L10)
            L7.available = L8
            if 0 < L4 then
              L7 = _UPVALUE2_
              L8 = string
              L8 = L8.format
              L9 = "%.0f"
              L10 = L5 / L4
              L10 = L10 * 100
              L8 = L8(L9, L10)
              L9 = "%"
              L8 = L8 .. L9
              L7.width = L8
            end
            L7 = _UPVALUE2_
            L7.isExtDisk = true
            L7 = table
            L7 = L7.insert
            L8 = _UPVALUE4_
            L9 = _UPVALUE2_
            L7(L8, L9)
          end
        end
        L11(L12, L13, L14, L15)
      end
    end
    L1.partitionList = L2
    L5(L6, L7)
  end
  L1(L2, L3, L4, L5)
  return L0
end
getStorageDeviceList = L24
function L24()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "samba"
  L3 = "globles"
  L4 = "name"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  return L0
end
getSambaName = L24
