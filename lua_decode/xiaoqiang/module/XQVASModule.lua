local L0, L1, L2, L3, L4, L5, L6, L7, L8
L0 = module
L1 = "xiaoqiang.module.XQVASModule"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQConfigs"
L1 = L1(L2)
L2 = require
L3 = "bit"
L2 = L2(L3)
L3 = require
L4 = "luci.model.uci"
L3 = L3(L4)
L3 = L3.cursor
L3 = L3()
L4 = require
L5 = "luci.util"
L4 = L4(L5)
L5 = require
L6 = "json"
L5 = L5(L6)
L6 = {}
L7 = {}
L7.title = "\231\179\187\231\187\159\232\135\170\229\138\168\229\141\135\231\186\167"
L7.desc = "\229\156\168\233\151\178\230\154\135\230\151\182\232\135\170\229\138\168\228\184\186\230\130\168\229\141\135\231\186\167\232\183\175\231\148\177\229\153\168\231\179\187\231\187\159"
L6.auto_upgrade = L7
L7 = {}
L7.title = "\230\129\182\230\132\143\231\189\145\229\157\128\230\143\144\233\134\146"
L7.desc = "\233\152\178\230\172\186\232\175\136\233\152\178\231\155\151\229\143\183\233\152\178\230\156\168\233\169\172\239\188\140\228\184\186\229\174\137\229\133\168\228\184\138\231\189\145\228\191\157\233\169\190\230\138\164\232\136\170"
L6.security_page = L7
L7 = {}
L7.title = "\230\175\148\228\187\183\229\138\169\230\137\139"
L7.desc = "\228\184\186\230\130\168\230\137\190\229\136\176\230\156\128\228\190\191\229\174\156\231\154\132\229\144\140\231\177\187\228\186\167\229\147\129\239\188\140\231\155\180\232\190\190\230\137\128\233\156\128"
L6.shopping_bar = L7
L7 = {}
L7.title = "\231\156\139\231\137\135\229\138\169\230\137\139"
L7.desc = "\229\184\174\228\189\160\230\144\156\231\189\151\230\156\128\231\131\173\231\155\184\229\133\179\232\167\134\233\162\145\239\188\140\230\148\175\230\140\129\232\183\168\229\185\179\229\143\176\230\148\182\232\151\143"
L6.baidu_video_bar = L7
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    L8 = A1[L6]
    if L8 then
      L8 = _UPVALUE0_
      L8 = L8.band
      L9 = L7
      L10 = A1[L6]
      L8 = L8(L9, L10)
      L2[L6] = L8
    else
      L2[L6] = L7
    end
  end
  return L2
end
_rule_merge = L7
function L7()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "xiaoqiang.XQCountryCode"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get_all
  L3 = "vas"
  L1 = L1(L2, L3, L4)
  L2 = L0.getBDataRegion
  L2 = L2()
  L3 = {}
  if L1 then
    for L7, L8 in L4, L5, L6 do
      L10 = L7
      L9 = L7.match
      L11 = "^%."
      L9 = L9(L10, L11)
      if not L9 then
        L9 = L3[L7]
        if not L9 then
          L10 = L8
          L9 = L8.match
          L11 = L2
          L9 = L9(L10, L11)
          if L9 then
            L3[L7] = 1
        end
        else
          L3[L7] = 0
        end
      end
    end
  end
  return L3
