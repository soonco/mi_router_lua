local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
L0 = type
L1 = pairs
L2 = ipairs
L3 = table
L4 = luci
L5 = math
L6 = require
L7 = "luci.template.parser"
L6 = L6(L7)
L7 = require
L8 = "luci.util"
L7 = L7(L8)
L8 = require
L9 = "luci.model.uci"
L8 = L8(L9)
L9 = module
L10 = "luci.model.firewall"
L9(L10)
L9, L10 = nil, nil
function L11(A0)
  local L1, L2, L3
  L1 = A0 or L1
  if A0 then
    L1 = #A0
    L2 = A0
    L1 = A0.match
    L3 = "^[a-zA-Z0-9_]+$"
    L1 = 0 < L1 and L1
  end
  return L1
end
_valid_id = L11
function L11(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = A0
  L6 = A1
  L7 = A2
  return L3(L4, L5, L6, L7)
end
_get = L11
function L11(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9
  if A3 ~= nil then
    L4 = _UPVALUE0_
    L5 = A3
    L4 = L4(L5)
    if L4 == "boolean" then
      if A3 then
        L4 = "1"
        if L4 then
          goto lbl_14
          A3 = L4 or A3
        end
      end
      A3 = "0"
    end
    ::lbl_14::
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.set
    L6 = A0
    L7 = A1
    L8 = A2
    L9 = A3
    return L4(L5, L6, L7, L8, L9)
  else
    L4 = _UPVALUE1_
    L5 = L4
    L4 = L4.delete
    L6 = A0
    L7 = A1
    L8 = A2
    return L4(L5, L6, L7, L8)
  end
end
_set = L11
function L11(A0)
  local L1, L2
  L1 = A0 or L1
  if not A0 then
    L1 = _UPVALUE0_
    if not L1 then
      L1 = _UPVALUE1_
      L1 = L1.cursor
      L1 = L1()
    end
  end
  _UPVALUE0_ = L1
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.substate
  L1 = L1(L2)
  _UPVALUE2_ = L1
  L1 = _M
  return L1
end
init = L11
function L11(A0, ...)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.save
  L4 = ...
  L2(L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.load
  L4 = ...
  L2(L3, L4)
end
save = L11
function L11(A0, ...)
  local L2, L3, L4
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.commit
  L4 = ...
  L2(L3, L4)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.load
  L4 = ...
  L2(L3, L4)
end
commit = L11
function L11()
  local L0, L1
  L0 = defaults
  return L0()
end
get_defaults = L11
function L11(A0)
  local L1, L2, L3, L4, L5
  L1 = "newzone"
  L2 = 1
  while true do
    L4 = A0
    L3 = A0.get_zone
    L5 = L1
    L3 = L3(L4, L5)
    if not L3 then
      break
    end
    L2 = L2 + 1
    L1 = "newzone%d" % L2
  end
  L4 = A0
  L3 = A0.add_zone
  L5 = L1
  return L3(L4, L5)
end
new_zone = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _valid_id
  L3 = A1
  L2 = L2(L3)
  if L2 then
    L3 = A0
    L2 = A0.get_zone
    L4 = A1
    L2 = L2(L3, L4)
    if not L2 then
      L2 = defaults
      L2 = L2()
      L3 = _UPVALUE0_
      L4 = L3
      L3 = L3.section
      L5 = "firewall"
      L6 = "zone"
      L7 = nil
      L8 = {}
      L8.name = A1
      L8.network = " "
      L10 = L2
      L9 = L2.input
      L9 = L9(L10)
      L9 = L9 or L9
      L8.input = L9
      L10 = L2
      L9 = L2.forward
      L9 = L9(L10)
      L9 = L9 or L9
      L8.forward = L9
      L10 = L2
      L9 = L2.output
      L9 = L9(L10)
      L9 = L9 or L9
      L8.output = L9
      L3 = L3(L4, L5, L6, L7, L8)
      L4 = L3 or L4
      if L3 then
        L4 = zone
        L5 = L3
        L4 = L4(L5)
      end
      return L4
    end
  end
end
add_zone = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "firewall"
  L5 = A1
  L2 = L2(L3, L4, L5)
  if L2 == "zone" then
    L2 = zone
    L3 = A1
    return L2(L3)
  else
    L2 = nil
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.foreach
    L5 = "firewall"
    L6 = "zone"
    function L7(A0)
      local L1, L2
      L1 = _UPVALUE0_
      if L1 then
        L1 = A0.name
        L2 = _UPVALUE0_
        if L1 == L2 then
          L1 = A0[".name"]
          _UPVALUE1_ = L1
          L1 = false
          return L1
        end
      end
    end
    L3(L4, L5, L6, L7)
    L3 = L2 or L3
    if L2 then
      L3 = zone
      L4 = L2
      L3 = L3(L4)
    end
    return L3
  end
end
get_zone = L11
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.foreach
  function L7(A0)
    local L1, L2, L3, L4
    L1 = A0.name
    if L1 then
      L1 = _UPVALUE0_
      L2 = A0.name
      L3 = zone
      L4 = A0[".name"]
      L3 = L3(L4)
      L1[L2] = L3
    end
  end
  L3(L4, L5, L6, L7)
  L3 = nil
  for L7 in L4, L5, L6 do
    L8 = #L1
    L8 = L8 + 1
    L9 = L2[L7]
    L1[L8] = L9
  end
  return L1
end
get_zones = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.foreach
  L5 = "firewall"
  L6 = "zone"
  function L7(A0)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = A0.name
    if L1 then
      L1 = _UPVALUE0_
      if L1 then
        L1 = nil
        for L5 in L2, L3, L4 do
          L6 = _UPVALUE0_
          if L5 == L6 then
            L6 = A0[".name"]
            _UPVALUE2_ = L6
            L6 = false
            return L6
          end
        end
      end
    end
  end
  L3(L4, L5, L6, L7)
  L3 = L2 or L3
  if L2 then
    L3 = zone
    L4 = L2
    L3 = L3(L4)
  end
  return L3
end
get_zone_by_network = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = false
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "firewall"
  L6 = A1
  L3 = L3(L4, L5, L6)
  if L3 == "zone" then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.get
    L5 = "firewall"
    L6 = A1
    L7 = "name"
    L3 = L3(L4, L5, L6, L7)
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.delete
    L6 = "firewall"
    L7 = A1
    L4 = L4(L5, L6, L7)
    L2 = L4
    A1 = L3
  else
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.foreach
    L5 = "firewall"
    L6 = "zone"
    function L7(A0)
      local L1, L2, L3, L4
      L1 = _UPVALUE0_
      if L1 then
        L1 = A0.name
        L2 = _UPVALUE0_
        if L1 == L2 then
          L1 = _UPVALUE2_
          L2 = L1
          L1 = L1.delete
          L3 = "firewall"
          L4 = A0[".name"]
          L1 = L1(L2, L3, L4)
          _UPVALUE1_ = L1
          L1 = false
          return L1
        end
      end
    end
    L3(L4, L5, L6, L7)
  end
  if L2 then
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.foreach
    L5 = "firewall"
    L6 = "rule"
    function L7(A0)
      local L1, L2, L3, L4
      L1 = A0.src
      L2 = _UPVALUE0_
      if L1 ~= L2 then
        L1 = A0.dest
        L2 = _UPVALUE0_
        if L1 ~= L2 then
          goto lbl_14
        end
      end
      L1 = _UPVALUE1_
      L2 = L1
      L1 = L1.delete
      L3 = "firewall"
      L4 = A0[".name"]
      L1(L2, L3, L4)
      ::lbl_14::
    end
    L3(L4, L5, L6, L7)
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.foreach
    L5 = "firewall"
    L6 = "redirect"
    function L7(A0)
      local L1, L2, L3, L4
      L1 = A0.src
      L2 = _UPVALUE0_
      if L1 ~= L2 then
        L1 = A0.dest
        L2 = _UPVALUE0_
        if L1 ~= L2 then
          goto lbl_14
        end
      end
      L1 = _UPVALUE1_
      L2 = L1
      L1 = L1.delete
      L3 = "firewall"
      L4 = A0[".name"]
      L1(L2, L3, L4)
      ::lbl_14::
    end
    L3(L4, L5, L6, L7)
    L3 = _UPVALUE0_
    L4 = L3
    L3 = L3.foreach
    L5 = "firewall"
    L6 = "forwarding"
    function L7(A0)
      local L1, L2, L3, L4
      L1 = A0.src
      L2 = _UPVALUE0_
      if L1 ~= L2 then
        L1 = A0.dest
        L2 = _UPVALUE0_
        if L1 ~= L2 then
          goto lbl_14
        end
      end
      L1 = _UPVALUE1_
      L2 = L1
      L1 = L1.delete
      L3 = "firewall"
      L4 = A0[".name"]
      L1(L2, L3, L4)
      ::lbl_14::
    end
    L3(L4, L5, L6, L7)
  end
  return L2
end
del_zone = L11
function L11(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = false
  L4 = _valid_id
  L5 = A2
  L4 = L4(L5)
  if L4 then
    L5 = A0
    L4 = A0.get_zone
    L6 = A2
    L4 = L4(L5, L6)
    if not L4 then
      L4 = _UPVALUE0_
      L5 = L4
      L4 = L4.foreach
      L6 = "firewall"
      L7 = "zone"
      function L8(A0)
        local L1, L2, L3, L4, L5, L6
        L1 = _UPVALUE0_
        if L1 then
          L1 = A0.name
          L2 = _UPVALUE0_
          if L1 == L2 then
            L1 = A0.network
            if not L1 then
              L1 = _UPVALUE1_
              L2 = L1
              L1 = L1.set
              L3 = "firewall"
              L4 = A0[".name"]
              L5 = "network"
              L6 = _UPVALUE0_
              L1(L2, L3, L4, L5, L6)
            end
            L1 = _UPVALUE1_
            L2 = L1
            L1 = L1.set
            L3 = "firewall"
            L4 = A0[".name"]
            L5 = "name"
            L6 = _UPVALUE2_
            L1(L2, L3, L4, L5, L6)
            L1 = true
            _UPVALUE3_ = L1
            L1 = false
            return L1
          end
        end
      end
      L4(L5, L6, L7, L8)
      if L3 then
        L4 = _UPVALUE0_
        L5 = L4
        L4 = L4.foreach
        L6 = "firewall"
        L7 = "rule"
        function L8(A0)
          local L1, L2, L3, L4, L5, L6
          L1 = A0.src
          L2 = _UPVALUE0_
          if L1 == L2 then
            L1 = _UPVALUE1_
            L2 = L1
            L1 = L1.set
            L3 = "firewall"
            L4 = A0[".name"]
            L5 = "src"
            L6 = _UPVALUE2_
            L1(L2, L3, L4, L5, L6)
          end
          L1 = A0.dest
          L2 = _UPVALUE0_
          if L1 == L2 then
            L1 = _UPVALUE1_
            L2 = L1
            L1 = L1.set
            L3 = "firewall"
            L4 = A0[".name"]
            L5 = "dest"
            L6 = _UPVALUE2_
            L1(L2, L3, L4, L5, L6)
          end
        end
        L4(L5, L6, L7, L8)
        L4 = _UPVALUE0_
        L5 = L4
        L4 = L4.foreach
        L6 = "firewall"
        L7 = "redirect"
        function L8(A0)
          local L1, L2, L3, L4, L5, L6
          L1 = A0.src
          L2 = _UPVALUE0_
          if L1 == L2 then
            L1 = _UPVALUE1_
            L2 = L1
            L1 = L1.set
            L3 = "firewall"
            L4 = A0[".name"]
            L5 = "src"
            L6 = _UPVALUE2_
            L1(L2, L3, L4, L5, L6)
          end
          L1 = A0.dest
          L2 = _UPVALUE0_
          if L1 == L2 then
            L1 = _UPVALUE1_
            L2 = L1
            L1 = L1.set
            L3 = "firewall"
            L4 = A0[".name"]
            L5 = "dest"
            L6 = _UPVALUE2_
            L1(L2, L3, L4, L5, L6)
          end
        end
        L4(L5, L6, L7, L8)
        L4 = _UPVALUE0_
        L5 = L4
        L4 = L4.foreach
        L6 = "firewall"
        L7 = "forwarding"
        function L8(A0)
          local L1, L2, L3, L4, L5, L6
          L1 = A0.src
          L2 = _UPVALUE0_
          if L1 == L2 then
            L1 = _UPVALUE1_
            L2 = L1
            L1 = L1.set
            L3 = "firewall"
            L4 = A0[".name"]
            L5 = "src"
            L6 = _UPVALUE2_
            L1(L2, L3, L4, L5, L6)
          end
          L1 = A0.dest
          L2 = _UPVALUE0_
          if L1 == L2 then
            L1 = _UPVALUE1_
            L2 = L1
            L1 = L1.set
            L3 = "firewall"
            L4 = A0[".name"]
            L5 = "dest"
            L6 = _UPVALUE2_
            L1(L2, L3, L4, L5, L6)
          end
        end
        L4(L5, L6, L7, L8)
      end
    end
  end
  return L3
end
rename_zone = L11
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  if A1 then
    L6, L7, L8, L9, L10 = L4(L5)
    for L6, L7 in L3, L4, L5 do
      L9 = L7
      L8 = L7.del_network
      L10 = A1
      L8(L9, L10)
    end
  end
end
del_network = L11
L11 = L7.class
L11 = L11()
defaults = L11
L11 = defaults
function L12(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.foreach
  L3 = "firewall"
  L4 = "defaults"
  function L5(A0)
    local L1, L2
    L1 = _UPVALUE0_
    L2 = A0[".name"]
    L1.sid = L2
    L1 = false
    return L1
  end
  L1(L2, L3, L4, L5)
  L1 = A0.sid
  if not L1 then
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.section
    L3 = "firewall"
    L4 = "defaults"
    L5 = nil
    L6 = {}
    L1 = L1(L2, L3, L4, L5, L6)
  end
  A0.sid = L1
end
L11.__init__ = L12
L11 = defaults
function L12(A0, A1)
  local L2, L3, L4, L5
  L2 = _get
  L3 = "firewall"
  L4 = A0.sid
  L5 = A1
  return L2(L3, L4, L5)
end
L11.get = L12
L11 = defaults
function L12(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _set
  L4 = "firewall"
  L5 = A0.sid
  L6 = A1
  L7 = A2
  return L3(L4, L5, L6, L7)
end
L11.set = L12
L11 = defaults
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "syn_flood"
  L1 = L1(L2, L3)
  L1 = L1 == "1"
  return L1
end
L11.syn_flood = L12
L11 = defaults
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "drop_invalid"
  L1 = L1(L2, L3)
  L1 = L1 == "1"
  return L1
end
L11.drop_invalid = L12
L11 = defaults
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "input"
  L1 = L1(L2, L3)
  L1 = L1 or L1
  return L1
end
L11.input = L12
L11 = defaults
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "forward"
  L1 = L1(L2, L3)
  L1 = L1 or L1
  return L1
end
L11.forward = L12
L11 = defaults
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "output"
  L1 = L1(L2, L3)
  L1 = L1 or L1
  return L1
end
L11.output = L12
L11 = L7.class
L11 = L11()
zone = L11
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "firewall"
  L5 = A1
  L2 = L2(L3, L4, L5)
  if L2 == "zone" then
    A0.sid = A1
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.get_all
    L4 = "firewall"
    L5 = A1
    L2 = L2(L3, L4, L5)
    A0.data = L2
  else
    L2 = _UPVALUE0_
    L3 = L2
    L2 = L2.foreach
    L4 = "firewall"
    L5 = "zone"
    function L6(A0)
      local L1, L2
      L1 = A0.name
      L2 = _UPVALUE0_
      if L1 == L2 then
        L1 = _UPVALUE1_
        L2 = A0[".name"]
        L1.sid = L2
        L1 = _UPVALUE1_
        L1.data = A0
        L1 = false
        return L1
      end
    end
    L2(L3, L4, L5, L6)
  end
end
L11.__init__ = L12
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5
  L2 = _get
  L3 = "firewall"
  L4 = A0.sid
  L5 = A1
  return L2(L3, L4, L5)
end
L11.get = L12
L11 = zone
function L12(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _set
  L4 = "firewall"
  L5 = A0.sid
  L6 = A1
  L7 = A2
  return L3(L4, L5, L6, L7)
end
L11.set = L12
L11 = zone
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "masq"
  L1 = L1(L2, L3)
  L1 = L1 == "1"
  return L1
end
L11.masq = L12
L11 = zone
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "name"
  return L1(L2, L3)
end
L11.name = L12
L11 = zone
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "network"
  return L1(L2, L3)
end
L11.network = L12
L11 = zone
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "input"
  L1 = L1(L2, L3)
  if not L1 then
    L1 = defaults
    L1 = L1()
    L2 = L1
    L1 = L1.input
    L1 = L1(L2)
    L1 = L1 or L1
  end
  return L1
end
L11.input = L12
L11 = zone
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "forward"
  L1 = L1(L2, L3)
  if not L1 then
    L1 = defaults
    L1 = L1()
    L2 = L1
    L1 = L1.forward
    L1 = L1(L2)
    L1 = L1 or L1
  end
  return L1
end
L11.forward = L12
L11 = zone
function L12(A0)
  local L1, L2, L3
  L2 = A0
  L1 = A0.get
  L3 = "output"
  L1 = L1(L2, L3)
  if not L1 then
    L1 = defaults
    L1 = L1()
    L2 = L1
    L1 = L1.output
    L1 = L1(L2)
    L1 = L1 or L1
  end
  return L1
end
L11.output = L12
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L2 = L2(L3, L4, L5)
  if L2 == "interface" then
    L2 = {}
    L3 = nil
    L7 = "network"
    if not L5 then
      L7 = "name"
    end
    for L7 in L4, L5, L6 do
      if L7 ~= A1 then
        L8 = #L2
        L8 = L8 + 1
        L2[L8] = L7
      end
    end
    L2[L4] = A1
    L4(L5, L6)
    L7 = _UPVALUE2_
    L7 = L7.concat
    L8 = L2
    L9 = " "
    L7, L8, L9 = L7(L8, L9)
    L4(L5, L6, L7, L8, L9)
  end
end
L11.add_network = L12
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = {}
  L3 = nil
  L7 = "network"
  if not L5 then
    L7 = "name"
  end
  for L7 in L4, L5, L6 do
    if L7 ~= A1 then
      L8 = #L2
      L8 = L8 + 1
      L2[L8] = L7
    end
  end
  if 0 < L4 then
    L7 = _UPVALUE1_
    L7 = L7.concat
    L8 = L2
    L9 = " "
    L7, L8, L9 = L7(L8, L9)
    L4(L5, L6, L7, L8, L9)
  else
    L7 = " "
    L4(L5, L6, L7)
  end
end
L11.del_network = L12
L11 = zone
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = {}
  L2 = nil
  L6 = "network"
  if not L4 then
    L6 = "name"
  end
  for L6 in L3, L4, L5 do
    L7 = #L1
    L7 = L7 + 1
    L1[L7] = L6
  end
  return L1
end
L11.get_networks = L12
L11 = zone
function L12(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.set
  L3 = "network"
  L4 = " "
  L1(L2, L3, L4)
end
L11.clear_networks = L12
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L3 = A0
  L2 = A0.name
  L2 = L2(L3)
  L3 = {}
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.foreach
  L6 = "firewall"
  L7 = "forwarding"
  function L8(A0)
    local L1, L2, L3, L4
    L1 = A0.src
    if L1 then
      L1 = A0.dest
      if L1 then
        L1 = _UPVALUE0_
        L1 = A0[L1]
        L2 = _UPVALUE1_
        if L1 == L2 then
          L1 = _UPVALUE2_
          L2 = _UPVALUE2_
          L2 = #L2
          L2 = L2 + 1
          L3 = forwarding
          L4 = A0[".name"]
          L3 = L3(L4)
          L1[L2] = L3
        end
      end
    end
  end
  L4(L5, L6, L7, L8)
  return L3
end
L11.get_forwardings_by = L12
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L7 = "src"
  L7, L8, L9, L10, L11 = L5(L6, L7)
  for L7, L8 in L4, L5, L6 do
    L10 = L8
    L9 = L8.dest
    L9 = L9(L10)
    if L9 == A1 then
      L2 = true
      break
    end
  end
  if not L2 then
    if A1 ~= L4 then
      if L4 then
        L7 = "forwarding"
        L8 = nil
        L9 = {}
        L11 = A0
        L10 = A0.name
        L10 = L10(L11)
        L9.src = L10
        L9.dest = A1
        if L4 then
        end
        return L5
      end
    end
  end
end
L11.add_forwarding_to = L12
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L7 = "dest"
  L7, L8, L9, L10, L11 = L5(L6, L7)
  for L7, L8 in L4, L5, L6 do
    L10 = L8
    L9 = L8.src
    L9 = L9(L10)
    if L9 == A1 then
      L2 = true
      break
    end
  end
  if not L2 then
    if A1 ~= L4 then
      if L4 then
        L7 = "forwarding"
        L8 = nil
        L9 = {}
        L9.src = A1
        L11 = A0
        L10 = A0.name
        L10 = L10(L11)
        L9.dest = L10
        if L4 then
        end
        return L5
      end
    end
  end
end
L11.add_forwarding_from = L12
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L3 = A0
  L2 = A0.name
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.delete_all
  L5 = "firewall"
  L6 = "forwarding"
  function L7(A0)
    local L1, L2
    L1 = A0.src
    if L1 then
      L1 = A0.dest
      if L1 then
        L1 = _UPVALUE0_
        L1 = A0[L1]
        L2 = _UPVALUE1_
        L1 = L1 == L2
      end
    end
    return L1
  end
  L3(L4, L5, L6, L7)
end
L11.del_forwardings_by = L12
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if not A1 then
    L2 = {}
    A1 = L2
  end
  L3 = A0
  L2 = A0.name
  L2 = L2(L3)
  A1.src = L2
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.section
  L4 = "firewall"
  L5 = "redirect"
  L6 = nil
  L7 = A1
  L2 = L2(L3, L4, L5, L6, L7)
  L3 = L2 or L3
  if L2 then
    L3 = redirect
    L4 = L2
    L3 = L3(L4)
  end
  return L3
end
L11.add_redirect = L12
L11 = zone
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if not A1 then
    L2 = {}
    A1 = L2
  end
  L3 = A0
  L2 = A0.name
  L2 = L2(L3)
  A1.src = L2
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.section
  L4 = "firewall"
  L5 = "rule"
  L6 = nil
  L7 = A1
  L2 = L2(L3, L4, L5, L6, L7)
  L3 = L2 or L3
  if L2 then
    L3 = rule
    L4 = L2
    L3 = L3(L4)
  end
  return L3
end
L11.add_rule = L12
L11 = zone
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  if A0 then
    L2 = A0
    L1 = A0.name
    L1 = L1(L2)
    if L1 == "lan" then
      L1 = "#90f090"
      return L1
  end
  else
    if A0 then
      L2 = A0
      L1 = A0.name
      L1 = L1(L2)
      if L1 == "wan" then
        L1 = "#f09090"
        return L1
    end
    elseif A0 then
      L1 = _UPVALUE0_
      L1 = L1.randomseed
      L2 = _UPVALUE1_
      L2 = L2.hash
      L4 = A0
      L3 = A0.name
      L3, L4, L5, L6, L7, L8, L9 = L3(L4)
      L2, L3, L4, L5, L6, L7, L8, L9 = L2(L3, L4, L5, L6, L7, L8, L9)
      L1(L2, L3, L4, L5, L6, L7, L8, L9)
      L1 = _UPVALUE0_
      L1 = L1.random
      L2 = 128
      L1 = L1(L2)
      L2 = _UPVALUE0_
      L2 = L2.random
      L3 = 128
      L2 = L2(L3)
      L3 = 0
      L4 = 128
      L5 = L1 + L2
      if L5 < 128 then
        L5 = 128 - L1
        L3 = L5 - L2
      else
        L5 = 255 - L1
        L4 = L5 - L2
      end
      L5 = _UPVALUE0_
      L5 = L5.floor
      L6 = _UPVALUE0_
      L6 = L6.random
      L6 = L6()
      L7 = L4 - L3
      L6 = L6 * L7
      L5 = L5(L6)
      L5 = L3 + L5
      L6 = {}
      L7 = 255 - L1
      L8 = 255 - L2
      L9 = 255 - L5
      L6[1] = L7
      L6[2] = L8
      L6[3] = L9
      L6 = "#%02x%02x%02x" % L6
      return L6
    else
      L1 = "#eeeeee"
      return L1
    end
  end
end
L11.get_color = L12
L11 = L7.class
L11 = L11()
forwarding = L11
L11 = forwarding
function L12(A0, A1)
  A0.sid = A1
end
L11.__init__ = L12
L11 = forwarding
function L12(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "firewall"
  L4 = A0.sid
  L5 = "src"
  return L1(L2, L3, L4, L5)
end
L11.src = L12
L11 = forwarding
function L12(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "firewall"
  L4 = A0.sid
  L5 = "dest"
  return L1(L2, L3, L4, L5)
end
L11.dest = L12
L11 = forwarding
function L12(A0)
  local L1, L2, L3
  L1 = zone
  L3 = A0
  L2 = A0.src
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
L11.src_zone = L12
L11 = forwarding
function L12(A0)
  local L1, L2, L3
  L1 = zone
  L3 = A0
  L2 = A0.dest
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
L11.dest_zone = L12
L11 = L7.class
L11 = L11()
rule = L11
L11 = rule
function L12(A0, A1)
  A0.sid = A1
end
L11.__init__ = L12
L11 = rule
function L12(A0, A1)
  local L2, L3, L4, L5
  L2 = _get
  L3 = "firewall"
  L4 = A0.sid
  L5 = A1
  return L2(L3, L4, L5)
end
L11.get = L12
L11 = rule
function L12(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _set
  L4 = "firewall"
  L5 = A0.sid
  L6 = A1
  L7 = A2
  return L3(L4, L5, L6, L7)
end
L11.set = L12
L11 = rule
function L12(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "firewall"
  L4 = A0.sid
  L5 = "src"
  return L1(L2, L3, L4, L5)
end
L11.src = L12
L11 = rule
function L12(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "firewall"
  L4 = A0.sid
  L5 = "dest"
  return L1(L2, L3, L4, L5)
end
L11.dest = L12
L11 = rule
function L12(A0)
  local L1, L2, L3
  L1 = zone
  L3 = A0
  L2 = A0.src
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
L11.src_zone = L12
L11 = rule
function L12(A0)
  local L1, L2, L3
  L1 = zone
  L3 = A0
  L2 = A0.dest
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
L11.dest_zone = L12
L11 = L7.class
L11 = L11()
redirect = L11
L11 = redirect
function L12(A0, A1)
  A0.sid = A1
end
L11.__init__ = L12
L11 = redirect
function L12(A0, A1)
  local L2, L3, L4, L5
  L2 = _get
  L3 = "firewall"
  L4 = A0.sid
  L5 = A1
  return L2(L3, L4, L5)
end
L11.get = L12
L11 = redirect
function L12(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = _set
  L4 = "firewall"
  L5 = A0.sid
  L6 = A1
  L7 = A2
  return L3(L4, L5, L6, L7)
end
L11.set = L12
L11 = redirect
function L12(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "firewall"
  L4 = A0.sid
  L5 = "src"
  return L1(L2, L3, L4, L5)
end
L11.src = L12
L11 = redirect
function L12(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "firewall"
  L4 = A0.sid
  L5 = "dest"
  return L1(L2, L3, L4, L5)
end
L11.dest = L12
L11 = redirect
function L12(A0)
  local L1, L2, L3
  L1 = zone
  L3 = A0
  L2 = A0.src
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
L11.src_zone = L12
L11 = redirect
function L12(A0)
  local L1, L2, L3
  L1 = zone
  L3 = A0
  L2 = A0.dest
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
L11.dest_zone = L12
