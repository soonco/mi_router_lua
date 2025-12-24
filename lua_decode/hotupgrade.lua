local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "hotupgrade"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.fs"
L0 = L0(L1)
L1 = require
L2 = "luci.util"
L1 = L1(L2)
L2 = require
L3 = "json"
L2 = L2(L3)
L3 = require
L4 = "posix"
L3 = L3(L4)
L4 = require
L5 = "xiaoqiang.util.XQDownloadUtil"
L4 = L4(L5)
L5 = require
L6 = "xiaoqiang.common.XQFunction"
L5 = L5(L6)
function L6(...)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L4 = LOG_USER
  L1(L2, L3, L4)
  L4, L5, L6, L7, L8, L9 = ...
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L2[4] = L6
  L2[5] = L7
  L2[6] = L8
  L2[7] = L9
  for L4, L5 in L1, L2, L3 do
    L6 = _UPVALUE0_
    L6 = L6.syslog
    L7 = 4
    L8 = _UPVALUE1_
    L8 = L8.serialize_data
    L9 = L5
    L8, L9 = L8(L9)
    L6(L7, L8, L9)
  end
  L1()
end
hotupgrade_log = L6
function L6(A0, A1)
  local L2, L3, L4, L5
  if A0 == nil then
    L2 = nil
    return L2
  end
  L2, L3 = nil, nil
  L4 = _UPVALUE0_
  L4 = L4.syncDownloadV2
  L5 = A0
  L4, L5 = L4(L5)
  L3 = L5
  L2 = L4
  if not L2 or not L3 then
    L4 = hotupgrade_log
    L5 = "Download patch file failed"
    L4(L5)
    L4 = nil
    return L4
  end
  if L2 ~= A1 then
    L4 = nil
    return L4
  end
  L4 = _UPVALUE1_
  L4 = L4.access
  L5 = L3
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE1_
    L4 = L4.unlink
    L5 = L3
    L4(L5)
    L4 = nil
    return L4
  end
  return L3
end
hotupgrade_download = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  if A0 then
    if L1 then
      if L1 then
        goto lbl_11
      end
    end
  end
  do return end
  ::lbl_11::
  for L4, L5 in L1, L2, L3 do
    L6, L7, L8, L9 = nil, nil, nil, nil
    L6 = L5.hotupgradeName
    L9 = false
    L10 = L5.hotupgradeName
    if L10 then
      L10 = L5.link
      if L10 then
        L10 = L5.hash
        if L10 then
          L10 = _UPVALUE0_
          L10 = L10.encode
          L11 = L5
          L10 = L10(L11)
          L11 = hotupgrade_log
          L12 = "Execute /usr/sbin/hotupgrade.sh check "
          L13 = L6
          L14 = " "
          L15 = L10
          L12 = L12 .. L13 .. L14 .. L15
          L11(L12)
          L11 = _UPVALUE1_
          L11 = L11.waitExec
          L12 = "/usr/sbin/hotupgrade.sh"
          L13 = "check"
          L14 = L6
          L15 = L10
          L11, L12 = L11(L12, L13, L14, L15)
          L8 = L12
          L4 = L11
          if L8 ~= 0 then
            L9 = true
          end
          if L9 == false then
            L11 = hotupgrade_download
            L12 = L5.link
            L13 = L5.hash
            L11 = L11(L12, L13)
            L7 = L11
            if L7 then
              L11 = hotupgrade_log
              L12 = "Execute /usr/sbin/hotupgrade.sh"
              L11(L12)
              L11 = _UPVALUE1_
              L11 = L11.waitExec
              L12 = "/usr/sbin/hotupgrade.sh"
              L13 = L7
              L11, L12 = L11(L12, L13)
              L8 = L12
              L4 = L11
              if L8 ~= 0 then
                L11 = _UPVALUE2_
                L11 = L11.unlink
                L12 = L7
                L11(L12)
              end
            end
          end
        end
      end
    end
  end
end
hotupgrade_upgrade = L6
