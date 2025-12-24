local L0, L1, L2
L0 = module
L1 = "xiaoqiang.util.XQBrUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "cjson"
L1 = L1(L2)
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = "/sys/class/net/"
  L2 = A0
  L3 = "/brif"
  L1 = L1 .. L2 .. L3
  L2 = io
  L2 = L2.open
  L3 = L1
  L2 = L2(L3)
  if L2 == nil then
    L3 = nil
    return L3
  end
  L4 = L2
  L3 = L2.close
  L3(L4)
  L3 = get_port_map
  L4 = A0
  L3 = L3(L4)
  if A0 == nil then
    L4 = nil
    return L4
  end
  L4 = "cat /sys/class/net/"
  L5 = A0
  L4 = L4 .. L5 .. L6 .. L7 .. L8
  L5 = _UPVALUE0_
  L5 = L5.execl
  L5 = L5(L6)
  macs_table = L5
  L5 = {}
  for L9, L10 in L6, L7, L8 do
    L11 = {}
    L12 = _UPVALUE0_
    L12 = L12.split
    L13 = L10
    L14 = ";"
    L12 = L12(L13, L14)
    fields = L12
    L12 = fields
    L12 = L12[1]
    L11.no = L12
    L12 = tonumber
    L13 = L11.no
    L12 = L12(L13)
    L12 = L3[L12]
    L11.dev = L12
    L12 = fields
    L12 = L12[2]
    L11.mac = L12
    L12 = fields
    L12 = L12[3]
    L11.is_local = L12
    L12 = _UPVALUE0_
    L12 = L12.trim
    L13 = fields
    L13 = L13[4]
    L12 = L12(L13)
    L11.ageing = L12
    L12 = table
    L12 = L12.insert
    L13 = L5
    L14 = L11
    L12(L13, L14)
  end
  return L5
end
get_macs = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = {}
  L2 = "ls /sys/class/net/"
  L2 = L2 .. L3 .. L4
  files = L3
  for L6, L7 in L3, L4, L5 do
    L8 = "/sys/class/net/"
    L9 = A0
    L10 = "/brif/"
    L11 = L7
    L12 = "/port_no"
    L8 = L8 .. L9 .. L10 .. L11 .. L12
    L9 = io
    L9 = L9.open
    L10 = L8
    L9 = L9(L10)
    if L9 == nil then
      L10 = nil
      return L10
    end
    L11 = L9
    L10 = L9.read
    L12 = "*a"
    L10 = L10(L11, L12)
    L12 = L9
    L11 = L9.close
    L11(L12)
    L11 = tonumber
    L12 = L10
    L11 = L11(L12)
    L1[L11] = L7
  end
  return L1
end
get_port_map = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  macs = L1
  L4 = A0
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13 = L2(L3, L4)
  L1(L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13)
  if L1 == nil then
    L1(L2)
    return L1
  end
  L4, L5, L6, L7, L8, L9, L10, L11, L12, L13 = L2(L3)
  L1(L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13)
  for L4, L5 in L1, L2, L3 do
    L6 = print
    L7 = string
    L7 = L7.format
    L8 = "%3s\t%s\t%s\t%s\t\t%8s"
    L9 = L5.no
    L10 = L5.dev
    L11 = L5.mac
    L12 = L5.is_local
    L13 = L5.ageing
    L7, L8, L9, L10, L11, L12, L13 = L7(L8, L9, L10, L11, L12, L13)
    L6(L7, L8, L9, L10, L11, L12, L13)
  end
end
print_br_macs = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L3 = "br-guest"
  L1[1] = L2
  L1[2] = L3
  for L3, L4 in L0, L1, L2 do
    L5 = print_br_macs
    L6 = L4
    L5(L6)
  end
end
print_all_macs = L2
