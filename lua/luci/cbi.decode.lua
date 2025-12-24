local L0, L1, L2, L3, L4, L5, L6, L7, L8
L0 = module
L1 = "luci.cbi"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.template"
L0(L1)
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "luci.http"
L1(L2)
L1 = require
L2 = "nixio.fs"
L1 = L1(L2)
L2 = require
L3 = "luci.model.uci"
L2 = L2(L3)
L3 = require
L4 = "luci.cbi.datatypes"
L3 = L3(L4)
L4 = L0.class
L5 = L0.instanceof
L6 = 0
FORM_NODATA = L6
L6 = 0
FORM_PROCEED = L6
L6 = 1
FORM_VALID = L6
L6 = 1
FORM_DONE = L6
L6 = -1
FORM_INVALID = L6
L6 = 2
FORM_CHANGED = L6
L6 = 4
FORM_SKIP = L6
L6 = true
AUTO = L6
L6 = "cbi.cts."
CREATE_PREFIX = L6
L6 = "cbi.rts."
REMOVE_PREFIX = L6
L6 = "cbi.sts."
RESORT_PREFIX = L6
L6 = "cbi.cbe."
FEXIST_PREFIX = L6
function L6(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26
  L2 = require
  L3 = "nixio.fs"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.i18n"
  L3 = L3(L4)
  L4 = require
  L5 = "luci.config"
  L4(L5)
  L4 = require
  L5 = "luci.util"
  L4(L5)
  L4 = "/lib/uci/upload/"
  L5 = luci
  L5 = L5.util
  L5 = L5.libpath
  L5 = L5()
  L6 = "/model/cbi/"
  L5 = L5 .. L6
  L6, L7 = nil, nil
  L8 = L2.access
  L9 = L5
  L10 = A0
  L11 = ".lua"
  L9 = L9 .. L10 .. L11
  L8 = L8(L9)
  if L8 then
    L8 = loadfile
    L9 = L5
    L10 = A0
    L11 = ".lua"
    L9 = L9 .. L10 .. L11
    L8, L9 = L8(L9)
    L7 = L9
    L6 = L8
  else
    L8 = L2.access
    L9 = A0
    L8 = L8(L9)
    if L8 then
      L8 = loadfile
      L9 = A0
      L8, L9 = L8(L9)
      L7 = L9
      L6 = L8
    else
      L8 = nil
      L9 = "Model '"
      L10 = A0
      L11 = "' not found!"
      L7 = L9 .. L10 .. L11
      L6 = L8
    end
  end
  L8 = assert
  L9 = L6
  L10 = L7
  L8(L9, L10)
  L8 = {}
  L9 = L3.translate
  L8.translate = L9
  L9 = L3.translatef
  L8.translatef = L9
  L9 = {}
  L10, L11, L15, L16, L20, L21, L22, L23, L24, L25, L26 = ...
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L9[4] = L13
  L9[5] = L14
  L9[6] = L15
  L9[7] = L16
  L9[8] = L17
  L9[9] = L18
  L9[10] = L19
  L9[11] = L20
  L9[12] = L21
  L9[13] = L22
  L9[14] = L23
  L9[15] = L24
  L9[16] = L25
  L9[17] = L26
  L8.arg = L9
  L9 = setfenv
  L10 = L6
  L11 = setmetatable
  L13.__index = L14
  L11, L15, L16, L20, L21, L22, L23, L24, L25, L26 = L11(L12, L13)
  L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26)
  L9 = {}
  L10 = L6
  L10, L11, L15, L16, L20, L21, L22, L23, L24, L25, L26 = L10()
  L9[1] = L10
  L9[2] = L11
  L9[3] = L12
  L9[4] = L13
  L9[5] = L14
  L9[6] = L15
  L9[7] = L16
  L9[8] = L17
  L9[9] = L18
  L9[10] = L19
  L9[11] = L20
  L9[12] = L21
  L9[13] = L22
  L9[14] = L23
  L9[15] = L24
  L9[16] = L25
  L9[17] = L26
  L10 = {}
  L11 = false
  for L15, L16 in L12, L13, L14 do
    if not L17 then
      L17(L18)
      return L17
    else
      L17(L18)
      if L17 then
        L11 = true
        for L20, L21 in L17, L18, L19 do
          L22 = L21.config
          L23 = "."
          L24 = L21.section
          L24 = L24.sectiontype
          L24 = L24 or L24
          L25 = "."
          L26 = L21.option
          L22 = L22 .. L23 .. L24 .. L25 .. L26
          L10[L22] = true
        end
      end
    end
  end
  if L11 then
    L15 = nil
    L16 = luci
    L16 = L16.http
    L16 = L16.setfilehandler
    L16(L17)
  end
  return L9
end
load = L6
L6 = {}
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L2 = 0
  L3 = false
  L4 = 0
  L5 = {}
  for L9 = L6, L7, L8 do
    L11 = A0
    L10 = A0.byte
    L12 = L9
    L10 = L10(L11, L12)
    L10 = L10 or L10
    if L3 then
      L3 = false
    elseif L10 == 92 then
      L3 = true
    elseif L10 == 40 or L10 == 44 then
      if L4 <= 0 then
        if L9 > L2 then
          L12 = A0
          L11 = A0.sub
          L13 = L2
          L14 = L9 - 1
          L11 = L11(L12, L13, L14)
          L12 = L11
          L11 = L11.gsub
          L13 = "\\(.)"
          L14 = "%1"
          L11 = L11(L12, L13, L14)
          L12 = L11
          L11 = L11.gsub
          L13 = "^%s+"
          L14 = ""
          L11 = L11(L12, L13, L14)
          L12 = L11
          L11 = L11.gsub
          L13 = "%s+$"
          L14 = ""
          L11 = L11(L12, L13, L14)
          L12 = #L11
          if 0 < L12 then
            L12 = tonumber
            L13 = L11
            L12 = L12(L13)
            if L12 then
              L12 = #L5
              L12 = L12 + 1
              L13 = tonumber
              L14 = L11
              L13 = L13(L14)
              L5[L12] = L13
          end
          else
            L13 = L11
            L12 = L11.match
            L14 = "^'.*'$"
            L12 = L12(L13, L14)
            if not L12 then
              L13 = L11
              L12 = L11.match
              L14 = "^\".*\"$"
              L12 = L12(L13, L14)
              if not L12 then
                goto lbl_81
              end
            end
            L12 = #L5
            L12 = L12 + 1
            L14 = L11
            L13 = L11.gsub
            L15 = "[\"'](.*)[\"']"
            L16 = "%1"
            L13 = L13(L14, L15, L16)
            L5[L12] = L13
            goto lbl_100
            ::lbl_81::
            L12 = type
            L13 = _UPVALUE0_
            L13 = L13[L11]
            L12 = L12(L13)
            if L12 == "function" then
              L12 = #L5
              L12 = L12 + 1
              L13 = _UPVALUE0_
              L13 = L13[L11]
              L5[L12] = L13
              L12 = #L5
              L12 = L12 + 1
              L13 = {}
              L5[L12] = L13
            else
              L12 = error
              L13 = "Datatype error, bad token %q" % L11
              L12(L13)
            end
          end
        end
        ::lbl_100::
        L2 = L9 + 1
      end
      if L10 == 40 then
        L11 = 1
        if L11 then
          goto lbl_107
        end
      end
      L11 = 0
      ::lbl_107::
      L4 = L4 + L11
    elseif L10 == 41 then
      L4 = L4 - 1
      if L4 <= 0 then
        L11 = type
        L12 = #L5
        L12 = L12 - 1
        L12 = L5[L12]
        L11 = L11(L12)
        if L11 ~= "function" then
          L11 = error
          L12 = "Datatype error, argument list follows non-function"
          L11(L12)
        end
        L11 = #L5
        L12 = compile_datatype
        L14 = A0
        L13 = A0.sub
        L15 = L2
        L16 = L9 - 1
        L13, L14, L15, L16 = L13(L14, L15, L16)
        L12 = L12(L13, L14, L15, L16)
        L5[L11] = L12
        L2 = L9 + 1
      end
    end
  end
  return L5
end
compile_datatype = L7
function L7(A0, A1)
  local L2, L3, L4, L5
  if A0 then
    L2 = #A0
    if 0 < L2 then
      L2 = _UPVALUE0_
      L2 = L2[A0]
      if not L2 then
        L2 = compile_datatype
        L3 = A0
        L2 = L2(L3)
        if L2 then
          L3 = type
          L4 = L2[1]
          L3 = L3(L4)
          if L3 == "function" then
            L3 = _UPVALUE0_
            L3[A0] = L2
        end
        else
          L3 = error
          L4 = "Datatype error, not a function expression"
          L3(L4)
        end
      end
      L2 = _UPVALUE0_
      L2 = L2[A0]
      if L2 then
        L2 = _UPVALUE0_
        L2 = L2[A0]
        L2 = L2[1]
        L3 = A1
        L4 = unpack
        L5 = _UPVALUE0_
        L5 = L5[A0]
        L5 = L5[2]
        L4, L5 = L4(L5)
        return L2(L3, L4, L5)
      end
    end
  end
  L2 = true
  return L2
end
verify_datatype = L7
L7 = L4
L7 = L7()
Node = L7
L7 = Node
function L8(A0, A1, A2)
  local L3
  L3 = {}
  A0.children = L3
  L3 = A1 or L3
  if not A1 then
    L3 = ""
  end
  A0.title = L3
  L3 = A2 or L3
  if not A2 then
    L3 = ""
  end
  A0.description = L3
  A0.template = "cbi/node"
