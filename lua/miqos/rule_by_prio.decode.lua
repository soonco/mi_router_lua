local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
L0 = require
L1 = "miqos.common"
L0(L1)
L0 = qdisc
if not L0 then
  L0 = {}
  qdisc = L0
end
L0 = "prio"
L1 = {}
L2 = {}
L3 = {}
L3.fwmark = "0x00010000/0x000f0000"
L3.fprio = "4"
L2[1] = L3
L1.high = L2
L2 = {}
L3 = {}
L3.fwmark = "0x00020000/0x000f0000"
L3.fprio = "4"
L4 = {}
L4.fwmark = "0x00130000/0x00ff0000"
L4.fprio = "5"
L2[1] = L3
L2[2] = L4
L1.game = L2
L2 = {}
L3 = {}
L3.fwmark = "0x00230000/0x00ff0000"
L3.fprio = "5"
L2[1] = L3
L1.web = L2
L2 = {}
L3 = {}
L3.fwmark = "0x00330000/0x00ff0000"
L3.fprio = "5"
L2[1] = L3
L1.video = L2
L2 = {}
L3 = {}
L3.fwmark = "0x00430000/0x00ff0000"
L3.fprio = "5"
L2[1] = L3
L1.other = L2
L2 = {}
L3 = {}
L3.fwmark = "0x00040000/0x000f0000"
L3.fprio = "4"
L2[1] = L3
L1.guest = L2
L2 = {}
L3 = {}
L3.fwmark = "0x00050000/0x000f0000"
L3.fprio = "4"
L2[1] = L3
L1.xq = L2
L2 = {}
L3 = {}
L3.small = false
L2.qos = L3
L3 = {}
L3.dft = 28672
L3.quan_v = 1500
L4 = {}
L4.id = 4096
L4.quan = 8
L3.root = L4
L4 = {}
L5 = {}
L5.id = 1
L5.prio = "1"
L5.type = "high"
L5.cid = 1
L6 = {}
L6.id = 2
L6.prio = "2"
L6.type = "game"
L6.cid = 2
L7 = {}
L7.id = 3
L7.prio = "3"
L7.type = "web"
L7.cid = 3
L8 = {}
L8.id = 4
L8.prio = "4"
L8.type = "video"
L8.cid = 4
L9 = {}
L9.id = 5
L9.prio = "5"
L9.type = "other"
L9.cid = 5
L10 = {}
L10.id = 6
L10.prio = "6"
L10.type = "guest"
L11 = cfg
L11 = L11.guest
L10.limit = L11
L10.cid = 11
L11 = {}
L11.id = 7
L11.prio = "7"
L11.type = "xq"
L12 = cfg
L12 = L12.xq
L11.limit = L12
L11.cid = 12
L4[1] = L5
L4[2] = L6
L4[3] = L7
L4[4] = L8
L4[5] = L9
L4[6] = L10
L4[7] = L11
L3.child = L4
L4 = {}
L5 = qdisc
L5[L0] = L4
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = {}
  if not A0 then
  end
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
end
L4.clean = L5
function L5()
  local L0, L1, L2, L3, L4, L5
  L0 = false
  L1 = ""
  L2 = cfg
  L2 = L2.bands
  L2 = L2.changed
  if L2 then
    L2 = L1
    L3 = "/band"
    L1 = L2 .. L3
    L2 = cfg
    L2 = L2.bands
    L2.changed = false
    L0 = true
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
    L0 = true
  end
  L2 = special_host_list
  L2 = L2.changed
  if L2 then
    L2 = L1
    L3 = "/speical host list"
    L1 = L2 .. L3
    L2 = special_host_list
    L2.changed = false
    L0 = true
  end
  if L1 ~= "" then
    L2 = logger
    L3 = 3
    L4 = "CHANGE: "
    L5 = L1
    L4 = L4 .. L5
    L2(L3, L4)
  end
  return L0
end
L4.changed = L5
function L5()
  local L0, L1, L2
  L0 = read_qos_guest_xq_config
  L1 = true
  L0 = L0(L1)
  if not L0 then
    L0 = logger
    L1 = 3
    L2 = "read_qos_config failed."
    L0(L1, L2)
    L0 = false
    return L0
  end
