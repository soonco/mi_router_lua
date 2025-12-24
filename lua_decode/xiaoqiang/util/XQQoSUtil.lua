local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "xiaoqiang.util.XQQoSUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.model.uci"
L0 = L0(L1)
L0 = L0.cursor
L0 = L0()
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQFunction"
L2 = L2(L3)
function L3()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get_all
  L2 = "app-tc"
  L3 = "config"
  L0 = L0(L1, L2, L3)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get_all
  L3 = "app-tc"
  L4 = "xunlei"
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get_all
  L4 = "app-tc"
  L5 = "kuaipan"
  L2 = L2(L3, L4, L5)
  L3 = {}
  if L0 then
    L4 = L0.enable
    L3.enable = L4
  end
  if L1 then
    L3.xunlei = L1
  end
  if L2 then
    L3.kuaipan = L2
  end
  return L3
end
_application = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.set
  L5 = "app-tc"
  L6 = A0
  L7 = A1
  L8 = A2
  L3(L4, L5, L6, L7, L8)
end
_set = L3
function L3()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.save
  L2 = "app-tc"
  L0(L1, L2)
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.commit
  L2 = "app-tc"
  L0(L1, L2)
end
_apply = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6, L7
  if A1 then
    L3 = _set
    L4 = A0
    L5 = "max_download_speed"
    L6 = tostring
    L7 = A1
    L6, L7 = L6(L7)
    L3(L4, L5, L6, L7)
  end
  if A2 then
    L3 = _set
    L4 = A0
    L5 = "max_upload_speed"
    L6 = tostring
    L7 = A2
    L6, L7 = L6(L7)
    L3(L4, L5, L6, L7)
  end
  L3 = _apply
  L3()
end
_appSpeedlimit = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.QOS_APPSL_ENABLE
    if L1 then
      goto lbl_9
    end
  end
  L1 = _UPVALUE0_
  L1 = L1.QOS_APPSL_DISABLE
  ::lbl_9::
  if A0 then
    L2 = "1"
    if L2 then
      goto lbl_15
    end
  end
  L2 = "0"
  ::lbl_15::
  L3 = _set
  L4 = "config"
  L5 = "enable"
  L6 = L2
  L3(L4, L5, L6)
  L3 = _apply
  L3()
  L3 = os
  L3 = L3.execute
  L4 = L1
  L3 = L3(L4)
  L3 = L3 == 0
  return L3
end
appSpeedlimitSwitch = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L1 = {}
  L2 = {}
  L3 = _application
  L3 = L3()
  L4 = _UPVALUE0_
  L4 = L4.thrift_tunnel_to_datacenter
  L5 = "{\"api\":45,\"appCode\":1}"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.thrift_tunnel_to_datacenter
  L6 = "{\"api\":45,\"appCode\":0}"
  L5 = L5(L6)
  if L4 then
    L6 = L4.code
    if L6 == 0 then
      L6 = tonumber
      L7 = L4.downloadSpeed
      L6 = L6(L7)
      L1.download = L6
      L6 = tonumber
      L7 = L4.uploadSpeed
      L6 = L6(L7)
      L1.upload = L6
  end
  else
    L1.download = 0
    L1.upload = 0
  end
  if L5 then
    L6 = L5.code
    if L6 == 0 then
      L6 = tonumber
      L7 = L5.downloadSpeed
      L6 = L6(L7)
      L2.download = L6
      L6 = tonumber
      L7 = L5.uploadSpeed
      L6 = L6(L7)
      L2.upload = L6
  end
  else
    L2.download = 0
    L2.upload = 0
  end
  L6 = L3.enable
  L0.enable = L6
  L6 = L3.xunlei
  L6 = L6.enable
  L1.enable = L6
  L6 = tonumber
  L7 = L3.xunlei
  L7 = L7.max_download_speed
  L6 = L6(L7)
  L1.maxdownload = L6
  L6 = tonumber
  L7 = L3.xunlei
  L7 = L7.max_upload_speed
  L6 = L6(L7)
  L1.maxupload = L6
  L6 = L3.kuaipan
  L6 = L6.enable
  L2.enable = L6
  L6 = tonumber
  L7 = L3.kuaipan
  L7 = L7.max_download_speed
  L6 = L6(L7)
  L2.maxdownload = L6
  L6 = tonumber
  L7 = L3.kuaipan
  L7 = L7.max_upload_speed
  L6 = L6(L7)
  L2.maxupload = L6
  L0.xunlei = L1
  L0.kuaipan = L2
  return L0
end
appInfo = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  L2 = _appSpeedlimit
  L3 = "xunlei"
  L4 = A0
  L5 = A1
  L2(L3, L4, L5)
end
setXunlei = L3
function L3(A0, A1)
  local L2, L3, L4, L5
  L2 = _appSpeedlimit
  L3 = "kuaipan"
  L4 = A0
  L5 = A1
  L2(L3, L4, L5)
end
setKuaipan = L3
function L3()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = _UPVALUE0_
  L1 = L1.QOS_APPSL_RELOAD
  L0(L1)
