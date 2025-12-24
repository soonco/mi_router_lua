local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27
L0 = module
L1 = "xiaoqiang.util.XQLEDControlUtil"
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
L2 = require
L3 = "xiaoqiang.common.XQFunction"
L2 = L2(L3)
L3 = {}
L3["1"] = "led_on"
L3["0"] = "led_off"
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  A0 = A0 / 60
  A1 = A1 / 100
  A2 = A2 / 100
  L3, L4, L5 = nil, nil, nil
  if A1 == 0 then
    L6 = A2
    L7 = A2
    L5 = A2
    L4 = L7
    L3 = L6
  else
    function L6(A0, A1, A2)
      local L3, L4
      if A2 < 0 then
        A2 = A2 + 6
      end
      if 6 <= A2 then
        A2 = A2 - 6
      end
      if A2 < 1 then
        L3 = A1 - A0
        L3 = L3 * A2
        L3 = L3 + A0
        return L3
      elseif A2 < 3 then
        return A1
      elseif A2 < 4 then
        L3 = A1 - A0
        L4 = 4 - A2
        L3 = L3 * L4
        L3 = L3 + A0
        return L3
      else
        return A0
      end
    end
    L7 = nil
    if A2 < 0.5 then
      L8 = 1 + A1
      L7 = A2 * L8
    else
      L8 = A2 + A1
      L9 = A2 * A1
      L7 = L8 - L9
    end
    L8 = 2 * A2
    L8 = L8 - L7
    L9 = L6
    L10 = L8
    L11 = L7
    L12 = A0 + 2
    L9 = L9(L10, L11, L12)
    L3 = L9
    L9 = L6
    L10 = L8
    L11 = L7
    L12 = A0
    L9 = L9(L10, L11, L12)
    L4 = L9
    L9 = L6
    L10 = L8
    L11 = L7
    L12 = A0 - 2
    L9 = L9(L10, L11, L12)
    L5 = L9
  end
  L6 = {}
  L7 = math
  L7 = L7.floor
  L8 = L3 * 255
  L7 = L7(L8)
  L6.r = L7
  L7 = math
  L7 = L7.floor
  L8 = L4 * 255
  L7 = L7(L8)
  L6.g = L7
  L7 = math
  L7 = L7.floor
  L8 = L5 * 255
  L7 = L7(L8)
  L6.b = L7
  return L6
