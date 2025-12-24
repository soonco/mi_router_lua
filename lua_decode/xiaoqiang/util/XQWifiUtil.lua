local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45, L46, L47, L48, L49, L50, L51, L52, L53, L54, L55, L56, L57, L58
L0 = module
L1 = "xiaoqiang.util.XQWifiUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "luci.model.network"
L2 = L2(L3)
L3 = require
L4 = "luci.util"
L3 = L3(L4)
L4 = require
L5 = "xiaoqiang.XQLog"
L4 = L4(L5)
L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
function L33()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  _UPVALUE0_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "if_2G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE1_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "if_5G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE2_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "if_5GH"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE3_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "if_6G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE4_ = L0
  L0 = tonumber
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "misc"
  L4 = "wireless"
  L5 = "wl_if_count"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L0 = L0(L1)
  _UPVALUE5_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "ifname_2G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE6_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "ifname_5G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE7_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "wifi5_bk_2G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE8_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "wifi5_bk_5G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE9_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "ifname_5GH"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE10_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "ifname_6G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE11_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "ifname_game"
  L0 = L0(L1, L2, L3, L4)
  _UPVALUE12_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "ifname_guest_2G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE13_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "ifname_guest_5G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  _UPVALUE14_ = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "wifi5_bk_2G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  iot_ifname_2g = L0
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "wireless"
  L4 = "wifi5_bk_5G"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  iot_ifname_5g = L0
  L0 = {}
  L1 = _UPVALUE1_
  L2 = _UPVALUE2_
  L0[1] = L1
  L0[2] = L2
  _UPVALUE15_ = L0
  L0 = {}
  L1 = _UPVALUE1_
  L2 = _UPVALUE2_
  L0[1] = L1
  L0[2] = L2
  _UPVALUE16_ = L0
  L0 = {}
  L1 = _UPVALUE1_
  L2 = ".network1"
  L1 = L1 .. L2
  L2 = _UPVALUE2_
  L3 = ".network1"
  L2 = L2 .. L3
  L0[1] = L1
  L0[2] = L2
  _UPVALUE17_ = L0
  L0 = {}
  L1 = _UPVALUE6_
  L2 = _UPVALUE7_
  L0[1] = L1
  L0[2] = L2
  _UPVALUE18_ = L0
  L0 = {}
  L1 = _UPVALUE8_
  L2 = _UPVALUE9_
  L0[1] = L1
  L0[2] = L2
  _UPVALUE19_ = L0
  L0 = {}
  L1 = _UPVALUE13_
  L2 = _UPVALUE14_
  L0[1] = L1
  L0[2] = L2
  _UPVALUE20_ = L0
  L0 = {}
  L1 = iot_ifname_2g
  L2 = iot_ifname_5g
  L0[1] = L1
  L0[2] = L2
  _UPVALUE21_ = L0
  L0 = {}
  L1 = "guest_2G"
  L2 = "guest_5G"
  L0[1] = L1
  L0[2] = L2
  _UPVALUE22_ = L0
  L0 = {}
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.CN = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11"
  L3 = "0 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.TW = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.HK = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"
  L1[1] = L2
  L1[2] = L3
  L0.EU = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"
  L1[1] = L2
  L1[2] = L3
  L0.UK = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.AS = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"
  L1[1] = L2
  L1[2] = L3
  L0.JP = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.KR = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.US = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.ID = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.IN = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"
  L1[1] = L2
  L1[2] = L3
  L0.DE = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"
  L1[1] = L2
  L1[2] = L3
  L0.GB = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.MY = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64"
  L1[1] = L2
  L1[2] = L3
  L0.RU = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.UA = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64"
  L1[1] = L2
  L1[2] = L3
  L0.EG = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64"
  L1[1] = L2
  L1[2] = L3
  L0.IL = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64"
  L1[1] = L2
  L1[2] = L3
  L0.MA = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64"
  L1[1] = L2
  L1[2] = L3
  L0.AZ = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64 100 104 108 112 116 120 124 128 132 136 140"
  L1[1] = L2
  L1[2] = L3
  L0.KZ = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64"
  L1[1] = L2
  L1[2] = L3
  L0.UZ = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64"
  L1[1] = L2
  L1[2] = L3
  L0.NG = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64"
  L1[1] = L2
  L1[2] = L3
  L0.TN = L1
  _UPVALUE23_ = L0
  L0 = {}
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 52 56 60 64"
  L4 = "0 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L0.CN = L1
  _UPVALUE24_ = L0
  L0 = {}
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L4 = "0 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L0.CN = L1
  _UPVALUE25_ = L0
  L0 = {}
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.CN = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.TW = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.HK = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.EU = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.UK = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.AS = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.JP = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.KR = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.US = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.ID = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.IN = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.DE = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.GB = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.MY = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.RU = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48 149 153 157 161 165"
  L1[1] = L2
  L1[2] = L3
  L0.UA = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.EG = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.IL = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.MA = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.AZ = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.KZ = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.UZ = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.NG = L1
  L1 = {}
  L2 = "0 1 2 3 4 5 6 7 8 9 10 11 12 13"
  L3 = "0 36 40 44 48"
  L1[1] = L2
  L1[2] = L3
  L0.TN = L1
  _UPVALUE26_ = L0
  L0 = {}
  L1 = {}
  L2 = "20"
  L1[1] = L2
  L2 = {}
  L3 = "20"
  L4 = "40"
  L2[1] = L3
  L2[2] = L4
  L3 = {}
  L4 = "20"
  L5 = "40"
  L6 = "80"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L4 = {}
  L5 = "20"
  L6 = "40"
  L7 = "80"
  L8 = "160"
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  L0[1] = L1
  L0[2] = L2
  L0[3] = L3
  L0[4] = L4
  _UPVALUE27_ = L0
  L0 = _UPVALUE5_
  if 3 == L0 then
    L0 = string
    L0 = L0.len
    L1 = _UPVALUE3_
    L0 = L0(L1)
    if 0 < L0 then
      L0 = table
      L0 = L0.insert
      L1 = _UPVALUE15_
      L2 = _UPVALUE12_
      if L2 then
        L2 = 2
        if L2 then
          goto lbl_510
        end
      end
      L2 = 3
      ::lbl_510::
      L3 = _UPVALUE3_
      L0(L1, L2, L3)
      L0 = table
      L0 = L0.insert
      L1 = _UPVALUE17_
      L2 = _UPVALUE12_
      if L2 then
        L2 = 2
        if L2 then
          goto lbl_522
        end
      end
      L2 = 3
      ::lbl_522::
      L3 = _UPVALUE3_
      L4 = ".network1"
      L3 = L3 .. L4
      L0(L1, L2, L3)
    else
      L0 = string
      L0 = L0.len
      L1 = _UPVALUE4_
      L0 = L0(L1)
      if 0 < L0 then
        L0 = table
        L0 = L0.insert
        L1 = _UPVALUE15_
        L2 = _UPVALUE4_
        L0(L1, L2)
        L0 = table
        L0 = L0.insert
        L1 = _UPVALUE17_
        L2 = _UPVALUE4_
        L3 = ".network1"
        L2 = L2 .. L3
        L0(L1, L2)
      end
    end
  end
  L0 = _UPVALUE5_
  if 3 == L0 then
    L0 = string
    L0 = L0.len
    L1 = _UPVALUE10_
    L0 = L0(L1)
    if 0 < L0 then
      L0 = table
      L0 = L0.insert
      L1 = _UPVALUE18_
      L2 = _UPVALUE12_
      if L2 then
        L2 = 2
        if L2 then
          goto lbl_564
        end
      end
      L2 = 3
      ::lbl_564::
      L3 = _UPVALUE10_
      L0(L1, L2, L3)
      L0 = _UPVALUE24_
      _UPVALUE23_ = L0
      L0 = _UPVALUE25_
      _UPVALUE26_ = L0
    else
      L0 = string
      L0 = L0.len
      L1 = _UPVALUE11_
      L0 = L0(L1)
      if 0 < L0 then
        L0 = table
        L0 = L0.insert
        L1 = _UPVALUE18_
        L2 = _UPVALUE11_
        L0(L1, L2)
      end
    end
  end
end
init = L33
function L33()
  local L0, L1
  L0 = _UPVALUE0_
  L1 = _UPVALUE1_
  return L0, L1
end
getWifiNames = L33
function L33()
  local L0, L1
  L0 = _UPVALUE0_
  return L0
end
getWifiDevNames = L33
function L33(A0)
  local L1
  L1 = _UPVALUE0_
  L1 = L1[A0]
  return L1
end
_wifiNameForIndex = L33
function L33()
  local L0, L1
  L0 = _UPVALUE0_
  return L0
end
get_wlan_count = L33
function L33()
  local L0, L1
  L0 = _UPVALUE0_
  return L0
end
get_wlan_ifname = L33
function L33()
  local L0, L1
  L0 = _UPVALUE0_
  return L0
end
get_wlan_wifi5_ifname = L33
function L33()
  local L0, L1
  L0 = _UPVALUE0_
  return L0
end
get_wlan_guest_ifname = L33
function L33()
  local L0, L1
  L0 = _UPVALUE0_
  if L0 then
    L0 = "_5G_Game"
    if L0 then
      goto lbl_8
    end
  end
  L0 = "_5G2"
  ::lbl_8::
  return L0
end
get5G2BandSuffix = L33
function L33()
  local L0, L1
  L0 = _UPVALUE0_
  if 2 < L0 then
    L0 = _UPVALUE1_
    if L0 then
      L0 = true
      return L0
  end
  else
    L0 = false
    return L0
  end
end
getGameWifiSupport = L33
function L33()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L2 = nil
  L6, L7, L8, L9, L13, L14, L15, L16, L17, L18, L19, L20 = L4(L5)
  for L6, L7 in L3, L4, L5 do
    L8 = {}
    L9 = L7.is_up
    L9 = L9(L10)
    L8.up = L9
    L9 = L7.name
    L9 = L9(L10)
    L8.device = L9
    L9 = {}
    L8.networks = L9
    L9 = nil
    L13, L14, L15, L16, L17, L18, L19, L20 = L11(L12)
    for L13, L14 in L10, L11, L12 do
      L15 = L8.networks
      L16 = L8.networks
      L16 = #L16
      L16 = L16 + 1
      L17 = {}
      L19 = L14
      L18 = L14.shortname
      L18 = L18(L19)
      L17.name = L18
      L19 = L14
      L18 = L14.is_up
      L18 = L18(L19)
      L17.up = L18
      L19 = L14
      L18 = L14.active_mode
      L18 = L18(L19)
      L17.mode = L18
      L19 = L14
      L18 = L14.active_ssid
      L18 = L18(L19)
      L17.ssid = L18
      L19 = L14
      L18 = L14.active_bssid
      L18 = L18(L19)
      L17.bssid = L18
      L19 = L14
      L18 = L14.ssid
      L18 = L18(L19)
      L17.cssid = L18
      L19 = L14
      L18 = L14.active_encryption
      L18 = L18(L19)
      L17.encryption = L18
      L19 = L14
      L18 = L14.frequency
      L18 = L18(L19)
      L17.frequency = L18
      L19 = L14
      L18 = L14.channel
      L18 = L18(L19)
      L17.channel = L18
      L19 = L14
      L18 = L14.confchannel
      L18 = L18(L19)
      L17.cchannel = L18
      L19 = L14
      L18 = L14.bw
      L18 = L18(L19)
      L17.bw = L18
      L19 = L14
      L18 = L14.confbw
      L18 = L18(L19)
      L17.cbw = L18
      L19 = L14
      L18 = L14.signal
      L18 = L18(L19)
      L17.signal = L18
      L19 = L14
      L18 = L14.signal_percent
      L18 = L18(L19)
      L17.quality = L18
      L19 = L14
      L18 = L14.noise
      L18 = L18(L19)
      L17.noise = L18
      L19 = L14
      L18 = L14.bitrate
      L18 = L18(L19)
      L17.bitrate = L18
      L19 = L14
      L18 = L14.ifname
      L18 = L18(L19)
      L17.ifname = L18
      L19 = L14
      L18 = L14.assoclist
      L18 = L18(L19)
      L17.assoclist = L18
      L19 = L14
      L18 = L14.country
      L18 = L18(L19)
      L17.country = L18
      L19 = L14
      L18 = L14.txpower
      L18 = L18(L19)
      L17.txpower = L18
      L19 = L14
      L18 = L14.txpower_offset
      L18 = L18(L19)
      L17.txpoweroff = L18
      L19 = L14
      L18 = L14.get
      L20 = "key"
      L18 = L18(L19, L20)
      L17.key = L18
      L19 = L14
      L18 = L14.get
      L20 = "key1"
      L18 = L18(L19, L20)
      L17.key1 = L18
      L19 = L14
      L18 = L14.get
      L20 = "encryption"
      L18 = L18(L19, L20)
      L17.encryption_src = L18
      L19 = L14
      L18 = L14.get
      L20 = "hidden"
      L18 = L18(L19, L20)
      L17.hidden = L18
      L19 = L14
      L18 = L14.txpwr
      L18 = L18(L19)
      L17.txpwr = L18
      L19 = L14
      L18 = L14.get
      L20 = "bsd"
      L18 = L18(L19, L20)
      L17.bsd = L18
      L19 = L7
      L18 = L7.get
      L20 = "txbf"
      L18 = L18(L19, L20)
      L18 = L18 or L18
      L17.txbf = L18
      L19 = L7
      L18 = L7.get
      L20 = "ax"
      L18 = L18(L19, L20)
      L18 = L18 or L18
      L17.ax = L18
      L19 = L14
      L18 = L14.get
      L20 = "weakenable"
      L18 = L18(L19, L20)
      L18 = L18 or L18
      L17.weakenable = L18
      L19 = L14
      L18 = L14.get
      L20 = "weakthreshold"
      L18 = L18(L19, L20)
      L18 = L18 or L18
      L17.weakthreshold = L18
      L19 = L14
      L18 = L14.get
      L20 = "kickthreshold"
      L18 = L18(L19, L20)
      L18 = L18 or L18
      L17.kickthreshold = L18
      L19 = L14
      L18 = L14.get
      L20 = "apcliband"
      L18 = L18(L19, L20)
      L17.apcliband = L18
      L19 = L14
      L18 = L14.disabled
      L18 = L18(L19)
      L18 = L18 or L18
      L17.disabled = L18
      L19 = L14
      L18 = L14.get
      L20 = "sae"
      L18 = L18(L19, L20)
      L18 = L18 or L18
      L17.sae = L18
      L19 = L14
      L18 = L14.get
      L20 = "sae_password"
      L18 = L18(L19, L20)
      L17.sae_password = L18
      L15[L16] = L17
      L16 = L14
      L15 = L14.disabled
      L15 = L15(L16)
      if L15 == nil then
        L16 = L14
        L15 = L14.set
        L17 = "disabled"
        L18 = "0"
        L15(L16, L17, L18)
        L15 = _UPVALUE1_
        L15 = L15.log
        L16 = 6
        L17 = "init disabled =0 ifname: "
        L19 = L14
        L18 = L14.ifname
        L18 = L18(L19)
        L17 = L17 .. L18
        L15(L16, L17)
        L16 = L1
        L15 = L1.save
        L17 = "wireless"
        L15(L16, L17)
        L16 = L1
        L15 = L1.commit
        L17 = "wireless"
        L15(L16, L17)
      end
    end
    L0[L10] = L8
  end
  return L0
