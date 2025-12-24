local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
L0 = require
L1 = "nixio.fs"
L0 = L0(L1)
L1 = require
L2 = "ubus"
L1 = L1(L2)
L2 = require
L3 = "luci.model.uci"
L2 = L2(L3)
L3 = require
L4 = "luci.util"
L3 = L3(L4)
util = L3
L3 = require
L4 = "posix"
L3 = L3(L4)
px = L3
L3 = require
L4 = "nixio"
L3 = L3(L4)
L4 = "/etc/config/"
L5 = "/tmp/etc/config/"
L6 = L4
L7 = "miqos"
L6 = L6 .. L7
L7 = L5
L8 = "miqos"
L7 = L7 .. L8
L8 = {}
L9 = {}
L9.path = "/var/run/miqosd.sock"
L8.server = L9
L9 = {}
L9.wire = 301
L9.wireless = 10
L8.idle_timeout = L9
L8.check_interval = 20
L8.clean_counters = 0
L9 = {}
L9.ip = ""
L9.mask = ""
L8.lan = L9
L9 = {}
L10 = {}
L10.dev = ""
L10.id = "2"
L9.UP = L10
L10 = {}
L10.dev = "br-lan"
L10.id = "1"
L9.DOWN = L10
L8.DEVS = L9
L9 = {}
L9.changed = 0
L9.UP = 0.6
L9.DOWN = 0.6
L10 = {}
L10.UP = 0
L10.DOWN = 0
L9.inner = L10
L9.default = 0.6
L8.guest = L9
L9 = {}
L9.changed = 0
L9.UP = 0.9
L9.DOWN = 0.9
L10 = {}
L10.UP = 0
L10.DOWN = 0
L9.inner = L10
L9.default = 0.9
L8.xq = L9
L9 = {}
L9.started = true
L9.changed = false
L9.flag = false
L8.enabled = L9
L9 = {}
L9.changed = false
L10 = g_group_def
L9.tab = L10
L9.default = "00"
L9.min_default = 0.5
L8.group = L9
L9 = {}
L9.changed = false
L9.seq = ""
L9.dft = "auto"
L8.flow = L9
L9 = {}
L9.old = nil
L9.cur = nil
L8.qdisc = L9
L9 = {}
L9.UP = 0
L9.DOWN = 0
L9.changed = true
L8.bands = L9
L9 = {}
L9.changed = false
L9.mode = "service"
L8.qos_type = L9
L8.quan = 1600
L8.virtual_proto = "ip"
L9 = {}
L9.changed = false
L9.enabled = false
L8.supress_host = L9
L9 = {}
L9.changed = false
L9.modeon = false
L9.plugon = false
L9.bandchanged = false
L9.cleanother = false
L9.cleanflag = false
L10 = {}
L10.UP = 1024000
L10.DOWN = 1024000
L9.bands = L10
L10 = {}
L10.UP = 5000
L10.DOWN = 5000
L9.devbands = L10
L10 = {}
L9.iplist = L10
L8.wangzhe = L9
cfg = L8
L8 = {}
L9 = {}
L9.game = 2
L9.web = 3
L9.video = 4
L9.download = 5
L8.auto = L9
L9 = {}
L9.game = 2
L9.web = 3
L9.video = 4
L9.download = 5
L8.game = L9
L9 = {}
L9.web = 2
L9.game = 3
L9.video = 4
L9.download = 5
L8.web = L9
L9 = {}
L9.video = 2
L9.game = 3
L9.web = 4
L9.download = 5
L8.video = L9
seq_prio = L8
L8 = "kbit"
UNIT = L8
L8 = "UP"
L9 = "DOWN"
DOWN = L9
UP = L8
L8 = "iptables -t mangle "
const_ipt_mangle = L8
L8 = "iptables -t mangle -F "
const_ipt_clear = L8
L8 = "iptables -t mangle -X "
const_ipt_delete = L8
L8 = "tc qdisc"
const_tc_qdisc = L8
L8 = "tc class"
const_tc_class = L8
L8 = "tc filter"
const_tc_filter = L8
L8 = {}
qdisc = L8
L8 = ""
L9 = ""
cur_qdisc = L9
old_qdisc = L8
L8 = false
g_debug = L8
L8 = 100
g_CONFIG_HZ = L8
L8 = 1.5
g_htb_buffer_factor = L8
L8 = g_CONFIG_HZ
L8 = 128 / L8
g_htb_buffer_data = L8
L8 = 1600
g_min_burst = L8
L8 = false
g_supress_host = L8
L8 = px
L8 = L8.openlog
L9 = "miqos"
L10 = LOG_NDELAY
L11 = LOG_USER
L8(L9, L10, L11)
function L8(A0, A1)
  local L2, L3, L4
  L2 = px
  L2 = L2.syslog
  L3 = A0
  L4 = A1
  L2(L3, L4)
end
logger = L8
L8 = "/tmp/miqos.lock"
const_lockfile = L8
L8 = nil
g_lockfile = L8
function L8(A0)
  local L1, L2, L3, L4
  if not A0 or A0 == "" then
    L1 = nil
    return L1
  end
  L1 = io
  L1 = L1.popen
  L2 = A0
  L1 = L1(L2)
  L3 = L1
  L2 = L1.read
  L4 = "*line"
  L2 = L2(L3, L4)
  L4 = L1
  L3 = L1.close
  L3(L4)
  return L2
end
run_cmd = L8
function L8()
  local L0, L1
  L0 = run_cmd
  L1 = "/usr/sbin/mwan3 curr_wan ipv4"
  L0 = L0(L1)
  if not L0 or L0 == "" then
    L1 = "wan"
    return L1
  end
  return L0
end
get_cur_wan_sec = L8
function L8()
  local L0, L1, L2, L3, L4
  L0 = get_cur_wan_sec
  L0 = L0()
  L1 = run_cmd
  L2 = "uci -q get network."
  L3 = L0
  L4 = ".proto"
  L2 = L2 .. L3 .. L4
  return L1(L2)
