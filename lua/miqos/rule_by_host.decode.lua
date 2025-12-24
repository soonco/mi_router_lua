local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
L0 = require
L1 = "miqos.common"
L0(L1)
L0 = "host"
L1 = {}
L2 = qdisc
L2[L0] = L1
L2 = require
L3 = "luci.ip"
L2 = L2(L3)
L3 = " tc -d class show dev %s |grep \"level 5\" "
L4 = {}
L4.rate_score = 0.5
L4.ceil_score = 1
L4.htb_buffer_factor = 1.5
L5 = {}
L5.ack = false
L5.syn = true
L5.fin = true
L5.rst = true
L5.icmp = true
L5.small = false
L4.qos = L5
L5 = {}
L5.wl = 5
L5.wi = 300
L4.online_timeout = L5
L5 = {}
L5.UP = 0.85
L5.DOWN = 0.85
L6 = {}
L6.dft = 16384
L6.quan_v = 1500
L7 = {}
L7.id = 4096
L7.quan = 8
L7.fwmark = "0x00010000/0x000f0000"
L7.fprio = "4"
L6.root = L7
L7 = {}
L8 = {}
L8.id = 8192
L8.prio = "1"
L8.quan = 4
L8.fwmark = "0x00020000/0x000f0000"
L8.fprio = "4"
L8.rate = 0.35
L8.ceil = 0.8
L8.highest_prio = "1"
L9 = {}
L9.id = 12288
L9.prio = "4"
L9.quan = 4
L9.fwmark = ""
L9.fprio = ""
L9.rate = 0.6
L9.ceil = 0.98
L9.supress = 2048
L10 = {}
L10.id = 16384
L10.prio = "6"
L10.quan = 2
L10.fwmark = "0x00040000/0x000f0000"
L10.fprio = "4"
L10.rate = 0.05
L10.ceil = 0
L11 = cfg
L11 = L11.guest
L10.limit = L11
L11 = {}
L11.id = 20480
L11.prio = "7"
L11.quan = 1
L11.fwmark = "0x00050000/0x000f0000"
L11.fprio = "4"
L11.rate = 0.05
L11.ceil = 0
L11.limit = L5
L7[1] = L8
L7[2] = L9
L7[3] = L10
L7[4] = L11
L6.child = L7
L7 = {}
L8 = {}
L8.id = 1
L8.prio = 2
L8.rate = 0.15
L8.ceil = 0.6
L7[1] = L8
L8 = {}
L8.id = 2
L8.prio = 3
L8.rate = 0.4
L8.ceil = 1
L7[2] = L8
L8 = {}
L8.id = 3
L8.prio = 4
L8.rate = 0.4
L8.ceil = 1
L7[3] = L8
L8 = {}
L8.id = 4
L8.prio = 5
L8.rate = 0.05
L8.ceil = 0.95
L8.default = true
L7[4] = L8
L8 = {}
L9 = {}
L10 = {}
L11 = {}
L12 = "video"
L11[1] = L12
L12 = {}
L13 = {}
L13.band = 0
L14 = {}
L14.id = 0
L14.band = 0
L15 = {}
L15.id = 512
L15.band = 480
L16 = {}
L16.id = 2048
L16.band = 800
L17 = {}
L17.id = 5120
L17.band = 1600
L18 = {}
L18.id = 10249
L18.band = 2400
L13[1] = L14
L13[2] = L15
L13[3] = L16
L13[4] = L17
L13[5] = L18
L12.video = L13
L13 = {}
L12.other = L13
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = 0
  for L6, L7 in L3, L4, L5 do
    if L6 ~= "changed" then
      L8 = 0
      for L12, L13 in L9, L10, L11 do
        L14 = A0[L12]
        if L14 then
          L8 = L8 + 1
        end
      end
      if 0 < L8 then
        if L9 then
          L2 = L2 + L9
        end
      end
    end
  end
  if L3 then
    L6 = L2
    L3(L4, L5)
  end
  if not (L2 <= 0) then
    if not (L2 > L3) then
      goto lbl_54
    end
  end
  do return L3, L4 end
  goto lbl_57
  ::lbl_54::
  do return L3, L4 end
  ::lbl_57::
end
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = {}
  for L5, L6 in L2, L3, L4 do
    L7 = string
    L7 = L7.format
    L8 = "%s del dev %s root "
    L9 = const_tc_qdisc
    L10 = L6.dev
    L7 = L7(L8, L9, L10)
    L8 = table
    L8 = L8.insert
    L9 = L1
    L10 = L7
    L8(L9, L10)
  end
  if not L2 then
    L2(L3, L4)
  end
  _UPVALUE0_ = L2
  _UPVALUE1_ = L2
  _UPVALUE2_ = L2
