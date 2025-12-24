local L0, L1, L2
L0 = module
L1 = "xiaoqiang.common.XQFunction"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQConfigs"
L0 = L0(L1)
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7
  if A0 then
    L1 = _cmdformat
    L2 = string
    L2 = L2.sub
    L3 = string
    L3 = L3.upper
    L4 = string
    L4 = L4.gsub
    L5 = A0
    L6 = "-"
    L7 = ":"
    L4 = L4(L5, L6, L7)
    L3 = L3(L4)
    L4 = 1
    L5 = 17
    L2, L3, L4, L5, L6, L7 = L2(L3, L4, L5)
    L1 = L1(L2, L3, L4, L5, L6, L7)
    return L1
  else
    L1 = ""
    return L1
  end
end
macFormat = L1
function L1(A0)
  local L1
  L1 = A0 == nil or A0 == ""
  return L1
end
isStrNil = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = false
  if A0 then
    if L2 == "string" then
      for L5 = L2, L3, L4 do
        L6 = string
        L6 = L6.byte
        L7 = A0
        L8 = L5
        L6 = L6(L7, L8)
        if 127 < L6 then
          L1 = true
          break
        end
      end
    end
  end
  return L1
end
checkChineseChar = L1
function L1(A0)
  local L1, L2, L3
  if not A0 then
    L1 = false
    return L1
  end
  L2 = A0
  L1 = A0.match
  L3 = "^%w[%w%-%.]+%w$"
  L1 = L1(L2, L3)
  if L1 then
    L1 = true
    return L1
  end
  L1 = false
  return L1
end
isDomain = L1
function L1(A0)
  local L1, L2, L3, L4
  if A0 ~= nil then
    L2 = A0
    L1 = A0.gsub
    L3 = "\r\n"
    L4 = "<br>"
    L1 = L1(L2, L3, L4)
    A0 = L1
    L2 = A0
    L1 = A0.gsub
    L3 = "\r"
    L4 = "<br>"
    L1 = L1(L2, L3, L4)
    A0 = L1
    L2 = A0
    L1 = A0.gsub
    L3 = "\n"
    L4 = "<br>"
    L1 = L1(L2, L3, L4)
    A0 = L1
  end
  return A0
end
parseEnter2br = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "nixio"
  L1 = L1(L2)
  L2 = L1.fork
  L2 = L2()
  if 0 < L2 then
    return
  elseif L2 == 0 then
    L3 = L1.chdir
    L4 = "/"
    L3(L4)
    L3 = L1.open
    L4 = "/dev/null"
    L5 = "w+"
    L3 = L3(L4, L5)
    if L3 then
      L4 = L1.dup
      L5 = L3
      L6 = L1.stderr
      L4(L5, L6)
      L4 = L1.dup
      L5 = L3
      L6 = L1.stdout
      L4(L5, L6)
      L4 = L1.dup
      L5 = L3
      L6 = L1.stdin
      L4(L5, L6)
      L5 = L3
      L4 = L3.fileno
      L4 = L4(L5)
      if 2 < L4 then
        L5 = L3
        L4 = L3.close
        L4(L5)
      end
    end
    L4 = L1.exec
    L5 = "/bin/sh"
    L6 = "-c"
    L7 = A0
    L4(L5, L6, L7)
  end
end
forkExec = L1
function L1(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "nixio"
  L2 = L2(L3)
  L3 = L2.fork
  L3 = L3()
  if 0 < L3 then
    return L3
  elseif L3 == 0 then
    L4 = L2.chdir
    L5 = "/"
    L4(L5)
    L4 = L2.open
    L5 = "/dev/null"
    L6 = "w+"
    L4 = L4(L5, L6)
    if L4 then
      L5 = L2.dup
      L6 = L4
      L7 = L2.stderr
      L5(L6, L7)
      L5 = L2.dup
      L6 = L4
      L7 = L2.stdout
      L5(L6, L7)
      L5 = L2.dup
      L6 = L4
      L7 = L2.stdin
      L5(L6, L7)
      L6 = L4
      L5 = L4.fileno
      L5 = L5(L6)
      if 2 < L5 then
        L6 = L4
        L5 = L4.close
        L5(L6)
      end
    end
    L5 = L2.execp
    L6 = A0
    L7 = unpack
    L8 = arg
    L7, L8 = L7(L8)
    L5(L6, L7, L8)
  end
end
forkExec2 = L1
function L1(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = require
  L3 = "nixio"
  L2 = L2(L3)
  L3 = assert
  L4 = L2.pipe
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13 = L4()
  L3, L4 = L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13)
  L5 = assert
  L6 = L2.fork
  L6, L7, L8, L9, L10, L11, L12, L13 = L6()
  L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13)
  if L5 == 0 then
    L6 = L2.dup
    L7 = L4
    L8 = L2.stdout
    L6(L7, L8)
    L7 = L3
    L6 = L3.close
    L6(L7)
    L7 = L4
    L6 = L4.close
    L6(L7)
    L6 = L2.open
    L7 = "/dev/null"
    L8 = "w+"
    L6 = L6(L7, L8)
    if L6 then
      L7 = L2.dup
      L8 = L6
      L9 = L2.stdin
      L7(L8, L9)
      L7 = L2.dup
      L8 = L6
      L9 = L2.stderr
      L7(L8, L9)
      L8 = L6
      L7 = L6.close
      L7(L8)
    end
    L7 = L2.chdir
    L8 = "/"
    L7(L8)
    L7 = L2.execp
    L8 = A0
    L9 = unpack
    L10 = arg
    L9, L10, L11, L12, L13 = L9(L10)
    L7(L8, L9, L10, L11, L12, L13)
    L7 = os
    L7 = L7.exit
    L8 = -1
    L7(L8)
  end
  L7 = L4
  L6 = L4.close
  L6(L7)
  L6 = L2.waitpid
  L7 = L5
  L6, L7, L8 = L6(L7)
  L9 = assert
  L10 = io
  L10 = L10.open
  L11 = "/proc/self/fd/"
  L13 = L3
  L12 = L3.fileno
  L12 = L12(L13)
  L11 = L11 .. L12
  L12 = "r"
  L10, L11, L12, L13 = L10(L11, L12)
  L9 = L9(L10, L11, L12, L13)
  L11 = L3
  L10 = L3.close
  L10(L11)
  L11 = L9
  L10 = L9.read
  L12 = "*all"
  L10 = L10(L11, L12)
  L12 = L9
  L11 = L9.close
  L11(L12)
  L11 = L7
  L12 = L8
  L13 = L10
  return L11, L12, L13
