local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
L0 = {}
L1 = require
L2 = "cjson"
L1 = L1(L2)
L2 = "SELECT COUNT(*) AS matching_count FROM TAG WHERE NAME LIKE '%s%%';"
L3 = "DELETE FROM TAG WHERE LOG_ID IN (%s);"
L4 = "DELETE FROM LOG WHERE ID IN (%s);"
L5 = [[
	SELECT COALESCE(MAX(ID), 0) AS max_id, COALESCE(MIN(ID), 0) AS min_id
	FROM
		LOG
	WHERE
		TIMESTAMP >= DATE('now', '-%d days', 'localtime');
]]
L6 = "DELETE FROM TAG WHERE LOG_ID <= %d AND LOG_ID >= %d;"
L7 = "DELETE FROM LOG WHERE ID <= %d AND ID >= %d;"
L8 = [[
	DELETE FROM TAG WHERE LOG_ID <= %d AND LOG_ID >= %d AND LOG_ID IN (
		SELECT LOG_ID FROM TAG WHERE TAG.NAME LIKE '%s%%'
	)
]]
L9 = "\tDELETE FROM LOG WHERE ID <= %d AND ID >= %d AND ID NOT IN (SELECT LOG_ID FROM TAG)\n"
L10 = [[
	SELECT COUNT(*)
	FROM
		LOG AS L
	JOIN
		TAG AS T
	ON
		L.ID = T.LOG_ID
	WHERE
		DATE(L.TIMESTAMP) >= DATE('now', '-%d days', 'localtime')
		AND L.TIMESTAMP <= DATETIME(%s, 'unixepoch')
		AND T.NAME LIKE '%s%%';
]]
L11 = [[
	SELECT
		DATE(L.TIMESTAMP, 'localtime') AS date,
		strftime('%%H:%%M', L.TIMESTAMP, 'localtime') AS time,
		strftime('%%s', L.TIMESTAMP) AS ts,
		L.ID AS id,
		L.MSG AS msg
	FROM
		LOG AS L
	JOIN
		TAG AS T
	ON
		L.ID = T.LOG_ID
	WHERE
		DATE(L.TIMESTAMP) >= DATE('now', '-%d days', 'localtime')
		AND L.TIMESTAMP <= DATETIME(%s, 'unixepoch')
		AND T.NAME LIKE '%s%%'
	ORDER BY
		L.ID DESC
	LIMIT %d
	OFFSET %d;
]]
L12 = _
if L12 == nil then
  function L12(A0)
    local L1
    return A0
  end
  _ = L12
end
L12 = nil
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = _UPVALUE0_
  if L0 == nil then
    L0 = require
    L1 = "xiaoqiang.util.XQDeviceUtil"
    L0 = L0(L1)
    L1 = L0.getDeviceListV2
    L1 = L1(L2, L3, L4)
    _UPVALUE0_ = L2
    for L5, L6 in L2, L3, L4 do
      L7 = L6.name
      if L7 ~= "" then
        L7 = _UPVALUE0_
        L8 = L6.mac
        L9 = L6.name
        L7[L8] = L9
      end
    end
  end
  L0 = _UPVALUE0_
  return L0
end
L0.get_device_map = L13
function L13(A0)
  local L1, L2
  L1 = string
  L1 = L1.upper
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  L1 = _UPVALUE0_
  L1 = L1.get_device_map
  L1 = L1()
  L1 = L1[A0]
  L1 = L1 or L1
  return L1
end
get_dev_name = L13
function L13(A0)
  local L1, L2, L3
  L1 = os
  L1 = L1.date
  L2 = "%Y-%m-%d %H:%M"
  L3 = A0
  return L1(L2, L3)
end
get_time = L13
L13 = {}
L14 = {}
L15 = {}
L16 = _
L17 = "\229\183\178\230\139\166\230\136\170 %s\230\148\187\229\135\187"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "type"
L16[1] = L17
L15.arg = L16
L16 = {}
function L17(A0)
  local L1, L2
  L1 = string
  L1 = L1.upper
  L2 = A0
  return L1(L2)