end
L1.clean = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24
  L1 = cfg
  L1 = L1.enabled
  L1 = L1.flag
  if L1 == "0" then
    return
  end
  L1 = UP
  L1 = A0[L1]
  L1 = L1.id
  L2 = DOWN
  L2 = A0[L2]
  L2 = L2.id
  L3 = {}
  L3[L1] = L4
  L3[L2] = L4
  for L7, L8 in L4, L5, L6 do
    L9 = L8.dev
    L10 = {}
    L14 = L9
    L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24 = L12(L13, L14)
    L14 = "*line"
    while L12 do
      L14 = string
      L14 = L14.find
      L15 = L12
      L16 = "class htb (%d+):(%w+).*rate (%w+) ceil (%w+)"
      L14, L15, L16, L17, L18, L19 = L14(L15, L16)
      if L14 then
        L20 = L3[L16]
        L20 = L20[L17]
        if not L20 then
          L20 = L3[L16]
          L21 = {}
          L20[L17] = L21
        end
        L20 = L3[L16]
        L20 = L20[L17]
        L20.r = L18
        L20 = L3[L16]
        L20 = L20[L17]
        L20.c = L19
      end
      L21 = L11
      L20 = L11.read
      L22 = "*line"
      L20 = L20(L21, L22)
    end
    L15 = L11
    L14 = L11.close
    L14(L15)
  end
  L7 = 0
  L8 = 0
  L9 = nil
  L10 = _UPVALUE1_
  L10 = L10.child
  L10 = L10[2]
  L10 = L10.id
  for L14, L15 in L11, L12, L13 do
    L16 = dec2hexstr
    L17 = L15.id
    L17 = L17 * 16
    L17 = L10 + L17
    L16 = L16(L17)
    L9 = L16
    L16 = L3[L1]
    L16 = L16[L9]
    if L16 then
      L16 = L3[L1]
      L16 = L16[L9]
      L16 = L3[L1]
      L16 = L16[L9]
      L7 = L16.r
    end
    L16 = L3[L2]
    L16 = L16[L9]
    if L16 then
      L16 = L3[L2]
      L16 = L16[L9]
      L16 = L3[L2]
      L16 = L16[L9]
      L8 = L16.r
    end
    L16, L17 = nil, nil
    L18 = L15.mac
    L19 = "on"
    if L18 then
      L20 = g_group_def
      L20 = L20[L18]
      if L20 then
        L20 = tonumber
        L21 = g_group_def
        L21 = L21[L18]
        L21 = L21.max_grp_uplink
        L20 = L20(L21)
        L21 = tonumber
        L22 = g_group_def
        L22 = L22[L18]
        L22 = L22.max_grp_downlink
        L21 = L21(L22)
        if L20 < 1 then
          L22 = math
          L22 = L22.ceil
          L23 = cfg
          L23 = L23.bands
          L23 = L23.UP
          L23 = L23 * L20
          L22 = L22(L23)
          L20 = L22
        elseif L20 == 1 then
          L20 = 0
        end
        if L21 < 1 then
          L22 = math
          L22 = L22.ceil
          L23 = cfg
          L23 = L23.bands
          L23 = L23.DOWN
          L23 = L23 * L21
          L22 = L22(L23)
          L21 = L22
        elseif L21 == 1 then
          L21 = 0
        end
        L22 = {}
        L22.max_per = L20
        L23 = g_group_def
        L23 = L23[L18]
        L23 = L23.min_grp_uplink
        L22.min_per = L23
        L23 = math
        L23 = L23.ceil
        L24 = g_group_def
        L24 = L24[L18]
        L24 = L24.max_grp_uplink
        L23 = L23(L24)
        L22.max_cfg = L23
        L22.max = L5
        L23 = math
        L23 = L23.ceil
        L24 = g_group_def
        L24 = L24[L18]
        L24 = L24.min_grp_uplink
        L23 = L23(L24)
        L22.min_cfg = L23
        L22.min = L7
        L16 = L22
        L22 = {}
        L22.max_per = L21
        L23 = g_group_def
        L23 = L23[L18]
        L23 = L23.min_grp_downlink
        L22.min_per = L23
        L23 = math
        L23 = L23.ceil
        L24 = g_group_def
        L24 = L24[L18]
        L24 = L24.max_grp_downlink
        L23 = L23(L24)
        L22.max_cfg = L23
        L22.max = L6
        L23 = math
        L23 = L23.ceil
        L24 = g_group_def
        L24 = L24[L18]
        L24 = L24.min_grp_downlink
        L23 = L23(L24)
        L22.min_cfg = L23
        L22.min = L8
        L17 = L22
        L22 = g_group_def
        L22 = L22[L18]
        L22 = L22.flag
        L19 = L22 or L19
        if not L22 then
          L19 = "on"
        end
    end
    else
      L20 = {}
      L20.max_per = 0
      L20.min_per = 0.5
      L20.max_cfg = 0
      L20.max = L5
      L20.min_cfg = 0
      L20.min = L7
      L16 = L20
      L20 = {}
      L20.max_per = 0
      L20.min_per = 0.5
      L20.max_cfg = 0
      L20.max = L6
      L20.min_cfg = 0
      L20.min = L8
      L17 = L20
    end
    L20 = {}
    L20.MAC = L18
    L20.UP = L16
    L20.DOWN = L17
    L20.flag = L19
    L4[L14] = L20
  end
  return L4