end
L4.read_qos_config = L5
L5 = {}
L6 = {}
L6.ftprio = "1"
L6.flow = "1"
L5.HIGH_PRIO_WITHOUT_LIMIT = L6
L6 = {}
L6.ftprio = "2"
L6.flow = "2"
L5.HIGH_PRIO_WITH_BANDLIMIT = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    L8 = L7.dev
    L9 = L7.id
    for L13, L14 in L10, L11, L12 do
      L15 = string
      L15 = L15.format
      L16 = "%s del dev %s parent %s: prio %s "
      L17 = const_tc_filter
      L18 = L8
      L19 = L9
      L20 = L14.ftprio
      L15 = L15(L16, L17, L18, L19, L20)
      L16 = table
      L16 = L16.insert
      L17 = L2
      L18 = L15
      L16(L17, L18)
    end
    for L13, L14 in L10, L11, L12 do
      L15 = _UPVALUE0_
      L15 = L15[L14]
      if L15 then
        L15 = _UPVALUE0_
        L15 = L15[L14]
        L15 = L15.ftprio
        L16 = _UPVALUE0_
        L16 = L16[L14]
        L16 = L16.flow
        L17 = tonumber
        L18 = string
        L18 = L18.split
        L19 = L13
        L20 = "."
        L18 = L18(L19, L20)
        L18 = L18[4]
        L17 = L17(L18)
        L18 = "0x"
        L19 = dec2hexstr
        L20 = L17
        L19 = L19(L20)
        L20 = "000000/0xff000000"
        L17 = L18 .. L19 .. L20
        L18 = string
        L18 = L18.format
        L19 = " %s replace dev %s parent %s: prio %s handle %s fw classid %s:%s "
        L20 = const_tc_filter
        L21 = L8
        L22 = L9
        L23 = L15
        L24 = L17
        L25 = L9
        L26 = L16
        L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26)
        L19 = table
        L19 = L19.insert
        L20 = A0
        L21 = L18
        L19(L20, L21)
      end
    end
  end
  L3(L4, L5)
  return L3
