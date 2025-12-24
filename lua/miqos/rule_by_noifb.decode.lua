local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24
L0 = require
L1 = "miqos.common"
L0(L1)
L0 = "noifb"
L1 = {}
L2 = qdisc
L2[L0] = L1
L2 = require
L3 = "luci.ip"
L2 = L2(L3)
L3 = {}
L4 = {}
L4.ack = false
L4.syn = true
L4.fin = true
L4.rst = true
L4.icmp = true
L4.small = false
L3.qos = L4
L4 = {}
L4.wl = 5
L4.wi = 300
L3.online_timeout = L4
L4 = {}
L4.dft = 20480
L4.quan_v = 1600
L5 = {}
L5.id = 4096
L5.quan = 2
L5.fwmark = "0x00010000/0x000f0000"
L5.fprio = "5"
L4.root = L5
L5 = {}
L6 = {}
L6.id = 8192
L6.prio = "1"
L6.quan = 2
L6.fwmark = "0x00020000/0x000f0000"
L6.fprio = "5"
L6.rate = 0.1
L6.ceil = 0.5
L7 = apply_arp_small_filter
L6.highest_prio = L7
L5.special = L6
L6 = {}
L6.id = 12288
L6.prio = "4"
L6.quan = 2
L6.fwmark = "0x00030000/0x000f0000"
L6.fprio = "5"
L6.rate = 0.7
L6.ceil = 0.98
L6.supress = 2048
L5.host = L6
L6 = {}
L6.id = 16384
L6.prio = "6"
L6.quan = 1
L6.fwmark = "0x00040000/0x000f0000"
L6.fprio = "5"
L6.rate = 0.1
L6.ceil = 0
L7 = cfg
L7 = L7.guest
L6.limit = L7
L5.guest = L6
L6 = {}
L6.id = 20480
L6.prio = "7"
L6.quan = 1
L6.fwmark = "0x00050000/0x000f0000"
L6.fprio = "5"
L6.rate = 0.05
L6.ceil = 0
L7 = cfg
L7 = L7.xq
L6.limit = L7
L5.xq = L6
L4.child = L5
L5 = {}
L6 = {}
L6.id = 1
L6.type = "game"
L6.rate = 0.1
L6.ceil = 0.6
L7 = {}
L7.fwmark = "0x00130000/0x00ff0000"
L7.fprio = "4"
L6.mark = L7
L5.game = L6
L6 = {}
L6.id = 2
L6.type = "web"
L6.rate = 0.35
L6.ceil = 1
L7 = {}
L7.fwmark = "0x00230000/0x00ff0000"
L7.fprio = "4"
L6.mark = L7
L5.web = L6
L6 = {}
L6.id = 3
L6.type = "video"
L6.rate = 0.45
L6.ceil = 1
L7 = {}
L7.fwmark = "0x00330000/0x00ff0000"
L7.fprio = "4"
L6.mark = L7
L5.video = L6
L6 = {}
L6.id = 4
L6.type = "download"
L6.rate = 0.1
L6.ceil = 0.95
L7 = {}
L7.fwmark = "0x00430000/0x00ff0000"
L7.fprio = "4"
L6.mark = L7
L6.default = true
L5.download = L6
L6 = {}
L7 = {}
L8 = {}
function L9()
  local L0, L1, L2, L3, L4, L5
  for L3, L4 in L0, L1, L2 do
    L5 = _UPVALUE0_
    L5 = L5[L3]
    L5.net = nil
    L5 = _UPVALUE0_
    L5 = L5[L3]
    L5.limit = nil
    L5 = _UPVALUE0_
    L5[L3] = nil
  end
end
function L10(A0)
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
  L2()
  L2.changed = true
end
L1.clean = L10
function L10(A0, A1, A2)
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
function L11()
  local L0, L1, L2, L3, L4, L5, L6
  for L3, L4 in L0, L1, L2 do
    L5 = L4.net
    L5 = L5.new
    if L5 == "" then
      L5 = _UPVALUE0_
      L5 = L5[L3]
      L5.net = nil
      L5 = _UPVALUE0_
      L5 = L5[L3]
      L5.limit = nil
      L5 = _UPVALUE0_
      L5[L3] = nil
    else
      L5 = L4.net
      L6 = L4.net
      L6 = L6.new
      L5.old = L6
      L5 = L4.net
      L5.new = ""
      L5 = L4.limit
      L5.changed = 0
    end
  end