end
waitExec = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  if L1 == "table" then
    for L4, L5 in L1, L2, L3 do
      L6 = type
      L7 = L5
      L6 = L6(L7)
      if L6 == "table" then
        L6 = print
        L7 = "<"
        L8 = L4
        L9 = ": "
        L7 = L7 .. L8 .. L9
        L6(L7)
        L6 = doPrint
        L7 = L5
        L6(L7)
        L6 = print
        L7 = ">"
        L6(L7)
      else
        L6 = print
        L7 = "["
        L8 = L4
        L9 = " : "
        L10 = tostring
        L11 = L5
        L10 = L10(L11)
        L11 = "]"
        L7 = L7 .. L8 .. L9 .. L10 .. L11
        L6(L7)
      end
    end
  else
    L1(L2)
  end
end
doPrint = L1
function L1(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = forkExec
    L2 = _UPVALUE0_
    L2 = L2.FORK_RESTART_WIFI
    L3 = ";"
    L4 = A0
    L2 = L2 .. L3 .. L4
    L1(L2)
  else
    L1 = forkExec
    L2 = _UPVALUE0_
    L2 = L2.FORK_RESTART_WIFI
    L1(L2)
  end
end
forkRestartWifi = L1
function L1()
  local L0, L1
  L0 = forkExec
  L1 = _UPVALUE0_
  L1 = L1.FORK_RESTART_WIFI_NOTIFY_BUT_MIIO
  L0(L1)
end
forkRestartWifiNotify = L1
function L1()
  local L0, L1
  L0 = forkExec
  L1 = _UPVALUE0_
  L1 = L1.FORK_RESTART_WIFI_NOTIFY_BUT_MIIO
  L0(L1)
end
forkRestartWifiNotifyButMiio = L1
function L1()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.XQFeatures"
  L1 = L1(L2)
  L1 = L1.FEATURES
  L2 = L1.system
  L2 = L2.cpe
  if L2 then
    L2 = L1.system
    L2 = L2.cpe
    if L2 == "1" then
      L3 = L0
      L2 = L0.commit
      L4 = "mobile"
      L2(L3, L4)
    end
  end
  L2 = forkExec
  L3 = _UPVALUE0_
  L3 = L3.FORK_RESTART_ROUTER
  L2(L3)
end
forkReboot = L1
function L1()
  local L0, L1
  L0 = forkExec
  L1 = _UPVALUE0_
  L1 = L1.FORK_SHUTDOWN_ROUTER
  L0(L1)
end
forkShutdown = L1
function L1()
  local L0, L1
  L0 = forkExec
  L1 = _UPVALUE0_
  L1 = L1.FORK_RESET_ALL
  L0(L1)
end
forkResetAll = L1
function L1()
  local L0, L1
  L0 = forkExec
  L1 = _UPVALUE0_
  L1 = L1.FORK_RESTART_DNSMASQ
  L0(L1)
end
forkRestartDnsmasq = L1
function L1(A0)
  local L1, L2, L3
  L1 = forkExec
  L2 = "flash.sh "
  L3 = A0
  L2 = L2 .. L3
  L1(L2)
end
forkFlashRomFile = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = tonumber
  L3 = A0
  L2 = L2(L3)
  L3 = tonumber
  L4 = A1
  L3 = L3(L4)
  if L2 and L3 and (L2 ~= 0 or L3 ~= 0) then
    L4 = nil
    if 0 < L2 and 0 < L3 then
      L5 = string
      L5 = L5.format
      L6 = "sleep %s ; /usr/sbin/uhbn 2 %s"
      L7 = tostring
      L8 = 60 * L2
      L7 = L7(L8)
      L8 = tostring
      L9 = L3
      L8, L9 = L8(L9)
      L5 = L5(L6, L7, L8, L9)
      L4 = L5
    end
    if L2 == 0 and 0 < L3 then
      L5 = string
      L5 = L5.format
      L6 = "sleep 4 ; /usr/sbin/uhbn 2 %s"
      L7 = tostring
      L8 = L3
      L7, L8, L9 = L7(L8)
      L5 = L5(L6, L7, L8, L9)
      L4 = L5
    end
    if 0 < L2 and L3 == 0 then
      L5 = string
      L5 = L5.format
      L6 = "sleep %s ; /usr/sbin/uhbn 3"
      L7 = tostring
      L8 = 60 * L2
      L7, L8, L9 = L7(L8)
      L5 = L5(L6, L7, L8, L9)
      L4 = L5
    end
    L5 = forkExec
    L6 = L4
    L5(L6)
  end
end
forkShutdownAndRebootWithDelay = L1
function L1()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = _UPVALUE0_
  L1 = L1.RESTART_MAC_FILTER
  L0(L1)
end
syncRestartMacFilter = L1
function L1()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "/usr/sbin/sysapi webinitrdr set off"
  L0(L1)
end
closeWebInitRDR = L1
function L1()
  local L0, L1, L2
  L0 = os
  L0 = L0.date
  L1 = "%Y-%m-%d--%X"
  L2 = os
  L2 = L2.time
  L2 = L2()
  return L0(L1, L2)
end
getTime = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  L5 = "GHz"
  L6 = "THz"
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L1[5] = L6
  for L5 = L2, L3, L4 do
    if 1024 < A0 and L5 < 5 then
      A0 = A0 / 1024
    else
      L6 = string
      L6 = L6.format
      L7 = "%.2f %s"
      L8 = A0
      L9 = L1[L5]
      return L6(L7, L8, L9)
    end
  end
end
hzFormat = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  L5 = "GB"
  L6 = "TB"
  L1[1] = L2
  L1[2] = L3
  L1[3] = L4
  L1[4] = L5
  L1[5] = L6
  for L5 = L2, L3, L4 do
    if 1024 < A0 and L5 < 5 then
      A0 = A0 / 1024
    else
      L6 = string
      L6 = L6.format
      L7 = "%.2f %s"
      L8 = A0
      L9 = L1[L5]
      return L6(L7, L8, L9)
    end
  end
end
byteFormat = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = #A0
  L2 = L1
  L3 = 0
  L4 = {}
  L5 = 0
  L6 = 192
  L7 = 224
  L8 = 240
  L9 = 248
  L10 = 252
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  L4[5] = L9
  L4[6] = L10
  while L2 ~= 0 do
    L5 = string
    L5 = L5.byte
    L6 = A0
    L7 = #L2
    L5 = L5(L6, L7)
    L6 = #L4
    while true do
      L7 = L4[L6]
      if not L7 then
        break
      end
      L7 = L4[L6]
      if L5 >= L7 then
        L2 = L2 - L6
        break
      end
      L6 = L6 - 1
    end
    L3 = L3 + 1
  end
  return L3
end
utfstrlen = L1
function L1(A0)
  local L1
  L1 = true
  return L1
end
checkSSID = L1
function L1(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.model.uci"
  L5 = L5(L6)
  L5 = L5.cursor
  L5 = L5()
  L6 = require
  L7 = "xiaoqiang.util.XQWifiUtil"
  L6 = L6(L7)
  L7 = L6.get_wlan_count
  L7 = L7()
  L8 = 0
  L9 = ""
  if A0 == "cfg_file" then
    L11 = L5
    L10 = L5.get
    L12 = "misc"
    L13 = "wireless"
    L14 = "if_5G"
    L10 = L10(L11, L12, L13, L14)
    L12 = L5
    L11 = L5.get
    L13 = "wireless"
    L14 = L10
    L15 = "channel"
    L11 = L11(L12, L13, L14, L15)
    L13 = L5
    L12 = L5.get
    L14 = "wireless"
    L15 = L10
    L16 = "bw"
    L12 = L12(L13, L14, L15, L16)
    L13 = "/sbin/wifi get_cac_time "
    L14 = L10
    L15 = " "
    L16 = L11
    L17 = " "
    L18 = L12
    L19 = " 2>/dev/null"
    L9 = L13 .. L14 .. L15 .. L16 .. L17 .. L18 .. L19
    L13 = io
    L13 = L13.popen
    L14 = L9
    L13 = L13(L14)
    L14 = string
    L14 = L14.trim
    L16 = L13
    L15 = L13.read
    L17 = "*all"
    L15 = L15(L16, L17)
    L15 = L15 or L15
    L14 = L14(L15)
    L16 = L13
    L15 = L13.close
    L15(L16)
    L15 = tonumber
    L16 = L4.trim
    L17 = L14
    L16, L17, L18, L19, L20, L21, L22, L23, L24 = L16(L17)
    L15 = L15(L16, L17, L18, L19, L20, L21, L22, L23, L24)
    if L8 < L15 then
      L15 = tonumber
      L16 = L4.trim
      L17 = L14
      L16, L17, L18, L19, L20, L21, L22, L23, L24 = L16(L17)
      L15 = L15(L16, L17, L18, L19, L20, L21, L22, L23, L24)
      L8 = L15
    end
    if 3 <= L7 then
      L16 = L5
      L15 = L5.get
      L17 = "misc"
      L18 = "wireless"
      L19 = "if_5GH"
      L15 = L15(L16, L17, L18, L19)
      L17 = L5
      L16 = L5.get
      L18 = "wireless"
      L19 = L15
      L20 = "channel"
      L16 = L16(L17, L18, L19, L20)
      L18 = L5
      L17 = L5.get
      L19 = "wireless"
      L20 = L15
      L21 = "bw"
      L17 = L17(L18, L19, L20, L21)
      L18 = "/sbin/wifi get_cac_time "
      L19 = L15
      L20 = " "
      L21 = L16
      L22 = " "
      L23 = L17
      L24 = " 2>/dev/null"
      L9 = L18 .. L19 .. L20 .. L21 .. L22 .. L23 .. L24
      L18 = io
      L18 = L18.popen
      L19 = L9
      L18 = L18(L19)
      L19 = string
      L19 = L19.trim
      L21 = L18
      L20 = L18.read
      L22 = "*all"
      L20 = L20(L21, L22)
      L20 = L20 or L20
      L19 = L19(L20)
      L14 = L19
      L20 = L18
      L19 = L18.close
      L19(L20)
      L19 = tonumber
      L20 = L4.trim
      L21 = L14
      L20, L21, L22, L23, L24 = L20(L21)
      L19 = L19(L20, L21, L22, L23, L24)
      if L8 < L19 then
        L19 = tonumber
        L20 = L4.trim
        L21 = L14
        L20, L21, L22, L23, L24 = L20(L21)
        L19 = L19(L20, L21, L22, L23, L24)
        L8 = L19
      end
    end
  else
    L11 = L5
    L10 = L5.get
    L12 = "wireless"
    L13 = A1
    L14 = "channel"
    L10 = L10(L11, L12, L13, L14)
    L12 = L5
    L11 = L5.get
    L13 = "wireless"
    L14 = A1
    L15 = "bw"
    L11 = L11(L12, L13, L14, L15)
    L12 = isStrNil
    L13 = A2
    L12 = L12(L13)
    if L12 then
      A2 = L10
    end
    L12 = isStrNil
    L13 = A3
    L12 = L12(L13)
    if L12 then
      A3 = L11
    end
    L12 = "/sbin/wifi get_cac_time "
    L13 = A1
    L14 = " "
    L15 = A2
    L16 = " "
    L17 = A3
    L18 = " 2>/dev/null"
    L9 = L12 .. L13 .. L14 .. L15 .. L16 .. L17 .. L18
    L12 = io
    L12 = L12.popen
    L13 = L9
    L12 = L12(L13)
    L13 = string
    L13 = L13.trim
    L15 = L12
    L14 = L12.read
    L16 = "*all"
    L14 = L14(L15, L16)
    L14 = L14 or L14
    L13 = L13(L14)
    L15 = L12
    L14 = L12.close
    L14(L15)
    L14 = tonumber
    L15 = L4.trim
    L16 = L13
    L15, L16, L17, L18, L19, L20, L21, L22, L23, L24 = L15(L16)
    L14 = L14(L15, L16, L17, L18, L19, L20, L21, L22, L23, L24)
    if L8 < L14 then
      L14 = tonumber
      L15 = L4.trim
      L16 = L13
      L15, L16, L17, L18, L19, L20, L21, L22, L23, L24 = L15(L16)
      L14 = L14(L15, L16, L17, L18, L19, L20, L21, L22, L23, L24)
      L8 = L14
    end
  end
  return L8
end
get_cac_time = L1
function L1()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = _UPVALUE0_
  L1 = L1.UPGRADE_LOCK
  return L0(L1)
end
sysLock = L1
function L1()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = _UPVALUE0_
  L1 = L1.UPGRADE_UNLOCK
  return L0(L1)
end
sysUnlock = L1
function L1()
  local L0, L1, L2
  L0 = require
  L1 = "luci.fs"
  L0 = L0(L1)
  L1 = L0.access
  L2 = _UPVALUE0_
  L2 = L2.UPGRADE_LOCK_FILE
  L1 = L1(L2)
  if L1 then
    L2 = 1
    return L2
  else
    L2 = 0
    return L2
  end
end
sysLockStatus = L1
function L1(A0)
  local L1, L2
  if A0 then
    L1 = forkExec
    L2 = _UPVALUE0_
    L2 = L2.UPDATE_LED_FLASH_ALERT_ENABLE
    L1(L2)
  else
    L1 = os
    L1 = L1.execute
    L2 = _UPVALUE0_
    L2 = L2.UPDATE_LED_FLASH_ALERT_DISABLE
    L1(L2)
  end
end
ledFlashAlert = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.exec
  L3 = string
  L3 = L3.format
  L4 = _UPVALUE0_
  L4 = L4.GPIO_VALUE
  L5 = tostring
  L6 = A0
  L5, L6 = L5(L6)
  L3, L4, L5, L6 = L3(L4, L5, L6)
  L2 = L2(L3, L4, L5, L6)
  if L2 then
    L3 = tonumber
    L4 = L1.trim
    L5 = L2
    L4, L5, L6 = L4(L5)
    L3 = L3(L4, L5, L6)
    L3 = L3 or L3
    return L3
  end
  L3 = 0
  return L3
end
getGpioValue = L1
function L1(A0)
  local L1, L2, L3, L4
  L1 = isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  else
    L2 = A0
    L1 = A0.gsub
    L3 = "\\"
    L4 = "\\\\"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "`"
    L4 = "\\`"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "\""
    L4 = "\\\""
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "%$"
    L4 = "\\$"
    L1 = L1(L2, L3, L4)
    return L1
  end
end
_cmdformat = L1
function L1(A0)
  local L1, L2, L3, L4
  L1 = isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  else
    L2 = A0
    L1 = A0.gsub
    L3 = "'"
    L4 = ""
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "\\"
    L4 = "\\\\"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "`"
    L4 = "\\`"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "\""
    L4 = "\\\""
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "%$"
    L4 = "\\$"
    L1 = L1(L2, L3, L4)
    return L1
  end
end
_strformat = L1
function L1(A0)
  local L1, L2, L3, L4
  L1 = isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  else
    L2 = A0
    L1 = A0.gsub
    L3 = "\\"
    L4 = "\\\\"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "`"
    L4 = "\\`"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "\""
    L4 = "\\\""
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "%$"
    L4 = "\\$"
    L1 = L1(L2, L3, L4)
    return L1
  end
end
paramFormat = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    return A1
  end
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = string
  L3 = L3.format
  L4 = "bdata get \"%s\""
  L5 = _cmdformat
  L6 = A0
  L5, L6 = L5(L6)
  L3 = L3(L4, L5, L6)
  L4 = L2.exec
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L5 = L2.trim
    L6 = L4
    L5 = L5(L6)
    L4 = L5
    return L4
  end
  return A1
end
bdataGet = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    return A1
  end
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = string
  L3 = L3.format
  L4 = "nvram get \"%s\""
  L5 = _cmdformat
  L6 = A0
  L5, L6 = L5(L6)
  L3 = L3(L4, L5, L6)
  L4 = L2.exec
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L5 = L2.trim
    L6 = L4
    L5 = L5(L6)
    L4 = L5
    return L4
  end
  return A1
end
nvramGet = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    return
  end
  L2 = nil
  L3 = isStrNil
  L4 = A1
  L3 = L3(L4)
  if L3 then
    L3 = string
    L3 = L3.format
    L4 = "nvram unset \"%s\""
    L5 = _cmdformat
    L6 = A0
    L5, L6, L7 = L5(L6)
    L3 = L3(L4, L5, L6, L7)
    L2 = L3
  else
    L3 = string
    L3 = L3.format
    L4 = "nvram set \"%s\"=\"%s\""
    L5 = _cmdformat
    L6 = A0
    L5 = L5(L6)
    L6 = _cmdformat
    L7 = A1
    L6, L7 = L6(L7)
    L3 = L3(L4, L5, L6, L7)
    L2 = L3
  end
  L3 = os
  L3 = L3.execute
  L4 = L2
  L3(L4)
end
nvramSet = L1
function L1()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "nvram commit"
  L0(L1)
end
nvramCommit = L1
function L1()
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
  L5 = "NETMODE"
  L1 = L1(L2, L3, L4, L5)
  L2 = isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = nil
  end
  return L1
end
getNetMode = L1
function L1()
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
  L5 = "MESH_VERSION"
  L1 = L1(L2, L3, L4, L5)
  L2 = isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = 1
  end
  return L1
end
getMeshVersion = L1
function L1()
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
  L5 = "CAP_MODE"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = 0
  if L1 == "ap" then
    L2 = 1
  end
  return L2
end
getCAPMode = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  if A0 then
    L3 = L1
    L2 = L1.set
    L4 = "xiaoqiang"
    L5 = "common"
    L6 = "CAP_MODE"
    L7 = A0
    L2(L3, L4, L5, L6, L7)
  else
    L3 = L1
    L2 = L1.delete
    L4 = "xiaoqiang"
    L5 = "common"
    L6 = "CAP_MODE"
    L2(L3, L4, L5, L6)
  end
  L3 = L1
  L2 = L1.commit
  L4 = "xiaoqiang"
  L2(L3, L4)
end
setCAPMode = L1
function L1()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "features"
  L5 = "support160Mhz"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if "0" == L1 then
    L2 = 0
    return L2
  end
  L2 = 1
  return L2
end
isSupport160Mhz = L1
function L1()
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
  L5 = "NETMODE"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L3 = L1
  L2 = L1.match
  L4 = "^whc_cap"
  L2 = L2(L3, L4)
  if L2 then
    L2 = true
    return L2
  else
    L3 = L1
    L2 = L1.match
    L4 = "^lanapmode"
    L2 = L2(L3, L4)
    if L2 then
      L2 = getCAPMode
      L2 = L2()
      if L2 == 1 then
        L2 = true
        return L2
      end
    end
  end
  L2 = false
  return L2
end
isMeshCap = L1
function L1()
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
  L5 = "NETMODE"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L3 = L1
  L2 = L1.match
  L4 = "^whc_re"
  L2 = L2(L3, L4)
  if L2 then
    L2 = true
    return L2
  end
  L2 = false
  return L2
end
isMeshRe = L1
function L1()
  local L0, L1
  L0 = isMeshCap
  L0 = L0()
  if not L0 then
    L0 = isMeshRe
    L0 = L0()
    if not L0 then
      goto lbl_11
    end
  end
  L0 = true
  do return L0 end
  ::lbl_11::
  L0 = false
  return L0
end
isMeshMode = L1
function L1()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "hardware"
  L5 = "recovery"
  L1 = L1(L2, L3, L4, L5)
  L2 = isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = 0
  end
  L2 = tonumber
  L3 = L1
  return L2(L3)
end
miscRecovery = L1
function L1()
  local L0, L1, L2
  L0 = miscRecovery
  L0 = L0()
  if L0 == 1 then
    L1 = 100
    return L1
  end
  L1 = 0
  L2 = getNetMode
  L2 = L2()
  if L2 == "lanapmode" then
    L1 = 2
  elseif L2 == "wifiapmode" then
    L1 = 1
  elseif L2 == "whc_re" then
    L1 = 3
  elseif L2 == "agent" then
    L1 = 3
  end
  return L1
end
getNetModeType = L1
function L1()
  local L0, L1, L2
  L0 = miscRecovery
  L0 = L0()
  if L0 == 1 then
    L1 = 100
    return L1
  end
  L1 = 0
  L2 = getNetMode
  L2 = L2()
  if L2 == "lanapmode" then
    L1 = 2
  elseif L2 == "wifiapmode" then
    L1 = 1
  elseif L2 == "whc_re" then
    L1 = 3
  elseif L2 == "whc_cap" then
    L1 = 4
  elseif L2 == "cpe_bridgemode" then
    L1 = 5
  elseif L2 == "controller" then
    L1 = 4
  elseif L2 == "agent" then
    L1 = 3
  end
  return L1
end
getnetmode = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "xiaoqiang.util.XQSynchrodata"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  if A0 then
    if A0 == "wifiapmode" then
      L3 = L1.syncWorkMode
      L4 = 1
      L3(L4)
    elseif A0 == "lanapmode" then
      L3 = L1.syncWorkMode
      L4 = 2
      L3(L4)
    end
    L4 = L2
    L3 = L2.set
    L5 = "xiaoqiang"
    L6 = "common"
    L7 = "NETMODE"
    L8 = A0
    L3(L4, L5, L6, L7, L8)
  else
    L3 = L1.syncWorkMode
    L4 = 0
    L3(L4)
    L4 = L2
    L3 = L2.delete
    L5 = "xiaoqiang"
    L6 = "common"
    L7 = "NETMODE"
    L3(L4, L5, L6, L7)
  end
  L4 = L2
  L3 = L2.commit
  L5 = "xiaoqiang"
  L3(L4, L5)
  L3 = waitExec
  L4 = "ubus"
  L5 = "call"
  L6 = "service"
  L7 = "event"
  L8 = "{ \"type\": \"config.change\", \"data\": { \"package\": \"xiaoqiang\" }}"
  L3(L4, L5, L6, L7, L8)
end
setNetMode = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQCryptoUtil"
  L2 = L2(L3)
  L3 = L2.binaryBase64Enc
  L4 = A0
  L3 = L3(L4)
  A0 = L3
  L3 = L1.trim
  L4 = L1.exec
  L5 = _UPVALUE0_
  L5 = L5.THRIFT_TUNNEL_TO_DATACENTER
  L5 = L5 % A0
  L4, L5, L6 = L4(L5)
  L3 = L3(L4, L5, L6)
  L4 = isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L4 = nil
    return L4
  else
    L4 = require
    L5 = "cjson"
    L4 = L4(L5)
    L5 = L4.decode
    L6 = L3
    return L5(L6)
  end
end
thrift_tunnel_to_datacenter = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = nil
    return L1
  end
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQCryptoUtil"
  L2 = L2(L3)
  L3 = L2.binaryBase64Enc
  L4 = A0
  L3 = L3(L4)
  A0 = L3
  L3 = L1.trim
  L4 = L1.exec
  L5 = _UPVALUE0_
  L5 = L5.THRIFT_TUNNEL_TO_SMARTHOME_CONTROLLER
  L5 = L5 % A0
  L4, L5, L6 = L4(L5)
  L3 = L3(L4, L5, L6)
  L4 = isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L4 = nil
    return L4
  else
    L4 = require
    L5 = "cjson"
    L4 = L4(L5)
    L5 = L4.decode
    L6 = L3
    return L5(L6)
  end
end
thrift_tunnel_to_smarthome_controller = L1
function L1()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = "matool --method identifyDevice"
  L2 = L0.trim
  L3 = L0.exec
  L4 = L1
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L3 = isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L2 = ""
  end
  return L2
end
mattool_identify_device = L1
function L1()
  local L0, L1, L2, L3, L4
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = "matool --method deviceID"
  L2 = L0.trim
  L3 = L0.exec
  L4 = L1
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L3 = isStrNil
  L4 = L2
  L3 = L3(L4)
  if L3 then
    L2 = ""
  end
  return L2
end
mattool_get_deviceid = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  if A0 == 0 then
    L2 = 0
    return L2
  end
  L2 = 0
  for L6 = L3, L4, L5 do
    L7 = bit
    L7 = L7.rshift
    L8 = 128
    L9 = L6
    L7 = L7(L8, L9)
    L8 = bit
    L8 = L8.band
    L9 = A0
    L10 = L7
    L8 = L8(L9, L10)
    if L8 == 0 then
      L9 = A0 - L2
      if L9 == 0 then
        if A1 == 0 or A1 == 2 then
          L9 = -1
          return L9
        elseif A1 == 1 then
          L9 = 2
          return L9
        end
      else
        L9 = -1
        return L9
      end
    end
    L2 = L2 + L7
  end
  return L3
end
_parse = L1
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  if A0 == "0.0.0.0" or A0 == "255.255.255.255" then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.cbi.datatypes"
  L2 = L2(L3)
  L3 = L2.ipaddr
  L4 = A0
  L3 = L3(L4)
  if not L3 then
    L3 = false
    return L3
  end
  L3 = L1.split
  L4 = A0
  L3 = L3(L4, L5)
  L4 = 1
  for L8, L9 in L5, L6, L7 do
    L10 = _parse
    L11 = tonumber
    L12 = L9
    L11 = L11(L12)
    L12 = L4
    L10 = L10(L11, L12)
    L4 = L10
    if L4 == -1 then
      L10 = false
      return L10
    end
  end
  return L5
end
checkMask = L1
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "bit"
  L3 = L3(L4)
  L4 = L2.split
  L5 = A1
  L6 = "."
  L4 = L4(L5, L6)
  L5 = L2.split
  L6 = A0
  L7 = "."
  L5 = L5(L6, L7)
  L6 = 0
  L7 = 0
  L8 = 0
  L9 = 0
  L10 = L3.lshift
  L11 = tonumber
  L12 = L5[1]
  L11 = L11(L12)
  L12 = 24
  L10 = L10(L11, L12)
  L6 = L6 + L10
  L10 = L3.lshift
  L11 = tonumber
  L12 = L5[2]
  L11 = L11(L12)
  L12 = 16
  L10 = L10(L11, L12)
  L6 = L6 + L10
  L10 = L3.lshift
  L11 = tonumber
  L12 = L5[3]
  L11 = L11(L12)
  L12 = 8
  L10 = L10(L11, L12)
  L6 = L6 + L10
  L10 = tonumber
  L11 = L5[4]
  L10 = L10(L11)
  L6 = L6 + L10
  L10 = L3.lshift
  L11 = tonumber
  L12 = L4[1]
  L11 = L11(L12)
  L12 = 24
  L10 = L10(L11, L12)
  L7 = L7 + L10
  L10 = L3.lshift
  L11 = tonumber
  L12 = L4[2]
  L11 = L11(L12)
  L12 = 16
  L10 = L10(L11, L12)
  L7 = L7 + L10
  L10 = L3.lshift
  L11 = tonumber
  L12 = L4[3]
  L11 = L11(L12)
  L12 = 8
  L10 = L10(L11, L12)
  L7 = L7 + L10
  L10 = tonumber
  L11 = L4[4]
  L10 = L10(L11)
  L7 = L7 + L10
  L10 = L3.band
  L11 = L3.bnot
  L12 = L7
  L11 = L11(L12)
  L12 = 4294967295
  L10 = L10(L11, L12)
  L8 = L10
  L10 = L3.band
  L11 = L8
  L12 = L6
  L10 = L10(L11, L12)
  L9 = L10
  if L8 == L9 or L9 == 0 then
    L10 = true
    return L10
  end
  L10 = false
  return L10
end
function L2(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.split
  L3 = A0
  L4 = "."
  L2 = L2(L3, L4)
  L3 = tonumber
  L4 = L2[1]
  L3 = L3(L4)
  if 224 <= L3 then
    L3 = tonumber
    L4 = L2[1]
    L3 = L3(L4)
    if L3 <= 239 then
      L3 = true
      return L3
    end
  end
  L3 = false
  return L3
end
isMulticast = L2
function L2(A0, A1)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  if not L2 then
    L2 = isMulticast
    L3 = A0
    L2 = L2(L3)
    if not L2 then
      goto lbl_14
    end
  end
  L2 = true
  do return L2 end
  ::lbl_14::
  L2 = false
  return L2
end
isBroadcastOrMulticast = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.ip"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.util"
  L3 = L3(L4)
  L4 = isStrNil
  L5 = A0
  L4 = L4(L5)
  if L4 then
    L4 = false
    return L4
  end
  L4 = L2.iptonl
  L5 = A0
  L4 = L4(L5)
  L5 = L2.iptonl
  L6 = "169.254.0.0"
  L5 = L5(L6)
  if L4 >= L5 then
    L5 = L2.iptonl
    L6 = "169.254.255.255"
    L5 = L5(L6)
    if L4 <= L5 then
      goto lbl_35
    end
  end
  L5 = L2.iptonl
  L6 = "127.0.0.1"
  L5 = L5(L6)
  ::lbl_35::
  if L4 == L5 then
    L5 = false
    return L5
  end
  L5 = isMulticast
  L6 = A0
  L5 = L5(L6)
  if L5 then
    L5 = false
    return L5
  end
  L5 = true
  return L5
end
checkDns = L2
function L2(A0)
  local L1, L2, L3, L4
  L1 = isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  end
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "&"
  L4 = "&amp;"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "<"
  L4 = "&lt;"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = ">"
  L4 = "&gt;"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "\""
  L4 = "&quot;"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "'"
  L4 = "&#039;"
  L1 = L1(L2, L3, L4)
  A0 = L1
  return A0
end
encode4HtmlValue = L2
function L2(A0)
  local L1, L2, L3, L4
  L1 = isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  end
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "&amp;"
  L4 = "&"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "&lt;"
  L4 = "<"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "&gt;"
  L4 = ">"
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "&quot;"
  L4 = "\""
  L1 = L1(L2, L3, L4)
  A0 = L1
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "&#039;"
  L4 = "'"
  L1 = L1(L2, L3, L4)
  A0 = L1
  return A0
end
decode4HtmlValue = L2
function L2(A0)
  local L1, L2, L3, L4
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "\\"
  L4 = "\\\\"
  L1 = L1(L2, L3, L4)
  A0 = L1
  return A0
end
encode4Js = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = L1.getRouterName
  L2 = L2()
  L3 = L1.getRouterLocale
  L3 = L3()
  L4 = isStrNil
  L5 = A0
  L4 = L4(L5)
  if L4 then
    A0 = "1"
  end
  if L3 ~= "" then
    L4 = " ("
    L5 = encode4HtmlValue
    L6 = L3
    L5 = L5(L6)
    L6 = ")"
    L3 = L4 .. L5 .. L6
  end
  L4 = tonumber
  L5 = A0
  L4 = L4(L5)
  if L4 == 1 then
    L4 = encode4HtmlValue
    L5 = L2
    L4 = L4(L5)
    L5 = L3
    L2 = L4 .. L5
  else
    L4 = encode4HtmlValue
    L5 = L2
    L4 = L4(L5)
    L2 = L4
  end
  return L2
end
getRouterName = L2
function L2()
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
  L2 = isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = nil
  end
  return L1
end
get_active_apcli = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "mesh"
  L5 = "max_node_count"
  L1 = L1(L2, L3, L4, L5)
  L2 = isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = 9
    return L2
  else
    L2 = tonumber
    L3 = L1
    return L2(L3)
  end
end
getMaxMeshNodeCount = L2
function L2()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.trim
  L2 = L0.exec
  L3 = "mesh_cmd re_count 2>>/dev/null"
  L2, L3 = L2(L3)
  L1 = L1(L2, L3)
  L2 = isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = 0
    return L2
  else
    L2 = tonumber
    L3 = L1
    return L2(L3)
  end
end
getMeshAliveReCount = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.trim
  L3 = L1.exec
  L4 = "openssl rand -hex "
  L5 = math
  L5 = L5.floor
  L6 = A0 / 2
  L5 = L5(L6)
  L6 = " 2>/dev/null"
  L4 = L4 .. L5 .. L6
  L3, L4, L5, L6 = L3(L4)
  L2 = L2(L3, L4, L5, L6)
  return L2
end
GenRandID = L2
function L2(A0, A1, A2)
  local L3, L4
  L3 = require
  L4 = "xiaoqiang.XQFeatures"
  L3 = L3(L4)
  L3 = L3.FEATURES
  L4 = L3[A1]
  if not L4 then
    return A0
  end
  L4 = L3[A1]
  L4 = L4[A2]
  if not L4 then
    return A0
  end
  L4 = L3[A1]
  L4 = L4[A2]
  return L4
end
getFeature = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "misc"
  L4 = "dhcp"
  L5 = "host_limit"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  return L1
end
getDhcpHostLimit = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "xiaoqiang"
  L4 = "common"
  L5 = "USER_MODIFIED_MODE"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if "" == L1 then
    L3 = L0
    L2 = L0.set
    L4 = "xiaoqiang"
    L5 = "common"
    L6 = "USER_MODIFIED_MODE"
    L7 = "1"
    L2(L3, L4, L5, L6, L7)
    L3 = L0
    L2 = L0.commit
    L4 = "xiaoqiang"
    L2(L3, L4)
  end
end
setUserModifiedModeFlag = L2
function L2(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L4 = require
  L5 = "xiaoqiang.util.XQSecureUtil"
  L4 = L4(L5)
  L5 = type
  L5 = L5(L6)
  if L5 == "table" then
    L5 = {}
    for L9, L10 in L6, L7, L8 do
      if L9 == A1 and A2 <= A3 then
        L10 = ""
      else
        L11 = type
        L12 = L10
        L11 = L11(L12)
        if L11 == "table" then
          L11 = validJsonParam
          L12 = L10
          L13 = A1
          L14 = A2
          L15 = A3 + 1
          L11 = L11(L12, L13, L14, L15)
          L10 = L11
        else
          L11 = type
          L12 = L10
          L11 = L11(L12)
          if L11 == "string" then
            L11 = L4.hackCharsCheck
            L12 = L10
            L11 = L11(L12)
            L10 = L11
          end
        end
        L5[L9] = L10
      end
    end
    return L5
  else
    L5 = type
    L5 = L5(L6)
    if L5 == "string" then
      L5 = L4.hackCharsCheck
      L5 = L5(L6)
      A0 = L5
    end
  end
  return A0
end
validJsonParam = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = "2-3"
  L1 = translate
  L2 = "\231\153\189"
  L1 = L1(L2)
  L2 = getFeature
  L3 = "miwifi.com"
  L4 = "system"
  L5 = "backend_url"
  L2 = L2(L3, L4, L5)
  L3 = getFeature
  L4 = "0"
  L5 = "system"
  L6 = "upgraded_light_color"
  L3 = L3(L4, L5, L6)
  L4 = getFeature
  L5 = "0"
  L6 = "system"
  L7 = "upgraded_expected_time"
  L4 = L4(L5, L6, L7)
  L5 = getFeature
  L6 = "0"
  L7 = "system"
  L8 = "new_upgraded_text"
  L5 = L5(L6, L7, L8)
  if L3 == "1" then
    L6 = translate
    L7 = "\232\147\157"
    L6 = L6(L7)
    L1 = L6
  end
  if L4 == "1" then
    L0 = "5-10"
  elseif L4 == "2" then
    L0 = "5-8"
  end
  L6 = L0
  L7 = L1
  L8 = L2
  L9 = L5
  return L6, L7, L8, L9
end
getUpgradeCharacteristic = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  if L2 ~= "table" then
    return L1
  end
  for L5, L6 in L2, L3, L4 do
    L1[L6] = true
  end
  return L1
end
arrayTransposition = L2
