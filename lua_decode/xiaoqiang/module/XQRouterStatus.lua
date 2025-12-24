local L0, L1, L2, L3, L4, L5, L6, L7
L0 = module
L1 = "xiaoqiang.module.XQRouterStatus"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQFunction"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQConfigs"
L2 = L2(L3)
function L3()
  local L0, L1, L2, L3
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1.thrift_tunnel_to_datacenter
  L2 = "{\"api\":1}"
  L1 = L1(L2)
  if L1 then
    L2 = L1.code
    if L2 == 0 then
      L2 = L1.exist
      if L2 == 1 then
        L2 = _UPVALUE0_
        L2 = L2.thrift_tunnel_to_datacenter
        L3 = "{\"api\":62}"
        L2 = L2(L3)
        if L2 then
          L3 = L2.code
          if L3 == 0 then
            L3 = L2.status
            L0.status = L3
            L3 = L2.progress
            L0.progress = L3
        end
        else
          L0.status = -1
          L0.progress = 0
        end
        L0.extdisk = 1
      else
        L0.extdisk = 0
        L0.status = 0
        L0.progress = 0
      end
  end
  else
    L0.status = 0
    L0.progress = 0
    L0.extdisk = 0
  end
  return L0
end
function L4()
  local L0, L1, L2, L3, L4
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = L1.getWanLanNetworkStatistics
  L3 = "wan"
  L2 = L2(L3)
  if L2 then
    L3 = tonumber
    L4 = L2.downspeed
    L3 = L3(L4)
    L3 = L3 or L3
    L0.speed = L3
    L3 = tonumber
    L4 = L2.maxdownloadspeed
    L3 = L3(L4)
    L3 = L3 or L3
    L0.maxspeed = L3
  else
    L0.speed = 0
    L0.maxspeed = 0
  end
  return L0
end
function L5()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.util.XQDeviceUtil"
  L1 = L1(L2)
  L2 = L1.getDeviceCount
  L2, L3, L4, L5 = L2()
  L0.online = L2
  L0.all = L3
  L0.online_without_mash = L4
  L0.all_without_mash = L5
  return L0
end
L6 = {}
L6.usb_status = L3
L6.wan_status = L4
L6.dev_status = L5
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = {}
  if L2 then
    for L5, L6 in L2, L3, L4 do
      L7 = L6
      L7 = L7()
      L1[L5] = L7
    end
  elseif L2 then
    for L6, L7 in L3, L4, L5 do
      L8 = nil
      L9 = _UPVALUE1_
      L9 = L9[L7]
      if L9 then
        L10 = L9
        L10 = L10()
        L8 = L10
      end
      if L8 then
        L1[L7] = L8
      end
    end
  end
  return L1
end
getStatus = L7
