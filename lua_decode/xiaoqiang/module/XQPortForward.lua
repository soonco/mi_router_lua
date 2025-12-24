local L0, L1, L2
L0 = module
L1 = "xiaoqiang.module.XQPortForward"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = 0
ALL_NORMAL = L2
L2 = 1
ERR_EMPTY = L2
L2 = 2
ERR_CHECK_FAILED = L2
L2 = 3
ERR_DMZ_ON = L2
L2 = 4
ERR_RELATIVE = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = ".%d+$"
  if A1 == "255.255.0.0" then
    L3 = ".%d+.%d+$"
  end
  L5 = A0
  L4 = A0.gsub
  L6 = L3
  L7 = ""
  L4 = L4(L5, L6, L7)
  L6 = L2
  L5 = L2.foreach
  L7 = "firewall"
  L8 = "redirect"
  function L9(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8
    L1 = tonumber
    L2 = A0.ftype
    L1 = L1(L2)
    if L1 then
      L2 = A0.dest_ip
      L3 = _UPVALUE0_
      L5 = L2
      L4 = L2.match
      L6 = _UPVALUE1_
      L4 = L4(L5, L6)
      L2 = L3 .. L4
      L3 = _UPVALUE2_
      L4 = L3
      L3 = L3.set
      L5 = "firewall"
      L6 = A0[".name"]
      L7 = "dest_ip"
      L8 = L2
      L3(L4, L5, L6, L7, L8)
    end
  end
  L5(L6, L7, L8, L9)
  L6 = L2
  L5 = L2.commit
  L7 = "firewall"
  L5(L6, L7)
end
hookLanIPChangeEvent = L2
function L2(A0)
  local L1, L2
  if A0 then
    L1 = type
    L2 = A0
    L1 = L1(L2)
    if L1 == "number" then
      if A0 == 1 then
        L1 = "tcp"
        return L1
      elseif A0 == 2 then
        L1 = "udp"
        return L1
      elseif A0 == 3 then
        L1 = "tcpudp"
        return L1
      else
        L1 = "tcp"
        return L1
      end
    end
  end
  if A0 then
    L1 = type
    L2 = "proto"
    L1 = L1(L2)
    if L1 == "string" then
      if A0 == "tcp" then
        L1 = 1
        return L1
      elseif A0 == "udp" then
        L1 = 2
        return L1
      elseif A0 == "tcpudp" then
        L1 = 3
        return L1
      else
        L1 = 1
        return L1
      end
    end
  end
  L1 = nil
  return L1
end
_protoHelper = L2
function L2(A0)
  local L1, L2
  if A0 then
    L1 = type
    L2 = A0
    L1 = L1(L2)
    if L1 == "number" and 0 < A0 then
      L1 = true
      return L1
  end
  else
    L1 = false
    return L1
  end
end
_portCheck = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  if A0 and A1 then
    L3 = tostring
    L4 = A0
    L3 = L3(L4)
    A0 = L3
    L3 = tostring
    L4 = A1
    L3 = L3(L4)
    A1 = L3
    L3 = {}
    L4 = {}
    L6 = A0
    L5 = A0.match
    L7 = "-"
    L5 = L5(L6, L7)
    if L5 then
      L5 = L2.split
      L6 = A0
      L7 = "-"
      L5 = L5(L6, L7)
      L6 = tonumber
      L7 = L5[1]
      L6 = L6(L7)
      L3.f = L6
      L6 = tonumber
      L7 = L5[2]
      L6 = L6(L7)
      L3.t = L6
    else
      L5 = tonumber
      L6 = A0
      L5 = L5(L6)
      L3.f = L5
      L5 = tonumber
      L6 = A0
      L5 = L5(L6)
      L3.t = L5
    end
    L6 = A1
    L5 = A1.match
    L7 = "-"
    L5 = L5(L6, L7)
    if L5 then
      L5 = L2.split
      L6 = A1
      L7 = "-"
      L5 = L5(L6, L7)
      L6 = tonumber
      L7 = L5[1]
      L6 = L6(L7)
      L4.f = L6
      L6 = tonumber
      L7 = L5[2]
      L6 = L6(L7)
      L4.t = L6
    else
      L5 = tonumber
      L6 = A1
      L5 = L5(L6)
      L4.f = L5
      L5 = tonumber
      L6 = A1
      L5 = L5(L6)
      L4.t = L5
    end
    L5 = L3.f
    L6 = L4.f
    if L5 >= L6 then
      L5 = L3.f
      L6 = L4.t
      if L5 <= L6 then
        goto lbl_94
      end
    end
    L5 = L3.t
    L6 = L4.f
    if L5 >= L6 then
      L5 = L3.t
      L6 = L4.t
      if L5 <= L6 then
        goto lbl_94
      end
    end
    L5 = L3.t
    L6 = L4.t
    if L5 >= L6 then
      L5 = L3.f
      L6 = L4.f
      ::lbl_94::
      if L5 <= L6 then
        L5 = true
        return L5
      end
    end
  end
  L3 = false
  return L3
end
_portRangeOverlap = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = false
  L4 = L1
  L3 = L1.foreach
  L5 = "firewall"
  L6 = "redirect"
  function L7(A0)
    local L1, L2, L3
    L1 = _portRangeOverlap
    L2 = _UPVALUE0_
    L3 = A0.src_dport
    L1 = L1(L2, L3)
    if L1 then
      L1 = true
      _UPVALUE1_ = L1
    end
  end
  L3(L4, L5, L6, L7)
  return L2
end
_portConflictCheck = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = false
  L5 = L2
  L4 = L2.foreach
  L6 = "firewall"
  L7 = "redirect"
  function L8(A0)
    local L1, L2, L3
    L1 = _protoHelper
    L2 = A0.proto
    L1 = L1(L2)
    L2 = _UPVALUE0_
    if L1 ~= L2 then
      L1 = _UPVALUE0_
      if L1 ~= 3 then
        L1 = _protoHelper
        L2 = A0.proto
        L1 = L1(L2)
        if L1 ~= 3 then
          goto lbl_23
        end
      end
    end
    L1 = _portRangeOverlap
    L2 = _UPVALUE1_
    L3 = A0.src_dport
    L1 = L1(L2, L3)
    if L1 then
      L1 = true
      _UPVALUE2_ = L1
    end
    ::lbl_23::
  end
  L4(L5, L6, L7, L8)
  return L3
end
_portConflictCheckWithProto = L2
function L2()
  local L0, L1
  L0 = portForwards
  L1 = 0
  L0 = L0(L1)
  L0 = #L0
  L0 = 0 < L0
  return L0
end
moduleOn = L2
function L2()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.module.XQDMZModule"
  L0 = L0(L1)
  L1 = {}
  L2 = L0.moduleOn
  L2 = L2()
  if L2 then
    L1.status = 2
  else
    L2 = moduleOn
    L2 = L2()
    if L2 then
      L2 = 1
      if L2 then
        goto lbl_19
      end
    end
    L2 = 0
    ::lbl_19::
    L1.status = L2
  end
  return L1
end
portForwardInfo = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = {}
  L3 = tonumber
  L4 = A0
  L3 = L3(L4)
  L3 = L3 or L3
  L5 = L1
  L4 = L1.foreach
  L6 = "firewall"
  L7 = "redirect"
  function L8(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8
    L1 = tonumber
    L2 = A0.ftype
    L1 = L1(L2)
    if L1 then
      L2 = _UPVALUE0_
      if L2 == 0 then
        goto lbl_12
      end
    end
    L2 = _UPVALUE0_
    ::lbl_12::
    if L2 == L1 then
      L2 = {}
      L3 = A0.name
      L2.name = L3
      L3 = A0.dest_ip
      L2.destip = L3
      L3 = _protoHelper
      L4 = A0.proto
      L3 = L3(L4)
      L3 = L3 or L3
      L2.proto = L3
      if L1 == 1 then
        L3 = tonumber
        L4 = A0.src_dport
        L3 = L3(L4)
        L2.srcport = L3
        L3 = A0.dest_port
        L2.destport = L3
        L2.ftype = 1
      elseif L1 == 2 then
        L2.ftype = 2
        L3 = {}
        L4 = require
        L5 = "luci.util"
        L4 = L4(L5)
        L5 = L4.split
        L6 = A0.src_dport
        L7 = "-"
        L5 = L5(L6, L7)
        L6 = {}
        L7 = tonumber
        L8 = L5[1]
        L7 = L7(L8)
        L6.f = L7
        L7 = tonumber
        L8 = L5[2]
        L7 = L7(L8)
        L6.t = L7
        L2.srcport = L6
      end
      L3 = table
      L3 = L3.insert
      L4 = _UPVALUE1_
      L5 = L2
      L3(L4, L5)
    end
  end
  L4(L5, L6, L7, L8)
  return L2
end
portForwards = L2
function L2(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A1
  L5 = L5(L6)
  if not L5 then
    L5 = _portCheck
    L6 = tonumber
    L7 = A2
    L6, L7, L8, L9, L10, L11, L12, L13 = L6(L7)
    L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13)
    if L5 then
      L5 = _portCheck
      L6 = tonumber
      L7 = A3
      L6, L7, L8, L9, L10, L11, L12, L13 = L6(L7)
      L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13)
      if L5 then
        L5 = require
        L6 = "luci.model.uci"
        L5 = L5(L6)
        L5 = L5.cursor
        L5 = L5()
        L6 = portForwardInfo
        L6 = L6()
        L6 = L6.status
        if L6 == 2 then
          L6 = 3
          return L6
        end
        L6 = _portConflictCheckWithProto
        L7 = A2
        L8 = A4
        L6 = L6(L7, L8)
        if L6 then
          L6 = 2
          return L6
        end
        L6 = string
        L6 = L6.format
        L7 = "wan%srdr%s"
        L8 = tostring
        L9 = A2
        L8 = L8(L9)
        L9 = tostring
        L10 = A4
        L9, L10, L11, L12, L13 = L9(L10)
        L6 = L6(L7, L8, L9, L10, L11, L12, L13)
        L7 = {}
        L7.src = "wan"
        L7.src_dport = A2
        L8 = _protoHelper
        L9 = tonumber
        L10 = A4
        L9, L10, L11, L12, L13 = L9(L10)
        L8 = L8(L9, L10, L11, L12, L13)
        L8 = L8 or L8
        L7.proto = L8
        L7.target = "DNAT"
        L7.dest = "lan"
        L7.dest_port = A3
        L7.dest_ip = A1
        L7.ftype = 1
        L8 = A0 or L8
        if not A0 then
          L8 = ""
        end
        L7.name = L8
        L9 = L5
        L8 = L5.section
        L10 = "firewall"
        L11 = "redirect"
        L12 = L6
        L13 = L7
        L8(L9, L10, L11, L12, L13)
        L9 = L5
        L8 = L5.commit
        L10 = "firewall"
        L8(L9, L10)
        L8 = 0
        return L8
      end
    end
  end
  L5 = 1
  return L5
end
setPortForward = L2
function L2(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A1
  L5 = L5(L6)
  if not L5 then
    L5 = _portCheck
    L6 = tonumber
    L7 = A2
    L6, L7, L8, L9, L10, L11, L12, L13, L14 = L6(L7)
    L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14)
    if L5 then
      L5 = _portCheck
      L6 = tonumber
      L7 = A3
      L6, L7, L8, L9, L10, L11, L12, L13, L14 = L6(L7)
      L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13, L14)
      if L5 then
        L5 = tonumber
        L6 = A2
        L5 = L5(L6)
        L6 = tonumber
        L7 = A3
        L6 = L6(L7)
        if L5 > L6 then
          L5 = 1
          return L5
        end
        L5 = require
        L6 = "luci.model.uci"
        L5 = L5(L6)
        L5 = L5.cursor
        L5 = L5()
        L6 = tostring
        L7 = A2
        L6 = L6(L7)
        L7 = "-"
        L8 = tostring
        L9 = A3
        L8 = L8(L9)
        L6 = L6 .. L7 .. L8
        L7 = portForwardInfo
        L7 = L7()
        L7 = L7.status
        if L7 == 2 then
          L7 = 3
          return L7
        end
        L7 = _portConflictCheckWithProto
        L8 = L6
        L9 = A4
        L7 = L7(L8, L9)
        if L7 then
          L7 = 2
          return L7
        end
        L7 = string
        L7 = L7.format
        L8 = "wan%srdr%s"
        L9 = tostring
        L10 = A2
        L9 = L9(L10)
        L10 = tostring
        L11 = A4
        L10, L11, L12, L13, L14 = L10(L11)
        L7 = L7(L8, L9, L10, L11, L12, L13, L14)
        L8 = {}
        L8.src = "wan"
        L8.src_dport = L6
        L9 = _protoHelper
        L10 = tonumber
        L11 = A4
        L10, L11, L12, L13, L14 = L10(L11)
        L9 = L9(L10, L11, L12, L13, L14)
        L9 = L9 or L9
        L8.proto = L9
        L8.target = "DNAT"
        L8.dest = "lan"
        L8.dest_ip = A1
        L8.ftype = 2
        L9 = A0 or L9
        if not A0 then
          L9 = ""
        end
        L8.name = L9
        L10 = L5
        L9 = L5.section
        L11 = "firewall"
        L12 = "redirect"
        L13 = L7
        L14 = L8
        L9(L10, L11, L12, L13, L14)
        L10 = L5
        L9 = L5.commit
        L11 = "firewall"
        L9(L10, L11)
        L9 = 0
        return L9
      end
    end
  end
  L5 = 1
  return L5