end
L1.update_counters = L14
function L14(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  if A0 == nil or A1 == nil or A2 == nil then
    L3 = false
    return L3
  end
  L3 = _UPVALUE0_
  L3 = L3.IPv4
  L4 = A0
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.IPv4
  L5 = A1
  L4 = L4(L5)
  if L3 and L4 then
    L5 = _UPVALUE0_
    L5 = L5.cidr
    L5 = L5.network
    L6 = L3
    L7 = A2
    L5 = L5(L6, L7)
    L6 = _UPVALUE0_
    L6 = L6.cidr
    L6 = L6.network
    L7 = L4
    L8 = A2
    L6 = L6(L7, L8)
    if L5 and L6 then
      L7 = _UPVALUE0_
      L7 = L7.cidr
      L7 = L7.equal
      L8 = L5
      L9 = L6
      L7 = L7(L8, L9)
      return L7
    end
  end
  L5 = false
  return L5
end
function L15(A0)
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
function L16()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = g_ubus
  L0 = L0.call
  L4 = {}
  L0 = L0(L1, L2, L3, L4)
  if not L0 then
  end
  for L4, L5 in L1, L2, L3 do
    L6 = L5.hw
    L7 = "0"
    if L8 ~= "wl0" then
      if L8 ~= "wl1" then
        goto lbl_23
      end
    end
    L7 = "1"
    goto lbl_32
    ::lbl_23::
    L11 = 1
    if L8 then
      L7 = "2"
    end
    ::lbl_32::
    for L11, L12 in L8, L9, L10 do
      L13 = L12.ip
      L14 = false
      L15 = string
      L15 = L15.split
      L16 = L13
      L17 = "."
      L15 = L15(L16, L17)
      L15 = L15[4]
      L16 = cfg
      L16 = L16.lan
      L16 = L16.ip
      if L16 then
        L16 = cfg
        L16 = L16.lan
        L16 = L16.mask
        if L16 then
          L16 = _UPVALUE0_
          L17 = L13
          L18 = cfg
          L18 = L18.lan
          L18 = L18.ip
          L19 = tonumber
          L20 = cfg
          L20 = L20.lan
          L20 = L20.mask
          L19, L20 = L19(L20)
          L16 = L16(L17, L18, L19, L20)
          if L16 then
            if L7 == "1" then
              L17 = L5.assoc
              if L17 == 1 then
                L14 = true
              end
            elseif L7 == "0" then
              L17 = L12.ageing_timer
              L18 = _UPVALUE1_
              L18 = L18.online_timeout
              L18 = L18.wi
              if L17 <= L18 then
                L14 = true
              end
            end
          end
        end
      end
      if L14 and L15 then
        L16 = _UPVALUE2_
        L17 = {}
        L17.mac = L6
        L17.st = "S_NEW"
        L17.id = L15
        L18 = L12.ageing_timer
        L17.idle = L18
        L16[L13] = L17
        L16 = _UPVALUE3_
        L16 = L16[L6]
        if not L16 then
          L16 = _UPVALUE3_
          L17 = {}
          L16[L6] = L17
        end
        L16 = table
        L16 = L16.insert
        L17 = _UPVALUE3_
        L17 = L17[L6]
        L18 = L13
        L16(L17, L18)
      end
    end
  end
end
function L17()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = {}
  L0.UP = 0
  L0.DOWN = 0
  for L4, L5 in L1, L2, L3 do
    for L9, L10 in L6, L7, L8 do
      L11 = L4
      L12 = g_group_def
      L12 = L12[L11]
      if not L12 then
        L12 = cfg
        L12 = L12.group
        L11 = L12.default
      end
      L12 = tonumber
      L13 = g_group_def
      L13 = L13[L11]
      L13 = L13.min_grp_uplink
      L12 = L12(L13)
      L13 = tonumber
      L14 = g_group_def
      L14 = L14[L11]
      L14 = L14.min_grp_downlink
      L13 = L13(L14)
      L14 = UP
      L15 = UP
      L15 = L0[L15]
      L15 = L15 + L12
      L0[L14] = L15
      L14 = DOWN
      L15 = DOWN
      L15 = L0[L15]
      L15 = L15 + L13
      L0[L14] = L15
    end
  end
  for L4, L5 in L1, L2, L3 do
    if not L6 then
      if L4 ~= L6 then
        goto lbl_131
      end
    end
    L6.each_up_rate = L7
    L6.each_down_rate = L7
    if L6 <= 1 then
      L6.each_up_ceil = L7
    else
      L6.each_up_ceil = L7
    end
    if L6 <= 1 then
      L6.each_down_ceil = L7
    else
      L6.each_down_ceil = L7
    end
    L9 = L4
    L10 = ",[UP]min="
    L11 = g_group_def
    L11 = L11[L4]
    L11 = L11.each_up_rate
    L12 = ",max="
    L13 = g_group_def
    L13 = L13[L4]
    L13 = L13.each_up_ceil
    L14 = ";[DOWN]min="
    L15 = g_group_def
    L15 = L15[L4]
    L15 = L15.each_down_rate
    L16 = ",max="
    L17 = g_group_def
    L17 = L17[L4]
    L17 = L17.each_down_ceil
    L6(L7, L8)
    ::lbl_131::
  end
end
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = false
  _UPVALUE0_ = L1
  _UPVALUE1_ = L1
  _UPVALUE2_ = L1
  L1()
  for L4, L5 in L1, L2, L3 do
    L6 = _UPVALUE1_
    L6 = L6[L4]
    if L6 then
      L6 = _UPVALUE2_
      L6 = L6[L4]
      L6.st = "S_UPD"
      L6 = _UPVALUE1_
      L6 = L6[L4]
      L6 = L6.mac
      L7 = L5.mac
      if L6 ~= L7 then
        L0 = true
      end
      L6 = _UPVALUE1_
      L6[L4] = nil
    else
      L0 = true
    end
  end
  for L4, L5 in L1, L2, L3 do
    L6 = _UPVALUE2_
    L6 = L6[L4]
    if not L6 then
      L6 = _UPVALUE1_
      L6 = L6[L4]
      L6.st = "S_DEL"
      L0 = true
      L6 = logger
      L7 = 3
      L8 = "expired ip "
      L9 = L4
      L10 = " out triggered flush."
      L8 = L8 .. L9 .. L10
      L6(L7, L8)
    else
      L6 = logger
      L7 = 3
      L8 = "ERROR: except case; should no any non-del records in such table."
      L6(L7, L8)
    end
  end
  return L0
end
function L19()
  local L0, L1
  L0 = true
  return L0
end
L1.changed = L19
function L19()
  local L0, L1, L2, L3, L4, L5
  L0 = "0"
  L1 = ""
  L2 = cfg
  L2 = L2.group
  L2 = L2.changed
  if L2 then
    L2 = L1
    L3 = "/group"
    L1 = L2 .. L3
    L2 = cfg
    L2 = L2.group
    L2.changed = false
    L0 = "2"
  end
  L2 = cfg
  L2 = L2.qos_type
  L2 = L2.changed
  if L2 then
    L2 = L1
    L3 = "/qos type"
    L1 = L2 .. L3
    L2 = cfg
    L2 = L2.qos_type
    L2.changed = false
    L0 = "2"
  end
  L2 = band_reserve_hosts
  L2 = L2.changed
  if L2 then
    L2 = L1
    L3 = "/band-reserve-hosts"
    L1 = L2 .. L3
    L2 = band_reserve_hosts
    L2.changed = false
    L0 = "2"
  end
  L2 = special_host_list
  L2 = L2.changed
  if L2 then
    L2 = L1
    L3 = "/special host list"
    L1 = L2 .. L3
    L2 = special_host_list
    L2.changed = false
    L0 = "2"
  end
  L2 = _UPVALUE0_
  L2 = L2()
  if L2 then
    L2 = L1
    L3 = "/hosts list"
    L1 = L2 .. L3
    L0 = "2"
  end
  L2 = cfg
  L2 = L2.bands
  L2 = L2.changed
  if L2 then
    L2 = L1
    L3 = "/bandwidth"
    L1 = L2 .. L3
    L2 = cfg
    L2 = L2.bands
    L3 = flase
    L2.changed = L3
    L0 = "1"
  end
  L2 = cfg
  L2 = L2.guest
  L2 = L2.changed
  if L2 == 1 then
    L2 = L1
    L3 = "/guest"
    L1 = L2 .. L3
    L2 = cfg
    L2 = L2.guest
    L2.changed = 0
    L0 = "1"
  end
  L2 = cfg
  L2 = L2.supress_host
  L2 = L2.changed
  if L2 then
    L2 = L1
    L3 = "/supress switch"
    L1 = L2 .. L3
    L2 = cfg
    L2 = L2.supress_host
    L2.changed = false
    L0 = "1"
  end
  if L1 ~= "" then
    L2 = logger
    L3 = 3
    L4 = "CHANGE: "
    L5 = L1
    L4 = L4 .. L5
    L2(L3, L4)
  end
  if L0 ~= "0" then
    L2 = _UPVALUE1_
    L2()
  end
  return L0
end
function L20(A0, A1, A2, A3, A4, A5, A6, A7, A8, A9)
  local L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44
  L10 = _UPVALUE0_
  L10 = #L10
  L11 = ""
  L12 = get_burst
  L13 = A8
  L12, L13 = L12(L13)
  L14 = A6 * 16
  L14 = A5 + L14
  if A4 == "del" then
    L15 = string
    L15 = L15.format
    L19 = A1
    L20 = A3
    L21 = dec2hexstr
    L22 = L14
    L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44 = L21(L22)
    L15 = L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44)
    L11 = L15
    L15 = table
    L15 = L15.insert
    L15(L16, L17, L18)
  elseif A4 == "change" then
    L15 = string
    L15 = L15.format
    L19 = A1
    L20 = A3
    L21 = dec2hexstr
    L22 = A5
    L21 = L21(L22)
    L22 = A3
    L23 = dec2hexstr
    L24 = L14
    L23 = L23(L24)
    L24 = A7
    L25 = UNIT
    L26 = A8
    L27 = UNIT
    L28 = L12
    L29 = L13
    L30 = A9
    L15 = L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
    L11 = L15
    L15 = table
    L15 = L15.insert
    L15(L16, L17, L18)
  else
    L15 = string
    L15 = L15.format
    L19 = A1
    L20 = A3
    L21 = dec2hexstr
    L22 = A5
    L21 = L21(L22)
    L22 = A3
    L23 = dec2hexstr
    L24 = L14
    L23 = L23(L24)
    L24 = A7
    L25 = UNIT
    L26 = A8
    L27 = UNIT
    L28 = L12
    L29 = L13
    L30 = A9
    L15 = L15(L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30)
    L11 = L15
    L15 = table
    L15 = L15.insert
    L15(L16, L17)
  end
  L15 = 0
  for L19 = L16, L17, L18 do
    L20 = A6 * 16
    L20 = L20 + L19
    L21 = A5 + L20
    L22 = _UPVALUE0_
    L22 = L22[L19]
    if A4 == "del" then
      L23 = string
      L23 = L23.format
      L24 = "%s %s dev %s classid %s:%s "
      L25 = const_tc_class
      L26 = A4
      L27 = A1
      L28 = A3
      L29 = dec2hexstr
      L30 = L21
      L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44 = L29(L30)
      L23 = L23(L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44)
      L11 = L23
      L23 = table
      L23 = L23.insert
      L24 = A0
      L25 = 1
      L26 = L11
      L23(L24, L25, L26)
    else
      L23 = math
      L23 = L23.ceil
      L24 = L22.rate
      L24 = A7 * L24
      L23 = L23(L24)
      L24 = math
      L24 = L24.ceil
      L25 = L22.ceil
      L25 = A8 * L25
      L24 = L24(L25)
      L25 = get_burst
      L26 = L24
      L25, L26 = L25(L26)
      L27 = L22.prio
      L28 = string
      L28 = L28.format
      L29 = "%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s "
      L30 = "quantum %s burst %d cburst %d"
      L29 = L29 .. L30
      L30 = const_tc_class
      L31 = A4
      L32 = A1
      L33 = A3
      L34 = dec2hexstr
      L35 = L14
      L34 = L34(L35)
      L35 = A3
      L36 = dec2hexstr
      L37 = L21
      L36 = L36(L37)
      L37 = L23
      L38 = UNIT
      L39 = L24
      L40 = UNIT
      L41 = L27
      L42 = A9
      L43 = L25
      L44 = L26
      L28 = L28(L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44)
      L11 = L28
      if A4 == "change" then
        L28 = table
        L28 = L28.insert
        L29 = A0
        L30 = 1
        L31 = L11
        L28(L29, L30, L31)
      else
        L28 = table
        L28 = L28.insert
        L29 = A0
        L30 = L11
        L28(L29, L30)
      end
      L28 = apply_leaf_qdisc
      L29 = A0
      L30 = A1
      L31 = A3
      L32 = dec2hexstr
      L33 = L21
      L32 = L32(L33)
      L33 = L24
      L28(L29, L30, L31, L32, L33)
    end
    L23 = L22.default
    if L23 then
      L15 = L21
    end
    L23 = "5"
    L24 = string
    L24 = L24.format
    L25 = " %s %s dev %s parent %s: prio %s handle 0x%s00000/0xfff00000 fw classid %s:%s "
    L26 = const_tc_filter
    L27 = A4
    L28 = A1
    L29 = A3
    L30 = L23
    L31 = dec2hexstr
    L32 = L20
    L31 = L31(L32)
    L32 = A3
    L33 = dec2hexstr
    L34 = L21
    L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44 = L33(L34)
    L24 = L24(L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44)
    L11 = L24
    if A4 == "del" then
      L24 = table
      L24 = L24.insert
      L25 = A0
      L26 = 1
      L27 = L11
      L24(L25, L26, L27)
    elseif A4 == "change" then
    else
      L24 = table
      L24 = L24.insert
      L25 = A0
      L26 = L11
      L24(L25, L26)
    end
  end
  if L15 ~= 0 then
    L19 = const_tc_filter
    L20 = A4
    L21 = A1
    L22 = A3
    L23 = L16
    L24 = dec2hexstr
    L25 = A6
    L24 = L24(L25)
    L25 = A3
    L26 = dec2hexstr
    L27 = L15
    L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44 = L26(L27)
    L11 = L17
    if A4 == "del" then
      L19 = 1
      L20 = L11
      L17(L18, L19, L20)
    elseif A4 == "change" then
    else
      L19 = L11
      L17(L18, L19)
    end
  end
  return L16
