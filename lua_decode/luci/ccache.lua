local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
L0 = require
L1 = "io"
L0 = L0(L1)
L1 = require
L2 = "nixio.fs"
L1 = L1(L2)
L2 = require
L3 = "luci.util"
L2 = L2(L3)
L3 = require
L4 = "nixio"
L3 = L3(L4)
L4 = require
L5 = "debug"
L4 = L4(L5)
L5 = require
L6 = "string"
L5 = L5(L6)
L6 = require
L7 = "package"
L6 = L6(L7)
L7 = type
L8 = loadfile
L9 = module
L10 = "luci.ccache"
L9(L10)
function L9(...)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.getinfo
  L2 = 1
  L3 = "S"
  L1 = L1(L2, L3)
  L1 = L1.source
  if L1 ~= "=?" then
    L1 = cache_enable
    L2, L3 = ...
    L1(L2, L3)
  end
end
cache_ondemand = L9
function L9(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  A0 = A0 or A0
  A1 = A1 or A1
  L2 = _UPVALUE0_
  L2 = L2.loaders
  L2 = L2[2]
  L3 = _UPVALUE1_
  L3 = L3.getuid
  L3 = L3()
  L4 = _UPVALUE2_
  L4 = L4.stat
  L5 = A0
  L4 = L4(L5)
  if not L4 then
    L4 = _UPVALUE2_
    L4 = L4.mkdir
    L5 = A0
    L4(L5)
  end
  function L4(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9
    L1 = ""
    for L5 = L2, L3, L4 do
      L6 = L1
      L7 = _UPVALUE0_
      L7 = L7.byte
      L8 = A0
      L9 = L5
      L7 = L7(L8, L9)
      L7 = "%2X" % L7
      L1 = L6 .. L7
    end
    return L1
  end
  function L5(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L1 = L1.stat
    L2 = A0
    L1 = L1(L2)
    if L1 then
      L2 = L1.uid
      L3 = _UPVALUE1_
      if L2 == L3 then
        L2 = L1.modestr
        L3 = _UPVALUE2_
        if L2 == L3 then
          L2 = _UPVALUE3_
          L3 = A0
          return L2(L3)
        end
      end
    end
  end
  function L6(A0, A1)
    local L2, L3, L4, L5, L6
    L2 = _UPVALUE0_
    L2 = L2.getuid
    L2 = L2()
    L3 = _UPVALUE1_
    if L2 == L3 then
      L2 = _UPVALUE2_
      L2 = L2.open
      L3 = A0
      L4 = "w"
      L2 = L2(L3, L4)
      if L2 then
        L4 = L2
        L3 = L2.write
        L5 = _UPVALUE3_
        L5 = L5.get_bytecode
        L6 = A1
        L5, L6 = L5(L6)
        L3(L4, L5, L6)
        L4 = L2
        L3 = L2.close
        L3(L4)
        L3 = _UPVALUE4_
        L3 = L3.chmod
        L4 = A0
        L5 = _UPVALUE5_
        L3(L4, L5)
      end
    end
  end
  L7 = _UPVALUE0_
  L7 = L7.loaders
  function L8(A0)
    local L1, L2, L3, L4, L5
    L1 = _UPVALUE0_
    L2 = "/"
    L3 = _UPVALUE1_
    L4 = A0
    L3 = L3(L4)
    L1 = L1 .. L2 .. L3
    L2 = _UPVALUE2_
    L3 = L1
    L2 = L2(L3)
    if L2 then
      return L2
    end
    L3 = _UPVALUE3_
    L4 = A0
    L3 = L3(L4)
    L2 = L3
    L3 = _UPVALUE4_
    L4 = L2
    L3 = L3(L4)
    if L3 == "function" then
      L3 = _UPVALUE5_
      L4 = L1
      L5 = L2
      L3(L4, L5)
    end
    return L2
  end
  L7[2] = L8
end
cache_enable = L9
