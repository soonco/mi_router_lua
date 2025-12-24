local L0, L1, L2, L3, L4
L0 = module
L1 = "xiaoqiang.util.XQUPnPUtil"
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
L3 = "xssFilter"
L2 = L2(L3)
L2 = L2.new
L2 = L2()
L3 = require
L4 = "luci.util"
L3 = L3(L4)
function L4()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = _UPVALUE0_
  L1 = L1.UPNP_STATUS
  L0 = L0(L1)
  if L0 == 0 then
    L0 = true
    return L0
  else
    L0 = false
    return L0
  end
end
getUPnPStatus = L4
function L4(A0)
  local L1, L2
  if A0 then
    L1 = os
    L1 = L1.execute
    L2 = "[ -f /etc/config/upnpd ] && sed -i 's/disable_upnp/enable_upnp/g' /etc/config/upnpd"
    L1(L2)
    L1 = os
    L1 = L1.execute
    L2 = _UPVALUE0_
    L2 = L2.UPNP_ENABLE
    return L1(L2)
  else
    L1 = os
    L1 = L1.execute
    L2 = "[ -f /etc/config/upnpd ] && sed -i 's/enable_upnp/disable_upnp/g' /etc/config/upnpd"
    L1(L2)
    L1 = os
    L1 = L1.execute
    L2 = _UPVALUE0_
    L2 = L2.UPNP_DISABLE
    return L1(L2)
  end
end
switchUPnP = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = getUPnPStatus
  L0 = L0()
  if L0 then
    L0 = _UPVALUE0_
    L0 = L0.exec
    L1 = _UPVALUE1_
    L1 = L1.UPNP_LEASE_FILE
    L0 = L0(L1)
    if L0 then
      L1 = _UPVALUE0_
      L1 = L1.trim
      L2 = L0
      L1 = L1(L2)
      L0 = L1
      L1 = io
      L1 = L1.open
      L2 = L0
      L1 = L1(L2, L3)
      if L1 then
        L2 = {}
        for L6 in L3, L4, L5 do
          L7 = _UPVALUE2_
          L7 = L7.isStrNil
          L8 = L6
          L7 = L7(L8)
          if not L7 then
            L7 = {}
            L8 = _UPVALUE3_
            L9 = L8
            L8 = L8.filter
            L10 = L6
            L8, L9 = L8(L9, L10)
            L10 = _UPVALUE0_
            L10 = L10.split
            L11 = L8
            L12 = ":"
            L13 = 5
            L10 = L10(L11, L12, L13)
            L11 = #L10
            if L11 == 6 then
              L11 = L10[1]
              L7.protocol = L11
              L11 = L10[2]
              L7.rport = L11
              L11 = L10[3]
              L7.ip = L11
              L11 = L10[4]
              L7.cport = L11
              L11 = L10[5]
              L7.time = L11
              L11 = L10[6]
              if L11 == "(null)" then
                L7.name = "\230\156\170\231\159\165\231\168\139\229\186\143"
              else
                L11 = L10[6]
                L7.name = L11
              end
              L11 = table
              L11 = L11.insert
              L12 = L2
              L13 = L7
              L11(L12, L13)
            end
          end
        end
        L3(L4)
        return L2
      end
    end
  end
  L0 = nil
  return L0
end
getUPnPList = L4
