local L0, L1, L2
L0 = module
L1 = "luci.tools.status"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.model.uci"
L0 = L0(L1)
L0 = L0.cursor
L0 = L0()
function L1(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = {}
  L2 = require
  L3 = "nixio.fs"
  L2 = L2(L3)
  L3 = "/var/dhcp.leases"
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.foreach
  L6 = "dhcp"
  L7 = "dnsmasq"
  function L8(A0)
    local L1, L2
    L1 = A0.leasefile
    if L1 then
      L1 = _UPVALUE0_
      L1 = L1.access
      L2 = A0.leasefile
      L1 = L1(L2)
      if L1 then
        L1 = A0.leasefile
        _UPVALUE1_ = L1
        L1 = false
        return L1
      end
    end
  end
  L4(L5, L6, L7, L8)
  L4 = io
  L4 = L4.open
  L5 = L3
  L6 = "r"
  L4 = L4(L5, L6)
  if L4 then
    while true do
      L6 = L4
      L5 = L4.read
      L7 = "*l"
      L5 = L5(L6, L7)
      if not L5 then
        break
      else
        L7 = L5
        L6 = L5.match
        L8 = "^(%d+) (%S+) (%S+) (%S+) (%S+)"
        L6, L7, L8, L9, L10 = L6(L7, L8)
        if L6 and L7 and L8 and L9 and L10 then
          if A0 == 4 then
            L12 = L8
            L11 = L8.match
            L13 = ":"
            L11 = L11(L12, L13)
            if not L11 then
              L11 = #L1
              L11 = L11 + 1
              L12 = {}
              L13 = os
              L13 = L13.difftime
              L14 = tonumber
              L15 = L6
              L14 = L14(L15)
              L14 = L14 or L14
              L15 = os
              L15 = L15.time
              L15 = L15()
              L13 = L13(L14, L15)
              L12.expires = L13
              L12.macaddr = L7
              L12.ipaddr = L8
              L13 = L9 ~= "*" and L13
              L12.hostname = L13
              L1[L11] = L12
          end
          elseif A0 == 6 then
            L12 = L8
            L11 = L8.match
            L13 = ":"
            L11 = L11(L12, L13)
            if L11 then
              L11 = #L1
              L11 = L11 + 1
              L12 = {}
              L13 = os
              L13 = L13.difftime
              L14 = tonumber
              L15 = L6
              L14 = L14(L15)
              L14 = L14 or L14
              L15 = os
              L15 = L15.time
              L15 = L15()
              L13 = L13(L14, L15)
              L12.expires = L13
              L12.ip6addr = L8
              L13 = L10 ~= "*" and L13
              L12.duid = L13
              L13 = L9 ~= "*" and L13
              L12.hostname = L13
              L1[L11] = L12
            end
          end
        end
      end
    end
    L6 = L4
    L5 = L4.close
    L5(L6)
  end
  return L1
end
function L2()
  local L0, L1
  L0 = _UPVALUE0_
  L1 = 4
  return L0(L1)
end
dhcp_leases = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L0 = require
  L1 = "nixio.fs"
  L0 = L0(L1)
  L1 = "/tmp/hosts/6relayd"
  L2 = {}
  L3 = L0.access
  L4 = L1
  L5 = "r"
  L3 = L3(L4, L5)
  if L3 then
    L3 = io
    L3 = L3.open
    L4 = L1
    L5 = "r"
    L3 = L3(L4, L5)
    if L3 then
      while true do
        L5 = L3
        L4 = L3.read
        L6 = "*l"
        L4 = L4(L5, L6)
        if not L4 then
          break
        else
          L6 = L4
          L5 = L4.match
          L7 = "^# (%S+) (%S+) (%S+) (%S+) (%d+) (%S+) (%S+) (.*)"
          L5, L6, L7, L8, L9, L10, L11, L12 = L5(L6, L7)
          if L12 then
            L13 = #L2
            L13 = L13 + 1
            L14 = {}
            L15 = os
            L15 = L15.difftime
            L16 = tonumber
            L17 = L9
            L16 = L16(L17)
            L16 = L16 or L16
            L17 = os
            L17 = L17.time
            L17 = L17()
            L15 = L15(L16, L17)
            L14.expires = L15
            L14.duid = L6
            L14.ip6addr = L12
            L15 = L8 ~= "-" and L15
            L14.hostname = L15
            L2[L13] = L14
          end
        end
      end
      L5 = L3
      L4 = L3.close
      L4(L5)
    end
    return L2
  else
    L3 = luci
    L3 = L3.sys
    L3 = L3.call
    L4 = "dnsmasq --version 2>/dev/null | grep -q ' DHCPv6 '"
    L3 = L3(L4)
    if L3 == 0 then
      L3 = _UPVALUE0_
      L4 = 6
      return L3(L4)
    end
  end
end
dhcp6_leases = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L0 = {}
  L1 = require
  L2 = "luci.model.network"
  L1 = L1(L2)
  L1 = L1.init
  L1 = L1()
  L2 = nil
  L6, L7, L8, L9, L13, L14, L15, L16, L17, L18, L19 = L4(L5)
  for L6, L7 in L3, L4, L5 do
    L8 = {}
    L9 = L7.is_up
    L9 = L9(L10)
    L8.up = L9
    L9 = L7.name
    L9 = L9(L10)
    L8.device = L9
    L9 = L7.get_i18n
    L9 = L9(L10)
    L8.name = L9
    L9 = {}
    L8.networks = L9
    L9 = nil
    L13, L14, L15, L16, L17, L18, L19 = L11(L12)
    for L13, L14 in L10, L11, L12 do
      L15 = L8.networks
      L16 = L8.networks
      L16 = #L16
      L16 = L16 + 1
      L17 = {}
      L19 = L14
      L18 = L14.shortname
      L18 = L18(L19)
      L17.name = L18
      L19 = L14
      L18 = L14.adminlink
      L18 = L18(L19)
      L17.link = L18
      L19 = L14
      L18 = L14.is_up
      L18 = L18(L19)
      L17.up = L18
      L19 = L14
      L18 = L14.active_mode
      L18 = L18(L19)
      L17.mode = L18
      L19 = L14
      L18 = L14.active_ssid
      L18 = L18(L19)
      L17.ssid = L18
      L19 = L14
      L18 = L14.active_bssid
      L18 = L18(L19)
      L17.bssid = L18
      L19 = L14
      L18 = L14.active_encryption
      L18 = L18(L19)
      L17.encryption = L18
      L19 = L14
      L18 = L14.frequency
      L18 = L18(L19)
      L17.frequency = L18
      L19 = L14
      L18 = L14.channel
      L18 = L18(L19)
      L17.channel = L18
      L19 = L14
      L18 = L14.signal
      L18 = L18(L19)
      L17.signal = L18
      L19 = L14
      L18 = L14.signal_percent
      L18 = L18(L19)
      L17.quality = L18
      L19 = L14
      L18 = L14.noise
      L18 = L18(L19)
      L17.noise = L18
      L19 = L14
      L18 = L14.bitrate
      L18 = L18(L19)
      L17.bitrate = L18
      L19 = L14
      L18 = L14.ifname
      L18 = L18(L19)
      L17.ifname = L18
      L19 = L14
      L18 = L14.assoclist
      L18 = L18(L19)
      L17.assoclist = L18
      L19 = L14
      L18 = L14.country
      L18 = L18(L19)
      L17.country = L18
      L19 = L14
      L18 = L14.txpower
      L18 = L18(L19)
      L17.txpower = L18
      L19 = L14
      L18 = L14.txpower_offset
      L18 = L18(L19)
      L17.txpoweroff = L18
      L15[L16] = L17
    end
    L0[L10] = L8
  end
  return L0
end
wifi_networks = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.network"
  L1 = L1(L2)
  L1 = L1.init
  L1 = L1()
  L3 = L1
  L2 = L1.get_wifinet
  L4 = A0
  L2 = L2(L3, L4)
  if L2 then
    L4 = L2
    L3 = L2.get_device
    L3 = L3(L4)
    if L3 then
      L4 = {}
      L4.id = A0
      L6 = L2
      L5 = L2.shortname
      L5 = L5(L6)
      L4.name = L5
      L6 = L2
      L5 = L2.adminlink
      L5 = L5(L6)
      L4.link = L5
      L6 = L2
      L5 = L2.is_up
      L5 = L5(L6)
      L4.up = L5
      L6 = L2
      L5 = L2.active_mode
      L5 = L5(L6)
      L4.mode = L5
      L6 = L2
      L5 = L2.active_ssid
      L5 = L5(L6)
      L4.ssid = L5
      L6 = L2
      L5 = L2.active_bssid
      L5 = L5(L6)
      L4.bssid = L5
      L6 = L2
      L5 = L2.active_encryption
      L5 = L5(L6)
      L4.encryption = L5
      L6 = L2
      L5 = L2.frequency
      L5 = L5(L6)
      L4.frequency = L5
      L6 = L2
      L5 = L2.channel
      L5 = L5(L6)
      L4.channel = L5
      L6 = L2
      L5 = L2.signal
      L5 = L5(L6)
      L4.signal = L5
      L6 = L2
      L5 = L2.signal_percent
      L5 = L5(L6)
      L4.quality = L5
      L6 = L2
      L5 = L2.noise
      L5 = L5(L6)
      L4.noise = L5
      L6 = L2
      L5 = L2.bitrate
      L5 = L5(L6)
      L4.bitrate = L5
      L6 = L2
      L5 = L2.ifname
      L5 = L5(L6)
      L4.ifname = L5
      L6 = L2
      L5 = L2.assoclist
      L5 = L5(L6)
      L4.assoclist = L5
      L6 = L2
      L5 = L2.country
      L5 = L5(L6)
      L4.country = L5
      L6 = L2
      L5 = L2.txpower
      L5 = L5(L6)
      L4.txpower = L5
      L6 = L2
      L5 = L2.txpower_offset
      L5 = L5(L6)
      L4.txpoweroff = L5
      L5 = {}
      L7 = L3
      L6 = L3.is_up
      L6 = L6(L7)
      L5.up = L6
      L7 = L3
      L6 = L3.name
      L6 = L6(L7)
      L5.device = L6
      L7 = L3
      L6 = L3.get_i18n
      L6 = L6(L7)
      L5.name = L6
      L4.device = L5
      return L4
    end
  end
  L3 = {}
  return L3
end
wifi_network = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
  L2 = {}
  for L6 in L3, L4, L5 do
    L7 = {}
    L8 = io
    L8 = L8.popen
    L9 = "swconfig dev %q show" % L6
    L10 = "r"
    L8 = L8(L9, L10)
    if L8 then
      L9 = nil
      repeat
        L11 = L8
        L10 = L8.read
        L12 = "*l"
        L10 = L10(L11, L12)
        L9 = L10
        if L9 then
          L11 = L9
          L10 = L9.match
          L12 = "port:(%d+) link:(%w+)"
          L10, L11 = L10(L11, L12)
          if L10 then
            L13 = L9
            L12 = L9.match
            L14 = " speed:(%d+)"
            L12 = L12(L13, L14)
            L14 = L9
            L13 = L9.match
            L15 = " (%w+)-duplex"
            L13 = L13(L14, L15)
            L15 = L9
            L14 = L9.match
            L16 = " (txflow)"
            L14 = L14(L15, L16)
            L16 = L9
            L15 = L9.match
            L17 = " (rxflow)"
            L15 = L15(L16, L17)
            L17 = L9
            L16 = L9.match
            L18 = " (auto)"
            L16 = L16(L17, L18)
            L17 = #L7
            L17 = L17 + 1
            L18 = {}
            L19 = tonumber
            L20 = L10
            L19 = L19(L20)
            L19 = L19 or L19
            L18.port = L19
            L19 = tonumber
            L20 = L12
            L19 = L19(L20)
            L19 = L19 or L19
            L18.speed = L19
            L19 = L11 == "up"
            L18.link = L19
            L19 = L13 == "full"
            L18.duplex = L19
            L19 = not L15
            L19 = not L19
            L18.rxflow = L19
            L19 = not L14
            L19 = not L19
            L18.txflow = L19
            L19 = not L16
            L19 = not L19
            L18.auto = L19
            L7[L17] = L18
          end
        end
      until not L9
      L11 = L8
      L10 = L8.close
      L10(L11)
    end
    L2[L6] = L7
  end
  return L2
end
switch_status = L2
