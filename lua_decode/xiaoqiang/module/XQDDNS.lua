local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
L0 = module
L1 = "xiaoqiang.module.XQDDNS"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = {}
L3 = {}
L3.service_name = "no-ip.com"
L3.ip_url = "http://[USERNAME]:[PASSWORD]@dynupdate.no-ip.com/nic/update?hostname=[DOMAIN]&myip=[IP]"
L2.noip = L3
L3 = {}
L3.service_name = "oray.com"
L3.ip_url = "http://[USERNAME]:[PASSWORD]@ddns.oray.com:80/ph/update?hostname=[DOMAIN]&myip=[IP]"
L2.oray = L3
L3 = {}
L3.service_name = "3322.org"
L3.ip_url = "http://[USERNAME]:[PASSWORD]@members.3322.net/dyndns/update?hostname=[DOMAIN]&myip=[IP]"
L2.pubyun = L3
L3 = {}
L3.service_name = "dyndns.org"
L3.ip_url = "https://[USERNAME]:[PASSWORD]@members.dyndns.org/nic/update?wildcard=ON&hostname=[DOMAIN]&myip=[IP]"
L2.dyndnsorg = L3
L3 = {}
L3.service_name = "dyndns.fr"
L3.ip_url = "http://[DOMAIN]:[PASSWORD]@dyndns.dyndns.fr/update.php?hostname=[DOMAIN]&myip=[IP]"
L2.dyndnsfr = L3
L3 = {}
L3.service_name = "dyndnspro.com"
L3.ip_url = "http://[DOMAIN]:[PASSWORD]@dyndns.dyndnspro.com/update.php?hostname=[DOMAIN]&myip=[IP]"
L2.dyndnspro = L3
L3 = {}
L3.service_name = "dynamicdomain.net"
L3.ip_url = "http://[DOMAIN]:[PASSWORD]@dyndns.dynamicdomain.net/update.php?hostname=[DOMAIN]&myip=[IP]"
L2.dynamicdomain = L3
L3 = {}
L3.service_name = "dyndns.it"
L3.ip_url = "http://[USERNAME]:[PASSWORD]@dyndns.it/nic/update?hostname=[DOMAIN]&myip=[IP]"
L2.dyndnsit = L3
L3 = {}
L3.service_name = "duckdns.org"
L3.ip_url = "http://www.duckdns.org/update?domains=[DOMAIN]&token=[PASSWORD]&ip=[IP]"
L2.duckdns = L3
L3 = {}
L3.service_name = "system-ns.com"
L3.ip_url = "http://system-ns.com/api?type=dynamic&domain=[DOMAIN]&command=set&token=[PASSWORD]&ip=[IP]"
L2.systemns = L3
L3 = {}
L4 = {}
L5 = _
L6 = "\230\156\170\230\156\137\230\191\128\230\180\187\232\138\177\231\148\159\229\163\179\231\154\132\229\159\159\229\144\141"
L5 = L5(L6)
L4.notfqdn = L5
L5 = _
L6 = "\232\186\171\228\187\189\232\174\164\232\175\129\229\135\186\233\148\153\239\188\140\232\175\183\230\163\128\230\159\165\231\148\168\230\136\183\229\144\141\229\146\140\229\175\134\231\160\129, \230\136\150\232\128\133\231\188\150\231\160\129\230\150\185\229\188\143\229\135\186\233\148\153\227\128\130"
L5 = L5(L6)
L4.badauth = L5
L5 = _
L6 = "\229\159\159\229\144\141\228\184\141\229\173\152\229\156\168\230\136\150\230\156\170\230\191\128\230\180\187\232\138\177\231\148\159\229\163\179"
L5 = L5(L6)
L4.nohost = L5
L5 = _
L6 = "\232\175\183\230\177\130\229\164\177\232\180\165\239\188\140\233\162\145\231\185\129\232\175\183\230\177\130\230\136\150\233\170\140\232\175\129\229\164\177\232\180\165\230\151\182\228\188\154\229\135\186\231\142\176"
L5 = L5(L6)
L4.abuse = L5
L5 = _
L6 = "\229\191\133\233\161\187\230\152\175\228\187\152\232\180\185\231\148\168\230\136\183\230\137\141\232\131\189\228\189\191\231\148\168\230\173\164\229\138\159\232\131\189"
L5 = L5(L6)
L4["!donator"] = L5
L5 = _
L6 = "\232\138\177\231\148\159\229\163\179\231\179\187\231\187\159\233\148\153\232\175\175"
L5 = L5(L6)
L4["911"] = L5
L3.oray = L4
L4 = {}
L5 = _
L6 = "\232\186\171\228\187\189\232\174\164\232\175\129\229\135\186\233\148\153\239\188\140\232\175\183\230\163\128\230\159\165\231\148\168\230\136\183\229\144\141\229\146\140\229\175\134\231\160\129, \230\136\150\232\128\133\231\188\150\231\160\129\230\150\185\229\188\143\229\135\186\233\148\153\227\128\130"
L5 = L5(L6)
L4.badauth = L5
L5 = _
L6 = "\232\175\165\229\159\159\229\144\141\228\184\141\230\152\175\229\138\168\230\128\129\229\159\159\229\144\141\239\188\140\229\143\175\232\131\189\230\152\175\229\133\182\228\187\150\231\177\187\229\158\139\231\154\132\229\159\159\229\144\141\239\188\136\230\153\186\232\131\189\229\159\159\229\144\141\227\128\129\233\157\153\230\128\129\229\159\159\229\144\141\227\128\129\229\159\159\229\144\141\232\189\172\229\144\145\227\128\129\229\173\144\229\159\159\229\144\141\239\188\137\227\128\130"
L5 = L5(L6)
L4.badsys = L5
L5 = _
L6 = "\231\148\177\228\186\142\229\143\145\233\128\129\229\164\167\233\135\143\229\158\131\229\156\190\230\149\176\230\141\174\239\188\140\229\174\162\230\136\183\231\171\175\229\144\141\231\167\176\232\162\171\231\179\187\231\187\159\229\176\129\230\157\128\227\128\130"
L5 = L5(L6)
L4.badagent = L5
L5 = _
L6 = "\230\178\161\230\156\137\230\143\144\228\190\155\229\159\159\229\144\141\229\143\130\230\149\176\239\188\140\229\191\133\233\161\187\230\143\144\228\190\155\228\184\128\228\184\170\229\156\168\229\133\172\228\186\145\230\179\168\229\134\140\231\154\132\229\138\168\230\128\129\229\159\159\229\144\141\229\159\159\229\144\141\227\128\130"
L5 = L5(L6)
L4.notfqdn = L5
L5 = _
L6 = "\229\159\159\229\144\141\228\184\141\229\173\152\229\156\168\239\188\140\232\175\183\230\163\128\230\159\165\229\159\159\229\144\141\230\152\175\229\144\166\229\161\171\229\134\153\230\173\163\231\161\174\227\128\130"
L5 = L5(L6)
L4.nohost = L5
L5 = _
L6 = "\229\191\133\233\161\187\230\152\175\230\148\182\232\180\185\231\148\168\230\136\183\239\188\140\230\137\141\232\131\189\228\189\191\231\148\168 offline \231\166\187\231\186\191\229\138\159\232\131\189\227\128\130"
L5 = L5(L6)
L4["!donator"] = L5
L5 = _
L6 = "\232\175\165\229\159\159\229\144\141\229\173\152\229\156\168\239\188\140\228\189\134\230\152\175\228\184\141\230\152\175\232\175\165\231\148\168\230\136\183\230\137\128\230\156\137\227\128\130"
L5 = L5(L6)
L4["!yours"] = L5
L5 = _
L6 = "\232\175\165\229\159\159\229\144\141\232\162\171\231\179\187\231\187\159\229\133\179\233\151\173\239\188\140\232\175\183\232\129\148\231\179\187\229\133\172\228\186\145\229\174\162\230\156\141\228\186\186\229\145\152\227\128\130"
L5 = L5(L6)
L4["!active"] = L5
L5 = _
L6 = "\229\191\133\233\161\187\230\152\175\228\187\152\232\180\185\231\148\168\230\136\183\230\137\141\232\131\189\228\189\191\231\148\168\230\173\164\229\138\159\232\131\189"
L5 = L5(L6)
L4.abuse = L5
L5 = _
L6 = "DNS \230\156\141\229\138\161\229\153\168\230\155\180\230\150\176\229\164\177\232\180\165\227\128\130"
L5 = L5(L6)
L4.dnserr = L5
L5 = _
L6 = "\230\156\141\229\138\161\229\153\168\229\134\133\233\131\168\228\184\165\233\135\141\233\148\153\232\175\175\239\188\140\230\175\148\229\166\130\230\149\176\230\141\174\229\186\147\229\135\186\233\148\153\230\136\150\232\128\133DNS\230\156\141\229\138\161\229\153\168\229\135\186\233\148\153\227\128\130"
L5 = L5(L6)
L4.interror = L5
L3.pubyun = L4
L4 = {}
L4.badauth = "The username and password pair do not match a real user."
L4.numhost = "Too many hosts (more than 20) specified in an update. Also returned if trying to update a round robin (which is not allowed)."
L4["good 127.0.0.1"] = "This answer indicates good update only when 127.0.0.1 address is requested by update. In all other cases it warns user that request was ignored because of agent that does not follow our specifications."
L4.notfqdn = "The hostname specified is not a fully-qualified domain name (not in the form hostname.dyndns.org or domain.com)."
L4.nohost = "The hostname specified does not exist in this user account (or is not in the service specified in the system parameter)."
L4.abuse = "The hostname specified is blocked for update abuse."
L4.dnserr = "DNS error encountered"
L4["911"] = "There is a problem or scheduled maintenance on our side."
L3.dyndnsorg = L4
L4 = {}
L4.badagent = "Client disabled. Client should exit and not perform any more updates without user intervention."
L4.badauth = "Invalid username password combination"
L4.nohost = "Hostname supplied does not exist under specified account, client exit and require user to enter new login credentials before performing an additional request."
L4.abuse = "Username is blocked due to abuse. Either for not following our update specifications or disabled due to violation of the No-IP terms of service. Our terms of service can be viewed here. Client should stop sending updates."
L4["!donator"] = "An update request was sent including a feature that is not available to that particular user such as offline options."
L4["911"] = "A fatal error on our side such as a database outage. Retry the update no sooner than 30 minutes."
L3.noip = L4
L4 = {}
L5 = "noip"
L6 = "oray"
L7 = "pubyun"
L8 = "dyndnsorg"
L9 = "dyndnsfr"
L10 = "dyndnspro"
L11 = "dynamicdomain"
L12 = "dyndnsit"
L13 = "duckdns"
L14 = "systemns"
L4[1] = L5
L4[2] = L6
L4[3] = L7
L4[4] = L8
L4[5] = L9
L4[6] = L10
L4[7] = L11
L4[8] = L12
L4[9] = L13
L4[10] = L14
function L5(A0)
  local L1, L2, L3, L4, L5, L6
  for L4, L5 in L1, L2, L3 do
    if L5 == A0 then
      return L4
    end
  end
  return L1