end
_country_code_rule = L7
L7 = {}
L8 = _country_code_rule
L7.countrycode = L8
FUNCTIONS = L7
function L7(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = {}
  if A0 ~= "vas" and A0 ~= "vas_user" then
    return L2
  end
  L3 = _UPVALUE0_
  L3 = L3.get_all
  L3 = L3(L4, L5, L6)
  if L3 then
    for L7, L8 in L4, L5, L6 do
      L10 = L7
      L9 = L7.match
      L11 = "^%."
      L9 = L9(L10, L11)
      if not L9 then
        L9 = tonumber
        L10 = L8
        L9 = L9(L10)
        L8 = L9
        if L8 and L8 == -1 then
          L9 = _UPVALUE0_
          L10 = L9
          L9 = L9.get
          L11 = "vas"
          L12 = L7
          L13 = "status"
          L9 = L9(L10, L11, L12, L13)
          L10 = _UPVALUE1_
          L10 = L10.isStrNil
          L11 = L9
          L10 = L10(L11)
          if L10 then
            L8 = 1
          else
            L10 = _UPVALUE2_
            L10 = L10.exec
            L11 = L9
            L10 = L10(L11)
            if L10 then
              L11 = _UPVALUE2_
              L11 = L11.trim
              L12 = L10
              L11 = L11(L12)
              L10 = L11
              L11 = tonumber
              L12 = L10
              L11 = L11(L12)
              L8 = L11 or L8
              if not L11 then
                L8 = 1
              end
            else
              L8 = 0
            end
          end
        end
        if L8 and L8 ~= -2 and L8 ~= -3 and L8 ~= -4 and L8 ~= -6 then
          L2[L7] = L8
        end
        if A1 and (L8 == -4 or L8 == -6) then
          L2[L7] = 0
        end
      end
    end
  end
  return L2
end
vas_info = L7
function L7()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "vas"
  L3 = "services"
  L4 = "security_page"
  L0 = L0(L1, L2, L3, L4)
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "vas_user"
  L4 = "services"
  L5 = "security_page"
  L1 = L1(L2, L3, L4, L5)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "security"
  L5 = "common"
  L6 = "malicious_url_firewall"
  L2 = L2(L3, L4, L5, L6)
  L3 = _UPVALUE0_
  L4 = L3
  L3 = L3.get
  L5 = "vas"
  L6 = "security_page"
  L7 = "on"
  L3 = L3(L4, L5, L6, L7)
  L3 = L3 or L3
  L4 = _UPVALUE0_
  L5 = L4
  L4 = L4.get
  L6 = "vas"
  L7 = "security_page"
  L8 = "off"
  L4 = L4(L5, L6, L7, L8)
  L4 = L4 or L4
  if L0 and L1 and L2 then
    L5 = tonumber
    L6 = L0
    L5 = L5(L6)
    L0 = L5
    L5 = tonumber
    L6 = L1
    L5 = L5(L6)
    L1 = L5
    L5 = tonumber
    L6 = L2
    L5 = L5(L6)
    L2 = L5
    if L0 == -6 and L2 ~= 1 then
      L5 = _UPVALUE1_
      L5 = L5.forkExec
      L6 = L3
      L5(L6)
    elseif L0 ~= -6 and L2 ~= L1 then
      L5 = _UPVALUE1_
      L5 = L5.forkExec
      L6 = L3 or L6
      if L1 ~= 1 or not L3 then
        L6 = L4
      end
      L5(L6)
    end
  end
end
_hot_fix = L7
function L7()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = {}
  L1 = vas_info
  L2 = "vas"
  L1 = L1(L2)
  L2 = vas_info
  L3 = "vas_user"
  L2 = L2(L3)
  L3 = _hot_fix
  L3()
  if not L1 then
    return L0
  end
  L3 = nil
  L7 = "rule"
  function L8(A0)
    local L1, L2, L3, L4
    L1 = FUNCTIONS
    L2 = A0[".name"]
    L1 = L1[L2]
    if L1 then
      L2 = type
      L3 = L1
      L2 = L2(L3)
      if L2 == "function" then
        L2 = _UPVALUE0_
        if L2 then
          L2 = _rule_merge
          L3 = _UPVALUE0_
          L4 = L1
          L4 = L4()
          L2 = L2(L3, L4)
          _UPVALUE0_ = L2
        else
          L2 = L1
          L2 = L2()
          _UPVALUE0_ = L2
        end
      end
    end
  end
  L4(L5, L6, L7, L8)
  for L7, L8 in L4, L5, L6 do
    if L8 then
      L9 = L2[L7]
      if not L9 then
        if L3 then
          if not L3 then
            goto lbl_38
          end
          L9 = L3[L7]
          if L9 ~= 1 then
            goto lbl_38
          end
        end
        L0[L7] = L8
      end
    end
    ::lbl_38::
  end
  return L0
end
get_new_vas = L7
function L7()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
  L0 = {}
  L1 = vas_info
  L2 = "vas"
  L3 = true
  L1 = L1(L2, L3)
  L2 = vas_info
  L3 = "vas_user"
  L2 = L2(L3)
  if not L1 then
    return L0
  end
  L3 = nil
  L7 = "rule"
  function L8(A0)
    local L1, L2, L3, L4
    L1 = FUNCTIONS
    L2 = A0[".name"]
    L1 = L1[L2]
    if L1 then
      L2 = type
      L3 = L1
      L2 = L2(L3)
      if L2 == "function" then
        L2 = _UPVALUE0_
        if L2 then
          L2 = _rule_merge
          L3 = _UPVALUE0_
          L4 = L1
          L4 = L4()
          L2 = L2(L3, L4)
          _UPVALUE0_ = L2
        else
          L2 = L1
          L2 = L2()
          _UPVALUE0_ = L2
        end
      end
    end
  end
  L4(L5, L6, L7, L8)
  for L7, L8 in L4, L5, L6 do
    if L3 then
      if not L3 then
        goto lbl_40
      end
      L9 = L3[L7]
      if L9 ~= 1 then
        goto lbl_40
      end
    end
    if L8 then
      L9 = L2[L7]
      if not L9 then
        L0[L7] = L8
    end
    else
      L9 = L2[L7]
      L0[L7] = L9
    end
    ::lbl_40::
  end
  L7 = "vas"
  L8 = "services"
  L9 = "invalid_page"
  if L4 and L4 ~= -3 then
    if not L5 then
      if L3 then
        if L5 then
          if not L5 then
            goto lbl_84
          end
          if L5 ~= 1 then
            goto lbl_84
          end
        end
      end
      L7 = "http_status_stat"
      L8 = "settings"
      L9 = "enabled"
      L7 = L5
      L0.invalid_page = L6
    end
  end
  ::lbl_84::
  return L0
end
get_vas = L7
function L7()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = {}
  L0.invalid_page_status = "off"
  L0.security_page_status = "off"
  L0.gouwudang_status = "off"
  L0.baidu_video_bar = "off"
  L1 = vas_info
  L1 = L1(L2)
  for L5, L6 in L2, L3, L4 do
    if L5 == "invalid_page" then
      L7 = tonumber
      L8 = L1.invalid_page
      L7 = L7(L8)
      if L7 == 1 then
        L0.invalid_page_status = "on"
      end
    elseif L5 == "security_page" then
      L7 = tonumber
      L8 = L1.security_page
      L7 = L7(L8)
      if L7 == 1 then
        L0.security_page_status = "on"
      end
    elseif L5 == "shopping_bar" then
      L7 = tonumber
      L8 = L1.shopping_bar
      L7 = L7(L8)
      if L7 == 1 then
        L0.gouwudang_status = "on"
      end
    elseif L5 == "baidu_video_bar" then
      L7 = tonumber
      L8 = L1.baidu_video_bar
      L7 = L7(L8)
      if L7 == 1 then
        L0.baidu_video_bar = "on"
      end
    else
      L7 = tonumber
      L8 = L1[L5]
      L7 = L7(L8)
      if L7 == 1 then
        L0[L5] = "on"
      else
        L0[L5] = "off"
      end
    end
  end
  return L0
end
get_vas_kv_info = L7
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  if A0 then
    L1 = type
    L2 = A0
    L1 = L1(L2)
    if L1 == "table" then
      goto lbl_10
    end
  end
  L1 = false
  do return L1 end
  ::lbl_10::
  L1 = {}
  L2 = vas_info
  L2 = L2(L3)
  for L6, L7 in L3, L4, L5 do
    L2[L6] = L7
    L8 = nil
    L9 = _UPVALUE0_
    L10 = L9
    L9 = L9.get
    L11 = "vas"
    L12 = "services"
    L13 = L6
    L9 = L9(L10, L11, L12, L13)
    L9 = L9 or L9
    if L9 then
      L10 = tonumber
      L11 = L9
      L10 = L10(L11)
      if L10 ~= -6 then
        if L7 == 1 then
          L10 = _UPVALUE0_
          L11 = L10
          L10 = L10.get
          L12 = "vas"
          L13 = L6
          L14 = "on"
          L10 = L10(L11, L12, L13, L14)
          L8 = L10
        else
          L10 = _UPVALUE0_
          L11 = L10
          L10 = L10.get
          L12 = "vas"
          L13 = L6
          L14 = "off"
          L10 = L10(L11, L12, L13, L14)
          L8 = L10
        end
        if L8 then
          L10 = table
          L10 = L10.insert
          L11 = L1
          L12 = L8
          L10(L11, L12)
        end
      end
    end
  end
  L6 = "settings"
  L7 = "services"
  L8 = L2
  L3(L4, L5, L6, L7, L8)
  L3(L4, L5)
  for L6, L7 in L3, L4, L5 do
    L8 = _UPVALUE1_
    L8 = L8.forkExec
    L9 = L7
    L8(L9)
  end
end
set_vas = L7
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  if A0 then
    if L1 == "table" then
      goto lbl_10
    end
  end
  do return L1 end
  ::lbl_10::
  for L4, L5 in L1, L2, L3 do
    if L5 then
      if L6 == "table" then
        if L6 then
          L9 = "vas"
          L10 = "services"
          L11 = L4
          if L6 == -6 then
            if L7 ~= -6 then
              L9 = "vas_user"
              L10 = "services"
              L11 = L4
              if L7 then
                L9 = L7
                if L8 == 0 then
                  L9 = L5.service
                  L9 = L9.off
                  L8(L9)
                else
                  L9 = L7
                  if L8 == 1 then
                    L9 = L5.service
                    L9 = L9.on
                    L8(L9)
                  end
                end
              end
          end
          elseif L6 ~= -6 then
            if L7 == -6 then
              L7(L8)
            end
          end
          L9 = "vas"
          L10 = "services"
          L11 = L4
          L12 = L5.status
          L7(L8, L9, L10, L11, L12)
          if L7 == -3 then
            if L7 then
              if L7 then
                L7(L8)
              end
            end
          end
          if L6 == -3 then
            if L7 ~= -3 then
              if L7 ~= -6 then
                L9 = L8
                L10 = "vas_user"
                L11 = "services"
                L12 = L4
                if L7 then
                  if L7 == 1 then
                    L9 = L5.service
                    L9 = L9.on
                    L8(L9)
                  else
                    L9 = L5.service
                    L9 = L9.off
                    L8(L9)
                  end
                end
              end
            end
          end
        end
        if L6 then
          if L6 == "table" then
            for L9, L10 in L6, L7, L8 do
              L11 = _UPVALUE0_
              L12 = L11
              L11 = L11.get_all
              L13 = "vas"
              L14 = L9
              L11 = L11(L12, L13, L14)
              if not L11 then
                L11 = _UPVALUE0_
                L12 = L11
                L11 = L11.section
                L13 = "vas"
                L14 = "rule"
                L15 = L9
                L16 = {}
                L16[L4] = L10
                L11(L12, L13, L14, L15, L16)
              else
                L11 = _UPVALUE0_
                L12 = L11
                L11 = L11.set
                L13 = "vas"
                L14 = L9
                L15 = L4
                L16 = L10
                L11(L12, L13, L14, L15, L16)
              end
            end
          end
        end
        if L6 then
          if L6 == "table" then
            L9 = "service"
            L10 = L4
            L11 = L5.service
            L6(L7, L8, L9, L10, L11)
          end
        end
      end
    end
  end
  L1(L2, L3)
  return L1
end
updateVasConf = L7
function L7()
  local L0, L1
  L0 = vas_info
  L1 = "vas_user"
  return L0(L1)
end
get_vas_info = L7
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7
  if not A0 then
    L1 = nil
    return L1
  end
  L1 = require
  L2 = "xiaoqiang.util.XQHttpUtil"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.trim
  L3 = _UPVALUE0_
  L3 = L3.exec
  L4 = _UPVALUE1_
  L4 = L4.SERVER_CONFIG_ONLINE_URL
  L3, L4, L5, L6, L7 = L3(L4)
  L2 = L2(L3, L4, L5, L6, L7)
  L3 = "http://"
  L4 = L2
  L5 = "/data/new_feature_switch/"
  L6 = A0
  L3 = L3 .. L4 .. L5 .. L6
  L4 = L1.httpGetRequest
  L5 = L3
  L4 = L4(L5)
  L5 = tonumber
  L6 = L4.code
  L5 = L5(L6)
  if L5 == 200 then
    L5 = L4.res
    if L5 then
      L5 = pcall
      L6 = _UPVALUE2_
      L6 = L6.decode
      L7 = L4.res
      L5, L6 = L5(L6, L7)
      if L5 and L6 then
        return L6
      end
    end
  end
  L5 = nil
  return L5
end
do_query = L7
function L7()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L0 = "/tmp/vas_details"
  L1 = require
  L2 = "nixio.fs"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.XQCountryCode"
  L2 = L2(L3)
  L3 = L2.getCurrentJLan
  L3 = L3()
  L4 = os
  L4 = L4.time
  L4 = L4()
  L5 = L1.access
  L6 = L0
  L5 = L5(L6)
  if L5 then
    L5 = L1.readfile
    L6 = L0
    L5 = L5(L6)
    L6 = pcall
    L7 = _UPVALUE0_
    L7 = L7.decode
    L8 = L5
    L6, L7 = L6(L7, L8)
    if L6 and L7 then
      L8 = L7.res
      if L8 then
        L8 = L7.lan
        if L8 == L3 then
          L8 = L7.timestamp
          if L8 then
            L8 = tonumber
            L9 = L4
            L8 = L8(L9)
            L9 = tonumber
            L10 = L7.timestamp
            L9 = L9(L10)
            L8 = L8 - L9
            if L8 < 300 then
              L8 = L7.res
              return L8
            end
          end
        end
      end
    end
  end
  L5 = do_query
  L6 = L3
  L5 = L5(L6)
  if L5 then
    L6 = {}
    L6.res = L5
    L6.lan = L3
    L6.timestamp = L4
    L7 = L1.writefile
    L8 = L0
    L9 = _UPVALUE0_
    L9 = L9.encode
    L10 = L6
    L9, L10 = L9(L10)
    L7(L8, L9, L10)
    return L5
  end
  L6 = nil
  return L6
end
get_server_vas_details = L7
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "nixio.fs"
  L1 = L1(L2)
  L2 = {}
  if A0 then
    L3 = type
    L3 = L3(L4)
    if L3 == "table" then
      L3 = get_server_vas_details
      L3 = L3()
      for L7, L8 in L4, L5, L6 do
        L9 = {}
        L10 = L1.access
        L11 = "/www/vas/"
        L12 = L8
        L13 = ".png"
        L11 = L11 .. L12 .. L13
        L10 = L10(L11)
        if L10 then
          L10 = L8
          L11 = ".png"
          L10 = L10 .. L11
          L9.icon = L10
        else
          L9.icon = "vas_default.png"
        end
        if L3 then
          L10 = L3[L8]
          if L10 then
            L10 = L3[L8]
            L10 = L10.title
            L9.title = L10
            L10 = L3[L8]
            L10 = L10.desc
            L9.desc = L10
        end
        else
          L10 = _UPVALUE0_
          L10 = L10[L8]
          if L10 then
            L10 = _UPVALUE0_
            L10 = L10[L8]
            L10 = L10.title
            L9.title = L10
            L10 = _UPVALUE0_
            L10 = L10[L8]
            L10 = L10.desc
            L9.desc = L10
          end
        end
        L10 = L9.title
        if L10 then
          L10 = L9.desc
          if L10 then
            L2[L8] = L9
          end
        end
      end
    end
  end
  return L2
end
get_vas_details = L7