end
function L12()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34
  L0 = g_ubus
  L0 = L0.call
  L4 = {}
  L0 = L0(L1, L2, L3, L4)
  _UPVALUE0_ = L1
  if not L0 then
  end
  for L4, L5 in L1, L2, L3 do
    L6 = L5.hw
    L7 = false
    L11 = 1
    if L8 then
      L7 = true
    end
    for L11, L12 in L8, L9, L10 do
      L13 = false
      if L7 then
        L14 = L5.assoc
        if L14 == 1 then
          L13 = true
      end
      elseif not L7 then
        L14 = L12.ageing_timer
        L15 = _UPVALUE1_
        L15 = L15.online_timeout
        L15 = L15.wi
        if L14 <= L15 then
          L13 = true
        end
      end
      if L13 then
        L14 = "guest"
        L15 = L12.ip
        L16 = false
        L17 = string
        L17 = L17.split
        L18 = L12.ip
        L19 = "."
        L17 = L17(L18, L19)
        L17 = L17[4]
        L18 = cfg
        L18 = L18.lan
        L18 = L18.ip
        if L18 then
          L18 = cfg
          L18 = L18.lan
          L18 = L18.mask
          if L18 then
            L18 = _UPVALUE2_
            L19 = L15
            L20 = cfg
            L20 = L20.lan
            L20 = L20.ip
            L21 = tonumber
            L22 = cfg
            L22 = L22.lan
            L22 = L22.mask
            L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34 = L21(L22)
            L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34)
            if L18 then
              L14 = "host"
            end
          end
        end
        L18 = _UPVALUE0_
        L19 = {}
        L19.mac = L6
        L20 = {}
        L19.UP = L20
        L20 = {}
        L19.DOWN = L20
        L18[L15] = L19
        L18 = 0
        L19 = 0
        L20 = g_group_def
        L20 = L20[L6]
        if L20 then
          L20 = math
          L20 = L20.ceil
          L21 = g_group_def
          L21 = L21[L6]
          L21 = L21.max_grp_uplink
          L21 = L21 or L21
          L20 = L20(L21)
          L18 = L20
          L20 = math
          L20 = L20.ceil
          L21 = g_group_def
          L21 = L21[L6]
          L21 = L21.max_grp_downlink
          L21 = L21 or L21
          L20 = L20(L21)
          L19 = L20
          L20 = _UPVALUE0_
          L20 = L20[L15]
          L21 = UP
          L20 = L20[L21]
          L20.max_per = L18
          L20 = _UPVALUE0_
          L20 = L20[L15]
          L21 = DOWN
          L20 = L20[L21]
          L20.max_per = L19
        end
        if not (L18 < 8) then
          L20 = math
          L20 = L20.ceil
          L21 = cfg
          L21 = L21.bands
          L21 = L21.UP
          L20 = L20(L21)
          if not (L18 > L20) then
            goto lbl_158
          end
        end
        if not (L19 < 8) then
          L20 = math
          L20 = L20.ceil
          L21 = cfg
          L21 = L21.bands
          L21 = L21.DOWN
          L20 = L20(L21)
          if not (L19 > L20) then
            goto lbl_158
          end
        end
        L20 = _UPVALUE3_
        L20 = L20[L15]
        if L20 then
          L20 = _UPVALUE3_
          L20 = L20[L15]
          L20 = L20.net
          L20.new = ""
          goto lbl_225
          ::lbl_158::
          if L18 < 8 then
            L20 = cfg
            L20 = L20.bands
            L18 = L20.UP
          end
          if L19 < 8 then
            L20 = cfg
            L20 = L20.bands
            L19 = L20.DOWN
          end
          L20 = _UPVALUE3_
          L20 = L20[L15]
          if not L20 then
            L20 = _UPVALUE3_
            L21 = {}
            L21.mac = L6
            L21.id = L17
            L21.ip = L15
            L22 = {}
            L22.old = ""
            L22.new = L14
            L21.net = L22
            L22 = {}
            L22.UP = L18
            L22.DOWN = L19
            L22.changed = 1
            L21.limit = L22
            L20[L15] = L21
          else
            L20 = _UPVALUE3_
            L20 = L20[L15]
            L21 = L20.net
            L21.new = L14
            L21 = L20.limit
            L21 = L21.UP
            if L21 == L18 then
              L21 = L20.limit
              L21 = L21.DOWN
              if L21 == L19 then
                goto lbl_225
              end
            end
            L21 = logger
            L22 = 3
            L23 = "limit changed, mac: "
            L24 = L6
            L25 = ",ip: "
            L26 = L15
            L27 = ",UP:"
            L28 = L20.limit
            L28 = L28.UP
            L29 = "->"
            L30 = L18
            L31 = ",DOWN:"
            L32 = L20.limit
            L32 = L32.DOWN
            L33 = "->"
            L34 = L19
            L23 = L23 .. L24 .. L25 .. L26 .. L27 .. L28 .. L29 .. L30 .. L31 .. L32 .. L33 .. L34
            L21(L22, L23)
            L21 = _UPVALUE3_
            L21 = L21[L15]
            L22 = {}
            L22.UP = L18
            L22.DOWN = L19
            L22.changed = 1
            L21.limit = L22
          end
        end
      end
      ::lbl_225::
    end
  end
end
function L13(A0, A1)
  local L2, L3
  L2 = seq_prio
  L2 = L2[A0]
  if not L2 then
    L2 = seq_prio
    L2 = L2.auto
  end
  L3 = L2[A1]
  L3 = L3 or L3
  return L3
