local L0, L1, L2
L0 = module
L1 = "xiaoqiang.module.XQNetworkNetDiagnose"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQFunction"
L1 = L1(L2)
L2 = {}
L2["1"] = "wan port unplug"
L2["2"] = "dhcp no server"
L2["3"] = "pppoe no reaponse"
L2["4"] = "dhcp upstream conflict"
L2["5"] = "gateway unreachable"
L2["6"] = "dns resolve failed"
L2["7"] = "dns custom set"
L2["8"] = "wifi_ap gateway unreachable"
L2["9"] = "wired_ap gateway unreachable"
L2["10"] = "link broken"
L2["11"] = "whc_re gateway unreachable"
L2["31"] = "pppoe no more sesson"
L2["32"] = "pppoe password error"
L2["33"] = "pppoe account not valid"
L2["34"] = "pppoe need reset mac"
L2["35"] = "pppoe stop by user"
NETTB = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = io
  L1 = L1.popen
  L2 = A0
  L1 = L1(L2)
  L2 = ""
  L3 = {}
  while true do
    L5 = L1
    L4 = L1.read
    L4 = L4(L5)
    L2 = L4
    if L2 == nil then
      break
    end
    L4 = #L3
    L4 = L4 + 1
    L3[L4] = L2
  end
  L5 = L1
  L4 = L1.close
  L4(L5)
  return L3
end
execl2 = L2
function L2(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  if A0 then
    L2 = L1.set
    L3 = "NETTB"
    L4 = A0
    L2(L3, L4)
  end
end
saveNettb = L2
function L2()
  local L0, L1, L2, L3
  L0 = io
  L0 = L0.popen
  L1 = "uci -q get network.wan.proto"
  L0 = L0(L1)
  L2 = L0
  L1 = L0.read
  L3 = "*line"
  L1 = L1(L2, L3)
  L3 = L0
  L2 = L0.close
  L2(L3)
  return L1
end
getWanMode = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = execl2
  L1 = "cat /tmp/resolv.conf.auto"
  L0 = L0(L1)
  L1 = nil
  if L0 then
    L2 = next
    L2 = L2(L3)
    if L2 ~= nil then
      L2 = 0
      for L6, L7 in L3, L4, L5 do
        if 2 < L2 then
          break
        end
        L8 = string
        L8 = L8.find
        L9 = L7
        L10 = "nameserver ([0-9]+%.[0-9]+%.[0-9]+%.[0-9]+)"
        L8, L9, L10 = L8(L9, L10)
        if L10 then
          L2 = L2 + 1
          if L1 then
            L11 = L1
            L12 = " "
            L13 = L10
            L1 = L11 .. L12 .. L13
          else
            L1 = L10
          end
        end
      end
      if L1 then
        return L1
      else
        return L3
      end
  end
  else
    L2 = "0"
    return L2
  end
end
getDnsIp = L2
function L2()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "xiaoqiang.XQPreference"
  L0 = L0(L1)
  L1 = tonumber
  L2 = L0.get
  L3 = "NETTB"
  L2, L3, L4 = L2(L3)
  L1 = L1(L2, L3, L4)
  if L1 then
    if L1 == 99 then
      L2 = L1
      L3 = "detecting..."
      return L2, L3
    elseif L1 == 0 then
      L2 = L1
      L3 = "network ok!"
      return L2, L3
    else
      L2 = NETTB
      L3 = tostring
      L4 = L1
      L3 = L3(L4)
      L2 = L2[L3]
      if L2 then
        L3 = L1
        L4 = L2
        return L3, L4
      end
      L3 = -1
      L4 = "unknown nettb code!"
      return L3, L4
    end
  else
    L2 = -2
    L3 = "no diag result!"
    return L2, L3
  end
end
getNetDiagResult = L2
function L2()
  local L0, L1
  L0 = saveNettb
  L1 = "99"
  L0(L1)
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = "lua /usr/sbin/do_net_diagose.lua"
  L0(L1)
end
asyncNetDiag = L2
