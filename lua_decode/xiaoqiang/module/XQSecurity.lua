local L0, L1, L2
L0 = module
L1 = "xiaoqiang.module.XQSecurity"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.module.XQVASModule"
L1 = L1(L2)
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = require
  L2 = "xiaoqiang.util.XQPushUtil"
  L1 = L1(L2)
  L2 = tonumber
  L4 = L0
  L3 = L0.get
  L5 = "vas"
  L6 = "services"
  L7 = "security_page"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L2 = L2(L3)
  L3 = tonumber
  L5 = L0
  L4 = L0.get
  L6 = "vas_user"
  L7 = "services"
  L8 = "security_page"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  L3 = L3(L4)
  L4 = tonumber
  L6 = L0
  L5 = L0.get
  L7 = "security"
  L8 = "common"
  L5 = L5(L6, L7, L8, L9)
  L5 = L5 or L5
  L4 = L4(L5)
  if L3 ~= L4 and L2 ~= -6 then
    L6 = L0
    L5 = L0.set
    L7 = "security"
    L8 = "common"
    L5(L6, L7, L8, L9, L10)
    L6 = L0
    L5 = L0.commit
    L7 = "security"
    L5(L6, L7)
    L5 = _UPVALUE0_
    L5 = L5.forkExec
    L6 = "touch /etc/config/securitypage/enable.tag;/etc/init.d/securitypage restart"
    L5(L6)
  end
  L5 = {}
  L5.wifi_arn = 0
  L6 = tonumber
  L8 = L0
  L7 = L0.get
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L6 = L6(L7)
  L5.privacy_protection = L6
  L6 = tonumber
  L8 = L0
  L7 = L0.get
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L6 = L6(L7)
  L5.virus_file_firewall = L6
  L5.malicious_url_firewall = L3
  L6 = _UPVALUE1_
  L6 = L6.get_vas
  L6 = L6()
  L7 = L6.app_security_v2
  if L7 then
    L7 = L6.app_security_v2
    L5.app_security_v2 = L7
  end
  L7 = L1.pushSettings
  L7 = L7()
  L8 = L7.auth
  if L8 then
    L8 = 1
    if L8 then
      goto lbl_98
    end
  end
  L8 = 0
  ::lbl_98::
  L5.wifi_arn = L8
  L8 = 1
  for L12, L13 in L9, L10, L11 do
    if L13 == 0 then
      L8 = 0
      break
    end
  end
  L5.open = L8
  L5.count = L9
  return L5
end
security_status = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = require
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  if A0 then
    if L2 == "table" then
      for L5, L6 in L2, L3, L4 do
        if L5 == "privacy_protection" then
          L8 = L1
          L7 = L1.set
          L9 = "security"
          L10 = "common"
          L11 = "privacy_protection"
          L12 = L6
          L7(L8, L9, L10, L11, L12)
        elseif L5 == "virus_file_firewall" then
          L8 = L1
          L7 = L1.set
          L9 = "security"
          L10 = "common"
          L11 = "virus_file_firewall"
          L12 = L6
          L7(L8, L9, L10, L11, L12)
        elseif L5 == "malicious_url_firewall" then
          L7 = _UPVALUE0_
          L7 = L7.set_vas
          L8 = {}
          L8.security_page = L6
          L7(L8)
        elseif L5 == "app_security_v2" then
          L7 = _UPVALUE0_
          L7 = L7.set_vas
          L8 = {}
          L8.app_security_v2 = L6
          L7(L8)
        end
      end
      L2(L3, L4)
      L2(L3)
    end
  end
end
security_switch = L2