end
function L14(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53
  L5 = _UPVALUE0_
  L5 = #L5
  L6 = ""
  L7 = A4.id
  L8 = L7 * 16
  L8 = A3 + L8
  L9 = A4.limit
  L10 = math
  L10 = L10.ceil
  L11 = L9.UP
  L10 = L10(L11)
  L11 = math
  L11 = L11.ceil
  L11 = L11(L12)
  if L10 > L11 then
    L10 = cfg
    L10 = L10.bands
    L10 = L10.UP
    L9.UP = L10
  end
  L10 = math
  L10 = L10.ceil
  L11 = L9.DOWN
  L10 = L10(L11)
  L11 = math
  L11 = L11.ceil
  L11 = L11(L12)
  if L10 > L11 then
    L10 = cfg
    L10 = L10.bands
    L10 = L10.DOWN
    L9.DOWN = L10
  end
  L10 = "*"
  if A2 == "add" then
    L10 = "+"
  elseif A2 == "del" then
    L10 = "-"
  end
  L11 = logger
  L15 = A4.ip
  L16 = ",mac:"
  L17 = A4.mac
  L18 = ", UP:"
  L19 = A4.limit
  L19 = L19.UP
  L20 = ", DOWN:"
  L21 = A4.limit
  L21 = L21.DOWN
  L11(L12, L13)
  L11 = ""
  if L12 ~= "FIX" then
    if L12 ~= "NOIFB" then
      goto lbl_71
    end
  end
  L11 = " prio 4 "
  ::lbl_71::
  for L15, L16 in L12, L13, L14 do
    L17 = L16.dev
    L18 = L16.id
    L19 = _UPVALUE1_
    L19 = L19[L15]
    L20 = math
    L20 = L20.ceil
    L21 = L9[L15]
    L20 = L20(L21)
    L21 = get_burst
    L22 = L20
    L21, L22 = L21(L22)
    L23 = _UPVALUE2_
    L23 = L23.quan_v
    L23 = L23 * 2
    if L19 > L20 then
      L19 = L20
    end
    if A2 == "del" then
      L24 = string
      L24 = L24.format
      L28 = L17
      L29 = L18
      L30 = dec2hexstr
      L31 = L8
      L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53 = L30(L31)
      L24 = L24(L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53)
      L6 = L24
      L24 = table
      L24 = L24.insert
      L24(L25, L26, L27)
    elseif A2 == "change" then
      L24 = string
      L24 = L24.format
      L28 = L17
      L29 = L18
      L30 = dec2hexstr
      L31 = A3
      L30 = L30(L31)
      L31 = L18
      L32 = dec2hexstr
      L33 = L8
      L32 = L32(L33)
      L33 = L19
      L34 = UNIT
      L35 = L20
      L36 = UNIT
      L37 = L11
      L38 = L21
      L39 = L22
      L40 = L23
      L24 = L24(L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40)
      L6 = L24
      L24 = table
      L24 = L24.insert
      L24(L25, L26, L27)
    else
      L24 = string
      L24 = L24.format
      L28 = L17
      L29 = L18
      L30 = dec2hexstr
      L31 = A3
      L30 = L30(L31)
      L31 = L18
      L32 = dec2hexstr
      L33 = L8
      L32 = L32(L33)
      L33 = L19
      L34 = UNIT
      L35 = L20
      L36 = UNIT
      L37 = L11
      L38 = L21
      L39 = L22
      L40 = L23
      L24 = L24(L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40)
      L6 = L24
      L24 = table
      L24 = L24.insert
      L24(L25, L26)
    end
    L24 = QOS_VER
    if L24 ~= "FIX" then
      L24 = QOS_VER
      if L24 ~= "NOIFB" then
        goto lbl_227
      end
    end
    L24 = apply_leaf_qdisc
    L28 = dec2hexstr
    L29 = L8
    L28 = L28(L29)
    L29 = L20
    L30 = true
    L24(L25, L26, L27, L28, L29, L30)
    L24 = "2"
    L28 = A2
    L29 = L17
    L30 = L18
    L31 = L24
    L32 = dec2hexstr
    L33 = L7
    L32 = L32(L33)
    L33 = L18
    L34 = dec2hexstr
    L35 = L8
    L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53 = L34(L35)
    L6 = L25
    if A2 == "del" then
      L28 = L6
      L25(L26, L27, L28)
    elseif A2 == "change" then
    else
      L25(L26, L27)
      goto lbl_404
      ::lbl_227::
      L24 = 0
      for L28, L29 in L25, L26, L27 do
        L30 = L7 * 16
        L31 = L29.id
        L30 = L30 + L31
        L31 = A3 + L30
        if A2 == "del" then
          L32 = string
          L32 = L32.format
          L33 = "%s %s dev %s classid %s:%s "
          L34 = const_tc_class
          L35 = A2
          L36 = L17
          L37 = L18
          L38 = dec2hexstr
          L39 = L31
          L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53 = L38(L39)
          L32 = L32(L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53)
          L6 = L32
          L32 = table
          L32 = L32.insert
          L33 = A0
          L34 = 1
          L35 = L6
          L32(L33, L34, L35)
        else
          L32 = math
          L32 = L32.ceil
          L33 = L29.rate
          L33 = L19 * L33
          L32 = L32(L33)
          L33 = math
          L33 = L33.ceil
          L34 = L29.ceil
          L34 = L20 * L34
          L33 = L33(L34)
          L34 = get_burst
          L35 = L33
          L34, L35 = L34(L35)
          L36 = _UPVALUE3_
          L37 = cfg
          L37 = L37.flow
          L37 = L37.seq
          L38 = L28
          L36 = L36(L37, L38)
          L37 = string
          L37 = L37.format
          L38 = "%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s prio %s "
          L39 = "quantum %s burst %d cburst %d "
          L38 = L38 .. L39
          L39 = const_tc_class
          L40 = A2
          L41 = L17
          L42 = L18
          L43 = dec2hexstr
          L44 = L8
          L43 = L43(L44)
          L44 = L18
          L45 = dec2hexstr
          L46 = L31
          L45 = L45(L46)
          L46 = L32
          L47 = UNIT
          L48 = L33
          L49 = UNIT
          L50 = L36
          L51 = L23
          L52 = L34
          L53 = L35
          L37 = L37(L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53)
          L6 = L37
          if A2 == "change" then
            L37 = table
            L37 = L37.insert
            L38 = A0
            L39 = 1
            L40 = L6
            L37(L38, L39, L40)
          else
            L37 = table
            L37 = L37.insert
            L38 = A0
            L39 = L6
            L37(L38, L39)
            L37 = apply_leaf_qdisc
            L38 = A0
            L39 = L17
            L40 = L18
            L41 = dec2hexstr
            L42 = L31
            L41 = L41(L42)
            L42 = L33
            L43 = true
            L37(L38, L39, L40, L41, L42, L43)
          end
        end
        L32 = "2"
        L33 = string
        L33 = L33.format
        L34 = "%s %s dev %s parent %s: prio %s handle 0x%s00000/0xfff00000 fw classid %s:%s "
        L35 = const_tc_filter
        L36 = A2
        L37 = L17
        L38 = L18
        L39 = L32
        L40 = dec2hexstr
        L41 = L30
        L40 = L40(L41)
        L41 = L18
        L42 = dec2hexstr
        L43 = L31
        L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53 = L42(L43)
        L33 = L33(L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53)
        L6 = L33
        if A2 == "del" then
          L33 = table
          L33 = L33.insert
          L34 = A0
          L35 = 1
          L36 = L6
          L33(L34, L35, L36)
        elseif A2 == "change" then
        else
          L33 = table
          L33 = L33.insert
          L34 = A0
          L35 = L6
          L33(L34, L35)
        end
        L33 = L29.default
        if L33 then
          L24 = L31
          if L24 ~= 0 then
            L33 = "3"
            L34 = string
            L34 = L34.format
            L35 = "%s %s dev %s parent %s: prio %s handle 0x%s000000/0xff000000 fw classid %s:%s "
            L36 = const_tc_filter
            L37 = A2
            L38 = L17
            L39 = L18
            L40 = L33
            L41 = dec2hexstr
            L42 = L7
            L41 = L41(L42)
            L42 = L18
            L43 = dec2hexstr
            L44 = L24
            L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53 = L43(L44)
            L34 = L34(L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53)
            L6 = L34
            if A2 == "del" then
              L34 = table
              L34 = L34.insert
              L35 = A0
              L36 = 1
              L37 = L6
              L34(L35, L36, L37)
            elseif A2 == "change" then
            else
              L34 = table
              L34 = L34.insert
              L35 = A0
              L36 = L6
              L34(L35, L36)
            end
          end
        end
      end
    end
    ::lbl_404::
  end
  return L12
end
function L15(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L3 = {}
  L4()
  for L7, L8 in L4, L5, L6 do
    L9 = L8.net
    L9 = L9.old
    if L9 == "" then
      L9 = L8.net
      L9 = L9.new
      if L9 == "host" then
        L9 = L8.limit
        L9 = L9.UP
        if L9 == 0 then
          L9 = L8.limit
          L9 = L9.DOWN
        end
        if L9 ~= 0 then
          L9 = _UPVALUE2_
          L10 = L3
          L11 = A0
          L12 = "add"
          L13 = A1
          L14 = L8
          L9(L10, L11, L12, L13, L14)
        end
      end
    else
      L9 = L8.net
      L9 = L9.old
      if L9 == "host" then
        L9 = L8.net
        L9 = L9.new
        if L9 == "guest" then
          L9 = _UPVALUE2_
          L10 = L3
          L11 = A0
          L12 = "del"
          L13 = A1
          L14 = L8
          L9(L10, L11, L12, L13, L14)
        else
          L9 = L8.net
          L9 = L9.new
          if L9 == "host" then
            L9 = L8.limit
            L9 = L9.changed
            if L9 == 1 then
              L9 = _UPVALUE2_
              L10 = L3
              L11 = A0
              L12 = "change"
              L13 = A1
              L14 = L8
              L9(L10, L11, L12, L13, L14)
            end
          else
            L9 = _UPVALUE2_
            L10 = L3
            L11 = A0
            L12 = "del"
            L13 = A1
            L14 = L8
            L9(L10, L11, L12, L13, L14)
          end
        end
      else
        L9 = L8.net
        L9 = L9.new
        if L9 == "host" then
          L9 = _UPVALUE2_
          L10 = L3
          L11 = A0
          L12 = "add"
          L13 = A1
          L14 = L8
          L9(L10, L11, L12, L13, L14)
        else
        end
      end
    end
  end
  L4()
  if not L4 then
    L4(L5, L6)
    return L4
  end
  return L4
end
function L16()
  local L0, L1
  L0 = true
  return L0
end
L1.changed = L16
function L16(A0)
  local L1, L2, L3
  L1 = math
  L1 = L1.ceil
  L2 = UP
  L2 = A0[L2]
  L2 = L2 / 15
  L1 = L1(L2)
  L2 = math
  L2 = L2.ceil
  L3 = DOWN
  L3 = A0[L3]
  L3 = L3 / 15
  L2 = L2(L3)
  if L1 < 40 then
    L1 = 40
  end
  if L2 < 80 then
    L2 = 80
  end
  L3 = {}
  L3.UP = L1
  L3.DOWN = L2
  return L3
end
function L17(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57
  L2 = {}
  L3 = ""
  L4 = "add"
  for L8, L9 in L5, L6, L7 do
    L10 = L9.dev
    L11 = L9.id
    L12 = A1[L8]
    L13 = math
    L13 = L13.ceil
    L14 = _UPVALUE0_
    L14 = L14.quan_v
    L15 = _UPVALUE0_
    L15 = L15.root
    L15 = L15.quan
    L14 = L14 * L15
    L13 = L13(L14)
    L14 = dec2hexstr
    L15 = _UPVALUE0_
    L15 = L15.root
    L15 = L15.id
    L14 = L14(L15)
    L15 = get_burst
    L16 = L12
    L15, L16 = L15(L16)
    L17 = string
    L17 = L17.format
    L21 = L10
    L22 = L11
    L23 = get_stab_string
    L24 = L10
    L23 = L23(L24)
    L24 = dec2hexstr
    L25 = _UPVALUE0_
    L25 = L25.dft
    L24, L25, L26, L27, L28, L29, L30, L31, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57 = L24(L25)
    L17 = L17(L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57)
    L3 = L17
    L17 = table
    L17 = L17.insert
    L17(L18, L19)
    L17 = string
    L17 = L17.format
    L21 = L10
    L22 = L11
    L23 = L11
    L24 = L14
    L25 = L12
    L26 = UNIT
    L27 = L13
    L28 = L15
    L29 = L16
    L17 = L17(L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29)
    L3 = L17
    L17 = table
    L17 = L17.insert
    L17(L18, L19)
    L17 = string
    L17 = L17.format
    L21 = L10
    L22 = L11
    L23 = _UPVALUE0_
    L23 = L23.root
    L23 = L23.fprio
    L24 = _UPVALUE0_
    L24 = L24.root
    L24 = L24.fwmark
    L25 = L11
    L26 = "0"
    L17 = L17(L18, L19, L20, L21, L22, L23, L24, L25, L26)
    L3 = L17
    L17 = table
    L17 = L17.insert
    L17(L18, L19)
    L17 = apply_ppp_qdisc
    L17(L18, L19, L20)
    L17 = L14
    for L21, L22 in L18, L19, L20 do
      L23 = L22.id
      L24 = L22.prio
      L25 = math
      L25 = L25.ceil
      L26 = L22.rate
      L26 = L12 * L26
      L25 = L25(L26)
      L26 = math
      L26 = L26.ceil
      L27 = L22.ceil
      L27 = L12 * L27
      L26 = L26(L27)
      L27 = L22.limit
      if L27 then
        L27 = math
        L27 = L27.ceil
        L28 = L22.limit
        L28 = L28[L8]
        L27 = L27(L28)
        L26 = L27
        if L26 <= 1 then
          L27 = math
          L27 = L27.ceil
          L28 = L12 * L26
          L27 = L27(L28)
          L26 = L27
        end
      end
      if L21 == "host" then
        L27 = get_supressed_ceil
        L28 = L26
        L29 = L22.supress
        L27 = L27(L28, L29)
        L26 = L27
      end
      if L25 > L26 then
        L25 = L26
      end
      if L26 ~= 0 then
        L27 = get_burst
        L28 = L26
        L27, L28 = L27(L28)
        L29 = L22.quan
        L30 = _UPVALUE0_
        L30 = L30.quan_v
        L29 = L29 * L30
        L30 = string
        L30 = L30.format
        L31 = "%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s "
        L31 = L31 .. L32
        L35 = L11
        L36 = L17
        L37 = L11
        L38 = dec2hexstr
        L39 = L23
        L38 = L38(L39)
        L39 = L25
        L40 = UNIT
        L41 = L26
        L42 = UNIT
        L43 = L24
        L44 = L29
        L45 = L27
        L46 = L28
        L30 = L30(L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46)
        L3 = L30
        L30 = table
        L30 = L30.insert
        L31 = L2
        L30(L31, L32)
        if L21 == "special" then
          L30 = _UPVALUE1_
          L30 = L30.qos
          L30 = L30.small
          if L30 then
            L30 = L22.highest_prio
            if L30 then
              L30 = L22.highest_prio
              L31 = L2
              L35 = dec2hexstr
              L36 = L23
              L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57 = L35(L36)
              L30(L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57)
            end
          end
        elseif L21 == "host" then
          L30 = L23
          L31 = ""
          for L35, L36 in L32, L33, L34 do
            L37 = L36.id
            L37 = L30 + L37
            L38 = math
            L38 = L38.ceil
            L39 = L36.rate
            L39 = L25 * L39
            L38 = L38(L39)
            L39 = math
            L39 = L39.ceil
            L40 = L36.ceil
            L40 = L26 * L40
            L39 = L39(L40)
            if L38 > L39 then
              L38 = L39
            end
            L40 = _UPVALUE3_
            L41 = cfg
            L41 = L41.flow
            L41 = L41.seq
            L42 = L35
            L40 = L40(L41, L42)
            L41 = string
            L41 = L41.format
            L42 = "%s %s dev %s parent %s:%s "
            L43 = "classid %s:%s htb rate %s%s ceil %s%s prio %s "
            L44 = "quantum %s burst %d cburst %d "
            L42 = L42 .. L43 .. L44
            L43 = const_tc_class
            L44 = L4
            L45 = L10
            L46 = L11
            L47 = dec2hexstr
            L48 = L30
            L47 = L47(L48)
            L48 = L11
            L49 = dec2hexstr
            L50 = L37
            L49 = L49(L50)
            L50 = L38
            L51 = UNIT
            L52 = L39
            L53 = UNIT
            L54 = L40
            L55 = L29
            L56 = L27
            L57 = L28
            L41 = L41(L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57)
            L3 = L41
            L41 = table
            L41 = L41.insert
            L42 = L2
            L43 = L3
            L41(L42, L43)
            L41 = apply_leaf_qdisc
            L42 = L2
            L43 = L10
            L44 = L11
            L45 = dec2hexstr
            L46 = L37
            L45 = L45(L46)
            L46 = L39
            L47 = true
            L41(L42, L43, L44, L45, L46, L47)
            L41 = L36.mark
            L41 = L41.fwmark
            if L41 then
              L41 = L36.mark
              L41 = L41.fwmark
              if L41 ~= "" then
                L41 = string
                L41 = L41.format
                L42 = "%s %s dev %s parent %s: prio %s handle %s fw classid %s:%s"
                L43 = const_tc_filter
                L44 = L4
                L45 = L10
                L46 = L11
                L47 = L36.mark
                L47 = L47.fprio
                L48 = L36.mark
                L48 = L48.fwmark
                L49 = L11
                L50 = dec2hexstr
                L51 = L37
                L50, L51, L52, L53, L54, L55, L56, L57 = L50(L51)
                L41 = L41(L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57)
                L3 = L41
                L41 = table
                L41 = L41.insert
                L42 = L2
                L43 = L3
                L41(L42, L43)
              end
            end
            L41 = L36.default
            if L41 then
              L41 = string
              L41 = L41.format
              L42 = "%s %s dev %s parent %s: prio %s handle %s fw classid %s:%s"
              L43 = const_tc_filter
              L44 = L4
              L45 = L10
              L46 = L11
              L47 = L22.fprio
              L48 = L22.fwmark
              L49 = L11
              L50 = dec2hexstr
              L51 = L37
              L50, L51, L52, L53, L54, L55, L56, L57 = L50(L51)
              L41 = L41(L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57)
              L3 = L41
              L41 = table
              L41 = L41.insert
              L42 = L2
              L43 = L3
              L41(L42, L43)
            end
          end
        end
        if L21 ~= "host" and L21 ~= "leteng" then
          L30 = L22.fwmark
          if L30 then
            L30 = L22.fwmark
            if L30 ~= "" then
              L30 = string
              L30 = L30.format
              L31 = "%s %s dev %s parent %s: prio %s handle %s fw classid %s:%s"
              L35 = L11
              L36 = L22.fprio
              L37 = L22.fwmark
              L38 = L11
              L39 = dec2hexstr
              L40 = L23
              L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57 = L39(L40)
              L30 = L30(L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57)
              L3 = L30
              L30 = table
              L30 = L30.insert
              L31 = L2
              L30(L31, L32)
              L30 = apply_leaf_qdisc
              L31 = L2
              L35 = L23
              L35 = L26
              L36 = true
              L30(L31, L32, L33, L34, L35, L36)
            end
          end
        end
      end
    end
  end
  if not L5 then
    L5(L6, L7)
    return L5
  end
  return L5
end
function L18(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42
  L3 = {}
  L4 = "change"
  L5 = ""
  L6, L7, L8 = nil, nil, nil
  L9 = _UPVALUE0_
  L9 = L9.child
  L9 = L9[A0]
  if not L9 then
    L9 = logger
    L13 = " in mainframe."
    L9(L10, L11)
    L9 = false
    return L9
  end
  L9 = _UPVALUE0_
  L9 = L9.child
  L9 = L9[A0]
  for L13, L14 in L10, L11, L12 do
    L15 = L14.dev
    L16 = L14.id
    L17 = L9.id
    L18 = _UPVALUE0_
    L18 = L18.root
    L18 = L18.id
    L19 = A2[L13]
    L20 = math
    L20 = L20.ceil
    L21 = L9.rate
    L21 = L21 * L19
    L20 = L20(L21)
    L21 = L9.ceil
    L22 = L9.ceil
    if L22 == 0 then
      L22 = L9.limit
      L21 = L22[L13]
    end
    if L21 == 0 then
      lceil = L19
    elseif L21 <= 1 then
      L22 = math
      L22 = L22.ceil
      L23 = L19 * L21
      L22 = L22(L23)
      lceil = L22
    else
      lceil = L21
    end
    L22 = lceil
    if L22 <= 8 then
      L22 = 8
      lceil = L22
    end
    L22 = lceil
    if L20 > L22 then
      L20 = lceil
    end
    L22 = L9.prio
    L23 = get_burst
    L24 = lceil
    L23, L24 = L23(L24)
    L25 = L9.quan
    L26 = _UPVALUE0_
    L26 = L26.quan_v
    L25 = L25 * L26
    L26 = string
    L26 = L26.format
    L27 = "%s %s dev %s parent %s:%s classid %s:%s htb rate %s%s ceil %s%s "
    L28 = "prio %s quantum %s burst %d cburst %d"
    L27 = L27 .. L28
    L28 = const_tc_class
    L29 = L4
    L30 = L15
    L31 = L16
    L32 = dec2hexstr
    L33 = L18
    L32 = L32(L33)
    L33 = L16
    L34 = dec2hexstr
    L35 = L17
    L34 = L34(L35)
    L35 = L20
    L36 = UNIT
    L37 = lceil
    L38 = UNIT
    L39 = L22
    L40 = L25
    L41 = L23
    L42 = L24
    L26 = L26(L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42)
    L5 = L26
    L26 = table
    L26 = L26.insert
    L27 = L3
    L28 = L5
    L26(L27, L28)
    L26 = table
    L26 = L26.insert
    L27 = L3
    L28 = L5
    L26(L27, L28)
  end
  if not L10 then
    L10(L11, L12)
    return L10
  end
end
function L19(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = ""
  L3 = false
  L4 = cfg
  L4 = L4.guest
  L4 = L4.changed
  if L4 == 1 then
    L4 = L2
    L5 = "/guest"
    L2 = L4 .. L5
    L4 = cfg
    L4 = L4.guest
    L4.changed = 0
    L3 = true
  end
  if L2 ~= "" then
    L4 = logger
    L5 = 3
    L6 = "CHANGE: "
    L7 = L2
    L6 = L6 .. L7
    L4(L5, L6)
  end
  if L3 then
    L4 = _UPVALUE0_
    L5 = "guest"
    L6 = A0
    L7 = A1
    L4(L5, L6, L7)
  end
end
function L20(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = ""
  L3 = false
  L4 = cfg
  L4 = L4.xq
  L4 = L4.changed
  if L4 == 1 then
    L4 = L2
    L5 = "/xq"
    L2 = L4 .. L5
    L4 = cfg
    L4 = L4.xq
    L4.changed = 0
    L3 = true
  end
  if L2 ~= "" then
    L4 = logger
    L5 = 3
    L6 = "CHANGE: "
    L7 = L2
    L6 = L6 .. L7
    L4(L5, L6)
  end
  if L3 then
    L4 = _UPVALUE0_
    L5 = "xq"
    L6 = A0
    L7 = A1
    L4(L5, L6, L7)
  end
end
function L21(A0, A1, A2, A3)
  local L4, L5, L6
  L4 = _UPVALUE1_
  L5 = A3
  L4 = L4(L5)
  _UPVALUE0_ = L4
  L4 = logger
  L5 = 3
  L6 = "CHANGE: noifb"
  L4(L5, L6)
  if A0 then
    L4 = _UPVALUE2_
    L4 = L4.clean
    L5 = A2
    L4(L5)
    L4 = _UPVALUE3_
    L5 = A2
    L6 = A3
    L4(L5, L6)
  end
  L4 = _UPVALUE4_
  L5 = A2
  L6 = A3
  L4(L5, L6)
  L4 = _UPVALUE5_
  L5 = A2
  L6 = A3
  L4(L5, L6)
  L4 = true
  return L4
end
L22 = {}
L23 = {}
L23.ftprio = "1"
L23.flow = "0"
L22.HIGH_PRIO_WITHOUT_LIMIT = L23
L23 = {}
L23.ftprio = "2"
L23.flow = "2000"
L22.HIGH_PRIO_WITH_BANDLIMIT = L23
function L23()
  local L0, L1, L2
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
  L0 = true
  return L0
end
L1.read_qos_config = L23
function L23(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = {}
  L2 = string
  L2 = L2.format
  L3 = "%s del dev br-guest root "
  L4 = const_tc_qdisc
  L2 = L2(L3, L4)
  L3 = table
  L3 = L3.insert
  L4 = L1
  L5 = L2
  L3(L4, L5)
  L3 = A0.DOWN
  L4 = cfg
  L4 = L4.bands
  L4 = L4.DOWN
  L3 = L3 * L4
  L4 = get_burst
  L5 = L3
  L4, L5 = L4(L5)
  L6 = string
  L6 = L6.format
  L7 = "%s add dev br-guest root handle 3: htb default 1000 "
  L8 = const_tc_qdisc
  L6 = L6(L7, L8)
  expr = L6
  L6 = table
  L6 = L6.insert
  L7 = L1
  L8 = expr
  L6(L7, L8)
  L6 = string
  L6 = L6.format
  L7 = "%s add dev br-guest parent 3: classid 3:1000 htb rate %s%s quantum 3200 burst %d cburst %d"
  L8 = const_tc_class
  L9 = L3
  L10 = UNIT
  L11 = L4
  L12 = L5
  L6 = L6(L7, L8, L9, L10, L11, L12)
  expr = L6
  L6 = table
  L6 = L6.insert
  L7 = L1
  L8 = expr
  L6(L7, L8)
  L6 = exec_cmd
  L7 = L1
  L8 = 1
  L6 = L6(L7, L8)
  if not L6 then
    L6 = logger
    L7 = 3
    L8 = "ERROR: clean qdisc rules for host mode failed!"
    L6(L7, L8)
  end
end
function L24(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8
  L4 = _UPVALUE0_
  L5 = A3
  L6 = origin_disc
  L7 = A2
  L8 = cfg
  L8 = L8.bands
  L4(L5, L6, L7, L8)
  L4 = _UPVALUE1_
  L5 = A2
  L6 = _UPVALUE2_
  L6 = L6.child
  L6 = L6.host
  L6 = L6.id
  L7 = _UPVALUE2_
  L7 = L7.child
  L7 = L7.guest
  L7 = L7.id
  L4(L5, L6, L7)
  L4 = _UPVALUE3_
  L5 = cfg
  L5 = L5.guest
  L5 = L5.inner
  L4(L5)
  L4 = true
  return L4
end
L1.apply = L24
function L24(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = cfg
  L1 = L1.enabled
  L1 = L1.flag
  if L1 == "0" then
    return
  end
  L1 = {}
  if L2 ~= "FIX" then
    if L2 ~= "NOIFB" then
      goto lbl_16
    end
  end
  L2()
  ::lbl_16::
  for L5, L6 in L2, L3, L4 do
    L7 = "on"
    L8 = g_group_def
    L9 = L6.mac
    L8 = L8[L9]
    if not L8 then
      L7 = "off"
    else
      L8 = g_group_def
      L9 = L6.mac
      L8 = L8[L9]
      L8 = L8.flag
      if L8 then
        L8 = g_group_def
        L9 = L6.mac
        L8 = L8[L9]
        L7 = L8.flag
      else
        L8 = tonumber
        L9 = g_group_def
        L10 = L6.mac
        L9 = L9[L10]
        L9 = L9.max_grp_uplink
        L9 = L9 or L9
        L8 = L8(L9)
        if not (L8 <= 0) then
          L8 = tonumber
          L9 = g_group_def
          L10 = L6.mac
          L9 = L9[L10]
          L9 = L9.max_grp_downlink
          L9 = L9 or L9
          L8 = L8(L9)
          if not (L8 <= 0) then
            goto lbl_62
          end
        end
        L7 = "off"
      end
    end
    ::lbl_62::
    L8 = {}
    L9 = L6.mac
    L8.MAC = L9
    L9 = {}
    L9.min = 0
    L9.min_per = 0
    L9.min_cfg = 0
    L10 = 0
    L11 = "Kbit"
    L10 = L10 .. L11
    L9.max = L10
    L10 = L6.UP
    L10 = L10.max_per
    L10 = L10 or L10
    L9.max_per = L10
    L9.max_cfg = 0
    L8.UP = L9
    L9 = {}
    L9.min = 0
    L9.min_per = 0
    L9.min_cfg = 0
    L10 = 0
    L11 = "Kbit"
    L10 = L10 .. L11
    L9.max = L10
    L10 = L6.DOWN
    L10 = L10.max_per
    L10 = L10 or L10
    L9.max_per = L10
    L9.max_cfg = 0
    L8.DOWN = L9
    L8.flag = L7
    L1[L5] = L8
    L8 = _UPVALUE2_
    L8 = L8[L5]
    if L8 then
      L8 = L1[L5]
      L8 = L8.UP
      L9 = _UPVALUE2_
      L9 = L9[L5]
      L9 = L9.limit
      L9 = L9.UP
      if not L9 then
        L9 = 0
        L10 = "Kbit"
        L9 = L9 .. L10
      end
      L8.max = L9
      L8 = L1[L5]
      L8 = L8.DOWN
      L9 = _UPVALUE2_
      L9 = L9[L5]
      L9 = L9.limit
      L9 = L9.DOWN
      if not L9 then
        L9 = 0
        L10 = "Kbit"
        L9 = L9 .. L10
      end
      L8.max = L9
    end
  end
  return L1
end
L1.update_counters = L24
