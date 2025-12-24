local L0, L1, L2
L0 = module
L1 = "xiaoqiang.util.XQVLANServiceUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.model.uci"
L0 = L0(L1)
L0 = L0.cursor
L0 = L0()
L1 = require
L2 = "xiaoqiang.XQLog"
L1 = L1(L2)
function L2(A0)
  local L1
  if nil == A0 then
    L1 = false
    return L1
  end
  if -1 <= A0 and A0 <= 4095 then
    L1 = true
    return L1
  end
  L1 = false
  return L1
end
validate_vlanid = L2
function L2(A0)
  local L1
  if nil == A0 then
    L1 = false
    return L1
  end
  if -1 <= A0 and A0 <= 7 then
    L1 = true
    return L1
  end
  L1 = false
  return L1
end
validate_priority = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6
  if nil == A0 then
    L1 = false
    return L1
  end
  L1 = A0.type
  L1 = L1.internet
  L1 = L1.vid
  L2 = A0.type
  L2 = L2.iptv
  L2 = L2.vid
  L3 = A0.type
  L3 = L3.voip
  L3 = L3.vid
  L4 = A0.service
  L4 = L4.Internet
  L4 = L4.enable
  L5 = A0.service
  L5 = L5.Multimedia
  L5 = L5.enable
  L6 = L4 + L5
  if 2 == L6 then
    L6 = L1 + L2
    if -2 == L6 or L1 ~= L2 then
      L6 = L1 + L3
      if -2 == L6 or L1 ~= L3 then
        L6 = L2 + L3
      end
    end
    if -2 ~= L6 and L2 == L3 then
      L6 = true
      return L6
    end
  elseif 1 == L5 then
    L6 = L2 + L3
    if -2 ~= L6 and L2 == L3 then
      L6 = true
      return L6
    end
  end
  L6 = false
  return L6
end
check_vid_conflict = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = false
  L2 = getVlanService
  L2 = L2()
  if nil == L2 then
    return L3
  end
  L1 = L1 or L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  L1 = L1
  for L6, L7 in L3, L4, L5 do
    if not L1 then
      L8 = A0.interface
      L8 = L8[L6]
      L1 = L8 ~= L7
    end
  end
  L6 = L1
  L3(L4, L5, L6)
  return L1