end
function L21(A0, A1, A2, A3, A4, A5, A6, A7)
  local L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40
  L8 = ""
  L9 = "add"
  if A6 ~= "add" then
    L9 = "del"
    for L13, L14 in L10, L11, L12 do
      L15 = L14.st
      if L15 == "S_DEL" then
        L15 = logger
        L16 = 3
        L17 = "--- del MAC "
        L18 = L14.mac
        L19 = ", IP "
        L20 = L13
        L17 = L17 .. L18 .. L19 .. L20
        L15(L16, L17)
        L15 = tonumber
        L16 = L14.id
        L15 = L15(L16)
        L16 = _UPVALUE1_
        L17 = A0
        L18 = A1
        L19 = A2
        L20 = A3
        L21 = L9
        L22 = A7
        L23 = L15
        L24 = 0
        L16 = L16(L17, L18, L19, L20, L21, L22, L23, L24, L25, L26)
        if not L16 then
          L16 = logger
          L17 = 3
          L18 = "gen del host:"
          L19 = L14.id
          L20 = " failed."
          L18 = L18 .. L19 .. L20
          L16(L17, L18)
          L16 = false
          return L16
        end
      end
    end
  end
  if A2 == L10 then
    if L10 then
      A4 = A4 - L11
    end
  end
  for L13, L14 in L10, L11, L12 do
    L15 = "add"
    L16 = L14.st
    if L16 ~= "S_NEW" then
      L15 = "change"
    end
    L16 = L14.mac
    L17 = tonumber
    L18 = L14.id
    L17 = L17(L18)
    L18 = g_group_def
    L18 = L18[L16]
    if not L18 then
      L18 = g_group_def
      L19 = cfg
      L19 = L19.group
      L19 = L19.default
      L18 = L18[L19]
    end
    L19, L20, L21, L22, L23, L24 = nil, nil, nil, nil, nil, nil
    if A2 == L25 then
      L23 = A4 * L25
      L24 = L25 or L24
      if not L25 then
        L24 = 0
      end
      if L24 > L25 then
        L24 = 0
      end
      L21 = L25
    else
      L23 = A4 * L25
      L24 = L25 or L24
      if not L25 then
        L24 = 0
      end
      if L24 > L25 then
        L24 = 0
      end
      L21 = L25
    end
    if L24 <= 0 then
      L24 = A5
    end
    if L24 < 40 then
      L24 = 40
    end
    if L23 > L24 then
      L23 = L24
    end
    L20 = L26
    L19 = L25
    if L21 <= 0 then
      L21 = 1
    end
    if 10 < L21 then
      L21 = 10
    end
    L22 = L25
    if A2 == L25 then
      for L28, L29 in L25, L26, L27 do
        L30 = band_reserve_hosts
        L30 = L30[L29]
        L31 = L30[L13]
        if L31 then
          L31 = g_debug
          if L31 then
            L31 = logger
            L32 = 3
            L33 = "reserve band "
            L34 = _UPVALUE5_
            L34 = L34[L29]
            L34 = L34.band
            L35 = "kbps for "
            L36 = L13
            L33 = L33 .. L34 .. L35 .. L36
            L31(L32, L33)
          end
          L31 = _UPVALUE5_
          L31 = L31[L29]
          L31 = L31.band
          L19 = L19 + L31
          break
        end
      end
    end
    L28 = L16
    L29 = ",IP "
    L30 = L13
    L31 = ", "
    L32 = A2
    L33 = ","
    L34 = L19
    L35 = "-"
    L36 = L20
    L37 = ", id:"
    L38 = L14.id
    L39 = ",action:"
    L40 = L15
    L25(L26, L27)
    L28 = A2
    L29 = A3
    L30 = L15
    L31 = A7
    L32 = L17
    L33 = L19
    L34 = L20
    L35 = L22
    if not L25 then
      L28 = L15
      L29 = " host: "
      L30 = L14.ip
      L31 = " failed."
      L25(L26, L27)
      return L25
    end
  end
  return L10