end
L16.type = L17
L15.map = L16
L14.msg = L15
L13.sec_risk_gw = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\229\183\178\230\139\166\230\136\170 \231\189\145\231\187\156\230\139\146\231\187\157\232\174\191\233\151\174\230\148\187\229\135\187"
L16 = L16(L17)
L15.tpl = L16
L14.msg = L15
L15 = {}
L16 = _
L17 = "%s\229\156\168%s\229\175\185%s\229\143\145\232\181\183\228\186\134\230\179\155\230\180\170\230\148\187\229\135\187"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "mac"
L18 = "timestamp"
L19 = "dstmac"
L16[1] = L17
L16[2] = L18
L16[3] = L19
L15.arg = L16
L16 = {}
L17 = get_dev_name
L16.mac = L17
L17 = get_time
L16.timestamp = L17
L17 = get_dev_name
L16.dstmac = L17
L15.map = L16
L14.ext = L15
L13.sec_risk_flood = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\229\183\178\230\139\166\230\136\170 \230\129\182\230\132\143\230\181\129\233\135\143\230\148\187\229\135\187"
L16 = L16(L17)
L15.tpl = L16
L14.msg = L15
L15 = {}
L16 = _
L17 = "%s\229\156\168%s\229\175\185%s\229\143\145\232\181\183\228\186\134\231\171\175\229\143\163\230\137\171\230\143\143"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "mac"
L18 = "timestamp"
L19 = "dstmac"
L16[1] = L17
L16[2] = L18
L16[3] = L19
L15.arg = L16
L16 = {}
L17 = get_dev_name
L16.mac = L17
L17 = get_time
L16.timestamp = L17
L17 = get_dev_name
L16.dstmac = L17
L15.map = L16
L14.ext = L15
L13.sec_risk_portscan = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\229\183\178\230\139\166\230\136\170 \230\129\182\230\132\143\230\181\129\233\135\143\230\148\187\229\135\187"
L16 = L16(L17)
L15.tpl = L16
L14.msg = L15
L15 = {}
L16 = _
L17 = "%s\229\156\168%s\229\143\145\232\181\183\228\186\134IP\230\137\171\230\143\143"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "mac"
L18 = "timestamp"
L16[1] = L17
L16[2] = L18
L15.arg = L16
L16 = {}
L17 = get_dev_name
L16.mac = L17
L17 = get_time
L16.timestamp = L17
L15.map = L16
L14.ext = L15
L13.sec_risk_ipscan = L14
L14 = {}
L15 = {}
L16 = _
L17 = "%s"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "type"
L16[1] = L17
L15.arg = L16
L16 = {}
L17 = {}
L18 = _
L19 = "\229\177\143\232\148\189\229\141\177\233\153\169\232\174\191\233\151\174"
L18 = L18(L19)
L17.reject = L18
L18 = _
L19 = "\229\133\129\232\174\184\229\141\177\233\153\169\232\174\191\233\151\174"
L18 = L18(L19)
L17.log = L18
L18 = _
L19 = "\229\138\160\229\133\165\232\174\191\233\151\174\231\153\189\229\144\141\229\141\149"
L18 = L18(L19)
L17.whitelist = L18
L16.type = L17
L15.map = L16
L14.msg = L15
L15 = {}
L16 = _
L17 = "%s"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "url"
L16[1] = L17
L15.arg = L16
L14.ext = L15
L13.sec_risk_web = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\233\135\141\230\150\176\229\144\175\229\138\168"
L16 = L16(L17)
L15.tpl = L16
L14.msg = L15
L13.sec_sys_restart = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\231\189\145\231\187\156%s"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "connected"
L16[1] = L17
L15.arg = L16
L16 = {}
L17 = {}
L18 = _
L19 = "\230\150\173\229\188\128"
L18 = L18(L19)
L17["false"] = L18
L18 = _
L19 = "\233\135\141\232\191\158"
L18 = L18(L19)
L17["true"] = L18
L16.connected = L17
L15.map = L16
L14.msg = L15
L13.sec_sys_internet = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\229\138\160\229\133\165\228\186\134Mesh\231\189\145\231\187\156"
L16 = L16(L17)
L15.tpl = L16
L14.msg = L15
L13.sec_sys_addre = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\228\191\174\230\148\185\231\189\145\231\187\156\229\175\134\231\160\129"
L16 = L16(L17)
L15.tpl = L16
L14.msg = L15
L13.sec_sys_wlanpwd = L14
L14 = {}
L15 = {}
L16 = _
L17 = "%s\233\153\144\229\136\182\232\129\148\231\189\145"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "restricted"
L16[1] = L17
L15.arg = L16
L16 = {}
L17 = {}
L18 = _
L19 = "\232\167\163\233\153\164"
L18 = L18(L19)
L17["false"] = L18
L18 = _
L19 = "\232\162\171"
L18 = L18(L19)
L17["true"] = L18
L16.restricted = L17
L15.map = L16
L14.msg = L15
L13.sec_nic_internet = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\229\183\178%s"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "connected"
L16[1] = L17
L15.arg = L16
L16 = {}
L17 = {}
L18 = _
L19 = "\230\150\173\229\188\128"
L18 = L18(L19)
L17["false"] = L18
L18 = _
L19 = "\228\184\138\231\186\191"
L18 = L18(L19)
L17["true"] = L18
L16.connected = L17
L15.map = L16
L14.msg = L15
L13.sec_nic_connect = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\232\162\171%s\233\187\145\229\144\141\229\141\149"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "enabled"
L16[1] = L17
L15.arg = L16
L16 = {}
L17 = {}
L18 = _
L19 = "\232\167\163\233\153\164"
L18 = L18(L19)
L17["false"] = L18
L18 = _
L19 = "\229\138\160\229\133\165"
L18 = L18(L19)
L17["true"] = L18
L16.enabled = L17
L15.map = L16
L14.msg = L15
L13.sec_nic_blacklist = L14
L14 = {}
L15 = {}
L16 = _
L17 = "\232\162\171%s\231\153\189\229\144\141\229\141\149"
L16 = L16(L17)
L15.tpl = L16
L16 = {}
L17 = "enabled"
L16[1] = L17
L15.arg = L16
L16 = {}
L17 = {}
L18 = _
L19 = "\232\167\163\233\153\164"
L18 = L18(L19)
L17["false"] = L18
L18 = _
L19 = "\229\138\160\229\133\165"
L18 = L18(L19)
L17["true"] = L18
L16.enabled = L17
L15.map = L16
L14.msg = L15
L13.sec_nic_whitelist = L14
function L14(A0)
  local L1, L2, L3
  L1 = string
  L1 = L1.find
  L2 = A0
  L3 = "'"
  L1 = L1(L2, L3)
  L2 = L1 ~= nil
  return L2