end
wifiNetworks = L33
function L33(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_wifinet
  L4 = A0
  L2 = L2(L3, L4)
  if L2 then
    L4 = L2
    L3 = L2.get_device
    L3 = L3(L4)
    if L3 then
      L4 = {}
      L4.id = A0
      L6 = L2
      L5 = L2.shortname
      L5 = L5(L6)
      L4.name = L5
      L6 = L2
      L5 = L2.is_up
      L5 = L5(L6)
      L4.up = L5
      L6 = L2
      L5 = L2.active_mode
      L5 = L5(L6)
      L4.mode = L5
      L6 = L2
      L5 = L2.active_ssid
      L5 = L5(L6)
      L4.ssid = L5
      L6 = L2
      L5 = L2.active_bssid
      L5 = L5(L6)
      L4.bssid = L5
      L6 = L2
      L5 = L2.ssid
      L5 = L5(L6)
      L4.cssid = L5
      L6 = L2
      L5 = L2.active_encryption
      L5 = L5(L6)
      L4.encryption = L5
      L6 = L2
      L5 = L2.get
      L7 = "encryption"
      L5 = L5(L6, L7)
      L4.encryption_src = L5
      L6 = L2
      L5 = L2.frequency
      L5 = L5(L6)
      L4.frequency = L5
      L6 = L2
      L5 = L2.channel
      L5 = L5(L6)
      L4.channel = L5
      L6 = L2
      L5 = L2.confchannel
      L5 = L5(L6)
      L4.cchannel = L5
      L6 = L2
      L5 = L2.bw
      L5 = L5(L6)
      L4.bw = L5
      L6 = L2
      L5 = L2.confbw
      L5 = L5(L6)
      L4.cbw = L5
      L6 = L2
      L5 = L2.signal
      L5 = L5(L6)
      L4.signal = L5
      L6 = L2
      L5 = L2.signal_percent
      L5 = L5(L6)
      L4.quality = L5
      L6 = L2
      L5 = L2.noise
      L5 = L5(L6)
      L4.noise = L5
      L6 = L2
      L5 = L2.bitrate
      L5 = L5(L6)
      L4.bitrate = L5
      L6 = L2
      L5 = L2.ifname
      L5 = L5(L6)
      L4.ifname = L5
      L6 = L2
      L5 = L2.assoclist
      L5 = L5(L6)
      L4.assoclist = L5
      L6 = L2
      L5 = L2.country
      L5 = L5(L6)
      L4.country = L5
      L6 = L2
      L5 = L2.txpower
      L5 = L5(L6)
      L4.txpower = L5
      L6 = L2
      L5 = L2.txpower_offset
      L5 = L5(L6)
      L4.txpoweroff = L5
      L6 = L2
      L5 = L2.get
      L7 = "key"
      L5 = L5(L6, L7)
      L4.key = L5
      L6 = L2
      L5 = L2.get
      L7 = "key1"
      L5 = L5(L6, L7)
      L4.key1 = L5
      L6 = L2
      L5 = L2.get
      L7 = "hidden"
      L5 = L5(L6, L7)
      L4.hidden = L5
      L6 = L2
      L5 = L2.txpwr
      L5 = L5(L6)
      L4.txpwr = L5
      L6 = L2
      L5 = L2.get
      L7 = "bsd"
      L5 = L5(L6, L7)
      L4.bsd = L5
      L6 = L2
      L5 = L2.disabled
      L5 = L5(L6)
      L4.disabled = L5
      L6 = L3
      L5 = L3.get
      L7 = "txbf"
      L5 = L5(L6, L7)
      L5 = L5 or L5
      L4.txbf = L5
      L6 = L3
      L5 = L3.get
      L7 = "ax"
      L5 = L5(L6, L7)
      L5 = L5 or L5
      L4.ax = L5
      L6 = L2
      L5 = L2.get
      L7 = "sae"
      L5 = L5(L6, L7)
      L5 = L5 or L5
      L4.sae = L5
      L6 = L2
      L5 = L2.get
      L7 = "sae_password"
      L5 = L5(L6, L7)
      L4.sae_password = L5
      L5 = {}
      L7 = L3
      L6 = L3.is_up
      L6 = L6(L7)
      L5.up = L6
      L7 = L3
      L6 = L3.name
      L6 = L6(L7)
      L5.device = L6
      L7 = L3
      L6 = L3.get_i18n
      L6 = L6(L7)
      L5.name = L6
      L4.device = L5
      return L4
    end
  end
  L3 = {}
  return L3
end
wifiNetwork = L33
function L33()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  for L5, L6 in L2, L3, L4 do
    L8 = L1
    L7 = L1.get_wifinet
    L9 = L6
    L7 = L7(L8, L9)
    if L7 then
      L9 = L7
      L8 = L7.ssid
      L8 = L8(L9)
      L0[L5] = L8
    end
  end
  return L2(L3)
end
getWifissid = L33
function L33()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = L0.exec
  L3 = "getmac wl1"
  L2 = L2(L3)
  L3 = L0.exec
  L4 = "getmac wl0"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  if 3 <= L4 then
    L4 = L0.exec
    L5 = "getmac wl2"
    L4 = L4(L5)
    L5 = L0.trim
    L6 = L2
    L5 = L5(L6)
    L6 = L0.trim
    L7 = L3
    L6 = L6(L7)
    L7 = L0.trim
    L8 = L4
    L7, L8 = L7(L8)
    return L5, L6, L7, L8
  else
    L4 = L0.trim
    L5 = L2
    L4 = L4(L5)
    L5 = L0.trim
    L6 = L3
    L5, L6, L7, L8 = L5(L6)
    return L4, L5, L6, L7, L8
  end
end
getWifiBssid = L33
function L33()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L0 = L0.isStrNil
  L1 = WIFIGUEST
  L0 = L0(L1)
  if not L0 then
    L0 = require
    L1 = "luci.util"
    L0 = L0(L1)
    L1 = "cat /sys/class/net/"
    L2 = WIFIGUEST
    L3 = "/address 2>/dev/null"
    L1 = L1 .. L2 .. L3
    L2 = L0.exec
    L3 = L1
    L2 = L2(L3)
    L3 = _UPVALUE0_
    L3 = L3.isStrNil
    L4 = L2
    L3 = L3(L4)
    if not L3 then
      L3 = L0.trim
      L4 = L2
      L3 = L3(L4)
      L2 = L3
      L3 = _UPVALUE0_
      L3 = L3.macFormat
      L4 = L2
      return L3(L4)
    end
  end
  L0 = nil
  return L0
end
getGuestWifiBssid = L33
function L33(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = pcall
  L2 = require
  L3 = "iwinfo"
  L1, L2 = L1(L2, L3)
  L3 = _wifiNameForIndex
  L4 = A0
  L3 = L3(L4)
  L4 = nil
  if L1 then
    L5 = L2.type
    L6 = L3 or L6
    if not L3 then
      L6 = ""
    end
    L5 = L5(L6)
    if L3 and L5 then
      L6 = L2[L5]
      if L6 then
        L6 = L2[L5]
        L6 = L6.freqlist
        L7 = L3
        L6 = L6(L7)
        L4 = L6
      end
    end
  end
  return L4
end
getChannels = L33
L33 = {}
L34 = {}
L34["20"] = "1"
L34["40"] = "1l"
L33["1"] = L34
L34 = {}
L34["20"] = "2"
L34["40"] = "2l"
L33["2"] = L34
L34 = {}
L34["20"] = "3"
L34["40"] = "3l"
L33["3"] = L34
L34 = {}
L34["20"] = "4"
L34["40"] = "4l"
L33["4"] = L34
L34 = {}
L34["20"] = "5"
L34["40"] = "5l"
L33["5"] = L34
L34 = {}
L34["20"] = "6"
L34["40"] = "6l"
L33["6"] = L34
L34 = {}
L34["20"] = "7"
L34["40"] = "7l"
L33["7"] = L34
L34 = {}
L34["20"] = "8"
L34["40"] = "8u"
L33["8"] = L34
L34 = {}
L34["20"] = "9"
L34["40"] = "9u"
L33["9"] = L34
L34 = {}
L34["20"] = "10"
L34["40"] = "10u"
L33["10"] = L34
L34 = {}
L34["20"] = "11"
L34["40"] = "11u"
L33["11"] = L34
L34 = {}
L34["20"] = "12"
L34["40"] = "12u"
L33["12"] = L34
L34 = {}
L34["20"] = "13"
L34["40"] = "13u"
L33["13"] = L34
L34 = {}
L35 = {}
L35["20"] = "36"
L35["40"] = "36l"
L35["80"] = "36/80"
L34["36"] = L35
L35 = {}
L35["20"] = "40"
L35["40"] = "40u"
L35["80"] = "40/80"
L34["40"] = L35
L35 = {}
L35["20"] = "44"
L35["40"] = "44l"
L35["80"] = "44/80"
L34["44"] = L35
L35 = {}
L35["20"] = "48"
L35["40"] = "48u"
L35["80"] = "48/80"
L34["48"] = L35
L35 = {}
L35["20"] = "52"
L35["40"] = "52l"
L35["80"] = "52/80"
L34["52"] = L35
L35 = {}
L35["20"] = "56"
L35["40"] = "56u"
L35["80"] = "56/80"
L34["56"] = L35
L35 = {}
L35["20"] = "60"
L35["40"] = "60l"
L35["80"] = "60/80"
L34["60"] = L35
L35 = {}
L35["20"] = "64"
L35["40"] = "64u"
L35["80"] = "64/80"
L34["64"] = L35
L35 = {}
L35["20"] = "149"
L35["40"] = "149l"
L35["80"] = "149/80"
L34["149"] = L35
L35 = {}
L35["20"] = "153"
L35["40"] = "153u"
L35["80"] = "153/80"
L34["153"] = L35
L35 = {}
L35["20"] = "157"
L35["40"] = "157l"
L35["80"] = "157/80"
L34["157"] = L35
L35 = {}
L35["20"] = "161"
L35["40"] = "161u"
L35["80"] = "161/80"
L34["161"] = L35
L35 = {}
L35["20"] = "165"
L34["165"] = L35
function L35(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = _UPVALUE0_
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = L3.isMeshSupportDFS
  L4 = L4()
  L5 = require
  L6 = "xiaoqiang.XQCountryCode"
  L5 = L5(L6)
  L6 = L5.getBDataCountryCode
  L6 = L6()
  L7 = _UPVALUE1_
  L7 = L7.isMeshMode
  L7 = L7()
  if L7 and not L4 then
    L2 = _UPVALUE2_
  end
  L2 = L2[L6]
  L7 = getGameWifiSupport
  L7 = L7()
  if L7 and 1 < A0 then
    if A0 == 3 then
      L7 = 2
      if L7 then
        goto lbl_33
        A0 = L7 or A0
      end
    end
    A0 = 3
  end
  ::lbl_33::
  if L2 then
    L7 = L2[A0]
    if L7 then
      goto lbl_40
    end
  end
  L7 = false
  do return L7 end
  ::lbl_40::
  L7 = nil
  L11 = " "
  L11, L12, L13 = L9(L10, L11)
  for L11, L12 in L8, L9, L10 do
    if L12 == A1 then
      L7 = L11
      break
    end
  end
  if L7 ~= nil then
    return L8
  else
    return L8
  end
end
verfiyChannelByWlIndex = L35
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "xiaoqiang.XQCountryCode"
  L1 = L1(L2)
  L2 = L1.getBDataCountryCode
  L2 = L2()
  L3 = {}
  L4 = nil
  L4 = L5[L2]
  if L5 and 1 < A0 then
    if A0 == 3 then
      if L5 then
        goto lbl_22
        A0 = L5 or A0
      end
    end
    A0 = 3
  end
  ::lbl_22::
  if nil ~= L4 then
    if nil ~= L5 then
      goto lbl_29
    end
  end
  do return L5 end
  ::lbl_29::
  L4 = L4[A0]
  L4 = L5
  for L8, L9 in L5, L6, L7 do
    L10 = tonumber
    L11 = L9
    L10 = L10(L11)
    L9 = L10
    L10 = {}
    L10.c = L9
    if L9 == 0 then
      if A0 == 1 then
        L11 = _UPVALUE2_
        L11 = L11[2]
        L10.b = L11
      elseif A0 == 2 then
        L11 = _UPVALUE2_
        L11 = L11[4]
        L10.b = L11
      elseif A0 == 3 then
        L11 = _UPVALUE2_
        L11 = L11[3]
        L10.b = L11
      end
    elseif L9 <= 13 then
      L11 = _UPVALUE2_
      L11 = L11[2]
      L10.b = L11
    elseif L9 == 165 then
      L11 = _UPVALUE2_
      L11 = L11[1]
      L10.b = L11
    elseif 149 <= L9 and L9 <= 161 then
      L11 = _UPVALUE2_
      L11 = L11[3]
      L10.b = L11
    elseif 140 <= L9 and L9 <= 144 then
      L11 = _UPVALUE2_
      L11 = L11[1]
      L10.b = L11
    elseif 132 <= L9 and L9 <= 136 then
      L11 = _UPVALUE2_
      L11 = L11[2]
      L10.b = L11
    elseif 36 <= L9 and L9 <= 128 then
      L11 = _UPVALUE2_
      L11 = L11[4]
      L10.b = L11
    else
      L11 = _UPVALUE2_
      L11 = L11[4]
      L10.b = L11
    end
    L11 = table
    L11 = L11.insert
    L12 = L3
    L13 = L10
    L11(L12, L13)
  end
  return L3
end
getDefaultWifiChannels = L35
function L35()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = {}
  L4 = {}
  L5 = nil
  L7 = L0
  L6 = L0.get
  L8 = "misc"
  L9 = "wireless"
  L10 = "ifname_2G"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L8 = L0
  L7 = L0.get
  L9 = "misc"
  L10 = "wireless"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L9 = L0
  L8 = L0.get
  L10 = "misc"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L9 = string
  L9 = L9.len
  L10 = L6
  L9 = L9(L10)
  if 0 < L9 then
    L9 = table
    L9 = L9.insert
    L10 = L3
    L9(L10, L11)
  end
  L9 = string
  L9 = L9.len
  L10 = L7
  L9 = L9(L10)
  if 0 < L9 then
    L9 = table
    L9 = L9.insert
    L10 = L3
    L9(L10, L11)
  end
  L9 = string
  L9 = L9.len
  L10 = L8
  L9 = L9(L10)
  if 0 < L9 then
    L9 = table
    L9 = L9.insert
    L10 = L3
    L9(L10, L11)
  end
  L9 = pcall
  L10 = require
  L9, L10 = L9(L10, L11)
  if not L9 then
    return L4
  end
  for L14, L15 in L11, L12, L13 do
    L16 = L10.type
    if not L15 then
    end
    L16 = L16(L17)
    if L15 and L16 then
      if L17 then
        L5 = L17
      end
    end
    if not L5 then
      return L4
    end
    for L20, L21 in L17, L18, L19 do
      L22 = {}
      if L20 and L21 then
        L23 = string
        L23 = L23.lower
        L24 = tostring
        L25 = L20
        L24, L25 = L24(L25)
        L23 = L23(L24, L25)
        L20 = L23
        L22.mac = L20
        L23 = table
        L23 = L23.insert
        L24 = L4
        L25 = L22
        L23(L24, L25)
      end
    end
  end
  return L4
end
getWifiAllDeviceMacList = L35
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = {}
  L3 = tonumber
  L3 = L3(L4)
  if L3 == 1 then
    L3 = getWifiStatus
    L3 = L3(L4)
    L3 = L3.up
    L1 = L3 == 1
    L3 = wifiNetwork
    L7, L8, L9, L10, L11, L12 = L4(L5)
    L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12)
    L3 = L3.assoclist
    L2 = L3 or L2
    if not L3 then
      L3 = {}
      L2 = L3
    end
  else
    L3 = getWifiStatus
    L3 = L3(L4)
    L3 = L3.up
    L1 = L3 == 1
    L3 = wifiNetwork
    L7, L8, L9, L10, L11, L12 = L4(L5)
    L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12)
    L3 = L3.assoclist
    L2 = L3 or L2
    if not L3 then
      L3 = {}
      L2 = L3
    end
  end
  L3 = {}
  if L1 then
    for L7, L8 in L4, L5, L6 do
      L9 = table
      L9 = L9.insert
      L10 = L3
      L11 = _UPVALUE0_
      L11 = L11.macFormat
      L12 = L7
      L11, L12 = L11(L12)
      L9(L10, L11, L12)
    end
  end
  return L3
end
getWifiConnectDeviceList = L35
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L2 = _UPVALUE1_
  L2 = L2[A0]
  if not L2 then
    L2 = 0
    return L2
  end
  L3 = L1
  L2 = L1.get_wifinet
  L4 = _UPVALUE1_
  L4 = L4[A0]
  L2 = L2(L3, L4)
  if not L2 then
    L3 = 0
    return L3
  end
  L3 = 0
  L4 = L2.assoclist
  L4 = L4(L5)
  L4 = L4 or L4
  for L8, L9 in L5, L6, L7 do
    L3 = L3 + 1
  end
  return L3
end
get_wl_con_dev_num = L35
function L35(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  end
  L2 = A0
  L1 = A0.match
  L3 = "l"
  L1 = L1(L2, L3)
  if L1 then
    L2 = A0
    L1 = A0.gsub
    L3 = "l"
    L4 = ""
    L1 = L1(L2, L3, L4)
    L2 = "(40M)"
    L1 = L1 .. L2
    return L1
  end
  L2 = A0
  L1 = A0.match
  L3 = "u"
  L1 = L1(L2, L3)
  if L1 then
    L2 = A0
    L1 = A0.gsub
    L3 = "u"
    L4 = ""
    L1 = L1(L2, L3, L4)
    L2 = "(40M)"
    L1 = L1 .. L2
    return L1
  end
  L2 = A0
  L1 = A0.match
  L3 = "/80"
  L1 = L1(L2, L3)
  if L1 then
    L2 = A0
    L1 = A0.gsub
    L3 = "/80"
    L4 = ""
    L1 = L1(L2, L3, L4)
    L2 = "(80M)"
    L1 = L1 .. L2
    return L1
  end
  L1 = A0
  L2 = "(20M)"
  L1 = L1 .. L2
  return L1
end
_pauseChannel = L35
function L35(A0)
  local L1, L2, L3, L4
  L1 = ""
  L2 = tonumber
  L3 = A0
  L2 = L2(L3)
  if L2 == 1 then
    L2 = _UPVALUE0_
    L2 = L2.trim
    L3 = _UPVALUE0_
    L3 = L3.exec
    L4 = "iwlist wl1 channel | awk -F '[ )]+' '/Current Frequency/{print $6}'"
    L3, L4 = L3(L4)
    L2 = L2(L3, L4)
    L1 = L2
  else
    L2 = _UPVALUE0_
    L2 = L2.trim
    L3 = _UPVALUE0_
    L3 = L3.exec
    L4 = "iwlist wl0 channel | awk -F '[ )]+' '/Current Frequency/{print $6}'"
    L3, L4 = L3(L4)
    L2 = L2(L3, L4)
    L1 = L2
  end
  L2 = _pauseChannel
  L3 = L1
  return L2(L3)
end
getWifiWorkChannel = L35
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = string
  L1 = L1.lower
  L1 = L1(L2)
  A0 = L1
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  for L5, L6 in L2, L3, L4 do
    L7 = L1.get_wifinet
    L7 = L7(L8, L9)
    if L8 then
      assoclist = L8
      for L11, L12 in L8, L9, L10 do
        L13 = string
        L13 = L13.lower
        L14 = L11
        L13 = L13(L14)
        if A0 == L13 then
          return L5
        end
      end
    end
  end
  return L2
end
getDeviceWifiIndex = L35
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = {}
  L2 = {}
  if L3 ~= 1 then
    return L1
  end
  if A0 == 1 then
    L6, L7, L8, L9, L10, L11, L12 = L4(L5)
    L2 = L3 or L2
    if not L3 then
      L2 = L3
    end
  else
    L6, L7, L8, L9, L10, L11, L12 = L4(L5)
    L2 = L3 or L2
    if not L3 then
      L2 = L3
    end
  end
  for L6, L7 in L3, L4, L5 do
    if L6 then
      L8 = _UPVALUE0_
      L8 = L8.macFormat
      L9 = L6
      L8 = L8(L9)
      L9 = math
      L9 = L9.abs
      L10 = tonumber
      L11 = L7.signal
      L10 = L10(L11)
      L11 = tonumber
      L12 = L7.noise
      L11 = L11(L12)
      L10 = L10 - L11
      L9 = L9(L10)
      L9 = 2 * L9
      L1[L8] = L9
    end
  end
  return L1
end
getWifiDeviceSignalDict = L35
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = wifiNetwork
  L6, L7, L8 = L2(L3)
  L1 = L1(L2, L3, L4, L5, L6, L7, L8)
  L1 = L1.assoclist
  L1 = L1 or L1
  for L5, L6 in L2, L3, L4 do
    if A0 == L5 then
      L7 = L6.signal
      return L7
    end
  end
  L6, L7, L8 = L3(L4)
  for L6, L7 in L3, L4, L5 do
    if A0 == L6 then
      L8 = L7.signal
      return L8
    end
  end
  return L3
end
getWifiDeviceSignal = L35
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L2 = L2(L3)
  if L2 then
    L2 = nil
    return L2
  end
  L2 = wifiNetwork
  L7, L8, L9 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9)
  L2 = L2.assoclist
  L2 = L2 or L2
  for L6, L7 in L3, L4, L5 do
    if A0 == L6 then
      L8 = L7.rx_rate
      L1.upspeed = L8
      L8 = L7.tx_rate
      L1.downspeed = L8
      return L1
    end
  end
  L7, L8, L9 = L4(L5)
  for L7, L8 in L4, L5, L6 do
    if A0 == L7 then
      L9 = L8.rx_rate
      L1.upspeed = L9
      L9 = L8.tx_rate
      L1.downspeed = L9
      return L1
    end
  end
  return L4
end
getWifiDeviceSpeed = L35
function L35()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = {}
  for L4 = L1, L2, L3 do
    L5 = getWifiDeviceSignalDict
    L6 = L4
    L5 = L5(L6)
    L6 = getWifiConnectDeviceList
    L6 = L6(L7)
    for L10, L11 in L7, L8, L9 do
      L12 = table
      L12 = L12.insert
      L13 = L0
      L14 = {}
      L15 = _UPVALUE0_
      L15 = L15.macFormat
      L16 = L11
      L15 = L15(L16)
      L14.mac = L15
      L15 = L5[L11]
      L14.signal = L15
      L14.wifiIndex = L4
      L12(L13, L14)
    end
  end
  return L0
end
getAllWifiConnetDeviceList = L35
function L35()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = {}
  for L4 = L1, L2, L3 do
    L5 = getWifiDeviceSignalDict
    L6 = L4
    L5 = L5(L6)
    L6 = getWifiConnectDeviceList
    L6 = L6(L7)
    for L10, L11 in L7, L8, L9 do
      L12 = {}
      L13 = L5[L11]
      L12.signal = L13
      L12.wifiIndex = L4
      L13 = _UPVALUE0_
      L13 = L13.macFormat
      L14 = L11
      L13 = L13(L14)
      L0[L13] = L12
    end
  end
  return L0
end
getAllWifiConnetDeviceDict = L35
function L35(A0)
  local L1, L2, L3
  L1 = wifiNetwork
  L2 = _wifiNameForIndex
  L3 = A0
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  L2 = {}
  L3 = L1.ssid
  L2.ssid = L3
  L3 = L1.up
  if L3 then
    L3 = 1
    if L3 then
      goto lbl_16
    end
  end
  L3 = 0
  ::lbl_16::
  L2.up = L3
  return L2
end
getWifiStatus = L35
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = {}
  L1.channel = ""
  L1.bandwidth = ""
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    return L1
  end
  L2 = string
  L2 = L2.find
  L3 = A0
  L2 = L2(L3, L4)
  if L2 ~= nil then
    L3 = A0
    L2 = A0.match
    L2 = L2(L3, L4)
    L1.channel = L2
    L1.bandwidth = "40"
  else
    L2 = string
    L2 = L2.find
    L3 = A0
    L2 = L2(L3, L4)
    if L2 ~= nil then
      L3 = A0
      L2 = A0.match
      L2 = L2(L3, L4)
      L1.channel = L2
      L1.bandwidth = "40"
    else
      L2 = string
      L2 = L2.find
      L3 = A0
      L2 = L2(L3, L4)
      if L2 ~= nil then
        L3 = A0
        L2 = A0.match
        L2 = L2(L3, L4)
        L1.channel = L2
        L1.bandwidth = "80"
      else
        L2 = tostring
        L3 = A0
        L2 = L2(L3)
        L1.channel = L2
        L1.bandwidth = "20"
      end
    end
  end
  L2 = {}
  L3 = L1.channel
  if L3 then
    L3 = _UPVALUE1_
    L3 = L3[L4]
    if not L3 then
      L3 = _UPVALUE2_
      L3 = L3[L4]
    end
    if L3 then
      if L4 == "table" then
        for L7, L8 in L4, L5, L6 do
          L9 = table
          L9 = L9.insert
          L10 = L2
          L11 = L7
          L9(L10, L11)
        end
      end
    end
  end
  L1.bandList = L2
  return L1
end
channelHelper = L35
function L35(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = {}
  L2.channel = ""
  L2.bandwidth = ""
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    return L2
  end
  L3 = {}
  L4 = nil
  for L8, L9 in L5, L6, L7 do
    if L9 == A1 then
      L10 = getDefaultWifiChannels
      L11 = L8
      L10 = L10(L11)
      L4 = L10
    end
  end
  if L4 then
    for L8, L9 in L5, L6, L7 do
      if L9 then
        L10 = tonumber
        L11 = L9.c
        L10 = L10(L11)
        L11 = tonumber
        L12 = A0
        L11 = L11(L12)
        if L10 == L11 then
          L3 = L9.b
          break
        end
      end
    end
  end
  L2.bandList = L3
  return L2
end
getBandList = L35
function L35(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  end
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "l"
  L4 = ""
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "u"
  L4 = ""
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "/80"
  L4 = ""
  L1 = L1(L2, L3, L4)
  A0 = L1
  return A0
end
_channelFix = L35
function L35(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = {}
  L4 = tonumber
  L5 = A0
  L4 = L4(L5)
  if L4 == 1 then
    L4 = _UPVALUE0_
    L5 = tostring
    L6 = A1
    L5 = L5(L6)
    L3 = L4[L5]
  else
    L4 = _UPVALUE1_
    L5 = tostring
    L6 = A1
    L5 = L5(L6)
    L3 = L4[L5]
  end
  if L3 then
    L4 = type
    L5 = L3
    L4 = L4(L5)
    if L4 == "table" then
      L4 = tostring
      L5 = A2
      L4 = L4(L5)
      L4 = L3[L4]
      L5 = _UPVALUE2_
      L5 = L5.isStrNil
      L6 = L4
      L5 = L5(L6)
      if not L5 then
        return L4
      end
    end
  end
  L4 = false
  return L4
end
channelFormat = L35
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = {}
  L2 = "`~!@#$%^&*()_-+={}[]:;\"<>?/.,"
  L3 = A0 - 2
  for L7 = L4, L5, L6 do
    L8 = #L1
    L8 = L8 + 1
    L9 = tostring
    L10 = L7
    L9 = L9(L10)
    L1[L8] = L9
  end
  for L7 = L4, L5, L6 do
    L8 = #L1
    L8 = L8 + 1
    L9 = string
    L9 = L9.char
    L10 = L7
    L9 = L9(L10)
    L1[L8] = L9
  end
  for L7 = L4, L5, L6 do
    L8 = #L1
    L8 = L8 + 1
    L9 = string
    L9 = L9.char
    L10 = L7
    L9 = L9(L10)
    L1[L8] = L9
  end
  for L7 = L4, L5, L6 do
    L8 = #L1
    L8 = L8 + 1
    L9 = string
    L9 = L9.sub
    L10 = L2
    L11 = L7
    L12 = L7
    L9 = L9(L10, L11, L12)
    L1[L8] = L9
  end
  L8, L9, L10, L11, L12 = L6()
  L5(L6, L7, L8, L9, L10, L11, L12)
  for L8 = L5, L6, L7 do
    L9 = math
    L9 = L9.random
    L10 = 1
    L11 = #L1
    L9 = L9(L10, L11)
    L10 = L4
    L11 = L1[L9]
  end
  L8 = #L2
  L8 = string
  L8 = L8.sub
  L9 = L2
  L10 = L5
  L11 = L5
  L8 = L8(L9, L10, L11)
  L8 = string
  L8 = L8.sub
  L9 = L2
  L10 = L6
  L11 = L6
  L8 = L8(L9, L10, L11)
  return L4
end
function L36(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = string
  L1 = L1.len
  L1 = L1(L2)
  for L5 = L2, L3, L4 do
    L6 = string
    L6 = L6.byte
    L7 = A0
    L8 = L5
    L6 = L6(L7, L8)
    if 127 < L6 then
      L7 = true
      return L7
    end
  end
  return L2
end
function L37(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2, L3, L4, L5 = nil, nil, nil, nil
  if A0 == "2G" then
    L7 = L1
    L6 = L1.get
    L8 = "misc"
    L9 = "wireless"
    L10 = "ifname_2G"
    L6 = L6(L7, L8, L9, L10)
    L2 = L6
  elseif A0 == "5G" then
    L7 = L1
    L6 = L1.get
    L8 = "misc"
    L9 = "wireless"
    L10 = "ifname_5G"
    L6 = L6(L7, L8, L9, L10)
    L2 = L6
  else
    L6, L7 = nil, nil
    return L6, L7
  end
  L7 = L1
  L6 = L1.foreach
  L8 = "wireless"
  L9 = "wifi-iface"
  function L10(A0)
    local L1, L2
    L1 = A0.ifname
    L2 = _UPVALUE0_
    if L1 == L2 then
      L1 = A0.ssid
      _UPVALUE1_ = L1
      L1 = A0.encryption
      _UPVALUE2_ = L1
      L1 = _UPVALUE2_
      if L1 ~= "ccmp" then
        L1 = _UPVALUE2_
        if L1 ~= "psk2+ccmp" then
          goto lbl_18
        end
      end
      L1 = A0.sae_password
      _UPVALUE3_ = L1
      goto lbl_23
      ::lbl_18::
      L1 = _UPVALUE2_
      if L1 ~= "none" then
        L1 = A0.key
        _UPVALUE3_ = L1
      end
    end
    ::lbl_23::
  end
  L6(L7, L8, L9, L10)
  L6 = nil
  L7 = L3
  L8 = _UPVALUE0_
  L9 = L3
  L8 = L8(L9)
  if L8 then
    L9 = L1
    L8 = L1.get
    L10 = "misc"
    L11 = "hardware"
    L12 = "model"
    L8 = L8(L9, L10, L11, L12)
    L7 = L8
  end
  if A0 == "2G" then
    L8 = L7
    L9 = "_IoT"
    L6 = L8 .. L9
    L8 = string
    L8 = L8.len
    L9 = L6
    L8 = L8(L9)
    if 31 < L8 then
      L8 = string
      L8 = L8.sub
      L9 = L7
      L10 = 1
      L11 = #L7
      L12 = string
      L12 = L12.len
      L13 = L7
      L12 = L12(L13)
      L12 = L12 - 27
      L11 = L11 - L12
      L8 = L8(L9, L10, L11)
      L7 = L8
      L8 = L7
      L9 = "_IoT"
      L6 = L8 .. L9
    end
  elseif A0 == "5G" then
    L8 = L7
    L9 = "_IoT_5G"
    L6 = L8 .. L9
    L8 = string
    L8 = L8.len
    L9 = L6
    L8 = L8(L9)
    if 31 < L8 then
      L8 = string
      L8 = L8.sub
      L9 = L7
      L10 = 1
      L11 = #L7
      L12 = string
      L12 = L12.len
      L13 = L7
      L12 = L12(L13)
      L12 = L12 - 24
      L11 = L11 - L12
      L8 = L8(L9, L10, L11)
      L7 = L8
      L8 = L7
      L9 = "_IoT_5G"
      L6 = L8 .. L9
    end
  end
  L8 = nil
  if L4 == "none" then
    L9 = _UPVALUE1_
    L10 = 8
    L9 = L9(L10)
    L8 = L9
  else
    L9 = L5
    L10 = L5
    L11 = "iot"
    L8 = L10 .. L11
    L10 = string
    L10 = L10.len
    L11 = L8
    L10 = L10(L11)
    if 63 < L10 then
      L10 = string
      L10 = L10.sub
      L11 = L9
      L12 = 1
      L13 = #L9
      L14 = string
      L14 = L14.len
      L15 = L9
      L14 = L14(L15)
      L14 = L14 - 60
      L13 = L13 - L14
      L10 = L10(L11, L12, L13)
      L9 = L10
      L10 = L9
      L11 = "iot"
      L8 = L10 .. L11
    end
  end
  L9 = L6
  L10 = L8
  return L9, L10
end
function L38()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "features"
  L5 = "iot_dev"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = {}
  L3 = {}
  L4 = {}
  L5 = {}
  L6 = {}
  L7 = tonumber
  L8 = L1
  L7 = L7(L8)
  if L7 == 1 then
    L8 = L0
    L7 = L0.get
    L9 = "wireless"
    L10 = "iot_2g"
    L11 = "ssid"
    L7 = L7(L8, L9, L10, L11)
    L7 = L7 or L7
    L9 = L0
    L8 = L0.get
    L10 = "wireless"
    L11 = "iot_2g"
    L12 = "disabled"
    L8 = L8(L9, L10, L11, L12)
    L8 = L8 or L8
    L10 = L0
    L9 = L0.get
    L11 = "wireless"
    L12 = "iot_2g"
    L13 = "encryption"
    L9 = L9(L10, L11, L12, L13)
    L5.encryption = L9
    if L7 == nil then
      L9 = _UPVALUE0_
      L10 = "2G"
      L9, L10 = L9(L10)
      L11 = _UPVALUE1_
      L11 = L11.encode4HtmlValue
      L12 = L9
      L11 = L11(L12)
      L5.ssid = L11
      L5.password = L10
    else
      L9 = _UPVALUE1_
      L9 = L9.encode4HtmlValue
      L10 = L7
      L9 = L9(L10)
      L5.ssid = L9
      L9 = L5.encryption
      if L9 == "none" then
        L9 = _UPVALUE0_
        L10 = "2G"
        L9, L10 = L9(L10)
        L5.password = L10
        _ = L9
      else
        L9 = L5.encryption
        if L9 ~= "ccmp" then
          L9 = L5.encryption
          if L9 ~= "psk2+ccmp" then
            goto lbl_85
          end
        end
        L10 = L0
        L9 = L0.get
        L11 = "wireless"
        L12 = "iot_2g"
        L13 = "sae_password"
        L9 = L9(L10, L11, L12, L13)
        L5.password = L9
        goto lbl_91
        ::lbl_85::
        L10 = L0
        L9 = L0.get
        L11 = "wireless"
        L12 = "iot_2g"
        L13 = "key"
        L9 = L9(L10, L11, L12, L13)
        L5.password = L9
      end
    end
    ::lbl_91::
    L5.ssidHtmlEncode = 1
    L10 = L0
    L9 = L0.get
    L11 = "wireless"
    L12 = "iot_5g"
    L13 = "ssid"
    L9 = L9(L10, L11, L12, L13)
    L9 = L9 or L9
    L11 = L0
    L10 = L0.get
    L12 = "wireless"
    L13 = "iot_5g"
    L14 = "encryption"
    L10 = L10(L11, L12, L13, L14)
    L6.encryption = L10
    if L9 == nil then
      L10 = _UPVALUE0_
      L11 = "5G"
      L10, L11 = L10(L11)
      L12 = _UPVALUE1_
      L12 = L12.encode4HtmlValue
      L13 = L10
      L12 = L12(L13)
      L6.ssid = L12
      L6.password = L11
    else
      L10 = _UPVALUE1_
      L10 = L10.encode4HtmlValue
      L11 = L9
      L10 = L10(L11)
      L6.ssid = L10
      L10 = L6.encryption
      if L10 == "none" then
        L10 = _UPVALUE0_
        L11 = "5G"
        L10, L11 = L10(L11)
        L6.password = L11
        _ = L10
      else
        L10 = L6.encryption
        if L10 ~= "ccmp" then
          L10 = L6.encryption
          if L10 ~= "psk2+ccmp" then
            goto lbl_145
          end
        end
        L11 = L0
        L10 = L0.get
        L12 = "wireless"
        L13 = "iot_5g"
        L14 = "sae_password"
        L10 = L10(L11, L12, L13, L14)
        L6.password = L10
        goto lbl_151
        ::lbl_145::
        L11 = L0
        L10 = L0.get
        L12 = "wireless"
        L13 = "iot_5g"
        L14 = "key"
        L10 = L10(L11, L12, L13, L14)
        L6.password = L10
      end
    end
    ::lbl_151::
    L6.ssidHtmlEncode = 1
    L10 = table
    L10 = L10.insert
    L11 = L3
    L12 = L5
    L10(L11, L12)
    L10 = table
    L10 = L10.insert
    L11 = L3
    L12 = L6
    L10(L11, L12)
    L2.basicInfo = L3
    L10 = tonumber
    L12 = L0
    L11 = L0.get
    L13 = "wireless"
    L14 = "iot_2g"
    L15 = "iotwifi5mode"
    L11, L12, L13, L14, L15 = L11(L12, L13, L14, L15)
    L10 = L10(L11, L12, L13, L14, L15)
    L4.wifi5mode = L10
    L11 = L0
    L10 = L0.get
    L12 = "wireless"
    L13 = "miot_2G"
    L14 = "miot_access_iotdev"
    L10 = L10(L11, L12, L13, L14)
    L10 = L10 or L10
    L4.high_priority_access = L10
    L10 = tonumber
    L12 = L0
    L11 = L0.get
    L13 = "wireless"
    L14 = "wifi0"
    L15 = "ax"
    L11, L12, L13, L14, L15 = L11(L12, L13, L14, L15)
    L10 = L10(L11, L12, L13, L14, L15)
    L10 = L10 or L10
    L4.ax = L10
    L10 = tonumber
    L11 = L8
    L10 = L10(L11)
    if L10 == 1 then
      L4.enable = 0
    else
      L4.enable = 1
    end
    L2.advanceInfo = L4
    return L2
  else
    L7 = nil
    return L7
  end
end
getIotWifiDeviceInfo = L38
function L38()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = {}
  L1 = {}
  L2 = wifiNetworks
  L2 = L2()
  for L6, L7 in L3, L4, L5 do
    L8 = {}
    L9 = 1
    L10 = L7.networks
    L10 = L10[L9]
    L10 = L10.cchannel
    if L10 == "auto" then
      L10 = "0"
    end
    L8.channel = L10
    L8.bandwidth = L11
    L8.channelInfo = L11
    for L14, L15 in L11, L12, L13 do
      L16 = L7.device
      if L15 == L16 then
        L16 = getDefaultWifiChannels
        L17 = L14
        L16 = L16(L17)
        L8.available_channels = L16
      end
    end
    L11(L12, L13)
    L11(L12, L13)
    L8.ssid = L11
    L8.ssidHtmlEncode = 1
    if L11 == "1" then
      L8.status = "0"
      L11.channel = L12
      L11.bandwidth = L12
    else
      L8.status = "1"
      L11.channel = L12
      L11.bandwidth = L12
    end
    if L11 == "wep-open" then
      L14 = L12
      if 4 < L13 then
        L14 = L12
        L15 = 0
        L16 = 2
        if L13 == "s:" then
          L14 = L12
          L15 = 3
        end
      end
    elseif L11 == "ccmp" then
    end
    L8.ifname = L13
    L14 = ".network"
    L15 = L9
    L8.device = L13
    L8.mode = L13
    L8.hidden = L13
    L8.signal = L13
    L14 = L12
    L8.password = L13
    L8.encryption = L11
    if L13 == "nil" then
      L8.txpwr = "max"
    else
      L8.txpwr = L13
    end
    L8.bsd = L13
    L8.txbf = L13
    L8.ax = L13
    L8.weakenable = L13
    L8.weakthreshold = L13
    L8.kickthreshold = L13
    L1[L13] = L8
  end
  for L6, L7 in L3, L4, L5 do
    L8 = table
    L8 = L8.insert
    L9 = L0
    L10 = L1[L7]
    L8(L9, L10)
  end
  return L0
end
getAllWifiInfo = L38
function L38()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = {}
  L1 = {}
  L2 = wifiNetworks
  L2 = L2()
  for L6, L7 in L3, L4, L5 do
    L8 = {}
    L9 = 1
    L10 = L7.networks
    L10 = L10[L9]
    L10 = L10.cchannel
    L8.channel = L10
    L11 = L7.networks
    L11 = L11[L9]
    L11 = L11.cbw
    L8.bandwidth = L11
    L11 = getBandList
    L12 = L10
    L13 = L7.networks
    L13 = L13[L9]
    L13 = L13.ifname
    L11 = L11(L12, L13)
    L8.channelInfo = L11
    L11 = L7.up
    if L11 then
      L8.status = "1"
      L11 = _UPVALUE0_
      L11 = L11.encode4HtmlValue
      L12 = L7.networks
      L12 = L12[L9]
      L12 = L12.ssid
      L11 = L11(L12)
      L8.ssid = L11
      L11 = L8.channelInfo
      L12 = L7.networks
      L12 = L12[L9]
      L12 = L12.channel
      L11.channel = L12
      L11 = L8.channelInfo
      L12 = L7.networks
      L12 = L12[L9]
      L12 = L12.bw
      L11.bandwidth = L12
    else
      L8.status = "0"
      L11 = _UPVALUE0_
      L11 = L11.encode4HtmlValue
      L12 = L7.networks
      L12 = L12[L9]
      L12 = L12.cssid
      L11 = L11(L12)
      L8.ssid = L11
      L11 = L8.channelInfo
      L12 = L7.networks
      L12 = L12[L9]
      L12 = L12.cchannel
      L11.channel = L12
      L11 = L8.channelInfo
      L12 = L7.networks
      L12 = L12[L9]
      L12 = L12.cbw
      L11.bandwidth = L12
    end
    L8.ssidHtmlEncode = 1
    L11 = L7.networks
    L11 = L11[L9]
    L11 = L11.encryption_src
    L12 = L7.networks
    L12 = L12[L9]
    L12 = L12.key
    if L11 == "wep-open" then
      L13 = L7.networks
      L13 = L13[L9]
      L12 = L13.key1
      L14 = L12
      L13 = L12.len
      L13 = L13(L14)
      if 4 < L13 then
        L14 = L12
        L13 = L12.sub
        L15 = 0
        L16 = 2
        L13 = L13(L14, L15, L16)
        if L13 == "s:" then
          L14 = L12
          L13 = L12.sub
          L15 = 3
          L13 = L13(L14, L15)
          L12 = L13
        end
      end
    elseif L11 == "ccmp" then
      L13 = L7.networks
      L13 = L13[L9]
      L12 = L13.sae_password
    end
    L13 = L7.networks
    L13 = L13[L9]
    L13 = L13.ifname
    L8.ifname = L13
    L13 = L7.device
    L14 = ".network"
    L15 = L9
    L13 = L13 .. L14 .. L15
    L8.device = L13
    L13 = L7.networks
    L13 = L13[L9]
    L13 = L13.mode
    L8.mode = L13
    L13 = L7.networks
    L13 = L13[L9]
    L13 = L13.hidden
    L13 = L13 or L13
    L8.hidden = L13
    L13 = L7.networks
    L13 = L13[L9]
    L13 = L13.signal
    L8.signal = L13
    L13 = _UPVALUE0_
    L13 = L13.encode4HtmlValue
    L14 = L12
    L13 = L13(L14)
    L8.password = L13
    L8.encryption = L11
    L13 = L7.networks
    L13 = L13[L9]
    L13 = L13.txpwr
    if L13 == "nil" then
      L8.txpwr = "max"
    else
      L13 = L7.networks
      L13 = L13[L9]
      L13 = L13.txpwr
      L13 = L13 or L13
      L8.txpwr = L13
    end
    L13 = L7.networks
    L13 = L13[L9]
    L13 = L13.bsd
    L8.bsd = L13
    L13 = L7.networks
    L13 = L13[L9]
    L13 = L13.txbf
    L8.txbf = L13
    L13 = L7.networks
    L13 = L13[L9]
    L13 = L13.ax
    L8.ax = L13
    L13 = L7.device
    L1[L13] = L8
  end
  if L3 then
    L3.iftype = 1
    L3(L4, L5)
  end
  if L3 then
    L3.iftype = 2
    L3(L4, L5)
  end
  if L3 then
    if L4 == 0 then
      L3.iftype = 3
      L6 = L3
      L4(L5, L6)
    end
  end
  return L0
end
getDiagAllWifiInfo = L38
function L38(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_wifinet
  L4 = _wifiNameForIndex
  L5 = A0
  L4, L5 = L4(L5)
  L2 = L2(L3, L4, L5)
  if L2 then
    L3 = tostring
    L5 = L2
    L4 = L2.txpwr
    L4, L5 = L4(L5)
    return L3(L4, L5)
  else
    L3 = nil
    return L3
  end
end
getWifiTxpwr = L38
function L38(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_wifinet
  L4 = _wifiNameForIndex
  L5 = A0
  L4, L5 = L4(L5)
  L2 = L2(L3, L4, L5)
  if L2 then
    L3 = tostring
    L5 = L2
    L4 = L2.channel
    L4, L5 = L4(L5)
    return L3(L4, L5)
  else
    L3 = nil
    return L3
  end
end
getWifiChannel = L38
function L38()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_wifinet
  L4 = _wifiNameForIndex
  L5 = 1
  L4, L5, L6, L7, L8 = L4(L5)
  L2 = L2(L3, L4, L5, L6, L7, L8)
  L4 = L1
  L3 = L1.get_wifinet
  L5 = _wifiNameForIndex
  L6 = 2
  L5, L6, L7, L8 = L5(L6)
  L3 = L3(L4, L5, L6, L7, L8)
  if L2 then
    L4 = table
    L4 = L4.insert
    L5 = L0
    L6 = tostring
    L8 = L2
    L7 = L2.txpwr
    L7, L8 = L7(L8)
    L6, L7, L8 = L6(L7, L8)
    L4(L5, L6, L7, L8)
  end
  if L3 then
    L4 = table
    L4 = L4.insert
    L5 = L0
    L6 = tostring
    L8 = L3
    L7 = L3.txpwr
    L7, L8 = L7(L8)
    L6, L7, L8 = L6(L7, L8)
    L4(L5, L6, L7, L8)
  end
  return L0
end
getWifiTxpwrList = L38
function L38()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_wifinet
  L4 = _wifiNameForIndex
  L5 = 1
  L4, L5, L6, L7, L8 = L4(L5)
  L2 = L2(L3, L4, L5, L6, L7, L8)
  L4 = L1
  L3 = L1.get_wifinet
  L5 = _wifiNameForIndex
  L6 = 2
  L5, L6, L7, L8 = L5(L6)
  L3 = L3(L4, L5, L6, L7, L8)
  if L2 then
    L4 = table
    L4 = L4.insert
    L5 = L0
    L6 = tostring
    L8 = L2
    L7 = L2.channel
    L7, L8 = L7(L8)
    L6, L7, L8 = L6(L7, L8)
    L4(L5, L6, L7, L8)
  end
  if L3 then
    L4 = table
    L4 = L4.insert
    L5 = L0
    L6 = tostring
    L8 = L3
    L7 = L3.channel
    L7, L8 = L7(L8)
    L6, L7, L8 = L6(L7, L8)
    L4(L5, L6, L7, L8)
  end
  return L0
end
getWifiChannelList = L38
function L38()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = {}
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_wifinet
  L4 = _wifiNameForIndex
  L5 = 1
  L4, L5, L6, L7, L8, L9 = L4(L5)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9)
  L4 = L1
  L3 = L1.get_wifinet
  L5 = _wifiNameForIndex
  L6 = 2
  L5, L6, L7, L8, L9 = L5(L6)
  L3 = L3(L4, L5, L6, L7, L8, L9)
  if L2 then
    L4 = table
    L4 = L4.insert
    L5 = L0
    L6 = {}
    L7 = tostring
    L9 = L2
    L8 = L2.channel
    L8, L9 = L8(L9)
    L7 = L7(L8, L9)
    L6.channel = L7
    L7 = tostring
    L9 = L2
    L8 = L2.txpwr
    L8, L9 = L8(L9)
    L7 = L7(L8, L9)
    L6.txpwr = L7
    L4(L5, L6)
  else
    L4 = table
    L4 = L4.insert
    L5 = L0
    L6 = {}
    L4(L5, L6)
  end
  if L3 then
    L4 = table
    L4 = L4.insert
    L5 = L0
    L6 = {}
    L7 = tostring
    L9 = L3
    L8 = L3.channel
    L8, L9 = L8(L9)
    L7 = L7(L8, L9)
    L6.channel = L7
    L7 = tostring
    L9 = L3
    L8 = L3.txpwr
    L8, L9 = L8(L9)
    L7 = L7(L8, L9)
    L6.txpwr = L7
    L4(L5, L6)
  else
    L4 = table
    L4 = L4.insert
    L5 = L0
    L6 = {}
    L4(L5, L6)
  end
  return L0
end
getWifiChannelTxpwrList = L38
function L38(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10
  L4 = _UPVALUE0_
  L4 = L4.init
  L4 = L4()
  L6 = L4
  L5 = L4.get_wifidev
  L7 = _UPVALUE1_
  L7 = L7.split
  L8 = _wifiNameForIndex
  L9 = 1
  L8 = L8(L9)
  L9 = "."
  L7 = L7(L8, L9)
  L7 = L7[1]
  L5 = L5(L6, L7)
  L7 = L4
  L6 = L4.get_wifidev
  L8 = _UPVALUE1_
  L8 = L8.split
  L9 = _wifiNameForIndex
  L10 = 2
  L9 = L9(L10)
  L10 = "."
  L8 = L8(L9, L10)
  L8 = L8[1]
  L6 = L6(L7, L8)
  if L5 then
    L7 = tonumber
    L8 = A0
    L7 = L7(L8)
    if L7 then
      L8 = L5
      L7 = L5.set
      L9 = "channel"
      L10 = A0
      L7(L8, L9, L10)
    end
    L7 = _UPVALUE2_
    L7 = L7.isStrNil
    L8 = A1
    L7 = L7(L8)
    if not L7 then
      L8 = L5
      L7 = L5.set
      L9 = "txpwr"
      L10 = A1
      L7(L8, L9, L10)
    end
  end
  if L6 then
    L7 = tonumber
    L8 = A2
    L7 = L7(L8)
    if L7 then
      L8 = L6
      L7 = L6.set
      L9 = "channel"
      L10 = A2
      L7(L8, L9, L10)
    end
    L7 = _UPVALUE2_
    L7 = L7.isStrNil
    L8 = A3
    L7 = L7(L8)
    if not L7 then
      L8 = L6
      L7 = L6.set
      L9 = "txpwr"
      L10 = A3
      L7(L8, L9, L10)
    end
  end
  L8 = L4
  L7 = L4.commit
  L9 = "wireless"
  L7(L8, L9)
  L8 = L4
  L7 = L4.save
  L9 = "wireless"
  L7(L8, L9)
  L7 = true
  return L7
end
setWifiChannelTxpwr = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_wifidev
  L4 = _UPVALUE1_
  L4 = L4.split
  L5 = _wifiNameForIndex
  L6 = 1
  L5 = L5(L6)
  L6 = "."
  L4 = L4(L5, L6)
  L4 = L4[1]
  L2 = L2(L3, L4)
  L4 = L1
  L3 = L1.get_wifidev
  L5 = _UPVALUE1_
  L5 = L5.split
  L6 = _wifiNameForIndex
  L7 = 2
  L6 = L6(L7)
  L7 = "."
  L5 = L5(L6, L7)
  L5 = L5[1]
  L3 = L3(L4, L5)
  if L2 then
    L4 = _UPVALUE2_
    L4 = L4.isStrNil
    L5 = A0
    L4 = L4(L5)
    if not L4 then
      L5 = L2
      L4 = L2.set
      L6 = "txpwr"
      L7 = A0
      L4(L5, L6, L7)
    end
  end
  if L3 then
    L4 = _UPVALUE2_
    L4 = L4.isStrNil
    L5 = A0
    L4 = L4(L5)
    if not L4 then
      L5 = L3
      L4 = L3.set
      L6 = "txpwr"
      L7 = A0
      L4(L5, L6, L7)
    end
  end
  L5 = L1
  L4 = L1.commit
  L6 = "wireless"
  L4(L5, L6)
  L5 = L1
  L4 = L1.save
  L6 = "wireless"
  L4(L5, L6)
  L4 = true
  return L4
end
setWifiTxpwr = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  if L2 then
    return L2
  end
  for L5, L6 in L2, L3, L4 do
    L8 = L1
    L7 = L1.get_wifidev
    L9 = L6
    L7 = L7(L8, L9)
    if L7 then
      L9 = L7
      L8 = L7.set
      L10 = "txbf"
      L11 = A0
      L8(L9, L10, L11)
    end
  end
  L2(L3, L4)
  L2(L3, L4)
  return L2
end
setWifiTxbf = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  if L2 then
    return L2
  end
  if A0 ~= nil then
    if L2 == 1 then
      L2()
  end
  else
    L2()
  end
  for L5, L6 in L2, L3, L4 do
    L8 = L1
    L7 = L1.get_wifidev
    L9 = L6
    L7 = L7(L8, L9)
    if L7 then
      L9 = L7
      L8 = L7.set
      L10 = "ax"
      L11 = A0
      L8(L9, L10, L11)
    end
  end
  L2(L3, L4)
  L2(L3, L4)
  return L2
end
setWifiAx = L38
function L38(A0, A1)
  local L2, L3
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A1
  L2 = L2(L3)
  if not L2 then
    if not A1 or A1 == "none" then
      goto lbl_19
    end
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = A0
    L2 = L2(L3)
    if not L2 then
      goto lbl_19
    end
  end
  L2 = 1502
  do return L2 end
  ::lbl_19::
  L2 = _UPVALUE0_
  L2 = L2.checkChineseChar
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = 1523
    return L2
  end
  if A1 == "psk" or A1 == "psk2" then
    L3 = A0
    L2 = A0.len
    L2 = L2(L3)
    if L2 < 8 then
      L2 = 1520
      return L2
    end
  elseif A1 == "mixed-psk" then
    L3 = A0
    L2 = A0.len
    L2 = L2(L3)
    if not (L2 < 8) then
      L3 = A0
      L2 = A0.len
      L2 = L2(L3)
    end
    if 63 < L2 then
      L2 = 1521
      return L2
    end
  elseif A1 == "wep-open" then
    L3 = A0
    L2 = A0.len
    L2 = L2(L3)
    if L2 ~= 5 then
      L3 = A0
      L2 = A0.len
      L2 = L2(L3)
      if L2 ~= 13 then
        L2 = 1522
        return L2
      end
    end
  end
  L2 = 0
  return L2
end
checkWifiPasswd = L38
function L38(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = 0
    return L2
  end
  L2 = string
  L2 = L2.len
  L3 = A0
  L2 = L2(L3)
  L3 = tonumber
  L4 = A1
  L3 = L3(L4)
  if L2 > L3 then
    L2 = 1572
    return L2
  end
  L2 = _UPVALUE0_
  L2 = L2.checkSSID
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = 1573
    return L2
  end
  L2 = 0
  return L2
end
checkSSID = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L2 = _UPVALUE1_
  L2 = L2[A0]
  if not L2 then
    L2 = nil
    return L2
  end
  L3 = L1
  L2 = L1.get_wifinet
  L4 = _UPVALUE1_
  L4 = L4[A0]
  L2 = L2(L3, L4)
  if not L2 then
    L3 = nil
    return L3
  end
  L4 = L2
  L3 = L2.get_device
  L3 = L3(L4)
  if not L3 then
    L4 = nil
    return L4
  end
  L4 = {}
  L4.wifiIndex = A0
  L6 = L3
  L5 = L3.get
  L7 = "channel"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4.channel = L5
  L6 = L3
  L5 = L3.get
  L7 = "bw"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4.bandwidth = L5
  L6 = L3
  L5 = L3.get
  L7 = "txpwr"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4.txpwr = L5
  L6 = L2
  L5 = L2.get
  L7 = "disabled"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4.on = L5
  L6 = L2
  L5 = L2.get
  L7 = "ssid"
  L5 = L5(L6, L7)
  L4.ssid = L5
  L6 = L2
  L5 = L2.get
  L7 = "encryption"
  L5 = L5(L6, L7)
  L4.encryption = L5
  L6 = L2
  L5 = L2.get
  L7 = "key"
  L5 = L5(L6, L7)
  L4.password = L5
  L6 = L2
  L5 = L2.get
  L7 = "hidden"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4.hidden = L5
  L6 = L2
  L5 = L2.get
  L7 = "bsd"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4.bsd = L5
  L6 = L3
  L5 = L3.get
  L7 = "txbf"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4.txbf = L5
  L6 = L2
  L5 = L2.get
  L7 = "ax"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4.ax = L5
  L6 = L2
  L5 = L2.get
  L7 = "bsd"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4.bsd = L5
  L4.ssidHtmlEncode = 1
  L5 = L4.encryption
  if L5 == "ccmp" then
    L6 = L2
    L5 = L2.get
    L7 = "sae_password"
    L5 = L5(L6, L7)
    L4.password = L5
  end
  return L4
end
getWifiBasicInfo = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = getWifiBasicInfo
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L4 = L1
    L3 = L1.section
    L5 = "backup"
    L6 = "backup"
    L7 = "wifi"
    L8 = tostring
    L9 = A0
    L8 = L8(L9)
    L7 = L7 .. L8
    L8 = L2
    L3(L4, L5, L6, L7, L8)
    L4 = L1
    L3 = L1.commit
    L5 = "backup"
    L3(L4, L5)
  end
end
backupWifiInfo = L38
function L38(A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14)
  local L15, L16, L17, L18, L19, L20, L21, L22, L23, L24
  L15 = require
  L16 = "luci.model.uci"
  L15 = L15(L16)
  L15 = L15.cursor
  L15 = L15()
  L16 = _UPVALUE0_
  L16 = L16.init
  L16 = L16()
  L17 = _UPVALUE1_
  L17 = L17[A0]
  if not L17 then
    L17 = false
    return L17
  end
  L18 = L16
  L17 = L16.get_wifinet
  L19 = _UPVALUE1_
  L19 = L19[A0]
  L17 = L17(L18, L19)
  if L17 == nil then
    L18 = false
    return L18
  end
  L19 = L17
  L18 = L17.get_device
  L18 = L18(L19)
  if L18 then
    L19 = _UPVALUE2_
    L19 = L19.isStrNil
    L20 = A4
    L19 = L19(L20)
    if not L19 then
      L20 = L18
      L19 = L18.set
      L21 = "channel"
      L22 = A4
      L19(L20, L21, L22)
    end
    L19 = _UPVALUE2_
    L19 = L19.isStrNil
    L20 = A8
    L19 = L19(L20)
    if not L19 then
      L20 = L18
      L19 = L18.set
      L21 = "bw"
      L22 = A8
      L19(L20, L21, L22)
    end
    L19 = _UPVALUE2_
    L19 = L19.isStrNil
    L20 = A5
    L19 = L19(L20)
    if not L19 then
      L20 = L18
      L19 = L18.set
      L21 = "txpwr"
      L22 = A5
      L19(L20, L21, L22)
    end
    if A7 == 1 then
      L20 = L18
      L19 = L18.set
      L21 = "disabled"
      L22 = "0"
      L19(L20, L21, L22)
    end
    L19 = _UPVALUE2_
    L19 = L19.isStrNil
    L20 = A10
    L19 = L19(L20)
    if not L19 then
      L19 = tonumber
      L20 = A10
      L19 = L19(L20)
      if L19 == 3 then
        L20 = L18
        L19 = L18.set
        L21 = "txbf"
        L22 = "3"
        L19(L20, L21, L22)
      else
        L19 = tonumber
        L20 = A10
        L19 = L19(L20)
        if L19 == 0 then
          L20 = L18
          L19 = L18.set
          L21 = "txbf"
          L22 = "0"
          L19(L20, L21, L22)
        end
      end
    end
    L19 = _UPVALUE2_
    L19 = L19.isStrNil
    L20 = A14
    L19 = L19(L20)
    if not L19 then
      L19 = tonumber
      L20 = A14
      L19 = L19(L20)
      if L19 == 0 then
        L20 = L18
        L19 = L18.set
        L21 = "ax"
        L22 = "0"
        L19(L20, L21, L22)
      else
        L20 = L18
        L19 = L18.set
        L21 = "ax"
        L22 = "1"
        L19(L20, L21, L22)
      end
    end
  end
  if A7 == 1 then
    L20 = L17
    L19 = L17.set
    L21 = "disabled"
    L22 = "0"
    L19(L20, L21, L22)
  elseif A7 == 0 then
    L20 = L17
    L19 = L17.set
    L21 = "disabled"
    L22 = "1"
    L19(L20, L21, L22)
  end
  if A9 ~= nil then
    L20 = L17
    L19 = L17.set
    L21 = "bsd"
    L22 = A9
    L19(L20, L21, L22)
    L19 = _UPVALUE2_
    L19 = L19.isMeshMode
    L19 = L19()
    if not L19 then
      L20 = L17
      L19 = L17.set
      L21 = "rrm"
      L22 = A9
      L19(L20, L21, L22)
      L20 = L17
      L19 = L17.set
      L21 = "wnm"
      L22 = A9
      L19(L20, L21, L22)
    end
  end
  L19 = _UPVALUE2_
  L19 = L19.isStrNil
  L20 = A11
  L19 = L19(L20)
  if not L19 then
    L20 = L17
    L19 = L17.set
    L21 = "weakenable"
    L22 = A11
    L19(L20, L21, L22)
  end
  L19 = _UPVALUE2_
  L19 = L19.isStrNil
  L20 = A12
  L19 = L19(L20)
  if not L19 then
    L20 = L17
    L19 = L17.set
    L21 = "weakthreshold"
    L22 = A12
    L19(L20, L21, L22)
  end
  L19 = _UPVALUE2_
  L19 = L19.isStrNil
  L20 = A13
  L19 = L19(L20)
  if not L19 then
    L20 = L17
    L19 = L17.set
    L21 = "kickthreshold"
    L22 = A13
    L19(L20, L21, L22)
  end
  L19 = _UPVALUE2_
  L19 = L19.isStrNil
  L20 = A1
  L19 = L19(L20)
  if not L19 then
    L20 = L17
    L19 = L17.set
    L21 = "ssid"
    L22 = A1
    L19(L20, L21, L22)
  end
  if A3 then
    L19 = checkWifiPasswd
    L20 = A2
    L21 = A3
    L19 = L19(L20, L21)
    if L19 == 0 then
      L21 = L17
      L20 = L17.set
      L22 = "encryption"
      L23 = A3
      L20(L21, L22, L23)
      L21 = L17
      L20 = L17.set
      L22 = "key"
      L23 = A2
      L20(L21, L22, L23)
      if A3 == "none" then
        L21 = L17
        L20 = L17.set
        L22 = "key"
        L23 = ""
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "sae"
        L23 = ""
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "sae_password"
        L23 = ""
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "ieee80211w"
        L23 = ""
        L20(L21, L22, L23)
      elseif A3 == "wep-open" then
        L21 = L17
        L20 = L17.set
        L22 = "key1"
        L23 = "s:"
        L24 = A2
        L23 = L23 .. L24
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "key"
        L23 = 1
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "sae"
        L23 = ""
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "sae_password"
        L23 = ""
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "ieee80211w"
        L23 = ""
        L20(L21, L22, L23)
      elseif A3 == "ccmp" then
        L21 = L17
        L20 = L17.set
        L22 = "sae"
        L23 = "1"
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "key"
        L23 = ""
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "sae_password"
        L23 = A2
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "ieee80211w"
        L23 = "2"
        L20(L21, L22, L23)
      elseif A3 == "psk2+ccmp" then
        L21 = L17
        L20 = L17.set
        L22 = "sae"
        L23 = "1"
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "key"
        L23 = A2
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "sae_password"
        L23 = A2
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "ieee80211w"
        L23 = "1"
        L20(L21, L22, L23)
      elseif A3 == "psk2" or A3 == "mixed-psk" then
        L21 = L17
        L20 = L17.set
        L22 = "sae"
        L23 = ""
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "sae_password"
        L23 = ""
        L20(L21, L22, L23)
        L21 = L17
        L20 = L17.set
        L22 = "ieee80211w"
        L23 = ""
        L20(L21, L22, L23)
      end
    elseif 1502 < L19 then
      L20 = false
      return L20
    end
  end
  if A6 == "1" then
    L20 = L17
    L19 = L17.set
    L21 = "hidden"
    L22 = "1"
    L19(L20, L21, L22)
  end
  if A6 == "0" then
    L20 = L17
    L19 = L17.set
    L21 = "hidden"
    L22 = "0"
    L19(L20, L21, L22)
  end
  L20 = L16
  L19 = L16.save
  L21 = "wireless"
  L19(L20, L21)
  L20 = L16
  L19 = L16.commit
  L21 = "wireless"
  L19(L20, L21)
  if A0 == 1 then
    if A7 == 1 then
      L20 = L15
      L19 = L15.set
      L21 = "wireless"
      L22 = "miot_2G"
      L23 = "disabled"
      L24 = "0"
      L19(L20, L21, L22, L23, L24)
    elseif A7 == 0 then
      L20 = L15
      L19 = L15.set
      L21 = "wireless"
      L22 = "miot_2G"
      L23 = "disabled"
      L24 = "1"
      L19(L20, L21, L22, L23, L24)
    end
    L20 = L15
    L19 = L15.commit
    L21 = "wireless"
    L19(L20, L21)
  end
  L19 = true
  return L19
end
setWifiBasicInfo = L38
function L38(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if not L3 then
    L3 = tonumber
    L4 = A1
    L3 = L3(L4)
    if L3 then
      L3 = tonumber
      L4 = A2
      L3 = L3(L4)
      if L3 then
        goto lbl_19
      end
    end
  end
  L3 = false
  do return L3 end
  ::lbl_19::
  L3 = _UPVALUE1_
  L3 = L3.init
  L3 = L3()
  L5 = L3
  L4 = L3.get_wifidev
  L6 = _UPVALUE2_
  L6 = L6.split
  L7 = _wifiNameForIndex
  L8 = 1
  L7 = L7(L8)
  L8 = "."
  L6 = L6(L7, L8)
  L6 = L6[1]
  L4 = L4(L5, L6)
  L6 = L3
  L5 = L3.get_wifidev
  L7 = _UPVALUE2_
  L7 = L7.split
  L8 = _wifiNameForIndex
  L9 = 2
  L8 = L8(L9)
  L9 = "."
  L7 = L7(L8, L9)
  L7 = L7[1]
  L5 = L5(L6, L7)
  if L4 then
    L7 = L4
    L6 = L4.set
    L8 = "country"
    L9 = A0
    L6(L7, L8, L9)
    L7 = L4
    L6 = L4.set
    L8 = "region"
    L9 = A1
    L6(L7, L8, L9)
    L7 = L4
    L6 = L4.set
    L8 = "aregion"
    L9 = A2
    L6(L7, L8, L9)
    L7 = L4
    L6 = L4.set
    L8 = "channel"
    L9 = "0"
    L6(L7, L8, L9)
    L7 = L4
    L6 = L4.set
    L8 = "bw"
    L9 = "0"
    L6(L7, L8, L9)
    L7 = L4
    L6 = L4.set
    L8 = "autoch"
    L9 = "2"
    L6(L7, L8, L9)
  end
  if L5 then
    L7 = L5
    L6 = L5.set
    L8 = "country"
    L9 = A0
    L6(L7, L8, L9)
    L7 = L5
    L6 = L5.set
    L8 = "region"
    L9 = A1
    L6(L7, L8, L9)
    L7 = L5
    L6 = L5.set
    L8 = "aregion"
    L9 = A2
    L6(L7, L8, L9)
    L7 = L5
    L6 = L5.set
    L8 = "channel"
    L9 = "0"
    L6(L7, L8, L9)
    L7 = L5
    L6 = L5.set
    L8 = "bw"
    L9 = "0"
    L6(L7, L8, L9)
    L7 = L5
    L6 = L5.set
    L8 = "autoch"
    L9 = "2"
    L6(L7, L8, L9)
  end
  L7 = L3
  L6 = L3.commit
  L8 = "wireless"
  L6(L7, L8)
  L7 = L3
  L6 = L3.save
  L8 = "wireless"
  L6(L7, L8)
  L6 = true
  return L6
end
setWifiRegion = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = {}
  L1.bsd = 0
  L1.mode = 0
  L2 = _UPVALUE1_
  L2 = L2.init
  L2 = L2()
  L4 = L2
  L3 = L2.get_wifinet
  L5 = _wifiNameForIndex
  L6 = 1
  L5, L6, L7, L11, L12, L13, L14, L15 = L5(L6)
  L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15)
  L4 = tonumber
  L6 = L3
  L5 = L3.get
  L7 = "bsd"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  L4 = L4(L5)
  L5 = tonumber
  L7 = L3
  L6 = L3.get
  L6 = L6(L7, L8)
  L6 = L6 or L6
  L5 = L5(L6)
  if L4 == 1 then
    L1.bsd = 1
    if L5 == 0 then
      L1.mode = 0
    else
      L7 = L3
      L6 = L3.get
      L6 = L6(L7, L8)
      L7 = L3.get
      L7 = L7(L8, L9)
      if L6 then
        if L8 == "table" then
          for L11, L12 in L8, L9, L10 do
            L13 = string
            L13 = L13.lower
            L14 = A0
            L13 = L13(L14)
            L14 = string
            L14 = L14.lower
            L15 = L12
            L14 = L14(L15)
            if L13 == L14 then
              L1.mode = 1
              break
            end
          end
        end
      end
      if L7 then
        if L8 == "table" then
          for L11, L12 in L8, L9, L10 do
            L13 = string
            L13 = L13.lower
            L14 = A0
            L13 = L13(L14)
            L14 = string
            L14 = L14.lower
            L15 = L12
            L14 = L14(L15)
            if L13 == L14 then
              L1.mode = 2
              break
            end
          end
        end
      end
    end
  end
  return L1
end
getBsdInfo = L38
function L38(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 or not A1 then
    L2 = nil
    return L2
  end
  L2 = {}
  L2.bsd = 0
  L2.mode = 0
  L3 = _UPVALUE1_
  L3 = L3.init
  L3 = L3()
  L5 = L3
  L4 = L3.get_wifinet
  L6 = _wifiNameForIndex
  L7 = 1
  L6, L7, L8, L9, L10, L11, L15, L16, L17, L18, L19 = L6(L7)
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L6 = L3
  L5 = L3.get_wifinet
  L7 = _wifiNameForIndex
  L8 = 2
  L7, L8, L9, L10, L11, L15, L16, L17, L18, L19 = L7(L8)
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L6 = tonumber
  L8 = L4
  L7 = L4.get
  L9 = "bsd"
  L7 = L7(L8, L9)
  L7 = L7 or L7
  L6 = L6(L7)
  L7 = tonumber
  L9 = L4
  L8 = L4.get
  L10 = "bsd_maclist_mode"
  L8 = L8(L9, L10)
  L8 = L8 or L8
  L7 = L7(L8)
  if L6 == 1 then
    L2.bsd = 1
    L2.mode = A1
    if L4 then
      L9 = L4
      L8 = L4.set
      L10 = "bsd_maclist_mode"
      L11 = "1"
      L8(L9, L10, L11)
    end
    if L5 then
      L9 = L5
      L8 = L5.set
      L10 = "bsd_maclist_mode"
      L11 = "1"
      L8(L9, L10, L11)
    end
    L9 = L4
    L8 = L4.get
    L10 = "bsd_2g"
    L8 = L8(L9, L10)
    L10 = L4
    L9 = L4.get
    L11 = "bsd_5g"
    L9 = L9(L10, L11)
    L10, L11 = nil, nil
    if L8 then
      if L12 == "table" then
        for L15, L16 in L12, L13, L14 do
          L17 = string
          L17 = L17.lower
          L18 = A0
          L17 = L17(L18)
          L18 = string
          L18 = L18.lower
          L19 = L16
          L18 = L18(L19)
          if L17 == L18 then
            L10 = L15
            break
          end
        end
    end
    else
      L8 = L12
    end
    if L9 then
      if L12 == "table" then
        for L15, L16 in L12, L13, L14 do
          L17 = string
          L17 = L17.lower
          L18 = A0
          L17 = L17(L18)
          L18 = string
          L18 = L18.lower
          L19 = L16
          L18 = L18(L19)
          if L17 == L18 then
            L11 = L15
            break
          end
        end
    end
    else
      L9 = L12
    end
    if A1 == 0 then
      if L10 then
        L12(L13, L14)
      end
      if L11 then
        L12(L13, L14)
      end
    elseif A1 == 1 then
      if not L10 then
        L12(L13, L14)
      end
      if L11 then
        L12(L13, L14)
      end
    elseif A1 == 2 then
      if L10 then
        L12(L13, L14)
      end
      if not L11 then
        L12(L13, L14)
      end
    end
    if L8 then
      if 0 < L12 then
        L15 = L8
        L12(L13, L14, L15)
        if L5 then
          L15 = L8
          L12(L13, L14, L15)
        end
    end
    else
      L15 = nil
      L12(L13, L14, L15)
      if L5 then
        L15 = nil
        L12(L13, L14, L15)
      end
    end
    if L9 then
      if 0 < L12 then
        L15 = L9
        L12(L13, L14, L15)
        if L5 then
          L15 = L9
          L12(L13, L14, L15)
        end
    end
    else
      L15 = nil
      L12(L13, L14, L15)
      if L5 then
        L15 = nil
        L12(L13, L14, L15)
      end
    end
    L12(L13, L14)
  end
  return L2
end
setBsdMaclist = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = getWifiStatus
  L2 = A0
  L1 = L1(L2)
  L2 = L1.up
  if L2 == 1 then
    L2 = true
    return L2
  end
  L2 = _UPVALUE0_
  L2 = L2.init
  L2 = L2()
  L4 = L2
  L3 = L2.get_wifinet
  L5 = _wifiNameForIndex
  L6 = A0
  L5, L6, L7, L8 = L5(L6)
  L3 = L3(L4, L5, L6, L7, L8)
  L4 = nil
  if L3 ~= nil then
    L6 = L3
    L5 = L3.get_device
    L5 = L5(L6)
    L4 = L5
  end
  if L4 and L3 then
    L6 = L4
    L5 = L4.set
    L7 = "disabled"
    L8 = "0"
    L5(L6, L7, L8)
    L6 = L3
    L5 = L3.set
    L7 = "disabled"
    L8 = nil
    L5(L6, L7, L8)
    L6 = L2
    L5 = L2.commit
    L7 = "wireless"
    L5(L6, L7)
    L5 = _UPVALUE1_
    L5 = L5.forkRestartWifi
    L5()
    L5 = true
    return L5
  end
  L5 = false
  return L5
end
turnWifiOn = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = getWifiStatus
  L2 = A0
  L1 = L1(L2)
  L2 = L1.up
  if L2 == 0 then
    L2 = true
    return L2
  end
  L2 = _UPVALUE0_
  L2 = L2.init
  L2 = L2()
  L4 = L2
  L3 = L2.get_wifinet
  L5 = _wifiNameForIndex
  L6 = A0
  L5, L6, L7, L8 = L5(L6)
  L3 = L3(L4, L5, L6, L7, L8)
  L4 = nil
  if L3 ~= nil then
    L6 = L3
    L5 = L3.get_device
    L5 = L5(L6)
    L4 = L5
  end
  if L4 and L3 then
    L6 = L4
    L5 = L4.set
    L7 = "disabled"
    L8 = "1"
    L5(L6, L7, L8)
    L6 = L3
    L5 = L3.set
    L7 = "disabled"
    L8 = nil
    L5(L6, L7, L8)
    L6 = L2
    L5 = L2.commit
    L7 = "wireless"
    L5(L6, L7)
    L5 = _UPVALUE1_
    L5 = L5.forkRestartWifi
    L5()
    L5 = true
    return L5
  end
  L5 = false
  return L5
end
turnWifiOff = L38
function L38()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.GET_WPS_STATUS
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L2 = L0.trim
    L3 = L1
    L2 = L2(L3)
    L1 = L2
    L2 = tonumber
    L3 = L1
    return L2(L3)
  end
  L2 = 0
  return L2
end
getWifiWpsStatus = L38
function L38()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.GET_WPS_CONMAC
  L1 = L1(L2)
  if L1 then
    L2 = _UPVALUE1_
    L2 = L2.macFormat
    L3 = L0.trim
    L4 = L1
    L3, L4 = L3(L4)
    return L2(L3, L4)
  end
  L2 = nil
  return L2
end
getWpsConDevMac = L38
function L38()
  local L0, L1, L2
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.CLOSE_WPS
  L1(L2)
  return
end
stopWps = L38
function L38()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.XQPreference"
  L1 = L1(L2)
  L2 = L0.exec
  L3 = _UPVALUE0_
  L3 = L3.OPEN_WPS
  L2(L3)
  L2 = tostring
  L3 = os
  L3 = L3.time
  L3, L4, L5 = L3()
  L2 = L2(L3, L4, L5)
  L3 = L1.set
  L4 = _UPVALUE0_
  L4 = L4.PREF_WPS_TIMESTAMP
  L5 = L2
  L3(L4, L5)
  return L2
end
openWifiWps = L38
function L38(A0)
  local L1, L2
  L1 = tonumber
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  if 0 <= A0 then
    A0 = 100
  end
  if -50 <= A0 and A0 < 0 then
    A0 = 100
  elseif -80 <= A0 then
    L1 = A0 + 80
    L1 = L1 * 26
    L1 = L1 / 10
    A0 = 24 + L1
  elseif -90 <= A0 then
    L1 = A0 + 90
    L1 = L1 * 26
    A0 = L1 / 10
  else
    A0 = 0
  end
  L1 = math
  L1 = L1.ceil
  L2 = A0
  return L1(L2)
end
miwifiutil_rssi_to_signal = L38
function L38(A0)
  local L1, L2, L3, L4, L5
  L1 = A0.scan_ifname
  L2 = A0.ssid
  L3 = "iwlist "
  L4 = L1
  L5 = " scanning"
  L3 = L3 .. L4 .. L5
  return L3
end
apcli_set_scan = L38
function L38(A0)
  local L1, L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.exec
  L3 = "wpa_cli -g /var/run/wpa_supplicantglobal ifname="
  L4 = A0
  L5 = " status | grep ^wpa_state= | cut -f2- -d="
  L3 = L3 .. L4 .. L5
  L2 = L2(L3)
  L1 = L2
  L3 = L1
  L2 = L1.match
  L4 = "COMPLETED"
  L2 = L2(L3, L4)
  if L2 then
    L2 = true
    L3 = L1
    return L2, L3
  else
    L2 = false
    L3 = L1
    return L2, L3
  end
end
apcli_get_connect = L38
function L38(A0)
  local L1, L2, L3, L4, L5
  L1 = apcli_get_device
  L2 = A0
  L1 = L1(L2)
  L2 = os
  L2 = L2.execute
  L3 = "wpa_cli -g /var/run/wpa_supplicantglobal interface_remove "
  L4 = A0
  L3 = L3 .. L4
  L2(L3)
  L2 = os
  L2 = L2.execute
  L3 = "ifconfig "
  L4 = A0
  L5 = " down"
  L3 = L3 .. L4 .. L5
  L2(L3)
  L2 = os
  L2 = L2.execute
  L3 = "wlanconfig "
  L4 = A0
  L5 = " destroy -cfg80211"
  L3 = L3 .. L4 .. L5
  L2(L3)
  L2 = os
  L2 = L2.execute
  L3 = "iw dev "
  L4 = A0
  L5 = " del"
  L3 = L3 .. L4 .. L5
  L2(L3)
end
apcli_set_inactive = L38
function L38(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28
  L2 = require
  L3 = "xiaoqiang.util.XQCryptoUtil"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQSecureUtil"
  L3 = L3(L4)
  L4 = A0.cmdssid
  L5 = A0.ifname
  L6 = L3.parseCmdline
  L7 = A0.encryption
  L6 = L6(L7)
  L7 = A0.cmdpassword
  L8 = L3.parseCmdline
  L9 = A0.enctype
  L8 = L8(L9)
  L9 = tonumber
  L10 = A1
  L9 = L9(L10)
  L9 = L9 or L9
  L10 = L2.binaryBase64Enc
  L11 = A0.cmdssid
  L10 = L10(L11)
  L11 = L2.binaryBase64Enc
  L12 = A0.cmdpassword
  L11 = L11(L12)
  L12 = A0.channel
  L13 = A0.band
  L14 = A0.reconnect
  L15 = string
  L15 = L15.format
  L16 = "/usr/sbin/check_apcli_connected \"%s\" \"%s\" \"%s\" \"%s\" \"%s\""
  L17 = L10
  L18 = L5
  L19 = L8
  L20 = L6
  L21 = L11
  L15 = L15(L16, L17, L18, L19, L20, L21)
  L16 = _UPVALUE0_
  L16 = L16.trim
  L17 = _UPVALUE0_
  L17 = L17.exec
  L18 = L15
  L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28 = L17(L18)
  L16 = L16(L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28)
  L17 = tonumber
  L18 = L16
  L17 = L17(L18)
  if L17 == 1 then
    return
  end
  L17 = A0.band
  L18 = apcli_get_device
  L19 = L5
  L18 = L18(L19)
  L20 = L18
  L19 = L18.name
  L19 = L19(L20)
  L20 = io
  L20 = L20.open
  L21 = "/var/run/wpa_supplicant-"
  L22 = L5
  L23 = ".conf"
  L21 = L21 .. L22 .. L23
  L22 = "w+"
  L20 = L20(L21, L22)
  L22 = L20
  L21 = L20.write
  L23 = string
  L23 = L23.format
  L24 = "ctrl_interface=/var/run/wpa_supplicant-%s\n"
  L25 = L5
  L23, L24, L25, L26, L27, L28 = L23(L24, L25)
  L21(L22, L23, L24, L25, L26, L27, L28)
  L22 = L20
  L21 = L20.write
  L23 = string
  L23 = L23.format
  L24 = "network={\n"
  L23, L24, L25, L26, L27, L28 = L23(L24)
  L21(L22, L23, L24, L25, L26, L27, L28)
  L22 = L20
  L21 = L20.write
  L23 = string
  L23 = L23.format
  L24 = "        scan_ssid=1\n"
  L23, L24, L25, L26, L27, L28 = L23(L24)
  L21(L22, L23, L24, L25, L26, L27, L28)
  L22 = L20
  L21 = L20.write
  L23 = string
  L23 = L23.format
  L24 = "        ssid=\"%s\"\n"
  L25 = L4
  L23, L24, L25, L26, L27, L28 = L23(L24, L25)
  L21(L22, L23, L24, L25, L26, L27, L28)
  L21 = A0.enctype
  L22 = L21
  L21 = L21.match
  L23 = "AES"
  L21 = L21(L22, L23)
  if L21 then
    if L6 == "SAEPSKMIX" then
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        key_mgmt=SAE WPA-PSK\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        proto=RSN\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        ieee80211w=1\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        pairwise=CCMP\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        group=CCMP\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        psk=\"%s\"\n"
      L25 = L7
      L23, L24, L25, L26, L27, L28 = L23(L24, L25)
      L21(L22, L23, L24, L25, L26, L27, L28)
    elseif L6 == "SAE" then
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        key_mgmt=SAE\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        proto=RSN\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        ieee80211w=2\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        pairwise=CCMP\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        group=CCMP\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        sae_password=\"%s\"\n"
      L25 = L7
      L23, L24, L25, L26, L27, L28 = L23(L24, L25)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        psk=\"%s\"\n"
      L25 = L7
      L23, L24, L25, L26, L27, L28 = L23(L24, L25)
      L21(L22, L23, L24, L25, L26, L27, L28)
    else
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        key_mgmt=WPA-PSK\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L6
      L21 = L6.match
      L23 = "WPA2PSK"
      L21 = L21(L22, L23)
      if L21 then
        L22 = L20
        L21 = L20.write
        L23 = string
        L23 = L23.format
        L24 = "        proto=RSN\n"
        L23, L24, L25, L26, L27, L28 = L23(L24)
        L21(L22, L23, L24, L25, L26, L27, L28)
      else
        L22 = L20
        L21 = L20.write
        L23 = string
        L23 = L23.format
        L24 = "        proto=WPA\n"
        L23, L24, L25, L26, L27, L28 = L23(L24)
        L21(L22, L23, L24, L25, L26, L27, L28)
      end
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        psk=\"%s\"\n"
      L25 = L7
      L23, L24, L25, L26, L27, L28 = L23(L24, L25)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        pairwise=CCMP\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        group=CCMP TKIP\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
    end
  else
    L21 = A0.enctype
    L22 = L21
    L21 = L21.match
    L23 = "TKIP"
    L21 = L21(L22, L23)
    if L21 then
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        key_mgmt=WPA-PSK\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L6
      L21 = L6.match
      L23 = "WPA2PSK"
      L21 = L21(L22, L23)
      if L21 then
        L22 = L20
        L21 = L20.write
        L23 = string
        L23 = L23.format
        L24 = "        proto=RSN\n"
        L23, L24, L25, L26, L27, L28 = L23(L24)
        L21(L22, L23, L24, L25, L26, L27, L28)
      else
        L22 = L20
        L21 = L20.write
        L23 = string
        L23 = L23.format
        L24 = "        proto=WPA\n"
        L23, L24, L25, L26, L27, L28 = L23(L24)
        L21(L22, L23, L24, L25, L26, L27, L28)
      end
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        psk=\"%s\"\n"
      L25 = L7
      L23, L24, L25, L26, L27, L28 = L23(L24, L25)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        pairwise=TKIP\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
      L22 = L20
      L21 = L20.write
      L23 = string
      L23 = L23.format
      L24 = "        group=CCMP TKIP\n"
      L23, L24, L25, L26, L27, L28 = L23(L24)
      L21(L22, L23, L24, L25, L26, L27, L28)
    else
      L21 = A0.enctype
      L22 = L21
      L21 = L21.match
      L23 = "WEP"
      L21 = L21(L22, L23)
      if L21 then
        L22 = L20
        L21 = L20.write
        L23 = string
        L23 = L23.format
        L24 = "        key_mgmt=NONE\n"
        L23, L24, L25, L26, L27, L28 = L23(L24)
        L21(L22, L23, L24, L25, L26, L27, L28)
        L22 = L20
        L21 = L20.write
        L23 = string
        L23 = L23.format
        L24 = "        wep_key0=\"%s\"\n"
        L25 = L7
        L23, L24, L25, L26, L27, L28 = L23(L24, L25)
        L21(L22, L23, L24, L25, L26, L27, L28)
        L22 = L20
        L21 = L20.write
        L23 = string
        L23 = L23.format
        L24 = "        wep_tx_keyidx=0\n"
        L23, L24, L25, L26, L27, L28 = L23(L24)
        L21(L22, L23, L24, L25, L26, L27, L28)
        L22 = L20
        L21 = L20.write
        L23 = string
        L23 = L23.format
        L24 = "        auth_alg=OPEN\n"
        L23, L24, L25, L26, L27, L28 = L23(L24)
        L21(L22, L23, L24, L25, L26, L27, L28)
      else
        L21 = A0.enctype
        L22 = L21
        L21 = L21.match
        L23 = "NONE"
        L21 = L21(L22, L23)
        if L21 then
          L22 = L20
          L21 = L20.write
          L23 = string
          L23 = L23.format
          L24 = "        key_mgmt=NONE\n"
          L23, L24, L25, L26, L27, L28 = L23(L24)
          L21(L22, L23, L24, L25, L26, L27, L28)
        end
      end
    end
  end
  L22 = L20
  L21 = L20.write
  L23 = string
  L23 = L23.format
  L24 = "}\n"
  L23, L24, L25, L26, L27, L28 = L23(L24)
  L21(L22, L23, L24, L25, L26, L27, L28)
  L22 = L20
  L21 = L20.flush
  L21(L22)
  L22 = L20
  L21 = L20.close
  L21(L22)
  if L14 == true then
    L21 = os
    L21 = L21.execute
    L22 = "wpa_cli -g /var/run/wpa_supplicantglobal interface_remove "
    L23 = L5
    L22 = L22 .. L23
    L21(L22)
    L21 = os
    L21 = L21.execute
    L22 = "sleep 2"
    L21(L22)
    L21 = os
    L21 = L21.execute
    L22 = "wpa_cli -g /var/run/wpa_supplicantglobal interface_add "
    L23 = L5
    L24 = " /var/run/wpa_supplicant-"
    L25 = L5
    L26 = ".conf nl80211 /var/run/wpa_supplicant-"
    L27 = L5
    L28 = " \"\" br-lan > /dev/null 2>&1"
    L22 = L22 .. L23 .. L24 .. L25 .. L26 .. L27 .. L28
    L21(L22)
    return
  end
  L21 = apcli_get_wifinet
  L22 = L5
  L21 = L21(L22)
  if L21 ~= nil then
    L21 = apcli_set_inactive
    L22 = L5
    L21(L22)
  end
  L21 = os
  L21 = L21.execute
  L22 = "sleep 1"
  L21(L22)
  L21 = os
  L21 = L21.execute
  L22 = "wlanconfig "
  L23 = L5
  L24 = " create wlandev "
  L25 = L19
  L26 = " wlanmode sta -cfg80211"
  L22 = L22 .. L23 .. L24 .. L25 .. L26
  L21(L22)
  L21 = os
  L21 = L21.execute
  L22 = "iw dev "
  L23 = L19
  L24 = " interface add "
  L25 = L5
  L26 = " type __ap"
  L22 = L22 .. L23 .. L24 .. L25 .. L26
  L21(L22)
  L21 = os
  L21 = L21.execute
  L22 = "cfg80211tool "
  L23 = L5
  L24 = " extap 1"
  L22 = L22 .. L23 .. L24
  L21(L22)
  L21 = os
  L21 = L21.execute
  L22 = "cfg80211tool "
  L23 = L5
  L24 = " athnewind 1"
  L22 = L22 .. L23 .. L24
  L21(L22)
  L21 = os
  L21 = L21.execute
  L22 = "sleep 1"
  L21(L22)
  L21 = os
  L21 = L21.execute
  L22 = "wpa_cli -g /var/run/wpa_supplicantglobal interface_add "
  L23 = L5
  L24 = " /var/run/wpa_supplicant-"
  L25 = L5
  L26 = ".conf nl80211 /var/run/wpa_supplicant-"
  L27 = L5
  L28 = " \"\" br-lan > /dev/null 2>&1"
  L22 = L22 .. L23 .. L24 .. L25 .. L26 .. L27 .. L28
  L21(L22)
  if L9 == 0 then
    L21 = os
    L21 = L21.execute
    L22 = "brctl addif br-lan "
    L23 = L5
    L22 = L22 .. L23
    L21(L22)
  end
  L21 = os
  L21 = L21.execute
  L22 = "ifconfig "
  L23 = L5
  L24 = " up"
  L22 = L22 .. L23 .. L24
  L21(L22)
end
apcli_set_connect = L38
function L38(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0.enctype
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE0_
    L1 = L1.isStrNil
    L2 = A0.encryption
    L1 = L1(L2)
    if not L1 then
      L1 = _UPVALUE0_
      L1 = L1.isStrNil
      L2 = A0.band
      L1 = L1(L2)
      if not L1 then
        L1 = _UPVALUE0_
        L1 = L1.isStrNil
        L2 = A0.channel
        L1 = L1(L2)
      end
    end
  end
  return L1
end
apcli_check_apcliitem = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  L2, L3 = nil, nil
  L7, L8, L12, L13, L14, L15 = L5(L6)
  for L7, L8 in L4, L5, L6 do
    L12, L13, L14, L15 = L10(L11)
    for L12, L13 in L9, L10, L11 do
      if L13 then
        L15 = L13
        L14 = L13.ifname
        L14 = L14(L15)
        if L14 == A0 then
          L13.dev = L8
          return L13
        end
      end
    end
  end
  return L4
end
apcli_get_wifinet = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "misc"
  L5 = "wireless"
  L6 = "apclient_"
  L7 = string
  L7 = L7.upper
  L8 = A0
  L7 = L7(L8)
  L6 = L6 .. L7
  return L2(L3, L4, L5, L6)
end
apcli_get_ifname_form_band = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = _UPVALUE0_
  L3 = L3.init
  L3 = L3()
  L4 = apcli_get_wifinet
  L5 = A0
  L4 = L4(L5)
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L6 = L4
  L5 = L5(L6)
  if not L5 then
    L6 = L4
    L5 = L4.get
    L7 = "device"
    L5 = L5(L6, L7)
    L1 = L5 or L1
    if not L5 then
      L1 = ""
    end
  end
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L6 = L1
  L5 = L5(L6)
  if L5 then
    L6 = L2
    L5 = L2.get
    L7 = "misc"
    L8 = "wireless"
    L9 = A0
    L10 = "_device"
    L9 = L9 .. L10
    L5 = L5(L6, L7, L8, L9)
    L1 = L5
  end
  L6 = L3
  L5 = L3.get_wifidev
  L7 = L1
  return L5(L6, L7)
end
apcli_get_device = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = apcli_get_wifinet
  L3 = A0
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L4 = L2
    L3 = L2.get
    L5 = "scanifname"
    L3 = L3(L4, L5)
    L3 = L3 or L3
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = L3
    L4 = L4(L5)
    if not L4 then
      return L3
    end
  end
  L4 = L1
  L3 = L1.get
  L5 = "misc"
  L6 = "wireless"
  L7 = A0
  L8 = "_scanifname"
  L7 = L7 .. L8
  return L3(L4, L5, L6, L7)
end
apcli_get_scanifname = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = apcli_get_wifinet
  L3 = A0
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L4 = L2
    L3 = L2.get
    L5 = "scanband"
    L3 = L3(L4, L5)
    L3 = L3 or L3
    L4 = _UPVALUE0_
    L4 = L4.isStrNil
    L5 = L3
    L4 = L4(L5)
    if not L4 then
      return L3
    end
  end
  L4 = L1
  L3 = L1.get
  L5 = "misc"
  L6 = "wireless"
  L7 = A0
  L8 = "_scanband"
  L7 = L7 .. L8
  return L3(L4, L5, L6, L7)
end
apcli_get_scanband = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "misc"
  L5 = "wireless"
  L6 = A0
  L7 = "_mode"
  L6 = L6 .. L7
  return L2(L3, L4, L5, L6)
end
apcli_get_apclimode = L38
function L38()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get_list
  L3 = "misc"
  L4 = "wireless"
  L5 = "APCLI_IFNAMES"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  return L1
end
apcli_get_ifnames = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.model.network"
  L1 = L1(L2)
  L1 = L1.init
  L1 = L1()
  L2 = apcli_set_inactive
  L3 = A0
  L2(L3)
  L2 = apcli_get_wifinet
  L3 = A0
  L2 = L2(L3)
  L4 = L2
  L3 = L2.set
  L5 = "disabled"
  L6 = "1"
  L3(L4, L5, L6)
  L4 = L1
  L3 = L1.save
  L5 = "wireless"
  L3(L4, L5)
  L4 = L1
  L3 = L1.commit
  L5 = "wireless"
  L3(L4, L5)
end
apcli_disable = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L1 = A0.ifname
  L2 = A0.ssid
  L3 = A0.encryption
  L4 = A0.enctype
  L5 = A0.password
  L6 = require
  L7 = "luci.model.uci"
  L6 = L6(L7)
  L6 = L6.cursor
  L6 = L6()
  L7 = require
  L8 = "luci.model.network"
  L7 = L7(L8)
  L7 = L7.init
  L7 = L7()
  L8 = require
  L9 = "xiaoqiang.util.XQSynchrodata"
  L8 = L8(L9)
  L9, L10, L11, L12 = nil, nil, nil, nil
  L13 = apcli_get_wifinet
  L13 = L13(L14)
  L9 = L13
  L13 = L3.match
  L13 = L13(L14, L15)
  if L13 then
    L12 = "psk2+ccmp"
  else
    L13 = L3.match
    L13 = L13(L14, L15)
    if L13 then
      L12 = "ccmp"
    else
      L13 = L3.match
      L13 = L13(L14, L15)
      if L13 then
        L12 = "psk2"
      else
        L13 = L3.match
        L13 = L13(L14, L15)
        if L13 then
          L12 = "none"
        else
          L12 = "mixed-psk"
        end
      end
    end
  end
  L13 = _UPVALUE0_
  L13 = L13.isStrNil
  L13 = L13(L14)
  if L13 then
    L13 = apcli_get_device
    L13 = L13(L14)
    L14.device = L15
    L14.ifname = L1
    L14.scanifname = L15
    L14.apcliband = L15
    L14.network = "lan"
    L14.mode = "sta"
    L14.ssid = L2
    L14.key = L5
    L14.encryption = L3
    L14.enctype = L4
    L14.disabled = "0"
    L17 = "txpwr"
    L18 = "max"
    L15(L16, L17, L18)
    L14.extap = "1"
    L14.athnewind = "1"
    L14.encryption = L12
    if L12 == "psk2+ccmp" then
      L14.sae = "1"
      L14.sae_password = L5
      L14.ieee80211w = "1"
    elseif L12 == "ccmp" then
      L14.sae = "1"
      L14.sae_password = L5
      L14.ieee80211w = "2"
    end
    L17 = L14
    L15(L16, L17)
    L17 = "xiaoqiang"
    L15(L16, L17)
  else
    L13 = L9.set
    L13(L14, L15, L16)
    L13 = L9.set
    L13(L14, L15, L16)
    L13 = L9.set
    L13(L14, L15, L16)
    L13 = L9.set
    L13(L14, L15, L16)
    L13 = L9.set
    L13(L14, L15, L16)
    L13 = L9.set
    L13(L14, L15, L16)
    L13 = L9.set
    L13(L14, L15, L16)
    L13 = L9.set
    L13(L14, L15, L16)
    L13 = L9.set
    L13(L14, L15, L16)
    if L12 == "psk2+ccmp" then
      L13 = L9.set
      L13(L14, L15, L16)
      L13 = L9.set
      L13(L14, L15, L16)
      L13 = L9.set
      L13(L14, L15, L16)
    elseif L12 == "ccmp" then
      L13 = L9.set
      L13(L14, L15, L16)
      L13 = L9.set
      L13(L14, L15, L16)
      L13 = L9.set
      L13(L14, L15, L16)
    end
    L13 = L9.set
    L13(L14, L15, L16)
  end
  L13 = apcli_get_ifnames
  L13 = L13()
  for L17, L18 in L14, L15, L16 do
    if L18 ~= L1 then
      L19 = os
      L19 = L19.execute
      L20 = "ifconfig "
      L21 = L18
      L22 = " down"
      L20 = L20 .. L21 .. L22
      L19(L20)
      L19 = apcli_get_wifinet
      L20 = L18
      L19 = L19(L20)
      L11 = L19
      if L11 ~= nil then
        L20 = L11
        L19 = L11.set
        L21 = "disabled"
        L22 = "1"
        L19(L20, L21, L22)
      end
    end
  end
  L17 = " up"
  L14(L15)
  L14(L15)
  L14(L15, L16)
  L14(L15, L16)
end
apcli_enable = L38
function L38()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "xiaoqiang"
  L4 = "common"
  L5 = "active_apcli"
  L1 = L1(L2, L3, L4, L5)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = nil
  end
  return L1
end
apcli_get_active = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "xiaoqiang.util.XQSynchrodata"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = nil
  if A0 then
    L4 = tonumber
    L5 = apcli_get_apclimode
    L6 = A0
    L5, L6, L7, L8, L9 = L5(L6)
    L4 = L4(L5, L6, L7, L8, L9)
    L3 = L4
    L5 = L2
    L4 = L2.set
    L6 = "xiaoqiang"
    L7 = "common"
    L8 = "active_apcli"
    L9 = A0
    L4(L5, L6, L7, L8, L9)
  else
    L3 = 0
    L5 = L2
    L4 = L2.delete
    L6 = "xiaoqiang"
    L7 = "common"
    L8 = "active_apcli"
    L4(L5, L6, L7, L8)
  end
  L5 = L2
  L4 = L2.commit
  L6 = "xiaoqiang"
  L4(L5, L6)
  L4 = L1.syncActiveApcliMode
  L5 = L3
  L4(L5)
end
apcli_set_active = L38
function L38()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L0 = L0.miscRecovery
  L0 = L0()
  if L0 == 1 then
    L1 = 0
    return L1
  end
  L1 = 0
  L2 = apcli_get_active
  L2 = L2()
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L3 = 0
    return L3
  end
  L3 = tonumber
  L4 = apcli_get_apclimode
  L5 = L2
  L4, L5 = L4(L5)
  L3 = L3(L4, L5)
  L1 = L3
  return L1
end
apcli_get_active_type = L38
function L38(A0, A1)
  local L2, L3, L4
  L2 = A0.band
  L3 = A1.band
  if L2 == L3 then
    L2 = tonumber
    L3 = A0.rssi
    L2 = L2(L3)
    L3 = tonumber
    L4 = A1.rssi
    L3 = L3(L4)
    L2 = L2 > L3
    return L2
  else
    L2 = A0.band
    if L2 == "5g" then
      L2 = true
      return L2
    else
      L2 = A0.band
      if L2 == "5gh" then
        L2 = A1.band
        if L2 ~= "5g" then
          L2 = true
          return L2
      end
      else
        L2 = false
        return L2
      end
    end
  end
end
rssi_cmp = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35
  L1 = {}
  L2 = ""
  L3 = 0
  L4, L5, L6 = nil, nil, nil
  L7 = {}
  L8 = nil
  L9 = A0.ssid
  L10 = A0.band
  if L11 then
    L9 = ""
  end
  if L11 then
    L10 = ""
  end
  L14, L15, L16, L17, L21, L22, L28, L29, L30, L31, L32, L33, L34, L35 = L12()
  for L14, L15 in L11, L12, L13 do
    L16 = _UPVALUE0_
    L16 = L16.isStrNil
    L17 = L15
    L16 = L16(L17)
    if not L16 then
      L16 = apcli_get_device
      L17 = L15
      L16 = L16(L17)
      L17 = L16.is_up
      L17 = L17(L18)
      if L17 then
        L17 = apcli_get_scanband
        L17 = L17(L18)
        L5 = L17
        L17 = apcli_get_scanifname
        L17 = L17(L18)
        L4 = L17
        L17 = _UPVALUE0_
        L17 = L17.isStrNil
        L17 = L17(L18)
        if not L17 then
          L17 = _UPVALUE0_
          L17 = L17.isStrNil
          L17 = L17(L18)
          if not L17 then
            L17 = _UPVALUE0_
            L17 = L17.isStrNil
            L17 = L17(L18)
            if L17 or L5 == L10 then
              L17 = {}
              L6 = L17
              L6.scan_ifname = L4
              L6.ifname = L15
              L6.band = L5
              L6.ssid = L9
              L17 = L2
              L2 = L17 .. L18
              L17 = table
              L17 = L17.insert
              L17(L18, L19)
            end
          end
        end
      end
    end
  end
  if L2 == "" then
    return L1
  end
  L11(L12)
  for L14, L15 in L11, L12, L13 do
    while "os" do
      L16 = _UPVALUE0_
      L16 = L16.isStrNil
      L17 = L15
      L16 = L16(L17)
      if not L16 then
        L16 = apcli_get_wifinet
        L17 = L15.scan_ifname
        L16 = L16(L17)
        L17 = L16.disabled
        L17 = L17(L18)
        if L17 == "1" then
          break
        end
        L17 = L16.scanlist
        L17 = L17(L18)
        if 0 < L18 then
          for L21, L22 in L18, L19, L20 do
            L22.rssi = L23
            L22.signal = L23
            L22.band = L23
          end
          for L21, L22 in L18, L19, L20 do
            L3 = 0
            for L26, L27 in L23, L24, L25 do
              L28 = _UPVALUE0_
              L28 = L28.isStrNil
              L29 = L22.ssid
              L28 = L28(L29)
              if not L28 then
                L28 = L27.ssid
                L29 = L22.ssid
                if L28 == L29 then
                  L28 = L27.band
                  L29 = L22.band
                  if L28 == L29 then
                    L3 = 1
                    break
                  end
                end
              end
            end
            if L3 == 0 then
              if not L23 then
                for L28 = L25, L26, L27 do
                  L29 = string
                  L29 = L29.byte
                  L30 = L23
                  L31 = L28
                  L32 = L28 + 1
                  L29, L30 = L29(L30, L31, L32)
                  if L29 == 166 and 192 < L30 and L30 < 217 then
                    L31 = _UPVALUE1_
                    L31 = L31.log
                    L32 = 4
                    L33 = string
                    L33 = L33.format
                    L34 = "filter out the SSID %s as it contains Greek letter \206\177~\207\137 using GB2312 code"
                    L35 = L23
                    L33, L34, L35 = L33(L34, L35)
                    L31(L32, L33, L34, L35)
                    break
                  end
                end
                if L24 == 0 then
                  L22.ssid = L25
                  L22.ssidHtmlEncode = 1
                  L25(L26, L27)
                end
              end
            end
          end
        end
      end
      break
    end
  end
  L11(L12, L13)
  return L1
end
apcli_get_scanlist = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = apcli_get_scanlist
  L2 = A0
  L1 = L1(L2)
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    L8 = _UPVALUE0_
    L8 = L8.isStrNil
    L9 = L7.wsc_devicename
    L8 = L8(L9)
    if not L8 then
      L8 = L7.wsc_devicename
      if L8 == "XiaoMiRouter" then
        L8 = L7.enctype
        if L8 == "NONE" then
          L8 = table
          L8 = L8.insert
          L9 = L2
          L10 = L7
          L8(L9, L10)
        end
      end
    end
  end
  return L2
end
extendwifi_get_scanlist = L38
function L38(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = apcli_get_scanlist
  L2 = A0
  L1 = L1(L2)
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    L8 = _UPVALUE0_
    L8 = L8.isStrNil
    L9 = L7.wsc_devicename
    L8 = L8(L9)
    if not L8 then
      L8 = L7.wsc_devicename
      if L8 == "XiaoMiRouter" then
        L8 = table
        L8 = L8.insert
        L9 = L2
        L10 = L7
        L8(L9, L10)
      end
    end
  end
  return L2
end
extendwifi_get_all_scanlist = L38
L38 = require
L39 = "luci.model.uci"
L38 = L38(L39)
L38 = L38.cursor
L39 = "/tmp/extendwifi/etc/config"
L38 = L38(L39)
L39 = require
L40 = "luci.model.uci"
L39 = L39(L40)
L39 = L39.cursor
L39 = L39()
L40 = {}
L41 = {}
L42 = "disabled"
L43 = "string"
L44 = "0"
L41[1] = L42
L41[2] = L43
L41[3] = L44
L42 = {}
L43 = "channel"
L44 = "string"
L45 = "0"
L42[1] = L43
L42[2] = L44
L42[3] = L45
L43 = {}
L44 = "bw"
L45 = "string"
L46 = "0"
L43[1] = L44
L43[2] = L45
L43[3] = L46
L44 = {}
L45 = "country"
L46 = "string"
L47 = "CN"
L44[1] = L45
L44[2] = L46
L44[3] = L47
L45 = {}
L46 = "txbf"
L47 = "string"
L48 = "3"
L45[1] = L46
L45[2] = L47
L45[3] = L48
L46 = {}
L47 = "ax"
L48 = "string"
L49 = "1"
L46[1] = L47
L46[2] = L48
L46[3] = L49
L47 = {}
L48 = "txpwr"
L49 = "string"
L50 = "max"
L47[1] = L48
L47[2] = L49
L47[3] = L50
L40[1] = L41
L40[2] = L42
L40[3] = L43
L40[4] = L44
L40[5] = L45
L40[6] = L46
L40[7] = L47
EXTENDWIFI_DEVICE_OPTION = L40
L40 = {}
L41 = {}
L42 = "disabled"
L43 = "string"
L44 = "0"
L41[1] = L42
L41[2] = L43
L41[3] = L44
L42 = {}
L43 = "network"
L44 = "string"
L45 = nil
L42[1] = L43
L42[2] = L44
L42[3] = L45
L43 = {}
L44 = "ssid"
L45 = "string"
L46 = nil
L43[1] = L44
L43[2] = L45
L43[3] = L46
L44 = {}
L45 = "key"
L46 = "string"
L47 = nil
L44[1] = L45
L44[2] = L46
L44[3] = L47
L45 = {}
L46 = "encryption"
L47 = "string"
L48 = nil
L45[1] = L46
L45[2] = L47
L45[3] = L48
L46 = {}
L47 = "enctype"
L48 = "string"
L49 = nil
L46[1] = L47
L46[2] = L48
L46[3] = L49
L47 = {}
L48 = "hidden"
L49 = "string"
L50 = nil
L47[1] = L48
L47[2] = L49
L47[3] = L50
L48 = {}
L49 = "macfilter"
L50 = "string"
L51 = nil
L48[1] = L49
L48[2] = L50
L48[3] = L51
L49 = {}
L50 = "maclist"
L51 = "list"
L52 = nil
L49[1] = L50
L49[2] = L51
L49[3] = L52
L50 = {}
L51 = "wpsdevicename"
L52 = "string"
L53 = nil
L50[1] = L51
L50[2] = L52
L50[3] = L53
L51 = {}
L52 = "bsd"
L53 = "string"
L54 = nil
L51[1] = L52
L51[2] = L53
L51[3] = L54
L52 = {}
L53 = "wscconfigstatus"
L54 = "string"
L55 = nil
L52[1] = L53
L52[2] = L54
L52[3] = L55
L53 = {}
L54 = "dynbcn"
L55 = "string"
L56 = nil
L53[1] = L54
L53[2] = L55
L53[3] = L56
L54 = {}
L55 = "rssithreshold"
L56 = "string"
L57 = nil
L54[1] = L55
L54[2] = L56
L54[3] = L57
L55 = {}
L56 = "ap_isolate"
L57 = "string"
L58 = nil
L55[1] = L56
L55[2] = L57
L55[3] = L58
L40[1] = L41
L40[2] = L42
L40[3] = L43
L40[4] = L44
L40[5] = L45
L40[6] = L46
L40[7] = L47
L40[8] = L48
L40[9] = L49
L40[10] = L50
L40[11] = L51
L40[12] = L52
L40[13] = L53
L40[14] = L54
L40[15] = L55
EXTENDWIFI_IFACE_OPTION = L40
L40 = {}
L41 = "/etc/xqDb"
L42 = "/etc/config/wifiblist"
L43 = "/etc/config/wifiwlist"
L44 = "/etc/config/devicelist"
L40[1] = L41
L40[2] = L42
L40[3] = L43
L40[4] = L44
EXTENDWIFI_FILE = L40
function L40(A0, A1)
  local L2, L3, L4, L5, L6, L7
  for L5, L6 in L2, L3, L4 do
    L7 = L6[".name"]
    if L7 == A1 then
      return L6
    end
  end
  return L2
end
__extendwifi_getdev = L40
function L40(A0, A1)
  local L2, L3, L4, L5, L6, L7
  for L5, L6 in L2, L3, L4 do
    L7 = L6.ifname
    if L7 == A1 then
      return L6
    end
  end
  return L2
end
__extendwifi_getiface = L40
function L40(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L6 = A0.ifname
  L7 = " --> "
  L8 = A1.ifname
  L9 = ")"
  L3(L4, L5)
  for L6, L7 in L3, L4, L5 do
    L8 = L7[1]
    L8 = A0[L8]
    L2 = L8 or L2
    if not L8 then
      L2 = L7[3]
    end
    if L2 == nil then
      L8 = _UPVALUE0_
      L8 = L8.log
      L9 = 3
      L10 = "rm "
      L11 = L7[1]
      L10 = L10 .. L11
      L8(L9, L10)
      L8 = _UPVALUE1_
      L9 = L8
      L8 = L8.delete
      L10 = "wireless"
      L11 = A1[".name"]
      L12 = L7[1]
      L8(L9, L10, L11, L12)
    else
      L8 = L7[2]
      if L8 == "string" then
        L8 = _UPVALUE0_
        L8 = L8.log
        L9 = 3
        L10 = L7[1]
        L11 = " = "
        L12 = L2
        L10 = L10 .. L11 .. L12
        L8(L9, L10)
      else
        L8 = _UPVALUE0_
        L8 = L8.log
        L9 = 3
        L10 = L7[1]
        L11 = " = "
        L10 = L10 .. L11
        L11 = L2
        L8(L9, L10, L11)
      end
      L8 = _UPVALUE1_
      L9 = L8
      L8 = L8.set
      L10 = "wireless"
      L11 = A1[".name"]
      L12 = L7[1]
      L13 = L2
      L8(L9, L10, L11, L12, L13)
    end
  end
  L3(L4, L5)
end
__extendwifi_tranlate_iface = L40
function L40(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L6 = A0[".name"]
  L7 = " --> "
  L8 = A1[".name"]
  L9 = ")"
  L3(L4, L5)
  for L6, L7 in L3, L4, L5 do
    L8 = L7[1]
    L8 = A0[L8]
    L2 = L8 or L2
    if not L8 then
      L2 = L7[3]
    end
    if L2 == nil then
      L8 = _UPVALUE0_
      L8 = L8.log
      L9 = 3
      L10 = "rm "
      L11 = L7[1]
      L10 = L10 .. L11
      L8(L9, L10)
      L8 = _UPVALUE1_
      L9 = L8
      L8 = L8.delete
      L10 = "wireless"
      L11 = A1[".name"]
      L12 = L7[1]
      L8(L9, L10, L11, L12)
    else
      L8 = _UPVALUE0_
      L8 = L8.log
      L9 = 3
      L10 = L7[1]
      L11 = " = "
      L12 = L2
      L10 = L10 .. L11 .. L12
      L8(L9, L10)
      L8 = _UPVALUE1_
      L9 = L8
      L8 = L8.set
      L10 = "wireless"
      L11 = A1[".name"]
      L12 = L7[1]
      L13 = L2
      L8(L9, L10, L11, L12, L13)
    end
  end
  L3(L4, L5)
end
__extendwifi_tranlate_device = L40
function L40()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30
  L0 = {}
  L1 = {}
  L2 = {}
  L3 = {}
  L4 = {}
  L5 = {}
  L6 = {}
  L7 = {}
  L8 = {}
  L9 = {}
  L13 = "wireless"
  L14 = "DEVICE_LIST"
  org_device = L10
  L13 = "wireless"
  L14 = "DEVICE_LIST"
  new_device = L10
  for L13, L14 in L10, L11, L12 do
    L16.idx = L14
    L19 = "misc"
    L20 = "wireless"
    L21 = L14
    L22 = "_name"
    L21 = L21 .. L22
    L16[".name"] = L17
    L2[L15] = L16
  end
  for L13, L14 in L10, L11, L12 do
    L16.idx = L14
    L19 = "misc"
    L20 = "wireless"
    L21 = L14
    L22 = "_name"
    L21 = L21 .. L22
    L16[".name"] = L17
    L3[L15] = L16
  end
  L13 = "wireless"
  L14 = "IFACE_LIST"
  org_iface = L10
  L13 = "wireless"
  L14 = "IFACE_LIST"
  new_iface = L10
  for L13, L14 in L10, L11, L12 do
    L16.idx = L14
    L19 = "misc"
    L20 = "wireless"
    L21 = L14
    L22 = "_name"
    L21 = L21 .. L22
    L16[".name"] = L17
    L19 = "misc"
    L20 = "wireless"
    L21 = L14
    L22 = "_ifname"
    L21 = L21 .. L22
    L16.ifname = L17
    L19 = "misc"
    L20 = "wireless"
    L21 = _UPVALUE1_
    L22 = L21
    L21 = L21.get
    L23 = "misc"
    L24 = "wireless"
    L25 = L14
    L26 = "_deviceidx"
    L25 = L25 .. L26
    L21 = L21(L22, L23, L24, L25)
    L21 = L21 or L21
    L22 = "_name"
    L21 = L21 .. L22
    L16.device = L17
    L19 = "misc"
    L20 = "wireless"
    L21 = _UPVALUE1_
    L22 = L21
    L21 = L21.get
    L23 = "misc"
    L24 = "wireless"
    L25 = L14
    L26 = "_deviceidx"
    L25 = L25 .. L26
    L21 = L21(L22, L23, L24, L25)
    L21 = L21 or L21
    L22 = "_band"
    L21 = L21 .. L22
    L16.band = L17
    L19 = "misc"
    L20 = "wireless"
    L21 = L14
    L22 = "_network"
    L21 = L21 .. L22
    L16.network = L17
    L16.mode = "ap"
    L7[L15] = L16
  end
  for L13, L14 in L10, L11, L12 do
    L16.idx = L14
    L19 = "misc"
    L20 = "wireless"
    L21 = L14
    L22 = "_name"
    L21 = L21 .. L22
    L16[".name"] = L17
    L19 = "misc"
    L20 = "wireless"
    L21 = L14
    L22 = "_ifname"
    L21 = L21 .. L22
    L16.ifname = L17
    L19 = "misc"
    L20 = "wireless"
    L21 = _UPVALUE1_
    L22 = L21
    L21 = L21.get
    L23 = "misc"
    L24 = "wireless"
    L25 = L14
    L26 = "_deviceidx"
    L25 = L25 .. L26
    L21 = L21(L22, L23, L24, L25)
    L21 = L21 or L21
    L22 = "_name"
    L21 = L21 .. L22
    L16.device = L17
    L19 = "misc"
    L20 = "wireless"
    L21 = _UPVALUE1_
    L22 = L21
    L21 = L21.get
    L23 = "misc"
    L24 = "wireless"
    L25 = L14
    L26 = "_deviceidx"
    L25 = L25 .. L26
    L21 = L21(L22, L23, L24, L25)
    L21 = L21 or L21
    L22 = "_band"
    L21 = L21 .. L22
    L16.band = L17
    L19 = "misc"
    L20 = "wireless"
    L21 = L14
    L22 = "_network"
    L21 = L21 .. L22
    L16.network = L17
    L16.mode = "ap"
    L8[L15] = L16
  end
  L13 = "wifi-device"
  function L14(A0)
    local L1, L2
    L1 = _UPVALUE0_
    L2 = _UPVALUE0_
    L2 = #L2
    L2 = L2 + 1
    L1[L2] = A0
  end
  L10(L11, L12, L13, L14)
  L13 = "wifi-device"
  function L14(A0)
    local L1, L2
    L1 = _UPVALUE0_
    L2 = _UPVALUE0_
    L2 = #L2
    L2 = L2 + 1
    L1[L2] = A0
  end
  L10(L11, L12, L13, L14)
  for L13, L14 in L10, L11, L12 do
    for L19, L20 in L16, L17, L18 do
      L21 = L14.idx
      L22 = L20.idx
      if L21 == L22 then
        L21 = __extendwifi_getdev
        L22 = L1
        L23 = L14[".name"]
        L21 = L21(L22, L23)
        dev_new = L21
        L21 = __extendwifi_getdev
        L22 = L0
        L23 = L20[".name"]
        L21 = L21(L22, L23)
        dev_org = L21
        L21 = dev_new
        if L21 then
          L21 = dev_org
          if L21 then
            L21 = __extendwifi_tranlate_device
            L22 = dev_org
            L23 = dev_new
            L21(L22, L23)
          end
        end
      end
    end
    if L15 == false then
      L4[L16] = L17
    end
  end
  L13 = L4
  L10(L11, L12, L13)
  L13 = "wifi-iface"
  function L14(A0)
    local L1, L2
    L1 = _UPVALUE0_
    L2 = _UPVALUE0_
    L2 = #L2
    L2 = L2 + 1
    L1[L2] = A0
  end
  L10(L11, L12, L13, L14)
  L13 = "wifi-iface"
  function L14(A0)
    local L1, L2
    L1 = _UPVALUE0_
    L2 = _UPVALUE0_
    L2 = #L2
    L2 = L2 + 1
    L1[L2] = A0
  end
  L10(L11, L12, L13, L14)
  for L13, L14 in L10, L11, L12 do
    L16[".name"] = L17
    L16[".type"] = "wifi-iface"
    L16.ifname = L17
    L16.device = L17
    L16.network = L17
    L16.mode = L17
    if L15 == nil then
    elseif L17 then
      if L17 ~= L18 then
        L19 = "reset section name "
        L20 = L14.idx
        L21 = "  "
        L22 = L14[".name"]
        L23 = " form "
        L24 = L15[".name"]
        L19 = L19 .. L20 .. L21 .. L22 .. L23 .. L24
        L17(L18, L19)
        L19 = "wireless"
        L20 = L15[".name"]
        L17(L18, L19, L20)
        L19 = "wireless"
        L20 = L16[".name"]
        L21 = L16[".type"]
        L17(L18, L19, L20, L21)
        L19 = "wireless"
        L20 = L16[".name"]
        L21 = "ifname"
        L22 = L16.ifname
        L17(L18, L19, L20, L21, L22)
        L19 = "wireless"
        L20 = L16[".name"]
        L21 = "device"
        L22 = L16.device
        L17(L18, L19, L20, L21, L22)
        L19 = "wireless"
        L20 = L16[".name"]
        L21 = "network"
        L22 = L16.network
        L17(L18, L19, L20, L21, L22)
        L19 = "wireless"
        L20 = L16[".name"]
        L21 = "mode"
        L22 = L16.mode
        L17(L18, L19, L20, L21, L22)
        L19 = "wireless"
        L17(L18, L19)
      end
    end
  end
  L6 = L10
  L13 = "wifi-iface"
  function L14(A0)
    local L1, L2
    L1 = _UPVALUE0_
    L2 = _UPVALUE0_
    L2 = #L2
    L2 = L2 + 1
    L1[L2] = A0
  end
  L10(L11, L12, L13, L14)
  for L13, L14 in L10, L11, L12 do
    for L19, L20 in L16, L17, L18 do
      L21 = L14.idx
      L22 = L20.idx
      if L21 == L22 then
        L21 = __extendwifi_getiface
        L22 = L5
        L23 = L20.ifname
        L21 = L21(L22, L23)
        L22 = __extendwifi_getiface
        L23 = L6
        L24 = L14.ifname
        L22 = L22(L23, L24)
        if L21 and L22 then
          L23 = __extendwifi_tranlate_iface
          L24 = L21
          L25 = L22
          L23(L24, L25)
          break
        end
      end
    end
    if L15 == false then
      L9[L16] = L14
    end
  end
  L13 = L9
  L10(L11, L12, L13)
  for L13, L14 in L10, L11, L12 do
    for L18, L19 in L15, L16, L17 do
      L20 = __extendwifi_getiface
      L21 = L5
      L22 = L19.ifname
      L20 = L20(L21, L22)
      L21 = __extendwifi_getiface
      L22 = L6
      L23 = L14.ifname
      L21 = L21(L22, L23)
      if L20 and L21 then
        L22 = L14.mode
        if L22 == "ap" then
          L22 = L14.network
          if L22 == "lan" then
            L22 = __extendwifi_tranlate_iface
            L23 = L20
            L24 = L21
            L22(L23, L24)
            L22 = string
            L22 = L22.upper
            L23 = L14.band
            L22 = L22(L23)
            L23 = _UPVALUE1_
            L24 = L23
            L23 = L23.set
            L25 = "wireless"
            L26 = L21[".name"]
            L27 = "ssid"
            L28 = L20.ssid
            L29 = "_"
            L30 = L22
            L28 = L28 .. L29 .. L30
            L23(L24, L25, L26, L27, L28)
            L23 = _UPVALUE1_
            L24 = L23
            L23 = L23.set
            L25 = "wireless"
            L26 = L21[".name"]
            L27 = "disabled"
            L28 = "0"
            L23(L24, L25, L26, L27, L28)
          end
        end
      end
    end
  end
  for L13, L14 in L10, L11, L12 do
    L19 = " "
    L20 = L14
    L21 = " -f  2> /dev/NULL >&2"
    L15(L16)
  end
  return L10
end
extendwifi_tranlate_wireless_config = L40
function L40(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = tonumber
  L3 = A0
  L2 = L2(L3)
  if L2 == 0 then
    L2 = "wifiblist"
    if L2 then
      goto lbl_15
    end
  end
  L2 = "wifiwlist"
  ::lbl_15::
  L4 = L1
  L3 = L1.get_list
  L5 = L2
  L6 = "maclist"
  L7 = "mac"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  return L3
end
getWiFiMacfilterList = L40
function L40()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.model.network"
  L0 = L0(L1)
  L0 = L0.init
  L0 = L0()
  L2 = L0
  L1 = L0.get_wifinet
  L3 = _wifiNameForIndex
  L4 = 1
  L3, L4 = L3(L4)
  L1 = L1(L2, L3, L4)
  if L1 then
    L3 = L1
    L2 = L1.get
    L4 = "macfilter"
    L2 = L2(L3, L4)
    if L2 == "disabled" then
      L3 = 0
      return L3
    elseif L2 == "deny" then
      L3 = 1
      return L3
    elseif L2 == "allow" then
      L3 = 2
      return L3
    else
      L3 = 0
      return L3
    end
  else
    L2 = 0
    return L2
  end
end
getWiFiMacfilterModel = L40
function L40()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.model.network"
  L0 = L0(L1)
  L0 = L0.init
  L0 = L0()
  L2 = L0
  L1 = L0.get_wifinet
  L3 = _wifiNameForIndex
  L4 = 1
  L3, L4 = L3(L4)
  L1 = L1(L2, L3, L4)
  L3 = L1
  L2 = L1.get
  L4 = "maclist"
  return L2(L3, L4)
end
getCurrentMacfilterList = L40
L40 = 0
L41 = 1
L42 = 2
L43 = 3
function L44(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = os
  L2 = L2.execute
  L3 = "iwpriv "
  L4 = A0
  L5 = " maccmd_sec "
  L6 = A1
  L3 = L3 .. L4 .. L5 .. L6
  L2(L3)
end
function L45(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = os
  L2 = L2.execute
  L3 = "iwpriv "
  L4 = A0
  L5 = " addmac_sec \""
  L6 = A1
  L7 = "\""
  L3 = L3 .. L4 .. L5 .. L6 .. L7
  L2(L3)
end
function L46(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = os
  L2 = L2.execute
  L3 = "iwpriv "
  L4 = A0
  L5 = " kickmac \""
  L6 = A1
  L7 = "\""
  L3 = L3 .. L4 .. L5 .. L6 .. L7
  L2(L3)
end
function L47(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L3 = L3.init
  L3 = L3()
  L5 = L3
  L4 = L3.get_wifinet
  L6 = A0
  L4 = L4(L5, L6)
  if nil == L4 then
    return
  end
  L6 = L4
  L5 = L4.set
  L7 = "macfilter"
  L8 = A1
  L5(L6, L7, L8)
  if A2 then
    L5 = #A2
    if 0 < L5 then
      L6 = L4
      L5 = L4.set_list
      L7 = "maclist"
      L8 = A2
      L5(L6, L7, L8)
  end
  else
    L6 = L4
    L5 = L4.set_list
    L7 = "maclist"
    L8 = nil
    L5(L6, L7, L8)
  end
end
function L48(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L5 = require
  L6 = "xiaoqiang.util.XQDBUtil"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQSynchrodata"
  L6 = L6(L7)
  L7 = tonumber
  L8 = A0
  L7 = L7(L8)
  A0 = L7
  L7 = _UPVALUE0_
  L7 = L7.isStrNil
  L8 = A1
  L7 = L7(L8)
  if not L7 then
    L7 = _UPVALUE0_
    L7 = L7.isStrNil
    L8 = A2
    L7 = L7(L8)
    if not L7 and (A0 == 0 or A0 == 1) then
      goto lbl_29
    end
  end
  L7 = 2
  do return L7 end
  ::lbl_29::
  L7 = _UPVALUE0_
  L7 = L7.macFormat
  L8 = A1
  L7 = L7(L8)
  A1 = L7
  L7 = _UPVALUE0_
  L7 = L7._cmdformat
  L8 = A1
  L7 = L7(L8)
  L8 = L7.match
  L8 = L8(L9, L10)
  if L8 then
    L8 = 2
    return L8
  end
  L8 = tonumber
  L8 = L8(L9)
  if L8 == 0 then
    L8 = _UPVALUE0_
    L8 = L8.isMeshMode
    L8 = L8()
    if L8 then
      L8 = string
      L8 = L8.format
      L8 = L8(L9, L10)
      L12 = L8
      L12, L13, L14, L15, L16, L17 = L11(L12)
      L12, L13, L14, L15, L16, L17 = L10(L11, L12, L13, L14, L15, L16, L17)
      if L9 == "resta" then
        return L10
      end
    end
  end
  L8 = L5.saveDeviceInfo
  L12 = ""
  L13 = ""
  L8(L9, L10, L11, L12, L13)
  if A0 == 1 then
    L3 = "allow"
    L4 = "wifiwlist"
  elseif A0 == 0 then
    L3 = "deny"
    L4 = "wifiblist"
  end
  L8 = _UPVALUE2_
  L8 = L8.get_list
  L12 = "mac"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  for L12, L13 in L9, L10, L11 do
    if A1 == L13 then
      L14 = 0
      return L14
    end
  end
  L9(L10, L11)
  if 32 < L9 then
    return L9
  end
  L12 = "maclist"
  L13 = "mac"
  L14 = L8
  L9(L10, L11, L12, L13, L14)
  L9(L10, L11)
  L10.mac = A1
  L10.limited = 1
  L9(L10)
  for L12, L13 in L9, L10, L11 do
    if A0 == 0 then
      L14 = _UPVALUE4_
      L15 = L13
      L16 = L3
      L17 = L8
      L14(L15, L16, L17)
      L14 = _UPVALUE5_
      L15 = L13
      L16 = _UPVALUE6_
      L14(L15, L16)
      L14 = _UPVALUE7_
      L15 = L13
      L16 = L7
      L14(L15, L16)
      L14 = _UPVALUE8_
      L15 = L13
      L16 = L7
      L14(L15, L16)
    elseif A0 == 1 then
      L14 = _UPVALUE4_
      L15 = L13
      L16, L17 = nil, nil
      L14(L15, L16, L17)
      L14 = _UPVALUE5_
      L15 = L13
      L16 = _UPVALUE9_
      L14(L15, L16)
    end
  end
  for L12, L13 in L9, L10, L11 do
    if A0 == 0 then
      L14 = _UPVALUE4_
      L15 = L13
      L16 = L3
      L17 = L8
      L14(L15, L16, L17)
      L14 = _UPVALUE5_
      L15 = L13
      L16 = _UPVALUE6_
      L14(L15, L16)
      L14 = _UPVALUE7_
      L15 = L13
      L16 = L7
      L14(L15, L16)
      L14 = _UPVALUE8_
      L15 = L13
      L16 = L7
      L14(L15, L16)
    elseif A0 == 1 then
      L14 = _UPVALUE4_
      L15 = L13
      L16, L17 = nil, nil
      L14(L15, L16, L17)
      L14 = _UPVALUE5_
      L15 = L13
      L16 = _UPVALUE9_
      L14(L15, L16)
    end
  end
  for L12, L13 in L9, L10, L11 do
    L14 = _UPVALUE4_
    L15 = L13
    L16 = L3
    L17 = L8
    L14(L15, L16, L17)
    if A0 == 0 then
      L14 = _UPVALUE5_
      L15 = L13
      L16 = _UPVALUE6_
      L14(L15, L16)
      L14 = _UPVALUE7_
      L15 = L13
      L16 = L7
      L14(L15, L16)
      L14 = _UPVALUE8_
      L15 = L13
      L16 = L7
      L14(L15, L16)
    elseif A0 == 1 then
      L14 = _UPVALUE5_
      L15 = L13
      L16 = _UPVALUE12_
      L14(L15, L16)
      L14 = _UPVALUE7_
      L15 = L13
      L16 = L7
      L14(L15, L16)
    end
  end
  L9(L10, L11)
  L9(L10, L11)
  return L9
end
addDevice = L48
function L48(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  if A1 == 1 then
    L2 = "allow"
  elseif A1 == 0 then
    L2 = "deny"
  end
  for L6, L7 in L3, L4, L5 do
    if L8 == 0 then
      L11 = A0
      L8(L9, L10, L11)
    elseif L8 == 1 then
      L11 = nil
      L8(L9, L10, L11)
    end
  end
  for L6, L7 in L3, L4, L5 do
    if L8 == 0 then
      L11 = A0
      L8(L9, L10, L11)
    elseif L8 == 1 then
      L11 = nil
      L8(L9, L10, L11)
    end
  end
  for L6, L7 in L3, L4, L5 do
    L11 = A0
    L8(L9, L10, L11)
  end
  L3(L4, L5)
  L3(L4, L5)
  for L6, L7 in L3, L4, L5 do
    L8(L9, L10)
    L8(L9, L10)
    if A1 == 0 then
      L8(L9, L10)
    elseif A1 == 1 then
      L8(L9, L10)
    end
    for L11, L12 in L8, L9, L10 do
      L13 = _UPVALUE10_
      L14 = L7
      L15 = L12
      L13(L14, L15)
      if A1 == 0 then
        L13 = _UPVALUE11_
        L14 = L7
        L15 = L12
        L13(L14, L15)
      end
    end
  end
  for L6, L7 in L3, L4, L5 do
    L8(L9, L10)
    L8(L9, L10)
    if A1 == 0 then
      L8(L9, L10)
    end
    for L11, L12 in L8, L9, L10 do
      L13 = _UPVALUE10_
      L14 = L7
      L15 = L12
      L13(L14, L15)
      if A1 == 0 then
        L13 = _UPVALUE11_
        L14 = L7
        L15 = L12
        L13(L14, L15)
      end
    end
  end
  for L6, L7 in L3, L4, L5 do
    L8(L9, L10)
    L8(L9, L10)
    if A1 == 0 then
      L8(L9, L10)
    end
    for L11, L12 in L8, L9, L10 do
      L13 = _UPVALUE10_
      L14 = L7
      L15 = L12
      L13(L14, L15)
      if A1 == 0 then
        L13 = _UPVALUE11_
        L14 = L7
        L15 = L12
        L13(L14, L15)
      end
    end
  end
end
apply_wl_maclist_acl_rule = L48
function L48(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  if A1 then
    L3 = type
    L4 = A1
    L3 = L3(L4)
    if L3 == "table" then
      L3 = _UPVALUE0_
      L3 = L3.isStrNil
      L4 = A2
      L3 = L3(L4)
      if not L3 then
        goto lbl_16
      end
    end
  end
  L3 = 2
  do return L3 end
  ::lbl_16::
  L3 = require
  L4 = "xiaoqiang.util.XQSynchrodata"
  L3 = L3(L4)
  L4 = tonumber
  L5 = A0
  L4 = L4(L5)
  if L4 == 0 then
    L4 = "wifiblist"
    if L4 then
      goto lbl_28
    end
  end
  L4 = "wifiwlist"
  ::lbl_28::
  L5 = _UPVALUE1_
  L6 = L5
  L5 = L5.get_list
  L7 = L4
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  L6 = getCurrentMacfilterList
  L6 = L6()
  L7 = tonumber
  L7 = L7(L8)
  A0 = L7
  L7 = {}
  for L11, L12 in L8, L9, L10 do
    L13 = _UPVALUE0_
    L13 = L13.macFormat
    L14 = L12
    L13 = L13(L14)
    L7[L13] = 1
  end
  if A2 == 0 then
    for L11, L12 in L8, L9, L10 do
      L13 = _UPVALUE0_
      L13 = L13.isStrNil
      L14 = L12
      L13 = L13(L14)
      if not L13 then
        L13 = _UPVALUE0_
        L13 = L13.macFormat
        L14 = L12
        L13 = L13(L14)
        L7[L13] = 1
      end
    end
  else
    for L11, L12 in L8, L9, L10 do
      L13 = _UPVALUE0_
      L13 = L13.isStrNil
      L14 = L12
      L13 = L13(L14)
      if not L13 then
        L13 = _UPVALUE0_
        L13 = L13.macFormat
        L14 = L12
        L13 = L13(L14)
        L7[L13] = 0
      end
    end
  end
  L5 = L8
  for L11, L12 in L8, L9, L10 do
    if L12 == 1 then
      L13 = table
      L13 = L13.insert
      L14 = L5
      L15 = _UPVALUE0_
      L15 = L15._cmdformat
      L16 = L11
      L15, L16 = L15(L16)
      L13(L14, L15, L16)
    end
  end
  if 32 < L8 then
    return L8
  end
  if 0 < L8 then
    L13 = L5
    L8(L9, L10, L11, L12, L13)
  else
    L8(L9, L10, L11, L12)
  end
  if A0 == 0 then
    if L6 then
      for L13, L14 in L10, L11, L12 do
        L15 = _UPVALUE0_
        L15 = L15.macFormat
        L16 = L14
        L15 = L15(L16)
        L8[L15] = 1
      end
    end
    if A2 == 0 then
      for L13, L14 in L10, L11, L12 do
        L15 = _UPVALUE0_
        L15 = L15.macFormat
        L16 = L14
        L15 = L15(L16)
        L14 = L15
        L15 = L8[L14]
        if not L15 then
          L9[L14] = 1
        end
      end
    elseif A2 == 1 then
      for L13, L14 in L10, L11, L12 do
        L15 = _UPVALUE0_
        L15 = L15.macFormat
        L16 = L14
        L15 = L15(L16)
        L14 = L15
        L15 = L8[L14]
        if L15 then
          L9[L14] = 0
        end
      end
    end
    for L13, L14 in L10, L11, L12 do
      L15 = L3.syncDeviceInfo
      L16 = {}
      L16.mac = L13
      L16.limited = L14
      L15(L16)
    end
  end
  L8(L9, L10)
  L8(L9, L10)
  if A0 == 1 then
    L8(L9)
  end
  L8(L9)
end
editWiFiMacfilterList = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.network"
  L2 = L2(L3)
  L2 = L2.init
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.util.XQDBUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.XQEquipment"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQPushUtil"
  L5 = L5(L6)
  L7 = L2
  L6 = L2.get_wifinet
  L8 = _wifiNameForIndex
  L9 = 1
  L8, L9, L10, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24 = L8(L9)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24)
  L7 = L5.pushSettings
  L7 = L7()
  L8 = {}
  L9 = L7.auth
  if L9 then
    L9 = 1
    if L9 then
      goto lbl_33
    end
  end
  L9 = 0
  ::lbl_33::
  L8.enable = L9
  L8.model = 0
  if L6 then
    L10 = L6
    L9 = L6.get
    L9 = L9(L10, L11)
    if L9 == "disabled" then
      L8.model = 0
    elseif L9 == "deny" then
      L8.model = 0
    elseif L9 == "allow" then
      L8.model = 1
    else
      L8.model = 0
    end
  end
  L9 = {}
  L10 = getWiFiMacfilterList
  if A0 == nil then
    if L11 then
      goto lbl_61
    end
  end
  ::lbl_61::
  L10 = L10(L11)
  for L14, L15 in L11, L12, L13 do
    L16 = _UPVALUE0_
    L16 = L16.macFormat
    L17 = L15
    L16 = L16(L17)
    L15 = L16
    L16 = {}
    L16.mac = L15
    L17 = ""
    L18 = L3.fetchDeviceInfo
    L19 = L15
    L18 = L18(L19)
    if L18 then
      L19 = L18.oName
      L20 = L18.nickname
      L21 = _UPVALUE0_
      L21 = L21.isStrNil
      L22 = L20
      L21 = L21(L22)
      if not L21 then
        L17 = L20
      else
        L21 = L4.identifyDevice
        L22 = L15
        L23 = L19
        L21 = L21(L22, L23)
        L22 = L21.type
        L23 = _UPVALUE0_
        L23 = L23.isStrNil
        L24 = L17
        L23 = L23(L24)
        if L23 then
          L23 = _UPVALUE0_
          L23 = L23.isStrNil
          L24 = L22.n
          L23 = L23(L24)
          if not L23 then
            L17 = L22.n
          end
        end
        L23 = _UPVALUE0_
        L23 = L23.isStrNil
        L24 = L17
        L23 = L23(L24)
        if L23 then
          L23 = _UPVALUE0_
          L23 = L23.isStrNil
          L24 = L19
          L23 = L23(L24)
          if not L23 then
            L17 = L19
          end
        end
        L23 = _UPVALUE0_
        L23 = L23.isStrNil
        L24 = L17
        L23 = L23(L24)
        if L23 then
          L23 = _UPVALUE0_
          L23 = L23.isStrNil
          L24 = L21.name
          L23 = L23(L24)
          if not L23 then
            L17 = L21.name
          end
        end
        L23 = _UPVALUE0_
        L23 = L23.isStrNil
        L24 = L17
        L23 = L23(L24)
        if L23 then
          L17 = L15
        end
        L23 = L22.c
        if L23 == 3 then
          L23 = _UPVALUE0_
          L23 = L23.isStrNil
          L24 = L20
          L23 = L23(L24)
          if L23 then
            L17 = L22.n
          end
        end
      end
      L16.name = L17
    end
    L19 = table
    L19 = L19.insert
    L20 = L9
    L21 = L16
    L19(L20, L21)
  end
  L8.maclist = L9
  L8.weblist = L10
  return L8
end
getWiFiMacfilterInfo = L48
function L48(A0, A1)
  local L2, L3, L4, L5, L6, L7
  for L5, L6 in L2, L3, L4 do
    if L6 == A1 then
      L7 = true
      return L7
    end
  end
  return L2
end
contains = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  if A0 then
    if L2 ~= 0 then
      goto lbl_10
    end
  end
  do return end
  ::lbl_10::
  for L5, L6 in L2, L3, L4 do
    L8 = L1
    L7 = L1.get_wifinet
    L7 = L7(L8, L9)
    if L7 then
      L8 = L7.assoclist
      L8 = L8(L9)
      if L8 then
        for L12, L13 in L9, L10, L11 do
          L14 = contains
          L15 = A0
          L16 = L12
          L14 = L14(L15, L16)
          if not L14 then
            L14 = _UPVALUE2_
            L15 = L6
            L16 = _UPVALUE3_
            L16 = L16._cmdformat
            L17 = L12
            L16, L17 = L16(L17)
            L14(L15, L16, L17)
          end
        end
      end
    end
  end
end
kick_wl_connected_device = L48
function L48(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  if A0 == false then
    for L6, L7 in L3, L4, L5 do
      L8 = _UPVALUE1_
      L9 = L7
      L10, L11 = nil, nil
      L8(L9, L10, L11)
      L8 = _UPVALUE2_
      L9 = L7
      L10 = _UPVALUE3_
      L8(L9, L10)
      L8 = _UPVALUE2_
      L9 = L7
      L10 = _UPVALUE4_
      L8(L9, L10)
    end
    for L6, L7 in L3, L4, L5 do
      L8 = _UPVALUE1_
      L9 = L7
      L10, L11 = nil, nil
      L8(L9, L10, L11)
      L8 = _UPVALUE2_
      L9 = L7
      L10 = _UPVALUE3_
      L8(L9, L10)
      L8 = _UPVALUE2_
      L9 = L7
      L10 = _UPVALUE4_
      L8(L9, L10)
    end
    for L6, L7 in L3, L4, L5 do
      L8 = _UPVALUE1_
      L9 = L7
      L10, L11 = nil, nil
      L8(L9, L10, L11)
      L8 = _UPVALUE2_
      L9 = L7
      L10 = _UPVALUE3_
      L8(L9, L10)
      L8 = _UPVALUE2_
      L9 = L7
      L10 = _UPVALUE4_
      L8(L9, L10)
    end
    L3(L4, L5)
    L3(L4, L5)
    L6 = "0"
    L4(L5, L6)
  else
    if A1 == 1 then
      L2 = L3
    elseif A1 == 0 then
      L2 = L3
    end
    for L6, L7 in L3, L4, L5 do
      L8 = _UPVALUE8_
      L8 = L8._cmdformat
      L9 = L7
      L8 = L8(L9)
      L7 = L8
    end
    L3(L4, L5)
    if A1 == 1 then
      L3(L4)
    end
  end
end
setWiFiMacfilterModel = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = luci
  L0 = L0.sys
  L0 = L0.exec
  L1 = "getmac wan"
  L0 = L0(L1)
  L1 = string
  L1 = L1.upper
  L2 = string
  L2 = L2.sub
  L3 = string
  L3 = L3.gsub
  L4 = L0
  L5 = ":"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L4 = -5
  L5 = -2
  L2, L3, L4, L5, L6, L7, L8 = L2(L3, L4, L5)
  L1 = L1(L2, L3, L4, L5, L6, L7, L8)
  L2 = require
  L3 = "xiaoqiang.XQCountryCode"
  L2 = L2(L3)
  L3 = L2.getCurrentCountryCode
  L3 = L3()
  L4 = require
  L5 = "xiaoqiang.util.XQSysUtil"
  L4 = L4(L5)
  L5 = nil
  L6 = "  MiShareWiFi_"
  if L3 == "CN" then
    L7 = L4.isRedmi
    L7 = L7()
    if 1 == L7 then
      L6 = "  Redmi\229\133\177\228\186\171WiFi_"
    else
      L6 = "  \229\176\143\231\177\179\229\133\177\228\186\171WiFi_"
    end
  end
  L7 = L6
  L8 = L1
  L5 = L7 .. L8
  return L5
end
getGuestWifi_ssid = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = tonumber
  L2 = A0
  L1 = L1(L2)
  index = L1
  L1 = index
  L2 = _UPVALUE0_
  L2 = #L2
  if L1 > L2 then
    L1 = nil
    return L1
  end
  L1 = _UPVALUE0_
  L2 = index
  L1 = L1[L2]
  L2 = getGuestWifi_ssid
  L2 = L2()
  if nil == L1 then
    L3 = nil
    return L3
  end
  L3 = _UPVALUE1_
  L3 = L3.init
  L3 = L3()
  L5 = L3
  L4 = L3.get_wifinet
  L6 = L1
  L4 = L4(L5, L6)
  if L4 then
    L5 = {}
    L5.ifname = L1
    L7 = L4
    L6 = L4.ssid
    L6 = L6(L7)
    L6 = L6 or L6
    L5.ssid = L6
    L7 = L4
    L6 = L4.get
    L8 = "encryption"
    L6 = L6(L7, L8)
    L6 = L6 or L6
    L5.encryption = L6
    L7 = L4
    L6 = L4.get
    L8 = "key"
    L6 = L6(L7, L8)
    if not L6 then
      L7 = L4
      L6 = L4.get
      L8 = "sae_password"
      L6 = L6(L7, L8)
      L6 = L6 or L6
    end
    L5.password = L6
    L6 = tonumber
    L8 = L4
    L7 = L4.disabled
    L7, L8 = L7(L8)
    L6 = L6(L7, L8)
    if L6 == 0 then
      L6 = 1
      if L6 then
        goto lbl_66
      end
    end
    L6 = 0
    ::lbl_66::
    L5.status = L6
    L5.enabled = "1"
    L7 = L4
    L6 = L4.get
    L8 = "closingTime"
    L6 = L6(L7, L8)
    L6 = L6 or L6
    L5.closingTime = L6
    return L5
  else
    L5 = {}
    L5.ifname = L1
    L5.ssid = L2
    L5.encryption = "psk2"
    L5.password = "12345678"
    L5.status = "0"
    L5.enabled = "1"
    L5.closingTime = "0"
    return L5
  end
end
getGuestWifi = L48
function L48()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get_all
  L3 = "network"
  L4 = "guest"
  L1 = L1(L2, L3, L4)
  if L1 then
    L2 = true
    return L2
  end
  L2 = false
  return L2
end
_checkGuestWifi = L48
function L48(A0)
  local L1, L2, L3
  L1 = true
  L2 = _checkGuestWifi
  L2 = L2()
  if L2 then
    L1 = false
  end
  if A0 then
    L2 = type
    L3 = A0
    L2 = L2(L3)
    if L2 == "function" then
      L2 = A0
      L3 = L1
      L2(L3)
  end
  elseif L1 then
    L2 = _UPVALUE0_
    L2 = L2.forkExec
    L3 = "sleep 4; /usr/sbin/guestwifi.sh open; lua /usr/sbin/sync_guest_bssid.lua >/dev/null 2>/dev/null"
    L2(L3)
  else
    L2 = _UPVALUE0_
    L2 = L2.forkRestartWifi
    L3 = "lua /usr/sbin/sync_guest_bssid.lua"
    L2(L3)
  end
  L2 = true
  return L2
end
enableGuestWifi = L48
function L48(A0, A1, A2, A3, A4, A5, A6, A7)
  local L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L8 = _UPVALUE0_
  L8 = #L8
  if not (A0 > L8) then
    L8 = _UPVALUE1_
    L8 = L8.isStrNil
    L9 = A1
    L8 = L8(L9)
    if not L8 then
      goto lbl_13
    end
  end
  L8 = false
  do return L8 end
  ::lbl_13::
  L8 = _UPVALUE2_
  L8 = L8.init
  L8 = L8()
  L10 = L8
  L9 = L8.get_wifidev
  L11 = _UPVALUE3_
  L11 = L11[A0]
  L9 = L9(L10, L11)
  if nil == L9 then
    L10 = false
    return L10
  end
  L10 = tonumber
  L12 = L9
  L11 = L9.get
  L13 = "disabled"
  L11, L12, L13, L14, L15, L16, L17, L18, L19 = L11(L12, L13)
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L11 = tonumber
  L12 = A5
  L11 = L11(L12)
  A5 = L11
  if 1 == L10 and 1 == A5 then
    L12 = L9
    L11 = L9.set
    L13 = "disabled"
    L14 = "0"
    L11(L12, L13, L14)
  end
  L11 = _UPVALUE0_
  L11 = L11[A0]
  L13 = L8
  L12 = L8.get_wifinet
  L14 = L11
  L12 = L12(L13, L14)
  L14 = L8
  L13 = L8.get_wifinet
  L15 = _UPVALUE4_
  L15 = L15[A0]
  L13 = L13(L14, L15)
  L14 = _UPVALUE5_
  L14 = L14[A0]
  if nil == L12 then
    L15 = {}
    L17 = L9
    L16 = L9.name
    L16 = L16(L17)
    L15.device = L16
    L15.ifname = L11
    L15.network = "guest"
    L15.mode = "ap"
    L15.twt_responder = 0
    if L13 then
      L17 = L13
      L16 = L13.get
      L18 = "macfilter"
      L16 = L16(L17, L18)
      if L16 == "deny" then
        L15.macfilter = L16
        L17 = getCurrentMacfilterList
        L17 = L17()
        L15.maclist = L17
      end
    end
    L17 = L9
    L16 = L9.add_wifinet_s
    L18 = L14
    L19 = L15
    L16(L17, L18, L19)
    L17 = L8
    L16 = L8.save
    L18 = "wireless"
    L16(L17, L18)
    L17 = L8
    L16 = L8.get_wifinet
    L18 = L11
    L16 = L16(L17, L18)
    L12 = L16
  end
  if nil == L12 then
    L15 = false
    return L15
  end
  L15 = checkWifiPasswd
  L16 = A3
  L17 = A2
  L15 = L15(L16, L17)
  if L15 ~= 0 then
    L16 = false
    return L16
  end
  L17 = L12
  L16 = L12.set
  L18 = "ap_isolate"
  L19 = "1"
  L16(L17, L18, L19)
  L17 = L12
  L16 = L12.set
  L18 = "ssid"
  L19 = A1
  L16(L17, L18, L19)
  L17 = L12
  L16 = L12.set
  L18 = "closingTime"
  L19 = A7
  L16(L17, L18, L19)
  L17 = L12
  L16 = L12.set
  L18 = "encryption"
  L19 = A2
  L16(L17, L18, L19)
  L17 = L12
  L16 = L12.set
  L18 = "disabled"
  if A5 == 1 then
    L19 = "0"
    if L19 then
      goto lbl_120
    end
  end
  L19 = "1"
  ::lbl_120::
  L16(L17, L18, L19)
  if A2 == "ccmp" then
    L17 = L12
    L16 = L12.set
    L18 = "sae"
    L19 = "1"
    L16(L17, L18, L19)
    L17 = L12
    L16 = L12.set
    L18 = "key"
    L19 = ""
    L16(L17, L18, L19)
    L17 = L12
    L16 = L12.set
    L18 = "sae_password"
    L19 = A3
    L16(L17, L18, L19)
    L17 = L12
    L16 = L12.set
    L18 = "ieee80211w"
    L19 = 2
    L16(L17, L18, L19)
  elseif A2 == "psk2+ccmp" then
    L17 = L12
    L16 = L12.set
    L18 = "sae"
    L19 = "1"
    L16(L17, L18, L19)
    L17 = L12
    L16 = L12.set
    L18 = "key"
    L19 = A3
    L16(L17, L18, L19)
    L17 = L12
    L16 = L12.set
    L18 = "sae_password"
    L19 = A3
    L16(L17, L18, L19)
    L17 = L12
    L16 = L12.set
    L18 = "ieee80211w"
    L19 = 1
    L16(L17, L18, L19)
  else
    L17 = L12
    L16 = L12.set
    L18 = "sae"
    L19 = ""
    L16(L17, L18, L19)
    L17 = L12
    L16 = L12.set
    L18 = "key"
    L19 = A3
    L16(L17, L18, L19)
    L17 = L12
    L16 = L12.set
    L18 = "sae_password"
    L19 = ""
    L16(L17, L18, L19)
    L17 = L12
    L16 = L12.set
    L18 = "ieee80211w"
    L19 = ""
    L16(L17, L18, L19)
  end
  L17 = L12
  L16 = L12.set
  L18 = "wpsdevicename"
  L19 = A6 or L19
  if not A6 then
    L19 = "XIAOMI_ROUTER_GUEST"
  end
  L16(L17, L18, L19)
  L16 = _UPVALUE2_
  L17 = L16
  L16 = L16.save
  L18 = "wireless"
  L16(L17, L18)
  L16 = _UPVALUE2_
  L17 = L16
  L16 = L16.commit
  L18 = "wireless"
  L16(L17, L18)
  L16 = true
  return L16
end
setGuestWifi = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = _UPVALUE0_
  L1 = #L1
  if A0 > L1 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE1_
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_wifidev
  L4 = _UPVALUE2_
  L4 = L4[A0]
  L2 = L2(L3, L4)
  if nil == L2 then
    L3 = false
    return L3
  end
  L3 = _UPVALUE0_
  L3 = L3[A0]
  L5 = L1
  L4 = L1.get_wifinet
  L6 = L3
  L4 = L4(L5, L6)
  if nil == L4 then
    L5 = false
    return L5
  end
  L6 = L4
  L5 = L4.set
  L7 = "disabled"
  L8 = "1"
  L5(L6, L7, L8)
  L5 = _UPVALUE1_
  L6 = L5
  L5 = L5.save
  L7 = "wireless"
  L5(L6, L7)
  L5 = _UPVALUE1_
  L6 = L5
  L5 = L5.commit
  L7 = "wireless"
  L5(L6, L7)
  L5 = true
  return L5
end
closeGuestWifi = L48
function L48(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = #L1
  if A0 > L1 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE1_
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.del_wifinet
  L4 = _UPVALUE0_
  L4 = L4[A0]
  L2(L3, L4)
  L3 = L1
  L2 = L1.save
  L4 = "wireless"
  L2(L3, L4)
  L3 = L1
  L2 = L1.commit
  L4 = "wireless"
  L2(L3, L4)
  L2 = true
  return L2
end
delGuestWifi = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L1 = {}
  L1.code = 0
  L2, L3, L4, L5 = nil, nil, nil, nil
  L6 = tonumber
  L7 = A0
  L6 = L6(L7)
  if L6 == 1 then
    L6 = "wl1"
    if L6 then
      goto lbl_13
    end
  end
  L6 = "wl0"
  ::lbl_13::
  L7 = "setchanauto.sh "
  L8 = tostring
  L9 = L6
  L8 = L8(L9)
  L9 = " getresult"
  L7 = L7 .. L8 .. L9
  L8 = _UPVALUE0_
  L8 = L8.execl
  L9 = L7
  L8 = L8(L9)
  L9 = {}
  if L8 then
    for L13, L14 in L10, L11, L12 do
      L15 = _UPVALUE1_
      L15 = L15.isStrNil
      L16 = L14
      L15 = L15(L16)
      if not L15 then
        if not L2 or not L4 then
          L16 = L14
          L15 = L14.match
          L17 = "^Current Channel (%S+) : Score = (%d+)"
          L15, L16 = L15(L16, L17)
          L4 = L16
          L2 = L15
        end
        if not L3 or not L5 then
          L16 = L14
          L15 = L14.match
          L17 = "^Select Channel (%S+) : Score = (%d+)"
          L15, L16 = L15(L16, L17)
          L5 = L16
          L3 = L15
        end
        L16 = L14
        L15 = L14.match
        L17 = "^Channel (%S+) : Score = (%d+)"
        L15, L16 = L15(L16, L17)
        if L15 and L16 then
          L17 = tonumber
          L18 = L16
          L17 = L17(L18)
          L9[L15] = L17
        end
      end
    end
  end
  if L2 and L3 and L4 and L5 then
    L1.cchannel = L10
    L1.schannel = L10
    L1.cscore = L10
    L1.sscore = L10
    for L14, L15 in L11, L12, L13 do
      if L14 ~= L2 then
        L16 = L1.cscore
        if L15 < L16 then
        end
      end
    end
    L1.ranking = L10
  else
    L1.code = 1
    L1.cchannel = L10
    L1.schannel = L10
    L1.cscore = L10
    L1.sscore = L10
    L1.ranking = 0
  end
  return L1
end
scanWifiChannel = L48
function L48()
  local L0, L1, L2
  L0 = getAllWifiInfo
  L0 = L0()
  L1 = L0[1]
  if L1 then
    L1 = L0[1]
    L1 = L1.status
    if L1 == "1" then
      L1 = _UPVALUE0_
      L1 = L1.forkExec
      L2 = "sleep 4; iwpriv wl1 acsreport 1 > /dev/null"
      L1(L2)
    end
  end
end
wifiChannelQuality = L48
function L48(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  if A0 then
    L2 = "sleep 4; iwconfig wl1 channel \""
    L3 = _UPVALUE0_
    L3 = L3._cmdformat
    L4 = tostring
    L5 = A0
    L4, L5, L6, L7, L8, L9 = L4(L5)
    L3 = L3(L4, L5, L6, L7, L8, L9)
    L4 = "\""
    L2 = L2 .. L3 .. L4
    L3 = channelHelper
    L4 = A0
    L3 = L3(L4)
    L4 = _UPVALUE1_
    L4 = L4.init
    L4 = L4()
    L6 = L4
    L5 = L4.get_wifidev
    L7 = _UPVALUE2_
    L7 = L7.split
    L8 = _wifiNameForIndex
    L9 = 1
    L8 = L8(L9)
    L9 = "."
    L7 = L7(L8, L9)
    L7 = L7[1]
    L5 = L5(L6, L7)
    L7 = L5
    L6 = L5.set
    L8 = "bw"
    L9 = L3.bandwidth
    L6(L7, L8, L9)
    L7 = L5
    L6 = L5.set
    L8 = "autoch"
    L9 = "0"
    L6(L7, L8, L9)
    L7 = L5
    L6 = L5.set
    L8 = "channel"
    L9 = L3.channel
    L6(L7, L8, L9)
    L7 = L4
    L6 = L4.commit
    L8 = "wireless"
    L6(L7, L8)
    L6 = _UPVALUE0_
    L6 = L6.forkExec
    L7 = L2
    L6(L7)
  end
end
iwprivSetChannel = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = _UPVALUE0_
  L2 = L2.init
  L2 = L2()
  L4 = L1
  L3 = L1.get_list
  L5 = "misc"
  L6 = "wireless"
  L7 = "device_"
  L8 = A0
  L9 = "_name"
  L7 = L7 .. L8 .. L9
  L3 = L3(L4, L5, L6, L7)
  if L3 ~= nil then
    L5 = L2
    L4 = L2.get_wifidev
    L6 = L3
    return L4(L5, L6)
  else
    L4 = nil
    return L4
  end
end
wifiutil_get_dev_info_form_band = L48
function L48(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  L4 = _UPVALUE0_
  L4 = L4.init
  L4 = L4()
  L6 = L4
  L5 = L4.get_wifinet
  L7 = _wifiNameForIndex
  L8 = A0
  L7, L8, L9 = L7(L8)
  L5 = L5(L6, L7, L8, L9)
  if L5 == nil then
    L6 = false
    return L6
  end
  L6 = _UPVALUE1_
  L6 = L6.isStrNil
  L7 = A1
  L6 = L6(L7)
  if not L6 then
    L7 = L5
    L6 = L5.set
    L8 = "weakenable"
    L9 = A1
    L6(L7, L8, L9)
  end
  L6 = _UPVALUE1_
  L6 = L6.isStrNil
  L7 = A2
  L6 = L6(L7)
  if not L6 then
    L7 = L5
    L6 = L5.set
    L8 = "weakthreshold"
    L9 = A2
    L6(L7, L8, L9)
  end
  L6 = _UPVALUE1_
  L6 = L6.isStrNil
  L7 = A3
  L6 = L6(L7)
  if not L6 then
    L7 = L5
    L6 = L5.set
    L8 = "kickthreshold"
    L9 = A3
    L6(L7, L8, L9)
  end
  L7 = L4
  L6 = L4.save
  L8 = "wireless"
  L6(L7, L8)
  L7 = L4
  L6 = L4.commit
  L8 = "wireless"
  L6(L7, L8)
  L6 = true
  return L6
end
setWifiWeakInfo = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = {}
  L1 = {}
  L2 = wifiNetworks
  L2 = L2()
  for L6, L7 in L3, L4, L5 do
    L8 = {}
    L9 = 1
    L10 = L7.networks
    L10 = L10[L9]
    L10 = L10.weakenable
    L10 = L10 or L10
    L8.weakenable = L10
    L10 = L7.networks
    L10 = L10[L9]
    L10 = L10.weakthreshold
    L10 = L10 or L10
    L8.weakthreshold = L10
    L10 = L7.networks
    L10 = L10[L9]
    L10 = L10.kickthreshold
    L10 = L10 or L10
    L8.kickthreshold = L10
    L10 = L7.device
    L1[L10] = L8
  end
  if L3 then
    L3(L4, L5)
  end
  if L3 then
    L3(L4, L5)
  end
  return L0
end
getWifiWeakInfo = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  if A0 then
    L4 = L2
    L3 = L2.set
    L5 = "miscan"
    L6 = "config"
    L7 = "enabled"
    L8 = "1"
    L3(L4, L5, L6, L7, L8)
  else
    L4 = L2
    L3 = L2.set
    L5 = "miscan"
    L6 = "config"
    L7 = "enabled"
    L8 = "0"
    L3(L4, L5, L6, L7, L8)
  end
  L4 = L2
  L3 = L2.commit
  L5 = "miscan"
  L3(L4, L5)
  if A0 then
    L3 = tonumber
    L4 = os
    L4 = L4.execute
    L5 = "/etc/init.d/scan start"
    L4, L5, L6, L7, L8 = L4(L5)
    L3 = L3(L4, L5, L6, L7, L8)
    L1 = L3
  else
    L3 = tonumber
    L4 = os
    L4 = L4.execute
    L5 = "/etc/init.d/scan stop"
    L4, L5, L6, L7, L8 = L4(L5)
    L3 = L3(L4, L5, L6, L7, L8)
    L1 = L3
  end
  if L1 ~= 0 then
    if A0 then
      L4 = L2
      L3 = L2.set
      L5 = "miscan"
      L6 = "config"
      L7 = "enabled"
      L8 = "0"
      L3(L4, L5, L6, L7, L8)
    else
      L4 = L2
      L3 = L2.set
      L5 = "miscan"
      L6 = "config"
      L7 = "enabled"
      L8 = "1"
      L3(L4, L5, L6, L7, L8)
    end
    L4 = L2
    L3 = L2.commit
    L5 = "miscan"
    L3(L4, L5)
    L3 = false
    return L3
  end
  L3 = _UPVALUE0_
  L3 = L3.forkExec
  L4 = "/sbin/whc_to_re_common_api.sh whc_sync"
  L3(L4)
  L3 = true
  return L3
end
miscanSwitch = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "miscan"
  L5 = "config"
  L6 = "enabled"
  L2 = L2(L3, L4, L5, L6)
  L0 = L2 or L0
  if not L2 then
    L0 = "0"
  end
  return L0
end
getMiscanSwitch = L48
function L48(A0)
  local L1, L2, L3, L4, L5
  if A0 then
    L1 = "iwconfig "
    L2 = A0
    L3 = " | awk 'NR==7' | awk -F '=' '{print $3}' | awk '{print $1}'"
    L1 = L1 .. L2 .. L3
    L2 = io
    L2 = L2.popen
    L3 = L1
    L2 = L2(L3)
    L4 = L2
    L3 = L2.read
    L5 = "*all"
    L3 = L3(L4, L5)
    L4 = tonumber
    L5 = L3
    return L4(L5)
  else
    L1 = 0
    return L1
  end
end
apcli_get_real_signal = L48
function L48(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if A1 ~= nil and A0 ~= nil then
    if L2 ~= 0 then
      goto lbl_10
    end
  end
  do return L2 end
  ::lbl_10::
  for L5, L6 in L2, L3, L4 do
    L7 = L6.mac
    if L7 == A1 then
      return L6
    end
  end
  return L2
end
_mesh_scanitem_get = L48
function L48(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if A1 ~= nil and A0 ~= nil then
    if L2 ~= 0 then
      goto lbl_10
    end
  end
  do return L2 end
  ::lbl_10::
  for L5, L6 in L2, L3, L4 do
    L7 = L6.obssid
    if L7 == A1 then
      return L6
    end
  end
  return L2
end
_mesh_scanobitem_get = L48
function L48(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if A1 ~= nil and A0 ~= nil then
    if L2 ~= 0 then
      goto lbl_10
    end
  end
  do return L2 end
  ::lbl_10::
  for L5, L6 in L2, L3, L4 do
    L7 = L6.ssid
    if L7 == A1 then
      return L6
    end
  end
  return L2
end
_mesh_scanssiditem_get = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = ""
  L2 = ""
  L3 = ""
  L4 = ""
  L5 = nil
  L6 = _UPVALUE0_
  L6 = L6.init
  L6 = L6()
  L7 = require
  L8 = "xiaoqiang.common.XQFunction"
  L7 = L7(L8)
  L8 = nil
  if A0 == "5g" then
    L1 = _UPVALUE1_
    L3 = _UPVALUE2_
  elseif A0 == "5gh" then
    L1 = _UPVALUE3_
    L3 = guest_ifname_5gh
  elseif A0 == "2g" then
    L1 = _UPVALUE4_
    L3 = _UPVALUE5_
  end
  L9 = "backhaul_"
  L10 = A0
  L11 = "_ap_iface"
  L4 = L9 .. L10 .. L11
  L9 = _UPVALUE6_
  L10 = L9
  L9 = L9.get
  L11 = "misc"
  L12 = "backhauls"
  L13 = L4
  L9 = L9(L10, L11, L12, L13)
  L2 = L9 or L2
  if not L9 then
    L2 = ""
  end
  L9 = L7.isStrNil
  L10 = L1
  L9 = L9(L10)
  if not L9 then
    L10 = L6
    L9 = L6.get_wifinet
    L11 = L1
    L9 = L9(L10, L11)
    L5 = L9
    L9 = _UPVALUE7_
    L9 = L9.exec
    L10 = "ifconfig "
    L11 = L1
    L10 = L10 .. L11
    L9 = L9(L10)
    L8 = L9
    if L5 then
      L10 = L5
      L9 = L5.disabled
      L9 = L9(L10)
      if L9 ~= "1" then
        L9 = L7.isStrNil
        L10 = L8
        L9 = L9(L10)
        if not L9 then
          return L1
        end
      end
    end
  end
  L9 = L7.isStrNil
  L10 = L2
  L9 = L9(L10)
  if not L9 then
    L10 = L6
    L9 = L6.get_wifinet
    L11 = L2
    L9 = L9(L10, L11)
    L5 = L9
    L9 = _UPVALUE7_
    L9 = L9.exec
    L10 = "ifconfig "
    L11 = L2
    L10 = L10 .. L11
    L9 = L9(L10)
    L8 = L9
    if L5 then
      L10 = L5
      L9 = L5.disabled
      L9 = L9(L10)
      if L9 ~= "1" then
        L9 = L7.isStrNil
        L10 = L8
        L9 = L9(L10)
        if not L9 then
          return L2
        end
      end
    end
  end
  L9 = L7.isStrNil
  L10 = L3
  L9 = L9(L10)
  if not L9 then
    L10 = L6
    L9 = L6.get_wifinet
    L11 = L3
    L9 = L9(L10, L11)
    L5 = L9
    L9 = _UPVALUE7_
    L9 = L9.exec
    L10 = "ifconfig "
    L11 = L3
    L10 = L10 .. L11
    L9 = L9(L10)
    L8 = L9
    if L5 then
      L10 = L5
      L9 = L5.disabled
      L9 = L9(L10)
      if L9 ~= "1" then
        L9 = L7.isStrNil
        L10 = L8
        L9 = L9(L10)
        if not L9 then
          return L3
        end
      end
    end
  end
  L9 = nil
  return L9
end
mesh_get_scaniface = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = {}
  L2 = require
  L3 = "miwifi_mesh"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = mesh_get_scaniface
  L6 = A0
  L5 = L5(L6)
  L6 = L4.isStrNil
  L7 = L5
  L6 = L6(L7)
  if not L6 then
    L6 = L2.relist
    L7 = L5
    L6 = L6(L7)
    L1 = L6
  else
    L6 = _UPVALUE0_
    L7 = L6
    L6 = L6.get
    L8 = "misc"
    L9 = "wireless"
    L10 = "mesh_ifname_5G"
    L6 = L6(L7, L8, L9, L10)
    L6 = L6 or L6
    L7 = L4.isStrNil
    L8 = L6
    L7 = L7(L8)
    if not L7 then
      L7 = _UPVALUE1_
      L7 = L7.exec
      L8 = "/usr/sbin/mesh_connect.sh setup_scaniface "
      L9 = A0
      L10 = " "
      L11 = L6
      L8 = L8 .. L9 .. L10 .. L11
      L7(L8)
      L7 = L2.relist
      L8 = L6
      L7 = L7(L8)
      L1 = L7
      L7 = _UPVALUE1_
      L7 = L7.exec
      L8 = "/usr/sbin/mesh_connect.sh clean_scaniface "
      L9 = L6
      L8 = L8 .. L9
      L7(L8)
    end
  end
  return L1
end
mesh_relist = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24
  L1 = require
  L2 = "miwifi_mesh"
  L1 = L1(L2)
  L2 = {}
  L3 = require
  L4 = "cjson"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQSysUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.common.XQFunction"
  L5 = L5(L6)
  L6 = L4.isSupportMeshVersion
  L7 = 4
  L6 = L6(L7)
  L7 = L4.isMeshMLOSupport_2G
  L7 = L7()
  L7 = L7 or L7
  L8 = L6 or L8
  if L6 then
    L8 = L5.isMeshCap
    L8 = L8()
  end
  if L8 then
    L9 = _UPVALUE0_
    L9 = L9.exec
    L10 = "ubus call xq_info_sync_mqtt relist '{\"action\":\"update\"}'"
    L9(L10)
  end
  L9 = ""
  L10 = ""
  L11 = _UPVALUE1_
  L11 = L11.init
  L11 = L11()
  L10 = L12
  if 0 < L12 then
    for L15, L16 in L12, L13, L14 do
      L18 = L2
      L19 = L16.mac
      L18 = _mesh_scanssiditem_get
      L19 = L2
      L20 = L16.ssid
      L18 = L18(L19, L20)
      if L17 == nil and L18 == nil then
        L19 = table
        L19 = L19.insert
        L20 = L2
        L21 = L16
        L19(L20, L21)
      end
    end
  end
  if L12 == "1" then
    L10 = L13
    if 0 < L13 then
      for L16, L17 in L13, L14, L15 do
        L18 = _mesh_scanitem_get
        L19 = L2
        L20 = L17.obssid
        L18 = L18(L19, L20)
        L19 = _mesh_scanobitem_get
        L20 = L2
        L21 = L17.mac
        L19 = L19(L20, L21)
        if L18 == nil and L19 == nil then
          L20 = table
          L20 = L20.insert
          L21 = L2
          L22 = L17
          L20(L21, L22)
        end
      end
    end
  end
  if L7 then
    L10 = L13
    if 0 < L13 then
      for L16, L17 in L13, L14, L15 do
        L18 = _mesh_scanitem_get
        L19 = L2
        L20 = L17.mac
        L18 = L18(L19, L20)
        L19 = _mesh_scanssiditem_get
        L20 = L2
        L21 = L17.ssid
        L19 = L19(L20, L21)
        if L18 == nil and L19 == nil then
          L20 = table
          L20 = L20.insert
          L21 = L2
          L22 = L17
          L20(L21, L22)
        end
      end
    end
  end
  if L8 then
    if L13 ~= nil then
      if 0 < L15 then
        for L18, L19 in L15, L16, L17 do
          L20 = _mesh_scanitem_get
          L21 = L2
          L22 = L19.mac
          L20 = L20(L21, L22)
          L21 = _mesh_scanssiditem_get
          L22 = L2
          L23 = L19.ssid
          L21 = L21(L22, L23)
          if L20 == nil and L21 == nil then
            L22 = table
            L22 = L22.insert
            L23 = L2
            L24 = L19
            L22(L23, L24)
          else
            L22 = L20 or L22
            if not L20 then
              L22 = L21
            end
            it = L22
            L22 = L19.rssi
            L23 = it
            L23 = L23.rssi
            if L22 > L23 then
              L22 = it
              L23 = L19.rssi
              L22.rssi = L23
            end
          end
        end
        sort_rssi_dec = L15
        L15(L16, L17)
      end
    end
  end
  L18, L19, L20, L21, L22, L23, L24 = L14(L15)
  L13(L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24)
  L18, L19, L20, L21, L22, L23, L24 = L14(L15)
  L13(L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24)
  if L13 then
    L15(L16, L17)
    L15(L16)
  end
  if L6 then
    L18, L19, L20, L21, L22, L23, L24 = L15(L16)
    L14(L15, L16, L17, L18, L19, L20, L21, L22, L23, L24)
    L18, L19, L20, L21, L22, L23, L24 = L15(L16)
    L14(L15, L16, L17, L18, L19, L20, L21, L22, L23, L24)
    for L17, L18 in L14, L15, L16 do
      L19 = L18.mesh_ver
      if 4 <= L19 then
        L19 = _UPVALUE0_
        L19 = L19.execl
        L20 = string
        L20 = L20.format
        L21 = "echo \"%s\" >> /tmp/re_deal_list"
        L22 = L18.mac
        L20, L21, L22, L23, L24 = L20(L21, L22)
        L19(L20, L21, L22, L23, L24)
      end
    end
  end
  return L2
end
mesh_get_scanlist = L48
function L48(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = require
  L3 = "cjson"
  L2 = L2(L3)
  L3 = io
  L3 = L3.open
  L4 = "/tmp/re_scan_list"
  L5 = "r"
  L3 = L3(L4, L5)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = ""
  if L3 then
    L6 = L3.read
    L6 = L6(L7, L8)
    scan_list = L7
    for L10, L11 in L7, L8, L9 do
      L12 = L11.mac
      if A0 == L12 then
        L5 = L11.obssid
        break
      else
        L12 = L11.obssid
        if A0 == L12 then
          L5 = L11.mac
          break
        end
      end
    end
    L7(L8)
  end
  L6 = L4.isMeshCap
  L6 = L6()
  if L6 then
    L6 = L4.forkExec
    L10 = A1
    L11 = "\",\"obssid\":\""
    L12 = L5
    L13 = "\"}'"
    L6(L7)
  end
  L6 = L4.forkExec
  L10 = A1
  L11 = "\",\"obssid\":\""
  L12 = L5
  L13 = "\"}'"
  L6(L7)
end
mesh_ver4_add_node = L48
function L48(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L2 = require
  L3 = "cjson"
  L2 = L2(L3)
  L3 = io
  L3 = L3.open
  L4 = "/tmp/re_scan_list"
  L5 = "r"
  L3 = L3(L4, L5)
  L4 = {}
  L5 = require
  L6 = "xiaoqiang.XQStatPoints"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.execl
  L7 = string
  L7 = L7.format
  L7, L11, L12, L13, L14, L15, L16 = L7(L8)
  L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16)
  L6 = _UPVALUE0_
  L6 = L6.execl
  L7 = string
  L7 = L7.format
  L7, L11, L12, L13, L14, L15, L16 = L7(L8)
  L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16)
  L6 = io
  L6 = L6.open
  L7 = "/var/run/scanrelist"
  L6 = L6(L7, L8)
  if L3 and L6 then
    L7 = L3.read
    L7 = L7(L8, L9)
    L4 = L8
    for L11, L12 in L8, L9, L10 do
      L13 = L12.mac
      if A0 == L13 then
        L13 = L2.encode
        L14 = L12
        L13 = L13(L14)
        L15 = L6
        L14 = L6.write
        L16 = L13
        L14(L15, L16)
      end
    end
  end
  if L3 then
    L7 = L3.close
    L7(L8)
  end
  if L6 then
    L7 = L6.close
    L7(L8)
  end
  L7 = _UPVALUE1_
  L7 = L7.isStrNil
  L7 = L7(L8)
  if L7 then
    L7 = _UPVALUE1_
    L7 = L7.forkExec
    L11 = A0
    L11, L12, L13, L14, L15, L16 = L10(L11)
    L11, L12, L13, L14, L15, L16 = L8(L9, L10, L11, L12, L13, L14, L15, L16)
    L7(L8, L9, L10, L11, L12, L13, L14, L15, L16)
  else
    L7 = _UPVALUE1_
    L7 = L7.forkExec
    L11 = A0
    L11 = _UPVALUE1_
    L11 = L11._strformat
    L12 = A1
    L11, L12, L13, L14, L15, L16 = L11(L12)
    L11, L12, L13, L14, L15, L16 = L8(L9, L10, L11, L12, L13, L14, L15, L16)
    L7(L8, L9, L10, L11, L12, L13, L14, L15, L16)
  end
  L7 = L5.Log
  L7(L8, L9)
  L7 = 0
  return L7
end
mesh_add_node = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = ":"
  L4 = ""
  L1 = L1(L2, L3, L4)
  L2 = "/tmp/"
  L3 = L1
  L4 = "-status"
  L2 = L2 .. L3 .. L4
  L3 = "cat "
  L4 = L2
  L3 = L3 .. L4
  L4 = nil
  L5 = io
  L5 = L5.open
  L6 = L2
  L7 = "r"
  L5 = L5(L6, L7)
  if L5 ~= nil then
    L7 = L5
    L6 = L5.read
    L8 = "*all"
    L6 = L6(L7, L8)
    L4 = L6
    L7 = L5
    L6 = L5.close
    L6(L7)
    if L4 == nil then
      L6 = 1
      return L6
    end
    L7 = L4
    L6 = L4.match
    L8 = "init"
    L6 = L6(L7, L8)
    if L6 then
      L6 = 1
      return L6
    end
    L7 = L4
    L6 = L4.match
    L8 = "connected"
    L6 = L6(L7, L8)
    if L6 then
      L6 = 2
      return L6
    end
    L7 = L4
    L6 = L4.match
    L8 = "syncd"
    L6 = L6(L7, L8)
    if L6 then
      L6 = 3
      return L6
    end
    L7 = L4
    L6 = L4.match
    L8 = "failed"
    L6 = L6(L7, L8)
    if L6 then
      L6 = 4
      return L6
    end
    L7 = L4
    L6 = L4.match
    L8 = "success"
    L6 = L6(L7, L8)
    if L6 then
      L6 = 0
      return L6
    end
  else
    L6 = 1
    return L6
  end
  L6 = 4
  return L6
end
mesh_get_status = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = _UPVALUE0_
  L0 = L0.init
  L0 = L0()
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "misc"
  L5 = "wireless"
  L6 = "ifname_5G"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L4 = L0
  L3 = L0.get_wifinet
  L5 = L2
  L3 = L3(L4, L5)
  L5 = L3
  L4 = L3.get
  L6 = "bsd"
  L4 = L4(L5, L6)
  L4 = L4 or L4
  L6 = L3
  L5 = L3.get
  L7 = "disabled"
  L5 = L5(L6, L7)
  L5 = L5 or L5
  if L4 == "1" or L5 == "1" then
    L6 = false
    return L6
  end
  L6 = true
  return L6
end
get_require_cac = L48
function L48()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.trim
  L1 = _UPVALUE0_
  L1 = L1.exec
  L2 = "/usr/sbin/wifi_5g_split get 2>/dev/null"
  L1, L2 = L1(L2)
  L0 = L0(L1, L2)
  if L0 == "0" then
    L1 = 0
    return L1
  else
    L1 = 1
    return L1
  end
end
get_wifi_split_status = L48
function L48(A0)
  local L1, L2, L3, L4
  if not A0 then
    L1 = 1
    return L1
  end
  L1 = tostring
  L2 = A0
  L1 = L1(L2)
  if L1 == "1" then
    L1 = "1"
    if L1 then
      goto lbl_14
      A0 = L1 or A0
    end
  end
  A0 = "0"
  ::lbl_14::
  L1 = _UPVALUE0_
  L1 = L1.exec
  L2 = "/usr/sbin/wifi_5g_split set "
  L3 = A0
  L4 = " 2>/dev/null"
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = 0
  return L1
end
set_wifi_split_status = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = _UPVALUE0_
  L0 = L0.init
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = L1.isMeshMLOSupport
  L2 = L2()
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.get
  L5 = "misc"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  if not L2 or L3 == "NULL" then
    L4 = true
    return L4
  end
  L4 = _UPVALUE1_
  L5 = L4
  L4 = L4.get
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  if L4 ~= "NULL" then
    L5 = string
    L5 = L5.split
    L5 = L5(L6, L7)
    for L9, L10 in L6, L7, L8 do
      L11 = _UPVALUE1_
      L12 = L11
      L11 = L11.get
      L13 = "misc"
      L14 = "wireless"
      L15 = "ifname_"
      L16 = string
      L16 = L16.upper
      L17 = L10
      L16 = L16(L17)
      L15 = L15 .. L16
      L11 = L11(L12, L13, L14, L15)
      L13 = L0
      L12 = L0.get_wifinet
      L14 = L11
      L12 = L12(L13, L14)
      L14 = L12
      L13 = L12.set
      L15 = "mld"
      L16 = L3
      L13(L14, L15, L16)
    end
    L6(L7, L8)
    L6(L7, L8)
  end
  L5 = _UPVALUE1_
  L5 = L5.set
  L9 = "mlo_enable"
  L10 = 1
  L5(L6, L7, L8, L9, L10)
  L5 = _UPVALUE1_
  L5 = L5.commit
  L5(L6, L7)
end
mlo_hostap_enable = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = _UPVALUE0_
  L0 = L0.init
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = L1.isMeshMLOSupport
  L2 = L2()
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.get
  L5 = "misc"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  if not L2 or L3 == "NULL" then
    L4 = true
    return L4
  end
  L4 = _UPVALUE1_
  L5 = L4
  L4 = L4.get
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  if L4 ~= "NULL" then
    L5 = string
    L5 = L5.split
    L5 = L5(L6, L7)
    for L9, L10 in L6, L7, L8 do
      L11 = _UPVALUE1_
      L12 = L11
      L11 = L11.get
      L13 = "misc"
      L14 = "wireless"
      L15 = "ifname_"
      L16 = string
      L16 = L16.upper
      L17 = L10
      L16 = L16(L17)
      L15 = L15 .. L16
      L11 = L11(L12, L13, L14, L15)
      L13 = L0
      L12 = L0.get_wifinet
      L14 = L11
      L12 = L12(L13, L14)
      L14 = L12
      L13 = L12.set
      L15 = "mld"
      L16 = nil
      L13(L14, L15, L16)
    end
    L6(L7, L8)
    L6(L7, L8)
  end
  L5 = _UPVALUE1_
  L5 = L5.set
  L9 = "mlo_enable"
  L10 = 0
  L5(L6, L7, L8, L9, L10)
  L5 = _UPVALUE1_
  L5 = L5.commit
  L5(L6, L7)
end
mlo_hostap_disable = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L0 = _UPVALUE0_
  L0 = L0.init
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = L1.isMeshMLOSupport
  L2 = L2()
  if not L2 then
    return L3
  end
  for L6 = L3, L4, L5 do
    L10 = "mld"
    L11 = nil
    L8(L9, L10, L11)
  end
  L3(L4, L5)
  L3(L4, L5)
  L6 = L5
  if L5 ~= "nil" then
    L6 = string
    L6 = L6.split
    L6 = L6(L7, L8)
    for L10, L11 in L7, L8, L9 do
      L12 = "bh_ap_"
      L13 = L11
      L12 = L12 .. L13
      L13 = _UPVALUE3_
      L14 = L13
      L13 = L13.delete
      L15 = "wireless"
      L16 = L12
      L17 = "mld"
      L13(L14, L15, L16, L17)
      if L4 == L11 then
        L13 = _UPVALUE4_
        L13 = L13.getNetMode
        L13 = L13()
        if L13 ~= "wifiapmode" then
          L13 = _UPVALUE3_
          L14 = L13
          L13 = L13.set
          L15 = "wireless"
          L16 = L12
          L17 = "disabled"
          L18 = "0"
          L13(L14, L15, L16, L17, L18)
      end
      else
        L13 = _UPVALUE3_
        L14 = L13
        L13 = L13.set
        L15 = "wireless"
        L16 = L12
        L17 = "disabled"
        L18 = "1"
        L13(L14, L15, L16, L17, L18)
      end
    end
  end
  L6 = _UPVALUE3_
  L6 = L6.commit
  L6(L7, L8)
end
mlo_config_clean = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = tonumber
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "wireless"
  L1, L2, L3, L7, L8, L9, L10, L11, L12, L13, L14, L15 = L1(L2, L3, L4, L5)
  L0 = L0(L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15)
  L0 = L0 or L0
  if L0 == 1 then
    L1 = mlo_hostap_enable
    L1()
  end
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "misc"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if L1 ~= "nil" then
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.get
    L2 = L2(L3, L4, L5, L6)
    L3 = string
    L3 = L3.split
    L3 = L3(L4, L5)
    for L7, L8 in L4, L5, L6 do
      L9 = "bh_ap_"
      L10 = L8
      L9 = L9 .. L10
      L10 = _UPVALUE0_
      L11 = L10
      L10 = L10.set
      L12 = "wireless"
      L13 = L9
      L14 = "mld"
      L15 = L2
      L10(L11, L12, L13, L14, L15)
      L10 = _UPVALUE0_
      L11 = L10
      L10 = L10.set
      L12 = "wireless"
      L13 = L9
      L14 = "disabled"
      L15 = "0"
      L10(L11, L12, L13, L14, L15)
    end
  end
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.commit
  L2(L3, L4)
end
mlo_config_restore = L48
function L48()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.foreach
  L2 = "wireless"
  L3 = "wifi-iface"
  function L4(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = A0[".name"]
    L2 = L1
    L1 = L1.match
    L3 = "bh_ap"
    L1 = L1(L2, L3)
    if L1 then
      L1 = _UPVALUE0_
      L2 = L1
      L1 = L1.set
      L3 = "wireless"
      L4 = A0[".name"]
      L5 = "disabled"
      L6 = 1
      L1(L2, L3, L4, L5, L6)
    end
  end
  L0(L1, L2, L3, L4)
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.commit
  L2 = "wireless"
  L0(L1, L2)
end
bh_ap_disable = L48
function L48()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.foreach
  L2 = "wireless"
  L3 = "wifi-iface"
  function L4(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = A0[".name"]
    L2 = L1
    L1 = L1.match
    L3 = "bh_ap"
    L1 = L1(L2, L3)
    if L1 then
      L1 = _UPVALUE0_
      L2 = L1
      L1 = L1.set
      L3 = "wireless"
      L4 = A0[".name"]
      L5 = "disabled"
      L6 = 0
      L1(L2, L3, L4, L5, L6)
    end
  end
  L0(L1, L2, L3, L4)
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.commit
  L2 = "wireless"
  L0(L1, L2)
end
bh_ap_enable = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = _UPVALUE0_
  L0 = L0.init
  L0 = L0()
  for L4, L5 in L1, L2, L3 do
    L7 = L0
    L6 = L0.get_wifinet
    L8 = L5
    L6 = L6(L7, L8)
    if L6 then
      L8 = L6
      L7 = L6.set
      L9 = "miwifi_mesh"
      L10 = 0
      L7(L8, L9, L10)
    end
  end
  L1(L2, L3)
  L1(L2, L3)
end
miwifi_mesh_disable = L48
function L48(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = _UPVALUE0_
  L1 = L1.init
  L1 = L1()
  if A0 == nil and (A0 ~= 1 or A0 ~= 0) then
    return L2
  end
  for L5, L6 in L2, L3, L4 do
    L8 = L1
    L7 = L1.get_wifinet
    L9 = L6
    L7 = L7(L8, L9)
    if L7 then
      L9 = L7
      L8 = L7.set
      L10 = "twt_responder"
      L11 = A0
      L8(L9, L10, L11)
    end
  end
  L2(L3, L4)
  L2(L3, L4)
  return L2
end
set_twt_hostap = L48
function L48()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = _UPVALUE0_
  L0 = L0.init
  L0 = L0()
  for L4, L5 in L1, L2, L3 do
    L7 = L0
    L6 = L0.get_wifinet
    L8 = L5
    L6 = L6(L7, L8)
    if L6 then
      L8 = L6
      L7 = L6.get
      L9 = "twt_responder"
      L7 = L7(L8, L9)
      if L7 == nil then
        L8 = 1
        return L8
      else
        return L7
      end
    end
  end
  return L1
end
get_twt_hostap = L48
function L48()
  local L0, L1, L2
  L0 = wifiNetwork
  L1 = _wifiNameForIndex
  L2 = 2
  L1, L2 = L1(L2)
  L0 = L0(L1, L2)
  L0 = L0.ax
  L0 = L0 or L0
  L1 = tonumber
  L2 = L0
  return L1(L2)
end
ax_enabled = L48
function L48()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "features"
  L4 = "game"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  L1 = tonumber
  L2 = L0
  return L1(L2)
end
get_wifi_game = L48
L48 = init
L48()
