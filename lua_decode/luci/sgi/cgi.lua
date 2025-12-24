local L0, L1, L2, L3
L0 = os
L0 = L0.clock
L0 = L0()
exectime = L0
L0 = module
L1 = "luci.sgi.cgi"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.ltn12"
L0 = L0(L1)
L1 = require
L2 = "nixio.util"
L1(L2)
L1 = require
L2 = "luci.http"
L1(L2)
L1 = require
L2 = "luci.sys"
L1(L2)
L1 = require
L2 = "luci.dispatcher"
L1(L2)
function L1(A0, A1)
  local L2, L3
  A1 = A1 or A1
  L2 = _UPVALUE0_
  L2 = L2.BLOCKSIZE
  function L3()
    local L0, L1, L2, L3
    L0 = _UPVALUE0_
    if L0 < 1 then
      L0 = _UPVALUE1_
      L1 = L0
      L0 = L0.close
      L0(L1)
      L0 = nil
      return L0
    else
      L0 = _UPVALUE0_
      L1 = _UPVALUE2_
      if L0 > L1 then
        L0 = _UPVALUE2_
        if L0 then
          goto lbl_18
        end
      end
      L0 = _UPVALUE0_
      ::lbl_18::
      L1 = _UPVALUE0_
      L1 = L1 - L0
      _UPVALUE0_ = L1
      L1 = _UPVALUE1_
      L2 = L1
      L1 = L1.read
      L3 = L0
      L1 = L1(L2, L3)
      if not L1 then
        L2 = _UPVALUE1_
        L3 = L2
        L2 = L2.close
        L2(L3)
      end
      return L1
    end
  end
  return L3
end
function L2()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = os
  function L2(A0)
    local L1, L2, L3, L4
    L1 = _UPVALUE0_
    L1 = L1.waitExec
    L2 = "/bin/sh"
    L3 = "-c"
    L4 = A0
    L1, L2, L3 = L1(L2, L3, L4)
    if L1 == "exited" then
      L4 = 256 * L2
      return L4
    elseif L1 == "stopped" then
      L4 = 256 * L2
      L4 = L4 + 127
      return L4
    else
      return L2
    end
  end
  L1.execute = L2
end
function L3()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = _UPVALUE0_
  L0()
  L0 = luci
  L0 = L0.http
  L0 = L0.Request
  L1 = luci
  L1 = L1.sys
  L1 = L1.getenv
  L1 = L1()
  L2 = _UPVALUE1_
  L3 = io
  L3 = L3.stdin
  L4 = tonumber
  L5 = luci
  L5 = L5.sys
  L5 = L5.getenv
  L6 = "CONTENT_LENGTH"
  L5, L6, L7, L8, L9, L10, L11, L12, L13 = L5(L6)
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13)
  L3 = _UPVALUE2_
  L3 = L3.sink
  L3 = L3.file
  L4 = io
  L4 = L4.stderr
  L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13 = L3(L4)
  L0 = L0(L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13)
  L1 = coroutine
  L1 = L1.create
  L2 = luci
  L2 = L2.dispatcher
  L2 = L2.httpdispatch
  L1 = L1(L2)
  L2 = ""
  L3 = true
  while true do
    L4 = coroutine
    L4 = L4.status
    L5 = L1
    L4 = L4(L5)
    if L4 == "dead" then
      break
    end
    L4 = coroutine
    L4 = L4.resume
    L5 = L1
    L6 = L0
    L4, L5, L6, L7 = L4(L5, L6)
    if not L4 then
      L8 = print
      L9 = "Status: 500 Internal Server Error"
      L8(L9)
      L8 = print
      L9 = "Content-Type: text/plain\n"
      L8(L9)
      L8 = print
      L9 = L5
      L8(L9)
      break
    end
    if L3 then
      if L5 == 1 then
        L8 = io
        L8 = L8.write
        L9 = "Status: "
        L10 = tostring
        L11 = L6
        L10 = L10(L11)
        L11 = " "
        L12 = L7
        L13 = "\r\n"
        L9 = L9 .. L10 .. L11 .. L12 .. L13
        L8(L9)
      elseif L5 == 2 then
        L8 = L2
        L9 = L6
        L10 = ": "
        L11 = L7
        L12 = "\r\n"
        L2 = L8 .. L9 .. L10 .. L11 .. L12
      elseif L5 == 3 then
        L8 = io
        L8 = L8.write
        L9 = L2
        L8(L9)
        L8 = io
        L8 = L8.write
        L9 = "\r\n"
        L8(L9)
      elseif L5 == 4 then
        L8 = io
        L8 = L8.write
        L9 = tostring
        L10 = L6 or L10
        if not L6 then
          L10 = ""
        end
        L9, L10, L11, L12, L13 = L9(L10)
        L8(L9, L10, L11, L12, L13)
      elseif L5 == 5 then
        L8 = io
        L8 = L8.flush
        L8()
        L8 = io
        L8 = L8.close
        L8()
        L3 = false
      elseif L5 == 6 then
        L9 = L6
        L8 = L6.copyz
        L10 = nixio
        L10 = L10.stdout
        L11 = L7
        L8(L9, L10, L11)
        L9 = L6
        L8 = L6.close
        L8(L9)
      end
    end
  end
end
run = L3