end
get_wan_proto = L8
function L8(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  if A0 == "lan" then
    L2 = "br-lan"
    return L2
  elseif A0 == "wan" then
    L2 = run_cmd
    L3 = "uci -q get misc.hardware.model"
    L2 = L2(L3)
    L2 = L2 or L2
    if L2 == "D01" then
      L3 = "eth0"
      return L3
    end
    L3 = get_cur_wan_sec
    L3 = L3()
    L4 = run_cmd
    L5 = "uci -q get network."
    L6 = L3
    L7 = ".ifname"
    L5 = L5 .. L6 .. L7
    return L4(L5)
  end
  L2 = ""
  return L2
end
read_interfaces = L8
function L8()
  local L0, L1, L2
  L0 = g_lockfile
  if not L0 then
    L0 = _UPVALUE0_
    L0 = L0.open
    L1 = const_lockfile
    L2 = "w"
    L0 = L0(L1, L2)
    g_lockfile = L0
  end
  L0 = g_lockfile
  L1 = L0
  L0 = L0.lock
  L2 = "tlock"
  L0 = L0(L1, L2)
  if not L0 then
    L0 = logger
    L1 = 3
    L2 = "Note: try to get lock failed ."
    L0(L1, L2)
    L0 = false
    return L0
  end
  L0 = true
  return L0
end
lock = L8
function L8()
  local L0, L1, L2
  L0 = g_lockfile
  if L0 then
    L0 = g_lockfile
    L1 = L0
    L0 = L0.lock
    L2 = "ulock"
    L0(L1, L2)
    L0 = g_lockfile
    L1 = L0
    L0 = L0.close
    L0(L1)
    L0 = nil
    g_lockfile = L0
  end
  L0 = true
  return L0
end
unlock = L8
L8 = L1.connect
L8 = L8()
g_ubus = L8
function L8()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = QOS_VER
  if L0 ~= "FIX" then
    L0 = QOS_VER
    if L0 ~= "NOIFB" then
      goto lbl_9
    end
  end
  L0 = true
  do return L0 end
  ::lbl_9::
  L0 = _UPVALUE0_
  L0 = L0.mkdirr
  L1 = _UPVALUE1_
  L0, L1, L2 = L0(L1)
  if not L0 then
    L3 = logger
    L4 = 3
    L5 = "fatal error: mkdir failed, code:"
    L6 = L1
    L7 = ",msg:"
    L8 = L2
    L5 = L5 .. L6 .. L7 .. L8
    L3(L4, L5)
    L3 = nil
    return L3
  end
  L3 = _UPVALUE0_
  L3 = L3.copy
  L4 = _UPVALUE2_
  L5 = _UPVALUE3_
  L3, L4, L5 = L3(L4, L5)
  L2 = L5
  L1 = L4
  L0 = L3
  if not L0 then
    L3 = logger
    L4 = 3
    L5 = "fatal error: copy cfg file 2 /tmp memory failed. code:"
    L6 = L1
    L7 = ",msg:"
    L8 = L2
    L5 = L5 .. L6 .. L7 .. L8
    L3(L4, L5)
    L3 = nil
    return L3
  end
  L3 = true
  return L3
end
cfg2tmp = L8
function L8(A0)
  local L1, L2, L3
  L1 = string
  L1 = L1.format
  L2 = "%x"
  L3 = A0
  return L1(L2, L3)
end
dec2hexstr = L8
function L8()
  local L0, L1, L2
  L0 = QOS_VER
  if L0 ~= "FIX" then
    L0 = QOS_VER
    if L0 ~= "NOIFB" then
      goto lbl_9
    end
  end
  L0 = true
  do return L0 end
  ::lbl_9::
  L0 = _UPVALUE0_
  L0 = L0.copy
  L1 = _UPVALUE1_
  L2 = _UPVALUE2_
  L0 = L0(L1, L2)
  if not L0 then
    L0 = logger
    L1 = 3
    L2 = "fatal error: copy /tmp cfg file 2 /etc/config/ failed. exit."
    L0(L1, L2)
    L0 = nil
    return L0
  end
  L0 = os
  L0 = L0.execute
  L1 = "/bin/sync"
  L0(L1)
  L0 = true
  return L0
end
tmp2cfg = L8
function L8(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = {}
  if not A0 then
  end
  for L5, L6 in L2, L3, L4 do
    L7 = type
    L8 = L6
    L7 = L7(L8)
    if L7 ~= "table" then
      L1[L5] = L6
    else
      L7 = copytab
      L8 = L6
      L7 = L7(L8)
      L1[L5] = L7
    end
  end
  return L1
end
copytab = L8
function L8(A0, A1, A2, A3)
  local L4, L5, L6, L7
  L4 = _UPVALUE0_
  L4 = L4.cursor
  L4 = L4()
  L5 = pcall
  function L6()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.get
    L2 = _UPVALUE1_
    L3 = _UPVALUE2_
    L4 = _UPVALUE3_
    return L0(L1, L2, L3, L4)
  end
  L5, L6 = L5(L6)
  L7 = L6 or L7
  if not L6 then
    L7 = A3
  end
  return L7
end
get_conf_std = L8
function L8()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L0 = L0.cursor
  L0 = L0()
  L1 = QOS_VER
  if L1 ~= "FIX" then
    L1 = QOS_VER
    if L1 ~= "NOIFB" then
      L2 = L0
      L1 = L0.set_confdir
      L3 = _UPVALUE1_
      L1(L2, L3)
    end
  end
  return L0
end
get_cursor = L8
function L8(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = {}
  L3 = get_cursor
  L3 = L3()
  L4 = pcall
  function L5()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.foreach
    L2 = _UPVALUE1_
    L3 = _UPVALUE2_
    function L4(A0)
      local L1, L2
      L1 = _UPVALUE0_
      L2 = A0.name
      L1[L2] = A0
    end
    L0(L1, L2, L3, L4)
  end
  L4, L5 = L4(L5)
  L6 = L2 or L6
  if not L2 then
    L6 = {}
  end
  return L6
end
get_tbls = L8
function L8(A0)
  local L1, L2, L3, L4, L5
  L1 = g_ubus
  L2 = L1
  L1 = L1.call
  L3 = "network.interface"
  L4 = "status"
  L5 = {}
  L5.interface = A0
  L1 = L1(L2, L3, L4, L5)
  if L1 then
    L2 = table
    L2 = L2.getn
    L3 = L1["ipv4-address"]
    L2 = L2(L3)
    if 0 < L2 then
      L2 = table
      L2 = L2.remove
      L3 = L1["ipv4-address"]
      L2 = L2(L3)
      L3 = L2.address
      L4 = L2.mask
      return L3, L4
    end
  end
  L2 = nil
  return L2
end
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = cfg
  L0 = L0.lan
  L1.mask = L3
  L0.ip = L2
  L0 = QOS_VER
  if L0 == "HWQOS" then
    L0 = true
    return L0
  end
  L0 = get_wan_proto
  L0 = L0()
  if L1 == "STD" then
    if L0 == "dhcp" or L0 == "static" then
      L1.dev = L2
      L1.virtual_proto = "ip"
    elseif L0 == "pppoe" then
      L1.dev = L2
      L1.virtual_proto = "pppoe"
    else
      L1(L2, L3)
      return L1
    end
  else
    L1.dev = L2
    if L0 == "pppoe" then
      L1.virtual_proto = "pppoe"
    else
      L1.virtual_proto = "ip"
    end
  end
  if L1 == "NOIFB" then
    L1.dev = "br-lan"
  end
  for L4, L5 in L1, L2, L3 do
    L6 = util
    L6 = L6.exec
    L7 = "ip link 2>&-|grep UP|grep "
    L8 = L5.dev
    L7 = L7 .. L8
    L6 = L6(L7)
    if L6 == "" then
      L7 = logger
      L8 = 3
      L9 = "DEV "
      L10 = L5.dev
      L11 = " is not UP. exit. "
      L9 = L9 .. L10 .. L11
      L7(L8, L9)
      L7 = false
      return L7
    end
  end
  return L1
end
read_network_conf = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = QOS_VER
  if L0 ~= "FIX" then
    L0 = cfg
    L0 = L0.enabled
    L0 = L0.started
    if not L0 then
      L0 = g_debug
      if L0 then
        L0 = logger
        L1 = 3
        L2 = "qos stopped, no action."
        L0(L1, L2)
      end
      L0 = false
      return L0
    end
  end
  L0, L1 = nil, nil
  L2 = get_tbls
  L3 = "miqos"
  L4 = "miqos"
  L2 = L2(L3, L4)
  L3 = L2.settings
  L3 = L3.enabled
  L0 = L3 or L0
  if not L3 then
    L0 = "0"
  end
  L3 = cfg
  L3 = L3.enabled
  L3 = L3.flag
  if L3 ~= L0 then
    L3 = cfg
    L3 = L3.enabled
    L3.flag = L0
    L3 = cfg
    L3 = L3.enabled
    L3.changed = true
  end
  L3 = L2.settings
  L3 = L3.qos_auto
  L0 = L3 or L0
  if not L3 then
    L0 = "auto"
  end
  L3 = cfg
  L3 = L3.qos_type
  L3 = L3.mode
  if L3 ~= L0 then
    L3 = cfg
    L3 = L3.qos_type
    L3.mode = L0
    L3 = cfg
    L3 = L3.qos_type
    L3.changed = true
  else
    L3 = cfg
    L3 = L3.qos_type
    L3.changed = false
  end
  L3 = get_tbls
  L4 = "miqos"
  L5 = "system"
  L3 = L3(L4, L5)
  L4 = L3.param
  L4 = L4.seq_prio
  L4 = L4 or L4
  L5 = cfg
  L5 = L5.flow
  L5 = L5.seq
  if L5 ~= L4 then
    L5 = cfg
    L5 = L5.flow
    L5.seq = L4
    L5 = cfg
    L5 = L5.flow
    L5 = L5.seq
    if L5 == "" then
      L5 = cfg
      L5 = L5.flow
      L6 = cfg
      L6 = L6.flow
      L6 = L6.dft
      L5.seq = L6
    end
    L5 = cfg
    L5 = L5.flow
    L5.changed = true
  end
  L5 = L2.settings
  L5 = L5.upload
  L4 = L5 or L4
  if not L5 then
    L4 = "0"
  end
  L5 = L2.settings
  L5 = L5.download
  L1 = L5 or L1
  if not L5 then
    L1 = "0"
  end
  L5 = cfg
  L5 = L5.bands
  L5 = L5.UP
  if L5 == L4 then
    L5 = cfg
    L5 = L5.bands
    L5 = L5.DOWN
    if L5 == L1 then
      goto lbl_121
    end
  end
  L5 = cfg
  L5 = L5.bands
  L6 = cfg
  L6 = L6.bands
  L7 = L4
  L6.DOWN = L1
  L5.UP = L7
  L5 = cfg
  L5 = L5.bands
  L5.changed = true
  goto lbl_124
  ::lbl_121::
  L5 = cfg
  L5 = L5.bands
  L5.changed = false
  ::lbl_124::
  L5 = tonumber
  L6 = cfg
  L6 = L6.bands
  L6 = L6.UP
  L5 = L5(L6)
  if not (L5 <= 0) then
    L5 = tonumber
    L6 = cfg
    L6 = L6.bands
    L6 = L6.DOWN
    L5 = L5(L6)
    if not (L5 <= 0) then
      goto lbl_169
    end
  end
  L5 = cfg
  L6 = cfg
  L6 = L6.clean_counters
  L6 = L6 + 1
  L5.clean_counters = L6
  L5 = g_debug
  if L5 then
    L5 = logger
    L6 = 3
    L7 = "bands zero clean counters: "
    L8 = cfg
    L8 = L8.clean_counters
    L7 = L7 .. L8
    L5(L6, L7)
  end
  L5 = cfg
  L5 = L5.clean_counters
  if L5 < 3 then
    L5 = g_debug
    if L5 then
      L5 = logger
      L6 = 3
      L7 = "bands zero clean system "
      L5(L6, L7)
    end
    L5 = cleanup_system
    L5()
  end
  L5 = false
  do return L5 end
  goto lbl_190
  ::lbl_169::
  L5 = tonumber
  L6 = cfg
  L6 = L6.bands
  L6 = L6.DOWN
  L5 = L5(L6)
  if L5 < 8000 then
    L5 = cfg
    L5 = L5.bands
    L5.UP = "0"
    L5 = cfg
    L5 = L5.bands
    L5.DOWN = "0"
    L5 = update_bw
    L6 = "0"
    L7 = "0"
    L5(L6, L7)
    L5 = cleanup_system
    L5()
    L5 = false
    return L5
  end
  ::lbl_190::
  L5 = QOS_VER
  if L5 == "HWQOS" then
    L5 = cfg
    L5 = L5.qdisc
    L5.cur = "service"
  else
    L5 = cfg
    L5 = L5.enabled
    L5 = L5.flag
    if L5 == "0" then
      L5 = cfg
      L5 = L5.qdisc
      L5.cur = "prio"
    else
      L5 = cfg
      L5 = L5.qdisc
      L5.cur = "service"
    end
  end
  L5 = QOS_VER
  if L5 == "FIX" then
    L5 = "service"
    cur_qdisc = L5
    L5 = cfg
    L5 = L5.qdisc
    L5.cur = "service"
  else
    L5 = QOS_VER
    if L5 == "NOIFB" then
      L5 = "noifb"
      cur_qdisc = L5
      L5 = cfg
      L5 = L5.qdisc
      L5.cur = "noifb"
    else
      L5 = cfg
      L5 = L5.qdisc
      L5 = L5.old
      L6 = cfg
      L6 = L6.qdisc
      L6 = L6.cur
      cur_qdisc = L6
      old_qdisc = L5
    end
  end
  L5 = qdisc
  L6 = cur_qdisc
  L5 = L5[L6]
  if L5 then
    L5 = qdisc
    L6 = cur_qdisc
    L5 = L5[L6]
    L5 = L5.read_qos_config
    if L5 then
      L5 = qdisc
      L6 = cur_qdisc
      L5 = L5[L6]
      L5 = L5.read_qos_config
      L5()
    end
  end
  L5 = true
  return L5
end
read_qos_config = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  g_group_def = L0
  L0.min_grp_uplink = L1
  L0.min_grp_downlink = L1
  if L0 ~= "FIX" then
    if L0 ~= "HWQOS" then
      if L0 ~= "NOIFB" then
        goto lbl_84
      end
    end
  end
  for L3, L4 in L0, L1, L2 do
    L5 = L4.name
    L6 = cfg
    L6 = L6.group
    L6 = L6.default
    if L5 ~= L6 then
      L5 = L4.flag
      if not L5 then
        L5 = tonumber
        L6 = g_group_def
        L6 = L6[L3]
        L6 = L6.max_grp_uplink
        L6 = L6 or L6
        L5 = L5(L6)
        if L5 <= 0 then
          L5 = tonumber
          L6 = g_group_def
          L6 = L6[L3]
          L6 = L6.max_grp_downlink
          L6 = L6 or L6
          L5 = L5(L6)
          if L5 <= 0 then
            L5 = g_group_def
            L5 = L5[L3]
            L5.flag = "off"
          end
        end
      else
        L5 = L4.flag
        if L5 == "off" then
          L5 = g_group_def
          L5 = L5[L3]
          L5.max_grp_uplink = 0
          L5 = g_group_def
          L5 = L5[L3]
          L5.max_grp_downlink = 0
        end
      end
    end
  end
  do return L0 end
  goto lbl_275
  ::lbl_84::
  if L0 == "auto" then
    for L3, L4 in L0, L1, L2 do
      L5 = L4.name
      L6 = cfg
      L6 = L6.group
      L6 = L6.default
      if L5 ~= L6 then
        L5 = g_group_def
        L5[L3] = nil
      else
        L5 = g_group_def
        L5 = L5[L3]
        L6 = cfg
        L6 = L6.group
        L6 = L6.min_default
        L5.min_grp_uplink = L6
        L5 = g_group_def
        L5 = L5[L3]
        L6 = cfg
        L6 = L6.group
        L6 = L6.min_default
        L5.min_grp_downlink = L6
      end
    end
  elseif L0 == "min" then
    for L3, L4 in L0, L1, L2 do
      L5 = L4.name
      L6 = cfg
      L6 = L6.group
      L6 = L6.default
      if L5 ~= L6 then
        L5 = g_group_def
        L5 = L5[L3]
        L5.max_grp_uplink = 0
        L5 = g_group_def
        L5 = L5[L3]
        L5.max_grp_downlink = 0
      end
      L5 = g_group_def
      L5 = L5[L3]
      L5 = L5.min_grp_uplink
      if L5 == 0 then
        L5 = g_group_def
        L5 = L5[L3]
        L6 = cfg
        L6 = L6.group
        L6 = L6.min_default
        L5.min_grp_uplink = L6
      end
      L5 = g_group_def
      L5 = L5[L3]
      L5 = L5.min_grp_downlink
      if L5 == 0 then
        L5 = g_group_def
        L5 = L5[L3]
        L6 = cfg
        L6 = L6.group
        L6 = L6.min_default
        L5.min_grp_downlink = L6
      end
    end
  elseif L0 == "max" then
    for L3, L4 in L0, L1, L2 do
      L5 = L4.name
      L6 = cfg
      L6 = L6.group
      L6 = L6.default
      if L5 ~= L6 then
        L5 = g_group_def
        L5 = L5[L3]
        L5.min_grp_uplink = 0
        L5 = g_group_def
        L5 = L5[L3]
        L5.min_grp_downlink = 0
      end
      L5 = g_group_def
      L5 = L5[L3]
      L5 = L5.min_grp_uplink
      if L5 == 0 then
        L5 = g_group_def
        L5 = L5[L3]
        L6 = cfg
        L6 = L6.group
        L6 = L6.min_default
        L5.min_grp_uplink = L6
      end
      L5 = g_group_def
      L5 = L5[L3]
      L5 = L5.min_grp_downlink
      if L5 == 0 then
        L5 = g_group_def
        L5 = L5[L3]
        L6 = cfg
        L6 = L6.group
        L6 = L6.min_default
        L5.min_grp_downlink = L6
      end
    end
  elseif L0 == "both" then
  elseif L0 == "service" then
    for L3, L4 in L0, L1, L2 do
      L5 = L4.name
      L6 = cfg
      L6 = L6.group
      L6 = L6.default
      if L5 ~= L6 then
        L5 = L4.flag
        if not L5 then
          L5 = tonumber
          L6 = g_group_def
          L6 = L6[L3]
          L6 = L6.max_grp_uplink
          L6 = L6 or L6
          L5 = L5(L6)
          if L5 <= 0 then
            L5 = tonumber
            L6 = g_group_def
            L6 = L6[L3]
            L6 = L6.max_grp_downlink
            L6 = L6 or L6
            L5 = L5(L6)
            if L5 <= 0 then
              L5 = g_group_def
              L5 = L5[L3]
              L5.flag = "off"
            end
          end
        else
          L5 = L4.flag
          if L5 == "off" then
            L5 = g_group_def
            L5 = L5[L3]
            L5.max_grp_uplink = 0
            L5 = g_group_def
            L5 = L5[L3]
            L5.max_grp_downlink = 0
          end
        end
      end
    end
  else
    L0(L1, L2)
    return L0
  end
  ::lbl_275::
  return L0
end
read_qos_group_config = L9
function L9(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L1 = {}
  L1[1] = L2
  L1[2] = L3
  if A0 then
    for L5, L6 in L2, L3, L4 do
      L8[1] = L9
      L8[2] = L10
      for L10, L11 in L7, L8, L9 do
        L13 = cfg
        L13 = L13[L6]
        L13 = L13.default
        if L12 <= 0 then
          L13 = cfg
          L13 = L13[L6]
          L14 = tonumber
          L15 = cfg
          L15 = L15.bands
          L15 = L15[L11]
          L14 = L14(L15)
          L13[L11] = L14
        elseif L12 <= 1 then
          L13 = cfg
          L13 = L13[L6]
          L14 = math
          L14 = L14.ceil
          L15 = cfg
          L15 = L15.bands
          L15 = L15[L11]
          L15 = L15 * L12
          L14 = L14(L15)
          L13[L11] = L14
        else
          L13 = cfg
          L13 = L13[L6]
          L14 = math
          L14 = L14.ceil
          L15 = L12
          L14 = L14(L15)
          L13[L11] = L14
        end
      end
    end
    return L2
  end
  for L6, L7 in L3, L4, L5 do
    if L8 then
      if L10 == L8 then
        if L10 == L9 then
          goto lbl_110
        end
      end
      L11.DOWN = L9
      L10.UP = L12
      L10.changed = 1
      goto lbl_113
      ::lbl_110::
      L10.changed = 0
      ::lbl_113::
      L13 = "DOWN"
      L11[1] = L12
      L11[2] = L13
      for L13, L14 in L10, L11, L12 do
        L15 = tonumber
        L16 = cfg
        L16 = L16[L7]
        L16 = L16.inner
        L16 = L16[L14]
        L15 = L15(L16)
        if L15 <= 0 then
          L16 = cfg
          L16 = L16[L7]
          L17 = tonumber
          L18 = cfg
          L18 = L18.bands
          L18 = L18[L14]
          L17 = L17(L18)
          L16[L14] = L17
        elseif L15 <= 1 then
          L16 = cfg
          L16 = L16[L7]
          L17 = math
          L17 = L17.ceil
          L18 = cfg
          L18 = L18.bands
          L18 = L18[L14]
          L18 = L18 * L15
          L17 = L17(L18)
          L16[L14] = L17
        else
          L16 = cfg
          L16 = L16[L7]
          L17 = math
          L17 = L17.ceil
          L18 = L15
          L17 = L17(L18)
          L16[L14] = L17
        end
      end
    end
  end
  return L3
end
read_qos_guest_xq_config = L9
function L9(A0)
  local L1, L2, L3, L4
  L1 = math
  L1 = L1.ceil
  L2 = g_htb_buffer_data
  L2 = A0 * L2
  L3 = g_htb_buffer_factor
  L2 = L2 * L3
  L1 = L1(L2)
  L2 = math
  L2 = L2.ceil
  L3 = g_htb_buffer_data
  L3 = A0 * L3
  L2 = L2(L3)
  L3 = g_min_burst
  if L1 < L3 then
    L1 = g_min_burst
  end
  L3 = g_min_burst
  if L2 < L3 then
    L2 = g_min_burst
  end
  L3 = L1
  L4 = L2
  return L3, L4
end
get_burst = L9
function L9(A0, A1)
  local L2, L3, L4
  L2 = A0
  L3 = cfg
  L3 = L3.supress_host
  L3 = L3.enabled
  if L3 and A1 and 0 < A1 then
    L3 = math
    L3 = L3.ceil
    L4 = A0 * 0.75
    L3 = L3(L4)
    if A1 < L3 then
      L3 = A1
    end
    L2 = L2 - L3
  end
  return L2
end
get_supressed_ceil = L9
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = "/tmp/miqos.log"
  for L6, L7 in L3, L4, L5 do
    L8 = L7
    L9 = g_debug
    if L9 then
      L9 = logger
      L10 = 3
      L11 = "++"
      L12 = L8
      L11 = L11 .. L12
      L9(L10, L11)
      L9 = L8
      L10 = " >/dev/null 2>>"
      L11 = L2
      L8 = L9 .. L10 .. L11
    else
      L9 = L8
      L10 = " &>/dev/null "
      L8 = L9 .. L10
    end
    L9 = os
    L9 = L9.execute
    L10 = L8
    L9 = L9(L10)
    if L9 ~= 0 and A1 ~= 1 then
      L9 = g_debug
      if L9 then
        L9 = os
        L9 = L9.execute
        L10 = "echo \"^^^ "
        L11 = L8
        L12 = " ^^^ \" >>"
        L13 = L2
        L10 = L10 .. L11 .. L12 .. L13
        L9(L10)
      end
      L9 = logger
      L10 = 3
      L11 = "[ERROR]:  "
      L12 = L8
      L13 = " failed!"
      L11 = L11 .. L12 .. L13
      L9(L10, L11)
      L9 = dump_qdisc
      L10 = cfg
      L10 = L10.DEVS
      L9(L10)
      L9 = system_exit
      L9()
      L9 = false
      return L9
    end
  end
  return L3
end
exec_cmd = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L1 = {}
  L2 = setmetatable
  L3 = L1
  L4 = {}
  L5 = {}
  function L6(A0, A1)
    local L2, L3, L4
    L2 = _UPVALUE0_
    L2 = L2[A1]
    if not L2 then
      L2 = table
      L2 = L2.insert
      L3 = A0
      L4 = A1
      L2(L3, L4)
      L2 = _UPVALUE0_
      L3 = table
      L3 = L3.getn
      L4 = A0
      L3 = L3(L4)
      L2[A1] = L3
    end
  end
  L5.insert = L6
  function L6(A0, A1)
    local L2, L3, L4
    L2 = _UPVALUE0_
    L2 = L2[A1]
    if L2 then
      L3 = _UPVALUE0_
      L3[A1] = nil
      L3 = table
      L3 = L3.remove
      L4 = A0
      L3 = L3(L4)
      if L3 ~= A1 then
        L4 = _UPVALUE0_
        L4[L3] = L2
        A0[L2] = L3
      end
    end
  end
  L5.remove = L6
  L4.__index = L5
  return L2(L3, L4)
end
newset = L9
L9 = string
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = {}
  L3 = string
  L3 = L3.gsub
  L4 = A0
  L5 = "[^"
  L6 = A1
  L7 = "]+"
  L5 = L5 .. L6 .. L7
  function L6(A0)
    local L1, L2, L3
    L1 = table
    L1 = L1.insert
    L2 = _UPVALUE0_
    L3 = A0
    L1(L2, L3)
  end
  L3(L4, L5, L6)
  return L2
end
L9.split = L10
function L9(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L3 = "    "
  L3 = L3 .. L4
  A2 = A2 or A2
  if not A0 then
  end
  for L7, L8 in L4, L5, L6 do
    L9 = type
    L10 = L8
    L9 = L9(L10)
    if L9 == "table" then
      L9 = A2
      L10 = 3
      L11 = L3
      L12 = L7
      L13 = " = {"
      L11 = L11 .. L12 .. L13
      L9(L10, L11)
      L9 = _UPVALUE0_
      L10 = L8
      L11 = L3
      L12 = A2
      L9(L10, L11, L12)
      L9 = A2
      L10 = 3
      L11 = L3
      L12 = "}"
      L11 = L11 .. L12
      L9(L10, L11)
    else
      L9 = type
      L10 = L8
      L9 = L9(L10)
      if L9 == "boolean" then
        L9 = "false"
        if L8 then
          L9 = "true"
        end
        L10 = A2
        L11 = 3
        L12 = L3
        L13 = L7
        L14 = "="
        L15 = L9
        L12 = L12 .. L13 .. L14 .. L15
        L10(L11, L12)
      else
        L9 = A2
        L10 = 3
        L11 = L3
        L12 = L7
        L13 = "="
        L14 = L8
        L11 = L11 .. L12 .. L13 .. L14
        L9(L10, L11)
      end
    end
  end
end
function L10(A0, A1, A2)
  local L3, L4, L5
  A2 = A2 or A2
  A1 = A1 or A1
  L3 = A1
  L4 = "-----------------"
  A1 = L3 .. L4
  L3 = A2
  L4 = 3
  L5 = A1
  L3(L4, L5)
  L3 = _UPVALUE0_
  L4 = A0
  L5 = ""
  L3(L4, L5)
  L3 = A2
  L4 = 3
  L5 = A1
  L3(L4, L5)
end
pr = L10
function L10(A0, A1)
  local L2, L3, L4, L5
  L2 = printf
  if not L2 then
    L2 = logger
    printf = L2
  end
  A1 = A1 or A1
  L2 = A1
  L3 = "-----------------"
  A1 = L2 .. L3
  L2 = printf
  L3 = 3
  L4 = A1
  L2(L3, L4)
  L2 = _UPVALUE0_
  L3 = A0
  L4 = ""
  L5 = printf
  L2(L3, L4, L5)
  L2 = printf
  L3 = 3
  L4 = A1
  L2(L3, L4)
end
pr_console = L10
function L10()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = "INFO,"
  L1 = "Qdisc:"
  L2 = cfg
  L2 = L2.qdisc
  L2 = L2.cur
  L2 = L2 or L2
  L3 = ",Mode:"
  L4 = cfg
  L4 = L4.qos_type
  L4 = L4.mode
  L5 = ",Band: U:"
  L6 = cfg
  L6 = L6.bands
  L6 = L6.UP
  L7 = "kbps,D:"
  L8 = cfg
  L8 = L8.bands
  L8 = L8.DOWN
  L9 = "kbps"
  L0 = L0 .. L1 .. L2 .. L3 .. L4 .. L5 .. L6 .. L7 .. L8 .. L9
  return L0
end
p_sysinfo = L10
L10 = {}
g_limit = L10
function L10(A0)
  local L1, L2, L3
  L1 = cfg
  L1 = L1.qdisc
  L1 = L1.cur
  L2 = qdisc
  L2 = L2[L1]
  if L2 then
    L2 = qdisc
    L2 = L2[L1]
    L2 = L2.update_counters
    if L2 then
      L2 = qdisc
      L2 = L2[L1]
      L2 = L2.update_counters
      L3 = A0
      L2 = L2(L3)
      g_limit = L2
  end
  else
    L2 = {}
    g_limit = L2
  end
end
update_counters = L10
L10 = "tc -d qdisc show | sort "
L11 = "tc -d class show dev "
L12 = "tc -d filter show dev "
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = {}
  L2(L3, L4)
  for L5, L6 in L2, L3, L4 do
    L7 = table
    L7 = L7.insert
    L8 = L1
    L7(L8, L9)
  end
  for L5, L6 in L2, L3, L4 do
    L7 = table
    L7 = L7.insert
    L8 = L1
    L7(L8, L9)
  end
  L2(L3, L4)
  for L7, L8 in L4, L5, L6 do
    if L2 then
      for L12 in L9, L10, L11 do
        L13 = logger
        L14 = 3
        L15 = L12
        L13(L14, L15)
      end
    end
  end
  L4(L5)
  L4(L5, L6)
end
dump_qdisc = L13
function L13(A0)
  local L1, L2, L3, L4, L5
  L1 = 5000
  L2 = 100000
  if A0 <= 0 then
    L3 = L1
    L4 = L2
    return L3, L4
  end
  L1 = 12800000 / A0
  if L1 < 5000 then
    L1 = 5000
  end
  L2 = 95000 + L1
  L3 = math
  L3 = L3.ceil
  L4 = L1
  L3 = L3(L4)
  L4 = math
  L4 = L4.ceil
  L5 = L2
  L4, L5 = L4(L5)
  return L3, L4, L5
end
calc_fq_codel_params = L13
function L13(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L6 = "add"
  L7 = nil
  L8 = {}
  L9 = g_leaf_type
  if L9 == "sfq" then
    if not A5 then
      L9 = string
      L9 = L9.format
      L10 = " %s del dev %s parent %s:%s sfq"
      L11 = const_tc_qdisc
      L12 = A1
      L13 = A2
      L14 = A3
      L9 = L9(L10, L11, L12, L13, L14)
      L7 = L9
      L9 = table
      L9 = L9.insert
      L10 = L8
      L11 = L7
      L9(L10, L11)
    end
    L9 = string
    L9 = L9.format
    L10 = " %s %s dev %s parent %s:%s sfq perturb 10 "
    L11 = const_tc_qdisc
    L12 = L6
    L13 = A1
    L14 = A2
    L15 = A3
    L9 = L9(L10, L11, L12, L13, L14, L15)
    L7 = L9
    L9 = table
    L9 = L9.insert
    L10 = A0
    L11 = L7
    L9(L10, L11)
  else
    L9 = g_leaf_type
    if L9 == "fq_codel" then
      if not A5 then
        L9 = string
        L9 = L9.format
        L10 = " %s del dev %s parent %s:%s "
        L11 = const_tc_qdisc
        L12 = A1
        L13 = A2
        L14 = A3
        L9 = L9(L10, L11, L12, L13, L14)
        L7 = L9
        L9 = table
        L9 = L9.insert
        L10 = L8
        L11 = L7
        L9(L10, L11)
      end
      L9 = calc_fq_codel_params
      L10 = A4
      L9, L10 = L9(L10)
      L11 = string
      L11 = L11.format
      L12 = " %s %s dev %s parent %s:%s fq_codel limit 1024 flows 1024 target %sus interval %sus "
      L13 = const_tc_qdisc
      L14 = L6
      L15 = A1
      L16 = A2
      L17 = A3
      L18 = L9
      L19 = L10
      L11 = L11(L12, L13, L14, L15, L16, L17, L18, L19)
      L7 = L11
      L11 = table
      L11 = L11.insert
      L12 = A0
      L13 = L7
      L11(L12, L13)
    else
      if not A5 then
        L9 = string
        L9 = L9.format
        L10 = " %s del dev %s parent %s:%s "
        L11 = const_tc_qdisc
        L12 = A1
        L13 = A2
        L14 = A3
        L9 = L9(L10, L11, L12, L13, L14)
        L7 = L9
        L9 = table
        L9 = L9.insert
        L10 = L8
        L11 = L7
        L9(L10, L11)
      end
      L9 = string
      L9 = L9.format
      L10 = " %s %s dev %s parent %s:%s pfifo limit 1024 "
      L11 = const_tc_qdisc
      L12 = L6
      L13 = A1
      L14 = A2
      L15 = A3
      L9 = L9(L10, L11, L12, L13, L14, L15)
      L7 = L9
      L9 = table
      L9 = L9.insert
      L10 = A0
      L11 = L7
      L9(L10, L11)
    end
  end
  L9 = exec_cmd
  L10 = L8
  L11 = 1
  L9(L10, L11)
end
apply_leaf_qdisc = L13
function L13(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L4 = A3 or L4
  if not A3 then
    L4 = "1"
  end
  L5 = "0x80"
  L6 = 0
  L7 = nil
  L8 = cfg
  L8 = L8.virtual_proto
  if L8 == "pppoe" then
    L6 = 6
    L7 = "0x8864"
    L8 = string
    L8 = L8.format
    L9 = " %s %s dev %s parent %s: prio %s protocol %s u32 match u8 0x80 %s at %d flowid %s: "
    L10 = const_tc_filter
    L11 = "add"
    L12 = A1
    L13 = A2
    L14 = L4
    L15 = L7
    L16 = L5
    L17 = L6
    L18 = A2
    L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16, L17, L18)
    expr = L8
    L8 = table
    L8 = L8.insert
    L9 = A0
    L10 = expr
    L8(L9, L10)
  end
end
apply_ppp_qdisc = L13
function L13(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L5 = ""
  L6 = "ip"
  L7 = 0
  L8 = "3"
  L9 = cfg
  L9 = L9.virtual_proto
  if L9 == "pppoe" then
    if A1 == "pppoe-wan" then
      L7 = 0
    else
      L9 = string
      L9 = L9.find
      L10 = A1
      L11 = "eth"
      L12 = 1
      L9 = L9(L10, L11, L12)
      if L9 then
        L7 = 8
        L6 = "0x8864"
      else
        L9 = QOS_VER
        if L9 == "STD" then
          L6 = "0x8864"
          L7 = 8
        else
          L6 = "ip"
          L7 = 0
        end
      end
    end
  end
  L9 = "0xffc0"
  L10 = string
  L10 = L10.format
  L11 = " %s %s dev %s parent %s: prio %s protocol %s u32 match u16 0x0000 %s at %d flowid %s:%s "
  L12 = const_tc_filter
  L13 = A2
  L14 = A1
  L15 = A3
  L16 = L8
  L17 = L6
  L18 = L9
  L19 = L7 + 2
  L20 = A3
  L21 = A4
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21)
  L5 = L10
  L10 = table
  L10 = L10.insert
  L11 = A0
  L12 = L5
  L10(L11, L12)
end
apply_arp_small_filter = L13
function L13(A0)
  local L1, L2, L3, L4
  L1 = g_enable_stab
  if L1 then
    L1 = "0"
    L2 = cfg
    L2 = L2.virtual_proto
    if L2 == "pppoe" then
      if A0 == "pppoe-wan" then
        L1 = "14"
      else
        L2 = string
        L2 = L2.find
        L3 = A0
        L4 = "eth"
        L2 = L2(L3, L4)
        if L2 then
          L1 = "22"
        else
          L2 = QOS_VER
          if L2 == "STD" then
            L1 = "22"
          else
            L1 = "14"
          end
        end
      end
    else
      L1 = "14"
    end
    L2 = "stab linklayer ethernet mpu 0 overhead "
    L3 = L1
    L2 = L2 .. L3
    return L2
  else
    L1 = " "
    return L1
  end
end
get_stab_string = L13
function L13(A0)
  local L1, L2, L3, L4
  L1 = run_cmd
  L2 = "uci -q get network."
  L3 = A0
  L4 = ".ifname"
  L2 = L2 .. L3 .. L4
  L1 = L1(L2)
  return L1
end
function L14()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = ""
  L1 = {}
  L2 = "br-lan"
  L1[1] = L2
  L2 = {}
  L3 = QOS_VER
  if L3 ~= "NOIFB" then
    L3 = table
    L3 = L3.insert
    L4 = L1
    L5 = "ifb0"
    L3(L4, L5)
  end
  L3 = run_cmd
  L4 = "uci -q get network.guest"
  L3 = L3(L4)
  if L3 then
    L4 = table
    L4 = L4.insert
    L5 = L1
    L4(L5, L6)
  end
  L4 = _UPVALUE0_
  L5 = "wan"
  L4 = L4(L5)
  if L4 then
    L5 = table
    L5 = L5.insert
    L5(L6, L7)
  end
  L5 = _UPVALUE0_
  L5 = L5(L6)
  if L5 then
    L6(L7, L8)
  end
  for L9, L10 in L6, L7, L8 do
    L11 = string
    L11 = L11.format
    L12 = "%s del dev %s root "
    L13 = const_tc_qdisc
    L14 = L10
    L11 = L11(L12, L13, L14)
    L0 = L11
    L11 = table
    L11 = L11.insert
    L12 = L2
    L13 = L0
    L11(L12, L13)
  end
  if not L6 then
    L6(L7, L8)
  end
end
function L15()
  local L0, L1, L2, L3
  L0 = QOS_VER
  if L0 ~= "FIX" then
    L0 = QOS_VER
    if L0 ~= "NOIFB" then
      L0 = cfg
      L0 = L0.qdisc
      L0 = L0.cur
      if L0 then
        L0 = qdisc
        L1 = cfg
        L1 = L1.qdisc
        L1 = L1.cur
        L0 = L0[L1]
        if L0 then
          L0 = qdisc
          L1 = cfg
          L1 = L1.qdisc
          L1 = L1.cur
          L0 = L0[L1]
          L0 = L0.clean
          if L0 then
            L0 = logger
            L1 = 3
            L2 = "======= Cleanup QoS rules for "
            L3 = cfg
            L3 = L3.qdisc
            L3 = L3.cur
            L2 = L2 .. L3
            L0(L1, L2)
            L0 = qdisc
            L1 = cfg
            L1 = L1.qdisc
            L1 = L1.cur
            L0 = L0[L1]
            L0 = L0.clean
            L1 = cfg
            L1 = L1.DEVS
            L0(L1)
            L0 = cfg
            L0 = L0.qdisc
            L0.cur = nil
            L0 = cfg
            L0 = L0.qdisc
            L0.old = nil
        end
      end
    end
  end
  else
    L0 = QOS_VER
    if L0 == "HWQOS" then
      L0 = logger
      L1 = 3
      L2 = "======= Cleanup  HWQOS rules for "
      L0(L1, L2)
      L0 = qdisc
      L0 = L0.service
      L0 = L0.clean
      L1 = nil
      L0(L1)
    else
      L0 = logger
      L1 = 3
      L2 = "======= Cleanup  default "
      L0(L1, L2)
      L0 = _UPVALUE0_
      L0()
    end
  end
  L0 = true
  return L0
end
cleanup_system = L15
function L15(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = cfg
  L1 = L1.qdisc
  L1 = L1.old
  L2 = cfg
  L2 = L2.qdisc
  L2 = L2.cur
  cur_qdisc = L2
  old_qdisc = L1
  L1 = "NULL"
  L2 = "NULL"
  L3 = "NULL"
  L4 = "NULL"
  L5 = old_qdisc
  if L5 ~= nil then
    L5 = string
    L5 = L5.format
    L6 = "old_qdisc: %s  "
    L7 = old_qdisc
    L5 = L5(L6, L7)
    L1 = L5
  else
    L5 = string
    L5 = L5.format
    L6 = "old_qdisc: %s  "
    L7 = "nil"
    L5 = L5(L6, L7)
    L1 = L5
  end
  L5 = cur_qdisc
  if L5 ~= nil then
    L5 = string
    L5 = L5.format
    L6 = "cur_qdisc: %s  "
    L7 = cur_qdisc
    L5 = L5(L6, L7)
    L2 = L5
  else
    L5 = string
    L5 = L5.format
    L6 = "cur_qdisc: %s  "
    L7 = "nil"
    L5 = L5(L6, L7)
    L2 = L5
  end
  L5 = cfg
  L5 = L5.qdisc
  L5 = L5.old
  if L5 ~= nil then
    L5 = string
    L5 = L5.format
    L6 = "cfg.qdisc.old: %s  "
    L7 = cfg
    L7 = L7.qdisc
    L7 = L7.old
    L5 = L5(L6, L7)
    L3 = L5
  else
    L5 = string
    L5 = L5.format
    L6 = "cfg.qdisc.old: %s  "
    L7 = "nil"
    L5 = L5(L6, L7)
    L3 = L5
  end
  L5 = cfg
  L5 = L5.qdisc
  L5 = L5.cur
  if L5 ~= nil then
    L5 = string
    L5 = L5.format
    L6 = "cfg.qdisc.cur: %s  "
    L7 = cfg
    L7 = L7.qdisc
    L7 = L7.cur
    L5 = L5(L6, L7)
    L4 = L5
  else
    L5 = string
    L5 = L5.format
    L6 = "cfg.qdisc.cur: %s  "
    L7 = "nil"
    L5 = L5(L6, L7)
    L4 = L5
  end
  L5 = logger
  L6 = 3
  L7 = "================="
  L8 = A0
  L9 = L1
  L10 = L2
  L11 = L3
  L12 = L4
  L7 = L7 .. L8 .. L9 .. L10 .. L11 .. L12
  L5(L6, L7)
end
dump_cur_old_qdisc = L15
