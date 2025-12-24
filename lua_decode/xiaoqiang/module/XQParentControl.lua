local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
L0 = module
L1 = "xiaoqiang.module.XQParentControl"
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
L3 = "bit"
L2 = L2(L3)
L3 = require
L4 = "math"
L3 = L3(L4)
L4 = require
L5 = "nixio.fs"
L4 = L4(L5)
L5 = require
L6 = "luci.model.uci"
L5 = L5(L6)
L5 = L5.cursor
L5 = L5()
L6 = require
L7 = "luci.util"
L6 = L6(L7)
L7 = require
L8 = "luci.cbi.datatypes"
L7 = L7(L8)
L8 = 5
L9 = {}
L9.Mon = 1
L9.Tue = 2
L9.Wed = 3
L9.Thu = 4
L9.Fri = 5
L9.Sat = 6
L9.Sun = 7
L10 = {}
L11 = "Mon"
L12 = "Tue"
L13 = "Wed"
L14 = "Thu"
L15 = "Fri"
L16 = "Sat"
L17 = "Sun"
L10[1] = L11
L10[2] = L12
L10[3] = L13
L10[4] = L14
L10[5] = L15
L10[6] = L16
L10[7] = L17
function L11()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get_all
  L2 = "parentalctl"
  L3 = "global"
  L0 = L0(L1, L2, L3)
  L1 = {}
  L1.on = 1
  if L0 then
    L2 = L0.disabled
    if L2 then
      L2 = tonumber
      L3 = L0.disabled
      L2 = L2(L3)
      if L2 == 1 then
        L1.on = 0
      end
    end
  end
  return L1
end
get_global_info = L11
function L11(A0)
  local L1, L2, L3, L4, L5
  L1 = true
  L2 = _UPVALUE0_
  L2 = L2.exec
  L3 = "/usr/sbin/sysapi macfilter get | grep \""
  L4 = string
  L4 = L4.lower
  L5 = A0
  L4 = L4(L5)
  L5 = "\""
  L3 = L3 .. L4 .. L5
  L2 = L2(L3)
  if L2 then
    L3 = _UPVALUE0_
    L3 = L3.trim
    L4 = L2
    L3 = L3(L4)
    L2 = L3
    L3 = L2
    L4 = ";"
    L2 = L3 .. L4
    L4 = L2
    L3 = L2.match
    L5 = "wan=(%S-);"
    L3 = L3(L4, L5)
    if L3 and L3 ~= "yes" then
      L1 = false
    end
  end
  return L1
end
get_macfilter_wan = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = require
  L3 = "xiaoqiang.util.XQSynchrodata"
  L2 = L2(L3)
  L4 = A0
  L3 = A0.gsub
  L5 = ":"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L4 = {}
  L4.mac = A0
  L4.disabled = "0"
  L4.mark = "1"
  if A1 then
    L5 = "none"
    if L5 then
      goto lbl_18
    end
  end
  L5 = "limited"
  ::lbl_18::
  L4.mode = L5
  summary = L4
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.section
  L6 = "parentalctl"
  L7 = "summary"
  L8 = L3
  L9 = summary
  L4(L5, L6, L7, L8, L9)
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.commit
  L6 = "parentalctl"
  L4(L5, L6)
  L4 = apply
  L4()
