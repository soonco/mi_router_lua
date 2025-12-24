local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
L0 = module
L1 = "luci.controller.config_scan.index"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.XQFeatures"
L0 = L0(L1)
L0 = L0.FEATURES
L1 = require
L2 = "luci.http"
L1 = L1(L2)
L2 = "/tmp/config_scan"
L3 = L2
L4 = "/"
L5 = "meta/ids"
L3 = L3 .. L4 .. L5
L4 = L2
L5 = "/"
L6 = "meta/result"
L4 = L4 .. L5 .. L6
L5 = L2
L6 = "/"
L7 = "meta/pids"
L5 = L5 .. L6 .. L7
L6 = 4
L7 = math
L7 = L7.randomseed
L8 = os
L8 = L8.time
L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19 = L8()
L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19)
function L7()
  local L0, L1, L2, L3, L4, L5
  L0 = node
  L1 = "api"
  L2 = "config_scanner"
  L0 = L0(L1, L2)
  L0.sysauth = "admin"
  L0.sysauth_authenticator = "htmlauth"
  L0.index = true
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "config_scanner"
  L5 = "overview"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "overview"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "config_scanner"
  L5 = "config"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "config"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "config_scanner"
  L5 = "start"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "start"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "config_scanner"
  L5 = "get_status"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "get_status"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
  L1 = entry
  L2 = {}
  L3 = "api"
  L4 = "config_scanner"
  L5 = "stop"
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = call
  L4 = "stop"
  L3 = L3(L4)
  L4 = ""
  L1(L2, L3, L4)
end
index = L7
function L7()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = L0.waitExec
  L2 = "awk"
  L3 = "/^now/ {print $3; exit}"
  L4 = "/proc/timer_list"
  L1, L2, L3 = L1(L2, L3, L4)
  L4 = math
  L4 = L4.floor
  L5 = tonumber
  L6 = L3 / 1000000000
  L5, L6 = L5(L6)
  return L4(L5, L6)
end
function L8()
  local L0, L1, L2
  L0 = os
  L0 = L0.execute
  L1 = "mkdir -p "
  L2 = _UPVALUE0_
  L1 = L1 .. L2
  L0(L1)
  L0 = os
  L0 = L0.execute
  L1 = "mkdir -p "
  L2 = _UPVALUE1_
  L1 = L1 .. L2
  L0(L1)
  L0 = os
  L0 = L0.execute
  L1 = "mkdir -p "
  L2 = _UPVALUE2_
  L1 = L1 .. L2
  L0(L1)
end
function L9()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "posix.fcntl"
  L0 = L0(L1)
  L1 = require
  L2 = "posix.unistd"
  L1 = L1(L2)
  L2 = require
  L3 = "posix.sys.stat"
  L2 = L2(L3)
  L3 = L0.open
  L4 = "/tmp/lock/config_scan.lock"
  L5 = L0.O_CREAT
  L6 = L0.O_WRONLY
  L5 = L5 + L6
  L6 = L0.O_TRUNC
  L5 = L5 + L6
  L6 = L2.IRWXU
  L3 = L3(L4, L5, L6)
  L4 = {}
  L5 = L0.F_WRLCK
  L4.l_type = L5
  L5 = L0.SEEK_SET
  L4.l_whence = L5
  L4.l_start = 0
  L4.l_len = 0
  L5 = L0.fcntl
  L6 = L3
  L7 = L0.F_SETLKW
  L8 = L4
  L5(L6, L7, L8)
  return L3
end
function L10(A0)
  local L1, L2, L3
  L1 = require
  L2 = "posix.unistd"
  L1 = L1(L2)
  L2 = L1.close
  L3 = A0
  L2(L3)
