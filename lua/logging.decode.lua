local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
L0 = type
L1 = table
L2 = string
L3 = tostring
L4 = tonumber
L5 = select
L6 = error
L7 = L2.format
L8 = pairs
L9 = ipairs
L10 = {}
L10._COPYRIGHT = "Copyright (C) 2004-2013 Kepler Project"
L10._DESCRIPTION = "A simple API to use logging features in Lua"
L10._VERSION = "LuaLogging 1.3.0"
L10.DEBUG = "DEBUG"
L10.INFO = "INFO"
L10.WARN = "WARN"
L10.ERROR = "ERROR"
L10.FATAL = "FATAL"
L11 = {}
L12 = "DEBUG"
L11[1] = L12
L11[2] = L13
L11[3] = L14
L11[4] = L15
L11[5] = L16
L12 = #L11
for L16 = L13, L14, L15 do
  L11[L17] = L16
end
for L18 = L15, L16, L17 do
  L19 = L11[L18]
  function L20(A0, ...)
    local L2, L3, L4, L5
    L2 = _UPVALUE0_
    L3 = A0
    L4 = _UPVALUE1_
    L5 = ...
    return L2(L3, L4, L5)
  end
  L14[L18] = L20
end
L10.new = L17
L10.prepareLogMsg = L17
L10.tostring = L17
L18 = _VERSION
if L18 ~= "Lua 5.2" then
  L18 = _G
  L18.logging = L10
end
return L10