end
L22 = {}
L23 = UP
L24 = {}
L24.id = 0
L24.ceil = 0
L22[L23] = L24
L23 = DOWN
L24 = {}
L24.id = 0
L24.ceil = 0
L22[L23] = L24
function L23(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25
  if A2 ~= "change" then
    L5 = logger
    L5(L6, L7)
    L5 = false
    return L5
  end
  L5 = ""
  for L9, L10 in L6, L7, L8 do
    L11 = L9
    L12 = L10.dev
    L13 = L10.id
    L14 = _UPVALUE0_
    L14 = L14[L9]
    L14 = L14.id
    L15 = _UPVALUE0_
    L15 = L15[L9]
    L15 = L15.rate
    L16 = _UPVALUE0_
    L16 = L16[L9]
    L16 = L16.ceil
    L17 = _UPVALUE1_
    L18 = A0
    L19 = L12
    L20 = L11
    L21 = L13
    L22 = L15
    L23 = L16
    L24 = A2
    L25 = L14
    L17 = L17(L18, L19, L20, L21, L22, L23, L24, L25)
    if not L17 then
      L17 = logger
      L18 = 3
      L19 = "gen all hosts rules failed."
      L17(L18, L19)
      L17 = false
      return L17
    end
  end
  return L6
end
function L24(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50
  L5 = ""
  for L9, L10 in L6, L7, L8 do
    L11 = L9
    L12 = L10.dev
    L13 = L10.id
    if A2 == "add" then
      L14 = string
      L14 = L14.format
      L15 = "%s %s dev %s root handle %s: %s htb default %s "
      L16 = const_tc_qdisc
      L17 = A2
      L18 = L12
      L19 = L13
      L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50 = L21(L22)
      L14 = L14(L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50)
      L5 = L14
      L14 = table
      L14 = L14.insert
      L15 = A0
      L16 = L5
      L14(L15, L16)
    end
    L14 = A3[L9]
    L15 = math
    L15 = L15.ceil
    L16 = _UPVALUE0_
    L16 = L16.quan_v
    L17 = _UPVALUE0_
    L17 = L17.root
    L17 = L17.quan
    L16 = L16 * L17
    L15 = L15(L16)
    L16 = dec2hexstr
    L17 = _UPVALUE0_
    L17 = L17.root
    L17 = L17.id
    L16 = L16(L17)
    L17 = get_burst
    L18 = tonumber
    L19 = L14
    L18, L19, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50 = L18(L19)
    L17, L18 = L17(L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50)
    L19 = string
    L19 = L19.format
    L23 = L12
    L24 = L13
    L25 = L13
    L26 = L16
    L27 = L14
    L28 = UNIT
    L29 = L15
    L30 = L17
    L31 = L18
    L19 = L19(L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31)
    L5 = L19
    L19 = table
    L19 = L19.insert
    L19(L20, L21)
    L19 = string
    L19 = L19.format
    L23 = L12
    L24 = L13
    L25 = _UPVALUE0_
    L25 = L25.root
    L25 = L25.fprio
    L26 = _UPVALUE0_
    L26 = L26.root
    L26 = L26.fwmark
    L27 = L13
    L28 = "0"
    L19 = L19(L20, L21, L22, L23, L24, L25, L26, L27, L28)
    L5 = L19
    L19 = table
    L19 = L19.insert
    L19(L20, L21)
    L19 = apply_ppp_qdisc
    L19(L20, L21, L22)
    L19 = L16
    for L23, L24 in L20, L21, L22 do
      L25 = L24
      L26 = L24.id
      L27 = L24.prio
      L28 = math
      L28 = L28.ceil
      L29 = L25.rate
      L29 = L14 * L29
      L28 = L28(L29)
      L29 = math
      L29 = L29.ceil
      L30 = L25.ceil
      L30 = L14 * L30
      L29 = L29(L30)
      L30 = L25.limit
      if L30 then
        L30 = tonumber
        L31 = L25.limit
        L31 = L31[L11]
        L30 = L30(L31)
        L29 = L30
        if L29 <= 1 then
          L30 = math
          L30 = L30.ceil
          L31 = A3[L11]
          L31 = L31 * L29
          L30 = L30(L31)
          L29 = L30
        end
      end
      L30 = get_supressed_ceil
      L31 = L29
      L32 = L24.supress
      L30 = L30(L31, L32)
      if L28 > L30 then
        L28 = L30
      end
      L31 = get_burst
      L32 = L30
      L31, L32 = L31(L32)
      L33 = math
      L33 = L33.ceil
      L34 = L24.quan
      L35 = _UPVALUE0_
      L35 = L35.quan_v
      L34 = L34 * L35
      L33 = L33(L34)
      L34 = string
      L34 = L34.format
      L35 = " %s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s "
      L36 = "prio %s quantum %s burst %d cburst %d"
      L35 = L35 .. L36
      L36 = const_tc_class
      L37 = A2
      L38 = L12
      L39 = L13
      L40 = L19
      L41 = L13
      L42 = dec2hexstr
      L43 = L26
      L42 = L42(L43)
      L43 = L28
      L44 = UNIT
      L45 = L30
      L46 = UNIT
      L47 = L27
      L48 = L33
      L49 = L31
      L50 = L32
      L34 = L34(L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50)
      L5 = L34
      L34 = table
      L34 = L34.insert
      L35 = A0
      L36 = L5
      L34(L35, L36)
      L34 = _UPVALUE1_
      L34 = L34.qos
      L34 = L34.small
      if L34 then
        L34 = L25.highest_prio
        if L34 then
          L34 = apply_arp_small_filter
          L35 = A0
          L36 = L12
          L37 = "add"
          L38 = L13
          L39 = dec2hexstr
          L40 = L26
          L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50 = L39(L40)
          L34(L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50)
        end
      end
      L34 = L25.fwmark
      if L34 then
        L34 = L25.fwmark
        if L34 ~= "" then
          if A2 == "add" then
            L34 = string
            L34 = L34.format
            L35 = " %s %s dev %s parent %s: prio %s handle %s fw classid %s:%s"
            L36 = const_tc_filter
            L37 = A2
            L38 = L12
            L39 = L13
            L40 = L25.fprio
            L41 = L25.fwmark
            L42 = L13
            L43 = dec2hexstr
            L44 = L26
            L43, L44, L45, L46, L47, L48, L49, L50 = L43(L44)
            L34 = L34(L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50)
            L5 = L34
            L34 = table
            L34 = L34.insert
            L35 = A0
            L36 = L5
            L34(L35, L36)
            L34 = apply_leaf_qdisc
            L35 = A0
            L36 = L12
            L37 = L13
            L38 = dec2hexstr
            L39 = L26
            L38 = L38(L39)
            L39 = L30
            L34(L35, L36, L37, L38, L39)
          end
      end
      else
        L34 = _UPVALUE2_
        L35 = {}
        L35.id = L26
        L35.rate = L28
        L35.ceil = L30
        L34[L9] = L35
        L34 = _UPVALUE3_
        L35 = A0
        L36 = L12
        L37 = L11
        L38 = L13
        L39 = L28
        L40 = L30
        L41 = A2
        L42 = L26
        L34 = L34(L35, L36, L37, L38, L39, L40, L41, L42)
        if not L34 then
          L34 = logger
          L35 = 3
          L36 = "gen all hosts rules failed."
          L34(L35, L36)
          L34 = false
          return L34
        end
      end
    end
  end
  return L6
end
function L25(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11
  L5 = false
  if A4 == "2" then
    L6 = _UPVALUE0_
    L7 = A0
    L8 = A1
    L9 = A2
    L10 = A3
    L11 = A4
    L6 = L6(L7, L8, L9, L10, L11)
    L5 = L6
  elseif A4 == "1" then
    L6 = _UPVALUE1_
    L7 = A0
    L8 = A1
    L9 = A2
    L10 = A3
    L11 = A4
    L6 = L6(L7, L8, L9, L10, L11)
    L5 = L6
  else
    L6 = logger
    L7 = 3
    L8 = "not supported changed-level."
    L6(L7, L8)
    L6 = false
    return L6
  end
  return L5
end
L26 = {}
L27 = {}
L27.ftprio = "2"
L27.flow = "0"
L26.HIGH_PRIO_WITHOUT_LIMIT = L27
L27 = {}
L27.ftprio = "2"
L27.flow = "2000"
L26.HIGH_PRIO_WITH_BANDLIMIT = L27
function L27(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    L8 = L6
    L9 = L7.dev
    L10 = L7.id
    for L14, L15 in L11, L12, L13 do
      L16 = string
      L16 = L16.format
      L17 = "%s del dev %s parent %s: prio %s "
      L18 = const_tc_filter
      L19 = L9
      L20 = L10
      L21 = L15.ftprio
      L16 = L16(L17, L18, L19, L20, L21)
      L17 = table
      L17 = L17.insert
      L18 = L2
      L19 = L16
      L17(L18, L19)
    end
    for L14, L15 in L11, L12, L13 do
      L16 = _UPVALUE0_
      L16 = L16[L15]
      if L16 then
        L16 = _UPVALUE0_
        L16 = L16[L15]
        L16 = L16.ftprio
        L17 = _UPVALUE0_
        L17 = L17[L15]
        L17 = L17.flow
        L18 = tonumber
        L19 = string
        L19 = L19.split
        L20 = L14
        L21 = "."
        L19 = L19(L20, L21)
        L19 = L19[4]
        L18 = L18(L19)
        L19 = "0x"
        L20 = dec2hexstr
        L21 = L18
        L20 = L20(L21)
        L21 = "000000/0xff000000"
        L18 = L19 .. L20 .. L21
        L19 = string
        L19 = L19.format
        L20 = " %s replace dev %s parent %s: prio %s handle %s fw classid %s:%s "
        L21 = const_tc_filter
        L22 = L9
        L23 = L10
        L24 = L16
        L25 = L18
        L26 = L10
        L27 = L17
        L19 = L19(L20, L21, L22, L23, L24, L25, L26, L27)
        L20 = table
        L20 = L20.insert
        L21 = A0
        L22 = L19
        L20(L21, L22)
      end
    end
  end
  L3(L4, L5)
  return L3
end
function L28()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  for L3, L4 in L0, L1, L2 do
    if L5 then
      for L8, L9 in L5, L6, L7 do
        if L8 ~= "band" then
          L10 = tonumber
          L11 = cfg
          L11 = L11.bands
          L11 = L11.DOWN
          L10 = L10(L11)
          L11 = L9.id
          if L10 > L11 then
            L10 = _UPVALUE0_
            L10 = L10[L3]
            L11 = L9.band
            L10.band = L11
          else
            break
          end
        end
      end
    end
  end
end
function L29()
  local L0, L1, L2
  L0 = cfg
  L0 = L0.bands
  L0 = L0.changed
  if L0 then
    L0 = _UPVALUE0_
    L0()
  end
  L0 = read_qos_group_config
  L0 = L0()
  if not L0 then
    L0 = logger
    L1 = 3
    L2 = "read_qos_group_config failed."
    L0(L1, L2)
    L0 = false
    return L0
  end
  L0 = read_qos_guest_xq_config
  L0 = L0()
  if not L0 then
    L0 = logger
    L1 = 3
    L2 = "read_qos_guest_xq_config failed."
    L0(L1, L2)
    L0 = false
    return L0
  end
end
L1.read_qos_config = L29
function L29(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12
  L4 = "add"
  L5 = "0"
  if not A0 then
    L6 = _UPVALUE0_
    L6 = L6()
    L5 = L6
    L5 = "1"
    L4 = "add"
  else
    L6 = qdisc
    L6 = L6[A0]
    if not L6 then
      L6 = logger
      L7 = 3
      L8 = "ERROR: qdisc `"
      L9 = A0
      L10 = "` not found. "
      L8 = L8 .. L9 .. L10
      L6(L7, L8)
      L6 = false
      return L6
    elseif A3 then
      L6 = _UPVALUE1_
      L6 = L6.clean
      L7 = A2
      L6(L7)
      L4 = "add"
    else
      L6 = _UPVALUE2_
      if A0 == L6 then
        L6 = _UPVALUE0_
        L6 = L6()
        L5 = L6
        if L5 == "0" then
          L6 = false
          return L6
        end
        L4 = "change"
      else
        L6 = _UPVALUE1_
        L6 = L6.clean
        L7 = A2
        L6(L7)
        L6 = _UPVALUE0_
        L6 = L6()
        L5 = L6
        L5 = "1"
        L4 = "add"
      end
    end
  end
  L6 = {}
  L7 = _UPVALUE3_
  L8 = L6
  L9 = A2
  L10 = L4
  L11 = A1
  L12 = L5
  L7 = L7(L8, L9, L10, L11, L12)
  if not L7 then
    L7 = logger
    L8 = 3
    L9 = "ERROR: generate host qdisc failed. "
    L7(L8, L9)
    L7 = false
    return L7
  end
  L7 = _UPVALUE4_
  L8 = L6
  L9 = A2
  L7 = L7(L8, L9)
  if not L7 then
    L7 = false
    return L7
  end
  L7 = exec_cmd
  L8 = L6
  L9 = nil
  L7 = L7(L8, L9)
  if not L7 then
    L7 = logger
    L8 = 3
    L9 = "ERROR: apply host qdisc failed."
    L7(L8, L9)
    L7 = false
    return L7
  end
  L7 = true
  return L7
end
L1.apply = L29
