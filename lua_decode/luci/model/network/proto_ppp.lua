local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
L0 = luci
L0 = L0.model
L0 = L0.network
L1, L2 = nil, nil
L6 = "pptp"
L7 = "pppoe"
L8 = "pppoa"
L9 = "3g"
L10 = "l2tp"
L4[1] = L5
L4[2] = L6
L4[3] = L7
L4[4] = L8
L4[5] = L9
L4[6] = L10
for L6, L7 in L3, L4, L5 do
  L9 = L0
  L8 = L0.register_protocol
  L10 = L7
  L8 = L8(L9, L10)
  function L9(A0)
    local L1, L2
    L1 = _UPVALUE0_
    if L1 == "ppp" then
      L1 = luci
      L1 = L1.i18n
      L1 = L1.translate
      L2 = "PPP"
      return L1(L2)
    else
      L1 = _UPVALUE0_
      if L1 == "pptp" then
        L1 = luci
        L1 = L1.i18n
        L1 = L1.translate
        L2 = "PPtP"
        return L1(L2)
      else
        L1 = _UPVALUE0_
        if L1 == "3g" then
          L1 = luci
          L1 = L1.i18n
          L1 = L1.translate
          L2 = "UMTS/GPRS/EV-DO"
          return L1(L2)
        else
          L1 = _UPVALUE0_
          if L1 == "pppoe" then
            L1 = luci
            L1 = L1.i18n
            L1 = L1.translate
            L2 = "PPPoE"
            return L1(L2)
          else
            L1 = _UPVALUE0_
            if L1 == "pppoa" then
              L1 = luci
              L1 = L1.i18n
              L1 = L1.translate
              L2 = "PPPoATM"
              return L1(L2)
            else
              L1 = _UPVALUE0_
              if L1 == "l2tp" then
                L1 = luci
                L1 = L1.i18n
                L1 = L1.translate
                L2 = "L2TP"
                return L1(L2)
              end
            end
          end
        end
      end
    end
  end
  L8.get_i18n = L9
  function L9(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L2 = "-"
    L3 = A0.sid
    L1 = L1 .. L2 .. L3
    return L1
  end
  L8.ifname = L9
  function L9(A0)
    local L1
    L1 = _UPVALUE0_
    if L1 == "ppp" then
      L1 = _UPVALUE0_
      return L1
    else
      L1 = _UPVALUE0_
      if L1 == "3g" then
        L1 = "comgt"
        return L1
      else
        L1 = _UPVALUE0_
        if L1 == "pptp" then
          L1 = "ppp-mod-pptp"
          return L1
        else
          L1 = _UPVALUE0_
          if L1 == "pppoe" then
            L1 = "ppp-mod-pppoe"
            return L1
          else
            L1 = _UPVALUE0_
            if L1 == "pppoa" then
              L1 = "ppp-mod-pppoa"
              return L1
            else
              L1 = _UPVALUE0_
              if L1 == "l2tp" then
                L1 = "xl2tpd"
                return L1
              end
            end
          end
        end
      end
    end
  end
  L8.opkg_package = L9
  function L9(A0)
    local L1, L2
    L1 = _UPVALUE0_
    if L1 == "pppoa" then
      L1 = nixio
      L1 = L1.fs
      L1 = L1.glob
      L2 = "/usr/lib/pppd/*/pppoatm.so"
      L1 = L1(L2)
      L1 = L1()
      L1 = L1 ~= nil
      return L1
    else
      L1 = _UPVALUE0_
      if L1 == "pppoe" then
        L1 = nixio
        L1 = L1.fs
        L1 = L1.glob
        L2 = "/usr/lib/pppd/*/rp-pppoe.so"
        L1 = L1(L2)
        L1 = L1()
        L1 = L1 ~= nil
        return L1
      else
        L1 = _UPVALUE0_
        if L1 == "pptp" then
          L1 = nixio
          L1 = L1.fs
          L1 = L1.glob
          L2 = "/usr/lib/pppd/*/pptp.so"
          L1 = L1(L2)
          L1 = L1()
          L1 = L1 ~= nil
          return L1
        else
          L1 = _UPVALUE0_
          if L1 == "3g" then
            L1 = nixio
            L1 = L1.fs
            L1 = L1.access
            L2 = "/lib/netifd/proto/3g.sh"
            return L1(L2)
          else
            L1 = _UPVALUE0_
            if L1 == "l2tp" then
              L1 = nixio
              L1 = L1.fs
              L1 = L1.access
              L2 = "/lib/netifd/proto/l2tp.sh"
              return L1(L2)
            else
              L1 = nixio
              L1 = L1.fs
              L1 = L1.access
              L2 = "/lib/netifd/proto/ppp.sh"
              return L1(L2)
            end
          end
        end
      end
    end
  end
  L8.is_installed = L9
  function L9(A0)
    local L1
    L1 = _UPVALUE0_
    L1 = L1 ~= "pppoe"
    return L1
  end
  L8.is_floating = L9
  function L9(A0)
    local L1
    L1 = true
    return L1
  end
  L8.is_virtual = L9
  function L9(A0)
    local L1, L2
    L2 = A0
    L1 = A0.is_floating
    L1 = L1(L2)
    if L1 then
      L1 = nil
      return L1
    else
      L1 = _UPVALUE0_
      L1 = L1.protocol
      L1 = L1.get_interfaces
      L2 = A0
      return L1(L2)
    end
  end
  L8.get_interfaces = L9
  function L9(A0, A1)
    local L2, L3, L4
    L3 = A0
    L2 = A0.is_floating
    L2 = L2(L3)
    if L2 then
      L2 = _UPVALUE0_
      L3 = L2
      L2 = L2.ifnameof
      L4 = A1
      L2 = L2(L3, L4)
      L4 = A0
      L3 = A0.ifname
      L3 = L3(L4)
      L2 = L2 == L3
      return L2
    else
      L2 = _UPVALUE0_
      L2 = L2.protocol
      L2 = L2.contains_interface
      L3 = A0
      L4 = A1
      return L2(L3, L4)
    end
  end
  L8.contains_interface = L9
  L10 = L0
  L9 = L0.register_pattern_virtual
  L11 = "^%s-%%w" % L7
  L9(L10, L11)
end
