local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9
L0 = module
L1 = "xiaoqiang.module.XQMiDockerUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.XQLog"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.common.XQFunction"
L1 = L1(L2)
L2 = require
L3 = "luci.model.uci"
L2 = L2(L3)
L2 = L2.cursor
L2 = L2()
L3 = require
L4 = "luci.util"
L3 = L3(L4)
L4 = require
L5 = "luci.sys"
L4 = L4(L5)
L5 = 6
L6 = {}
L6.ERROR_DOCKER_ALREADY_INSTALL = 1700
L6.ERROR_NOT_INSTALL_DOCKER = 1701
L6.ERROR_NOT_START_DOCKER = 1702
L6.ERROR_INSTALL_DOCKER = 1703
L6.ERROR_UNINSTALL_DOCKER = 1704
L6.ERROR_NOT_INSTALL_USB = 1705
L6.ERROR_NOT_EXT4 = 1706
L6.ERROR_NOT_GREATER_32G = 1707
L6.ERROR_ALREADY_INSTALL = 1708
L6.ERROR_NOW_RUNNING = 1709
L6.ERROR_INVALID_DISK = 1800
L6.ERROR_NETWORK_FAILED = 1801
L6.ERROR_LAN_NOT_EXIST_IP = 1802
DOCKER_ERROR_CODE = L6
function L6(A0)
  local L1, L2, L3
  L1 = {}
  L1.code = A0
  L2 = getErrorMessage
  L3 = A0
  L2 = L2(L3)
  L1.msg = L2
  return L1
end
getErrorInfo = L6
function L6(A0)
  local L1, L2, L3, L4
  L1 = {}
  L2 = _
  L3 = "docker \229\183\178\231\187\143\229\174\137\232\163\133"
  L2 = L2(L3)
  L1[1700] = L2
  L2 = _
  L3 = "\230\178\161\230\156\137\229\174\137\232\163\133docker\231\142\175\229\162\131"
  L2 = L2(L3)
  L1[1701] = L2
  L2 = _
  L3 = "\230\178\161\230\156\137\229\144\175\229\138\168docker"
  L2 = L2(L3)
  L1[1702] = L2
  L2 = _
  L3 = "\228\184\141\229\143\175\231\148\168\239\188\140\230\163\128\230\181\139\229\136\176\229\183\178\229\174\137\232\163\133\231\154\132Docker\230\150\135\228\187\182\231\188\186\229\164\177\239\188\140\232\175\183\229\141\184\232\189\189Docker\229\144\142\233\135\141\230\150\176\229\174\137\232\163\133"
  L2 = L2(L3)
  L1[1703] = L2
  L2 = _
  L3 = "\230\178\161\230\156\137\229\174\137\232\163\133docker"
  L2 = L2(L3)
  L1[1704] = L2
  L2 = _
  L3 = "\230\178\161\230\156\137\229\174\137\232\163\133\231\163\129\231\155\152"
  L2 = L2(L3)
  L1[1705] = L2
  L2 = _
  L3 = "\231\163\129\231\155\152\230\150\135\228\187\182\231\179\187\231\187\159\232\166\129\230\177\130EXT4\230\160\188\229\188\143"
  L2 = L2(L3)
  L1[1706] = L2
  L2 = _
  L3 = "\231\163\129\231\155\152\229\174\185\233\135\143\232\166\129\229\164\167\228\186\14232G"
  L2 = L2(L3)
  L1[1707] = L2
  L2 = _
  L3 = "portainer\230\173\163\229\156\168\229\174\137\232\163\133\230\136\150\229\183\178\231\187\143\229\174\137\232\163\133"
  L2 = L2(L3)
  L1[1708] = L2
  L2 = _
  L3 = "docker\230\173\163\229\156\168\232\191\144\232\161\140"
  L2 = L2(L3)
  L1[1709] = L2
  L2 = _
  L3 = "\228\184\141\229\143\175\231\148\168\239\188\140\230\156\170\230\163\128\230\181\139\229\136\176\228\184\138\228\184\128\230\172\161\229\174\137\232\163\133Docker\231\154\132\229\173\152\229\130\168\229\153\168\239\188\140\232\175\183\229\133\136\229\141\184\232\189\189Docker\229\144\142\233\135\141\230\150\176\232\191\155\232\161\140\229\174\137\232\163\133"
  L2 = L2(L3)
  L1[1800] = L2
  L2 = _
  L3 = "\232\191\158\230\142\165\229\164\150\231\189\145\229\188\130\229\184\184"
  L2 = L2(L3)
  L1[1801] = L2
  L2 = _
  L3 = "lan\229\143\163\230\178\161\230\156\137\229\156\176\229\157\128"
  L2 = L2(L3)
  L1[1801] = L2
  L2 = L1[A0]
  if L2 == nil then
    L2 = translate
    L3 = _
    L4 = "\230\156\170\231\159\165\233\148\153\232\175\175"
    L3, L4 = L3(L4)
    return L2(L3, L4)
  else
    L2 = translate
    L3 = L1[A0]
    return L2(L3)
  end