end
function L7(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39
  L4 = ""
  for L8, L9 in L5, L6, L7 do
    L10 = L9.dev
    L11 = L9.id
    L12 = table
    L12 = L12.getn
    L13 = _UPVALUE0_
    L13 = L13.child
    L12 = L12(L13)
    L13 = A3[L8]
    if A2 == "add" then
      L14 = string
      L14 = L14.format
      L15 = " %s %s dev %s root handle %s: prio bands %d priomap 2 3 3 3 2 3 1 1 2 2 2 2 2 2 2 2 "
      L19 = L11
      L20 = L12
      L14 = L14(L15, L16, L17, L18, L19, L20)
      L4 = L14
      L14 = table
      L14 = L14.insert
      L15 = A0
      L14(L15, L16)
    end
    L14, L15 = nil, nil
    for L19, L20 in L16, L17, L18 do
      if L21 then
        if L21 then
          goto lbl_51
        end
      end
      L21(L22, L23)
      do return L21 end
      ::lbl_51::
      for L24, L25 in L21, L22, L23 do
        L26 = L25.fprio
        L15 = L25.fwmark
        L14 = L26
        L26 = string
        L26 = L26.format
        L27 = " %s %s dev %s parent %s: prio %s handle %s fw classid %s:%s "
        L28 = const_tc_filter
        L29 = A2
        L30 = L10
        L31 = L11
        L32 = L14
        L33 = L15
        L34 = L11
        L35 = L19
        L26 = L26(L27, L28, L29, L30, L31, L32, L33, L34, L35)
        L4 = L26
        L26 = table
        L26 = L26.insert
        L27 = A0
        L28 = L4
        L26(L27, L28)
        L26 = 0
        L27 = L20.limit
        if L27 then
          L27 = L20.limit
          L27 = L27[L8]
          if L27 <= 0 then
            L26 = L13
          else
            L27 = L20.limit
            L27 = L27[L8]
            if L27 <= 1 then
              L27 = math
              L27 = L27.ceil
              L28 = L20.limit
              L28 = L28[L8]
              L28 = L13 * L28
              L27 = L27(L28)
              L26 = L27
            else
              L27 = math
              L27 = L27.ceil
              L28 = L20.limit
              L28 = L28[L8]
              L27 = L27(L28)
              L26 = L27
            end
          end
          L27 = "replace"
          L28 = math
          L28 = L28.ceil
          L29 = L26 * 1024
          L30 = g_CONFIG_HZ
          L29 = L29 / L30
          L28 = L28(L29)
          if L28 < 2000 then
            L28 = 2000
          end
          L29 = string
          L29 = L29.format
          L30 = " %s %s dev %s parent %s:%s handle %d: tbf rate %s%s buffer %s latency 10ms"
          L31 = const_tc_qdisc
          L32 = L27
          L33 = L10
          L34 = L11
          L35 = L19
          L36 = L20.cid
          L37 = L26
          L38 = UNIT
          L39 = L28
          L29 = L29(L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
          L4 = L29
          L29 = table
          L29 = L29.insert
          L30 = A0
          L31 = L4
          L29(L30, L31)
        end
        L27 = L20.bandlimit
        if L27 then
          L27 = tonumber
          L28 = L20.bandlimit
          L28 = L28[L8]
          L27 = L27(L28)
          if 0 < L27 then
            L27 = tonumber
            L28 = L20.bandlimit
            L28 = L28[L8]
            L27 = L27(L28)
            L26 = L27
            L27 = "replace"
            L28 = math
            L28 = L28.ceil
            L29 = L26 * 1024
            L30 = g_CONFIG_HZ
            L29 = L29 / L30
            L28 = L28(L29)
            if L28 < 2000 then
              L28 = 2000
            end
            L29 = string
            L29 = L29.format
            L30 = " %s %s dev %s parent %s:%s handle %d: tbf rate %s%s buffer %s latency 10ms"
            L31 = const_tc_qdisc
            L32 = L27
            L33 = L10
            L34 = L11
            L35 = L19
            L36 = L20.cid
            L37 = L26
            L38 = UNIT
            L39 = L28
            L29 = L29(L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
            L4 = L29
            L29 = table
            L29 = L29.insert
            L30 = A0
            L31 = L4
            L29(L30, L31)
          end
        end
      end
      if not L21 then
        if not L21 then
          L24 = L11
          L25 = L20.cid
          L26 = 0
          L21(L22, L23, L24, L25, L26)
        end
      end
    end
    if L16 then
      L19 = "add"
      L20 = L11
      L16(L17, L18, L19, L20, L21)
    end
  end
  if not L5 then
    return L5
  end
  return L5
end
function L8(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10
  L4 = "add"
  if not A0 then
    L4 = "add"
  else
    L5 = qdisc
    L5 = L5[A0]
    if not L5 then
      L5 = logger
      L6 = 3
      L7 = "ERROR: qdisc `"
      L8 = A0
      L9 = "` not found. "
      L7 = L7 .. L8 .. L9
      L5(L6, L7)
      L5 = false
      return L5
    elseif A3 then
      L5 = _UPVALUE0_
      L5 = L5.clean
      L6 = A2
      L5(L6)
      L4 = "add"
    else
      L5 = _UPVALUE1_
      if A0 == L5 then
        L4 = "change"
      else
        L5 = _UPVALUE0_
        L5 = L5.clean
        L6 = A2
        L5(L6)
        L4 = "add"
      end
    end
  end
  L5 = {}
  L6 = _UPVALUE2_
  L7 = L5
  L8 = A2
  L9 = L4
  L10 = A1
  L6 = L6(L7, L8, L9, L10)
  if not L6 then
    L6 = logger
    L7 = 3
    L8 = "ERROR: generate prio qdisc failed."
    L6(L7, L8)
    L6 = false
    return L6
  end
  L6 = exec_cmd
  L7 = L5
  L8 = nil
  L6 = L6(L7, L8)
  if not L6 then
    L6 = logger
    L7 = 3
    L8 = "ERROR: apply prio qdisc failed."
    L6(L7, L8)
    L6 = false
    return L6
  end
  L6 = true
  return L6
end
L4.apply = L8