end
function L5(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  A0 = A0 / 255
  A1 = A1 / 255
  A2 = A2 / 255
  L3 = math
  L3 = L3.max
  L4 = A0
  L5 = A1
  L6 = A2
  L3 = L3(L4, L5, L6)
  L4 = math
  L4 = L4.min
  L5 = A0
  L6 = A1
  L7 = A2
  L4 = L4(L5, L6, L7)
  L5 = 0
  L6 = 0
  L7 = L3 + L4
  L7 = L7 / 2
  L8 = L3 - L4
  if L3 == L4 then
    L5 = 0
  else
    if 0.5 < L7 then
      L9 = 2 - L3
      L9 = L9 - L4
      L6 = L8 / L9
    else
      L9 = L3 + L4
      L6 = L8 / L9
    end
    if L3 == A0 then
      L9 = A1 - A2
      L5 = L9 / L8
      if A1 < A2 then
        L5 = L5 + 6
      end
    elseif L3 == A1 then
      L9 = A2 - A0
      L9 = L9 / L8
      L5 = L9 + 2
    elseif L3 == A2 then
      L9 = A0 - A1
      L9 = L9 / L8
      L5 = L9 + 4
    end
    L5 = L5 / 6
  end
  L9 = {}
  L10 = L5 * 360
  L9.h = L10
  L10 = L6 * 100
  L9.s = L10
  L10 = L7 * 100
  L9.l = L10
  return L9
end
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "bit"
  L1 = L1(L2)
  L2, L3, L4 = nil, nil, nil
  L5 = tonumber
  L6 = A0
  L5 = L5(L6)
  if L5 then
    L6 = L1.band
    L7 = L1.rshift
    L8 = L5
    L9 = 24
    L7 = L7(L8, L9)
    L8 = 255
    L6 = L6(L7, L8)
    L2 = L6
    L6 = L1.band
    L7 = L1.rshift
    L8 = L5
    L9 = 16
    L7 = L7(L8, L9)
    L8 = 255
    L6 = L6(L7, L8)
    L3 = L6
    L6 = L1.band
    L7 = L1.rshift
    L8 = L5
    L9 = 8
    L7 = L7(L8, L9)
    L8 = 255
    L6 = L6(L7, L8)
    L4 = L6
    L6 = {}
    L6.r = L2
    L6.g = L3
    L6.b = L4
    return L6
  else
    L6 = nil
    return L6
  end
end
function L7(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = require
  L4 = "bit"
  L3 = L3(L4)
  L4 = 0
  L5 = L3.bor
  L6 = L4
  L7 = L3.lshift
  L8 = A0
  L9 = 24
  L7, L8, L9 = L7(L8, L9)
  L5 = L5(L6, L7, L8, L9)
  L4 = L5
  L5 = L3.bor
  L6 = L4
  L7 = L3.lshift
  L8 = A1
  L9 = 16
  L7, L8, L9 = L7(L8, L9)
  L5 = L5(L6, L7, L8, L9)
  L4 = L5
  L5 = L3.bor
  L6 = L4
  L7 = L3.lshift
  L8 = A2
  L9 = 8
  L7, L8, L9 = L7(L8, L9)
  L5 = L5(L6, L7, L8, L9)
  L4 = L5
  L5 = _UPVALUE0_
  L5 = L5.log
  L6 = 5
  L7 = "rgb2dec: "
  L8 = L4
  L7 = L7 .. L8
  L5(L6, L7)
  return L4
end
function L8(A0)
  local L1
end
function L9()
  local L0, L1
end
function L10(A0)
  local L1
end
L11 = {}
function L12()
  local L0, L1
end
L11.get_config = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = A0.val1
  if L1 ~= "-1" then
    L1 = A0.val2
    if L1 ~= "-1" then
      L1 = A0.val3
      if L1 ~= "-1" then
        L1 = {}
        L2 = tonumber
        L3 = A0.val1
        L2 = L2(L3)
        L2 = L2 * 3.6
        L1.h = L2
        L2 = tonumber
        L3 = A0.val2
        L2 = L2(L3)
        L1.s = L2
        L2 = tonumber
        L3 = A0.val3
        L2 = L2(L3)
        L1.l = L2
        L2 = L1.h
        if not (L2 < 0) then
          L2 = L1.h
          if not (360 < L2) then
            L2 = L1.s
            if not (L2 < 0) then
              L2 = L1.s
              if not (100 < L2) then
                L2 = L1.l
                if not (L2 < 0) then
                  L2 = L1.l
                  if not (100 < L2) then
                    goto lbl_44
                  end
                end
              end
            end
          end
        end
        L2 = false
        do return L2 end
        ::lbl_44::
        L2 = _UPVALUE0_
        L3 = L1.h
        L4 = L1.s
        L5 = L1.l
        L2 = L2(L3, L4, L5)
        L3 = _UPVALUE1_
        L4 = L3
        L3 = L3.set
        L5 = "xqled"
        L6 = "custom_ambient_brightness"
        L7 = "value"
        L8 = _UPVALUE2_
        L9 = L2.r
        L10 = L2.g
        L11 = L2.b
        L8, L9, L10, L11 = L8(L9, L10, L11)
        L3(L4, L5, L6, L7, L8, L9, L10, L11)
        L3 = _UPVALUE1_
        L4 = L3
        L3 = L3.commit
        L5 = "xqled"
        L3(L4, L5)
        L3 = _UPVALUE3_
        L3 = L3.forkExec
        L4 = "xqled update user_defined"
        L3(L4)
        L3 = true
        return L3
    end
  end
  else
    L1 = false
    return L1
  end
end
L11.set_hsl = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = A0.val1
  if L1 ~= "-1" then
    L1 = A0.val2
    if L1 ~= "-1" then
      L1 = A0.val3
      if L1 ~= "-1" then
        L1 = {}
        L2 = tonumber
        L3 = A0.val1
        L2 = L2(L3)
        L1.r = L2
        L2 = tonumber
        L3 = A0.val2
        L2 = L2(L3)
        L1.g = L2
        L2 = tonumber
        L3 = A0.val3
        L2 = L2(L3)
        L1.b = L2
        L2 = L1.r
        if not (L2 < 0) then
          L2 = L1.r
          if not (255 < L2) then
            L2 = L1.g
            if not (L2 < 0) then
              L2 = L1.g
              if not (255 < L2) then
                L2 = L1.b
                if not (L2 < 0) then
                  L2 = L1.b
                  if not (255 < L2) then
                    goto lbl_43
                  end
                end
              end
            end
          end
        end
        L2 = false
        do return L2 end
        ::lbl_43::
        L2 = _UPVALUE0_
        L3 = L2
        L2 = L2.set
        L4 = "xqled"
        L5 = "custom_ambient_brightness"
        L6 = "value"
        L7 = _UPVALUE1_
        L8 = L1.r
        L9 = L1.g
        L10 = L1.b
        L7, L8, L9, L10 = L7(L8, L9, L10)
        L2(L3, L4, L5, L6, L7, L8, L9, L10)
        L2 = _UPVALUE0_
        L3 = L2
        L2 = L2.commit
        L4 = "xqled"
        L2(L3, L4)
        L2 = _UPVALUE2_
        L2 = L2.forkExec
        L3 = "xqled update user_defined"
        L2(L3)
        L2 = true
        return L2
    end
  end
  else
    L1 = false
    return L1
  end
end
L11.set_rgb = L12
function L12(A0)
  local L1, L2
  L1 = os
  L1 = L1.execute
  L2 = "/usr/sbin/led_ctl led_on xled"
  L1(L2)
  L1 = true
  return L1
end
L11.on = L12
function L12(A0)
  local L1, L2
  L1 = os
  L1 = L1.execute
  L2 = "/usr/sbin/led_ctl led_off xled"
  L1(L2)
  L1 = true
  return L1
end
L11.off = L12
function L12(A0)
  local L1, L2
  L1 = os
  L1 = L1.execute
  L2 = "/usr/sbin/led_ctl event_toggle 1"
  L1(L2)
  L1 = true
  return L1
end
L11.event_on = L12
function L12(A0)
  local L1, L2
  L1 = os
  L1 = L1.execute
  L2 = "/usr/sbin/led_ctl event_toggle 0"
  L1(L2)
  L1 = true
  return L1
end
L11.event_off = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = A0.timer
  if L1 then
    L1 = A0.timer
    L1 = L1.status
    if L1 == "1" then
      L1 = os
      L1 = L1.execute
      L2 = "/usr/sbin/led_ctl timer_on "
      L3 = A0.timer
      L3 = L3.start_h
      L4 = " "
      L5 = A0.timer
      L5 = L5.start_m
      L6 = " "
      L7 = A0.timer
      L7 = L7.stop_h
      L8 = " "
      L9 = A0.timer
      L9 = L9.stop_m
      L10 = " xled"
      L2 = L2 .. L3 .. L4 .. L5 .. L6 .. L7 .. L8 .. L9 .. L10
      L1(L2)
    else
      L1 = os
      L1 = L1.execute
      L2 = "/usr/sbin/led_ctl timer_off xled"
      L1(L2)
    end
  end
  L1 = true
  return L1
end
L11.timer = L12
L12 = {}
L12.still_light = "ambient_rgb_light"
L12.breath = "ambient_rgb_breath"
L12.flashing = "ambient_rgb_star"
L12.cycle = "ambient_rgb_cycle"
L12.rainbow = "ambient_rgb_rainbow"
L13 = {}
L13.ambient_rgb_light = 0
L13.ambient_rgb_breath = 1
L13.ambient_rgb_star = 2
L13.ambient_rgb_cycle = 3
L13.ambient_rgb_rainbow = 4
function L14(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = {}
  L2 = {}
  L3 = A0.formvalue
  L4 = "func"
  L3 = L3(L4)
  L1.func = L3
  L3 = A0.formvalue
  L4 = "val1"
  L3 = L3(L4)
  L1.val1 = L3
  L3 = A0.formvalue
  L4 = "val2"
  L3 = L3(L4)
  L1.val2 = L3
  L3 = A0.formvalue
  L4 = "val3"
  L3 = L3(L4)
  L1.val3 = L3
  L3 = A0.formvalue
  L4 = "timer_on"
  L3 = L3(L4)
  L2.status = L3
  L3 = A0.formvalue
  L4 = "timer_open"
  L3 = L3(L4)
  L2.start_time = L3
  L3 = A0.formvalue
  L4 = "timer_close"
  L3 = L3(L4)
  L2.stop_time = L3
  L3 = next
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L1.timer = L2
  end
  L3 = _UPVALUE0_
  L3 = L3.log
  L4 = 5
  L5 = "[XLED] analyzeXLEDConfig: "
  L6 = L1
  L3(L4, L5, L6)
  L3 = _UPVALUE1_
  L4 = L1.func
  L3 = L3[L4]
  if not L3 then
    L3 = _UPVALUE2_
    L4 = L1.func
    L3 = L3[L4]
    if not L3 then
      L3 = nil
      return L3
    end
  end
  L3 = L2.status
  if L3 then
    L3 = L2.status
    if L3 == "1" then
      L3 = L2.start_time
      if L3 then
        L3 = L2.stop_time
        if L3 then
          goto lbl_75
        end
      end
      L3 = _UPVALUE0_
      L3 = L3.log
      L4 = 1
      L5 = "analyzeXLEDConfig: need timer_open and timer_close"
      L3(L4, L5)
      L3 = nil
      do return L3 end
      goto lbl_108
      ::lbl_75::
      L3 = string
      L3 = L3.match
      L4 = L2.start_time
      L5 = "^([0-2][0-9]):([0-5][0-9])$"
      L3, L4 = L3(L4, L5)
      L2.start_m = L4
      L2.start_h = L3
      L3 = string
      L3 = L3.match
      L4 = L2.stop_time
      L5 = "^([0-2][0-9]):([0-5][0-9])$"
      L3, L4 = L3(L4, L5)
      L2.stop_m = L4
      L2.stop_h = L3
      L3 = L2.start_h
      if L3 then
        L3 = L2.start_m
        if L3 then
          L3 = L2.stop_h
          if L3 then
            L3 = L2.stop_m
            if L3 then
              goto lbl_108
            end
          end
        end
      end
      L3 = _UPVALUE0_
      L3 = L3.log
      L4 = 1
      L5 = "analyzeXLEDConfig: timer_open or timer_close format error"
      L3(L4, L5)
      L3 = nil
      return L3
    end
  end
  ::lbl_108::
  L3 = next
  L4 = L1
  L3 = L3(L4)
  if L3 then
    return L1
  else
    L3 = nil
    return L3
  end
end
function L15()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "xqled"
  L4 = "custom_ambient_brightness"
  L5 = "value"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = _UPVALUE1_
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L3 = L2.r
    L0.color_R = L3
    L3 = L2.g
    L0.color_G = L3
    L3 = L2.b
    L0.color_B = L3
  else
    L3 = nil
    return L3
  end
  L3 = _UPVALUE2_
  L4 = L2.r
  L5 = L2.g
  L6 = L2.b
  L3 = L3(L4, L5, L6)
  if L3 then
    L4 = L3.h
    L4 = L4 / 3.6
    L0.color_H = L4
    L4 = L3.s
    L0.color_S = L4
    L4 = L3.l
    L0.color_L = L4
  else
    L4 = nil
    return L4
  end
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = "xqled"
  L7 = "custom_ambient_action"
  L8 = "value"
  L4 = L4(L5, L6, L7, L8)
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.get
  L7 = "xiaoqiang"
  L8 = "common"
  L9 = "XLED"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  if L5 == "0" then
    L0.status = 5
  else
    L6 = _UPVALUE3_
    L6 = L6[L4]
    L0.status = L6
  end
  L6 = L0.status
  if not L6 then
    L6 = nil
    return L6
  end
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = "xqled"
  L9 = "handle_event"
  L10 = "value"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L0.event_enable = L6
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = "xiaoqiang"
  L9 = "common"
  L10 = "XLED_TIMER"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L0.xled_timer_enable = L6
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = "xiaoqiang"
  L9 = "common"
  L10 = "XLED_TIMER_OPEN"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L0.xled_timer_open = L6
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = "xiaoqiang"
  L9 = "common"
  L10 = "XLED_TIMER_CLOSE"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L0.xled_timer_close = L6
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = "xqled"
  L9 = "default_color"
  L10 = "value"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L0.default_color = L6
  L6 = _UPVALUE4_
  L6 = L6.log
  L7 = 5
  L8 = "[XLED] getXLEDConfig: "
  L9 = L0
  L6(L7, L8, L9)
  return L0
end
function L16(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  if not A0 then
    L1 = false
    return L1
  end
  L1 = true
  L2 = _UPVALUE0_
  L3 = A0.func
  L2 = L2[L3]
  if L2 then
    L2 = _UPVALUE0_
    L3 = A0.func
    L2 = L2[L3]
    L3 = A0
    L2 = L2(L3)
    L1 = L2
  else
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.set
    L4 = "xqled"
    L5 = "custom_ambient_action"
    L6 = "value"
    L7 = _UPVALUE2_
    L8 = A0.func
    L7 = L7[L8]
    L2(L3, L4, L5, L6, L7)
    L2 = A0.val1
    if L2 ~= "-1" then
      L2 = A0.val2
      if L2 ~= "-1" then
        L2 = A0.val3
        if L2 ~= "-1" then
          L2 = _UPVALUE1_
          L3 = L2
          L2 = L2.set
          L4 = "xqled"
          L5 = "custom_ambient_brightness"
          L6 = "value"
          L7 = _UPVALUE3_
          L8 = A0.val1
          L9 = A0.val2
          L10 = A0.val3
          L7, L8, L9, L10 = L7(L8, L9, L10)
          L2(L3, L4, L5, L6, L7, L8, L9, L10)
        end
      end
    end
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.commit
    L4 = "xqled"
    L2(L3, L4)
    L2 = _UPVALUE4_
    L2 = L2.forkExec
    L3 = "xqled update user_defined"
    L2(L3)
  end
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.set
  L4 = "miled"
  L5 = "settings"
  L6 = "action"
  L7 = A0.func
  L2(L3, L4, L5, L6, L7)
  L2 = _UPVALUE1_
  L3 = L2
  L2 = L2.commit
  L4 = "miled"
  L2(L3, L4)
  L2 = _UPVALUE4_
  L2 = L2.forkExec
  L3 = "miled_ctrl.lua generate"
  L2(L3)
  return L1
end
function L17(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = {}
  L2 = {}
  L3 = A0.formvalue
  L4 = "on"
  L3 = L3(L4)
  L1.status = L3
  L3 = A0.formvalue
  L4 = "timer_on"
  L3 = L3(L4)
  L2.status = L3
  L3 = A0.formvalue
  L4 = "timer_open"
  L3 = L3(L4)
  L2.start_time = L3
  L3 = A0.formvalue
  L4 = "timer_close"
  L3 = L3(L4)
  L2.stop_time = L3
  L3 = next
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L1.timer = L2
  end
  L3 = _UPVALUE0_
  L3 = L3.log
  L4 = 5
  L5 = "analyzeEthLEDConfig: "
  L6 = L1
  L3(L4, L5, L6)
  L3 = L2.status
  if L3 then
    L3 = L2.status
    if L3 == "1" then
      L3 = L2.start_time
      if L3 then
        L3 = L2.stop_time
        if L3 then
          goto lbl_51
        end
      end
      L3 = _UPVALUE0_
      L3 = L3.log
      L4 = 1
      L5 = "analyzeEthLEDConfig: need timer_open and timer_close"
      L3(L4, L5)
      L3 = nil
      do return L3 end
      goto lbl_84
      ::lbl_51::
      L3 = string
      L3 = L3.match
      L4 = L2.start_time
      L5 = "^([0-2][0-9]):([0-5][0-9])$"
      L3, L4 = L3(L4, L5)
      L2.start_m = L4
      L2.start_h = L3
      L3 = string
      L3 = L3.match
      L4 = L2.stop_time
      L5 = "^([0-2][0-9]):([0-5][0-9])$"
      L3, L4 = L3(L4, L5)
      L2.stop_m = L4
      L2.stop_h = L3
      L3 = L2.start_h
      if L3 then
        L3 = L2.start_m
        if L3 then
          L3 = L2.stop_h
          if L3 then
            L3 = L2.stop_m
            if L3 then
              goto lbl_84
            end
          end
        end
      end
      L3 = _UPVALUE0_
      L3 = L3.log
      L4 = 1
      L5 = "analyzeEthLEDConfig: timer_open or timer_close format error"
      L3(L4, L5)
      L3 = nil
      return L3
    end
  end
  ::lbl_84::
  return L1
end
function L18()
  local L0, L1, L2, L3, L4, L5
  L0 = {}
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "xiaoqiang"
  L4 = "common"
  L5 = "ETHLED"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L0.status = L1
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "xiaoqiang"
  L4 = "common"
  L5 = "ETHLED_TIMER"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L0.timer_status = L1
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "xiaoqiang"
  L4 = "common"
  L5 = "ETHLED_TIMER_OPEN"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L0.timer_open = L1
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "xiaoqiang"
  L4 = "common"
  L5 = "ETHLED_TIMER_CLOSE"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L0.timer_close = L1
  return L0
end
function L19(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  if nil == A0 then
    L1 = false
    return L1
  end
  L1 = next
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = true
    return L1
  end
  L1 = _UPVALUE0_
  L2 = A0.status
  L1 = L1[L2]
  if not L1 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE1_
  L1 = L1()
  L2 = A0.status
  L3 = L1.status
  if L2 ~= L3 then
    L2 = _UPVALUE2_
    L2 = L2.forkExec
    L3 = "/usr/sbin/led_ctl "
    L4 = _UPVALUE0_
    L5 = A0.status
    L4 = L4[L5]
    L5 = " ethled"
    L3 = L3 .. L4 .. L5
    L2(L3)
  end
  L2 = A0.timer
  if L2 then
    L2 = A0.timer
    L2 = L2.status
    if L2 == "1" then
      L2 = _UPVALUE2_
      L2 = L2.forkExec
      L3 = "/usr/sbin/led_ctl timer_on "
      L4 = A0.timer
      L4 = L4.start_h
      L5 = " "
      L6 = A0.timer
      L6 = L6.start_m
      L7 = " "
      L8 = A0.timer
      L8 = L8.stop_h
      L9 = " "
      L10 = A0.timer
      L10 = L10.stop_m
      L11 = " ethled"
      L3 = L3 .. L4 .. L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
      L2(L3)
    else
      L2 = _UPVALUE2_
      L2 = L2.forkExec
      L3 = "/usr/sbin/led_ctl timer_off ethled"
      L2(L3)
    end
  end
  L2 = true
  return L2
end
function L20(A0)
  local L1, L2, L3, L4, L5
  L1 = {}
  L2 = A0.formvalue
  L3 = "on"
  L2 = L2(L3)
  L1.status = L2
  L2 = _UPVALUE0_
  L2 = L2.log
  L3 = 5
  L4 = "analyzeAllLEDConfig: "
  L5 = L1
  L2(L3, L4, L5)
  return L1
end
function L21()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "xiaoqiang.XQFeatures"
  L0 = L0(L1)
  L0 = L0.FEATURES
  L1 = {}
  L2 = 0
  L3 = L0.apps
  if L3 then
    L3 = L0.apps
    L3 = L3.LED_control
    if L3 then
      L3 = require
      L4 = "bit"
      L3 = L3(L4)
      L3 = L3.band
      L4 = L0.apps
      L4 = L4.LED_control
      L5 = 1
      L3 = L3(L4, L5)
      if L3 ~= 0 then
        L3 = tonumber
        L4 = _UPVALUE0_
        L5 = L4
        L4 = L4.get
        L6 = "xiaoqiang"
        L7 = "common"
        L8 = "BLUE_LED"
        L4 = L4(L5, L6, L7, L8)
        L4 = L4 or L4
        L3 = L3(L4)
        L2 = L2 + L3
      end
    end
  end
  L3 = L0.apps
  if L3 then
    L3 = L0.apps
    L3 = L3.LED_control
    if L3 then
      L3 = require
      L4 = "bit"
      L3 = L3(L4)
      L3 = L3.band
      L4 = L0.apps
      L4 = L4.LED_control
      L5 = 2
      L3 = L3(L4, L5)
      if L3 ~= 0 then
        L3 = tonumber
        L4 = _UPVALUE0_
        L5 = L4
        L4 = L4.get
        L6 = "xiaoqiang"
        L7 = "common"
        L8 = "ETHLED"
        L4 = L4(L5, L6, L7, L8)
        L4 = L4 or L4
        L3 = L3(L4)
        L2 = L2 + L3
      end
    end
  end
  L3 = L0.apps
  if L3 then
    L3 = L0.apps
    L3 = L3.LED_control
    if L3 then
      L3 = require
      L4 = "bit"
      L3 = L3(L4)
      L3 = L3.band
      L4 = L0.apps
      L4 = L4.LED_control
      L5 = 4
      L3 = L3(L4, L5)
      if L3 ~= 0 then
        L3 = tonumber
        L4 = _UPVALUE0_
        L5 = L4
        L4 = L4.get
        L6 = "xiaoqiang"
        L7 = "common"
        L8 = "XLED"
        L4 = L4(L5, L6, L7, L8)
        L4 = L4 or L4
        L3 = L3(L4)
        L2 = L2 + L3
      end
    end
  end
  if L2 == 0 then
    L1.status = "0"
  else
    L1.status = "1"
  end
  L3 = _UPVALUE1_
  L3 = L3.log
  L4 = 5
  L5 = "getAllLEDConfig: "
  L6 = L1
  L3(L4, L5, L6)
  return L1
end
function L22(A0)
  local L1, L2, L3, L4
  if nil == A0 then
    L1 = false
    return L1
  end
  L1 = next
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = true
    return L1
  end
  L1 = _UPVALUE0_
  L2 = A0.status
  L1 = L1[L2]
  if nil == L1 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE1_
  L1 = L1.forkExec
  L2 = "/usr/sbin/led_ctl "
  L3 = _UPVALUE0_
  L4 = A0.status
  L3 = L3[L4]
  L2 = L2 .. L3
  L1(L2)
  L1 = _UPVALUE1_
  L1 = L1.forkExec
  L2 = "/usr/sbin/led_ctl "
  L3 = _UPVALUE0_
  L4 = A0.status
  L3 = L3[L4]
  L4 = " xled"
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = _UPVALUE1_
  L1 = L1.forkExec
  L2 = "/usr/sbin/led_ctl "
  L3 = _UPVALUE0_
  L4 = A0.status
  L3 = L3[L4]
  L4 = " ethled"
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = true
  return L1
end
L23 = {}
L23.analyzeConfig = L8
L23.getConfig = L9
L23.setConfig = L10
L24 = {}
L24.analyzeConfig = L14
L24.getConfig = L15
L24.setConfig = L16
L25 = {}
L25.analyzeConfig = L17
L25.getConfig = L18
L25.setConfig = L19
L26 = {}
L26.analyzeConfig = L20
L26.getConfig = L21
L26.setConfig = L22
L27 = {}
L27.led = L23
L27.xled = L24
L27.ethled = L25
L27.allled = L26
LEDControl = L27
