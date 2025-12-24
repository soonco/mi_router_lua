local L0, L1, L2
L0 = module
L1 = "luci.i18n"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0(L1)
L0 = require
L1 = "luci.template.parser"
L0 = L0(L1)
L1 = {}
table = L1
L1 = luci
L1 = L1.util
L1 = L1.libpath
L1 = L1()
L2 = "/i18n/"
L1 = L1 .. L2
i18ndir = L1
L1 = {}
loaded = L1
L1 = luci
L1 = L1.util
L1 = L1.threadlocal
L1 = L1()
context = L1
L1 = "en"
default = L1
function L1()
  local L0, L1
end
clear = L1
function L1(A0, A1, A2)
end
load = L1
function L1(A0, A1)
end
loadc = L1
function L1(A0)
  local L1, L2, L3, L4, L5
  L1 = context
  L3 = A0
  L2 = A0.gsub
  L4 = "_"
  L5 = "-"
  L2 = L2(L3, L4, L5)
  L1.lang = L2
  L1 = context
  L2 = context
  L2 = L2.lang
  L3 = L2
  L2 = L2.match
  L4 = "^([a-z][a-z])_"
  L2 = L2(L3, L4)
  L1.parent = L2
  L1 = _UPVALUE0_
  L1 = L1.load_catalog
  L2 = context
  L2 = L2.lang
  L3 = i18ndir
  L1 = L1(L2, L3)
  if not L1 then
    L1 = context
    L1 = L1.parent
    if L1 then
      L1 = _UPVALUE0_
      L1 = L1.load_catalog
      L2 = context
      L2 = L2.parent
      L3 = i18ndir
      L1(L2, L3)
      L1 = context
      L1 = L1.parent
      return L1
    end
  end
  L1 = context
  L1 = L1.lang
  return L1
end
setlanguage = L1
function L1(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.translate
  L2 = A0
  L1 = L1(L2)
  L1 = L1 or L1
  return L1
end
translate = L1
function L1(A0, ...)
  local L2, L3, L4
  L2 = tostring
  L3 = translate
  L4 = A0
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L3 = L2
  L2 = L2.format
  L4 = ...
  return L2(L3, L4)
end
translatef = L1
function L1(A0)
  local L1, L2, L3
  L1 = tostring
  L2 = translate
  L3 = A0
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
string = L1
function L1(A0, ...)
  local L2, L3, L4
  L2 = tostring
  L3 = translate
  L4 = A0
  L3, L4 = L3(L4)
  L2 = L2(L3, L4)
  L3 = L2
  L2 = L2.format
  L4 = ...
  return L2(L3, L4)
end
stringf = L1
