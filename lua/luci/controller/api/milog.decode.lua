local L0, L1, L2, L3, L4
L0 = module
L1 = "luci.controller.api.milog"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0()
  local L0, L1, L2, L3, L4, L5
  L0 = node
  L1 = "api"
  L2 = "mi_log"
  L0 = L0(L1, L2)
  L1 = firstchild
  L1 = L1()
  L0.target = L1
  L0.title = ""
  L0.order = 999
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "jsonauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "mi_log"
  L2[1] = L3
  L2[2] = L4
  L3 = firstchild
  L3 = L3()
  L4 = ""
  L5 = 100
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "mi_log"
  L5 = "get_onoff"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getOnOff"
  L3 = L3(L4)
  L4 = ""
  L5 = 100
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "mi_log"
  L5 = "set_onoff"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "setOnOff"
  L3 = L3(L4)
  L4 = ""
  L5 = 100
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "mi_log"
  L5 = "overview"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "overview"
  L3 = L3(L4)
  L4 = ""
  L5 = 100
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "mi_log"
  L5 = "del_logs"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "delLogs"
  L3 = L3(L4)
  L4 = ""
  L5 = 100
  L1(L2, L3, L4, L5)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "mi_log"
  L5 = "get_logs"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "getLogs"
  L3 = L3(L4)
  L4 = ""
  L5 = 100
  L1(L2, L3, L4, L5)
end
index = L0
L0 = require
L1 = "xiaoqiang.module.XQMiwifiLog"
L0 = L0(L1)
L1 = require
L2 = "luci.cbi.datatypes"
L1 = L1(L2)
L2 = require
L3 = "luci.http"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.XQLog"
L3 = L3(L4)
function L4()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "milog"
  L4 = "global"
  L5 = "enable"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = {}
  L3 = {}
  if L1 ~= "0" then
    L4 = 1
    if L4 then
      goto lbl_22
    end
  end
  L4 = 0
  ::lbl_22::
  L3.enable = L4
  L2.meta = L3
  L3 = L1 ~= "0"
  return L2, L3
end
_overview = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.code = 0
  L1.msg = "success"
  L2 = {}
  L2.on = 0
  L1.info = L2
  L3 = L0
  L2 = L0.get
  L4 = "milog"
  L5 = "global"
  L6 = "enable"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  if L2 ~= "0" then
    L3 = L1.info
    L3.on = 1
  end
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L1
  L3(L4)
end
getOnOff = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "on"
  L3 = nil
  L4 = "?numberstr"
  L1 = L1(L2, L3, L4)
  L1 = L1 or L1
  L2 = {}
  L2.code = 0
  L2.msg = "success"
  L4 = L0
  L3 = L0.set
  L5 = "milog"
  L6 = "global"
  L7 = "enable"
  L8 = L1
  L3(L4, L5, L6, L7, L8)
  L4 = L0
  L3 = L0.commit
  L5 = "milog"
  L3(L4, L5)
  L3 = os
  L3 = L3.execute
  L4 = "/etc/init.d/miwifi-logd reload"
  L3(L4)
  L3 = _UPVALUE0_
  L3 = L3.write_json
  L4 = L2
  L3(L4)
end
setOnOff = L4
function L4()
  local L0, L1, L2, L3
  L0 = {}
  L0.code = 0
  L0.msg = "success"
  L1 = {}
  L1.risk_cnt = 0
  L1.sys_cnt = 0
  L1.nic_cnt = 0
  L0.info = L1
  L1 = L0.info
  L2 = _UPVALUE0_
  L2 = L2.get_cnt_by_prefix
  L3 = "sec_risk_"
  L2 = L2(L3)
  L1.risk_cnt = L2
  L1 = L0.info
  L2 = _UPVALUE0_
  L2 = L2.get_cnt_by_prefix
  L3 = "sec_sys_"
  L2 = L2(L3)
  L1.sys_cnt = L2
  L1 = L0.info
  L2 = _UPVALUE0_
  L2 = L2.get_cnt_by_prefix
  L3 = "sec_nic_"
  L2 = L2(L3)
  L1.nic_cnt = L2
  L1 = _UPVALUE1_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
