local L0, L1, L2
L0 = module
L1 = "xiaoqiang.module.XQIPConflict"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = L0.getNetModeType
  L1 = L1()
  if 0 ~= L1 then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = string
  L2 = L2.gsub
  L3 = L1.exec
  L4 = "/usr/sbin/ip_conflict.sh wan"
  L3 = L3(L4)
  L4 = "^[%s\n\r\t]*(.-)[%s\n\r\t]*$"
  L5 = "%1"
  L2 = L2(L3, L4, L5)
  L3 = L0.isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 or L2 == "0.0.0.0" then
    L3 = false
    return L3
  end
  return L2
end
ip_conflict_detection = L0
function L0()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "/usr/sbin/ip_conflict.sh br-lan"
  L0(L1)
end
lan_ip_conflict_resolution = L0
function L0()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "xiaoqiang.module.XQMessageBox"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQEvent"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.util"
  L3 = L3(L4)
  L4 = string
  L4 = L4.gsub
  L5 = L3.exec
  L6 = "/usr/sbin/ip_conflict.sh wan modify"
  L5 = L5(L6)
  L6 = "^[%s\n\r\t]*(.-)[%s\n\r\t]*$"
  L7 = "%1"
  L4 = L4(L5, L6, L7)
  L5 = L2.isStrNil
  L6 = L4
  L5 = L5(L6)
  if not L5 and L4 ~= "0.0.0.0" then
    L5 = L0.removeMessage
    L6 = 4
    L5(L6)
    L5 = require
    L6 = "luci.model.uci"
    L5 = L5(L6)
    L5 = L5.cursor
    L5 = L5()
    L7 = L5
    L6 = L5.get
    L8 = "network"
    L9 = "lan"
    L10 = "netmask"
    L6 = L6(L7, L8, L9, L10)
    L6 = L6 or L6
    L7 = L1.lanIPChange
    L8 = L4
    L9 = L6
    L10 = L6
    L7(L8, L9, L10)
    L7 = true
    return L7
  end
  L5 = false
  return L5
end
ip_conflict_resolution = L0
function L0(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = "/usr/sbin/ip_conflict.sh br-lan check"
  L6 = L2._strformat
  L7 = A0
  L6 = L6(L7)
  L7 = L2._strformat
  L8 = A1
  L7 = L7(L8)
  L8 = nil
  L9 = L5
  L10 = " "
  L11 = L6
  L12 = " "
  L13 = L7
  L5 = L9 .. L10 .. L11 .. L12 .. L13
  L9 = string
  L9 = L9.gsub
  L10 = L4.exec
  L11 = L5
  L10 = L10(L11)
  L11 = "^[%s\n\r\t]*(.-)[%s\n\r\t]*$"
  L12 = "%1"
  L9 = L9(L10, L11, L12)
  L8 = L9
  L9 = L2.isStrNil
  L10 = L8
  L9 = L9(L10)
  if not L9 then
    L9 = L3.log
    L10 = 6
    L11 = "lan_wan_ip_conflict_chk: "
    L12 = L8
    L11 = L11 .. L12
    L9(L10, L11)
  end
  L9 = L2.isStrNil
  L10 = L8
  L9 = L9(L10)
  if L9 or L8 == "0" then
    L9 = false
    return L9
  end
  L9 = true
  return L9
end
lan_wan_ip_conflict_chk = L0