end
is_sql_hack = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "ubus"
  L1 = L1(L2)
  L2 = {}
  L3 = L1.connect
  L3 = L3()
  if not L3 then
    return L2
  end
  L5 = L3
  L4 = L3.call
  L6 = "miwifi-logd"
  L7 = "query"
  L8 = {}
  L8.sql = A0
  L4 = L4(L5, L6, L7, L8)
  L5 = L4.code
  if L5 == 0 then
    L2 = L4.result
  end
  return L2
end
L0.exec_sql = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L2 = L2.exec_sql
  L3 = A0
  L2 = L2(L3)
  L3 = #L2
  if L3 == 0 then
    L3 = {}
    for L7 = L4, L5, L6 do
      L3[L7] = 0
    end
    return L4(L5)
  end
  L3 = unpack
  return L3(L4)
end
L0.get_stat_from_sql = L14
function L14(A0)
  local L1, L2, L3, L4
  L1 = is_sql_hack
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = 0
    return L1
  end
  L1 = _UPVALUE0_
  L1 = L1.get_stat_from_sql
  L2 = string
  L2 = L2.format
  L3 = _UPVALUE1_
  L4 = A0
  L2 = L2(L3, L4)
  L3 = 1
  L1 = L1(L2, L3)
  L2 = tonumber
  L3 = L1
  L2 = L2(L3)
  L2 = L2 or L2
  return L2