end
vlan_service_changed = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.log
  L4 = 6
  L5 = A0
  L6 = A1
  L3(L4, L5, L6)
  L3 = vlan_service_changed
  L4 = A0
  L3 = L3(L4)
  if not L3 then
    L3 = true
    return L3
  end
  L3 = check_vid_conflict
  L4 = A0
  L3 = L3(L4)
  if L3 then
    L3 = false
    return L3
  end
  L3 = validate_vlanid
  L4 = A0.type
  L4 = L4.internet
  L4 = L4.vid
  L3 = L3(L4)
  if not L3 then
    L3 = false
    return L3
  end
  L3 = validate_vlanid
  L4 = A0.type
  L4 = L4.iptv
  L4 = L4.vid
  L3 = L3(L4)
  if not L3 then
    L3 = false
    return L3
  end
  L3 = validate_vlanid
  L4 = A0.type
  L4 = L4.voip
  L4 = L4.vid
  L3 = L3(L4)
  if not L3 then
    L3 = false
    return L3
  end
  L3 = validate_vlanid
  L4 = A0.type
  L4 = L4.bridge
  L4 = L4.vid
  L3 = L3(L4)
  if not L3 then
    L3 = false
    return L3
  end
  L3 = validate_priority
  L4 = A0.type
  L4 = L4.internet
  L4 = L4.priority
  L3 = L3(L4)
  if not L3 then
    L3 = false
    return L3
  end
  L3 = validate_priority
  L4 = A0.type
  L4 = L4.iptv
  L4 = L4.priority
  L3 = L3(L4)
  if not L3 then
    L3 = false
    return L3
  end
  L3 = validate_priority
  L4 = A0.type
  L4 = L4.voip
  L4 = L4.priority
  L3 = L3(L4)
  if not L3 then
    L3 = false
    return L3
  end
  L3 = validate_priority
  L4 = A0.type
  L4 = L4.bridge
  L4 = L4.priority
  L3 = L3(L4)
  if not L3 then
    L3 = false
    return L3
  end
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "Internet"
  L7 = "enable"
  L8 = A0.service
  L8 = L8.Internet
  L8 = L8.enable
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "Internet"
  L7 = "profile"
  L8 = A0.service
  L8 = L8.Internet
  L8 = L8.profile
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "Multimedia"
  L7 = "enable"
  L8 = A0.service
  L8 = L8.Multimedia
  L8 = L8.enable
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "Multimedia"
  L7 = "profile"
  L8 = A0.service
  L8 = L8.Multimedia
  L8 = L8.profile
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "iptv"
  L7 = "vid"
  L8 = A0.type
  L8 = L8.iptv
  L8 = L8.vid
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "iptv"
  L7 = "priority"
  L8 = A0.type
  L8 = L8.iptv
  L8 = L8.priority
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "iptv"
  L7 = "wan_egress_tag"
  L8 = A0.type
  L8 = L8.iptv
  L8 = L8.wan_egress_tag
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "iptv"
  L7 = "lan_egress_tag"
  L8 = A0.type
  L8 = L8.iptv
  L8 = L8.lan_egress_tag
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "voip"
  L7 = "vid"
  L8 = A0.type
  L8 = L8.voip
  L8 = L8.vid
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "voip"
  L7 = "priority"
  L8 = A0.type
  L8 = L8.voip
  L8 = L8.priority
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "voip"
  L7 = "wan_egress_tag"
  L8 = A0.type
  L8 = L8.voip
  L8 = L8.wan_egress_tag
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "voip"
  L7 = "lan_egress_tag"
  L8 = A0.type
  L8 = L8.voip
  L8 = L8.lan_egress_tag
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "internet"
  L7 = "vid"
  L8 = A0.type
  L8 = L8.internet
  L8 = L8.vid
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "internet"
  L7 = "priority"
  L8 = A0.type
  L8 = L8.internet
  L8 = L8.priority
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "internet"
  L7 = "wan_egress_tag"
  L8 = A0.type
  L8 = L8.internet
  L8 = L8.wan_egress_tag
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "internet"
  L7 = "lan_egress_tag"
  L8 = A0.type
  L8 = L8.internet
  L8 = L8.lan_egress_tag
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "bridge"
  L7 = "vid"
  L8 = A0.type
  L8 = L8.bridge
  L8 = L8.vid
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "bridge"
  L7 = "priority"
  L8 = A0.type
  L8 = L8.bridge
  L8 = L8.priority
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "bridge"
  L7 = "wan_egress_tag"
  L8 = A0.type
  L8 = L8.bridge
  L8 = L8.wan_egress_tag
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.set
  L5 = "vlan_service"
  L6 = "bridge"
  L7 = "lan_egress_tag"
  L8 = A0.type
  L8 = L8.bridge
  L8 = L8.lan_egress_tag
  L3(L4, L5, L6, L7, L8)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.foreach
  L5 = "vlan_service"
  L6 = "interface"
  function L7(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.set
    L3 = "vlan_service"
    L4 = A0[".name"]
    L5 = "type"
    L6 = _UPVALUE1_
    L6 = L6.interface
    L7 = A0[".name"]
    L6 = L6[L7]
    L1(L2, L3, L4, L5, L6)
  end
  L3(L4, L5, L6, L7)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.save
  L5 = "vlan_service"
  L3(L4, L5)
  L3 = _UPVALUE1_
  L4 = L3
  L3 = L3.commit
  L5 = "vlan_service"
  L3(L4, L5)
  if A1 then
    L3 = L2.forkExec
    L4 = "vlan_service.sh restart true"
    L3(L4)
  else
    L3 = os
    L3 = L3.execute
    L4 = "vlan_service.sh restart false"
    L3(L4)
  end
  L3 = true
  return L3
end
setVlanService = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = {}
  L1 = {}
  L2 = {}
  L2.enable = 0
  L2.profile = 0
  L1.Internet = L2
  L2 = {}
  L2.enable = 0
  L2.profile = 0
  L1.Multimedia = L2
  L0.service = L1
  L1 = {}
  L2 = {}
  L2.vid = -1
  L2.priority = -1
  L2.wan_egress_tag = 1
  L2.lan_egress_tag = 0
  L1.iptv = L2
  L2 = {}
  L2.vid = -1
  L2.priority = -1
  L2.wan_egress_tag = 1
  L2.lan_egress_tag = 0
  L1.voip = L2
  L2 = {}
  L2.vid = -1
  L2.priority = -1
  L2.wan_egress_tag = 1
  L2.lan_egress_tag = 0
  L1.bridge = L2
  L2 = {}
  L2.vid = -1
  L2.priority = -1
  L2.wan_egress_tag = 1
  L2.lan_egress_tag = 0
  L1.internet = L2
  L0.type = L1
  L1 = {}
  L0.interface = L1
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "vlan_service"
  L4 = "Multimedia"
  L5 = "enable"
  L1 = L1(L2, L3, L4, L5)
  L2 = L0.service
  L2 = L2.Multimedia
  if L1 then
    L3 = tonumber
    L4 = L1
    L3 = L3(L4)
    if L3 then
      goto lbl_56
    end
  end
  L3 = 0
  ::lbl_56::
  L2.enable = L3
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "vlan_service"
  L5 = "Multimedia"
  L6 = "profile"
  L2 = L2(L3, L4, L5, L6)
  L3 = L0.service
  L3 = L3.Multimedia
  if L2 then
    L4 = tonumber
    L5 = L2
    L4 = L4(L5)
    if L4 then
      goto lbl_73
    end
  end
  L4 = 0
  ::lbl_73::
  L3.profile = L4
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "vlan_service"
  L6 = "Internet"
  L7 = "enable"
  L3 = L3(L4, L5, L6, L7)
  L1 = L3
  L3 = L0.service
  L3 = L3.Internet
  if L1 then
    L4 = tonumber
    L5 = L1
    L4 = L4(L5)
    if L4 then
      goto lbl_91
    end
  end
  L4 = 0
  ::lbl_91::
  L3.enable = L4
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "vlan_service"
  L6 = "Internet"
  L7 = "profile"
  L3 = L3(L4, L5, L6, L7)
  L2 = L3
  L3 = L0.service
  L3 = L3.Internet
  if L2 then
    L4 = tonumber
    L5 = L2
    L4 = L4(L5)
    if L4 then
      goto lbl_109
    end
  end
  L4 = 0
  ::lbl_109::
  L3.profile = L4
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "vlan_service"
  L6 = "iptv"
  L7 = "vid"
  L3 = L3(L4, L5, L6, L7)
  L4 = L0.type
  L4 = L4.iptv
  if L3 then
    L5 = tonumber
    L6 = L3
    L5 = L5(L6)
    if L5 then
      goto lbl_126
    end
  end
  L5 = -1
  ::lbl_126::
  L4.vid = L5
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = "vlan_service"
  L7 = "iptv"
  L8 = "priority"
  L4 = L4(L5, L6, L7, L8)
  L5 = L0.type
  L5 = L5.iptv
  if L4 then
    L6 = tonumber
    L7 = L4
    L6 = L6(L7)
    if L6 then
      goto lbl_143
    end
  end
  L6 = -1
  ::lbl_143::
  L5.priority = L6
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.get
  L7 = "vlan_service"
  L8 = "iptv"
  L9 = "wan_egress_tag"
  L5 = L5(L6, L7, L8, L9)
  L6 = L0.type
  L6 = L6.iptv
  if L5 then
    L7 = tonumber
    L8 = L5
    L7 = L7(L8)
    if L7 then
      goto lbl_160
    end
  end
  L7 = 1
  ::lbl_160::
  L6.wan_egress_tag = L7
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = "vlan_service"
  L9 = "iptv"
  L10 = "lan_egress_tag"
  L6 = L6(L7, L8, L9, L10)
  L7 = L0.type
  L7 = L7.iptv
  if L6 then
    L8 = tonumber
    L9 = L6
    L8 = L8(L9)
    if L8 then
      goto lbl_177
    end
  end
  L8 = 0
  ::lbl_177::
  L7.lan_egress_tag = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "voip"
  L11 = "vid"
  L7 = L7(L8, L9, L10, L11)
  L3 = L7
  L7 = L0.type
  L7 = L7.voip
  if L3 then
    L8 = tonumber
    L9 = L3
    L8 = L8(L9)
    if L8 then
      goto lbl_195
    end
  end
  L8 = -1
  ::lbl_195::
  L7.vid = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "voip"
  L11 = "priority"
  L7 = L7(L8, L9, L10, L11)
  L4 = L7
  L7 = L0.type
  L7 = L7.voip
  if L4 then
    L8 = tonumber
    L9 = L4
    L8 = L8(L9)
    if L8 then
      goto lbl_213
    end
  end
  L8 = -1
  ::lbl_213::
  L7.priority = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "voip"
  L11 = "wan_egress_tag"
  L7 = L7(L8, L9, L10, L11)
  L5 = L7
  L7 = L0.type
  L7 = L7.voip
  if L5 then
    L8 = tonumber
    L9 = L5
    L8 = L8(L9)
    if L8 then
      goto lbl_231
    end
  end
  L8 = 1
  ::lbl_231::
  L7.wan_egress_tag = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "voip"
  L11 = "lan_egress_tag"
  L7 = L7(L8, L9, L10, L11)
  L6 = L7
  L7 = L0.type
  L7 = L7.voip
  if L6 then
    L8 = tonumber
    L9 = L6
    L8 = L8(L9)
    if L8 then
      goto lbl_249
    end
  end
  L8 = 0
  ::lbl_249::
  L7.lan_egress_tag = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "internet"
  L11 = "vid"
  L7 = L7(L8, L9, L10, L11)
  L3 = L7
  L7 = L0.type
  L7 = L7.internet
  if L3 then
    L8 = tonumber
    L9 = L3
    L8 = L8(L9)
    if L8 then
      goto lbl_267
    end
  end
  L8 = -1
  ::lbl_267::
  L7.vid = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "internet"
  L11 = "priority"
  L7 = L7(L8, L9, L10, L11)
  L4 = L7
  L7 = L0.type
  L7 = L7.internet
  if L4 then
    L8 = tonumber
    L9 = L4
    L8 = L8(L9)
    if L8 then
      goto lbl_285
    end
  end
  L8 = -1
  ::lbl_285::
  L7.priority = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "internet"
  L11 = "wan_egress_tag"
  L7 = L7(L8, L9, L10, L11)
  L5 = L7
  L7 = L0.type
  L7 = L7.internet
  if L5 then
    L8 = tonumber
    L9 = L5
    L8 = L8(L9)
    if L8 then
      goto lbl_303
    end
  end
  L8 = 1
  ::lbl_303::
  L7.wan_egress_tag = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "internet"
  L11 = "lan_egress_tag"
  L7 = L7(L8, L9, L10, L11)
  L6 = L7
  L7 = L0.type
  L7 = L7.internet
  if L6 then
    L8 = tonumber
    L9 = L6
    L8 = L8(L9)
    if L8 then
      goto lbl_321
    end
  end
  L8 = 0
  ::lbl_321::
  L7.lan_egress_tag = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "bridge"
  L11 = "vid"
  L7 = L7(L8, L9, L10, L11)
  L3 = L7
  L7 = L0.type
  L7 = L7.bridge
  if L3 then
    L8 = tonumber
    L9 = L3
    L8 = L8(L9)
    if L8 then
      goto lbl_339
    end
  end
  L8 = -1
  ::lbl_339::
  L7.vid = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "bridge"
  L11 = "priority"
  L7 = L7(L8, L9, L10, L11)
  L4 = L7
  L7 = L0.type
  L7 = L7.bridge
  if L4 then
    L8 = tonumber
    L9 = L4
    L8 = L8(L9)
    if L8 then
      goto lbl_357
    end
  end
  L8 = -1
  ::lbl_357::
  L7.priority = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "bridge"
  L11 = "wan_egress_tag"
  L7 = L7(L8, L9, L10, L11)
  L5 = L7
  L7 = L0.type
  L7 = L7.bridge
  if L5 then
    L8 = tonumber
    L9 = L5
    L8 = L8(L9)
    if L8 then
      goto lbl_375
    end
  end
  L8 = 1
  ::lbl_375::
  L7.wan_egress_tag = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L9 = "vlan_service"
  L10 = "bridge"
  L11 = "lan_egress_tag"
  L7 = L7(L8, L9, L10, L11)
  L6 = L7
  L7 = L0.type
  L7 = L7.bridge
  if L6 then
    L8 = tonumber
    L9 = L6
    L8 = L8(L9)
    if L8 then
      goto lbl_393
    end
  end
  L8 = 0
  ::lbl_393::
  L7.lan_egress_tag = L8
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.foreach
  L9 = "vlan_service"
  L10 = "interface"
  function L11(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L1 = L1.interface
    L2 = A0[".name"]
    L3 = A0.type
    L1[L2] = L3
  end
  L7(L8, L9, L10, L11)
  L7 = _UPVALUE1_
  L7 = L7.log
  L8 = 6
  L9 = L0
  L7(L8, L9)
  return L0
end
getVlanService = L2
