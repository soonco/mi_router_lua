local L0, L1, L2, L3, L4, L5
L0 = require
L1 = "nixio.fs"
L0 = L0(L1)
L1 = SimpleForm
L2 = "firewall"
L3 = translate
L4 = "Firewall - Custom Rules"
L3 = L3(L4)
L4 = translate
L5 = [[
Custom rules allow you to execute arbritary iptables commands 
		which are not otherwise covered by the firewall framework. 
		The commands are executed after each firewall restart, right after 
		the default ruleset has been loaded.]]
L4, L5 = L4(L5)
L1 = L1(L2, L3, L4, L5)
L3 = L1
L2 = L1.field
L4 = Value
L5 = "_custom"
L2 = L2(L3, L4, L5)
L2.template = "cbi/tvalue"
L2.rows = 20
function L3(A0, A1)
  local L2, L3
  L2 = _UPVALUE0_
  L2 = L2.readfile
  L3 = "/etc/firewall.user"
  return L2(L3)
end
L2.cfgvalue = L3
function L3(A0, A1, A2)
  local L3, L4, L5, L6
  L4 = A2
  L3 = A2.gsub
  L5 = "\r\n?"
  L6 = "\n"
  L3 = L3(L4, L5, L6)
  A2 = L3
  L3 = _UPVALUE0_
  L3 = L3.writefile
  L4 = "/etc/firewall.user"
  L5 = A2
  L3(L4, L5)
end
L2.write = L3
return L1