end
L0.get_cnt_by_prefix = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  L5 = ""
  L5 = ""
  A0 = L2
  for L5 in L2, L3, L4 do
    L6 = table
    L6 = L6.insert
    L7 = L1
    L8 = tonumber
    L9 = L5
    L8, L9 = L8(L9)
    L6(L7, L8, L9)
  end
  return L1
end
L0.get_ids_from_str = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.get_ids_from_str
  L2 = A0
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.exec_sql
  L3 = string
  L3 = L3.format
  L4 = _UPVALUE1_
  L5 = table
  L5 = L5.concat
  L6 = L1
  L7 = ","
  L5, L6, L7 = L5(L6, L7)
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2(L3, L4, L5, L6, L7)
  L2 = _UPVALUE0_
  L2 = L2.exec_sql
  L3 = string
  L3 = L3.format
  L4 = _UPVALUE2_
  L5 = table
  L5 = L5.concat
  L6 = L1
  L7 = ","
  L5, L6, L7 = L5(L6, L7)
  L3, L4, L5, L6, L7 = L3(L4, L5, L6, L7)
  L2(L3, L4, L5, L6, L7)
end
L0.del_by_ids = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  if A1 then
    L2 = is_sql_hack
    L3 = A1
    L2 = L2(L3)
    if L2 then
      return
    end
  end
  L2, L3 = nil, nil
  L4 = _UPVALUE0_
  L4 = L4.get_stat_from_sql
  L5 = string
  L5 = L5.format
  L6 = _UPVALUE1_
  L7 = A0 - 1
  L5 = L5(L6, L7)
  L6 = 2
  L4, L5 = L4(L5, L6)
  L3 = L5
  L2 = L4
  L4 = type
  L5 = A1
  L4 = L4(L5)
  if L4 == "string" then
    L4 = _UPVALUE0_
    L4 = L4.exec_sql
    L5 = string
    L5 = L5.format
    L6 = _UPVALUE2_
    L7 = L2
    L8 = L3
    L9 = A1
    L5, L6, L7, L8, L9 = L5(L6, L7, L8, L9)
    L4(L5, L6, L7, L8, L9)
    L4 = _UPVALUE0_
    L4 = L4.exec_sql
    L5 = string
    L5 = L5.format
    L6 = _UPVALUE3_
    L7 = L2
    L8 = L3
    L5, L6, L7, L8, L9 = L5(L6, L7, L8)
    L4(L5, L6, L7, L8, L9)
  else
    L4 = _UPVALUE0_
    L4 = L4.exec_sql
    L5 = string
    L5 = L5.format
    L6 = _UPVALUE4_
    L7 = L2
    L8 = L3
    L5, L6, L7, L8, L9 = L5(L6, L7, L8)
    L4(L5, L6, L7, L8, L9)
    L4 = _UPVALUE0_
    L4 = L4.exec_sql
    L5 = string
    L5 = L5.format
    L6 = _UPVALUE5_
    L7 = L2
    L8 = L3
    L5, L6, L7, L8, L9 = L5(L6, L7, L8)
    L4(L5, L6, L7, L8, L9)
  end