end
reload = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = 0
    return L1
  end
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 == "number" then
    L1 = tonumber
    L2 = string
    L2 = L2.format
    L3 = "%0.2f"
    L4 = A0 / 8192
    L2, L3, L4, L5, L6, L7 = L2(L3, L4)
    return L1(L2, L3, L4, L5, L6, L7)
  end
  L2 = A0
  L1 = A0.match
  L3 = "Gbit"
  L1 = L1(L2, L3)
  if L1 then
    L1 = tonumber
    L3 = A0
    L2 = A0.match
    L4 = "(%S+)Gbit"
    L2, L3, L4, L5, L6, L7 = L2(L3, L4)
    L1 = L1(L2, L3, L4, L5, L6, L7)
    L1 = L1 * 131072
    return L1
  else
    L2 = A0
    L1 = A0.match
    L3 = "Mbit"
    L1 = L1(L2, L3)
    if L1 then
      L1 = tonumber
      L3 = A0
      L2 = A0.match
      L4 = "(%S+)Mbit"
      L2, L3, L4, L5, L6, L7 = L2(L3, L4)
      L1 = L1(L2, L3, L4, L5, L6, L7)
      L1 = L1 * 128
      return L1
    else
      L2 = A0
      L1 = A0.match
      L3 = "Kbit"
      L1 = L1(L2, L3)
      if L1 then
        L1 = tonumber
        L2 = string
        L2 = L2.format
        L3 = "%0.2f"
        L4 = tonumber
        L6 = A0
        L5 = A0.match
        L7 = "(%S+)Kbit"
        L5, L6, L7 = L5(L6, L7)
        L4 = L4(L5, L6, L7)
        L4 = L4 / 8
        L2, L3, L4, L5, L6, L7 = L2(L3, L4)
        return L1(L2, L3, L4, L5, L6, L7)
      else
        L2 = A0
        L1 = A0.match
        L3 = "bit"
        L1 = L1(L2, L3)
        if L1 then
          L1 = tonumber
          L2 = string
          L2 = L2.format
          L3 = "%0.2f"
          L4 = tonumber
          L6 = A0
          L5 = A0.match
          L7 = "(%S+)bit"
          L5, L6, L7 = L5(L6, L7)
          L4 = L4(L5, L6, L7)
          L4 = L4 / 8192
          L2, L3, L4, L5, L6, L7 = L2(L3, L4)
          return L1(L2, L3, L4, L5, L6, L7)
        else
          L1 = 0
          return L1
        end
      end
    end
  end
end
_bitFormat = L3
function L3(A0)
  local L1
  if A0 == 1 then
    L1 = 0.25
    return L1
  elseif A0 == 2 then
    L1 = 0.5
    return L1
  elseif A0 == 3 then
    L1 = 0.75
    return L1
  else
    L1 = 0.1
    return L1
  end
end
_weightHelper = L3
function L3(A0)
  local L1
  if A0 == 0 then
    L1 = 2
    return L1
  elseif 0 < A0 and A0 <= 0.25 then
    L1 = 1
    return L1
  elseif 0.25 < A0 and A0 <= 0.5 then
    L1 = 2
    return L1
  elseif 0.5 < A0 then
    L1 = 3
    return L1
  end
  L1 = 0
  return L1
end
_levelHelper = L3
function L3(A0)
  local L1, L2
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.forkExec
    L2 = "/etc/init.d/miqos on"
    L1(L2)
  else
    L1 = _UPVALUE0_
    L1 = L1.forkExec
    L2 = "/etc/init.d/miqos off"
    L1(L2)
  end
  L1 = true
  return L1
