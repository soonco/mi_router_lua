local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
L0 = require
L1 = "json"
L0 = L0(L1)
L1 = require
L2 = "miqos.common"
L1(L2)
L1 = {}
function L2(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.commit
  L3 = "miqos"
  L1(L2, L3)
  L1 = tmp2cfg
  L1 = L1()
  if not L1 then
    L1 = logger
    L2 = 1
    L3 = "copy tmp cfg to /etc/config/ failed."
    L1(L2, L3)
  end
end
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = get_cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "miqos"
  L5 = "settings"
  L6 = "enabled"
  L2 = L2(L3, L4, L5, L6)
  if A0 then
    if L2 == "1" then
      return
    end
    L4 = L1
    L3 = L1.set
    L5 = "miqos"
    L6 = "settings"
    L7 = "enabled"
    L8 = "1"
    L3(L4, L5, L6, L7, L8)
    L3 = logger
    L4 = 3
    L5 = "update_qos_enabled enable miqos."
    L3(L4, L5)
  else
    if L2 == "0" then
      return
    end
    L4 = L1
    L3 = L1.set
    L5 = "miqos"
    L6 = "settings"
    L7 = "enabled"
    L8 = "0"
    L3(L4, L5, L6, L7, L8)
    L3 = logger
    L4 = 3
    L5 = "update_qos_enabled disable miqos."
    L3(L4, L5)
  end
  L3 = _UPVALUE0_
  L4 = L1
  L3(L4)
end
function L4(A0)
  local L1, L2, L3
  if A0 == 1 then
    L1 = logger
    L2 = 3
    L3 = "enable dev_redirect caused by qos on."
    L1(L2, L3)
    L1 = os
    L1 = L1.execute
    L2 = "[ -f /proc/sys/net/dev_redirect_enable ] && echo 1 > /proc/sys/net/dev_redirect_enable"
    L1(L2)
  else
    L1 = logger
    L2 = 3
    L3 = "disable dev_redirect caused by qos off."
    L1(L2, L3)
    L1 = os
    L1 = L1.execute
    L2 = "[ -f /proc/sys/net/dev_redirect_enable ] && echo 0 > /proc/sys/net/dev_redirect_enable"
    L1(L2)
  end
end
function L5()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L1 = true
  L0(L1)
  L0 = cfg
  L0 = L0.enabled
  L0 = L0.started
  if not L0 then
    L0 = cfg
    L0 = L0.enabled
    L0.changed = true
  end
  L0 = cfg
  L0 = L0.enabled
  L0.started = true
  L0 = read_network_conf
  L0 = L0()
  if not L0 then
    L0 = logger
    L1 = 3
    L2 = "failed to read network config when `qos on`!"
    L0(L1, L2)
  end
  L0 = _UPVALUE1_
  L1 = 1
  L0(L1)
  L0 = {}
  L0.status = 0
  L0.data = "ok"
  L1 = true
  return L0, L1
end
L1.on = L5
function L5()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L1 = false
  L0(L1)
  L0 = cfg
  L0 = L0.enabled
  L0.started = true
  L0 = read_network_conf
  L0 = L0()
  if not L0 then
    L0 = logger
    L1 = 3
    L2 = "failed to read network config when `qos off`!"
    L0(L1, L2)
  end
  L0 = _UPVALUE1_
  L1 = 0
  L0(L1)
  L0 = {}
  L0.status = 0
  L0.data = "ok"
  L1 = true
  return L0, L1
end
L1.off = L5
function L5()
  local L0, L1, L2, L3, L4
  L0 = cleanup_system
  L0()
  L0 = logger
  L1 = 3
  L2 = "QOS_VER: "
  L3 = QOS_VER
  L4 = " shutdown!"
  L2 = L2 .. L3 .. L4
  L0(L1, L2)
  L0 = _UPVALUE0_
  L1 = 0
  L0(L1)
  L0 = cfg
  L0 = L0.enabled
  L0.started = false
  L0 = QOS_VER
  if L0 then
    L0 = QOS_VER
    if L0 ~= "FIX" then
      L0 = QOS_VER
      if L0 ~= "NOIFB" then
        goto lbl_31
      end
    end
  end
  L0 = {}
  L0.status = 0
  L0.data = "ok"
  L1 = false
  do return L0, L1 end
  goto lbl_36
  ::lbl_31::
  L0 = {}
  L0.status = 0
  L0.data = "ok"
  L1 = true
  do return L0, L1 end
  ::lbl_36::
end
L1.shutdown = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  if not (A0 and A1) or not A2 then
    L3 = logger
    L4 = 3
    L5 = "ERROR: parameter lost for cmd `nprio`"
    L3(L4, L5)
    L3 = {}
    L3.status = 1
    L3.data = "unkown error."
    L4 = false
    return L3, L4
  end
  L3 = g_debug
  if L3 then
    L3 = logger
    L4 = 3
    L5 = "nprio "
    L6 = A0
    L7 = ","
    L8 = A1
    L9 = ","
    L10 = A2
    L5 = L5 .. L6 .. L7 .. L8 .. L9 .. L10
    L3(L4, L5)
  end
  if A0 == "add" then
    L3 = special_host_list
    L3 = L3.host
    L3 = L3[A1]
    if L3 then
      L3 = special_host_list
      L3 = L3.host
      L3 = L3[A1]
      if A2 == L3 then
        goto lbl_52
      end
    end
    L3 = special_host_list
    L3 = L3.host
    L3[A1] = A2
    L3 = special_host_list
    L3.changed = true
    L3 = {}
    L3.status = 0
    L3.data = "ok"
    L4 = false
    do return L3, L4 end
    goto lbl_87
    ::lbl_52::
    L3 = {}
    L3.status = 0
    L3.data = "already in list."
    L4 = false
    return L3, L4
  elseif A0 == "del" then
    L3 = special_host_list
    L3 = L3.host
    L3 = L3[A1]
    if L3 then
      L3 = special_host_list
      L3 = L3.host
      L3[A1] = nil
      L3 = special_host_list
      L3.changed = true
      L3 = {}
      L3.status = 0
      L3.data = "ok"
      L4 = false
      return L3, L4
    else
      L3 = {}
      L3.status = 0
      L3.data = "not exist in list."
      L4 = false
      return L3, L4
    end
  else
    L3 = {}
    L3.status = 1
    L3.data = "not supported action for cmd `nprio`."
    L4 = false
    return L3, L4
  end
  ::lbl_87::
end
L1.nprio = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  if not (A0 and A1) or not A2 then
    L3 = logger
    L4 = 3
    L5 = "ERROR: parameter lost for cmd `reserve`"
    L3(L4, L5)
    L3 = {}
    L3.status = 1
    L3.data = "unkown error."
    L4 = false
    return L3, L4
  end
  L3 = g_debug
  if L3 then
    L3 = logger
    L4 = 3
    L5 = "update_reserved_hosts, act:"
    L6 = A0
    L7 = ", ip:"
    L8 = A1
    L9 = ", type:"
    L10 = A2
    L5 = L5 .. L6 .. L7 .. L8 .. L9 .. L10
    L3(L4, L5)
  end
  if A0 == "add" then
    L3 = band_reserve_hosts
    L3 = L3[A2]
    if not L3 then
      L3 = band_reserve_hosts
      L4 = {}
      L3[A2] = L4
    end
    L3 = band_reserve_hosts
    L3 = L3[A2]
    if L3 then
      L3 = band_reserve_hosts
      L3 = L3[A2]
      L3 = L3[A1]
      if L3 then
        L3 = {}
        L3.status = 0
        L3.data = "already reserved."
        L4 = false
        return L3, L4
      end
    end
    L3 = band_reserve_hosts
    L3 = L3[A2]
    L3[A1] = A2
  elseif A0 == "del" then
    L3 = band_reserve_hosts
    L3 = L3[A2]
    if L3 then
      L3 = band_reserve_hosts
      L3 = L3[A2]
      L3 = L3[A1]
      if L3 then
        L3 = band_reserve_hosts
        L3 = L3[A2]
        L3[A1] = nil
    end
    else
      L3 = {}
      L3.status = 0
      L3.data = "already delted."
      L4 = false
      return L3, L4
    end
  else
    L3 = logger
    L4 = 3
    L5 = "do not support act: "
    L6 = A0
    L5 = L5 .. L6
    L3(L4, L5)
    L3 = {}
    L3.status = 1
    L3.data = "not supported."
    L4 = false
    return L3, L4
  end
  L3 = band_reserve_hosts
  L3.changed = true
  L3 = {}
  L3.status = 0
  L3.data = "ok"
  L4 = false
  return L3, L4
end
L1.reserve = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = tonumber
  L3 = A0
  L2 = L2(L3)
  if 0 <= L2 then
    L2 = tonumber
    L3 = A1
    L2 = L2(L3)
    if 0 <= L2 then
      L2 = get_cursor
      L2 = L2()
      L4 = L2
      L3 = L2.get
      L5 = "miqos"
      L6 = "settings"
      L7 = "upload"
      L3 = L3(L4, L5, L6, L7)
      L5 = L2
      L4 = L2.get
      L6 = "miqos"
      L7 = "settings"
      L8 = "download"
      L4 = L4(L5, L6, L7, L8)
      if L3 == A0 and L4 == A1 then
        L5 = true
        return L5
      end
      L6 = L2
      L5 = L2.set
      L7 = "miqos"
      L8 = "settings"
      L9 = "upload"
      L10 = A0
      L5(L6, L7, L8, L9, L10)
      L6 = L2
      L5 = L2.set
      L7 = "miqos"
      L8 = "settings"
      L9 = "download"
      L10 = A1
      L5(L6, L7, L8, L9, L10)
      L5 = _UPVALUE0_
      L6 = L2
      L5(L6)
      L5 = true
      return L5
    end
  end
  L2 = false
  return L2
end
update_bw = L5
function L5(A0, A1)
  local L2, L3, L4
  L2 = tonumber
  L3 = cfg
  L3 = L3.bands
  L3 = L3.UP
  L2 = L2(L3)
  if not (L2 <= 0) then
    L2 = tonumber
    L3 = cfg
    L3 = L3.bands
    L3 = L3.DOWN
    L2 = L2(L3)
    if not (L2 <= 0) then
      goto lbl_31
    end
  end
  L2 = tonumber
  L3 = A0
  L2 = L2(L3)
  if 0 < L2 then
    L2 = tonumber
    L3 = A1
    L2 = L2(L3)
    if 0 < L2 then
      L2 = logger
      L3 = 3
      L4 = "bands from zero to non zero, do cleanup_system"
      L2(L3, L4)
      L2 = cleanup_system
      L2()
    end
  end
  ::lbl_31::
  if A0 and A1 then
    L2 = update_bw
    L3 = A0
    L4 = A1
    L2 = L2(L3, L4)
    if L2 then
      L2 = {}
      L2.status = 0
      L2.data = "ok"
      L3 = true
      return L2, L3
    end
  end
  L2 = {}
  L2.status = 1
  L2.data = "update bandwidth failed."
  L3 = false
  return L2, L3
end
L1.change_band = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = get_cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "miqos"
  L4 = "settings"
  L5 = "upload"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L3 = L0
  L2 = L0.get
  L4 = "miqos"
  L5 = "settings"
  L6 = "download"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = L1
  L4 = L2
  return L3, L4
end
function L6()
  local L0, L1, L2
  L0 = {}
  L1 = _UPVALUE0_
  L1, L2 = L1()
  L0.downlink = L2
  L0.uplink = L1
  L1 = {}
  L1.status = 0
  L1.data = L0
  L2 = false
  return L1, L2
end
L1.show_band = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = get_cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "miqos"
  L6 = "guest"
  L7 = "up_per"
  L3 = L3(L4, L5, L6, L7)
  L5 = L2
  L4 = L2.get
  L6 = "miqos"
  L7 = "guest"
  L8 = "down_per"
  L4 = L4(L5, L6, L7, L8)
  if L3 == A0 and L4 == A1 then
    L5 = true
    return L5
  end
  L6 = L2
  L5 = L2.set
  L7 = "miqos"
  L8 = "guest"
  L9 = "up_per"
  L10 = A0
  L5(L6, L7, L8, L9, L10)
  L6 = L2
  L5 = L2.set
  L7 = "miqos"
  L8 = "guest"
  L9 = "down_per"
  L10 = A1
  L5(L6, L7, L8, L9, L10)
  L5 = _UPVALUE0_
  L6 = L2
  L5(L6)
  L5 = true
  return L5
end
function L7(A0, A1)
  local L2, L3, L4
  if A0 and A1 then
    L2 = _UPVALUE0_
    L3 = A0
    L4 = A1
    L2 = L2(L3, L4)
    if L2 then
      L2 = {}
      L2.status = 0
      L2.data = "ok"
      L3 = true
      return L2, L3
    end
  end
  L2 = {}
  L2.status = 1
  L2.data = "update guest limit failed."
  L3 = false
  return L2, L3
end
L1.on_guest = L7
function L7()
  local L0, L1
  L0 = {}
  L0.status = 0
  L1 = cfg
  L1 = L1.guest
  L0.data = L1
  L1 = false
  return L0, L1
end
L1.show_guest = L7
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = get_cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "miqos"
  L6 = "xq"
  L7 = "up_per"
  L3 = L3(L4, L5, L6, L7)
  L5 = L2
  L4 = L2.get
  L6 = "miqos"
  L7 = "xq"
  L8 = "down_per"
  L4 = L4(L5, L6, L7, L8)
  if L3 == A0 and L4 == A1 then
    L5 = true
    return L5
  end
  L6 = L2
  L5 = L2.set
  L7 = "miqos"
  L8 = "xq"
  L9 = "up_per"
  L10 = A0
  L5(L6, L7, L8, L9, L10)
  L6 = L2
  L5 = L2.set
  L7 = "miqos"
  L8 = "xq"
  L9 = "down_per"
  L10 = A1
  L5(L6, L7, L8, L9, L10)
  L5 = _UPVALUE0_
  L6 = L2
  L5(L6)
  L5 = true
  return L5
end
function L8(A0, A1)
  local L2, L3, L4
  if A0 and A1 then
    L2 = _UPVALUE0_
    L3 = A0
    L4 = A1
    L2 = L2(L3, L4)
    if L2 then
      L2 = {}
      L2.status = 0
      L2.data = "ok"
      L3 = true
      return L2, L3
    end
  end
  L2 = {}
  L2.status = 1
  L2.data = "update xq limit failed."
  L3 = false
  return L2, L3
end
L1.on_xq = L8
function L8()
  local L0, L1
  L0 = {}
  L0.status = 0
  L1 = cfg
  L1 = L1.xq
  L0.data = L1
  L1 = false
  return L0, L1
end
L1.show_xq = L8
function L8()
  local L0, L1, L2
  L0 = QOS_VER
  if L0 ~= "FIX" then
    L0 = QOS_VER
    if L0 ~= "NOIFB" then
      goto lbl_10
    end
  end
  L0 = update_counters
  L1 = nil
  L0(L1)
  ::lbl_10::
  L0 = {}
  L0.status = 0
  L1 = g_limit
  L0.data = L1
  L1 = cfg
  L1 = L1.qos_type
  L1 = L1.mode
  L0.mode = L1
  L1 = {}
  L2 = cfg
  L2 = L2.bands
  L2 = L2.UP
  L1.upload = L2
  L2 = cfg
  L2 = L2.bands
  L2 = L2.DOWN
  L1.download = L2
  L0.arrange_bandwidth = L1
  L1 = false
  return L0, L1
end
L1.show_limit = L8
function L8()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = {}
  L1 = g_group_def
  if not L1 then
    L1 = read_qos_group_config
    L1()
  end
  L1 = {}
  L5 = "min_grp_downlink"
  L6 = "flag"
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L1[5] = L6
  for L5, L6 in L2, L3, L4 do
    if L5 ~= L7 then
      L0[L5] = L7
      for L10, L11 in L7, L8, L9 do
        L12 = L0[L5]
        L13 = L6[L11]
        L12[L11] = L13
      end
    end
  end
  return L0
end
function L9()
  local L0, L1
  L0 = {}
  L0.status = 0
  L1 = _UPVALUE0_
  L1 = L1()
  L0.data = L1
  L1 = cfg
  L1 = L1.qos_type
  L1 = L1.mode
  L0.mode = L1
  return L0
end
L1.show_cfg = L9
function L9(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L6 = string
  L6 = L6.upper
  L7 = A0
  L6 = L6(L7)
  L7 = string
  L7 = L7.gsub
  L8 = L6
  L9 = ":"
  L10 = ""
  L7 = L7(L8, L9, L10)
  L8 = get_cursor
  L8 = L8()
  L10 = L8
  L9 = L8.get_all
  L9 = L9(L10, L11)
  L10 = ""
  for L14, L15 in L11, L12, L13 do
    L16 = L15[".type"]
    if L16 == "group" then
      L16 = L15.name
      if L16 == L6 then
        L10 = L14
        break
      end
    end
  end
  if L10 == "" then
    L14 = "group"
    L15 = L7
    L10 = L11
    L14 = L10
    L15 = "name"
    L16 = L6
    L11(L12, L13, L14, L15, L16)
    L14 = L10
    L15 = "min_grp_uplink"
    L16 = "0.5"
    L11(L12, L13, L14, L15, L16)
    L14 = L10
    L15 = "min_grp_downlink"
    L16 = "0.5"
    L11(L12, L13, L14, L15, L16)
    L14 = L10
    L15 = "max_grp_uplink"
    L16 = "0"
    L11(L12, L13, L14, L15, L16)
    L14 = L10
    L15 = "max_grp_downlink"
    L16 = "0"
    L11(L12, L13, L14, L15, L16)
    L14 = L10
    L15 = "mode"
    L16 = "general"
    L11(L12, L13, L14, L15, L16)
    L14 = L10
    L15 = "mac"
    L16 = {}
    L17 = L6
    L16[1] = L17
    L11(L12, L13, L14, L15, L16)
  end
  if not A5 and A1 and A2 then
    A5 = "on"
  end
  if A5 and (A5 == "on" or A5 == "off") then
    L14 = L10
    L15 = "flag"
    L16 = A5
    L11(L12, L13, L14, L15, L16)
  end
  if A3 then
    if L11 <= 0 or 1 < L11 then
      A3 = g_default_min_updown_factor
      if L12 then
        L14 = "setting min reserve out of range, set it to default value."
        L12(L13, L14)
      end
    end
    L14 = "miqos"
    L15 = L10
    L16 = "min_grp_uplink"
    L17 = A3
    L12(L13, L14, L15, L16, L17)
  end
  if A4 then
    if L11 <= 0 or 1 < L11 then
      A4 = g_default_min_updown_factor
      if L12 then
        L14 = "setting min reserve out of range, set it to default value."
        L12(L13, L14)
      end
    end
    L14 = "miqos"
    L15 = L10
    L16 = "min_grp_downlink"
    L17 = A4
    L12(L13, L14, L15, L16, L17)
  end
  if A1 then
    if L11 < 8 then
      A1 = 0
      if L12 then
        L14 = "NOTE: setting min reserve out of range, set it to default value."
        L12(L13, L14)
      end
    end
    L14 = "miqos"
    L15 = L10
    L16 = "max_grp_uplink"
    L17 = A1
    L12(L13, L14, L15, L16, L17)
  end
  if A2 then
    if L11 < 8 then
      A2 = 0
      if L12 then
        L14 = "NOTE: setting min reserve out of range, set it to default value."
        L12(L13, L14)
      end
    end
    L14 = "miqos"
    L15 = L10
    L16 = "max_grp_downlink"
    L17 = A2
    L12(L13, L14, L15, L16, L17)
  end
  L12(L13)
end
function L10(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11
  if A0 == "max" then
    L6 = _UPVALUE0_
    L7 = A1
    L8 = A2
    L9 = A3
    L10, L11 = nil, nil
    L6(L7, L8, L9, L10, L11)
  elseif A0 == "min" then
    L6 = _UPVALUE0_
    L7 = A1
    L8, L9 = nil, nil
    L10 = A2
    L11 = A3
    L6(L7, L8, L9, L10, L11)
  elseif A0 == "both" then
    L6 = _UPVALUE0_
    L7 = A1
    L8 = A2
    L9 = A3
    L10 = A4
    L11 = A5
    L6(L7, L8, L9, L10, L11)
  else
    L6 = logger
    L7 = 3
    L8 = "not supported on_limit mode."
    L6(L7, L8)
    L6 = {}
    L6.status = 1
    L6.data = "not supported on_limit mode."
    L7 = false
    return L6, L7
  end
  L6 = cfg
  L6 = L6.group
  L6.changed = true
  L6 = {}
  L6.status = 0
  L6.data = "ok"
  L7 = true
  return L6, L7
end
L1.on_limit = L10
function L10(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11
  if A0 == "max" then
    L6 = _UPVALUE0_
    L7 = A1
    L8 = A2
    L9 = A3
    L10, L11 = nil, nil
    L6(L7, L8, L9, L10, L11)
  elseif A0 == "min" then
    L6 = _UPVALUE0_
    L7 = A1
    L8, L9 = nil, nil
    L10 = A2
    L11 = A3
    L6(L7, L8, L9, L10, L11)
  elseif A0 == "both" then
    L6 = _UPVALUE0_
    L7 = A1
    L8 = A2
    L9 = A3
    L10 = A4
    L11 = A5
    L6(L7, L8, L9, L10, L11)
  else
    L6 = logger
    L7 = 3
    L8 = "not supported on_limit mode."
    L6(L7, L8)
    L6 = {}
    L6.status = 1
    L6.data = "not supported on_limit mode."
    L7 = false
    return L6, L7
  end
  L6 = cfg
  L6 = L6.group
  L6.changed = true
  L6 = {}
  L6.status = 0
  L6.data = "ok"
  L7 = false
  return L6, L7
end
L1.set_limit = L10
function L10()
  local L0, L1
  L0 = {}
  L0.status = 0
  L0.data = "ok"
  L1 = true
  return L0, L1
end
L1.apply = L10
function L10(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = get_cursor
  L1 = L1()
  L2 = L1.get_all
  L2 = L2(L3, L4)
  if A0 then
    for L7, L8 in L4, L5, L6 do
      L9 = L8[".type"]
      if L9 == "group" then
        L9 = L8.name
        if L9 == L3 then
          L10 = L1
          L9 = L1.delete
          L11 = "miqos"
          L12 = L7
          L9(L10, L11, L12)
          break
        end
      end
    end
  else
    for L6, L7 in L3, L4, L5 do
      L8 = L7[".type"]
      if L8 == "group" then
        L8 = L7.name
        if L8 ~= "00" then
          L9 = L1
          L8 = L1.delete
          L10 = "miqos"
          L11 = L6
          L8(L9, L10, L11)
        end
      end
    end
  end
  L3(L4)
end
function L11(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = A0
  L1(L2)
  L1 = cfg
  L1 = L1.group
  L1.changed = true
  L1 = {}
  L1.status = 0
  L1.data = "ok"
  L2 = true
  return L1, L2
end
L1.off_limit = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  if not A0 and not A1 then
    L2 = {}
    L2.status = 1
    L2.data = "parameters mac or on_flag is NULL."
    L3 = false
    return L2, L3
  end
  if A1 ~= "on" and A1 ~= "off" then
    L2 = {}
    L2.status = 1
    L2.data = "parameters on_flag is not one of on/off."
    L3 = false
    return L2, L3
  end
  L2 = g_group_def
  if not L2 then
    L2 = read_qos_group_config
    L2()
  end
  L2 = g_group_def
  L2 = L2[A0]
  if L2 then
    L2 = g_group_def
    L2 = L2[A0]
    L2 = L2.flag
    if L2 then
      L2 = g_group_def
      L2 = L2[A0]
      L2 = L2.flag
      if L2 == A1 then
        L2 = {}
        L2.status = 0
        L2.data = "parameters on_flag with same value."
        L3 = false
        return L2, L3
    end
    else
      L2 = _UPVALUE0_
      L3 = A0
      L4, L5, L6, L7 = nil, nil, nil, nil
      L8 = A1
      L2(L3, L4, L5, L6, L7, L8)
    end
  else
    L2 = _UPVALUE0_
    L3 = A0
    L4, L5, L6, L7 = nil, nil, nil, nil
    L8 = A1
    L2(L3, L4, L5, L6, L7, L8)
  end
  L2 = {}
  L2.status = 0
  L2.data = "ok"
  L3 = true
  return L2, L3
end
L1.limit_flag = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = get_cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "miqos"
  L5 = "settings"
  L6 = "qos_auto"
  L2 = L2(L3, L4, L5, L6)
  if L2 == A0 then
    return
  end
  L4 = L1
  L3 = L1.set
  L5 = "miqos"
  L6 = "settings"
  L7 = "qos_auto"
  L8 = A0
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE0_
  L4 = L1
  L3(L4)
end
function L12(A0)
  local L1, L2, L3
  if A0 == "auto" then
    L1 = logger
    L2 = 3
    L3 = "----->>set to auto-limit-mode."
    L1(L2, L3)
  elseif A0 == "min" then
    L1 = logger
    L2 = 3
    L3 = "----->>set to min-limit-mode."
    L1(L2, L3)
  elseif A0 == "max" then
    L1 = logger
    L2 = 3
    L3 = "----->>set to max-limit-mode."
    L1(L2, L3)
  elseif A0 == "both" then
    L1 = logger
    L2 = 3
    L3 = "----->>set to both-limit-mode."
    L1(L2, L3)
  else
    L1 = logger
    L2 = 3
    L3 = "----->>set to service-limit-mode."
    L1(L2, L3)
    A0 = "service"
  end
  L1 = _UPVALUE0_
  L2 = A0
  L1(L2)
  L1 = {}
  L1.status = 0
  L1.data = "ok"
  L2 = true
  return L1, L2
end
L1.set_type = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = get_cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "miqos"
  L5 = "param"
  L6 = "seq_prio"
  L2 = L2(L3, L4, L5, L6)
  if L2 ~= A0 then
    L4 = L1
    L3 = L1.set
    L5 = "miqos"
    L6 = "param"
    L7 = "seq_prio"
    L8 = A0
    L3(L4, L5, L6, L7, L8)
    L3 = _UPVALUE0_
    L4 = L1
    L3(L4)
  end
  L3 = {}
  L3.status = 0
  L3.data = "ok"
  L4 = true
  return L3, L4
end
L1.set_seq = L12
function L12()
  local L0, L1, L2
  L0 = cfg
  L0 = L0.flow
  L0 = L0.seq
  if L0 == "" then
    L1 = cfg
    L1 = L1.flow
    L0 = L1.dft
  end
  L1 = {}
  L1.status = 0
  L2 = {}
  L2.seq_prio = L0
  L1.data = L2
  L2 = false
  return L1, L2
end
L1.get_seq = L12
function L12(A0)
  local L1, L2
  if A0 == "on" then
    L1 = cfg
    L1 = L1.supress_host
    L1.enabled = true
  elseif A0 == "off" then
    L1 = cfg
    L1 = L1.supress_host
    L1.enabled = false
  else
    L1 = {}
    L1.status = 1
    L1.data = "not supported supress command."
    L2 = false
    return L1, L2
  end
  L1 = cfg
  L1 = L1.supress_host
  L1.changed = true
  L1 = {}
  L1.status = 0
  L1.data = "ok"
  L2 = true
  return L1, L2
end
L1.supress_host = L12
function L12(A0)
  local L1, L2, L3, L4, L5
  L1 = false
  if A0 then
    L2 = string
    L2 = L2.upper
    L3 = A0
    L2 = L2(L3)
    if L2 == "00" then
      L1 = true
    else
      L3 = g_group_def
      if L3 then
        L3 = g_group_def
        L3 = L3[L2]
        if L3 then
          L3 = math
          L3 = L3.ceil
          L4 = g_group_def
          L4 = L4[L2]
          L4 = L4.max_grp_uplink
          L4 = L4 or L4
          L3 = L3(L4)
          L4 = math
          L4 = L4.ceil
          L5 = g_group_def
          L5 = L5[L2]
          L5 = L5.max_grp_downlink
          L5 = L5 or L5
          L4 = L4(L5)
          if 8 < L3 or 8 < L4 then
            L1 = true
          end
        end
      end
    end
  end
  return L1
end
function L13(A0)
  local L1, L2, L3
  L1 = {}
  L1.status = 0
  L1.data = "ok"
  L2 = _UPVALUE0_
  L3 = A0
  L2, L3 = L2(L3)
  return L1, L2, L3
end
L1.device_in = L13
function L13(A0)
  local L1, L2, L3
  L1 = {}
  L1.status = 0
  L1.data = "ok"
  L2 = _UPVALUE0_
  L3 = A0
  L2, L3 = L2(L3)
  return L1, L2, L3
end
L1.device_out = L13
function L13()
  local L0, L1
  L0 = cfg
  L0 = L0.wangzhe
  L0.changed = true
  L0 = cfg
  L0 = L0.wangzhe
  L0.modeon = true
  L0 = cfg
  L0 = L0.wangzhe
  L0.cleanflag = true
  L0 = {}
  L0.status = 0
  L0.data = "ok"
  L1 = true
  return L0, L1
end
L1.game_mode_on = L13
function L13()
  local L0, L1
  L0 = cfg
  L0 = L0.wangzhe
  L0.modeon = false
  L0 = cfg
  L0 = L0.wangzhe
  L0.cleanother = true
  L0 = cfg
  L0 = L0.enabled
  L0.changed = true
  L0 = {}
  L0.status = 0
  L0.data = "ok"
  L1 = true
  return L0, L1
end
L1.game_mode_off = L13
function L13()
  local L0, L1
  L0 = cfg
  L0 = L0.wangzhe
  L0.plugon = true
  L0 = {}
  L0.status = 0
  L0.data = "ok"
  L1 = true
  return L0, L1
end
L1.wangzhe_plug_on = L13
function L13()
  local L0, L1
  L0 = cfg
  L0 = L0.wangzhe
  L0.plugon = false
  L0 = {}
  L0.status = 0
  L0.data = "ok"
  L1 = true
  return L0, L1
end
L1.wangzhe_plug_off = L13
function L13(A0)
  local L1, L2
  L1 = cfg
  L1 = L1.wangzhe
  L1 = L1.iplist
  L2 = {}
  L2.devip = A0
  L1[A0] = L2
  L1 = cfg
  L1 = L1.wangzhe
  L1.changed = true
  L1 = {}
  L1.status = 0
  L1.data = "ok"
  L2 = true
  return L1, L2
end
L1.game_dev_add = L13
function L13(A0)
  local L1, L2
  L1 = cfg
  L1 = L1.wangzhe
  L1 = L1.iplist
  L1 = L1[A0]
  if L1 then
    L1 = cfg
    L1 = L1.wangzhe
    L1 = L1.iplist
    L1 = L1[A0]
    L1.devip = nil
    L1 = cfg
    L1 = L1.wangzhe
    L1 = L1.iplist
    L1[A0] = nil
  end
  L1 = cfg
  L1 = L1.wangzhe
  L1.changed = true
  L1 = {}
  L1.status = 0
  L1.data = "ok"
  L2 = true
  return L1, L2
end
L1.game_dev_del = L13
function L13(A0, A1)
  local L2, L3, L4
  L2 = cfg
  L2 = L2.wangzhe
  L2 = L2.devbands
  L3 = tonumber
  L4 = A0
  L3 = L3(L4)
  L2.UP = L3
  L2 = cfg
  L2 = L2.wangzhe
  L2 = L2.devbands
  L3 = tonumber
  L4 = A1
  L3 = L3(L4)
  L2.DOWN = L3
  L2 = cfg
  L2 = L2.wangzhe
  L2.bandchanged = true
  L2 = {}
  L2.status = 0
  L2.data = "ok"
  L3 = true
  return L2, L3
end
L1.game_dev_band = L13
function L13(A0, A1)
  local L2, L3, L4
  L2 = cfg
  L2 = L2.wangzhe
  L2 = L2.bands
  L3 = tonumber
  L4 = A0
  L3 = L3(L4)
  L2.UP = L3
  L2 = cfg
  L2 = L2.wangzhe
  L2 = L2.bands
  L3 = tonumber
  L4 = A1
  L3 = L3(L4)
  L2.DOWN = L3
  L2 = cfg
  L2 = L2.wangzhe
  L2.bandchanged = true
  L2 = {}
  L2.status = 0
  L2.data = "ok"
  L3 = true
  return L2, L3
end
L1.game_mode_band = L13
function L13()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = {}
  L1 = ""
  L2 = ""
  L3 = ""
  for L7, L8 in L4, L5, L6 do
    L9 = {}
    L10 = L8.devip
    L9.IP = L10
    L0[L7] = L9
  end
  if L4 then
    L2 = "True"
  else
    L2 = "False"
  end
  if L4 then
    L3 = "True"
  else
    L3 = "False"
  end
  if L4 then
    L1 = "True"
  else
    L1 = "False"
  end
  L4.modeon = L2
  L4.changed = L1
  L4.devs = L0
  L4.plugon = L3
  L5.upload = L6
  L5.download = L6
  L4.total_bands = L5
  L5.upload = L6
  L5.download = L6
  L4.dev_bands = L5
  return L4, L5
end
L1.show_game_state = L13
function L13()
  local L0, L1, L2
  L0 = {}
  L1 = cfg
  L1 = L1.wangzhe
  L1 = L1.plugon
  if L1 then
    L0.switch = 1
  else
    L0.switch = 0
  end
  L1 = {}
  L1.status = 0
  L1.data = L0
  L2 = false
  return L1, L2
end
L1.show_wangzhe = L13
function L13(A0, ...)
  local L2, L3, L4, L5, L6
  if A0 then
    L2 = _UPVALUE0_
    L2 = L2[A0]
    if L2 then
      goto lbl_26
    end
  end
  if A0 then
    L2 = logger
    L3 = 3
    L4 = "cmd `"
    L5 = A0
    L6 = "` is not defined."
    L4 = L4 .. L5 .. L6
    L2(L3, L4)
  else
    L2 = logger
    L3 = 3
    L4 = "cmd is NULL. r u sure?"
    L2(L3, L4)
  end
  L2 = {}
  L2.status = 1
  L2.data = "cmd is not defined."
  do return L2 end
  goto lbl_33
  ::lbl_26::
  L2 = _UPVALUE0_
  L2 = L2[A0]
  L3 = unpack
  L4 = arg
  L3, L4, L5, L6 = L3(L4)
  do return L2(L3, L4, L5, L6) end
  ::lbl_33::
end
process_cmd = L13