end
function L11(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = require
  L4 = "nixio"
  L3 = L3(L4)
  L4 = L3.open
  L5 = A0
  L6 = "/"
  L7 = A1
  L5 = L5 .. L6 .. L7
  L6 = "w"
  L4 = L4(L5, L6)
  L6 = L4
  L5 = L4.write
  L7 = A2
  L5(L6, L7)
  L6 = L4
  L5 = L4.close
  L5(L6)
end
function L12(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = require
  L3 = "nixio"
  L2 = L2(L3)
  L3 = L2.open
  L4 = A0
  L5 = "/"
  L6 = A1
  L4 = L4 .. L5 .. L6
  L5 = "r"
  L3 = L3(L4, L5)
  if not L3 then
    L4 = nil
    return L4
  end
  L5 = L3
  L4 = L3.read
  L6 = 1024
  L4 = L4(L5, L6)
  L6 = L3
  L5 = L3.close
  L5(L6)
  L5 = tonumber
  L6 = L4
  return L5(L6)
end
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = {}
  L2 = {}
  L3 = require
  L3 = L3(L4)
  files = L4
  if not L4 then
    return L4, L5
  end
  for L7, L8 in L4, L5, L6 do
    if L8 ~= "." and L8 ~= ".." then
      L9 = _UPVALUE0_
      L10 = A0
      L11 = L8
      L9 = L9(L10, L11)
      L1[L8] = L9
      L10 = table
      L10 = L10.insert
      L11 = L2
      L12 = {}
      L12.workid = L8
      L12.ts = L9
      L10(L11, L12)
    end
  end
  L4(L5, L6)
  return L4, L5
end
function L14(A0)
  local L1, L2, L3, L4, L5
  L1 = os
  L1 = L1.remove
  L2 = _UPVALUE0_
  L3 = "/"
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = os
  L1 = L1.remove
  L2 = _UPVALUE1_
  L3 = "/"
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = os
  L1 = L1.remove
  L2 = _UPVALUE2_
  L3 = "/"
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = os
  L1 = L1.execute
  L2 = "rm -r "
  L3 = _UPVALUE3_
  L4 = "/"
  L5 = A0
  L2 = L2 .. L3 .. L4 .. L5
  L1(L2)
end
function L15()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = _UPVALUE0_
  L0 = L0()
  L1 = _UPVALUE1_
  L2 = _UPVALUE2_
  L1, L2 = L1(L2)
  for L6, L7 in L3, L4, L5 do
    L8 = L7.ts
    L9 = L0 - 10
    if L8 < L9 then
      L8 = _UPVALUE3_
      L9 = L7.workid
      L8(L9)
    end
  end
end
function L16()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = _UPVALUE0_
  L0()
  L0 = _UPVALUE1_
  L0()
  L0 = _UPVALUE2_
  L1 = _UPVALUE3_
  L0, L1 = L0(L1)
  L2 = _UPVALUE2_
  L3 = _UPVALUE4_
  L2, L3 = L2(L3)
  L4 = #L1
  L5 = #L3
  L4 = L4 - L5
  L5 = _UPVALUE5_
  if not (L4 >= L5) then
    L4 = #L3
    L5 = _UPVALUE5_
    L5 = 2 * L5
    if not (L4 >= L5) then
      goto lbl_23
    end
  end
  do return end
  ::lbl_23::
  L4 = tostring
  L5 = math
  L5 = L5.random
  L6 = 1000
  L5, L6, L7, L8 = L5(L6)
  L4 = L4(L5, L6, L7, L8)
  while true do
    L5 = L0[L4]
    if not L5 then
      break
    end
    L5 = tostring
    L6 = math
    L6 = L6.random
    L7 = 1000
    L6, L7, L8 = L6(L7)
    L5 = L5(L6, L7, L8)
    L4 = L5
  end
  L5 = _UPVALUE6_
  L6 = _UPVALUE3_
  L7 = L4
  L8 = _UPVALUE7_
  L8 = L8()
  L5(L6, L7, L8)
  return L4
end
function L17(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = _UPVALUE1_
  L1 = L1(L2)
  L2 = L1[A0]
  if L2 then
    L2 = _UPVALUE2_
    L3 = _UPVALUE3_
    L4 = A0
    L5 = _UPVALUE4_
    L5 = L5()
    L2(L3, L4, L5)
  end
end
function L18()
  local L0, L1
  L0 = require
  L1 = "config_scan.main_scanner"
  L0 = L0(L1)
  L1 = L0.overview
  return L1()
end
_overview = L18
function L18()
  local L0, L1, L2
  L0 = _overview
  L0 = L0()
  L0.code = 0
  L1 = _UPVALUE0_
  L1 = L1.write_json
  L2 = L0
  L1(L2)
end
overview = L18
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = _UPVALUE0_
  L0()
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = _overview
  L1 = L1()
  L2 = _UPVALUE1_
  L2 = L2.formvalue
  L2 = L2(L3)
  for L6, L7 in L3, L4, L5 do
    L8 = L1[L6]
    if L8 ~= nil then
      L9 = L0
      L8 = L0.set
      L10 = "config_scan"
      L11 = L6
      L12 = "node"
      L8(L9, L10, L11, L12)
      if L7 == "1" then
        L9 = L0
        L8 = L0.set
        L10 = "config_scan"
        L11 = L6
        L12 = "ignored"
        L13 = "0"
        L8(L9, L10, L11, L12, L13)
      elseif L7 == "0" then
        L9 = L0
        L8 = L0.set
        L10 = "config_scan"
        L11 = L6
        L12 = "ignored"
        L13 = "1"
        L8(L9, L10, L11, L12, L13)
      end
    end
  end
  L3(L4, L5)
  L4.code = 0
  L3(L4)
end
config = L18
function L18(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "config_scan.main_scanner"
  L1 = L1(L2)
  L2 = L1.scan
  L3 = _UPVALUE0_
  L4 = "/"
  L5 = A0
  L3 = L3 .. L4 .. L5
  L2(L3)
  L2 = _UPVALUE1_
  L2 = L2()
  L3 = _UPVALUE2_
  L4 = A0
  L3(L4)
  L3 = _UPVALUE3_
  L4 = L2
  L3(L4)
end
scan = L18
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = _UPVALUE0_
  L0()
  L0 = _UPVALUE1_
  L0 = L0()
  if not L0 then
    L1 = _UPVALUE2_
    L1 = L1.write_json
    L2 = {}
    L2.code = -1
    L2.msg = "resource busy"
    L1(L2)
    return
  end
  L1 = require
  L2 = "nixio"
  L1 = L1(L2)
  L2 = _UPVALUE3_
  L3 = "/"
  L4 = L0
  L2 = L2 .. L3 .. L4
  L3 = L1.fs
  L3 = L3.mkdir
  L4 = L2
  L3(L4)
  L3 = require
  L4 = "config_scan.main_scanner"
  L3 = L3(L4)
  L4 = L3.prepare
  L5 = L2
  L4(L5)
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = L4.forkExec2
  L6 = "lua"
  L7 = "-e"
  L8 = string
  L8 = L8.format
  L9 = "require(\"luci.controller.config_scan.index\").scan(\"%s\")"
  L10 = L0
  L8, L9, L10 = L8(L9, L10)
  L5 = L5(L6, L7, L8, L9, L10)
  L6 = _UPVALUE4_
  L7 = _UPVALUE5_
  L8 = L0
  L9 = L5
  L6(L7, L8, L9)
  L6 = _UPVALUE2_
  L6 = L6.write_json
  L7 = {}
  L7.code = 0
  L8 = {}
  L8.work_id = L0
  L7.meta = L8
  L6(L7)
end
start = L18
function L18(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
  L2 = _UPVALUE0_
  L3 = _UPVALUE1_
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L4 = _UPVALUE2_
  L3 = L3(L4)
  L4 = L2[A0]
  if not L4 then
    return
  end
  L4 = L3[A0]
  if L4 then
    L1 = true
  end
  L4 = require
  L5 = "xiaoqiang.common.XQFunction"
  L4 = L4(L5)
  L5 = _UPVALUE3_
  L6 = "/"
  L7 = A0
  L5 = L5 .. L6 .. L7
  L6 = L4.waitExec
  L7 = "find"
  L8 = L5
  L9 = "-name"
  L10 = "display"
  L6, L7, L8 = L6(L7, L8, L9, L10)
  L9 = nil
  L10 = {}
  for L14 in L11, L12, L13 do
    L15 = {}
    for L19 in L16, L17, L18 do
      L20 = table
      L20 = L20.insert
      L21 = L15
      L22 = L19
      L20(L21, L22)
    end
    if 0 < L16 then
      L19 = #L14
      L19 = L19 - 7
      L19 = "status"
      if L1 then
        if L18 then
          goto lbl_64
        end
      end
      ::lbl_64::
      L19 = {}
      L19.status = L18
      if L18 == 1 then
        L20 = #L15
        L20 = L20 - 2
        L9 = L15[L20]
      end
      if L18 == 2 then
        if L17 == 2 then
          L20 = _UPVALUE4_
          L21 = L16
          L22 = "score"
          L20 = L20(L21, L22)
          if L20 then
            goto lbl_82
          end
        end
        L20 = 1
        ::lbl_82::
        L19.secure = L20
        L20 = io
        L20 = L20.open
        L21 = L16
        L22 = "/enable_scan"
        L21 = L21 .. L22
        L22 = "r"
        L20 = L20(L21, L22)
        if L20 then
          L21 = 1
          if L21 then
            goto lbl_96
          end
        end
        L21 = 0
        ::lbl_96::
        L19.enable_scan = L21
        if L20 then
          L22 = L20
          L21 = L20.close
          L21(L22)
        end
      end
      L20 = #L15
      L20 = L20 - 2
      L20 = L15[L20]
      L10[L20] = L19
    end
  end
  if L1 then
    if L12 then
      goto lbl_119
    end
  end
  L14 = "/meta"
  L14 = "status"
  ::lbl_119::
  L11.status = L12
  L14 = L5
  L15 = "/meta"
  L14 = L14 .. L15
  L15 = "score"
  L11.score = L12
  L11.running = L9
  L10.meta = L11
  L14 = _UPVALUE6_
  L14, L15, L19, L20, L21, L22 = L14()
  L11(L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22)
  return L10
end
_get_status = L18
function L18()
  local L0, L1, L2, L3
  L0 = _UPVALUE0_
  L0()
  L0 = _UPVALUE1_
  L0 = L0.formvalue
  L1 = "work_id"
  L2 = nil
  L0 = L0(L1, L2)
  L1 = _get_status
  L2 = L0
  L1 = L1(L2)
  if not L1 then
    L2 = _UPVALUE1_
    L2 = L2.write_json
    L3 = {}
    L3.code = -1
    L2(L3)
    return
  end
  L1.code = 0
  L2 = _UPVALUE1_
  L2 = L2.write_json
  L3 = L1
  L2(L3)
end
get_status = L18
function L18(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = require
  L2 = "nixio"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L3 = _UPVALUE1_
  L4 = A0
  L2 = L2(L3, L4)
  L3 = L1.setenv
  L4 = "pid"
  L5 = tostring
  L6 = L2
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
  L3 = os
  L3 = L3.execute
  L4 = [[
        kill "$pid";
        while kill -0 "$pid"; do 
            kill "$pid";
            sleep 1;
        done
    ]]
  L3(L4)
end
function L19()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L0()
  L0 = _UPVALUE1_
  L0 = L0.formvalue
  L1 = "work_id"
  L2 = nil
  L0 = L0(L1, L2)
  L1 = _UPVALUE2_
  L2 = _UPVALUE3_
  L1 = L1(L2)
  L2 = _UPVALUE2_
  L3 = _UPVALUE4_
  L2 = L2(L3)
  L3 = L1[L0]
  if not L3 then
    L3 = _UPVALUE1_
    L3 = L3.write_json
    L4 = {}
    L4.code = -1
    L3(L4)
    return
  end
  L3 = L2[L0]
  if not L3 then
    L3 = _UPVALUE5_
    L4 = L0
    L3(L4)
    L3 = _UPVALUE6_
    L4 = L0
    L3(L4)
  end
  L3 = _get_status
  L4 = L0
  L3 = L3(L4)
  L3.code = 0
  L4 = _UPVALUE1_
  L4 = L4.write_json
  L5 = L3
  L4(L5)
end
stop = L19
