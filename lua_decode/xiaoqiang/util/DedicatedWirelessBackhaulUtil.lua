local L0, L1, L2, L3, L4, L5, L6, L7, L8
L0 = module
L1 = "xiaoqiang.util.DedicatedWirelessBackhaulUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.model.uci"
L0 = L0(L1)
L0 = L0.cursor
L0 = L0()
L1 = require
L2 = "xiaoqiang.util.XQWifiUtil"
L1 = L1(L2)
L2 = L1.get_wlan_ifname
L2 = L2()
L3 = require
L4 = "luci.model.network"
L3 = L3(L4)
L5 = L0
L4 = L0.get
L6 = "misc"
L7 = "wireless"
L8 = "ifname_dwb"
L4 = L4(L5, L6, L7, L8)
function L5()
  local L0, L1
  L0 = _UPVALUE0_
  if L0 then
    L0 = true
    return L0
  else
    L0 = false
    return L0
  end
end
is_supported = L5
function L5()
  local L0, L1, L2, L3, L4, L5
  if L0 ~= nil then
    if L0 ~= 0 then
      goto lbl_12
    end
  end
  do return L0 end
  ::lbl_12::
  for L3 = L0, L1, L2 do
    L4 = _UPVALUE1_
    L4 = L4[L3]
    L5 = _UPVALUE0_
    if L4 == L5 then
      return L3
    end
  end
  return L0
end
mesh_get_dwb_band = L5
function L5()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  if L0 ~= nil then
    L0 = string
    L0 = L0.len
    L1 = _UPVALUE0_
    L0 = L0(L1)
    if L0 ~= 0 then
      goto lbl_12
    end
  end
  L0 = nil
  do return L0 end
  ::lbl_12::
  L0 = _UPVALUE1_
  L0 = L0.init
  L0 = L0()
  L2 = L0
  L1 = L0.get_wifinet
  L3 = _UPVALUE0_
  L1 = L1(L2, L3)
  return L1
end
get_dwb_wifinet = L5
function L5(A0)
  local L1, L2, L3, L4, L5
  if A0 == nil then
    L1 = -1
    return L1
  end
  L1 = get_dwb_wifinet
  L1 = L1()
  if L1 == nil then
    L2 = -1
    return L2
  end
  L3 = L1
  L2 = L1.set
  L4 = "dwb_status"
  L5 = A0
  L2(L3, L4, L5)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.save
  L4 = "wireless"
  L2(L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.commit
  L4 = "wireless"
  L2(L3, L4)
end
mesh_set_dwb_status = L5
function L5()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = get_dwb_wifinet
  L1 = L1()
  L2 = "0"
  if L1 == nil then
    L3 = nil
    return L3
  end
  L3 = L0.isMeshRe
  L3 = L3()
  if L3 then
    L4 = L1
    L3 = L1.get
    L5 = "disabled"
    L3 = L3(L4, L5)
    L3 = L3 or L3
    if L3 ~= "1" then
      L4 = "1"
      if L4 then
        goto lbl_27
        L2 = L4 or L2
      end
    end
    L2 = "0"
    ::lbl_27::
  else
    L4 = L1
    L3 = L1.get
    L5 = "dwb_status"
    L3 = L3(L4, L5)
    L2 = L3
  end
  return L2
end
mesh_get_dwb_status = L5
function L5(A0)
  local L1, L2, L3, L4, L5
  L1 = get_dwb_wifinet
  L1 = L1()
  if L1 == nil then
    L2 = nil
    return L2
  end
  L3 = L1
  L2 = L1.set
  L4 = "dwb_ssid"
  L5 = A0
  L2(L3, L4, L5)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.save
  L4 = "wireless"
  L2(L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.commit
  L4 = "wireless"
  L2(L3, L4)
end
mesh_set_dwb_ssid_channge = L5
function L5()
  local L0, L1, L2, L3
  L0 = get_dwb_wifinet
  L0 = L0()
  if L0 == nil then
    L1 = nil
    return L1
  end
  L2 = L0
  L1 = L0.get
  L3 = "dwb_ssid"
  L1 = L1(L2, L3)
  return L1
end
mesh_get_dwb_bsd_channge = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = require
  L1 = "ubus"
  L0 = L0(L1)
  L1 = 0
  L2 = _UPVALUE0_
  if L2 ~= nil then
    L2 = _UPVALUE0_
    if L2 ~= "" then
      goto lbl_13
    end
  end
  L2 = 0
  do return L2 end
  ::lbl_13::
  L2 = L0.connect
  L3 = nil
  L2 = L2(L3, L4)
  if not L2 then
    L3 = 0
    return L3
  end
  L3 = L2.call
  L7 = {}
  L3 = L3(L4, L5, L6, L7)
  L4(L5)
  if not L3 then
    return L4
  end
  for L7, L8 in L4, L5, L6 do
    L9 = L8.link_type
    if L9 ~= nil then
      L9 = L8.link_type
      if L9 == "wired" then
        goto lbl_44
      end
    end
    L9 = 2
    do return L9 end
    ::lbl_44::
    L1 = L1 + 1
  end
  if L1 == 0 then
    return L4
  else
    return L4
  end
end
mesh_get_dwb_type = L5
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _UPVALUE0_
  if L3 == nil then
    return
  end
  L3 = mesh_get_dwb_band
  L3 = L3()
  L4 = mesh_get_dwb_status
  L4 = L4()
  L5 = 2
  if L3 == 3 then
    L5 = 2
  elseif L3 == 2 then
    L5 = 3
  end
  L6 = A1[L3]
  if L6 then
    L6 = A1[L3]
    L6 = L6.on
    if L6 == 1 and L4 ~= "1" then
      L6 = A1[L3]
      L6.on = 0
    end
  end
  L6 = A0[1]
  L6 = L6.bsd
  if L6 ~= A2 then
    L6 = mesh_set_dwb_ssid_channge
    L7 = "0"
    L6(L7)
    return
  end
  L6 = A0[1]
  L6 = L6.bsd
  if L6 ~= "0" or A2 ~= "0" then
    return
  end
  L6 = A1[L5]
  if L6 then
    L6 = A0[L5]
    L6 = L6.ssid
    L7 = A1[L5]
    L7 = L7.ssid
    if L6 ~= L7 then
      goto lbl_61
    end
  end
  L6 = A1[L3]
  if L6 then
    L6 = A0[L3]
    L6 = L6.ssid
    L7 = A1[L3]
    L7 = L7.ssid
    ::lbl_61::
    if L6 ~= L7 then
      L6 = mesh_set_dwb_ssid_channge
      L7 = "1"
      L6(L7)
    end
  end
end
mesh_sync_dwb_ssid = L5