end
L0.del_by_days = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = {}
  L3 = A0.tpl
  L4 = A0.map
  L4 = L4 or L4
  L5 = A0.arg
  L5 = L5 or L5
  if L3 == nil then
    return L6
  end
  for L9, L10 in L6, L7, L8 do
    L11 = A1[L10]
    L12 = type
    L13 = L4[L10]
    L12 = L12(L13)
    if L12 == "table" then
      L13 = type
      L14 = L11
      L13 = L13(L14)
      if L13 ~= "string" then
        L13 = tostring
        L14 = L11
        L13 = L13(L14)
        L11 = L13
      end
      L13 = L4[L10]
      L13 = L13[L11]
      L11 = L13 or L11
      if not L13 then
      end
    elseif L12 == "function" then
      L13 = L4[L10]
      L14 = L11
      L13 = L13(L14)
      L11 = L13 or L11
      if not L13 then
      end
    end
    L13 = table
    L13 = L13.insert
    L14 = L2
    L15 = L11
    L13(L14, L15)
  end
  if 0 < L6 then
    L9 = L2
    L9, L10, L11, L12, L13, L14, L15 = L8(L9)
    return L6(L7, L8, L9, L10, L11, L12, L13, L14, L15)
  else
    return L3
  end
end
L0.format_display_str = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _UPVALUE0_
  L2 = L2.decode
  L3 = A1
  L2 = L2(L3)
  L3 = ""
  L4 = ""
  L5 = ""
  L6 = L2.tag
  if L6 == nil then
    L6 = ""
    L7 = A1
    L8 = ""
    L9 = ""
    return L6, L7, L8, L9
  end
  L6 = L2.timestamp
  if L6 == nil then
    L6 = tonumber
    L7 = A0
    L6 = L6(L7)
    L2.timestamp = L6
  end
  L6 = _UPVALUE1_
  L7 = L2.tag
  L6 = L6[L7]
  L7 = _UPVALUE2_
  L7 = L7.format_display_str
  L8 = L6.msg
  L8 = L8 or L8
  L9 = L2
  L7 = L7(L8, L9)
  L3 = L7
  L7 = _UPVALUE2_
  L7 = L7.format_display_str
  L8 = L6.ext
  L8 = L8 or L8
  L9 = L2
  L7 = L7(L8, L9)
  L4 = L7
  L7 = string
  L7 = L7.upper
  L8 = L2.mac
  L8 = L8 or L8
  L7 = L7(L8)
  L5 = L7
  L7 = L2.tag
  L8 = L3
  L9 = L4
  L10 = L5
  return L7, L8, L9, L10
end
L0.parse_json_msg = L14
function L14(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L3 = L3.get_stat_from_sql
  L4 = string
  L4 = L4.format
  L5 = _UPVALUE1_
  L6 = A0 - 1
  L7 = A1
  L8 = A2
  L4 = L4(L5, L6, L7, L8)
  L5 = 1
  L3 = L3(L4, L5)
  L4 = tonumber
  L5 = L3
  L4 = L4(L5)
  L4 = L4 or L4
  return L4
end
L0.get_logs_cnt = L14
function L14(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L5 = is_sql_hack
  L6 = A2
  L5 = L5(L6)
  if L5 then
    L5 = {}
    return L5
  end
  L5 = {}
  L6 = _UPVALUE0_
  L6 = L6.exec_sql
  L10 = A1
  L11 = A2
  L12 = A3
  L13 = A4
  L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L7(L8, L9, L10, L11, L12, L13)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  for L10, L11 in L7, L8, L9 do
    L12 = L11[5]
    L13, L14, L15 = nil, nil, nil
    L16 = _UPVALUE0_
    L16 = L16.parse_json_msg
    L17 = L11[3]
    L18 = L12
    L16, L17, L18, L19 = L16(L17, L18)
    L14 = L19
    L15 = L18
    L13 = L17
    A2 = L16
    L16 = table
    L16 = L16.insert
    L17 = L5
    L18 = {}
    L19 = L11[1]
    L18.date = L19
    L19 = L11[2]
    L18.time = L19
    L19 = L11[3]
    L18.ts = L19
    L19 = L11[4]
    L18.id = L19
    L18.type = A2
    L18.msg = L13
    L18.ext = L15
    L18.mac = L14
    L18.dev = L14
    L16(L17, L18)
  end
  return L5
end
L0.get_logs = L14
return L0
