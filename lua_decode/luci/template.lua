local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "luci.config"
L1 = L1(L2)
L2 = require
L3 = "luci.template.parser"
L2 = L2(L3)
L3 = tostring
L4 = pairs
L5 = loadstring
L6 = setmetatable
L7 = loadfile
L8 = getfenv
L9 = setfenv
L10 = rawget
L11 = assert
L12 = type
L13 = error
L14 = module
L15 = "luci.template"
L14(L15)
L14 = L1.template
L14 = L14 or L14
L1.template = L14
L14 = L1.template
L14 = L14.viewdir
if not L14 then
  L14 = L0.libpath
  L14 = L14()
  L15 = "/view"
  L14 = L14 .. L15
end
viewdir = L14
L14 = L0.threadlocal
L14 = L14()
context = L14
function L14(A0, A1)
  local L2, L3, L4, L5
  L2 = Template
  L3 = A0
  L2 = L2(L3)
  L3 = L2
  L2 = L2.render
  L4 = A1 or L4
  if not A1 then
    L4 = _UPVALUE0_
    L5 = 2
    L4 = L4(L5)
  end
  return L2(L3, L4)
end
render = L14
L14 = L0.class
L14 = L14()
Template = L14
L14 = Template
L15 = L6
L16 = {}
L17 = {}
L17.__mode = "v"
L15 = L15(L16, L17)
L14.cache = L15
L14 = Template
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = A0.cache
  L2 = L2[A1]
  A0.template = L2
  A0.name = A1
  L2 = context
  L2 = L2.viewns
  A0.viewns = L2
  L2 = A0.template
  if not L2 then
    L2 = nil
    L3 = viewdir
    L4 = "/"
    L5 = A1
    L6 = ".htm"
    L3 = L3 .. L4 .. L5 .. L6
    L4 = _UPVALUE0_
    L4 = L4.parse
    L5 = L3
    L4, L5, L6 = L4(L5)
    L2 = L6
    _ = L5
    A0.template = L4
    L4 = A0.template
    if not L4 then
      L4 = _UPVALUE1_
      L5 = "Failed to load template '"
      L6 = A1
      L7 = "'.\n"
      L8 = "Error while parsing template '"
      L9 = L3
      L10 = "':\n"
      L11 = L2 or L11
      if not L2 then
        L11 = "Unknown syntax error"
      end
      L5 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
      L4(L5)
    else
      L4 = A0.cache
      L5 = A0.template
      L4[A1] = L5
    end
  end
end
L14.__init__ = L15
L14 = Template
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  if not A1 then
    L2 = _UPVALUE0_
    L3 = 2
    L2 = L2(L3)
    A1 = L2
  end
  L2 = _UPVALUE1_
  L3 = A0.template
  L4 = _UPVALUE2_
  L5 = {}
  L6 = {}
  function L7(A0, A1)
    local L2, L3, L4
    L2 = _UPVALUE0_
    L3 = A0
    L4 = A1
    L2 = L2(L3, L4)
    if not L2 then
      L2 = _UPVALUE1_
      L2 = L2.viewns
      L2 = L2[A1]
      if not L2 then
        L2 = _UPVALUE2_
        L2 = L2[A1]
      end
    end
    return L2
  end
  L6.__index = L7
  L4, L5, L6, L7, L8, L9, L10 = L4(L5, L6)
  L2(L3, L4, L5, L6, L7, L8, L9, L10)
  L2 = _UPVALUE4_
  L2 = L2.copcall
  L3 = A0.template
  L2, L3 = L2(L3)
  if not L2 then
    L4 = _UPVALUE5_
    L5 = "Failed to execute template '"
    L6 = A0.name
    L7 = "'.\n"
    L8 = "A runtime error occured: "
    L9 = _UPVALUE6_
    L10 = L3 or L10
    if not L3 then
      L10 = "(nil)"
    end
    L9 = L9(L10)
    L5 = L5 .. L6 .. L7 .. L8 .. L9
    L4(L5)
  end
end
L14.render = L15