end
setRangePortForward = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = _portCheck
  L3 = tonumber
  L4 = A0
  L3, L4, L5, L6, L7 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7)
  if L2 then
    L2 = require
    L3 = "luci.model.uci"
    L2 = L2(L3)
    L2 = L2.cursor
    L2 = L2()
    L3 = string
    L3 = L3.format
    L4 = "wan%srdr%s"
    L5 = tostring
    L6 = A0
    L5 = L5(L6)
    L6 = tostring
    L7 = A1
    L6, L7 = L6(L7)
    L3 = L3(L4, L5, L6, L7)
    L5 = L2
    L4 = L2.delete
    L6 = "firewall"
    L7 = L3
    L4(L5, L6, L7)
    L5 = L2
    L4 = L2.commit
    L6 = "firewall"
    L4(L5, L6)
    L4 = true
    return L4
  end
  L2 = false
  return L2
end
deletePortForward = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.delete_all
  L3 = "firewall"
  L4 = "redirect"
  function L5(A0)
    local L1
    L1 = A0.ftype
    if L1 then
      L1 = true
      return L1
    else
      L1 = false
      return L1
    end
  end
  L1(L2, L3, L4, L5)
  L2 = L0
  L1 = L0.commit
  L3 = "firewall"
  L1(L2, L3)
  L1 = true
  return L1