end
function L7()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = 0
  L1 = 1
  repeat
    L2 = _UPVALUE0_
    L2 = L2.call
    L3 = "pgrep dockerd > /dev/null 2>&1"
    L2 = L2(L3)
    L0 = L2
    if L0 ~= 0 then
      L2 = _UPVALUE1_
      L2 = L2.log
      L3 = _UPVALUE2_
      L4 = "dockerd stopped after "
      L5 = L1
      L6 = " counts"
      L4 = L4 .. L5 .. L6
      L2(L3, L4)
      L2 = true
      return L2
    end
    L2 = _UPVALUE3_
    L2 = L2.exec
    L3 = "sleep 3"
    L2(L3)
    L1 = L1 + 1
  until 100 < L1
  L2 = _UPVALUE1_
  L2 = L2.log
  L3 = _UPVALUE2_
  L4 = "docker can not stop"
  L2(L3, L4)
  L2 = false
  return L2
end
function L8()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "mi_docker"
  L3 = "settings"
  L4 = "portainer_install"
  L0 = L0(L1, L2, L3, L4)
  L1 = 1
  L2 = 0
  if L0 and L0 == "0" then
    L3 = true
    return L3
  end
  while L1 ~= 0 do
    L2 = L2 + 1
    if 99 < L2 then
      L3 = _UPVALUE1_
      L3 = L3.log
      L4 = _UPVALUE2_
      L5 = "portainer can not start"
      L3(L4, L5)
      L3 = false
      return L3
    end
    L3 = _UPVALUE3_
    L3 = L3.exec
    L4 = "sleep 3"
    L3(L4)
    L3 = _UPVALUE4_
    L3 = L3.call
    L4 = "/etc/init.d/mi_docker check_portainer"
    L3 = L3(L4)
    L1 = L3
  end
  L3 = _UPVALUE1_
  L3 = L3.log
  L4 = _UPVALUE2_
  L5 = "portainer start after "
  L6 = L2
  L7 = " counts"
  L5 = L5 .. L6 .. L7
  L3(L4, L5)
  L3 = true
  return L3
end
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.set
  L2 = "mi_docker"
  L3 = "settings"
  L4 = "docker_enable"
  L5 = "1"
  L0(L1, L2, L3, L4, L5)
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.commit
  L2 = "mi_docker"
  L0(L1, L2)
  L0 = _UPVALUE1_
  L0 = L0.forkExec
  L1 = "/etc/init.d/mi_docker start"
  L0(L1)
  L0 = _UPVALUE2_
  return L0()
end
start = L9
function L9()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.set
  L2 = "mi_docker"
  L3 = "settings"
  L4 = "docker_enable"
  L5 = "0"
  L0(L1, L2, L3, L4, L5)
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.commit
  L2 = "mi_docker"
  L0(L1, L2)
  L0 = _UPVALUE1_
  L0 = L0.forkExec
  L1 = "/etc/init.d/mi_docker stop"
  L0(L1)
  L0 = _UPVALUE2_
  return L0()
