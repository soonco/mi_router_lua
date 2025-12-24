local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "xiaoqiang.util.XQDBUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = pcall
L1 = require
L2 = "lsqlite3"
L0, L1 = L0(L1, L2)
L2 = "/etc/xqDb"
L3 = require
L4 = "luci.model.uci"
L3 = L3(L4)
L3 = L3.cursor
L3 = L3()
L4 = require
L5 = "xiaoqiang.XQLog"
L4 = L4(L5)
L5 = 7
DEBUG = L5
L5 = 6
INFO = L5
L5 = 5
NOTICE = L5
L5 = 4
WARN = L5
L5 = 3
ERROR = L5
L5 = 2
CRIT = L5
L5 = require
L6 = "luci.cbi.datatypes"
L5 = L5(L6)
function L6(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12
  L5 = _UPVALUE0_
  L5 = L5.macaddr
  L6 = A0
  L5 = L5(L6)
  if not L5 then
    L5 = false
    return L5
  end
  L6 = A0
  L5 = A0.gsub
  L7 = ":"
  L8 = ""
  L5 = L5(L6, L7, L8)
  L6 = "_INFO"
  L5 = L5 .. L6
  L6 = {}
  L6.mac = A0
  L6.oname = A1
  L6.nickname = A2
  L6.company = A3
  L7 = _UPVALUE1_
  L8 = L7
  L7 = L7.section
  L9 = "devicelist"
  L10 = "deviceinfo"
  L11 = L5
  L12 = L6
  L7(L8, L9, L10, L11, L12)
  L7 = _UPVALUE1_
  L8 = L7
  L7 = L7.commit
  L9 = "devicelist"
  return L7(L8, L9)
end
conf_saveDeviceInfo = L6
function L6(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L5 = _UPVALUE0_
  if not L5 then
    L5 = conf_saveDeviceInfo
    L6 = A0
    L7 = A1
    return L5(L6, L7, L8, L9, L10)
  end
  L5 = _UPVALUE1_
  L5 = L5.macaddr
  L6 = A0
  L5 = L5(L6)
  if not L5 then
    return
  end
  L5 = _UPVALUE2_
  L5 = L5.open
  L6 = _UPVALUE3_
  L5 = L5(L6)
  L6 = string
  L6 = L6.format
  L7 = "select * from DEVICE_INFO where MAC = '%s'"
  L6 = L6(L7, L8)
  L7 = false
  for L11 in L8, L9, L10 do
    if L11 then
      L7 = true
    end
  end
  if not L7 then
    L11 = A0
    L12 = A1
    L13 = A2
    L14 = A3
    L15 = A4
  else
    L11 = A0
    L12 = A1
    L13 = A2
    L14 = A3
    L15 = A4
    L16 = A0
  end
  L11 = L8
  L9(L10, L11)
  return L9(L10)
end
saveDeviceInfo = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2.macaddr
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = false
    return L2
  end
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L3 = "_INFO"
  L2 = L2 .. L3
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.get_all
  L5 = "devicelist"
  L6 = L2
  L3 = L3(L4, L5, L6)
  if L3 then
    L3 = _UPVALUE1_
    L4 = L3
    L3 = L3.set
    L5 = "devicelist"
    L6 = "key"
    L7 = "nickname"
    L8 = A1
    return L3(L4, L5, L6, L7, L8)
  end
  L3 = false
  return L3
end
conf_updateDeviceNickname = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  if not L2 then
    L2 = conf_updateDeviceNickname
    L3 = A0
    L4 = A1
    return L2(L3, L4)
  end
  L2 = _UPVALUE1_
  L2 = L2.macaddr
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    return
  end
  L2 = _UPVALUE2_
  L2 = L2.open
  L3 = _UPVALUE3_
  L2 = L2(L3)
  L3 = string
  L3 = L3.format
  L4 = "update DEVICE_INFO set NICKNAME = '%s' where MAC = '%s'"
  L5 = A1
  L6 = A0
  L3 = L3(L4, L5, L6)
  L5 = L2
  L4 = L2.exec
  L6 = L3
  L4(L5, L6)
  L5 = L2
  L4 = L2.close
  return L4(L5)
end
updateDeviceNickname = L6
function L6(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.macaddr
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = {}
    return L1
  end
  L2 = A0
  L1 = A0.gsub
  L3 = ":"
  L4 = ""
  L1 = L1(L2, L3, L4)
  L2 = "_INFO"
  L1 = L1 .. L2
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.get_all
  L4 = "devicelist"
  L5 = L1
  L2 = L2(L3, L4, L5)
  if L2 then
    L3 = {}
    L4 = L2.mac
    L4 = L4 or L4
    L3.mac = L4
    L4 = L2.oname
    L4 = L4 or L4
    L3.oName = L4
    L4 = L2.nickname
    L4 = L4 or L4
    L3.nickname = L4
    L4 = L2.company
    L4 = L4 or L4
    L3.company = L4
    L3.ownnerId = ""
    return L3
  end
  L3 = {}
  return L3
end
conf_fetchDeviceInfo = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = _UPVALUE0_
  if not L1 then
    L1 = conf_fetchDeviceInfo
    L2 = A0
    return L1(L2)
  end
  L1 = _UPVALUE1_
  L1 = L1.macaddr
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    return
  end
  L1 = _UPVALUE2_
  L1 = L1.open
  L2 = _UPVALUE3_
  L1 = L1(L2)
  L2 = string
  L2 = L2.format
  L3 = "select * from DEVICE_INFO where MAC = '%s'"
  L2 = L2(L3, L4)
  L3 = {}
  for L7 in L4, L5, L6 do
    if L7 then
      L8 = {}
      L9 = L7[1]
      L8.mac = L9
      L9 = L7[2]
      L8.oName = L9
      L9 = L7[3]
      L8.nickname = L9
      L9 = L7[4]
      L8.company = L9
      L9 = L7[5]
      L8.ownnerId = L9
      L3 = L8
    end
  end
  L4(L5)
  return L3
end
fetchDeviceInfo = L6
function L6()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.foreach
  L3 = "devicelist"
  L4 = "deviceinfo"
  function L5(A0)
    local L1, L2, L3, L4
    L1 = table
    L1 = L1.insert
    L2 = _UPVALUE0_
    L3 = {}
    L4 = A0.mac
    L4 = L4 or L4
    L3.mac = L4
    L4 = A0.oname
    L4 = L4 or L4
    L3.oName = L4
    L4 = A0.nickname
    L4 = L4 or L4
    L3.nickname = L4
    L4 = A0.company
    L4 = L4 or L4
    L3.company = L4
    L3.ownnerId = ""
    L1(L2, L3)
  end
  L1(L2, L3, L4, L5)
  return L0
end
conf_fetchAllDeviceInfo = L6
function L6()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = _UPVALUE0_
  if not L0 then
    L0 = conf_fetchAllDeviceInfo
    return L0()
  end
  L0 = _UPVALUE1_
  L0 = L0.open
  L1 = _UPVALUE2_
  L0 = L0(L1)
  L1 = string
  L1 = L1.format
  L2 = "select * from DEVICE_INFO"
  L1 = L1(L2)
  L2 = {}
  if not L0 then
    return L2
  end
  for L6 in L3, L4, L5 do
    if L6 then
      L7 = _UPVALUE3_
      L7 = L7.macaddr
      L8 = L6[1]
      L7 = L7(L8)
      if L7 then
        L7 = table
        L7 = L7.insert
        L8 = L2
        L9 = {}
        L10 = L6[1]
        L9.mac = L10
        L10 = L6[2]
        L9.oName = L10
        L10 = L6[3]
        L9.nickname = L10
        L10 = L6[4]
        L9.company = L10
        L10 = L6[5]
        L9.ownnerId = L10
        L7(L8, L9)
      end
    end
  end
  L3(L4)
  return L2
end
fetchAllDeviceInfo = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = require
  L3 = "socket"
  L2 = L2(L3)
  L3 = nil
  if A0 == nil then
    L4 = false
    return L4
  end
  L4 = nil
  if A1 ~= nil then
    L4 = A1
  else
    L5 = _UPVALUE0_
    L5 = L5.open
    L6 = _UPVALUE1_
    L5 = L5(L6)
    L4 = L5
  end
  L6 = L4
  L5 = L4.exec
  L7 = A0
  L5 = L5(L6, L7)
  L6 = _UPVALUE0_
  L6 = L6.OK
  if L5 ~= L6 then
    L6 = 0
    repeat
      L7 = L2.select
      L8, L9 = nil, nil
      L10 = 0.1
      L7(L8, L9, L10)
      L8 = L4
      L7 = L4.exec
      L9 = A0
      L7 = L7(L8, L9)
      L5 = L7
      L6 = L6 + 1
      L7 = _UPVALUE0_
      L7 = L7.OK
    until L5 == L7 or 3 <= L6
    L7 = _UPVALUE0_
    L7 = L7.OK
    if L5 ~= L7 then
      L7 = _UPVALUE2_
      L7 = L7.log
      L8 = ERROR
      L9 = string
      L9 = L9.format
      L10 = "SQLite cmd retry[%d] exec failed[%s] resson[%s]"
      L11 = L6
      L12 = A0
      L14 = L4
      L13 = L4.errmsg
      L13, L14 = L13(L14)
      L9, L10, L11, L12, L13, L14 = L9(L10, L11, L12, L13, L14)
      L7(L8, L9, L10, L11, L12, L13, L14)
      L3 = false
    else
      L7 = _UPVALUE2_
      L7 = L7.log
      L8 = INFO
      L9 = string
      L9 = L9.format
      L10 = "SQLite cmd retry[%d] exec success"
      L11 = L6
      L9, L10, L11, L12, L13, L14 = L9(L10, L11)
      L7(L8, L9, L10, L11, L12, L13, L14)
      L3 = true
    end
  else
    L6 = _UPVALUE2_
    L6 = L6.log
    L7 = INFO
    L8 = string
    L8 = L8.format
    L9 = "SQLite cmd[%s] exec success"
    L10 = A0
    L8, L9, L10, L11, L12, L13, L14 = L8(L9, L10)
    L6(L7, L8, L9, L10, L11, L12, L13, L14)
    L3 = true
  end
  if not A1 then
    L7 = L4
    L6 = L4.close
    L6(L7)
  end
  return L3
end
sql_exec = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  if A1 then
    L3 = A1
  else
    L4 = _UPVALUE0_
    L4 = L4.open
    L5 = _UPVALUE1_
    L4 = L4(L5)
    L3 = L4
  end
  L4 = string
  L4 = L4.format
  L5 = "select name from sqlite_master where name = '%s'"
  L4 = L4(L5, L6)
  L5 = {}
  for L9 in L6, L7, L8 do
    L5 = L9
  end
  if L6 == nil then
    L9 = A0
    L6(L7, L8)
    L2 = false
  else
    L9 = A0
    L6(L7, L8)
    L2 = true
  end
  if not A1 then
    L6(L7)
  end
  return L2
end
table_is_exist = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  if A1 then
    L2 = A1
  else
    L3 = _UPVALUE0_
    L3 = L3.open
    L4 = _UPVALUE1_
    L3 = L3(L4)
    L2 = L3
  end
  L3 = string
  L3 = L3.format
  L4 = "select * from '%s'"
  L5 = A0
  L3 = L3(L4, L5)
  L4 = require
  L5 = "cjson"
  L4 = L4(L5)
  L5 = {}
  for L9 in L6, L7, L8 do
    L10 = _UPVALUE2_
    L10 = L10.log
    L11 = DEBUG
    L12 = L4.encode
    L13 = L9
    L12, L13 = L12(L13)
    L10(L11, L12, L13)
  end
  if not A1 then
    L6(L7)
  end
end
table_dump = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7
  if A0 then
    L1 = A0
  else
    L3 = _UPVALUE0_
    L3 = L3.open
    L4 = _UPVALUE1_
    L3 = L3(L4)
    L1 = L3
  end
  L3 = string
  L3 = L3.format
  L4 = "CREATE TABLE DEVICE_PUSH_INFO (MAC TEXT PRIMARY KEY NOT NULL,STATUS TEXT,TIME INTEGER,ACTION TEXT,PUSHTIME INTEGER,LAST_ACTION TEXT,NAME TEXT);"
  L3 = L3(L4)
  L4 = sql_exec
  L5 = L3
  L6 = L1
  L4 = L4(L5, L6)
  if L4 == false then
    L5 = _UPVALUE2_
    L5 = L5.log
    L6 = ERROR
    L7 = "[vip push]create table for DEVICE_PUSH_INFO error"
    L5(L6, L7)
    L2 = false
  else
    L2 = true
  end
  if not A0 then
    L6 = L1
    L5 = L1.close
    L5(L6)
  end
  return L2
end
table_create = L6
function L6(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  if A3 then
    L4 = A3
  else
    L5 = SQLite
    L5 = L5.open
    L6 = _UPVALUE0_
    L5 = L5(L6)
    L4 = L5
  end
  L5 = string
  L5 = L5.upper
  L6 = A2
  L5 = L5(L6)
  A2 = L5
  L5 = string
  L5 = L5.format
  L6 = "select * from DEVICE_PUSH_INFO where MAC = '%s'"
  L5 = L5(L6, L7)
  L6 = false
  for L10 in L7, L8, L9 do
    if L10 then
      L6 = true
    end
  end
  L10 = json
  L10 = L10.encode
  L11 = L6
  L10 = L10(L11)
  L7(L8, L9)
  if nil == L8 then
    if not L6 then
      L10 = "DEVICE_PUSH_INFO"
      L11 = string
      L11 = L11.upper
      L12 = A2
      L11 = L11(L12)
      L12 = os
      L12 = L12.time
      L12 = L12()
      L13 = A1
    else
      L10 = os
      L10 = L10.time
      L10 = L10()
      L11 = A1
      L12 = A2
    end
  elseif not L6 then
    L10 = "DEVICE_PUSH_INFO"
    L11 = string
    L11 = L11.upper
    L12 = A2
    L11 = L11(L12)
    L12 = os
    L12 = L12.time
    L12 = L12()
    L13 = A1
    L14 = name
  else
    L10 = os
    L10 = L10.time
    L10 = L10()
    L11 = A1
    L12 = name
    L13 = A2
  end
  if not A3 then
    L10 = L4
    L9(L10)
  end
  return L8
end
set_pending_status = L6
function L6(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  if A3 then
    L4 = A3
  else
    L5 = SQLite
    L5 = L5.open
    L6 = _UPVALUE0_
    L5 = L5(L6)
    L4 = L5
  end
  L5 = string
  L5 = L5.upper
  L6 = A0
  L5 = L5(L6)
  A0 = L5
  L5 = string
  L5 = L5.format
  L6 = "select * from DEVICE_PUSH_INFO where MAC = '%s'"
  L5 = L5(L6, L7)
  L6 = false
  for L10 in L7, L8, L9 do
    if L10 then
      L6 = true
    end
  end
  L10 = json
  L10 = L10.encode
  L11 = L6
  L10 = L10(L11)
  L7(L8, L9)
  if not L6 then
    L10 = "DEVICE_PUSH_INFO"
    L11 = string
    L11 = L11.upper
    L12 = A0
    L11 = L11(L12)
    L12 = os
    L12 = L12.time
    L12 = L12()
    L13 = A2
    L14 = A1
  else
    L10 = os
    L10 = L10.time
    L10 = L10()
    L11 = A2
    L12 = A1
    L13 = A0
  end
  if not A3 then
    L10 = L4
    L9(L10)
  end
  return L8
end
set_pending_status_with_name = L6
function L6()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQFunction"
  L1 = L1(L2)
  L2 = tonumber
  L3 = L0.exec
  L4 = "ps | grep -v grep | grep vip_device_push_act.lua 2>&1 > /dev/null; echo $?"
  L3, L4, L5 = L3(L4)
  L2 = L2(L3, L4, L5)
  if L2 == 1 then
    L3 = _UPVALUE0_
    L3 = L3.log
    L4 = 6
    L5 = "can not found processon 'vip_device_push_act.lua' call it up"
    L3(L4, L5)
    L3 = L1.forkExec
    L4 = "vip_device_push_act.lua"
    L3(L4)
  else
    L3 = _UPVALUE0_
    L3 = L3.log
    L4 = 4
    L5 = "vip_device_push_act.lua exist"
    L3(L4, L5)
  end
end
call_push_action_up = L6
function L6(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  if A0 == nil or A2 == nil then
    L3 = nil
    return L3
  end
  L3 = _UPVALUE0_
  L3 = L3.open
  L4 = _UPVALUE1_
  L3 = L3(L4)
  if L3 == nil then
    L4 = _UPVALUE2_
    L4 = L4.log
    L5 = ERROR
    L6 = "[vip push]open db failed"
    L4(L5, L6)
  end
  L4 = table_is_exist
  L5 = "DEVICE_PUSH_INFO"
  L6 = L3
  L4 = L4(L5, L6)
  if not L4 then
    L4 = _UPVALUE2_
    L4 = L4.log
    L5 = NOTICE
    L6 = "[vip push]can't found table named 'DEIVCE_PUSH_INFO'"
    L4(L5, L6)
    L4 = table_create
    L5 = L3
    L4 = L4(L5)
    if not L4 then
      L4 = _UPVALUE2_
      L4 = L4.log
      L5 = ERROR
      L6 = "[vip push]create table error"
      L4(L5, L6)
      L5 = L3
      L4 = L3.close
      L4(L5)
      L4 = false
      return L4
    end
  end
  if A1 == nil then
    L4 = set_pending_status
    L5 = A0
    L6 = A2
    L7 = L3
    L4 = L4(L5, L6, L7)
    if not L4 then
      L4 = _UPVALUE2_
      L4 = L4.log
      L5 = ERROR
      L6 = "[vip push]set mac["
      L7 = string
      L7 = L7.upper
      L8 = A0
      L7 = L7(L8)
      L8 = "] status[pending] error"
      L6 = L6 .. L7 .. L8
      L4(L5, L6)
    else
      L4 = _UPVALUE2_
      L4 = L4.log
      L5 = DEBUG
      L6 = "[vip push]set mac["
      L7 = string
      L7 = L7.upper
      L8 = A0
      L7 = L7(L8)
      L8 = "] status[pending] success,call vip_device_push_act.lua"
      L6 = L6 .. L7 .. L8
      L4(L5, L6)
      L4 = call_push_action_up
      L4()
    end
  else
    L4 = set_pending_status_with_name
    L5 = A0
    L6 = A1
    L7 = A2
    L8 = L3
    L4 = L4(L5, L6, L7, L8)
    if not L4 then
      L4 = _UPVALUE2_
      L4 = L4.log
      L5 = ERROR
      L6 = "[vip push]set mac["
      L7 = string
      L7 = L7.upper
      L8 = A0
      L7 = L7(L8)
      L8 = "] status[pending] error"
      L6 = L6 .. L7 .. L8
      L4(L5, L6)
    else
      L4 = _UPVALUE2_
      L4 = L4.log
      L5 = DEBUG
      L6 = "[vip push]set mac["
      L7 = string
      L7 = L7.upper
      L8 = A0
      L7 = L7(L8)
      L8 = "] status[pending] success,call vip_device_push_act.lua"
      L6 = L6 .. L7 .. L8
      L4(L5, L6)
      L4 = call_push_action_up
      L4()
    end
  end
  L5 = L3
  L4 = L3.close
  L4(L5)
end
vip_device_pre_push = L6