end
deleteAllPortForward = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.foreach
  L5 = "firewall"
  L6 = "redirect"
  function L7(A0)
    local L1, L2, L3, L4, L5
    L1 = A0.app_name
    if L1 == "Virtual Server" then
      L2 = {}
      L3 = A0.name
      L2.name = L3
      L3 = A0.service
      L2.service = L3
      L3 = protoToUpper
      L4 = A0.proto
      L3 = L3(L4)
      L2.protocol = L3
      L3 = A0.src_dport
      L2.export = L3
      L3 = A0.dest_port
      L3 = L3 or L3
      L2.inport = L3
      L3 = A0.dest_ip
      L2.ip = L3
      L3 = A0.web_del
      if L3 == "0" then
        L3 = "0"
        if L3 then
          goto lbl_29
        end
      end
      L3 = "1"
      ::lbl_29::
      L2.web_del = L3
      L3 = table
      L3 = L3.insert
      L4 = _UPVALUE0_
      L5 = L2
      L3(L4, L5)
    end
  end
  L3(L4, L5, L6, L7)
  return L0
end
VSInfo = L2
function L2(A0)
  local L1, L2
  if A0 then
    L1 = type
    L2 = A0
    L1 = L1(L2)
    if L1 == "number" then
      if A0 == 1 then
        L1 = "tcp"
        return L1
      elseif A0 == 2 then
        L1 = "udp"
        return L1
      elseif A0 == 3 then
        L1 = "tcpudp"
        return L1
      else
        L1 = "tcp"
        return L1
      end
    end
  end
  L1 = nil
  return L1