overview = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "type"
  L2 = nil
  L3 = "?commonstr"
  L0 = L0(L1, L2, L3)
  L0 = L0 or L0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "value"
  L3 = nil
  L4 = "?commonstr"
  L1 = L1(L2, L3, L4)
  L1 = L1 or L1
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "filter"
  L4 = nil
  L5 = "?commonstr"
  L2 = L2(L3, L4, L5)
  L3 = {}
  L3.code = 0
  L3.msg = "success"
  if L0 ~= "duration" then
    L4 = _UPVALUE1_
    L4 = L4.del_by_ids
    L5 = L1
    L4(L5)
  else
    L4 = _UPVALUE2_
    L4 = L4.integer
    L5 = L1
    L4 = L4(L5)
    if L4 then
      L4 = _UPVALUE1_
      L4 = L4.del_by_days
      L5 = tonumber
      L6 = L1
      L5 = L5(L6)
      L5 = L5 or L5
      if L2 then
        L6 = "sec_"
        L7 = L2
        L6 = L6 .. L7
        if L6 then
          goto lbl_57
        end
      end
      L6 = nil
      ::lbl_57::
      L4(L5, L6)
    else
      L3.code = 1523
      L4 = _
      L5 = "\229\143\130\230\149\176\233\148\153\232\175\175"
      L4 = L4(L5)
      L3.msg = L4
    end
  end
  L4 = _UPVALUE0_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
delLogs = L4
function L4()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = _UPVALUE0_
  L0 = L0.formvalue
  L1 = "type"
  L2 = nil
  L3 = "?commonstr"
  L0 = L0(L1, L2, L3)
  L0 = L0 or L0
  L1 = _UPVALUE0_
  L1 = L1.formvalue
  L2 = "tsclient"
  L3 = nil
  L4 = "?numberstr"
  L1 = L1(L2, L3, L4)
  L1 = L1 or L1
  L2 = _UPVALUE0_
  L2 = L2.formvalue
  L3 = "duration"
  L4 = nil
  L5 = "?numberstr"
  L2 = L2(L3, L4, L5)
  L2 = L2 or L2
  L3 = _UPVALUE0_
  L3 = L3.formvalue
  L4 = "offset"
  L5 = nil
  L6 = "?numberstr"
  L3 = L3(L4, L5, L6)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L4 = L4.formvalue
  L5 = "limit"
  L6 = nil
  L7 = "?numberstr"
  L4 = L4(L5, L6, L7)
  L4 = L4 or L4
  L5 = {}
  L5.code = 0
  L5.msg = "success"
  L6 = {}
  L5.info = L6
  if L1 == "" or L2 == "" then
    L5.code = 1523
    L6 = _
    L7 = "\229\143\130\230\149\176\233\148\153\232\175\175"
    L6 = L6(L7)
    L5.msg = L6
    L6 = _UPVALUE0_
    L6 = L6.write_json
    L7 = L5
    L6(L7)
    return
  end
  if L0 == "" then
    L0 = "sys"
  end
  if L3 == "" then
    L3 = "0"
  end
  if L4 == "" then
    L4 = "10"
  end
  L6 = _UPVALUE1_
  L6 = L6.get_logs_cnt
  L7 = tonumber
  L8 = L2
  L7 = L7(L8)
  L7 = L7 or L7
  L8 = L1
  L9 = "sec_"
  L9 = L9 .. L10
  L6 = L6(L7, L8, L9)
  L5.total = L6
  L6 = _UPVALUE1_
  L6 = L6.get_logs
  L7 = tonumber
  L8 = L2
  L7 = L7(L8)
  L7 = L7 or L7
  L8 = L1
  L9 = "sec_"
  L9 = L9 .. L10
  L6 = L6(L7, L8, L9, L10, L11)
  L7 = {}
  L8 = nil
  L9 = 0
  for L13, L14 in L10, L11, L12 do
    L15 = L14.date
    L14.date = nil
    L16 = _UPVALUE1_
    L16 = L16.get_device_map
    L16 = L16()
    L17 = L14.mac
    L16 = L16[L17]
    L16 = L16 or L16
    L14.dev = L16
    if L15 ~= L8 then
      L16 = {}
      L16.date = L15
      L17 = {}
      L16.data = L17
      L7 = L16
      L16 = table
      L16 = L16.insert
      L17 = L5.info
      L18 = L7
      L16(L17, L18)
      L8 = L15
    end
    L16 = table
    L16 = L16.insert
    L17 = L7.data
    L18 = L14
    L16(L17, L18)
    L9 = L9 + 1
  end
  L5.count = L9
  L10(L11)
end
getLogs = L4
