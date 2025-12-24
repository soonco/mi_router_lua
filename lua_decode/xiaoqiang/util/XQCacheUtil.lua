local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "xiaoqiang.util.XQCacheUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "luci.util"
L2 = L2(L3)
L3 = require
L4 = "luci.sys"
L3 = L3(L4)
L4 = require
L5 = "nixio"
L4 = L4(L5)
L5 = require
L6 = "nixio.fs"
L5 = L5(L6)
function L6(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if not (not L3 and A1) or not A2 then
    L3 = false
    return L3
  end
  L3 = "/tmp/"
  L4 = A0
  L3 = L3 .. L4
  L4 = {}
  L4.data = A1
  L5 = _UPVALUE1_
  L5 = L5.uptime
  L5 = L5()
  L4.atime = L5
  L5 = tostring
  L6 = A2
  L5 = L5(L6)
  L4.expire = L5
  L5 = _UPVALUE2_
  L5 = L5.open
  L6 = L3
  L7 = "w"
  L8 = 600
  L5 = L5(L6, L7, L8)
  L7 = L5
  L6 = L5.writeall
  L8 = _UPVALUE3_
  L8 = L8.get_bytecode
  L9 = L4
  L8, L9 = L8(L9)
  L6(L7, L8, L9)
  L7 = L5
  L6 = L5.close
  L6(L7)
  L6 = true
  return L6
end
saveCache = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = "/tmp/"
  L2 = A0
  L1 = L1 .. L2
  L2 = _UPVALUE1_
  L2 = L2.access
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L2 = nil
    return L2
  end
  L2 = _UPVALUE1_
  L2 = L2.readfile
  L3 = L1
  L2 = L2(L3)
  L3 = loadstring
  L4 = L2
  L3 = L3(L4)
  L4 = setfenv
  L5 = L3
  L6 = {}
  L4(L5, L6)
  L4 = L3
  L4 = L4()
  L5 = L4.atime
  if L5 then
    L5 = L4.expire
    if L5 then
      L5 = tonumber
      L6 = L4.expire
      L5 = L5(L6)
      if 0 < L5 then
        L5 = L4.atime
        L6 = L4.expire
        L5 = L5 + L6
        L6 = _UPVALUE2_
        L6 = L6.uptime
        L6 = L6()
        if L5 < L6 then
          L5 = _UPVALUE1_
          L5 = L5.unlink
          L6 = L1
          L5(L6)
          L5 = nil
          return L5
        end
      end
    end
  end
  L5 = L4.data
  return L5
end
getCache = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = "/tmp/"
  L2 = A0
  L1 = L1 .. L2
  L2 = _UPVALUE1_
  L2 = L2.access
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L2 = nil
    return L2
  end
  L2 = _UPVALUE1_
  L2 = L2.readfile
  L3 = L1
  L2 = L2(L3)
  L3 = loadstring
  L4 = L2
  L3 = L3(L4)
  L4 = setfenv
  L5 = L3
  L6 = {}
  L4(L5, L6)
  L4 = L3
  L4 = L4()
  L5 = L4.atime
  if L5 then
    L5 = L4.expire
    if L5 then
      L5 = tonumber
      L6 = L4.expire
      L5 = L5(L6)
      if 0 < L5 then
        L5 = L4.atime
        L6 = L4.expire
        L5 = L5 + L6
        L6 = _UPVALUE2_
        L6 = L6.uptime
        L6 = L6()
        if L5 < L6 then
          L5 = L4.data
          L5.active = 0
          L5 = _UPVALUE1_
          L5 = L5.unlink
          L6 = L1
          L5(L6)
      end
    end
  end
  else
    L5 = L4.data
    L5.active = 1
  end
  L5 = L4.data
  return L5
end
getCacheData = L6
function L6(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = "/tmp/"
  L2 = A0
  L1 = L1 .. L2
  L2 = _UPVALUE1_
  L2 = L2.access
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = _UPVALUE1_
    L2 = L2.unlink
    L3 = L1
    L2(L3)
  end
  L2 = true
  return L2
end
rmCacheData = L6