end
numberToProto = L2
function L2(A0)
  local L1, L2
  if A0 then
    L1 = type
    L2 = "proto"
    L1 = L1(L2)
    if L1 == "string" then
      if A0 == "TCP" then
        L1 = "tcp"
        return L1
      elseif A0 == "UDP" then
        L1 = "udp"
        return L1
      elseif A0 == "ALL" then
        L1 = "tcpudp"
        return L1
      else
        L1 = "tcp"
        return L1
      end
    end
  end
  L1 = nil
  return L1
end
protoToLower = L2
function L2(A0)
  local L1, L2
  if A0 then
    L1 = type
    L2 = "proto"
    L1 = L1(L2)
    if L1 == "string" then
      if A0 == "tcp" then
        L1 = "TCP"
        return L1
      elseif A0 == "udp" then
        L1 = "UDP"
        return L1
      elseif A0 == "tcpudp" then
        L1 = "ALL"
        return L1
      else
        L1 = "TCP"
        return L1
      end
    end
  end
  L1 = nil
  return L1
end
protoToUpper = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  if A0 and A1 then
    L3 = tostring
    L4 = A0
    L3 = L3(L4)
    A0 = L3
    L3 = tostring
    L4 = A1
    L3 = L3(L4)
    A1 = L3
    L3 = {}
    L4 = {}
    L6 = A0
    L5 = A0.match
    L7 = "-"
    L5 = L5(L6, L7)
    if L5 then
      L5 = L2.split
      L6 = A0
      L7 = "-"
      L5 = L5(L6, L7)
      L6 = tonumber
      L7 = L5[1]
      L6 = L6(L7)
      L3.f = L6
      L6 = tonumber
      L7 = L5[2]
      L6 = L6(L7)
      L3.t = L6
    else
      L5 = tonumber
      L6 = A0
      L5 = L5(L6)
      L3.f = L5
      L5 = tonumber
      L6 = A0
      L5 = L5(L6)
      L3.t = L5
    end
    L6 = A1
    L5 = A1.match
    L7 = "-"
    L5 = L5(L6, L7)
    if L5 then
      L5 = L2.split
      L6 = A1
      L7 = "-"
      L5 = L5(L6, L7)
      L6 = tonumber
      L7 = L5[1]
      L6 = L6(L7)
      L4.f = L6
      L6 = tonumber
      L7 = L5[2]
      L6 = L6(L7)
      L4.t = L6
    else
      L5 = tonumber
      L6 = A1
      L5 = L5(L6)
      L4.f = L5
      L5 = tonumber
      L6 = A1
      L5 = L5(L6)
      L4.t = L5
    end
    L5 = L3.f
    L6 = L4.f
    if L5 >= L6 then
      L5 = L3.f
      L6 = L4.t
      if L5 <= L6 then
        goto lbl_94
      end
    end
    L5 = L3.t
    L6 = L4.f
    if L5 >= L6 then
      L5 = L3.t
      L6 = L4.t
      if L5 <= L6 then
        goto lbl_94
      end
    end
    L5 = L3.t
    L6 = L4.t
    if L5 >= L6 then
      L5 = L3.f
      L6 = L4.f
      ::lbl_94::
      if L5 <= L6 then
        L5 = true
        return L5
      end
    end
  end
  L3 = false
  return L3
end
VS_portRangeOverlap = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = false
  L5 = L2
  L4 = L2.foreach
  L6 = "firewall"
  L7 = "redirect"
  function L8(A0)
    local L1, L2, L3
    L1 = A0.proto
    L2 = protoToLower
    L3 = _UPVALUE0_
    L2 = L2(L3)
    if L1 ~= L2 then
      L1 = _UPVALUE0_
      if L1 ~= "ALL" then
        L1 = A0.proto
        if L1 ~= "tcpudp" then
          goto lbl_21
        end
      end
    end
    L1 = VS_portRangeOverlap
    L2 = _UPVALUE1_
    L3 = A0.src_dport
    L1 = L1(L2, L3)
    if L1 then
      L1 = true
      _UPVALUE2_ = L1
    end
    ::lbl_21::
  end
  L4(L5, L6, L7, L8)
  return L3
end
VSportConflictCheckWithProto = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = false
  L5 = L2
  L4 = L2.foreach
  L6 = "firewall"
  L7 = "porttrigger"
  function L8(A0)
    local L1, L2, L3
    L1 = A0.proto
    L2 = protoToLower
    L3 = _UPVALUE0_
    L2 = L2(L3)
    if L1 ~= L2 then
      L1 = _UPVALUE0_
      if L1 ~= "ALL" then
        L1 = A0.proto
        if L1 ~= "tcpudp" then
          goto lbl_21
        end
      end
    end
    L1 = VS_portRangeOverlap
    L2 = _UPVALUE1_
    L3 = A0.src_dport
    L1 = L1(L2, L3)
    if L1 then
      L1 = true
      _UPVALUE2_ = L1
    end
    ::lbl_21::
  end
  L4(L5, L6, L7, L8)
  return L3
end
PTportConflictCheckWithProto = L2
function L2(A0)
  local L1, L2, L3
  L1 = require
  L2 = "luci.cbi.datatypes"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = ERR_EMPTY
    return L2
  end
  L2 = L1.port
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = ALL_NORMAL
    return L2
  end
  L2 = ERR_CHECK_FAILED
  return L2