end
macfilter_wan_changed = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = A0
  L1 = A0.gsub
  L1 = L1(L2, L3, L4)
  L2 = _UPVALUE0_
  L2 = L2.pow
  L2 = L2(L3, L4)
  L2 = L2 - 1
  L6 = "device"
  function L7(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = A0[".name"]
    L2 = L1
    L1 = L1.match
    L3 = "^"
    L4 = _UPVALUE0_
    L5 = "_"
    L3 = L3 .. L4 .. L5
    L1 = L1(L2, L3)
    if L1 then
      L1 = A0[".name"]
      L2 = L1
      L1 = L1.gsub
      L3 = _UPVALUE0_
      L4 = "_"
      L3 = L3 .. L4
      L4 = ""
      L1 = L1(L2, L3, L4)
      L2 = tonumber
      L3 = L1
      L2 = L2(L3)
      if L2 then
        L3 = _UPVALUE1_
        if L2 <= L3 then
          L3 = _UPVALUE3_
          L3 = L3.bxor
          L4 = _UPVALUE2_
          L5 = _UPVALUE4_
          L5 = L5.pow
          L6 = 2
          L7 = L2 - 1
          L5, L6, L7 = L5(L6, L7)
          L3 = L3(L4, L5, L6, L7)
          _UPVALUE2_ = L3
        end
      end
    end
  end
  L3(L4, L5, L6, L7)
  for L6 = L3, L4, L5 do
    L7 = _UPVALUE3_
    L7 = L7.band
    L8 = L2
    L9 = _UPVALUE0_
    L9 = L9.pow
    L10 = 2
    L11 = L6 - 1
    L9, L10, L11 = L9(L10, L11)
    L7 = L7(L8, L9, L10, L11)
    if 0 < L7 then
      L7 = L1
      L8 = "_"
      L9 = tostring
      L10 = L6
      L9 = L9(L10)
      L7 = L7 .. L8 .. L9
      return L7
    end
  end
  return L3
end
_generate_key = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = {}
  L3, L4, L5 = nil, nil, nil
  for L9, L10 in L6, L7, L8 do
    L11 = tonumber
    L12 = L10
    L11 = L11(L12)
    if L11 == 0 then
      L2 = nil
      break
    end
    L11 = _UPVALUE0_
    L12 = tonumber
    L13 = L10
    L12 = L12(L13)
    L11 = L11[L12]
    if L11 then
      L11 = table
      L11 = L11.insert
      L12 = L2
      L13 = _UPVALUE0_
      L14 = tonumber
      L15 = L10
      L14 = L14(L15)
      L13 = L13[L14]
      L11(L12, L13)
    end
  end
  if L2 then
    L3 = L6
  else
    L4 = L6
    L5 = L4 + 86400
    if not L6 then
      L9 = "([%d:]+)%-([%d:]+)"
      if L6 > L7 then
        L4 = L4 + 86400
      end
      if L7 < L8 then
        L5 = L4 + 86400
      else
        L5 = L4 + 172800
      end
    end
    L4 = L6
    L5 = L6
    if L6 == "string" then
      if L6 == "string" then
        goto lbl_92
      end
    end
    return L6, L7, L8
  end
  ::lbl_92::
  return L6, L7, L8
end
_parse_frequency = L11
function L11(A0)
  local L1, L2
  if A0 then
    L1 = _UPVALUE0_
    L1 = L1.forkExec
    L2 = "/usr/sbin/parentalctl.sh 2>/dev/null >/dev/null"
    L1(L2)
  else
    L1 = os
    L1 = L1.execute
    L2 = "/usr/sbin/parentalctl.sh 2>/dev/null >/dev/null"
    L1(L2)
  end
end
apply = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE1_
    L1 = L1.macaddr
    L2 = A0
    L1 = L1(L2)
    if L1 then
      goto lbl_16
    end
  end
  L1 = nil
  do return L1 end
  goto lbl_21
  ::lbl_16::
  L1 = _UPVALUE0_
  L1 = L1.macFormat
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  ::lbl_21::
  L1 = get_macfilter_wan
  L2 = A0
  L1 = L1(L2)
  L2 = {}
  L4 = A0
  L3 = A0.gsub
  L5 = ":"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L4 = _UPVALUE2_
  L5 = L4
  L4 = L4.get_all
  L6 = "parentalctl"
  L7 = L3
  L4 = L4(L5, L6, L7)
  if L4 then
    L5 = tonumber
    L6 = L4.mark
    L5 = L5(L6)
    if L5 then
      L5 = tonumber
      L6 = L4.mark
      L5 = L5(L6)
      if L5 == 1 then
        L5 = tonumber
        L6 = L4.disabled
        L5 = L5(L6)
        if L5 == 0 then
          L5 = 1
          if L5 then
            goto lbl_55
          end
        end
        L5 = 0
        ::lbl_55::
        L2.enable = L5
        L5 = L4.mode
        L5 = L5 or L5
        L2.mode = L5
        if not L1 then
          L2.mode = "limited"
          L2.enable = 1
          L5 = _UPVALUE2_
          L6 = L5
          L5 = L5.set
          L7 = "parentalctl"
          L8 = L3
          L9 = "disabled"
          L10 = "0"
          L5(L6, L7, L8, L9, L10)
          L5 = _UPVALUE2_
          L6 = L5
          L5 = L5.set
          L7 = "parentalctl"
          L8 = L3
          L9 = "mode"
          L10 = "limited"
          L5(L6, L7, L8, L9, L10)
          L5 = _UPVALUE2_
          L6 = L5
          L5 = L5.commit
          L7 = "parentalctl"
          L5(L6, L7)
        end
    end
  end
  else
    L2.enable = 1
    if L1 then
      L2.mode = "none"
    else
      L2.mode = "limited"
    end
    L5 = {}
    L5.disabled = "0"
    L6 = L2.mode
    L5.mode = L6
    L5.mac = A0
    L6 = parentctl_rules
    L7 = {}
    L7[A0] = 1
    L6 = L6(L7)
    if L6 then
      L7 = L6[A0]
      if L7 then
        L7 = L6[A0]
        L7 = L7.enabled
        if 0 < L7 then
          L2.mode = "time"
          L7 = os
          L7 = L7.execute
          L8 = "/usr/sbin/sysapi macfilter set mac="
          L9 = A0
          L10 = " wan=yes; /usr/sbin/sysapi macfilter commit"
          L8 = L8 .. L9 .. L10
          L7(L8)
        end
      end
    end
    if L4 then
      L7 = L4.mark
      if not L7 then
        L7 = _UPVALUE2_
        L8 = L7
        L7 = L7.delete
        L9 = "parentalctl"
        L10 = L3
        L7(L8, L9, L10)
        L7 = _UPVALUE2_
        L8 = L7
        L7 = L7.commit
        L9 = "parentalctl"
        L7(L8, L9)
      end
    end
  end
  L5 = get_parentctl_url_filter
  L6 = A0
  L5 = L5(L6)
  L6 = {}
  L7 = L5.mode
  L6.mode = L7
  L7 = L5.count
  L6.count = L7
  L2.urlfilter = L6
  return L2
end
get_device_mode_info = L11
function L11(A0)
  local L1
  if A0 and A0 ~= "time" and A0 ~= "limited" and A0 ~= "none" then
    L1 = false
    return L1
  end
  L1 = true
  return L1
end
check_mode = L11
function L11(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L3 = require
  L4 = "xiaoqiang.util.XQSynchrodata"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.module.XQFirewall"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQController"
  L5 = L5(L6)
  L6 = {}
  L8 = A0
  L7 = A0.gsub
  L9 = ":"
  L10 = ""
  L7 = L7(L8, L9, L10)
  L8 = _UPVALUE0_
  L9 = L8
  L8 = L8.get_all
  L10 = "parentalctl"
  L11 = L7
  L8 = L8(L9, L10, L11)
  L9 = "1"
  if L8 then
    if A1 then
      if A1 == 1 then
        L10 = "0"
        if L10 then
          goto lbl_31
        end
      end
      L10 = "1"
      ::lbl_31::
      L8.disabled = L10
    end
    if A2 then
      L8.mode = A2
    end
  else
    L10 = {}
    L10.disabled = "0"
    L10.mode = "time"
    L10.mac = A0
    L8 = L10
    if A1 then
      if A1 == 1 then
        L10 = "0"
        if L10 then
          goto lbl_49
        end
      end
      L10 = "1"
      ::lbl_49::
      L8.disabled = L10
    end
    if A2 then
      L8.mode = A2
    end
  end
  L8.mark = 1
  L10 = tonumber
  L11 = L8.disabled
  L10 = L10(L11)
  if L10 == 0 then
    L10 = 1
    if L10 then
      goto lbl_63
    end
  end
  L10 = 0
  ::lbl_63::
  L6.enable = L10
  L10 = L8.mode
  L6.mode = L10
  L10 = L6.mode
  if L10 == "limited" then
    L10 = L6.enable
    if L10 == 1 then
      L9 = "0"
    end
  end
  L10 = _UPVALUE0_
  L11 = L10
  L10 = L10.section
  L12 = "parentalctl"
  L13 = "summary"
  L14 = L7
  L15 = L8
  L10(L11, L12, L13, L14, L15)
  L10 = _UPVALUE0_
  L11 = L10
  L10 = L10.commit
  L12 = "parentalctl"
  L10(L11, L12)
  L10 = L4.setMacFilter
  L11 = string
  L11 = L11.upper
  L12 = A0
  L11 = L11(L12)
  L12 = ""
  L13 = 0
  L14 = L9
  L10(L11, L12, L13, L14)
  L10 = L5.permission
  L11 = A0
  L12 = lan
  L13 = L9
  L14 = admin
  L15 = pridisk
  L10(L11, L12, L13, L14, L15)
  L10 = L3.syncDeviceInfo
  L11 = {}
  L11.mac = A0
  L10(L11)
  return L6
end
set_device_mode_info = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE1_
    L1 = L1.macaddr
    L2 = A0
    L1 = L1(L2)
    if L1 then
      goto lbl_16
    end
  end
  L1 = nil
  do return L1 end
  goto lbl_21
  ::lbl_16::
  L1 = _UPVALUE0_
  L1 = L1.macFormat
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  ::lbl_21::
  L1 = {}
  L2 = {}
  L4 = A0
  L3 = A0.gsub
  L5 = ":"
  L6 = ""
  L3 = L3(L4, L5, L6)
  L4 = os
  L4 = L4.date
  L5 = "%H:%M"
  L4 = L4(L5)
  L5 = os
  L5 = L5.date
  L6 = "%Y-%m-%d"
  L5 = L5(L6)
  L6 = os
  L6 = L6.date
  L7 = "%a"
  L6 = L6(L7)
  L7 = _UPVALUE2_
  L8 = L7
  L7 = L7.foreach
  L9 = "parentalctl"
  L10 = "device"
  function L11(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
    L1 = A0[".name"]
    L1 = L1.match
    L1 = L1(L2, L3)
    if L1 then
      L1 = {}
      L1.id = L2
      L1.mac = L2
      if L2 == 1 then
        if L2 then
          goto lbl_24
        end
      end
      ::lbl_24::
      L1.enable = L2
      L1.active = 0
      if L2 then
        if L2 and L3 then
          L4.from = L2
          L4.to = L3
          L1.timeseg = L4
        end
      end
      if L2 then
        if L2 then
          L2[1] = L3
          L1.frequency = L2
          if L2 == 1 then
            if not (L2 >= L3) then
              if L2 then
                if L2 > L3 then
                  if L2 > L3 then
                    if L2 > L3 then
                      goto lbl_94
                    end
                  end
                end
              end
              if not L2 then
                goto lbl_102
              end
              if not (L2 < L3) then
                goto lbl_102
              end
              if not (L2 > L3) then
                goto lbl_102
              end
              if L2 ~= L3 then
                goto lbl_102
              end
            end
            ::lbl_94::
            L1.enable = 0
            L7 = 1
            L2(L3, L4, L5, L6, L7)
          end
        end
      end
      ::lbl_102::
      if L2 then
        for L7, L8 in L4, L5, L6 do
          L9 = table
          L9 = L9.insert
          L10 = L2
          L11 = _UPVALUE5_
          L11 = L11[L8]
          L9(L10, L11)
        end
        L1.frequency = L2
      end
      if L2 == 1 then
        if L2 then
          for L5, L6 in L2, L3, L4 do
            L7 = _UPVALUE5_
            L8 = _UPVALUE6_
            L7 = L7[L8]
            if L6 == L7 or L6 == 0 then
              L7 = L1.timeseg
              if L7 then
                L7 = L1.timeseg
                L7 = L7.from
                L8 = L1.timeseg
                L8 = L8.to
                if L7 > L8 then
                  L7 = _UPVALUE2_
                  L8 = L1.timeseg
                  L8 = L8.from
                  L7 = L7 >= L8
                  if L6 == 0 or not L7 then
                    if L6 == 0 then
                      L8 = _UPVALUE1_
                      L9 = A0.start_date
                      if not (L8 > L9) or not L7 then
                        L8 = _UPVALUE1_
                        L9 = A0.start_date
                        if L8 == L9 then
                          L8 = _UPVALUE2_
                          L9 = L1.timeseg
                          L9 = L9.from
                          if L8 >= L9 then
                            L1.active = 1
                            break
                          end
                        end
                      end
                    end
                  end
                else
                  L7 = _UPVALUE2_
                  L8 = L1.timeseg
                  L8 = L8.from
                  if L7 >= L8 then
                    L7 = _UPVALUE2_
                    L8 = L1.timeseg
                    L8 = L8.to
                    if L7 <= L8 then
                      L7 = _UPVALUE1_
                      L8 = A0.start_date
                      if L7 == L8 then
                        L1.active = 1
                        break
                      end
                    end
                  end
                end
              else
                L1.active = 1
                break
              end
            end
          end
        end
      end
      L2(L3, L4)
    end
  end
  L7(L8, L9, L10, L11)
  L7 = _UPVALUE2_
  L8 = L7
  L7 = L7.commit
  L9 = "parentalctl"
  L7(L8, L9)
  L1.rules = L2
  return L1
end
get_device_info = L11
function L11(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L4 = require
  L5 = "xiaoqiang.util.XQSynchrodata"
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A0
  L5 = L5(L6)
  if not L5 and A2 then
    L5 = type
    L6 = A2
    L5 = L5(L6)
    if L5 == "table" then
      L5 = _UPVALUE0_
      L5 = L5.isStrNil
      L6 = A3
      L5 = L5(L6)
      if not L5 then
        L6 = A3
        L5 = A3.match
        L7 = "[%d:]+%-[%d:]+"
        L5 = L5(L6, L7)
        if L5 then
          goto lbl_31
        end
      end
    end
  end
  L5 = false
  do return L5 end
  goto lbl_36
  ::lbl_31::
  L5 = _UPVALUE0_
  L5 = L5.macFormat
  L6 = A0
  L5 = L5(L6)
  A0 = L5
  ::lbl_36::
  L5 = _generate_key
  L6 = A0
  L5 = L5(L6)
  if not L5 then
    L6 = false
    return L6
  end
  L6 = _parse_frequency
  L7 = A2
  L8 = A3
  L6, L7, L8 = L6(L7, L8)
  L9 = {}
  L9.mac = A0
  L9.weekdays = L6
  L9.start_date = L7
  L9.stop_date = L8
  if A1 == 1 then
    L10 = 0
    if L10 then
      goto lbl_58
    end
  end
  L10 = 1
  ::lbl_58::
  L9.disabled = L10
  L9.time_seg = A3
  L10 = _UPVALUE1_
  L11 = L10
  L10 = L10.section
  L12 = "parentalctl"
  L13 = "device"
  L14 = L5
  L15 = L9
  L10(L11, L12, L13, L14, L15)
  L10 = _UPVALUE1_
  L11 = L10
  L10 = L10.commit
  L12 = "parentalctl"
  L10(L11, L12)
  L10 = L4.syncDeviceInfo
  L11 = {}
  L11.mac = A0
  L10(L11)
  return L5
end
add_device_info = L11
function L11(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L5 = require
  L6 = "xiaoqiang.util.XQSynchrodata"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L7 = A0
  L6 = L6(L7)
  if L6 then
    L6 = false
    return L6
  end
  L6 = _UPVALUE1_
  L7 = L6
  L6 = L6.get_all
  L8 = "parentalctl"
  L9 = A0
  L6 = L6(L7, L8, L9)
  if not L6 then
    L7 = false
    return L7
  end
  if A2 then
    if A2 == 1 then
      L7 = 0
      if L7 then
        goto lbl_29
      end
    end
    L7 = 1
    ::lbl_29::
    L6.disabled = L7
  end
  if A3 then
    L7 = _parse_frequency
    L8 = A3
    L9 = A4 or L9
    if not A4 then
      L9 = L6.time_seg
    end
    L7, L8, L9 = L7(L8, L9)
    if L7 then
      L6.weekdays = L7
      L6.start_date = nil
      L6.stop_date = nil
      L10 = _UPVALUE1_
      L11 = L10
      L10 = L10.delete
      L12 = "parentalctl"
      L13 = A0
      L14 = "start_date"
      L10(L11, L12, L13, L14)
      L10 = _UPVALUE1_
      L11 = L10
      L10 = L10.delete
      L12 = "parentalctl"
      L13 = A0
      L14 = "stop_date"
      L10(L11, L12, L13, L14)
    end
    if L8 then
      L6.start_date = L8
    end
    if L9 then
      L6.stop_date = L9
    end
    if L8 or L9 then
      L6.weekdays = nil
      L10 = _UPVALUE1_
      L11 = L10
      L10 = L10.delete
      L12 = "parentalctl"
      L13 = A0
      L14 = "weekdays"
      L10(L11, L12, L13, L14)
    end
  elseif A2 and A2 == 1 then
    L7 = L6.start_date
    if L7 then
      L7 = L6.stop_date
      if L7 then
        L7 = _parse_frequency
        L8 = {}
        L9 = 0
        L8[1] = L9
        L9 = A4 or L9
        if not A4 then
          L9 = L6.time_seg
        end
        L7, L8, L9 = L7(L8, L9)
        if L8 then
          L6.start_date = L8
        end
        if L9 then
          L6.stop_date = L9
        end
      end
    end
  end
  if A4 then
    L8 = A4
    L7 = A4.match
    L9 = "[%d:]+%-[%d:]+"
    L7 = L7(L8, L9)
    if L7 then
      L6.time_seg = A4
    end
  end
  L7 = _UPVALUE1_
  L8 = L7
  L7 = L7.section
  L9 = "parentalctl"
  L10 = "device"
  L11 = A0
  L12 = L6
  L7(L8, L9, L10, L11, L12)
  L7 = _UPVALUE1_
  L8 = L7
  L7 = L7.commit
  L9 = "parentalctl"
  L7(L8, L9)
  L7 = L5.syncDeviceInfo
  L8 = {}
  L8.mac = A1
  L7(L8)
  L7 = true
  return L7
end
update_device_info = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "xiaoqiang.util.XQSynchrodata"
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.get_all
  L4 = "parentalctl"
  L5 = A0
  L2 = L2(L3, L4, L5)
  L3 = nil
  if L2 then
    L3 = L2.mac
  end
  L4 = _UPVALUE1_
  L5 = L4
  L4 = L4.delete
  L6 = "parentalctl"
  L7 = A0
  L4(L5, L6, L7)
  L4 = _UPVALUE1_
  L5 = L4
  L4 = L4.commit
  L6 = "parentalctl"
  L4(L5, L6)
  L4 = L1.syncDeviceInfo
  L5 = {}
  L5.mac = L3
  L4(L5)
  L4 = true
  return L4
end
delete_device_info = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  L5 = "device"
  function L6(A0)
    local L1, L2, L3
    L1 = A0.mac
    if L1 then
      L1 = A0[".name"]
      L2 = L1
      L1 = L1.match
      L3 = "_"
      L1 = L1(L2, L3)
      if L1 then
        L1 = _UPVALUE0_
        if L1 then
          L1 = _UPVALUE0_
          if not L1 then
            goto lbl_57
          end
          L1 = _UPVALUE0_
          L2 = A0.mac
          L1 = L1[L2]
          if not L1 then
            goto lbl_57
          end
        end
        L1 = _UPVALUE1_
        L2 = A0.mac
        L1 = L1[L2]
        if L1 then
          L2 = L1.total
          L2 = L2 + 1
          L1.total = L2
          L2 = A0.disabled
          if L2 then
            L2 = tonumber
            L3 = A0.disabled
            L2 = L2(L3)
            if L2 == 0 then
              L2 = L1.enabled
              L2 = L2 + 1
              L1.enabled = L2
            end
          end
        else
          L2 = {}
          L2.total = 1
          L2.enabled = 0
          L1 = L2
          L2 = A0.disabled
          if L2 then
            L2 = tonumber
            L3 = A0.disabled
            L2 = L2(L3)
            if L2 == 0 then
              L1.enabled = 1
            end
          end
        end
        L2 = _UPVALUE1_
        L3 = A0.mac
        L2[L3] = L1
      end
    end
    ::lbl_57::
  end
  L2(L3, L4, L5, L6)
  if A0 then
    for L5, L6 in L2, L3, L4 do
      L7 = L1[L5]
      if not L7 then
        L7 = {}
        L7.total = 0
        L7.enabled = 0
        L1[L5] = L7
      end
    end
  end
  return L1
end
parentctl_rules = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = require
  L2 = "xiaoqiang.module.XQFirewall"
  L1 = L1(L2)
  L2 = {}
  L3 = L1.getMacfilterInfoDict
  L3 = L3()
  if A0 then
    if L4 == "table" then
      for L7, L8 in L4, L5, L6 do
        L9 = true
        L10 = L3[L7]
        if L10 then
          L10 = L3[L7]
          L9 = L10.wan
        end
        L10 = {}
        L12 = L7
        L11 = L7.gsub
        L13 = ":"
        L14 = ""
        L11 = L11(L12, L13, L14)
        L12 = _UPVALUE0_
        L13 = L12
        L12 = L12.get_all
        L14 = "parentalctl"
        L15 = L11
        L12 = L12(L13, L14, L15)
        if L12 then
          L13 = tonumber
          L14 = L12.mark
          L13 = L13(L14)
          if L13 then
            L13 = tonumber
            L14 = L12.mark
            L13 = L13(L14)
            if L13 == 1 then
              L13 = tonumber
              L14 = L12.disabled
              L13 = L13(L14)
              if L13 == 0 then
                L13 = 1
                if L13 then
                  goto lbl_55
                end
              end
              L13 = 0
              ::lbl_55::
              L10.enable = L13
              L13 = L12.mode
              L13 = L13 or L13
              L10.mode = L13
              if not L9 then
                L10.mode = "limited"
                L10.enable = 1
              end
          end
        end
        else
          L10.enable = 1
          if L9 then
            L10.mode = "none"
          else
            L10.mode = "limited"
          end
          L13 = {}
          L13.disabled = "0"
          L14 = L10.mode
          L13.mode = L14
          L13.mac = L7
          L14 = parentctl_rules
          L15 = {}
          L15[L7] = 1
          L14 = L14(L15)
          if L14 then
            L15 = L14[L7]
            if L15 then
              L15 = L14[L7]
              L15 = L15.enabled
              if 0 < L15 then
                L10.mode = "time"
              end
            end
          end
        end
        L2[L7] = L10
      end
    end
  end
  return L2
end
netacctl_status = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = _UPVALUE1_
  L1 = L1.access
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = nil
    return L1
  end
  L1 = io
  L1 = L1.open
  L2 = A0
  L1 = L1(L2, L3)
  L2 = {}
  if L1 then
    for L6 in L3, L4, L5 do
      L7 = _UPVALUE0_
      L7 = L7.isStrNil
      L8 = L6
      L7 = L7(L8)
      if not L7 then
        L8 = L6
        L7 = L6.match
        L9 = "(%S+)%s%S+"
        L7 = L7(L8, L9)
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
get_url_info = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L2 = L2(L3)
  if L2 then
    L2 = false
    return L2
  end
  if A1 then
    L2 = type
    L2 = L2(L3)
    if L2 == "table" then
      L2 = io
      L2 = L2.open
      L2 = L2(L3, L4)
      for L6, L7 in L3, L4, L5 do
        L8 = _UPVALUE0_
        L8 = L8.isStrNil
        L9 = L7
        L8 = L8(L9)
        if not L8 then
          L9 = L7
          L8 = L7.gsub
          L10 = "http://"
          L11 = ""
          L8 = L8(L9, L10, L11)
          L10 = L8
          L9 = L8.gsub
          L11 = "^www."
          L12 = ""
          L9 = L9(L10, L11, L12)
          L8 = L9
          L9 = _UPVALUE1_
          L9 = L9.ipaddr
          L10 = L8
          L9 = L9(L10)
          if not L9 then
            L10 = L8
            L9 = L8.match
            L11 = "^%."
            L9 = L9(L10, L11)
            if not L9 then
              L9 = "."
              L10 = L8
              L8 = L9 .. L10
            end
          end
          L10 = L2
          L9 = L2.write
          L11 = L7
          L12 = " "
          L13 = L8
          L14 = "\n"
          L11 = L11 .. L12 .. L13 .. L14
          L9(L10, L11)
        end
      end
      L3(L4)
    end
  end
  L2 = true
  return L2
end
set_url_info = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE1_
    L1 = L1.macaddr
    L2 = A0
    L1 = L1(L2)
    if L1 then
      goto lbl_16
    end
  end
  L1 = nil
  do return L1 end
  goto lbl_21
  ::lbl_16::
  L1 = _UPVALUE0_
  L1 = L1.macFormat
  L2 = A0
  L1 = L1(L2)
  A0 = L1
  ::lbl_21::
  L1 = {}
  L1.mode = "none"
  L1.count = 0
  L3 = A0
  L2 = A0.gsub
  L4 = ":"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L3 = "_RULE"
  L2 = L2 .. L3
  L3 = _UPVALUE2_
  L4 = L3
  L3 = L3.get_all
  L5 = "parentalctl"
  L6 = L2
  L3 = L3(L4, L5, L6)
  if L3 then
    L4 = L3.mode
    L4 = L4 or L4
    L1.mode = L4
    L4 = tonumber
    L5 = L3.disabled
    L4 = L4(L5)
    if L4 == 0 then
      L4 = L3.hostfile
      if L4 then
        L5 = type
        L6 = L4
        L5 = L5(L6)
        if L5 == "table" then
          L5 = #L4
          if 0 < L5 then
            L5 = L4[1]
            L6 = get_url_info
            L7 = L5
            L6 = L6(L7)
            L6 = L6 or L6
            L7 = #L6
            L1.count = L7
            L1.urls = L6
          end
        end
      end
    end
  end
  return L1
end
get_parentctl_url_filter = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if A1 == "white" then
    L3 = "/etc/parentalctl/"
    L5 = A0
    L4 = A0.gsub
    L6 = ":"
    L7 = ""
    L4 = L4(L5, L6, L7)
    L5 = "_WHITE.url"
    L2 = L3 .. L4 .. L5
  elseif A1 == "black" then
    L3 = "/etc/parentalctl/"
    L5 = A0
    L4 = A0.gsub
    L6 = ":"
    L7 = ""
    L4 = L4(L5, L6, L7)
    L5 = "_BLACK.url"
    L2 = L3 .. L4 .. L5
  end
  if L2 then
    L3 = get_url_info
    L4 = L2
    L3 = L3(L4)
    L3 = L3 or L3
    return L3
  end
  L3 = {}
  return L3
end
get_parentctl_url_list = L11
function L11(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L3 = require
  L4 = "xiaoqiang.util.XQSynchrodata"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = A0
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE1_
    L4 = L4.macaddr
    L5 = A0
    L4 = L4(L5)
    if L4 then
      L4 = _UPVALUE0_
      L4 = L4.isStrNil
      L5 = A1
      L4 = L4(L5)
      if not L4 then
        goto lbl_25
      end
    end
  end
  L4 = nil
  do return L4 end
  goto lbl_30
  ::lbl_25::
  L4 = _UPVALUE0_
  L4 = L4.macFormat
  L5 = A0
  L4 = L4(L5)
  A0 = L4
  ::lbl_30::
  L5 = A0
  L4 = A0.gsub
  L6 = ":"
  L7 = ""
  L4 = L4(L5, L6, L7)
  L5 = "_RULE"
  L4 = L4 .. L5
  L5 = _UPVALUE2_
  L6 = L5
  L5 = L5.get_all
  L7 = "parentalctl"
  L8 = L4
  L5 = L5(L6, L7, L8)
  if not L5 then
    L6 = {}
    L5 = L6
  end
  L5.mac = A0
  L6 = nil
  if A1 == "white" then
    L7 = "/etc/parentalctl/"
    L9 = A0
    L8 = A0.gsub
    L10 = ":"
    L11 = ""
    L8 = L8(L9, L10, L11)
    L9 = "_WHITE.url"
    L6 = L7 .. L8 .. L9
  elseif A1 == "black" then
    L7 = "/etc/parentalctl/"
    L9 = A0
    L8 = A0.gsub
    L10 = ":"
    L11 = ""
    L8 = L8(L9, L10, L11)
    L9 = "_BLACK.url"
    L6 = L7 .. L8 .. L9
  end
  if A1 ~= "none" then
    L7 = "0"
    if L7 then
      goto lbl_72
    end
  end
  L7 = "1"
  ::lbl_72::
  L5.disabled = L7
  if L6 then
    L7 = {}
    L8 = L6
    L7[1] = L8
    L5.hostfile = L7
  end
  if A2 then
    L5.name = A2
  end
  L5.mode = A1
  L7 = _UPVALUE2_
  L8 = L7
  L7 = L7.section
  L9 = "parentalctl"
  L10 = "rule"
  L11 = L4
  L12 = L5
  L7(L8, L9, L10, L11, L12)
  L7 = _UPVALUE2_
  L8 = L7
  L7 = L7.commit
  L9 = "parentalctl"
  L7(L8, L9)
  L7 = L3.syncDeviceInfo
  L8 = {}
  L8.mac = A0
  L7(L8)
end
set_parentctl_url_filter = L11
function L11()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQSynchrodata"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.foreach
  L3 = "parentalctl"
  L4 = "rule"
  function L5(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = next
    L2 = A0
    L1 = L1(L2)
    if L1 then
      L1 = A0.disabled
      if L1 ~= "1" then
        L1 = A0.mode
        if L1 ~= "none" then
          L1 = _UPVALUE0_
          L2 = L1
          L1 = L1.set
          L3 = "parentalctl"
          L4 = A0[".name"]
          L5 = "disabled"
          L6 = "1"
          L1(L2, L3, L4, L5, L6)
          L1 = _UPVALUE0_
          L2 = L1
          L1 = L1.set
          L3 = "parentalctl"
          L4 = A0[".name"]
          L5 = "mode"
          L6 = "none"
          L1(L2, L3, L4, L5, L6)
          L1 = _UPVALUE1_
          L1 = L1.syncDeviceInfo
          L2 = {}
          L3 = A0.mac
          L2.mac = L3
          L1(L2)
        end
      end
    end
  end
  L1(L2, L3, L4, L5)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.commit
  L3 = "parentalctl"
  L1(L2, L3)
end
disable_all_parentctl_url_filter = L11
function L11(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L5 = require
  L6 = "xiaoqiang.util.XQSynchrodata"
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L7 = A0
  L6 = L6(L7)
  if not L6 then
    L6 = _UPVALUE1_
    L6 = L6.macaddr
    L7 = A0
    L6 = L6(L7)
    if L6 and A1 and A2 and A3 then
      goto lbl_25
    end
  end
  L6 = false
  do return L6 end
  goto lbl_30
  ::lbl_25::
  L6 = _UPVALUE0_
  L6 = L6.macFormat
  L7 = A0
  L6 = L6(L7)
  A0 = L6
  ::lbl_30::
  if A2 == "none" then
    L6 = false
    return L6
  end
  L6 = "/etc/parentalctl/"
  L8 = A0
  L7 = A0.gsub
  L7 = L7(L8, L9, L10)
  L8 = "_BLACK.url"
  L6 = L6 .. L7 .. L8
  if A2 == "white" then
    L7 = "/etc/parentalctl/"
    L8 = A0.gsub
    L8 = L8(L9, L10, L11)
    L6 = L7 .. L8 .. L9
  end
  L7 = get_url_info
  L8 = L6
  L7 = L7(L8)
  if A3 then
    L8 = type
    L8 = L8(L9)
    if L8 == "table" then
      L8 = #A3
      if 1 < L8 and A1 == 1 then
        L8 = {}
        for L13, L14 in L10, L11, L12 do
          L15 = _UPVALUE0_
          L15 = L15.isStrNil
          L16 = L14
          L15 = L15(L16)
          if not L15 then
            L8[L14] = true
          end
        end
        if L7 then
          for L13 = L10, L11, L12 do
            L14 = L7[L13]
            L14 = L8[L14]
            if L14 then
              L14 = table
              L14 = L14.remove
              L15 = L7
              L16 = L13
              L14(L15, L16)
            end
          end
          L10(L11, L12)
          return L10
        end
      end
    end
  end
  if L7 then
    L8 = nil
    for L12, L13 in L9, L10, L11 do
      if L13 == A3 then
        L8 = L12
      end
    end
    if A1 == 0 then
      if not L8 then
        L9(L10, L11)
      end
    elseif A1 == 1 then
      if L8 then
        L9(L10, L11)
      end
    elseif A1 == 2 and A4 then
      if L8 then
        L7[L8] = A4
      else
        L9(L10, L11)
      end
    end
  else
    L8 = {}
    L7 = L8
    if A1 == 0 then
      L8 = {}
      L8[1] = L9
      L7 = L8
    end
    if A1 == 2 and A4 then
      L8 = {}
      L8[1] = L9
      L7 = L8
    end
  end
  L8 = set_url_info
  L8(L9, L10)
  L8 = L5.syncDeviceInfo
  L9.mac = A0
  L8(L9)
  L8 = true
  return L8
end
edit_parentctl_url_list = L11
function L11(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = 0
    return L1
  end
  L1 = _UPVALUE1_
  L1 = L1.access
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = 0
    return L1
  end
  L1 = "wc -l \""
  L2 = _UPVALUE0_
  L2 = L2._cmdformat
  L3 = A0
  L2 = L2(L3)
  L3 = "\" | awk '{print $1}'"
  L1 = L1 .. L2 .. L3
  L2 = tonumber
  L3 = _UPVALUE2_
  L3 = L3.trim
  L4 = _UPVALUE2_
  L4 = L4.exec
  L5 = L1
  L4, L5 = L4(L5)
  L3, L4, L5 = L3(L4, L5)
  return L2(L3, L4, L5)
end
_get_file_line_count = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = {}
  L2 = {}
  if A0 then
    if L3 == "table" then
      L6 = "rule"
      function L7(A0)
        local L1, L2, L3, L4, L5, L6, L7
        L1 = A0.mac
        if L1 then
          L1 = A0.mode
          L2 = A0.hostfile
          if L2 then
            L3 = type
            L4 = L2
            L3 = L3(L4)
            if L3 == "table" then
              L3 = #L2
              if L3 == 1 then
                L2 = L2[1]
            end
          end
          else
            L2 = nil
          end
          L3 = A0.disabled
          if L3 then
            L3 = tonumber
            L4 = A0.disabled
            L3 = L3(L4)
            if L3 == 1 then
              L1 = "none"
            end
          end
          L3 = _UPVALUE0_
          L4 = A0.mac
          L5 = {}
          L6 = _get_file_line_count
          L7 = L2
          L6 = L6(L7)
          L5.count = L6
          L5.mode = L1
          L3[L4] = L5
        end
      end
      L3(L4, L5, L6, L7)
      for L6, L7 in L3, L4, L5 do
        L8 = L2[L6]
        if not L8 then
          L8 = {}
          L8.count = 0
          L8.mode = "none"
        end
        L1[L6] = L8
      end
    end
  end
  return L1
end
get_urlfilter_info = L11