end
_serverId = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = false
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.foreach
  L4 = "ddns"
  L5 = "service"
  function L6(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = A0.enabled
    if L1 == "0" then
      L1 = A0.laststatus
      L1 = L1 and L1
      if L1 == "loading" then
        L1 = _UPVALUE0_
        L2 = L1
        L1 = L1.set
        L3 = "ddns"
        L4 = A0[".name"]
        L5 = "laststatus"
        L6 = "off"
        L1(L2, L3, L4, L5, L6)
      end
    else
      L1 = true
      _UPVALUE1_ = L1
    end
  end
  L2(L3, L4, L5, L6)
  if not L0 then
    L3 = L1
    L2 = L1.set
    L4 = "ddns"
    L5 = "ddns"
    L6 = "status"
    L7 = "off"
    L2(L3, L4, L5, L6, L7)
  end
  L3 = L1
  L2 = L1.commit
  L4 = "ddns"
  L2(L3, L4)
end
ddns_cfg_update = L5
function L5(A0)
  local L1, L2, L3, L4
  L1 = os
  L1 = L1.execute
  L2 = "/usr/lib/ddns/dynamic_dns_updater.sh -S "
  L3 = A0
  L4 = " -- stop"
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = true
  return L1
end
ddns_stop = L5
function L5(A0)
  local L1, L2, L3, L4
  L1 = os
  L1 = L1.execute
  L2 = "uci set ddns.ddns.status=on 2>/dev/null && uci set ddns."
  L3 = A0
  L4 = ".laststatus=\"loading\" && uci commit ddns 2>/dev/null"
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = os
  L1 = L1.execute
  L2 = "rm -rf /var/run/ddns/*"
  L1(L2)
  L1 = _UPVALUE0_
  L1 = L1.forkExec
  L2 = "/usr/lib/ddns/dynamic_dns_updater.sh -v 0 -S "
  L3 = A0
  L4 = " -- start &"
  L2 = L2 .. L3 .. L4
  L1(L2)
  L1 = true
  return L1
end
ddns_start = L5
function L5(A0)
  local L1, L2
  L1 = ddns_stop
  L2 = A0
  L1(L2)
  L1 = ddns_start
  L2 = A0
  L1(L2)
  L1 = true
  return L1
end
ddns_restart = L5
function L5(A0, A1, A2, A3, A4, A5, A6)
  local L7, L8, L9, L10, L11, L12, L13, L14, L15
  L7 = require
  L8 = "luci.model.uci"
  L7 = L7(L8)
  L7 = L7.cursor
  L7 = L7()
  L8 = _UPVALUE0_
  L8 = L8[A0]
  if L8 and A2 and A3 and A6 and A4 and A5 then
    L10 = L7
    L9 = L7.foreach
    L11 = "ddns"
    L12 = "service"
    function L13(A0)
      local L1, L2, L3, L4, L5, L6
      L1 = A0[".name"]
      L2 = _UPVALUE0_
      if L1 ~= L2 then
        L1 = tonumber
        L2 = A0.enabled
        L1 = L1(L2)
        if L1 == 1 then
          L1 = _UPVALUE1_
          L2 = L1
          L1 = L1.set
          L3 = "ddns"
          L4 = A0[".name"]
          L5 = "enabled"
          L6 = 0
          L1(L2, L3, L4, L5, L6)
          L1 = ddns_stop
          L2 = A0[".name"]
          L1(L2)
        end
      end
    end
    L9(L10, L11, L12, L13)
    L9 = {}
    L9.enabled = A1
    L10 = L8.service_name
    L9.service_name = L10
    L9.force_interval = A5
    L9.force_unit = "hours"
    L9.check_interval = A4
    L9.check_unit = "minutes"
    L9.username = A2
    L9.password = A3
    L9.ip_source = "web"
    L10 = L8.ip_url
    L9.ip_url = L10
    L9.lookup_host = A6
    L9.domain = A6
    L9.use_https = 0
    L9.ip_script = "/usr/lib/ddns/getlocalip.sh"
    L10 = L8.service_name
    if L10 == "dyndns.org" then
      L9.use_https = 1
    end
    L11 = L7
    L10 = L7.section
    L12 = "ddns"
    L13 = "service"
    L14 = A0
    L15 = L9
    L10(L11, L12, L13, L14, L15)
    L11 = L7
    L10 = L7.commit
    L12 = "ddns"
    L10(L11, L12)
    L10 = ddns_cfg_update
    L10()
    L10 = true
    return L10
  end
  L9 = false
  return L9
end
_saveConfig = L5
function L5(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    L3 = false
    return L3
  end
  L4 = L2
  L3 = L2.foreach
  L5 = "ddns"
  L6 = "service"
  function L7(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = A0[".name"]
    L2 = _UPVALUE0_
    if L1 ~= L2 then
      L1 = A0.enabled
      if L1 == "1" then
        L1 = _UPVALUE1_
        if L1 == 1 then
          L1 = _UPVALUE2_
          L2 = L1
          L1 = L1.set
          L3 = "ddns"
          L4 = A0[".name"]
          L5 = "enabled"
          L6 = 0
          L1(L2, L3, L4, L5, L6)
          L1 = ddns_stop
          L2 = A0[".name"]
          L1(L2)
        end
      end
    else
      L1 = _UPVALUE2_
      L2 = L1
      L1 = L1.set
      L3 = "ddns"
      L4 = A0[".name"]
      L5 = "enabled"
      L6 = _UPVALUE1_
      L1(L2, L3, L4, L5, L6)
    end
  end
  L3(L4, L5, L6, L7)
  L4 = L2
  L3 = L2.commit
  L5 = "ddns"
  L3(L4, L5)
  if A1 == 1 then
    L3 = ddns_start
    L4 = A0
    L3(L4)
  else
    L3 = ddns_stop
    L4 = A0
    L3(L4)
  end
  L3 = ddns_cfg_update
  L3()
  L3 = true
  return L3
end
_ddnsServerSwitch = L5
function L5()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = {}
  L2 = {}
  L2.on = 0
  L3 = {}
  L2.list = L3
  L4 = L0
  L3 = L0.get
  L5 = "ddns"
  L6 = "ddns"
  L7 = "status"
  L3 = L3(L4, L5, L6, L7)
  L1.daemon = L3
  L3 = L1.daemon
  if L3 == "on" then
    L2.on = 1
  end
  L4 = L0
  L3 = L0.foreach
  L5 = "ddns"
  L6 = "service"
  function L7(A0)
    local L1, L2, L3, L4, L5
    L1 = {}
    L2 = _serverId
    L3 = A0[".name"]
    L2 = L2(L3)
    if L2 then
      L3 = A0.laststatus
      if L3 ~= "ok" then
        L3 = A0.laststatus
        if L3 ~= "off" then
          goto lbl_15
        end
      end
      L1.status = 1
      goto lbl_35
      ::lbl_15::
      L3 = A0.laststatus
      if L3 ~= "loading" then
        L3 = A0.laststatus
        if L3 then
          goto lbl_23
        end
      end
      L1.status = 2
      goto lbl_35
      ::lbl_23::
      L1.status = 0
      L3 = _UPVALUE0_
      L4 = key
      L3 = L3[L4]
      if L3 then
        L4 = A0.lastreturn
        L4 = L3[L4]
        L4 = L4 or L4
        L1.error = L4
      end
      ::lbl_35::
      L3 = tonumber
      L4 = A0.enabled
      L3 = L3(L4)
      L1.enabled = L3
      L1.id = L2
      L3 = _UPVALUE1_
      L4 = A0[".name"]
      L3 = L3[L4]
      L3 = L3.service_name
      L1.servicename = L3
      L3 = A0.domain
      L1.domain = L3
      L3 = A0.wanip
      L1.wanip = L3
      L3 = table
      L3 = L3.insert
      L4 = _UPVALUE2_
      L4 = L4.list
      L5 = L1
      L3(L4, L5)
    end
  end
  L3(L4, L5, L6, L7)
  return L2
end
ddnsInfo = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "ddns"
  L5 = "ddns"
  L6 = "status"
  L2 = L2(L3, L4, L5, L6)
  if A0 and L2 == "off" then
    L4 = L1
    L3 = L1.set
    L5 = "ddns"
    L6 = "ddns"
    L7 = "status"
    L8 = "on"
    L3(L4, L5, L6, L7, L8)
    L4 = L1
    L3 = L1.commit
    L5 = "ddns"
    L3(L4, L5)
    L3 = os
    L3 = L3.execute
    L4 = "/etc/init.d/ddns restart"
    L3(L4)
  elseif not A0 and L2 ~= "off" then
    L4 = L1
    L3 = L1.set
    L5 = "ddns"
    L6 = "ddns"
    L7 = "status"
    L8 = "off"
    L3(L4, L5, L6, L7, L8)
    L4 = L1
    L3 = L1.commit
    L5 = "ddns"
    L3(L4, L5)
    L3 = os
    L3 = L3.execute
    L4 = "/etc/init.d/ddns stop"
    L3(L4)
  end
end
ddnsSwitch = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = tonumber
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = _UPVALUE0_
  L3 = tonumber
  L4 = A0
  L3 = L3(L4)
  L2 = L2[L3]
  L3 = {}
  L5 = L1
  L4 = L1.get_all
  L6 = "ddns"
  L7 = L2
  L4 = L4(L5, L6, L7)
  if L4 then
    L5 = L4.username
    L5 = L5 or L5
    L3.username = L5
    L5 = L4.password
    L5 = L5 or L5
    L3.password = L5
    L5 = tonumber
    L6 = L4.force_interval
    L5 = L5(L6)
    L5 = L5 or L5
    L3.forceinterval = L5
    L5 = tonumber
    L6 = L4.check_interval
    L5 = L5(L6)
    L5 = L5 or L5
    L3.checkinterval = L5
    L5 = L4.domain
    L5 = L5 or L5
    L3.domain = L5
    L5 = tonumber
    L6 = L4.enabled
    L5 = L5(L6)
    L5 = L5 or L5
    L3.enabled = L5
    return L3
  end
  L5 = false
  return L5
end
getDdns = L5
function L5(A0, A1, A2, A3, A4, A5, A6)
  local L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L7 = tonumber
  L8 = A0
  L7 = L7(L8)
  if not L7 then
    L7 = false
    return L7
  end
  L7 = _UPVALUE0_
  L8 = tonumber
  L9 = A0
  L8 = L8(L9)
  L7 = L7[L8]
  L8 = _UPVALUE1_
  L8 = L8.isStrNil
  L9 = A2
  L8 = L8(L9)
  if not L8 then
    L8 = _UPVALUE1_
    L8 = L8.isStrNil
    L9 = A3
    L8 = L8(L9)
    if not L8 then
      L8 = _UPVALUE1_
      L8 = L8.isStrNil
      L9 = A6
      L8 = L8(L9)
      if not L8 then
        L8 = _UPVALUE1_
        L8 = L8.isStrNil
        L9 = L7
        L8 = L8(L9)
        if not L8 then
          goto lbl_39
        end
      end
    end
  end
  L8 = false
  do return L8 end
  ::lbl_39::
  L8 = tonumber
  L9 = A4
  L8 = L8(L9)
  A4 = L8
  L8 = tonumber
  L9 = A5
  L8 = L8(L9)
  A5 = L8
  if not A4 or not A5 then
    L8 = false
    return L8
  end
  if A1 == 1 then
    L8 = 1
    if L8 then
      goto lbl_59
    end
  end
  L8 = 0
  ::lbl_59::
  L9 = _saveConfig
  L10 = L7
  L11 = L8
  L12 = A2
  L13 = A3
  L14 = A4
  L15 = A5
  L16 = A6
  L9 = L9(L10, L11, L12, L13, L14, L15, L16)
  if L9 and L8 == 1 then
    L9 = ddns_start
    L10 = L7
    return L9(L10)
  end
  L9 = false
  return L9
end
setDdns = L5
function L5(A0, A1, A2, A3, A4, A5, A6)
  local L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L7 = tonumber
  L8 = A0
  L7 = L7(L8)
  if not L7 then
    L7 = false
    return L7
  end
  L7 = require
  L8 = "luci.model.uci"
  L7 = L7(L8)
  L7 = L7.cursor
  L7 = L7()
  L8 = _UPVALUE0_
  L9 = tonumber
  L10 = A0
  L9 = L9(L10)
  L8 = L8[L9]
  L10 = L7
  L9 = L7.get_all
  L11 = "ddns"
  L12 = L8
  L9 = L9(L10, L11, L12)
  if L9 then
    L10 = _UPVALUE1_
    L10 = L10.isStrNil
    L11 = A2
    L10 = L10(L11)
    if not L10 then
      L10 = L9.username
      if A2 ~= L10 then
        L11 = L7
        L10 = L7.set
        L12 = "ddns"
        L13 = L8
        L14 = "username"
        L15 = A2
        L10(L11, L12, L13, L14, L15)
      end
    end
    L10 = _UPVALUE1_
    L10 = L10.isStrNil
    L11 = A3
    L10 = L10(L11)
    if not L10 then
      L10 = L9.password
      if A3 ~= L10 then
        L11 = L7
        L10 = L7.set
        L12 = "ddns"
        L13 = L8
        L14 = "password"
        L15 = A3
        L10(L11, L12, L13, L14, L15)
      end
    end
    L10 = _UPVALUE1_
    L10 = L10.isStrNil
    L11 = A6
    L10 = L10(L11)
    if not L10 then
      L10 = L9.domain
      if A6 ~= L10 then
        L11 = L7
        L10 = L7.set
        L12 = "ddns"
        L13 = L8
        L14 = "lookup_host"
        L15 = A6
        L10(L11, L12, L13, L14, L15)
        L11 = L7
        L10 = L7.set
        L12 = "ddns"
        L13 = L8
        L14 = "domain"
        L15 = A6
        L10(L11, L12, L13, L14, L15)
      end
    end
    L10 = tonumber
    L11 = A4
    L10 = L10(L11)
    if L10 then
      L10 = tonumber
      L11 = A4
      L10 = L10(L11)
      L11 = tonumber
      L12 = L9.check_interval
      L11 = L11(L12)
      if L10 ~= L11 then
        L11 = L7
        L10 = L7.set
        L12 = "ddns"
        L13 = L8
        L14 = "check_interval"
        L15 = A4
        L10(L11, L12, L13, L14, L15)
      end
    end
    L10 = tonumber
    L11 = A5
    L10 = L10(L11)
    if L10 then
      L10 = tonumber
      L11 = A5
      L10 = L10(L11)
      L11 = tonumber
      L12 = L9.force_interval
      L11 = L11(L12)
      if L10 ~= L11 then
        L11 = L7
        L10 = L7.set
        L12 = "ddns"
        L13 = L8
        L14 = "force_interval"
        L15 = A5
        L10(L11, L12, L13, L14, L15)
      end
    end
    if A1 == 1 then
      L10 = 1
      if L10 then
        goto lbl_119
      end
    end
    L10 = 0
    ::lbl_119::
    L11 = tonumber
    L12 = L9.enabled
    L11 = L11(L12)
    if L10 ~= L11 then
      L12 = L7
      L11 = L7.set
      L13 = "ddns"
      L14 = L8
      L15 = "enabled"
      L16 = L10
      L11(L12, L13, L14, L15, L16)
    end
    L12 = L7
    L11 = L7.commit
    L13 = "ddns"
    L11(L12, L13)
    if L10 == 1 then
      L11 = ddns_restart
      L12 = L8
      L11(L12)
    end
    L11 = true
    return L11
  end
  L10 = false
  return L10
end
editDdns = L5
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = tonumber
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE0_
  L2 = tonumber
  L3 = A0
  L2 = L2(L3)
  L1 = L1[L2]
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = false
    return L2
  end
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "ddns"
  L6 = L1
  L7 = "enabled"
  L3 = L3(L4, L5, L6, L7)
  L5 = L2
  L4 = L2.delete
  L6 = "ddns"
  L7 = L1
  L4(L5, L6, L7)
  L5 = L2
  L4 = L2.commit
  L6 = "ddns"
  L4(L5, L6)
  if L3 == "1" then
    L4 = ddns_stop
    L5 = L1
    L4(L5)
    L4 = ddns_cfg_update
    L4()
  end
  L4 = true
  return L4
end
deleteDdns = L5
function L5(A0, A1)
  local L2, L3, L4
  if A0 then
    L2 = _ddnsServerSwitch
    L3 = _UPVALUE0_
    L3 = L3[A0]
    if A1 then
      L4 = 1
      if L4 then
        goto lbl_12
      end
    end
    L4 = 0
    ::lbl_12::
    return L2(L3, L4)
  end
  L2 = false
  return L2
end
ddnsServerSwitch = L5
function L5()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.foreach
  L3 = "ddns"
  L4 = "service"
  function L5(A0)
    local L1, L2
    L1 = A0.enabled
    if L1 == "1" then
      L1 = ddns_restart
      L2 = A0[".name"]
      L1(L2)
    end
  end
  L1(L2, L3, L4, L5)
  L1 = true
  return L1
end
reload = L5