end
L7.__init__ = L8
L7 = Node
function L8(A0, A1)
  local L2, L3
  L2 = type
  L3 = A0[A1]
  L2 = L2(L3)
  if L2 == "function" then
    L2 = A0[A1]
    L3 = A0
    return L2(L3)
  end
end
L7._run_hook = L8
L7 = Node
function L8(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L3 = false
  for L7, L8 in L4, L5, L6 do
    L9 = type
    L10 = A0[L8]
    L9 = L9(L10)
    if L9 == "function" then
      L9 = A0[L8]
      L10 = A0
      L9(L10)
      L3 = true
    end
  end
  return L3
end
L7._run_hooks = L8
L7 = Node
function L8(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9
  for L5, L6 in L2, L3, L4 do
    L8 = L6
    L7 = L6.prepare
    L9 = ...
    L7(L8, L9)
  end
end
L7.prepare = L8
L7 = Node
function L8(A0, A1)
  local L2, L3, L4
  L2 = table
  L2 = L2.insert
  L3 = A0.children
  L4 = A1
  L2(L3, L4)
end
L7.append = L8
L7 = Node
function L8(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9
  for L5, L6 in L2, L3, L4 do
    L8 = L6
    L7 = L6.parse
    L9 = ...
    L7(L8, L9)
  end
end
L7.parse = L8
L7 = Node
function L8(A0, A1)
  local L2, L3, L4
  if not A1 then
    L2 = {}
    A1 = L2
  end
  A1.self = A0
  L2 = luci
  L2 = L2.template
  L2 = L2.render
  L3 = A0.template
  L4 = A1
  L2(L3, L4)
end
L7.render = L8
L7 = Node
function L8(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  for L7, L8 in L4, L5, L6 do
    L9 = A0.children
    L9 = #L9
    L9 = L7 == L9
    L8.last_child = L9
    L10 = L8
    L9 = L8.render
    L11 = ...
    L9(L10, L11)
  end
end
L7.render_children = L8
L7 = L4
L8 = Node
L7 = L7(L8)
Template = L7
L7 = Template
function L8(A0, A1)
  local L2, L3
  L2 = Node
  L2 = L2.__init__
  L3 = A0
  L2(L3)
  A0.template = A1
end
L7.__init__ = L8
L7 = Template
function L8(A0)
  local L1, L2, L3
  L1 = luci
  L1 = L1.template
  L1 = L1.render
  L2 = A0.template
  L3 = {}
  L3.self = A0
  L1(L2, L3)
end
L7.render = L8
L7 = Template
function L8(A0, A1)
  local L2, L3, L4
  L2 = A1 ~= false
  A0.readinput = L2
  L2 = Map
  L2 = L2.formvalue
  L3 = A0
  L4 = "cbi.submit"
  L2 = L2(L3, L4)
  if L2 then
    L2 = FORM_DONE
    if L2 then
      goto lbl_17
    end
  end
  L2 = FORM_NODATA
  ::lbl_17::
  return L2
end
L7.parse = L8
L7 = L4
L8 = Node
L7 = L7(L8)
Map = L7
L7 = Map
function L8(A0, A1, ...)
  local L3, L4, L5
  L3 = Node
  L3 = L3.__init__
  L4 = A0
  L5 = ...
  L3(L4, L5)
  A0.config = A1
  L3 = {}
  L4 = A0.config
  L3[1] = L4
  A0.parsechain = L3
  A0.template = "cbi/map"
  A0.apply_on_parse = nil
  A0.readinput = true
  A0.proceed = false
  L3 = {}
  A0.flow = L3
  L3 = _UPVALUE0_
  L3 = L3.cursor
  L3 = L3()
  A0.uci = L3
  A0.save = true
  A0.changed = false
  L3 = A0.uci
  L4 = L3
  L3 = L3.load
  L5 = A0.config
  L3 = L3(L4, L5)
  if not L3 then
    L3 = error
    L4 = "Unable to read UCI data: "
    L5 = A0.config
    L4 = L4 .. L5
    L3(L4)
  end
end
L7.__init__ = L8
L7 = Map
function L8(A0, A1)
  local L2, L3
  L2 = A0.readinput
  if L2 then
    L2 = luci
    L2 = L2.http
    L2 = L2.formvalue
    L3 = A1
    L2 = L2(L3)
  end
  return L2
end
L7.formvalue = L8
L7 = Map
function L8(A0, A1)
  local L2, L3
  L2 = A0.readinput
  if L2 then
    L2 = luci
    L2 = L2.http
    L2 = L2.formvaluetable
    L3 = A1
    L2 = L2(L3)
    if L2 then
      goto lbl_12
    end
  end
  L2 = {}
  ::lbl_12::
  return L2
end
L7.formvaluetable = L8
L7 = Map
function L8(A0, A1, A2)
  local L3
  if not A2 then
    L3 = A0.scheme
    if L3 then
      L3 = A0.scheme
      L3 = L3.sections
      L3 = L3[A1]
    end
    return L3
  else
    L3 = A0.scheme
    if L3 then
      L3 = A0.scheme
      L3 = L3.variables
      L3 = L3[A1]
      if L3 then
        L3 = A0.scheme
        L3 = L3.variables
        L3 = L3[A1]
        L3 = L3[A2]
      end
    end
    return L3
  end
end
L7.get_scheme = L8
L7 = Map
function L8(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.formvalue
  L3 = "cbi.submit"
  return L1(L2, L3)
end
L7.submitstate = L8
L7 = Map
function L8(A0, A1)
  local L2, L3, L4
  L2 = table
  L2 = L2.insert
  L3 = A0.parsechain
  L4 = A1
  L2(L3, L4)
end
L7.chain = L8
L7 = Map
function L8(A0, A1)
  return A1
end
L7.state_handler = L8
L7 = Map
function L8(A0, A1, ...)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = A1 ~= false
  A0.readinput = L3
  L3(L4, L5)
  if L3 then
    A0.state = L3
    return L3(L4, L5)
  end
  L6, L7, L8, L9, L10 = ...
  L3(L4, L5, L6, L7, L8, L9, L10)
  if L3 then
    L6 = "on_before_save"
    L3(L4, L5, L6)
    for L6, L7 in L3, L4, L5 do
      L8 = A0.uci
      L9 = L8
      L8 = L8.save
      L10 = L7
      L8(L9, L10)
    end
    L3(L4, L5)
    if L3 then
      if not L3 then
        if L3 then
          goto lbl_63
        end
      end
      ::lbl_63::
      if L3 then
        L3(L4, L5)
        for L6, L7 in L3, L4, L5 do
          L8 = A0.uci
          L9 = L8
          L8 = L8.commit
          L10 = L7
          L8(L9, L10)
          L8 = A0.uci
          L9 = L8
          L8 = L8.load
          L10 = L7
          L8(L9, L10)
        end
        L6 = "on_after_commit"
        L7 = "on_before_apply"
        L3(L4, L5, L6, L7)
        if L3 then
          L3(L4, L5)
          L6 = "on_after_apply"
          L3(L4, L5, L6)
        else
          A0.apply_needed = true
        end
        L3(L4, L5)
      end
    end
    for L6, L7 in L3, L4, L5 do
      L8 = A0.uci
      L9 = L8
      L8 = L8.unload
      L10 = L7
      L8(L9, L10)
    end
    if L3 == "function" then
      L6 = A0
      L6, L7, L8, L9, L10 = L5(L6)
      L3(L4, L5, L6, L7, L8, L9, L10)
    end
  end
  if L3 then
    if not L3 then
      A0.state = L3
    elseif L3 then
      A0.state = L3
    else
      if L3 then
        if L3 then
          goto lbl_145
        end
      end
      ::lbl_145::
      A0.state = L3
    end
  else
    A0.state = L3
  end
  return L3(L4, L5)
end
L7.parse = L8
L7 = Map
function L8(A0, ...)
  local L2, L3, L4
  L3 = A0
  L2 = A0._run_hooks
  L4 = "on_init"
  L2(L3, L4)
  L2 = Node
  L2 = L2.render
  L3 = A0
  L4 = ...
  L2(L3, L4)
end
L7.render = L8
L7 = Map
function L8(A0, A1, ...)
  local L3, L4, L5, L6
  L3 = _UPVALUE0_
  L4 = A1
  L5 = AbstractSection
  L3 = L3(L4, L5)
  if L3 then
    L3 = A1
    L4 = A0
    L5, L6 = ...
    L3 = L3(L4, L5, L6)
    L5 = A0
    L4 = A0.append
    L6 = L3
    L4(L5, L6)
    return L3
  else
    L3 = error
    L4 = "class must be a descendent of AbstractSection"
    L3(L4)
  end
end
L7.section = L8
L7 = Map
function L8(A0, A1)
  local L2, L3, L4, L5
  L2 = A0.uci
  L3 = L2
  L2 = L2.add
  L4 = A0.config
  L5 = A1
  return L2(L3, L4, L5)
end
L7.add = L8
L7 = Map
function L8(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  L4 = type
  L5 = A3
  L4 = L4(L5)
  if L4 == "table" then
    L4 = #A3
    if not (0 < L4) then
      goto lbl_28
    end
  end
  if A2 then
    L4 = A0.uci
    L5 = L4
    L4 = L4.set
    L6 = A0.config
    L7 = A1
    L8 = A2
    L9 = A3
    return L4(L5, L6, L7, L8, L9)
  else
    L4 = A0.uci
    L5 = L4
    L4 = L4.set
    L6 = A0.config
    L7 = A1
    L8 = A3
    do return L4(L5, L6, L7, L8) end
    goto lbl_35
    ::lbl_28::
    L4 = Map
    L4 = L4.del
    L5 = A0
    L6 = A1
    L7 = A2
    return L4(L5, L6, L7)
  end
  ::lbl_35::
end
L7.set = L8
L7 = Map
function L8(A0, A1, A2)
  local L3, L4, L5, L6, L7
  if A2 then
    L3 = A0.uci
    L4 = L3
    L3 = L3.delete
    L5 = A0.config
    L6 = A1
    L7 = A2
    return L3(L4, L5, L6, L7)
  else
    L3 = A0.uci
    L4 = L3
    L3 = L3.delete
    L5 = A0.config
    L6 = A1
    return L3(L4, L5, L6)
  end
end
L7.del = L8
L7 = Map
function L8(A0, A1, A2)
  local L3, L4, L5, L6, L7
  if not A1 then
    L3 = A0.uci
    L4 = L3
    L3 = L3.get_all
    L5 = A0.config
    return L3(L4, L5)
  elseif A2 then
    L3 = A0.uci
    L4 = L3
    L3 = L3.get
    L5 = A0.config
    L6 = A1
    L7 = A2
    return L3(L4, L5, L6, L7)
  else
    L3 = A0.uci
    L4 = L3
    L3 = L3.get_all
    L5 = A0.config
    L6 = A1
    return L3(L4, L5, L6)
  end
end
L7.get = L8
L7 = L4
L8 = Node
L7 = L7(L8)
Compound = L7
L7 = Compound
function L8(A0, ...)
  local L2, L3
  L2 = Node
  L2 = L2.__init__
  L3 = A0
  L2(L3)
  A0.template = "cbi/compound"
  L2 = {}
  L3 = ...
  L2[1] = L3
  A0.children = L2
end
L7.__init__ = L8
L7 = Compound
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7
  for L5, L6 in L2, L3, L4 do
    L6.delegator = A1
  end
end
L7.populate_delegator = L8
L7 = Compound
function L8(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = 0
  L3 = nil
  for L7, L8 in L4, L5, L6 do
    L10 = L8
    L9 = L8.parse
    L11 = ...
    L9 = L9(L10, L11)
    L2 = L9
    L3 = L2 or L3
    if not (not L3 or L3 > L2) or not L2 then
    end
  end
  return L3
end
L7.parse = L8
L7 = L4
L8 = Node
L7 = L7(L8)
Delegator = L7
L7 = Delegator
function L8(A0, ...)
  local L2, L3, L4
  L2 = Node
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  L2 = {}
  A0.nodes = L2
  L2 = {}
  A0.defaultpath = L2
  A0.pageaction = false
  A0.readinput = true
  A0.allow_reset = false
  A0.allow_cancel = false
  A0.allow_back = false
  A0.allow_finish = false
  A0.template = "cbi/delegator"
end
L7.__init__ = L8
L7 = Delegator
function L8(A0, A1, A2)
  local L3, L4, L5
  L3 = assert
  L4 = A0.nodes
  L4 = L4[A1]
  L4 = not L4
  L5 = "Duplicate entry"
  L3(L4, L5)
  L3 = A0.nodes
  L3[A1] = A2
end
L7.set = L8
L7 = Delegator
function L8(A0, A1, A2)
  local L3, L4, L5, L6
  L4 = A0
  L3 = A0.set
  L5 = A1
  L6 = A2
  L3 = L3(L4, L5, L6)
  A2 = L3
  L3 = A0.defaultpath
  L4 = A0.defaultpath
  L4 = #L4
  L4 = L4 + 1
  L3[L4] = A1
end
L7.add = L8
L7 = Delegator
function L8(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9
  L3 = A0.chain
  L3 = #L3
  L3 = L3 + 1
  for L7, L8 in L4, L5, L6 do
    if L8 == A2 then
      L3 = L7 + 1
      break
    end
  end
  L7 = A1
  L4(L5, L6, L7)
end
L7.insert_after = L8
L7 = Delegator
function L8(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = 0
  L3 = A0.chain
  L4 = {}
  L8, L9, L10 = ...
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  L4[5] = L9
  L4[6] = L10
  for L8 = L5, L6, L7 do
    L9 = L3[L8]
    L10 = A0.current
    if L9 == L10 then
      L2 = L8
      break
    end
  end
  for L8 = L5, L6, L7 do
    L2 = L2 + 1
    L9 = L4[L8]
    L3[L2] = L9
  end
  for L8 = L5, L6, L7 do
    L3[L8] = nil
  end
end
L7.set_route = L8
L7 = Delegator
function L8(A0, A1)
  local L2, L3, L4, L5
  L2 = A0.nodes
  L2 = L2[A1]
  L3 = type
  L4 = L2
  L3 = L3(L4)
  if L3 == "string" then
    L3 = load
    L4 = L2
    L5 = A1
    L3 = L3(L4, L5)
    L2 = L3
  end
  L3 = type
  L4 = L2
  L3 = L3(L4)
  if L3 == "table" then
    L3 = getmetatable
    L4 = L2
    L3 = L3(L4)
    if L3 == nil then
      L3 = Compound
      L4 = unpack
      L5 = L2
      L4, L5 = L4(L5)
      L3 = L3(L4, L5)
      L2 = L3
    end
  end
  return L2
end
L7.get = L8
L7 = Delegator
function L8(A0, ...)
  local L2, L3, L4, L5, L6, L7
  L2 = A0.allow_cancel
  if L2 then
    L2 = Map
    L2 = L2.formvalue
    L3 = A0
    L4 = "cbi.cancel"
    L2 = L2(L3, L4)
    if L2 then
      L3 = A0
      L2 = A0._run_hooks
      L4 = "on_cancel"
      L2 = L2(L3, L4)
      if L2 then
        L2 = FORM_DONE
        return L2
      end
    end
  end
  L2 = Map
  L2 = L2.formvalue
  L3 = A0
  L4 = "cbi.delg.current"
  L2 = L2(L3, L4)
  if not L2 then
    L3 = A0
    L2 = A0._run_hooks
    L4 = "on_init"
    L2(L3, L4)
  end
  L2 = nil
  L3 = A0.chain
  if not L3 then
    L4 = A0
    L3 = A0.get_chain
    L3 = L3(L4)
  end
  A0.chain = L3
  L3 = A0.current
  if not L3 then
    L4 = A0
    L3 = A0.get_active
    L3 = L3(L4)
  end
  A0.current = L3
  L3 = A0.active
  if not L3 then
    L4 = A0
    L3 = A0.get
    L5 = A0.current
    L3 = L3(L4, L5)
  end
  A0.active = L3
  L3 = assert
  L4 = A0.active
  L5 = "Invalid state"
  L3(L4, L5)
  L3 = FORM_DONE
  L4 = type
  L5 = A0.active
  L4 = L4(L5)
  if L4 ~= "function" then
    L4 = A0.active
    L5 = L4
    L4 = L4.populate_delegator
    L6 = A0
    L4(L5, L6)
    L4 = A0.active
    L5 = L4
    L4 = L4.parse
    L4 = L4(L5)
    L3 = L4
  else
    L5 = A0
    L4 = A0.active
    L4(L5)
  end
  L4 = FORM_PROCEED
  if L3 > L4 then
    L4 = Map
    L4 = L4.formvalue
    L5 = A0
    L6 = "cbi.delg.back"
    L4 = L4(L5, L6)
    if L4 then
      L5 = A0
      L4 = A0.get_prev
      L6 = A0.current
      L4 = L4(L5, L6)
      L2 = L4
    else
      L5 = A0
      L4 = A0.get_next
      L6 = A0.current
      L4 = L4(L5, L6)
      L2 = L4
    end
  else
    L4 = FORM_PROCEED
    if L3 < L4 then
      return L3
    end
  end
  L4 = Map
  L4 = L4.formvalue
  L5 = A0
  L6 = "cbi.submit"
  L4 = L4(L5, L6)
  if not L4 then
    L4 = FORM_NODATA
    return L4
  else
    L4 = FORM_PROCEED
    if L3 > L4 then
      if L2 then
        L5 = A0
        L4 = A0.get
        L6 = L2
        L4 = L4(L5, L6)
        if L4 then
          goto lbl_121
        end
      end
      L5 = A0
      L4 = A0._run_hook
      L6 = "on_done"
      L4 = L4(L5, L6)
      L4 = L4 or L4
      return L4
    ::lbl_121::
    else
      L4 = L2 or L4
      if not L2 then
        L4 = A0.current
      end
      A0.current = L4
      L5 = A0
      L4 = A0.get
      L6 = A0.current
      L4 = L4(L5, L6)
      A0.active = L4
      L4 = type
      L5 = A0.active
      L4 = L4(L5)
      if L4 ~= "function" then
        L4 = A0.active
        L5 = L4
        L4 = L4.populate_delegator
        L6 = A0
        L4(L5, L6)
        L4 = A0.active
        L5 = L4
        L4 = L4.parse
        L6 = false
        L4 = L4(L5, L6)
        L5 = FORM_SKIP
        if L4 == L5 then
          L6 = A0
          L5 = A0.parse
          L7 = ...
          return L5(L6, L7)
        else
          L5 = FORM_PROCEED
          return L5
        end
      else
        L5 = A0
        L4 = A0.parse
        L6, L7 = ...
        return L4(L5, L6, L7)
      end
    end
  end
end
L7.parse = L8
L7 = Delegator
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  for L5, L6 in L2, L3, L4 do
    if L6 == A1 then
      L7 = A0.chain
      L8 = L5 + 1
      L7 = L7[L8]
      return L7
    end
  end
end
L7.get_next = L8
L7 = Delegator
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  for L5, L6 in L2, L3, L4 do
    if L6 == A1 then
      L7 = A0.chain
      L8 = L5 - 1
      L7 = L7[L8]
      return L7
    end
  end
end
L7.get_prev = L8
L7 = Delegator
function L8(A0)
  local L1, L2, L3
  L1 = Map
  L1 = L1.formvalue
  L2 = A0
  L3 = "cbi.delg.path"
  L1 = L1(L2, L3)
  L1 = L1 or L1
  L2 = type
  L3 = L1
  L2 = L2(L3)
  L2 = L1 or L2
  if L2 ~= "table" or not L1 then
    L2 = {}
    L3 = L1
    L2[1] = L3
  end
  return L2
end
L7.get_chain = L8
L7 = Delegator
function L8(A0)
  local L1, L2, L3
  L1 = Map
  L1 = L1.formvalue
  L2 = A0
  L3 = "cbi.delg.current"
  L1 = L1(L2, L3)
  if not L1 then
    L1 = A0.chain
    L1 = L1[1]
  end
  return L1
end
L7.get_active = L8
L7 = L4
L8 = Node
L7 = L7(L8)
Page = L7
L7 = Page
L8 = Node
L8 = L8.__init__
L7.__init__ = L8
L7 = Page
function L8()
  local L0, L1
end
L7.parse = L8
L7 = L4
L8 = Node
L7 = L7(L8)
SimpleForm = L7
L7 = SimpleForm
function L8(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8
  L5 = Node
  L5 = L5.__init__
  L6 = A0
  L7 = A2
  L8 = A3
  L5(L6, L7, L8)
  A0.config = A1
  L5 = A4 or L5
  if not A4 then
    L5 = {}
  end
  A0.data = L5
  A0.template = "cbi/simpleform"
  A0.dorender = true
  A0.pageaction = false
  A0.readinput = true
end
L7.__init__ = L8
L7 = SimpleForm
L8 = Map
L8 = L8.formvalue
L7.formvalue = L8
L7 = SimpleForm
L8 = Map
L8 = L8.formvaluetable
L7.formvaluetable = L8
L7 = SimpleForm
function L8(A0, A1, ...)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L3 = A1 ~= false
  A0.readinput = L3
  L3 = A0.formvalue
  L3 = L3(L4, L5)
  if L3 then
    L3 = FORM_SKIP
    return L3
  end
  L3 = A0.formvalue
  L3 = L3(L4, L5)
  if L3 then
    L3 = A0._run_hooks
    L3 = L3(L4, L5)
    if L3 then
      L3 = FORM_DONE
      return L3
    end
  end
  L3 = A0.submitstate
  L3 = L3(L4)
  if L3 then
    L3 = Node
    L3 = L3.parse
    L7, L8, L12, L13, L14 = ...
    L3(L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  end
  L3 = true
  for L7, L8 in L4, L5, L6 do
    for L12, L13 in L9, L10, L11 do
      if L3 then
        L14 = L13.tag_missing
        if L14 then
          L14 = L13.tag_missing
          L14 = L14[1]
        end
        L14 = L13.tag_invalid
        if L14 then
          L14 = L13.tag_invalid
          L14 = L14[1]
        end
        L14 = L13.error
        L3 = not L14 and L3
      end
    end
  end
  if not L4 then
    if L4 then
      goto lbl_82
    end
  end
  if L3 then
    if L4 then
      goto lbl_82
    end
  end
  ::lbl_82::
  A0.dorender = L5
  if L5 then
    L7 = L4
    L8 = A0.data
    L7 = A0.dorender
    L7 = L7 or L5 ~= false
    A0.dorender = L7
    if not L6 then
    end
  end
  return L4
end
L7.parse = L8
L7 = SimpleForm
function L8(A0, ...)
  local L2, L3, L4
  L2 = A0.dorender
  if L2 then
    L2 = Node
    L2 = L2.render
    L3 = A0
    L4 = ...
    L2(L3, L4)
  end
end
L7.render = L8
L7 = SimpleForm
function L8(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.formvalue
  L3 = "cbi.submit"
  return L1(L2, L3)
end
L7.submitstate = L8
L7 = SimpleForm
function L8(A0, A1, ...)
  local L3, L4, L5, L6
  L3 = _UPVALUE0_
  L4 = A1
  L5 = AbstractSection
  L3 = L3(L4, L5)
  if L3 then
    L3 = A1
    L4 = A0
    L5, L6 = ...
    L3 = L3(L4, L5, L6)
    L5 = A0
    L4 = A0.append
    L6 = L3
    L4(L5, L6)
    return L3
  else
    L3 = error
    L4 = "class must be a descendent of AbstractSection"
    L3(L4)
  end
end
L7.section = L8
L7 = SimpleForm
function L8(A0, A1, ...)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  for L7, L8 in L4, L5, L6 do
    L9 = _UPVALUE0_
    L10 = L8
    L11 = SimpleSection
    L9 = L9(L10, L11)
    if L9 then
      L3 = L8
      break
    end
  end
  L3 = L3 or L3
  if L4 then
    L7, L8, L9, L10, L11 = ...
    L4.track_missing = true
    L7 = L4
    L5(L6, L7)
    return L4
  else
    L4(L5)
  end
end
L7.field = L8
L7 = SimpleForm
function L8(A0, A1, A2, A3)
  local L4
  L4 = A0.data
  L4[A2] = A3
end
L7.set = L8
L7 = SimpleForm
function L8(A0, A1, A2)
  local L3
  L3 = A0.data
  L3[A2] = nil
end
L7.del = L8
L7 = SimpleForm
function L8(A0, A1, A2)
  local L3
  L3 = A0.data
  L3 = L3[A2]
  return L3
end
L7.get = L8
L7 = SimpleForm
function L8()
  local L0, L1
  return L0
end
L7.get_scheme = L8
L7 = L4
L8 = SimpleForm
L7 = L7(L8)
Form = L7
L7 = Form
function L8(A0, ...)
  local L2, L3, L4
  L2 = SimpleForm
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.embedded = true
end
L7.__init__ = L8
L7 = L4
L8 = Node
L7 = L7(L8)
AbstractSection = L7
L7 = AbstractSection
function L8(A0, A1, A2, ...)
  local L4, L5, L6
  L4 = Node
  L4 = L4.__init__
  L5 = A0
  L6 = ...
  L4(L5, L6)
  A0.sectiontype = A2
  A0.map = A1
  L4 = A1.config
  A0.config = L4
  L4 = {}
  A0.optionals = L4
  L4 = {}
  A0.defaults = L4
  L4 = {}
  A0.fields = L4
  L4 = {}
  A0.tag_error = L4
  L4 = {}
  A0.tag_invalid = L4
  L4 = {}
  A0.tag_deperror = L4
  A0.changed = false
  A0.optional = true
  A0.addremove = false
  A0.dynamic = false
end
L7.__init__ = L8
L7 = AbstractSection
function L8(A0, A1, A2, A3)
  local L4, L5, L6
  L4 = A0.tabs
  L4 = L4 or L4
  A0.tabs = L4
  L4 = A0.tab_names
  L4 = L4 or L4
  A0.tab_names = L4
  L4 = A0.tab_names
  L5 = A0.tab_names
  L5 = #L5
  L5 = L5 + 1
  L4[L5] = A1
  L4 = A0.tabs
  L5 = {}
  L5.title = A2
  L5.description = A3
  L6 = {}
  L5.childs = L6
  L4[A1] = L5
end
L7.tab = L8
L7 = AbstractSection
function L8(A0)
  local L1, L2
  L1 = A0.tabs
  L1 = L1 ~= nil
  return L1
end
L7.has_tabs = L8
L7 = AbstractSection
function L8(A0, A1, A2, ...)
  local L4, L5, L6, L7, L8
  L4 = _UPVALUE0_
  L5 = A1
  L6 = AbstractValue
  L4 = L4(L5, L6)
  if L4 then
    L4 = A1
    L5 = A0.map
    L6 = A0
    L7 = A2
    L8 = ...
    L4 = L4(L5, L6, L7, L8)
    L6 = A0
    L5 = A0.append
    L7 = L4
    L5(L6, L7)
    L5 = A0.fields
    L5[A2] = L4
    return L4
  elseif A1 == true then
    L4 = error
    L5 = "No valid class was given and autodetection failed."
    L4(L5)
  else
    L4 = error
    L5 = "class must be a descendant of AbstractValue"
    L4(L5)
  end
end
L7.option = L8
L7 = AbstractSection
function L8(A0, A1, ...)
  local L3, L4, L5, L6
  L3 = assert
  L4 = A1 or L4
  if A1 then
    L4 = A0.tabs
    if L4 then
      L4 = A0.tabs
      L4 = L4[A1]
    end
  end
  L5 = tostring
  L6 = A1
  L5 = L5(L6)
  L5 = "Cannot assign option to not existing tab %q" % L5
  L3(L4, L5)
  L3 = A0.tabs
  L3 = L3[A1]
  L3 = L3.childs
  L4 = AbstractSection
  L4 = L4.option
  L5 = A0
  L6 = ...
  L4 = L4(L5, L6)
  if L4 then
    L5 = #L3
    L5 = L5 + 1
    L3[L5] = L4
  end
  return L4
end
L7.taboption = L8
L7 = AbstractSection
function L8(A0, A1, ...)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L3 = assert
  L4 = A1 or L4
  if A1 then
    L4 = A0.tabs
    if L4 then
      L4 = A0.tabs
      L4 = L4[A1]
    end
  end
  L3(L4, L5)
  L3, L4 = nil, nil
  for L8, L9 in L5, L6, L7 do
    L10 = A0.tabs
    L10 = L10[A1]
    L10 = L10.childs
    L10 = #L10
    L10 = L8 == L10
    L9.last_child = L10
    L11 = L9
    L10 = L9.render
    L12 = ...
    L10(L11, L12)
  end
end
L7.render_tab = L8
L7 = AbstractSection
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = A0.optional
  if not L2 then
    return
  end
  L2 = A0.optionals
  L2[A1] = L3
  L2 = A0.map
  L2 = L2.formvalue
  L6 = "."
  L7 = A1
  L2 = L2(L3, L4)
  for L6, L7 in L3, L4, L5 do
    L8 = L7.optional
    if L8 then
      L9 = L7
      L8 = L7.cfgvalue
      L10 = A1
      L8 = L8(L9, L10)
      if not L8 then
        L9 = A0
        L8 = A0.has_tabs
        L8 = L8(L9)
        if not L8 then
          L8 = L7.option
          if L2 == L8 then
            L2 = nil
            L8 = A0.map
            L8.proceed = true
          else
            L8 = table
            L8 = L8.insert
            L9 = A0.optionals
            L9 = L9[A1]
            L10 = L7
            L8(L9, L10)
          end
        end
      end
    end
  end
  if L2 then
    if 0 < L3 then
      if L3 then
        L3(L4, L5)
      end
    end
  end
end
L7.parse_optionals = L8
L7 = AbstractSection
function L8(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L4 = A0
  L3 = A0.option
  L5 = Value
  L6 = A1
  L7 = A1
  L3 = L3(L4, L5, L6, L7)
  L3.optional = A2
end
L7.add_dynamic = L8
L7 = AbstractSection
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = A0.dynamic
  if not L2 then
    return
  end
  L2 = luci
  L2 = L2.util
  L2 = L2.clone
  L3 = A0.cfgvalue
  L3, L7, L8, L9, L13, L14, L15 = L3(L4, L5)
  L2 = L2(L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15)
  L3 = A0.map
  L3 = L3.formvaluetable
  L7 = "."
  L8 = A1
  L3 = L3(L4, L5)
  for L7, L8 in L4, L5, L6 do
    L2[L7] = L8
  end
  for L7, L8 in L4, L5, L6 do
    L9 = true
    for L13, L14 in L10, L11, L12 do
      L15 = L14.option
      if L15 == L7 then
        L9 = false
      end
    end
    if L9 then
      L13 = 1
      if L10 ~= "." then
        L10.proceed = true
        L13 = true
        L10(L11, L12, L13)
      end
    end
  end
end
L7.parse_dynamic = L8
L7 = AbstractSection
function L8(A0, A1)
  local L2, L3, L4
  L2 = A0.map
  L3 = L2
  L2 = L2.get
  L4 = A1
  return L2(L3, L4)
end
L7.cfgvalue = L8
L7 = AbstractSection
function L8(A0)
  local L1
  L1 = A0.map
  L1.changed = true
end
L7.push_events = L8
L7 = AbstractSection
function L8(A0, A1)
  local L2, L3, L4
  L2 = A0.map
  L2.proceed = true
  L2 = A0.map
  L3 = L2
  L2 = L2.del
  L4 = A1
  return L2(L3, L4)
end
L7.remove = L8
L7 = AbstractSection
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  if A1 then
    L2 = L3 or L2
    if L3 then
      L6 = nil
      L7 = A0.sectiontype
      L2 = L3
    end
  else
    A1 = L3
    L2 = A1
  end
  if L2 then
    for L6, L7 in L3, L4, L5 do
      L8 = L7.default
      if L8 then
        L8 = A0.map
        L9 = L8
        L8 = L8.set
        L10 = A1
        L11 = L7.option
        L12 = L7.default
        L8(L9, L10, L11, L12)
      end
    end
    for L6, L7 in L3, L4, L5 do
      L8 = A0.map
      L9 = L8
      L8 = L8.set
      L10 = A1
      L11 = L6
      L12 = L7
      L8(L9, L10, L11, L12)
    end
  end
  L3.proceed = true
  return L2
end
L7.create = L8
L7 = L4
L8 = AbstractSection
L7 = L7(L8)
SimpleSection = L7
L7 = SimpleSection
function L8(A0, A1, ...)
  local L3, L4, L5, L6, L7
  L3 = AbstractSection
  L3 = L3.__init__
  L4 = A0
  L5 = A1
  L6 = nil
  L7 = ...
  L3(L4, L5, L6, L7)
  A0.template = "cbi/nullsection"
end
L7.__init__ = L8
L7 = L4
L8 = AbstractSection
L7 = L7(L8)
Table = L7
L7 = Table
function L8(A0, A1, A2, ...)
  local L4, L5, L6, L7, L8, L9, L10
  L4 = {}
  L5 = A0
  L4.config = "table"
  L6 = A2 or L6
  if not A2 then
    L6 = {}
  end
  A0.data = L6
  L6 = Map
  L6 = L6.formvalue
  L4.formvalue = L6
  L6 = Map
  L6 = L6.formvaluetable
  L4.formvaluetable = L6
  L4.readinput = true
  function L6(A0, A1, A2)
    local L3
    L3 = _UPVALUE0_
    L3 = L3.data
    L3 = L3[A1]
    if L3 then
      L3 = _UPVALUE0_
      L3 = L3.data
      L3 = L3[A1]
      L3 = L3[A2]
    end
    return L3
  end
  L4.get = L6
  function L6(A0)
    local L1, L2, L3
    L1 = Map
    L1 = L1.formvalue
    L2 = A0
    L3 = "cbi.submit"
    return L1(L2, L3)
  end
  L4.submitstate = L6
  function L6(...)
    local L1
    L1 = true
    return L1
  end
  L4.del = L6
  function L6()
    local L0, L1
    return L0
  end
  L4.get_scheme = L6
  L6 = AbstractSection
  L6 = L6.__init__
  L7 = A0
  L8 = L4
  L9 = "table"
  L10 = ...
  L6(L7, L8, L9, L10)
  A0.template = "cbi/tblsection"
  A0.rowcolors = true
  A0.anonymous = true
end
L7.__init__ = L8
L7 = Table
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L3 = A1 ~= false
  L2.readinput = L3
  L5, L6, L7, L8, L9 = L3(L4)
  for L5, L6 in L2, L3, L4 do
    L7 = A0.map
    L8 = L7
    L7 = L7.submitstate
    L7 = L7(L8)
    if L7 then
      L7 = Node
      L7 = L7.parse
      L8 = A0
      L9 = L6
      L7(L8, L9)
    end
  end
end
L7.parse = L8
L7 = Table
function L8(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  for L5, L6 in L2, L3, L4 do
    L7 = table
    L7 = L7.insert
    L8 = L1
    L9 = L5
    L7(L8, L9)
  end
  return L1
end
L7.cfgsections = L8
L7 = Table
function L8(A0, A1)
  A0.data = A1
end
L7.update = L8
L7 = L4
L8 = AbstractSection
L7 = L7(L8)
NamedSection = L7
L7 = NamedSection
function L8(A0, A1, A2, A3, ...)
  local L5, L6, L7, L8, L9
  L5 = AbstractSection
  L5 = L5.__init__
  L6 = A0
  L7 = A1
  L8 = A3
  L9 = ...
  L5(L6, L7, L8, L9)
  A0.addremove = false
  A0.template = "cbi/nsection"
  A0.section = A2
end
L7.__init__ = L8
L7 = NamedSection
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = A0.section
  L4 = A0
  L3 = A0.cfgvalue
  L5 = L2
  L3 = L3(L4, L5)
  L4 = A0.addremove
  if L4 then
    L4 = A0.config
    L5 = "."
    L6 = L2
    L4 = L4 .. L5 .. L6
    if L3 then
      L5 = A0.map
      L6 = L5
      L5 = L5.formvalue
      L7 = "cbi.rns."
      L8 = L4
      L7 = L7 .. L8
      L5 = L5(L6, L7)
      if L5 then
        L6 = A0
        L5 = A0.remove
        L7 = L2
        L5 = L5(L6, L7)
        if L5 then
          L6 = A0
          L5 = A0.push_events
          L5(L6)
          return
        end
      end
    else
      L5 = A0.map
      L6 = L5
      L5 = L5.formvalue
      L7 = "cbi.cns."
      L8 = L4
      L7 = L7 .. L8
      L5 = L5(L6, L7)
      if L5 then
        L6 = A0
        L5 = A0.create
        L7 = L2
        L5(L6, L7)
        return
      end
    end
  end
  if L3 then
    L4 = AbstractSection
    L4 = L4.parse_dynamic
    L5 = A0
    L6 = L2
    L4(L5, L6)
    L4 = A0.map
    L5 = L4
    L4 = L4.submitstate
    L4 = L4(L5)
    if L4 then
      L4 = Node
      L4 = L4.parse
      L5 = A0
      L6 = L2
      L4(L5, L6)
    end
    L4 = AbstractSection
    L4 = L4.parse_optionals
    L5 = A0
    L6 = L2
    L4(L5, L6)
    L4 = A0.changed
    if L4 then
      L5 = A0
      L4 = A0.push_events
      L4(L5)
    end
  end
end
L7.parse = L8
L7 = L4
L8 = AbstractSection
L7 = L7(L8)
TypedSection = L7
L7 = TypedSection
function L8(A0, A1, A2, ...)
  local L4, L5, L6, L7, L8
  L4 = AbstractSection
  L4 = L4.__init__
  L5 = A0
  L6 = A1
  L7 = A2
  L8 = ...
  L4(L5, L6, L7, L8)
  A0.template = "cbi/tsection"
  L4 = {}
  A0.deps = L4
  A0.anonymous = false
end
L7.__init__ = L8
L7 = TypedSection
function L8(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = {}
  L2 = A0.map
  L2 = L2.uci
  L3 = L2
  L2 = L2.foreach
  L4 = A0.map
  L4 = L4.config
  L5 = A0.sectiontype
  function L6(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.checkscope
    L3 = A0[".name"]
    L1 = L1(L2, L3)
    if L1 then
      L1 = table
      L1 = L1.insert
      L2 = _UPVALUE1_
      L3 = A0[".name"]
      L1(L2, L3)
    end
  end
  L2(L3, L4, L5, L6)
  return L1
end
L7.cfgsections = L8
L7 = TypedSection
function L8(A0, A1, A2)
  local L3, L4, L5
  L3 = table
  L3 = L3.insert
  L4 = A0.deps
  L5 = {}
  L5.option = A1
  L5.value = A2
  L3(L4, L5)
end
L7.depends = L8
L7 = TypedSection
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = A0.addremove
  if L2 then
    L2 = REMOVE_PREFIX
    L2 = L2 .. L3
    for L7, L8 in L4, L5, L6 do
      L10 = L7
      L11 = -2
      if L9 == ".x" then
        L10 = L7
        L11 = 1
        L12 = #L7
        L12 = L12 - 2
      end
      L10 = A0
      L11 = L7
      if L9 then
        L10 = A0
        L11 = L7
        if L9 then
          L10 = A0
          L11 = L7
          L9(L10, L11)
        end
      end
    end
  end
  L2 = nil
  L10, L11, L12, L13, L14, L15 = L4(L5)
  for L6, L7 in L3, L4, L5 do
    L10 = L7
    L8(L9, L10)
    if L8 then
      L10 = L7
      L11 = A1
      L8(L9, L10, L11)
    end
    L10 = L7
    L8(L9, L10)
  end
  if L3 then
    L10, L11, L12, L13, L14, L15 = L6(L7, L8)
    if L7 then
      if L6 then
        L10 = L5
      end
    elseif L6 then
      if L7 then
      end
      if not L6 then
        A0.err_invalid = true
      end
      if L6 then
        if 0 < L7 then
          L10 = L5
          if L7 then
          end
          if not L3 then
            A0.invalid_cts = true
          end
        end
      end
    end
    if L3 then
      L7(L8, L9)
    end
  end
  if L3 then
    if L4 then
      if 0 < L5 then
        for L10 in L7, L8, L9 do
          L11 = A0.map
          L11 = L11.uci
          L12 = L11
          L11 = L11.reorder
          L13 = A0.config
          L14 = L10
          L15 = L6
          L11(L12, L13, L14, L15)
        end
        L7 = 0 < L6
        A0.changed = L7
      end
    end
  end
  if not L3 then
    if not L3 then
      goto lbl_180
    end
  end
  L3(L4)
  ::lbl_180::
end
L7.parse = L8
L7 = TypedSection
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = A0.filter
  if L2 then
    L2 = A0.filter
    L2 = L2(L3, L4)
    if not L2 then
      L2 = nil
      return L2
    end
  end
  L2 = A0.deps
  L2 = #L2
  if 0 < L2 then
    L2 = A0.cfgvalue
    L2 = L2(L3, L4)
    if L2 then
      L2 = false
      for L6, L7 in L3, L4, L5 do
        L9 = A0
        L8 = A0.cfgvalue
        L10 = A1
        L8 = L8(L9, L10)
        L9 = L7.option
        L8 = L8[L9]
        L9 = L7.value
        if L8 == L9 then
          L2 = true
        end
      end
      if not L2 then
        return L3
      end
    end
  end
  L2 = A0.validate
  return L2(L3, L4)
end
L7.checkscope = L8
L7 = TypedSection
function L8(A0, A1)
  return A1
end
L7.validate = L8
L7 = L4
L8 = Node
L7 = L7(L8)
AbstractValue = L7
L7 = AbstractValue
function L8(A0, A1, A2, A3, ...)
  local L5, L6, L7
  L5 = Node
  L5 = L5.__init__
  L6 = A0
  L7 = ...
  L5(L6, L7)
  A0.section = A2
  A0.option = A3
  A0.map = A1
  L5 = A1.config
  A0.config = L5
  L5 = {}
  A0.tag_invalid = L5
  L5 = {}
  A0.tag_missing = L5
  L5 = {}
  A0.tag_reqerror = L5
  L5 = {}
  A0.tag_error = L5
  L5 = {}
  A0.deps = L5
  L5 = {}
  A0.subdeps = L5
  A0.track_missing = false
  A0.rmempty = true
  A0.default = nil
  A0.size = nil
  A0.optional = false
end
L7.__init__ = L8
L7 = AbstractValue
function L8(A0)
  local L1
  L1 = A0.cast
  L1 = L1 or L1
  A0.cast = L1
end
L7.prepare = L8
L7 = AbstractValue
function L8(A0, A1, A2)
  local L3, L4, L5, L6
  L4 = type
  L5 = A1
  L4 = L4(L5)
  if L4 == "string" then
    L4 = {}
    L3 = L4
    L3[A1] = A2
  else
    L3 = A1
  end
  L4 = table
  L4 = L4.insert
  L5 = A0.deps
  L6 = {}
  L6.deps = L3
  L6.add = ""
  L4(L5, L6)
end
L7.depends = L8
L7 = AbstractValue
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = "cbid."
  L3 = A0.map
  L3 = L3.config
  L4 = "."
  L5 = A1
  L6 = "."
  L7 = A0.option
  L2 = L2 .. L3 .. L4 .. L5 .. L6 .. L7
  return L2
end
L7.cbid = L8
L7 = AbstractValue
function L8(A0, A1)
  local L2, L3, L4, L5
  L2 = "cbi.opt."
  L3 = A0.config
  L4 = "."
  L5 = A1
  L2 = L2 .. L3 .. L4 .. L5
  L3 = A0.map
  L4 = L3
  L3 = L3.formvalue
  L5 = L2
  L3 = L3(L4, L5)
  L4 = A0.option
  L3 = L3 == L4
  return L3
end
L7.formcreated = L8
L7 = AbstractValue
function L8(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = A0.map
  L3 = L2
  L2 = L2.formvalue
  L5 = A0
  L4 = A0.cbid
  L6 = A1
  L4, L5, L6 = L4(L5, L6)
  return L2(L3, L4, L5, L6)
end
L7.formvalue = L8
L7 = AbstractValue
function L8(A0, A1)
  A0.optional = A1
end
L7.additional = L8
L7 = AbstractValue
function L8(A0, A1)
  local L2
  L2 = not A1
  A0.rmempty = L2
end
L7.mandatory = L8
L7 = AbstractValue
function L8(A0, A1, A2, A3)
  local L4, L5, L6
  L4 = A0.error
  L4 = L4 or L4
  A0.error = L4
  L4 = A0.error
  L5 = A3 or L5
  if not A3 then
    L5 = A2
  end
  L4[A1] = L5
  L4 = A0.section
  L5 = A0.section
  L5 = L5.error
  L5 = L5 or L5
  L4.error = L5
  L4 = A0.section
  L4 = L4.error
  L5 = A0.section
  L5 = L5.error
  L5 = L5[A1]
  L5 = L5 or L5
  L4[A1] = L5
  L4 = table
  L4 = L4.insert
  L5 = A0.section
  L5 = L5.error
  L5 = L5[A1]
  L6 = A3 or L6
  if not A3 then
    L6 = A2
  end
  L4(L5, L6)
  if A2 == "invalid" then
    L4 = A0.tag_invalid
    L4[A1] = true
  elseif A2 == "missing" then
    L4 = A0.tag_missing
    L4[A1] = true
  end
  L4 = A0.tag_error
  L4[A1] = true
  L4 = A0.map
  L4.save = false
end
L7.add_error = L8
L7 = AbstractValue
function L8(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L4 = A0
  L3 = A0.formvalue
  L5 = A1
  L3 = L3(L4, L5)
  L5 = A0
  L4 = A0.cfgvalue
  L4 = L4(L5, L6)
  L5 = type
  L5 = L5(L6)
  if L5 == "table" then
    L5 = type
    L5 = L5(L6)
    if L5 == "table" then
      L5 = #L3
      L5 = L5 == L6
      if L5 then
        for L9 = L6, L7, L8 do
          L10 = L4[L9]
          L11 = L3[L9]
          if L10 ~= L11 then
            L5 = false
          end
        end
      end
      if L5 then
        L3 = L4
      end
    end
  end
  if L3 then
    L5 = #L3
    if 0 < L5 then
      L5 = nil
      L9 = A1
      L5 = L7
      L3 = L6
      L3 = L6
      if not L3 and not A2 then
        L9 = "invalid"
        L10 = L5
        L6(L7, L8, L9, L10)
      end
      if L3 then
        if L6 or L3 ~= L4 then
          L9 = L3
          if L6 then
            L6.changed = true
          end
        end
      end
  end
  else
    L5 = A0.rmempty
    if not L5 then
      L5 = A0.optional
      if not L5 then
        goto lbl_93
      end
    end
    L5 = A0.remove
    L5 = L5(L6, L7)
    if L5 then
      L5 = A0.section
      L5.changed = true
      goto lbl_106
      ::lbl_93::
      if L4 ~= L3 and not A2 then
        L5 = A0.validate
        L5 = L5(L6, L7, L8)
        L9 = A1
        L10 = "missing"
        L11 = L6
        L7(L8, L9, L10, L11)
      end
    end
  end
  ::lbl_106::
end
L7.parse = L8
L7 = AbstractValue
function L8(A0, A1, A2)
  local L3, L4, L5
  L3 = A0.optional
  if L3 then
    L3 = A0.section
    L4 = L3
    L3 = L3.has_tabs
    L3 = L3(L4)
    if not L3 then
      L4 = A0
      L3 = A0.cfgvalue
      L5 = A1
      L3 = L3(L4, L5)
      if not L3 then
        L4 = A0
        L3 = A0.formcreated
        L5 = A1
        L3 = L3(L4, L5)
        if not L3 then
          goto lbl_33
        end
      end
    end
  end
  if not A2 then
    L3 = {}
    A2 = L3
  end
  A2.section = A1
  L4 = A0
  L3 = A0.cbid
  L5 = A1
  L3 = L3(L4, L5)
  A2.cbid = L3
  L3 = Node
  L3 = L3.render
  L4 = A0
  L5 = A2
  L3(L4, L5)
  ::lbl_33::
end
L7.render = L8
L7 = AbstractValue
function L8(A0, A1)
  local L2, L3, L4, L5, L6
  L3 = A0.tag_error
  L3 = L3[A1]
  if L3 then
    L4 = A0
    L3 = A0.formvalue
    L5 = A1
    L3 = L3(L4, L5)
    L2 = L3
  else
    L3 = A0.map
    L4 = L3
    L3 = L3.get
    L5 = A1
    L6 = A0.option
    L3 = L3(L4, L5, L6)
    L2 = L3
  end
  if not L2 then
    L3 = nil
    return L3
  else
    L3 = A0.cast
    if L3 then
      L3 = A0.cast
      L4 = type
      L5 = L2
      L4 = L4(L5)
      if L3 ~= L4 then
        goto lbl_32
      end
    end
    do return L2 end
    goto lbl_50
    ::lbl_32::
    L3 = A0.cast
    if L3 == "string" then
      L3 = type
      L4 = L2
      L3 = L3(L4)
      if L3 == "table" then
        L3 = L2[1]
        return L3
      end
    else
      L3 = A0.cast
      if L3 == "table" then
        L3 = {}
        L4 = L2
        L3[1] = L4
        return L3
      end
    end
  end
  ::lbl_50::
end
L7.cfgvalue = L8
L7 = AbstractValue
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = A0.datatype
  if L2 and A1 then
    L2 = type
    L2 = L2(L3)
    if L2 == "table" then
      L2 = nil
      for L6, L7 in L3, L4, L5 do
        if L7 then
          L8 = #L7
          if 0 < L8 then
            L8 = verify_datatype
            L9 = A0.datatype
            L10 = L7
            L8 = L8(L9, L10)
            if not L8 then
              L8 = nil
              return L8
            end
          end
        end
      end
    else
      L2 = verify_datatype
      L2 = L2(L3, L4)
      if not L2 then
        L2 = nil
        return L2
      end
    end
  end
  return A1
end
L7.validate = L8
L7 = AbstractValue
L8 = AbstractValue
L8 = L8.validate
L7.transform = L8
L7 = AbstractValue
function L8(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = A0.map
  L4 = L3
  L3 = L3.set
  L5 = A1
  L6 = A0.option
  L7 = A2
  return L3(L4, L5, L6, L7)
end
L7.write = L8
L7 = AbstractValue
function L8(A0, A1)
  local L2, L3, L4, L5
  L2 = A0.map
  L3 = L2
  L2 = L2.del
  L4 = A1
  L5 = A0.option
  return L2(L3, L4, L5)
end
L7.remove = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
Value = L7
L7 = Value
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/value"
  L2 = {}
  A0.keylist = L2
  L2 = {}
  A0.vallist = L2
end
L7.__init__ = L8
L7 = Value
function L8(A0)
  local L1
  L1 = {}
  A0.keylist = L1
  L1 = {}
  A0.vallist = L1
end
L7.reset_values = L8
L7 = Value
function L8(A0, A1, A2)
  local L3, L4, L5, L6
  A2 = A2 or A2
  L3 = table
  L3 = L3.insert
  L4 = A0.keylist
  L5 = tostring
  L6 = A1
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
  L3 = table
  L3 = L3.insert
  L4 = A0.vallist
  L5 = tostring
  L6 = A2
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
end
L7.value = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
DummyValue = L7
L7 = DummyValue
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/dvalue"
  A0.value = nil
end
L7.__init__ = L8
L7 = DummyValue
function L8(A0, A1)
  local L2, L3, L4, L5
  L3 = A0.value
  if L3 then
    L3 = type
    L4 = A0.value
    L3 = L3(L4)
    if L3 == "function" then
      L4 = A0
      L3 = A0.value
      L5 = A1
      L3 = L3(L4, L5)
      L2 = L3
    else
      L2 = A0.value
    end
  else
    L3 = AbstractValue
    L3 = L3.cfgvalue
    L4 = A0
    L5 = A1
    L3 = L3(L4, L5)
    L2 = L3
  end
  return L2
end
L7.cfgvalue = L8
L7 = DummyValue
function L8(A0)
  local L1
end
L7.parse = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
Flag = L7
L7 = Flag
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/fvalue"
  A0.enabled = "1"
  A0.disabled = "0"
  L2 = A0.disabled
  A0.default = L2
end
L7.__init__ = L8
L7 = Flag
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = A0.map
  L3 = L2
  L2 = L2.formvalue
  L4 = FEXIST_PREFIX
  L5 = A0.config
  L6 = "."
  L7 = A1
  L8 = "."
  L9 = A0.option
  L4 = L4 .. L5 .. L6 .. L7 .. L8 .. L9
  L2 = L2(L3, L4)
  if L2 then
    L4 = A0
    L3 = A0.formvalue
    L5 = A1
    L3 = L3(L4, L5)
    if L3 then
      L3 = A0.enabled
      if L3 then
        goto lbl_22
      end
    end
    L3 = A0.disabled
    ::lbl_22::
    L4 = A0.default
    if L3 == L4 then
      L4 = A0.optional
      if L4 then
        goto lbl_36
      end
      L4 = A0.rmempty
      if L4 then
        goto lbl_36
      end
    end
    L5 = A0
    L4 = A0.write
    L6 = A1
    L7 = L3
    L4(L5, L6, L7)
    goto lbl_43
    ::lbl_36::
    L5 = A0
    L4 = A0.remove
    L6 = A1
    L4(L5, L6)
  else
    L4 = A0
    L3 = A0.remove
    L5 = A1
    L3(L4, L5)
  end
  ::lbl_43::
end
L7.parse = L8
L7 = Flag
function L8(A0, A1)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.cfgvalue
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  L2 = L2 or L2
  return L2
end
L7.cfgvalue = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
ListValue = L7
L7 = ListValue
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/lvalue"
  L2 = {}
  A0.keylist = L2
  L2 = {}
  A0.vallist = L2
  A0.size = 1
  A0.widget = "select"
end
L7.__init__ = L8
L7 = ListValue
function L8(A0)
  local L1
  L1 = {}
  A0.keylist = L1
  L1 = {}
  A0.vallist = L1
end
L7.reset_values = L8
L7 = ListValue
function L8(A0, A1, A2, ...)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  if L4 then
    return
  end
  A2 = A2 or A2
  L7 = A1
  L7, L8, L9, L10, L11, L12, L13 = L6(L7)
  L4(L5, L6, L7, L8, L9, L10, L11, L12, L13)
  L7 = A2
  L7, L8, L9, L10, L11, L12, L13 = L6(L7)
  L4(L5, L6, L7, L8, L9, L10, L11, L12, L13)
  L7, L8, L9, L10, L11, L12, L13 = ...
  L5[1] = L6
  L5[2] = L7
  L5[3] = L8
  L5[4] = L9
  L5[5] = L10
  L5[6] = L11
  L5[7] = L12
  L5[8] = L13
  for L7, L8 in L4, L5, L6 do
    L9 = A0.subdeps
    L10 = A0.subdeps
    L10 = #L10
    L10 = L10 + 1
    L11 = {}
    L12 = "-"
    L13 = A1
    L12 = L12 .. L13
    L11.add = L12
    L11.deps = L8
    L9[L10] = L11
  end
end
L7.value = L8
L7 = ListValue
function L8(A0, A1)
  local L2, L3, L4
  L2 = luci
  L2 = L2.util
  L2 = L2.contains
  L3 = A0.keylist
  L4 = A1
  L2 = L2(L3, L4)
  if L2 then
    return A1
  else
    L2 = nil
    return L2
  end
end
L7.validate = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
MultiValue = L7
L7 = MultiValue
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/mvalue"
  L2 = {}
  A0.keylist = L2
  L2 = {}
  A0.vallist = L2
  A0.widget = "checkbox"
  A0.delimiter = " "
end
L7.__init__ = L8
L7 = MultiValue
function L8(A0, ...)
  local L2, L3, L4
  L2 = A0.widget
  if L2 == "select" then
    L2 = A0.size
    if not L2 then
      L2 = A0.vallist
      L2 = #L2
      A0.size = L2
    end
  end
  L2 = AbstractValue
  L2 = L2.render
  L3 = A0
  L4 = ...
  L2(L3, L4)
end
L7.render = L8
L7 = MultiValue
function L8(A0)
  local L1
  L1 = {}
  A0.keylist = L1
  L1 = {}
  A0.vallist = L1
end
L7.reset_values = L8
L7 = MultiValue
function L8(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = luci
  L3 = L3.util
  L3 = L3.contains
  L4 = A0.keylist
  L5 = A1
  L3 = L3(L4, L5)
  if L3 then
    return
  end
  A2 = A2 or A2
  L3 = table
  L3 = L3.insert
  L4 = A0.keylist
  L5 = tostring
  L6 = A1
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
  L3 = table
  L3 = L3.insert
  L4 = A0.vallist
  L5 = tostring
  L6 = A2
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
end
L7.value = L8
L7 = MultiValue
function L8(A0, A1)
  local L2, L3, L4, L5
  L3 = A0
  L2 = A0.cfgvalue
  L4 = A1
  L2 = L2(L3, L4)
  L3 = type
  L4 = L2
  L3 = L3(L4)
  if L3 ~= "string" then
    L3 = {}
    return L3
  end
  L3 = luci
  L3 = L3.util
  L3 = L3.split
  L4 = L2
  L5 = A0.delimiter
  return L3(L4, L5)
end
L7.valuelist = L8
L7 = MultiValue
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = type
  L2 = L2(L3)
  if L2 ~= "table" or not A1 then
    L2 = {}
    L2[1] = L3
    A1 = L2
  end
  L2 = nil
  for L6, L7 in L3, L4, L5 do
    L8 = luci
    L8 = L8.util
    L8 = L8.contains
    L9 = A0.keylist
    L10 = L7
    L8 = L8(L9, L10)
    if L8 then
      if L2 then
        L8 = L2
        L9 = A0.delimiter
        L10 = L7
        L8 = L8 .. L9 .. L10
        if L8 then
          goto lbl_34
          L2 = L8 or L2
        end
      end
      L2 = L7
    end
    ::lbl_34::
  end
  return L2
end
L7.validate = L8
L7 = L4
L8 = MultiValue
L7 = L7(L8)
StaticList = L7
L7 = StaticList
function L8(A0, ...)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = MultiValue
  L2 = L2.__init__
  L6, L7, L8, L9, L10, L11 = ...
  L2(L3, L4, L5, L6, L7, L8, L9, L10, L11)
  A0.cast = "table"
  L2 = A0.cfgvalue
  A0.valuelist = L2
  L2 = A0.override_scheme
  if not L2 then
    L2 = A0.map
    L2 = L2.get_scheme
    L2 = L2(L3, L4, L5)
    if L2 then
      L2 = A0.map
      L2 = L2.get_scheme
      L2 = L2(L3, L4, L5)
      if L3 then
        if L3 then
          if not L3 then
            for L6, L7 in L3, L4, L5 do
              L9 = A0
              L8 = A0.value
              L10 = L6
              L11 = L7
              L8(L9, L10, L11)
            end
          end
        end
      end
    end
  end
end
L7.__init__ = L8
L7 = StaticList
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = type
  L2 = L2(L3)
  if L2 ~= "table" or not A1 then
    L2 = {}
    L2[1] = L3
    A1 = L2
  end
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    L8 = luci
    L8 = L8.util
    L8 = L8.contains
    L9 = A0.keylist
    L10 = L7
    L8 = L8(L9, L10)
    if L8 then
      L8 = table
      L8 = L8.insert
      L9 = L2
      L10 = L7
      L8(L9, L10)
    end
  end
  return L2
end
L7.validate = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
DynamicList = L7
L7 = DynamicList
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/dynlist"
  A0.cast = "table"
  L2 = {}
  A0.keylist = L2
  L2 = {}
  A0.vallist = L2
end
L7.__init__ = L8
L7 = DynamicList
function L8(A0)
  local L1
  L1 = {}
  A0.keylist = L1
  L1 = {}
  A0.vallist = L1
end
L7.reset_values = L8
L7 = DynamicList
function L8(A0, A1, A2)
  local L3, L4, L5, L6
  A2 = A2 or A2
  L3 = table
  L3 = L3.insert
  L4 = A0.keylist
  L5 = tostring
  L6 = A1
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
  L3 = table
  L3 = L3.insert
  L4 = A0.vallist
  L5 = tostring
  L6 = A2
  L5, L6 = L5(L6)
  L3(L4, L5, L6)
end
L7.value = L8
L7 = DynamicList
function L8(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = {}
  L4 = type
  L4 = L4(L5)
  if L4 == "table" then
    L4 = nil
    for L8, L9 in L5, L6, L7 do
      if L9 then
        L10 = #L9
        if 0 < L10 then
          L10 = #L3
          L10 = L10 + 1
          L3[L10] = L9
        end
      end
    end
  else
    L4 = {}
    L4[1] = L5
    L3 = L4
  end
  L4 = A0.cast
  if L4 == "string" then
    L4 = table
    L4 = L4.concat
    L4 = L4(L5, L6)
    A2 = L4
  else
    A2 = L3
  end
  L4 = AbstractValue
  L4 = L4.write
  return L4(L5, L6, L7)
end
L7.write = L8
L7 = DynamicList
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = AbstractValue
  L2 = L2.cfgvalue
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  L3 = type
  L4 = L2
  L3 = L3(L4)
  if L3 == "string" then
    L3 = nil
    L4 = {}
    for L8 in L5, L6, L7 do
      L9 = #L8
      if 0 < L9 then
        L9 = #L4
        L9 = L9 + 1
        L4[L9] = L8
      end
    end
    L2 = L4
  end
  return L2
end
L7.cfgvalue = L8
L7 = DynamicList
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = AbstractValue
  L2 = L2.formvalue
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  L3 = type
  L4 = L2
  L3 = L3(L4)
  if L3 == "string" then
    L3 = A0.cast
    if L3 == "string" then
      L3 = nil
      L4 = {}
      for L8 in L5, L6, L7 do
        L9 = #L4
        L9 = L9 + 1
        L4[L9] = L8
      end
      L2 = L4
    else
      L3 = {}
      L4 = L2
      L3[1] = L4
      L2 = L3
    end
  end
  return L2
end
L7.formvalue = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
TextValue = L7
L7 = TextValue
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/tvalue"
end
L7.__init__ = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
Button = L7
L7 = Button
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/button"
  A0.inputstyle = nil
  A0.rmempty = true
end
L7.__init__ = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
FileUpload = L7
L7 = FileUpload
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/upload"
  L2 = A0.map
  L2 = L2.upload_fields
  if not L2 then
    L2 = A0.map
    L3 = {}
    L4 = A0
    L3[1] = L4
    L2.upload_fields = L3
  else
    L2 = A0.map
    L2 = L2.upload_fields
    L3 = A0.map
    L3 = L3.upload_fields
    L3 = #L3
    L3 = L3 + 1
    L2[L3] = A0
  end
end
L7.__init__ = L8
L7 = FileUpload
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = AbstractValue
  L2 = L2.formcreated
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  if not L2 then
    L2 = A0.map
    L3 = L2
    L2 = L2.formvalue
    L4 = "cbi.rlf."
    L5 = A1
    L6 = "."
    L7 = A0.option
    L4 = L4 .. L5 .. L6 .. L7
    L2 = L2(L3, L4)
    if not L2 then
      L2 = A0.map
      L3 = L2
      L2 = L2.formvalue
      L4 = "cbi.rlf."
      L5 = A1
      L6 = "."
      L7 = A0.option
      L8 = ".x"
      L4 = L4 .. L5 .. L6 .. L7 .. L8
      L2 = L2(L3, L4)
    end
  end
  return L2
end
L7.formcreated = L8
L7 = FileUpload
function L8(A0, A1)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.cfgvalue
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  if L2 then
    L3 = _UPVALUE0_
    L3 = L3.access
    L4 = L2
    L3 = L3(L4)
    if L3 then
      return L2
    end
  end
  L3 = nil
  return L3
end
L7.cfgvalue = L8
L7 = FileUpload
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = AbstractValue
  L2 = L2.formvalue
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  if L2 then
    L3 = A0.map
    L4 = L3
    L3 = L3.formvalue
    L5 = "cbi.rlf."
    L6 = A1
    L7 = "."
    L8 = A0.option
    L5 = L5 .. L6 .. L7 .. L8
    L3 = L3(L4, L5)
    if not L3 then
      L3 = A0.map
      L4 = L3
      L3 = L3.formvalue
      L5 = "cbi.rlf."
      L6 = A1
      L7 = "."
      L8 = A0.option
      L9 = ".x"
      L5 = L5 .. L6 .. L7 .. L8 .. L9
      L3 = L3(L4, L5)
      if not L3 then
        return L2
      end
    end
    L3 = _UPVALUE0_
    L3 = L3.unlink
    L4 = L2
    L3(L4)
    A0.value = nil
  end
  L3 = nil
  return L3
end
L7.formvalue = L8
L7 = FileUpload
function L8(A0, A1)
  local L2, L3, L4, L5
  L2 = AbstractValue
  L2 = L2.formvalue
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  if L2 then
    L3 = _UPVALUE0_
    L3 = L3.access
    L4 = L2
    L3 = L3(L4)
    if L3 then
      L3 = _UPVALUE0_
      L3 = L3.unlink
      L4 = L2
      L3(L4)
    end
  end
  L3 = AbstractValue
  L3 = L3.remove
  L4 = A0
  L5 = A1
  return L3(L4, L5)
end
L7.remove = L8
L7 = L4
L8 = AbstractValue
L7 = L7(L8)
FileBrowser = L7
L7 = FileBrowser
function L8(A0, ...)
  local L2, L3, L4
  L2 = AbstractValue
  L2 = L2.__init__
  L3 = A0
  L4 = ...
  L2(L3, L4)
  A0.template = "cbi/browser"
end
L7.__init__ = L8