end
checkOnePort = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = checkOnePort
  L2 = A0
  L1 = L1(L2)
  L2 = ERR_CHECK_FAILED
  if L1 < L2 then
    return L1
  end
  L3 = A0
  L2 = A0.match
  L4 = "^(%d+)-(%d+)$"
  L2, L3 = L2(L3, L4)
  L4 = checkOnePort
  L5 = L2
  L4 = L4(L5)
  L5 = checkOnePort
  L6 = L3
  L5 = L5(L6)
  if L4 == 0 and L5 == 0 then
    L6 = tonumber
    L7 = L2
    L6 = L6(L7)
    L7 = tonumber
    L8 = L3
    L7 = L7(L8)
    if L6 >= L7 then
      L6 = ERR_RELATIVE
      return L6
    else
      L6 = ALL_NORMAL
      return L6
    end
  end
  L6 = L4 or L6
  if not (L4 > L5) or not L4 then
    L6 = L5
  end
  return L6
end
checkPort = L2
function L2(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L6 = require
  L7 = "luci.model.uci"
  L6 = L6(L7)
  L6 = L6.cursor
  L6 = L6()
  L7 = require
  L8 = "xiaoqiang.module.XQFirewall"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.module.XQDMZModule"
  L8 = L8(L9)
  L9 = tonumber
  L11 = L6
  L10 = L6.get
  L12 = "firewall"
  L13 = "vs"
  L14 = "rule_num"
  L10 = L10(L11, L12, L13, L14)
  L10 = L10 or L10
  L9 = L9(L10)
  L10 = L8.moduleOn
  L10 = L10()
  if L10 then
    L10 = ERR_DMZ_ON
    return L10
  end
  L10 = checkPort
  L11 = A3
  L10 = L10(L11)
  L11 = ALL_NORMAL
  if L10 ~= L11 then
    return L10
  end
  L11 = _UPVALUE0_
  L11 = L11.isStrNil
  L12 = A5
  L11 = L11(L12)
  if not L11 then
    L11 = L7.checkPort
    L12 = A4
    L11 = L11(L12)
    if L11 then
      L11 = VSportConflictCheckWithProto
      L12 = A3
      L13 = A2
      L11 = L11(L12, L13)
      if L11 then
        L11 = ERR_CHECK_FAILED
        return L11
      end
      L11 = string
      L11 = L11.format
      L12 = "vs%s_%s_%s"
      L13 = tostring
      L14 = A3
      L13 = L13(L14)
      L14 = tostring
      L15 = A4
      L14 = L14(L15)
      L15 = A2
      L11 = L11(L12, L13, L14, L15)
      L13 = L11
      L12 = L11.gsub
      L14 = "-"
      L15 = "_"
      L12 = L12(L13, L14, L15)
      L11 = L12
      L12 = {}
      L12.src = "wan"
      L12.target = "DNAT"
      L12.dest = "lan"
      L12.app_name = "Virtual Server"
      L13 = A1 or L13
      if not A1 then
        L13 = ""
      end
      L12.service = L13
      L12.enabled = 1
      L13 = A0 or L13
      if not A0 then
        L13 = ""
      end
      L12.name = L13
      L13 = protoToLower
      L14 = A2
      L13 = L13(L14)
      L13 = L13 or L13
      L12.proto = L13
      L12.src_dport = A3
      L12.dest_port = A4
      L12.dest_ip = A5
      L14 = L6
      L13 = L6.section
      L15 = "firewall"
      L16 = "redirect"
      L17 = L11
      L18 = L12
      L13(L14, L15, L16, L17, L18)
      L14 = L6
      L13 = L6.set
      L15 = "firewall"
      L16 = "vs"
      L17 = "rule_num"
      L18 = L9 + 1
      L13(L14, L15, L16, L17, L18)
      L14 = L6
      L13 = L6.commit
      L15 = "firewall"
      L13(L14, L15)
      L13 = ALL_NORMAL
      return L13
    end
  end
  L11 = ERR_EMPTY
  return L11
end
setVSRules = L2
function L2(A0, A1, A2, A3, A4, A5)
  local L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L6 = require
  L7 = "xiaoqiang.module.XQFirewall"
  L6 = L6(L7)
  L7 = require
  L8 = "luci.model.uci"
  L7 = L7(L8)
  L7 = L7.cursor
  L7 = L7()
  L8 = false
  L9 = tonumber
  L11 = L7
  L10 = L7.get
  L12 = "firewall"
  L13 = "vs"
  L14 = "rule_num"
  L10 = L10(L11, L12, L13, L14)
  L10 = L10 or L10
  L9 = L9(L10)
  L11 = L7
  L10 = L7.delete
  L12 = "firewall"
  L13 = A0
  L10 = L10(L11, L12, L13)
  if L10 then
    L11 = L7
    L10 = L7.set
    L12 = "firewall"
    L13 = "vs"
    L14 = "rule_num"
    L15 = L9 - 1
    L10(L11, L12, L13, L14, L15)
    L11 = L7
    L10 = L7.commit
    L12 = "firewall"
    L10(L11, L12)
    L8 = true
  else
    L10 = L6.checkPort
    L11 = A3
    L10 = L10(L11)
    if L10 then
      L10 = L6.checkPort
      L11 = A4
      L10 = L10(L11)
      if L10 then
        L10 = string
        L10 = L10.format
        L11 = "vs%s_%s_%s"
        L12 = tostring
        L13 = A3
        L12 = L12(L13)
        L13 = tostring
        L14 = A4
        L13 = L13(L14)
        L14 = tostring
        L15 = A2
        L14, L15, L16 = L14(L15)
        L10 = L10(L11, L12, L13, L14, L15, L16)
        L12 = L10
        L11 = L10.gsub
        L13 = "-"
        L14 = "_"
        L11 = L11(L12, L13, L14)
        L10 = L11
        L12 = L7
        L11 = L7.delete
        L13 = "firewall"
        L14 = L10
        L11 = L11(L12, L13, L14)
        if L11 then
          L12 = L7
          L11 = L7.set
          L13 = "firewall"
          L14 = "vs"
          L15 = "rule_num"
          L16 = L9 - 1
          L11(L12, L13, L14, L15, L16)
          L12 = L7
          L11 = L7.commit
          L13 = "firewall"
          L11(L12, L13)
        end
        L8 = true
      end
    end
  end
  return L8
end
deleteVSRule = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "firewall"
  L4 = "vs"
  L5 = "rule_num"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = 0
  L3 = tonumber
  L4 = L1
  L3 = L3(L4)
  L1 = L3
  if 0 < L1 then
    L4 = L0
    L3 = L0.foreach
    L5 = "firewall"
    L6 = "redirect"
    function L7(A0)
      local L1
      L1 = A0[".name"]
      if L1 ~= "dmz" then
        L1 = A0[".name"]
        if L1 ~= "dmzudp" then
          L1 = A0.enabled
          if L1 ~= "0" then
            L1 = _UPVALUE0_
            L1 = L1 + 1
            _UPVALUE0_ = L1
          end
        end
      end
    end
    L3(L4, L5, L6, L7)
    if 0 < L2 then
      L3 = true
      if L3 then
        goto lbl_33
      end
    end
    L3 = false
    ::lbl_33::
    return L3
  else
    L3 = false
    return L3
  end
end
VSOn = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "firewall"
  L4 = "pt"
  L5 = "rule_num"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  L2 = tonumber
  L3 = L1
  L2 = L2(L3)
  L1 = L2
  if 0 < L1 then
    L2 = true
    return L2
  else
    L2 = false
    return L2
  end
end
PTOn = L2
function L2(A0)
  local L1, L2
  if A0 then
    L1 = type
    L2 = A0
    L1 = L1(L2)
    if L1 == "number" and 0 < A0 and A0 < 65536 then
      L1 = true
      return L1
  end
  else
    L1 = false
    return L1
  end
end
VS_portCheck = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = tonumber
  L5 = L1
  L4 = L1.get
  L6 = "firewall"
  L7 = "vs"
  L8 = "maxrulenum"
  L4, L5, L6, L7, L8 = L4(L5, L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8)
  L3 = L3 or L3
  L5 = L1
  L4 = L1.get
  L6 = "firewall"
  L7 = "vs"
  L8 = "rule_num"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L5 = tonumber
  L6 = L4
  L5 = L5(L6)
  L4 = L5
  if L3 < L4 then
    L5 = 1
    return L5
  end
  L5 = 0
  return L5
end
checkAddMaxVSNumItem = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = false
  L4 = #A0
  L5 = {}
  L6 = tonumber
  L10 = "pt"
  L11 = "maxrulenum"
  L10, L11, L12, L13, L14 = L7(L8, L9, L10, L11)
  L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14)
  L6 = L6 or L6
  L10 = "porttrigger"
  function L11(A0)
    local L1, L2, L3
    L1 = A0.app_name
    if L1 == "Port Trigger" then
      L1 = table
      L1 = L1.insert
      L2 = _UPVALUE0_
      L3 = A0.tgport
      L1(L2, L3)
    end
  end
  L7(L8, L9, L10, L11)
  if 0 < L4 then
    L10 = ";"
    L10, L11, L12, L13, L14 = L8(L9, L10)
    for L10, L11 in L7, L8, L9 do
      L4 = #L11
      if 0 < L4 then
        L12 = table
        L12 = L12.insert
        L13 = L5
        L14 = L11
        L12(L13, L14)
      end
    end
  end
  if L6 < L7 then
    return L7
  end
  return L7