end
stop = L9
function L9()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = "/etc/init.d/mi_docker ui_install"
  L0(L1)
end
install = L9
function L9()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.call
  L1 = "/etc/init.d/mi_docker ui_uninstall"
  L0(L1)
end
uninstall = L9
function L9()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = "/etc/init.d/mi_docker install_portainer"
  L0(L1)
end
installPortainer = L9
function L9()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.call
  L1 = "/etc/init.d/mi_docker check_docker_env"
  return L0(L1)
end
checkEnv = L9
function L9()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.call
  L1 = "pgrep dockerd >/dev/null"
  L0 = L0(L1)
  L0 = L0 == 0
  return L0
end
checkRunning = L9
function L9()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L0.msg = ""
  L0.code = 0
  L1 = nil
  L2 = checkEnv
  L2 = L2()
  if L2 ~= 0 then
    L0.disk_type = nil
    L0.disk_size = nil
    L0.install_docker = 0
    L0.docker = 0
    L0.portainer = 0
    L2 = DOCKER_ERROR_CODE
    L2 = L2.ERROR_INVALID_DISK
    L0.code = L2
    L2 = _UPVALUE0_
    L3 = L0.code
    L2 = L2(L3)
    L0.msg = L2
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.get
    L4 = "mi_docker"
    L5 = "settings"
    L6 = "docker_install"
    L2 = L2(L3, L4, L5, L6)
    L1 = L2
    if L1 and L1 == "1" then
      L0.install_docker = 1
    end
  else
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.get
    L4 = "mi_docker"
    L5 = "settings"
    L6 = "device_type"
    L2 = L2(L3, L4, L5, L6)
    L2 = L2 or L2
    L0.disk_type = L2
    L2 = _UPVALUE2_
    L2 = L2.exec
    L3 = "/etc/init.d/mi_docker get_disk_size"
    L2 = L2(L3)
    L0.disk_size = L2
    L0.install_docker = 1
    L2 = _UPVALUE3_
    L2 = L2.call
    L3 = "/etc/init.d/mi_docker check_bins"
    L2 = L2(L3)
    L1 = L2
    if L1 ~= 0 then
      L0.install_docker_success = 0
    else
      L0.install_docker_success = 1
    end
    L2 = _UPVALUE1_
    L3 = L2
    L2 = L2.get
    L4 = "mi_docker"
    L5 = "settings"
    L6 = "docker_enable"
    L2 = L2(L3, L4, L5, L6)
    if L2 and L2 == "1" then
      L0.docker = 1
    else
      L0.docker = 0
    end
    L3 = _UPVALUE3_
    L3 = L3.call
    L4 = "/etc/init.d/mi_docker check_portainer"
    L3 = L3(L4)
    L1 = L3
    if L1 == 0 then
      L0.portainer = 1
    else
      L0.portainer = 0
    end
    L3 = L0.docker
    if L3 == 1 then
      L3 = _UPVALUE3_
      L3 = L3.call
      L4 = "/etc/init.d/mi_docker check_integrity"
      L3 = L3(L4)
      L1 = L3
      if L1 ~= 0 then
        L3 = DOCKER_ERROR_CODE
        L3 = L3.ERROR_INSTALL_DOCKER
        L0.code = L3
        L3 = _UPVALUE0_
        L4 = L0.code
        L3 = L3(L4)
        L0.msg = L3
        L0.docker = 0
        L0.portainer = 0
      end
    end
  end
  return L0
end
getInfo = L9
function L9()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.call
  L1 = "/etc/init.d/mi_docker cancel_install"
  L0(L1)
end
cancelInstall = L9
function L9()
  local L0, L1
  L0 = _UPVALUE0_
  L0 = L0.call
  L1 = "/etc/init.d/mi_docker cancel_install_portainer"
  L0(L1)
end
cancelInstallPortainer = L9
