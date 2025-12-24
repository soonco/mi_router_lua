local L0, L1, L2, L3, L4, L5
L0 = module
L1 = "xiaoqiang.module.XQMessageBox"
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
L3 = "xiaoqiang.util.XQCacheUtil"
L2 = L2(L3)
L3 = 86400
L4 = "XQMessageBox"
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  if A0 then
    L1 = A0.type
    if L1 then
      L1 = A0.data
      if L1 then
        goto lbl_10
      end
    end
  end
  do return end
  ::lbl_10::
  L1 = _UPVALUE0_
  L1 = L1.getCache
  L2 = _UPVALUE1_
  L1 = L1(L2)
  L2 = os
  L2 = L2.time
  L2 = L2()
  A0.timestamp = L2
  if not L1 then
    L2 = {}
    L1 = L2
    L2 = table
    L2 = L2.insert
    L2(L3, L4)
  else
    L2 = false
    for L6, L7 in L3, L4, L5 do
      L8 = A0.type
      L9 = L7.type
      if L8 == L9 then
        L2 = true
        L8 = A0.data
        L7.data = L8
        break
      end
    end
    if not L2 then
      L3(L4, L5)
    end
  end
  L2 = _UPVALUE0_
  L2 = L2.saveCache
  L2(L3, L4, L5)
end
addMessage = L5
function L5()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.getCache
  L1 = _UPVALUE1_
  L0 = L0(L1)
  L0 = L0 or L0
  return L0
end
getMessages = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  if A0 then
    L1 = tonumber
    L1 = L1(L2)
    if L1 then
      L1 = _UPVALUE0_
      L1 = L1.getCache
      L1 = L1(L2)
      if L1 then
        for L5, L6 in L2, L3, L4 do
          L7 = L6.type
          L8 = tonumber
          L9 = A0
          L8 = L8(L9)
          if L7 == L8 then
            L7 = table
            L7 = L7.remove
            L8 = L1
            L9 = L5
            L7(L8, L9)
          end
        end
        L5 = _UPVALUE2_
        L2(L3, L4, L5)
      end
    end
  end
end
removeMessage = L5