end
checkAddMaxPTNumItem = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.foreach
  L4 = "firewall"
  L5 = "porttrigger"
  function L6(A0)
    local L1, L2, L3, L4, L5
    L1 = A0.app_name
    if L1 == "Port Trigger" then
      L2 = {}
      L3 = A0.name
      L2.name = L3
      L3 = protoToUpper
      L4 = A0.tgprotocol
      L3 = L3(L4)
      L2.tgprotocol = L3
      L3 = protoToUpper
      L4 = A0.exprotocol
      L3 = L3(L4)
      L2.exprotocol = L3
      L3 = tonumber
      L4 = A0.tgport
      L3 = L3(L4)
      L2.tgport = L3
      L3 = tonumber
      L4 = A0.export
      L3 = L3(L4)
      L2.export = L3
      L3 = table
      L3 = L3.insert
      L4 = _UPVALUE0_
      L5 = L2
      L3(L4, L5)
    end
  end
  L2(L3, L4, L5, L6)
  return L1
end
PTInfo = L2
function L2(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L5 = require
  L6 = "luci.model.uci"
  L5 = L5(L6)
  L5 = L5.cursor
  L5 = L5()
  L6 = require
  L7 = "xiaoqiang.module.XQFirewall"
  L6 = L6(L7)
  L7 = require
  L8 = "xiaoqiang.module.XQDMZModule"
  L7 = L7(L8)
  L9 = L5
  L8 = L5.get
  L10 = "firewall"
  L11 = "pt"
  L12 = "rule_num"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L9 = tonumber
  L10 = L8
  L9 = L9(L10)
  L8 = L9
  L9 = L7.moduleOn
  L9 = L9()
  if L9 then
    L9 = 3
    return L9
  end
  L9 = L6.checkPort
  L10 = A2
  L9 = L9(L10)
  if L9 then
    L9 = L6.checkPort
    L10 = A4
    L9 = L9(L10)
    if L9 then
      L9 = PTportConflictCheckWithProto
      L10 = A2
      L11 = A1
      L9 = L9(L10, L11)
      if not L9 then
        L9 = PTportConflictCheckWithProto
        L10 = A4
        L11 = A3
        L9 = L9(L10, L11)
        if not L9 then
          goto lbl_54
        end
      end
      L9 = 2
      do return L9 end
      ::lbl_54::
      L9 = string
      L9 = L9.format
      L10 = "pt%s_%s_%s_%s"
      L11 = tostring
      L12 = A2
      L11 = L11(L12)
      L12 = tostring
      L13 = A1
      L12 = L12(L13)
      L13 = tostring
      L14 = A4
      L13 = L13(L14)
      L14 = tostring
      L15 = A3
      L14, L15, L16 = L14(L15)
      L9 = L9(L10, L11, L12, L13, L14, L15, L16)
      L11 = L9
      L10 = L9.gsub
      L12 = "-"
      L13 = "_"
      L10 = L10(L11, L12, L13)
      L9 = L10
      L10 = {}
      L10.src = "wan"
      L10.target = "TRIGGER"
      L10.dest = "lan"
      L10.app_name = "Port Trigger"
      L10.enabled = 1
      L11 = A0 or L11
      if not A0 then
        L11 = ""
      end
      L10.name = L11
      L11 = protoToLower
      L12 = A1
      L11 = L11(L12)
      L11 = L11 or L11
      L10.tgprotocol = L11
      L11 = protoToLower
      L12 = A3
      L11 = L11(L12)
      L11 = L11 or L11
      L10.exprotocol = L11
      L10.export = A4
      L10.tgport = A2
      L8 = L8 + 1
      L12 = L5
      L11 = L5.section
      L13 = "firewall"
      L14 = "porttrigger"
      L15 = L9
      L16 = L10
      L11(L12, L13, L14, L15, L16)
      L12 = L5
      L11 = L5.set
      L13 = "firewall"
      L14 = "@defaults[0]"
      L15 = "port_trigger"
      L16 = "1"
      L11(L12, L13, L14, L15, L16)
      L12 = L5
      L11 = L5.set
      L13 = "firewall"
      L14 = "pt"
      L15 = "rule_num"
      L16 = L8
      L11(L12, L13, L14, L15, L16)
      L12 = L5
      L11 = L5.commit
      L13 = "firewall"
      L11(L12, L13)
      L11 = 0
      return L11
    end
  end
  L9 = 1
  return L9
end
setPTRules = L2
function L2(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L5 = require
  L6 = "xiaoqiang.module.XQFirewall"
  L5 = L5(L6)
  L6 = require
  L7 = "luci.model.uci"
  L6 = L6(L7)
  L6 = L6.cursor
  L6 = L6()
  L8 = L6
  L7 = L6.get
  L9 = "firewall"
  L10 = "pt"
  L11 = "rule_num"
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L8 = tonumber
  L9 = L7
  L8 = L8(L9)
  L7 = L8
  L8 = L5.checkPort
  L9 = A4
  L8 = L8(L9)
  if L8 then
    L8 = L5.checkPort
    L9 = A2
    L8 = L8(L9)
    if L8 then
      L8 = string
      L8 = L8.format
      L9 = "pt%s_%s_%s_%s"
      L10 = tostring
      L11 = A2
      L10 = L10(L11)
      L11 = tostring
      L12 = A1
      L11 = L11(L12)
      L12 = tostring
      L13 = A4
      L12 = L12(L13)
      L13 = tostring
      L14 = A3
      L13, L14 = L13(L14)
      L8 = L8(L9, L10, L11, L12, L13, L14)
      L10 = L8
      L9 = L8.gsub
      L11 = "-"
      L12 = "_"
      L9 = L9(L10, L11, L12)
      L8 = L9
      L10 = L6
      L9 = L6.delete
      L11 = "firewall"
      L12 = L8
      L9(L10, L11, L12)
      L7 = L7 - 1
      L10 = L6
      L9 = L6.set
      L11 = "firewall"
      L12 = "pt"
      L13 = "rule_num"
      L14 = L7
      L9(L10, L11, L12, L13, L14)
      L10 = L6
      L9 = L6.commit
      L11 = "firewall"
      L9(L10, L11)
      L9 = true
      return L9
    end
  end
  L8 = false
  return L8
end
deletePTRule = L2
function L2(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12
  L5 = require
  L6 = "luci.model.uci"
  L5 = L5(L6)
  L5 = L5.cursor
  L5 = L5()
  L6 = string
  L6 = L6.format
  L7 = "pt%s_%s_%s_%s"
  L8 = tostring
  L9 = A2
  L8 = L8(L9)
  L9 = tostring
  L10 = A1
  L9 = L9(L10)
  L10 = tostring
  L11 = A4
  L10 = L10(L11)
  L11 = tostring
  L12 = A3
  L11, L12 = L11(L12)
  L6 = L6(L7, L8, L9, L10, L11, L12)
  L8 = L6
  L7 = L6.gsub
  L9 = "-"
  L10 = "_"
  L7 = L7(L8, L9, L10)
  L6 = L7
  L7 = "/etc/firewall.d/firewall.trigger add"
  L8 = L6
  L7 = L7 .. L8
  L8 = _UPVALUE0_
  L8 = L8.forkExec
  L9 = L7
  L8(L9)
end
trigger_add = L2
function L2(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12
  L5 = require
  L6 = "luci.model.uci"
  L5 = L5(L6)
  L5 = L5.cursor
  L5 = L5()
  L6 = string
  L6 = L6.format
  L7 = "pt%s_%s_%s_%s"
  L8 = tostring
  L9 = A2
  L8 = L8(L9)
  L9 = tostring
  L10 = A1
  L9 = L9(L10)
  L10 = tostring
  L11 = A4
  L10 = L10(L11)
  L11 = tostring
  L12 = A3
  L11, L12 = L11(L12)
  L6 = L6(L7, L8, L9, L10, L11, L12)
  L8 = L6
  L7 = L6.gsub
  L9 = "-"
  L10 = "_"
  L7 = L7(L8, L9, L10)
  L6 = L7
  L7 = "/etc/firewall.d/firewall.trigger del"
  L8 = L6
  L7 = L7 .. L8
  L8 = _UPVALUE0_
  L8 = L8.forkExec
  L9 = L7
  L8(L9)
end
trigger_del = L2
function L2(A0, A1, A2, A3, A4, A5, A6, A7)
  local L8, L9, L10, L11, L12, L13, L14
  L8 = require
  L9 = "luci.model.uci"
  L8 = L8(L9)
  L8 = L8.cursor
  L8 = L8()
  L10 = L8
  L9 = L8.set
  L11 = "fw3_helper"
  L12 = "pptp"
  L13 = "enabled"
  if A0 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_16
    end
  end
  L14 = "0"
  ::lbl_16::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "fw3_helper"
  L12 = "sip"
  L13 = "enabled"
  if A3 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_27
    end
  end
  L14 = "0"
  ::lbl_27::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "fw3_helper"
  L12 = "ftp"
  L13 = "enabled"
  if A4 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_38
    end
  end
  L14 = "0"
  ::lbl_38::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "fw3_helper"
  L12 = "tftp"
  L13 = "enabled"
  if A5 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_49
    end
  end
  L14 = "0"
  ::lbl_49::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "fw3_helper"
  L12 = "rtsp"
  L13 = "enabled"
  if A6 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_60
    end
  end
  L14 = "0"
  ::lbl_60::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "fw3_helper"
  L12 = "h323_ras"
  L13 = "enabled"
  if A7 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_71
    end
  end
  L14 = "0"
  ::lbl_71::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "fw3_helper"
  L12 = "h323_Q931"
  L13 = "enabled"
  if A7 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_82
    end
  end
  L14 = "0"
  ::lbl_82::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.commit
  L11 = "fw3_helper"
  L9(L10, L11)
  L10 = L8
  L9 = L8.set
  L11 = "firewall"
  L12 = "basicset"
  L13 = "alg_pptp"
  if A0 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_96
    end
  end
  L14 = "0"
  ::lbl_96::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "firewall"
  L12 = "basicset"
  L13 = "alg_l2tp"
  if A1 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_107
    end
  end
  L14 = "0"
  ::lbl_107::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "firewall"
  L12 = "basicset"
  L13 = "alg_ipsec"
  if A2 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_118
    end
  end
  L14 = "0"
  ::lbl_118::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "firewall"
  L12 = "basicset"
  L13 = "alg_sip"
  if A3 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_129
    end
  end
  L14 = "0"
  ::lbl_129::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "firewall"
  L12 = "basicset"
  L13 = "alg_ftp"
  if A4 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_140
    end
  end
  L14 = "0"
  ::lbl_140::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "firewall"
  L12 = "basicset"
  L13 = "alg_tftp"
  if A5 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_151
    end
  end
  L14 = "0"
  ::lbl_151::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "firewall"
  L12 = "basicset"
  L13 = "alg_rtsp"
  if A6 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_162
    end
  end
  L14 = "0"
  ::lbl_162::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.set
  L11 = "firewall"
  L12 = "basicset"
  L13 = "alg_h323"
  if A7 == 1 then
    L14 = "1"
    if L14 then
      goto lbl_173
    end
  end
  L14 = "0"
  ::lbl_173::
  L9(L10, L11, L12, L13, L14)
  L10 = L8
  L9 = L8.commit
  L11 = "firewall"
  L9(L10, L11)
end
setALGFirewall = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "basicset"
  L6 = "alg_pptp"
  L2 = L2(L3, L4, L5, L6)
  L1.pptp = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "basicset"
  L6 = "alg_l2tp"
  L2 = L2(L3, L4, L5, L6)
  L1.l2tp = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "basicset"
  L6 = "alg_ipsec"
  L2 = L2(L3, L4, L5, L6)
  L1.ipsec = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "basicset"
  L6 = "alg_sip"
  L2 = L2(L3, L4, L5, L6)
  L1.sip = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "basicset"
  L6 = "alg_ftp"
  L2 = L2(L3, L4, L5, L6)
  L1.ftp = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "basicset"
  L6 = "alg_tftp"
  L2 = L2(L3, L4, L5, L6)
  L1.tftp = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "basicset"
  L6 = "alg_rtsp"
  L2 = L2(L3, L4, L5, L6)
  L1.rtsp = L2
  L3 = L0
  L2 = L0.get
  L4 = "firewall"
  L5 = "basicset"
  L6 = "alg_h323"
  L2 = L2(L3, L4, L5, L6)
  L1.h323 = L2
  return L1
end
ALGInfo = L2