end
qosSwitch = L3
function L3(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = "auto"
  L4 = "min"
  L5 = "max"
  L6 = "service"
  L7 = "service"
  L8 = "service"
  L9 = "service"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L2[4] = L6
  L2[5] = L7
  L2[6] = L8
  L2[7] = L9
  L3 = {}
  L4 = "auto"
  L5 = "auto"
  L6 = "auto"
  L7 = "auto"
  L8 = "game"
  L9 = "web"
  L10 = "video"
  L3[1] = L4
  L3[2] = L5
  L3[3] = L6
  L3[4] = L7
  L3[5] = L8
  L3[6] = L9
  L3[7] = L10
  L4 = false
  L5 = 0
  L6 = tonumber
  L7 = A0
  L6 = L6(L7)
  if L6 then
    L6 = tonumber
    L7 = A0
    L6 = L6(L7)
    A0 = L6
  else
    L6 = 1523
    return L6
  end
  if 0 <= A0 and A0 <= 6 then
    L7 = L1
    L6 = L1.get
    L8 = "miqos"
    L9 = "settings"
    L10 = "qos_auto"
    L6 = L6(L7, L8, L9, L10)
    L6 = L6 or L6
    L8 = L1
    L7 = L1.get
    L9 = "miqos"
    L10 = "param"
    L11 = "seq_prio"
    L7 = L7(L8, L9, L10, L11)
    L7 = L7 or L7
    L8 = A0 + 1
    L8 = L2[L8]
    if L6 ~= L8 then
      L4 = true
      L9 = L1
      L8 = L1.set
      L10 = "miqos"
      L11 = "settings"
      L12 = "qos_auto"
      L13 = A0 + 1
      L13 = L2[L13]
      L8(L9, L10, L11, L12, L13)
    end
    L8 = A0 + 1
    L8 = L3[L8]
    if L7 ~= L8 then
      L4 = true
      L9 = L1
      L8 = L1.set
      L10 = "miqos"
      L11 = "param"
      L12 = "seq_prio"
      L13 = A0 + 1
      L13 = L3[L13]
      L8(L9, L10, L11, L12, L13)
    end
  end
  if L4 then
    L7 = L1
    L6 = L1.commit
    L8 = "miqos"
    L6(L7, L8)
    L6 = _UPVALUE0_
    L6 = L6.forkExec
    L7 = "/etc/init.d/miqos apply"
    L6(L7)
  end
  return L5
end
setQoSMode = L3
function L3()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "/etc/init.d/miqos restart"
  return L0(L1)
end
qosRestart = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = os
  L2 = L2.execute
  L3 = "/etc/init.d/miqos status"
  L2 = L2(L3)
  if L2 == 0 then
    L1.on = 1
    L1.mode = 3
    L3 = L0
    L2 = L0.get
    L4 = "miqos"
    L5 = "settings"
    L6 = "qos_auto"
    L2 = L2(L3, L4, L5, L6)
    L2 = L2 or L2
    L3 = {}
    L3.auto = 3
    L3.game = 4
    L3.web = 5
    L3.video = 6
    if L2 == "auto" then
      L1.mode = 0
    elseif L2 == "min" then
      L1.mode = 1
    elseif L2 == "max" then
      L1.mode = 2
    elseif L2 == "service" or L2 == "noifb" then
      L5 = L0
      L4 = L0.get
      L6 = "miqos"
      L7 = "param"
      L8 = "seq_prio"
      L4 = L4(L5, L6, L7, L8)
      L4 = L4 or L4
      L5 = L3[L4]
      L1.mode = L5
    else
      L4 = L3.auto
      L1.mode = L4
    end
  else
    L1.on = 0
    L1.mode = 0
  end
  return L1
end
qosStatus = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.download = 0
  L1.upload = 0
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "miqos"
  L6 = "settings"
  L7 = "download"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2 = L2(L3)
  L3 = tonumber
  L5 = L0
  L4 = L0.get
  L6 = "miqos"
  L7 = "settings"
  L8 = "upload"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L3 = L3(L4)
  L4 = tonumber
  L5 = string
  L5 = L5.format
  L6 = "%0.2f"
  L7 = L2 / 1024
  L5, L6, L7, L8 = L5(L6, L7)
  L4 = L4(L5, L6, L7, L8)
  L1.download = L4
  L4 = tonumber
  L5 = string
  L5 = L5.format
  L6 = "%0.2f"
  L7 = L3 / 1024
  L5, L6, L7, L8 = L5(L6, L7)
  L4 = L4(L5, L6, L7, L8)
  L1.upload = L4
  return L1
end
qosBand = L3
function L3()
  local L0, L1, L2, L3
  L0 = require
  L1 = "miqos"
  L0 = L0(L1)
  L1 = {}
  L1.switch = 0
  L2 = L0.cmd
  L3 = "show_wangzhe"
  L2 = L2(L3)
  if L2 then
    L3 = L2.status
    if L3 == 0 then
      L3 = L2.data
      if L3 then
        L3 = L2.data
        L3 = L3.switch
        L1.switch = L3
      end
    end
  end
  return L1
end
wangzheInfo = L3
function L3(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = require
  L3 = "miqos"
  L2 = L2(L3)
  if A0 and A1 then
    L3 = tostring
    L4 = math
    L4 = L4.floor
    L5 = 1024 * A0
    L4, L5, L6, L7, L8, L9 = L4(L5)
    L3 = L3(L4, L5, L6, L7, L8, L9)
    L4 = tostring
    L5 = math
    L5 = L5.floor
    L6 = 1024 * A1
    L5, L6, L7, L8, L9 = L5(L6)
    L4 = L4(L5, L6, L7, L8, L9)
    L5 = L2.cmd
    L6 = string
    L6 = L6.format
    L7 = "change_band %s %s"
    L8 = L3
    L9 = L4
    L6, L7, L8, L9 = L6(L7, L8, L9)
    L5 = L5(L6, L7, L8, L9)
    if L5 then
      L6 = L5.status
      if L6 == 0 then
        L6 = true
        return L6
      end
    end
  end
  L3 = false
  return L3
end
setQosBand = L3
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = pcall
  function L3()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.foreach
    L2 = "miqos"
    L3 = "group"
    function L4(A0)
      local L1, L2
      L1 = A0.name
      L2 = _UPVALUE0_
      L2 = L2.QOS_DEFAULT_GROUP
      if L1 ~= L2 then
        L1 = _UPVALUE1_
        L2 = A0.name
        L1[L2] = A0
      end
    end
    L0(L1, L2, L3, L4)
  end
  L2, L3 = L2(L3)
  for L7, L8 in L4, L5, L6 do
    L9 = L8.flag
    if not L9 then
      L9 = tonumber
      L10 = L1[L7]
      L10 = L10.max_grp_uplink
      L10 = L10 or L10
      L9 = L9(L10)
      if L9 <= 0 then
        L9 = tonumber
        L10 = L1[L7]
        L10 = L10.max_grp_downlink
        L10 = L10 or L10
        L9 = L9(L10)
        if L9 <= 0 then
          L9 = L1[L7]
          L9.flag = "off"
        end
      end
    else
      L9 = L8.flag
      if L9 == "off" then
        L9 = L1[L7]
        L9.max_grp_uplink = 0
        L9 = L1[L7]
        L9.max_grp_downlink = 0
      end
    end
  end
  if not L1 then
  end
  return L4
end
function L4()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L1.status = 0
  L2 = _UPVALUE0_
  L2 = L2()
  L1.data = L2
  L3 = L0
  L2 = L0.get
  L4 = "miqos"
  L5 = "settings"
  L6 = "qos_auto"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L1.mode = L2
  return L1
end
getQosCfg = L4
function L4(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "miqos"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQDeviceUtil"
  L3 = L3(L4)
  L4 = {}
  L5 = {}
  L6 = L3.getDeviceList
  L7 = true
  L6 = L6(L7, L8)
  L7 = L2.cmd
  L7 = L7(L8)
  if L6 then
    if L8 == "table" then
      if 0 < L8 then
        for L11, L12 in L8, L9, L10 do
          L13 = L12.ip
          L5[L13] = L12
        end
      end
    end
  end
  if L5 and L7 then
    if L8 == 0 then
      if L8 then
        for L11, L12 in L8, L9, L10 do
          L13 = L5[L11]
          if L13 then
            L14 = L1.clone
            L15 = L13
            L16 = true
            L14 = L14(L15, L16)
            L13 = L14
            L13.ip = L11
            L14 = {}
            L15 = tonumber
            L16 = L12.DOWN
            L16 = L16.max_per
            L15 = L15(L16)
            L15 = L15 / 8
            L14.downmax = L15
            L15 = tonumber
            L16 = L12.DOWN
            L16 = L16.min_per
            L15 = L15(L16)
            L15 = L15 / 8
            L14.downmin = L15
            L15, L16 = nil, nil
            if A0 then
              L17 = A0.download
              if 0 < L17 then
                L17 = tonumber
                L18 = L12.DOWN
                L18 = L18.max_per
                L17 = L17(L18)
                L17 = L17 or L17
                L15 = 100 * L17
                L17 = _levelHelper
                L18 = tonumber
                L19 = L12.DOWN
                L19 = L19.min_per
                L18 = L18(L19)
                L18 = L18 or L18
                L17 = L17(L18)
                L16 = L17
            end
            else
              L16 = 2
              L15 = 100
            end
            L14.maxdownper = L15
            L17 = tonumber
            L18 = L12.UP
            L18 = L18.max_per
            L17 = L17(L18)
            L17 = L17 / 8
            L14.upmax = L17
            L17 = tonumber
            L18 = L12.UP
            L18 = L18.min_per
            L17 = L17(L18)
            L17 = L17 / 8
            L14.upmin = L17
            L17 = nil
            L18 = A0.upload
            if 0 < L18 then
              L18 = tonumber
              L19 = L12.UP
              L19 = L19.max_per
              L18 = L18(L19)
              L18 = L18 or L18
              L17 = 100 * L18
            else
              L17 = 100
            end
            L14.level = L16
            L14.upmaxper = L17
            L13.qos = L14
            L18 = L13.isap
            if L18 == 0 then
              L18 = table
              L18 = L18.insert
              L19 = L4
              L20 = L13
              L18(L19, L20)
            end
            L18 = L13.statistics
            if L18 then
              L19 = math
              L19 = L19.floor
              L20 = L14.upmax
              L19 = L19(L20)
              if 0 ~= L19 then
                L19 = math
                L19 = L19.min
                L20 = math
                L20 = L20.floor
                L21 = L14.upmax
                L21 = L21 * 1024
                L20 = L20(L21)
                L21 = L18.upspeed
                L19 = L19(L20, L21)
                L18.upspeed = L19
              end
              L19 = math
              L19 = L19.floor
              L20 = L14.downmax
              L19 = L19(L20)
              if 0 ~= L19 then
                L19 = math
                L19 = L19.min
                L20 = math
                L20 = L20.floor
                L21 = L14.downmax
                L21 = L21 * 1024
                L20 = L20(L21)
                L21 = L18.downspeed
                L19 = L19(L20, L21)
                L18.downspeed = L19
              end
            end
          end
        end
      end
    end
  end
  return L4
end
qosList = L4
function L4(A0)
  local L1, L2, L3, L4
  L1 = getQosCfg
  L1 = L1()
  L2 = {}
  L2.upmax = 0
  L2.downmax = 0
  L2.flag = "off"
  L3 = L1.status
  if L3 ~= 0 then
    L3 = nil
    return L3
  end
  L3 = L1.data
  if L3 then
    L3 = L1.data
    L3 = L3[A0]
    if L3 then
      L3 = tonumber
      L4 = L1.data
      L4 = L4[A0]
      L4 = L4.max_grp_uplink
      L3 = L3(L4)
      L3 = L3 / 8
      L2.upmax = L3
      L3 = tonumber
      L4 = L1.data
      L4 = L4[A0]
      L4 = L4.max_grp_downlink
      L3 = L3(L4)
      L3 = L3 / 8
      L2.downmax = L3
      L3 = L1.data
      L3 = L3[A0]
      L3 = L3.flag
      L2.flag = L3
      L3 = L1.data
      L3 = L3[A0]
      L3 = L3.flag
      if not L3 then
        L3 = L2.upmax
        if not (0 < L3) then
          L3 = L2.downmax
          if not (0 < L3) then
            goto lbl_50
          end
        end
        L2.flag = "on"
        goto lbl_51
        ::lbl_50::
        L2.flag = "off"
      end
    end
  end
  ::lbl_51::
  return L2
end
macQosInfo = L4
function L4(A0, A1, A2, A3, A4, A5, A6)
  local L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L7 = require
  L8 = "luci.cbi.datatypes"
  L7 = L7(L8)
  L8 = require
  L9 = "luci.model.uci"
  L8 = L8(L9)
  L8 = L8.cursor
  L8 = L8()
  L9 = string
  L9 = L9.gsub
  L10 = A1
  L11 = ":"
  L12 = ""
  L9 = L9(L10, L11, L12)
  L10 = false
  L11, L12, L13 = nil, nil, nil
  L14 = _UPVALUE0_
  L14 = L14.isStrNil
  L15 = A0
  L14 = L14(L15)
  if not L14 then
    L14 = _UPVALUE0_
    L14 = L14.isStrNil
    L15 = A1
    L14 = L14(L15)
    if not L14 then
      L14 = L7.macaddr
      L15 = A1
      L14 = L14(L15)
      if L14 then
        goto lbl_36
      end
    end
  end
  L14 = false
  do return L14 end
  ::lbl_36::
  L15 = L8
  L14 = L8.get_all
  L16 = "miqos"
  L17 = L9
  L14 = L14(L15, L16, L17)
  L12 = L14 or L12
  if not L14 then
    L12 = nil
  end
  if L12 then
    L14 = L12[".type"]
    if L14 == "group" then
      goto lbl_98
    end
  end
  L15 = L8
  L14 = L8.section
  L16 = "miqos"
  L17 = "group"
  L18 = L9
  L14(L15, L16, L17, L18)
  L15 = L8
  L14 = L8.set
  L16 = "miqos"
  L17 = L9
  L18 = "name"
  L19 = A1
  L14(L15, L16, L17, L18, L19)
  L15 = L8
  L14 = L8.set
  L16 = "miqos"
  L17 = L9
  L18 = "min_grp_uplink"
  L19 = "0.5"
  L14(L15, L16, L17, L18, L19)
  L15 = L8
  L14 = L8.set
  L16 = "miqos"
  L17 = L9
  L18 = "min_grp_downlink"
  L19 = "0.5"
  L14(L15, L16, L17, L18, L19)
  L15 = L8
  L14 = L8.set
  L16 = "miqos"
  L17 = L9
  L18 = "max_grp_uplink"
  L19 = "0"
  L14(L15, L16, L17, L18, L19)
  L15 = L8
  L14 = L8.set
  L16 = "miqos"
  L17 = L9
  L18 = "max_grp_downlink"
  L19 = "0"
  L14(L15, L16, L17, L18, L19)
  L15 = L8
  L14 = L8.set
  L16 = "miqos"
  L17 = L9
  L18 = "mode"
  L19 = "general"
  L14(L15, L16, L17, L18, L19)
  L15 = L8
  L14 = L8.set
  L16 = "miqos"
  L17 = L9
  L18 = "mac"
  L19 = {}
  L20 = A1
  L19[1] = L20
  L14(L15, L16, L17, L18, L19)
  L10 = true
  ::lbl_98::
  L14 = _UPVALUE0_
  L14 = L14.isStrNil
  L15 = A6
  L14 = L14(L15)
  if L14 and A2 and A3 then
    A6 = "on"
  end
  if A6 and (A6 == "on" or A6 == "off") then
    L15 = L8
    L14 = L8.get
    L16 = "miqos"
    L17 = L9
    L18 = "flag"
    L14 = L14(L15, L16, L17, L18)
    L13 = L14 or L13
    if not L14 then
      L13 = "off"
    end
    if L13 ~= A6 then
      L15 = L8
      L14 = L8.set
      L16 = "miqos"
      L17 = L9
      L18 = "flag"
      L19 = A6
      L14(L15, L16, L17, L18, L19)
      L10 = true
    end
  end
  if A4 then
    L14 = tonumber
    L15 = A4
    L14 = L14(L15)
    L11 = L14
    if L11 <= 0 or 1 < L11 then
      A4 = nil
    end
    L15 = L8
    L14 = L8.get
    L16 = "miqos"
    L17 = L9
    L18 = "min_grp_uplink"
    L14 = L14(L15, L16, L17, L18)
    L13 = L14 or L13
    if not L14 then
      L13 = nil
    end
    if L13 ~= A4 then
      L15 = L8
      L14 = L8.set
      L16 = "miqos"
      L17 = L9
      L18 = "min_grp_uplink"
      L19 = A4
      L14(L15, L16, L17, L18, L19)
      L10 = true
    end
  end
  if A5 then
    L14 = tonumber
    L15 = A5
    L14 = L14(L15)
    L11 = L14
    if L11 <= 0 or 1 < L11 then
      A5 = nil
    end
    L15 = L8
    L14 = L8.get
    L16 = "miqos"
    L17 = L9
    L18 = "min_grp_downlink"
    L14 = L14(L15, L16, L17, L18)
    L13 = L14 or L13
    if not L14 then
      L13 = nil
    end
    if L13 ~= A5 then
      L15 = L8
      L14 = L8.set
      L16 = "miqos"
      L17 = L9
      L18 = "min_grp_downlink"
      L19 = A5
      L14(L15, L16, L17, L18, L19)
      L10 = true
    end
  end
  if A2 then
    L14 = tonumber
    L15 = A2
    L14 = L14(L15)
    L11 = L14
    if L11 < 8 then
      A2 = 0
    end
    L15 = L8
    L14 = L8.get
    L16 = "miqos"
    L17 = L9
    L18 = "max_grp_uplink"
    L14 = L14(L15, L16, L17, L18)
    L13 = L14 or L13
    if not L14 then
      L13 = nil
    end
    if L13 ~= A2 then
      L15 = L8
      L14 = L8.set
      L16 = "miqos"
      L17 = L9
      L18 = "max_grp_uplink"
      L19 = A2
      L14(L15, L16, L17, L18, L19)
      L10 = true
    end
  end
  if A3 then
    L14 = tonumber
    L15 = A3
    L14 = L14(L15)
    L11 = L14
    if L11 < 8 then
      A3 = 0
    end
    L15 = L8
    L14 = L8.get
    L16 = "miqos"
    L17 = L9
    L18 = "max_grp_downlink"
    L14 = L14(L15, L16, L17, L18)
    L13 = L14 or L13
    if not L14 then
      L13 = nil
    end
    if L13 ~= A3 then
      L15 = L8
      L14 = L8.set
      L16 = "miqos"
      L17 = L9
      L18 = "max_grp_downlink"
      L19 = A3
      L14(L15, L16, L17, L18, L19)
      L10 = true
    end
  end
  if L10 then
    L15 = L8
    L14 = L8.commit
    L16 = "miqos"
    L14(L15, L16)
  end
  L14 = true
  return L14
end
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = require
  L4 = "miqos"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = A0
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE0_
    L4 = L4.macFormat
    L5 = A0
    L4 = L4(L5)
    A0 = L4
    L4 = tonumber
    L5 = A1
    L4 = L4(L5)
    if L4 then
      L4 = tonumber
      L5 = A2
      L4 = L4(L5)
      if L4 then
        L4 = _UPVALUE1_
        L5 = "max"
        L6 = A0
        L7 = tostring
        L8 = tonumber
        L9 = A1
        L8 = L8(L9)
        L8 = 8 * L8
        L7 = L7(L8)
        L8 = tostring
        L9 = tonumber
        L10 = A2
        L9 = L9(L10)
        L9 = 8 * L9
        L8, L9, L10 = L8(L9)
        L4(L5, L6, L7, L8, L9, L10)
        L4 = L3.cmd
        L5 = "apply"
        L4(L5)
        L4 = true
        return L4
      end
    end
  end
  L4 = false
  return L4
end
setMacQosInfo = L5
function L5(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L4 = require
  L5 = "miqos"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A0
  L5 = L5(L6)
  if not L5 then
    L5 = tonumber
    L6 = A1
    L5 = L5(L6)
    if L5 then
      L5 = _UPVALUE0_
      L5 = L5.macFormat
      L6 = A0
      L5 = L5(L6)
      A0 = L5
      L5 = tonumber
      L6 = A1
      L5 = L5(L6)
      A1 = L5
      L5 = qosStatus
      L5 = L5()
      if L5 then
        L6 = L5.mode
        if L6 ~= A1 then
          L6 = setQoSMode
          L7 = A1
          L6 = L6(L7)
          if L6 ~= 0 then
            L6 = false
            return L6
          end
        end
      end
      if A1 == 1 then
        L6 = _weightHelper
        L7 = tonumber
        L8 = A2
        L7, L8, L9, L10, L11, L12, L13 = L7(L8)
        L6 = L6(L7, L8, L9, L10, L11, L12, L13)
        A2 = L6
        L6 = _weightHelper
        L7 = tonumber
        L8 = A3
        L7, L8, L9, L10, L11, L12, L13 = L7(L8)
        L6 = L6(L7, L8, L9, L10, L11, L12, L13)
        A3 = L6
        if A2 and A3 then
          L6 = _UPVALUE1_
          L7 = "min"
          L8 = A0
          L9, L10 = nil, nil
          L11 = tostring
          L12 = A2
          L11 = L11(L12)
          L12 = tostring
          L13 = A3
          L12, L13 = L12(L13)
          L6(L7, L8, L9, L10, L11, L12, L13)
          L6 = L4.cmd
          L7 = "apply"
          L6(L7)
          L6 = true
          return L6
        end
      else
        L6 = tonumber
        L7 = A2
        L6 = L6(L7)
        if L6 then
          L6 = tonumber
          L7 = A3
          L6 = L6(L7)
          if L6 then
            L6 = _UPVALUE1_
            L7 = "max"
            L8 = A0
            L9 = tostring
            L10 = tonumber
            L11 = A2
            L10 = L10(L11)
            L10 = 8 * L10
            L9 = L9(L10)
            L10 = tostring
            L11 = tonumber
            L12 = A3
            L11 = L11(L12)
            L11 = 8 * L11
            L10, L11, L12, L13 = L10(L11)
            L6(L7, L8, L9, L10, L11, L12, L13)
            L6 = L4.cmd
            L7 = "apply"
            L6(L7)
            L6 = true
            return L6
          end
        end
      end
    end
  end
  L5 = false
  return L5
end
qosOnLimit = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = require
  L3 = "miqos"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if not L3 and (A1 == "on" or A1 == "off") then
    L3 = _UPVALUE0_
    L3 = L3.macFormat
    L4 = A0
    L3 = L3(L4)
    A0 = L3
    L3 = _UPVALUE1_
    L4 = "max"
    L5 = A0
    L6, L7, L8, L9 = nil, nil, nil, nil
    L10 = A1
    L3(L4, L5, L6, L7, L8, L9, L10)
    L3 = L2.cmd
    L4 = "apply"
    L3(L4)
    L3 = true
    return L3
  else
    L3 = false
    return L3
  end
end
qosLimitFlag = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L2 = require
  L2 = L2(L3)
  if A1 then
    if L3 == "table" then
      if not (L3 <= 0) then
        goto lbl_16
      end
    end
  end
  do return L3 end
  ::lbl_16::
  if A0 then
    A0 = L3
    if L3 then
      if L4 == 1 then
        goto lbl_31
      end
    end
    do return L4 end
    ::lbl_31::
    if L3 then
      if L4 ~= A0 then
        if L4 ~= 0 then
          return L4
        end
      end
    end
    for L7, L8 in L4, L5, L6 do
      L9 = _UPVALUE0_
      L9 = L9.macFormat
      L10 = L8.mac
      L9 = L9(L10)
      L10 = tonumber
      L11 = L8.maxup
      L10 = L10(L11)
      L11 = tonumber
      L12 = L8.maxdown
      L11 = L11(L12)
      if A0 == "1" then
        L12 = _weightHelper
        L13 = tonumber
        L14 = L8.maxup
        L13, L14, L15, L16, L17, L18, L19 = L13(L14)
        L12 = L12(L13, L14, L15, L16, L17, L18, L19)
        L10 = L12
        L12 = _weightHelper
        L13 = tonumber
        L14 = L8.maxdown
        L13, L14, L15, L16, L17, L18, L19 = L13(L14)
        L12 = L12(L13, L14, L15, L16, L17, L18, L19)
        L11 = L12
        if L10 and L11 then
          L12 = _UPVALUE1_
          L13 = "min"
          L14 = L9
          L15, L16 = nil, nil
          L17 = tostring
          L18 = L10
          L17 = L17(L18)
          L18 = tostring
          L19 = L11
          L18, L19 = L18(L19)
          L12(L13, L14, L15, L16, L17, L18, L19)
        end
      elseif L10 and L11 then
        L12 = _UPVALUE1_
        L13 = "max"
        L14 = L9
        L15 = tostring
        L16 = 8 * L10
        L15 = L15(L16)
        L16 = tostring
        L17 = 8 * L11
        L16, L17, L18, L19 = L16(L17)
        L12(L13, L14, L15, L16, L17, L18, L19)
      end
    end
  else
    for L6, L7 in L3, L4, L5 do
      L8 = _UPVALUE0_
      L8 = L8.macFormat
      L9 = L7.mac
      L8 = L8(L9)
      L9 = tonumber
      L10 = L7.maxup
      L9 = L9(L10)
      L10 = tonumber
      L11 = L7.maxdown
      L10 = L10(L11)
      if L9 and L10 then
        L11 = _UPVALUE1_
        L12 = "max"
        L13 = L8
        L14 = tostring
        L15 = 8 * L9
        L14 = L14(L15)
        L15 = tostring
        L16 = 8 * L10
        L15, L16, L17, L18, L19 = L15(L16)
        L11(L12, L13, L14, L15, L16, L17, L18, L19)
      end
    end
  end
  L3(L4)
  L3(L4)
  return L3
end
qosOnLimits = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "miqos"
  L1 = L1(L2)
  L2 = nil
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if not L3 then
    L3 = L1.cmd
    L4 = string
    L4 = L4.format
    L5 = "off_limit %s"
    L6 = _UPVALUE0_
    L6 = L6.macFormat
    L7 = A0
    L6, L7 = L6(L7)
    L4, L5, L6, L7 = L4(L5, L6, L7)
    L3 = L3(L4, L5, L6, L7)
    L2 = L3
  else
    L3 = L1.cmd
    L4 = string
    L4 = L4.format
    L5 = "off_limit"
    L4, L5, L6, L7 = L4(L5)
    L3 = L3(L4, L5, L6, L7)
    L2 = L3
  end
  if L2 then
    L3 = L2.status
    if L3 == 0 then
      L3 = true
      return L3
  end
  else
    L3 = false
    return L3
  end
end
qosOffLimit = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = {}
  L2 = {}
  L2.on = 0
  L2.mode = 0
  L1.status = L2
  L2 = {}
  L2.upload = 0
  L2.download = 0
  L1.band = L2
  L2 = qosStatus
  L2 = L2()
  L1.status = L2
  L3 = qosBand
  L3 = L3()
  L1.band = L3
  L3 = getQosCfg
  L3 = L3()
  if L3 then
    L4 = L3.status
    if L4 == 0 then
      L4 = L2.mode
      if L4 ~= 0 then
        L4 = {}
        if A0 then
          if L5 == "table" then
            if 0 < L5 then
              for L8, L9 in L5, L6, L7 do
                L10 = {}
                L11 = _UPVALUE0_
                L11 = L11.macFormat
                L12 = L9
                L11 = L11(L12)
                L10.mac = L11
                L11 = L3.data
                L12 = L10.mac
                L11 = L11[L12]
                if L11 then
                  L12 = L2.mode
                  if L12 == 1 then
                    L12 = _levelHelper
                    L13 = tonumber
                    L14 = L11.min_grp_downlink
                    L13, L14 = L13(L14)
                    L12 = L12(L13, L14)
                    L10.level = L12
                  else
                    L12 = tonumber
                    L13 = L11.max_grp_uplink
                    L12 = L12(L13)
                    L12 = L12 / 8
                    L10.upmax = L12
                    L12 = tonumber
                    L13 = L11.max_grp_downlink
                    L12 = L12(L13)
                    L12 = L12 / 8
                    L10.downmax = L12
                  end
                  L12 = L11.flag
                  if not L12 then
                    L12 = L10.upmax
                    if L12 then
                      L12 = L10.upmax
                      if 0 < L12 then
                        goto lbl_87
                      end
                    end
                    L12 = L10.downmax
                    if L12 then
                      L12 = L10.downmax
                      ::lbl_87::
                      if 0 < L12 then
                        L10.flag = "on"
                    end
                    else
                      L10.flag = "off"
                    end
                  else
                    L12 = L11.flag
                    if L12 == "on" then
                      L10.flag = "on"
                    else
                      L10.flag = "off"
                    end
                  end
                else
                  L12 = L2.mode
                  if L12 == 1 then
                    L10.level = 2
                  else
                    L10.upmax = 0
                    L10.downmax = 0
                  end
                  L10.flag = "off"
                end
                L4[L9] = L10
              end
          end
        end
        else
          for L8, L9 in L5, L6, L7 do
            L10 = {}
            L11 = L2.mode
            if L11 == 1 then
              L10.mac = L8
              L11 = _levelHelper
              L12 = tonumber
              L13 = L9.min_grp_downlink
              L12, L13, L14 = L12(L13)
              L11 = L11(L12, L13, L14)
              L10.level = L11
            else
              L10.mac = L8
              L11 = tonumber
              L12 = L9.max_grp_uplink
              L11 = L11(L12)
              L11 = L11 / 8
              L10.upmax = L11
              L11 = tonumber
              L12 = L9.max_grp_downlink
              L11 = L11(L12)
              L11 = L11 / 8
              L10.downmax = L11
            end
            L11 = L9.flag
            if not L11 then
              L11 = L10.upmax
              if L11 then
                L11 = L10.upmax
                if 0 < L11 then
                  goto lbl_152
                end
              end
              L11 = L10.downmax
              if L11 then
                L11 = L10.downmax
                ::lbl_152::
                if 0 < L11 then
                  L10.flag = "on"
              end
              else
                L10.flag = "off"
              end
            else
              L11 = L9.flag
              if L11 == "on" then
                L10.flag = "on"
              else
                L10.flag = "off"
              end
            end
            L4[L8] = L10
          end
        end
        L1.dict = L4
      end
    end
  end
  return L1
end
qosHistory = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = {}
  L1.guest = 0.6
  L1.xq = 0.9
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = {}
  L4 = {}
  L5 = {}
  if A0 ~= "guest" and A0 ~= "xq" then
    return L3
  end
  L9 = A0
  L10 = "up_per"
  L4.UP = L6
  L9 = A0
  L10 = "down_per"
  L4.DOWN = L6
  L9 = "settings"
  L10 = "upload"
  L5.UP = L6
  L9 = "settings"
  L10 = "download"
  L5.DOWN = L6
  if L6 < 8000 then
    L5.UP = "0"
    L5.DOWN = "0"
  end
  L3.percent_up = L6
  L3.percent = L6
  L9 = "DOWN"
  L7[1] = L8
  L7[2] = L9
  for L9, L10 in L6, L7, L8 do
    L11 = tonumber
    L12 = L4[L10]
    L11 = L11(L12)
    L12 = tonumber
    L13 = L5[L10]
    L12 = L12(L13)
    if L11 <= 0 then
      L3[L10] = L12
    elseif L11 <= 1 then
      L13 = math
      L13 = L13.ceil
      L14 = L12 * L11
      L13 = L13(L14)
      L3[L10] = L13
    else
      L13 = math
      L13 = L13.ceil
      L14 = L11
      L13 = L13(L14)
      L3[L10] = L13
    end
  end
  return L3
end
function L6()
  local L0, L1
  L0 = _UPVALUE0_
  L1 = "guest"
  return L0(L1)
end
guestQoSInfo = L6
function L6()
  local L0, L1
  L0 = _UPVALUE0_
  L1 = "xq"
  return L0(L1)
end
xqQoSInfo = L6
function L6(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = require
  L4 = "miqos"
  L3 = L3(L4)
  L4 = nil
  if A1 then
    L5 = tonumber
    L6 = A1
    L5 = L5(L6)
    if L5 then
      L5 = tonumber
      L6 = A1
      L5 = L5(L6)
      if 0 <= L5 then
        L5 = tonumber
        L6 = A1
        L5 = L5(L6)
        if L5 <= 1 then
          if A2 then
            L5 = tonumber
            L6 = A2
            L5 = L5(L6)
            if not (L5 < 0) then
              goto lbl_35
            end
            L5 = tonumber
            L6 = A2
            L5 = L5(L6)
            if not (1 < L5) then
              goto lbl_35
            end
          end
          A2 = A1
          ::lbl_35::
          if A0 == "guest" then
            L4 = "on_guest "
          elseif A0 == "xq" then
            L4 = "on_xq "
          else
            L5 = false
            return L5
          end
          L5 = L4
          L6 = tostring
          L7 = A2
          L6 = L6(L7)
          L7 = " "
          L8 = tostring
          L9 = A1
          L8 = L8(L9)
          L4 = L5 .. L6 .. L7 .. L8
          L5 = L3.cmd
          L6 = L4
          L5(L6)
          L5 = true
          return L5
      end
    end
  end
  else
    L5 = false
    return L5
  end
end
setQosGuestOrXQ = L6
function L6(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12
  L5 = require
  L6 = "xqcrypto"
  L5 = L5(L6)
  if not A0 or not A4 then
    L6 = -1
    return L6
  end
  L6 = L5.app_opt
  L7 = tostring
  L8 = A0
  L7 = L7(L8)
  L8 = "+"
  L6 = L6(L7, L8)
  if 0 <= L6 then
    if A4 == 0 then
      L7 = L5.lan_opt
      L8 = tostring
      L9 = L6
      L8 = L8(L9)
      L9 = "+"
      L10 = A1 or L10
      if not A1 then
        L10 = "0.0.0.0"
      end
      L7 = L7(L8, L9, L10)
      if L7 == 0 then
        if A2 or A3 then
          L7 = L5.remote_opt
          L8 = tostring
          L9 = L6
          L8 = L8(L9)
          L9 = "+"
          L10 = tostring
          L11 = A2 or L11
          if not A2 then
            L11 = "0.0.0.0"
          end
          L10 = L10(L11)
          L11 = tostring
          L12 = A3 or L12
          if not A3 then
            L12 = 0
          end
          L11, L12 = L11(L12)
          L7 = L7(L8, L9, L10, L11, L12)
          if L7 == 0 then
            L7 = 0
            return L7
          else
            L7 = -4
            return L7
          end
        end
      else
        L7 = -3
        return L7
      end
    elseif A4 == 1 then
      if not A1 then
        L7 = L5.app_opt
        L8 = tostring
        L9 = A0
        L8 = L8(L9)
        L9 = "-"
        L7 = L7(L8, L9)
        if 0 <= L7 then
          L7 = 0
          return L7
        else
          L7 = -2
          return L7
        end
      else
        L7 = L5.lan_opt
        L8 = tostring
        L9 = L6
        L8 = L8(L9)
        L9 = "-"
        L10 = A1
        L7 = L7(L8, L9, L10)
        if L7 == 0 then
          L7 = 0
          return L7
        else
          L7 = -3
          return L7
        end
        if A2 or A3 then
          L7 = L5.remote_opt
          L8 = tostring
          L9 = L6
          L8 = L8(L9)
          L9 = "-"
          L10 = tostring
          L11 = A2 or L11
          if not A2 then
            L11 = "0.0.0.0"
          end
          L10 = L10(L11)
          L11 = tostring
          L12 = A3 or L12
          if not A3 then
            L12 = 0
          end
          L11, L12 = L11(L12)
          L7 = L7(L8, L9, L10, L11, L12)
          if L7 == 0 then
            L7 = 0
            return L7
          else
            L7 = -4
            return L7
          end
        end
        L7 = 0
        return L7
      end
    else
      L7 = -1
      return L7
    end
  else
    L7 = -2
    return L7
  end
end
qos_app = L6
