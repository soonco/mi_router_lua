local L0, L1, L2
L0 = module
L1 = "xiaoqiang.XQStatPoints"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "posix"
L0 = L0(L1)
function L1(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L2 = L2.openlog
  L3 = "sp_lib"
  L4 = _UPVALUE0_
  L4 = L4.LOG_NDELAY
  L5 = _UPVALUE0_
  L5 = L5.LOG_LOCAL1
  L2(L3, L4, L5)
  L2 = _UPVALUE0_
  L2 = L2.syslog
  L3 = _UPVALUE0_
  L3 = L3.LOG_INFO
  L4 = tostring
  L5 = A0
  L4 = L4(L5)
  L5 = "="
  L6 = tostring
  L7 = A1
  L6 = L6(L7)
  L4 = L4 .. L5 .. L6
  L2(L3, L4)
  L2 = _UPVALUE0_
  L2 = L2.closelog
  L2()
end
Log = L1
function L1(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11
  L4 = "/usr/bin/sp_log_info.sh"
  if A0 and A1 then
    L5 = L4
    L6 = " -k "
    L7 = A0
    L8 = " -m "
    L9 = string
    L9 = L9.format
    L10 = "\"%s\""
    L11 = A1
    L9 = L9(L10, L11)
    L4 = L5 .. L6 .. L7 .. L8 .. L9
    if A2 then
      L5 = L4
      L6 = " -f "
      L7 = A2
      L4 = L5 .. L6 .. L7
      if A3 then
        L5 = L4
        L6 = " -l "
        L7 = A3
        L4 = L5 .. L6 .. L7
      end
    end
    L5 = luci
    L5 = L5.util
    L5 = L5.exec
    L6 = L4
    L5(L6)
  end
end
LogToFile = L1
