local L0, L1, L2
L0 = module
L1 = "xiaoqiang.module.XQPredownload"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "otapred"
  L6 = "settings"
  L7 = "auto"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2 = L2(L3)
  L1.auto = L2
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "otapred"
  L6 = "settings"
  L7 = "time"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2 = L2(L3)
  L1.time = L2
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "otapred"
  L6 = "settings"
  L7 = "priority"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2 = L2(L3)
  L1.priority = L2
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "otapred"
  L6 = "settings"
  L7 = "plugin"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2 = L2(L3)
  L1.plugin = L2
  return L1
end
predownloadInfo = L2
function L2(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = tonumber
  L6 = A0
  L5 = L5(L6)
  if L5 then
    L6 = L4
    L5 = L4.set
    L7 = "otapred"
    L8 = "settings"
    L9 = "priority"
    L10 = A0
    L5(L6, L7, L8, L9, L10)
  end
  L5 = tonumber
  L6 = A1
  L5 = L5(L6)
  if L5 then
    L6 = L4
    L5 = L4.set
    L7 = "otapred"
    L8 = "settings"
    L9 = "auto"
    L10 = A1
    L5(L6, L7, L8, L9, L10)
  end
  L5 = tonumber
  L6 = A2
  L5 = L5(L6)
  if L5 then
    L5 = tonumber
    L6 = A2
    L5 = L5(L6)
    if 0 <= L5 then
      L5 = tonumber
      L6 = A2
      L5 = L5(L6)
      if L5 < 24 then
        L6 = L4
        L5 = L4.set
        L7 = "otapred"
        L8 = "settings"
        L9 = "time"
        L10 = A2
        L5(L6, L7, L8, L9, L10)
      end
    end
  end
  L5 = tonumber
  L6 = A3
  L5 = L5(L6)
  if L5 then
    L6 = L4
    L5 = L4.set
    L7 = "otapred"
    L8 = "settings"
    L9 = "plugin"
    L10 = A3
    L5(L6, L7, L8, L9, L10)
  end
  L6 = L4
  L5 = L4.commit
  L7 = "otapred"
  L5(L6, L7)
end
setPredownload = L2
function L2(A0)
  local L1, L2, L3
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  if A0 then
    L2 = os
    L2 = L2.execute
    L3 = "/etc/init.d/predownload-ota start"
    L2 = L2(L3)
    L2 = L2 == 0
    return L2
  else
    L2 = os
    L2 = L2.execute
    L3 = "/etc/init.d/predownload-ota stop"
    L2 = L2(L3)
    L2 = L2 == 0
    return L2
  end
end
switch = L2
function L2()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "/etc/init.d/predownload-ota restart"
  L0(L1)
end
reload = L2
