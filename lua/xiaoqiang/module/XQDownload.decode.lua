local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39, L40, L41, L42, L43, L44, L45
L0 = require
L1 = "xiaoqiang.XQLog"
L0 = L0(L1)
L1 = require
L2 = "json"
L1 = L1(L2)
json = L1
L1 = require
L2 = "json.rpc"
L1(L2)
L1 = module
L2 = "xiaoqiang.module.XQDownload"
L3 = package
L3 = L3.seeall
L1(L2, L3)
L1 = "http://localhost:6800/jsonrpc"
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L1 = 0
  L2 = "aria2.getGlobalOption"
  L3 = {}
  L4 = {}
  L8 = "main"
  L9 = "autoclean_cycle"
  autoclean_cycle = L5
  L1 = L6
  result = L5
  if L1 then
    L8 = L1
    L5(L6, L7)
    L1 = 2903
    return L5, L6
  else
    L1 = 0
  end
  for L8, L9 in L5, L6, L7 do
    if L8 == "dir" or L8 == "max-concurrent-downloads" or L8 == "max-download-limit" then
      L10 = string
      L10 = L10.gsub
      L11 = L8
      L12 = "-"
      L13 = "_"
      L10 = L10(L11, L12, L13)
      L8 = L10
      L3[L8] = L9
    end
  end
  file = L5
  if L5 ~= nil then
    L3.bind = 1
  else
    L3.bind = 0
  end
  L3.autoclean_cycle = L5
  return L5, L6
end
getGlobalOption = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = 0
  L4 = "aria2.changeGlobalOption"
  L5 = "[{"
  L6 = 0
  if A0 ~= "" then
    L6 = 1
    L7 = L5
    L8 = "'max-download-limit':'"
    L9 = A0
    L10 = "'"
    L5 = L7 .. L8 .. L9 .. L10
    L8 = L2
    L7 = L2.set
    L9 = "aria2"
    L10 = "main"
    L11 = "max_download_limit"
    L12 = A0
    L7(L8, L9, L10, L11, L12)
    L8 = L2
    L7 = L2.commit
    L9 = "aria2"
    L7(L8, L9)
  end
  if A1 ~= "" then
    if L6 == 1 then
      L7 = L5
      L8 = ","
      L5 = L7 .. L8
    end
    L7 = L5
    L8 = "'max-concurrent-downloads':'"
    L9 = A1
    L10 = "'"
    L5 = L7 .. L8 .. L9 .. L10
    L8 = L2
    L7 = L2.set
    L9 = "aria2"
    L10 = "main"
    L11 = "max_concurrent_downloads"
    L12 = A1
    L7(L8, L9, L10, L11, L12)
    L8 = L2
    L7 = L2.commit
    L9 = "aria2"
    L7(L8, L9)
  end
  L7 = L5
  L8 = "}]"
  L5 = L7 .. L8
  L7 = json
  L7 = L7.decode
  L8 = L5
  L7 = L7(L8)
  L5 = L7
  L7 = json
  L7 = L7.rpc
  L7 = L7.call
  L8 = _UPVALUE0_
  L9 = L4
  L10 = L5
  L7, L8 = L7(L8, L9, L10)
  L3 = L8
  result = L7
  if L3 and L3 ~= 0 then
    L7 = _UPVALUE1_
    L7 = L7.log
    L8 = 4
    L9 = "changeGlobalOption "
    L10 = L3
    L9 = L9 .. L10
    L7(L8, L9)
    L3 = 2904
  else
    L3 = 0
  end
  return L3
end
changeGlobalOption = L2
function L2()
  local L0, L1, L2, L3, L4, L5
  L0 = "aria2.tellActive"
  L1 = 0
  L2 = json
  L2 = L2.rpc
  L2 = L2.call
  L3 = _UPVALUE0_
  L4 = L0
  L2, L3 = L2(L3, L4)
  L1 = L3
  result = L2
  if L1 then
    L2 = _UPVALUE1_
    L2 = L2.log
    L3 = 4
    L4 = "tellActive "
    L5 = L1
    L4 = L4 .. L5
    L2(L3, L4)
    L1 = 2914
  else
    L1 = 0
  end
  L2 = result
  L3 = L1
  return L2, L3
end
tellActive = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = "aria2.tellWaiting"
  L1 = "[0,1000]"
  L2 = 0
  L3 = json
  L3 = L3.decode
  L4 = L1
  L3 = L3(L4)
  L1 = L3
  L3 = json
  L3 = L3.rpc
  L3 = L3.call
  L4 = _UPVALUE0_
  L5 = L0
  L6 = L1
  L3, L4 = L3(L4, L5, L6)
  L2 = L4
  result = L3
  if L2 then
    L3 = _UPVALUE1_
    L3 = L3.log
    L4 = 4
    L5 = "tellWaiting "
    L6 = L2
    L5 = L5 .. L6
    L3(L4, L5)
    L2 = 2914
  else
    L2 = 0
  end
  L3 = result
  L4 = L2
  return L3, L4
end
tellWaiting = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = "aria2.tellStopped"
  L1 = "[0,1000]"
  L2 = 0
  L3 = json
  L3 = L3.decode
  L4 = L1
  L3 = L3(L4)
  L1 = L3
  L3 = json
  L3 = L3.rpc
  L3 = L3.call
  L4 = _UPVALUE0_
  L5 = L0
  L6 = L1
  L3, L4 = L3(L4, L5, L6)
  L2 = L4
  result = L3
  if L2 then
    L3 = _UPVALUE1_
    L3 = L3.log
    L4 = 4
    L5 = "tellStopped "
    L6 = L2
    L5 = L5 .. L6
    L3(L4, L5)
    L2 = 2914
  else
    L2 = 0
  end
  L3 = result
  L4 = L2
  return L3, L4
end
tellStopped = L2
function L2()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L0 = "system.multicall"
  L1 = 0
  L2 = nil
  L3 = "[[{'methodName':'aria2.tellActive'},{'methodName':'aria2.tellWaiting','params':[0,1000]}]]"
  L4 = json
  L4 = L4.decode
  L5 = L3
  L4 = L4(L5)
  L3 = L4
  L4 = json
  L4 = L4.rpc
  L4 = L4.call
  L5 = _UPVALUE0_
  L6 = L0
  L7 = L3
  L4, L5 = L4(L5, L6, L7)
  L2 = L5
  L1 = L4
  if L2 then
    L4 = _UPVALUE1_
    L4 = L4.log
    L5 = 4
    L6 = "tellActive "
    L7 = L2
    L6 = L6 .. L7
    L4(L5, L6)
    L2 = 2914
  else
    L2 = 0
  end
  L4 = L1
  L5 = L2
  return L4, L5
end
tellOndownload = L2
function L2(A0)
  local L1, L2
  L1 = {}
  L1.active = 1
  L1.paused = 2
  L1.complete = 3
  L1.waiting = 4
  L2 = L1[A0]
  if L2 ~= nil then
    L2 = L1[A0]
    return L2
  else
    L2 = 0
    return L2
  end
end
function L3(A0)
  local L1, L2
  L1 = {}
  L1.index = true
  L1.path = true
  L1.length = true
  L2 = L1[A0]
  if L2 ~= nil then
    L2 = true
    return L2
  else
    L2 = false
    return L2
  end
end
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = string
  L2 = L2.reverse
  L3 = A0
  L2 = L2(L3)
  L3 = string
  L3 = L3.find
  L4 = L2
  L5 = A1
  L3, L4 = L3(L4, L5)
  L4 = L4 or L4
  L5 = string
  L5 = L5.len
  L6 = A0
  L5 = L5(L6)
  L5 = L5 - L4
  L5 = L5 + 1
  L6 = nil
  L7 = string
  L7 = L7.sub
  L8 = A0
  L9 = L5 + 1
  L10 = string
  L10 = L10.len
  L11 = A0
  L10, L11 = L10(L11)
  L7 = L7(L8, L9, L10, L11)
  L6 = L7
  return L6
end
function L5(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = {}
  L2 = {}
  if L3 ~= "table" then
    return L3
  end
  for L6 = L3, L4, L5 do
    for L10, L11 in L7, L8, L9 do
      L12 = _UPVALUE0_
      L13 = L10
      L12 = L12(L13)
      if L12 then
        if L10 == "path" then
          L12 = _UPVALUE1_
          L13 = L11
          L14 = "/"
          L12 = L12(L13, L14)
          L2.name = L12
        else
          L2[L10] = L11
        end
      end
    end
    if L2 then
      if L7 then
        L7(L8, L9)
        L2 = L7
      end
    end
  end
  return L1
end
function L6(A0)
  local L1, L2
  L1 = {}
  L1.completedLength = true
  L1.totalLength = true
  L1.connections = true
  L1.gid = true
  L1.downloadSpeed = true
  L1.dir = true
  L1.status = true
  L1.errorCode = true
  L1.errorMessage = true
  L2 = L1[A0]
  if L2 ~= nil then
    L2 = true
    return L2
  else
    L2 = false
    return L2
  end
end
function L7(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  if L3 ~= "table" then
    return L3
  end
  for L6 = L3, L4, L5 do
    for L10, L11 in L7, L8, L9 do
      if L10 == A1 then
        if A2 ~= "" then
          if L12 == "table" then
            for L15 = L12, L13, L14 do
              for L19, L20 in L16, L17, L18 do
                if A2 == L19 then
                  return L20
                end
              end
            end
          else
            return L12
          end
        else
          return L11
        end
      end
    end
  end
end
function L8(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31
  L3 = {}
  L4 = {}
  L5 = 0
  if A0 then
    if L6 ~= nil then
      goto lbl_13
    end
  end
  do return L6 end
  ::lbl_13::
  for L9, L10 in L6, L7, L8 do
    if L11 ~= "table" then
      L14 = L9
      L15 = " v "
      L11(L12, L13)
    else
      for L14, L15 in L11, L12, L13 do
        L5 = L5 + 1
        if L16 == "table" then
          for L19, L20 in L16, L17, L18 do
            if L19 == "status" then
              L3[L19] = L21
            elseif L19 == "bittorrent" then
              L3.filetype = "bt"
              for L24, L25 in L21, L22, L23 do
                if L24 == "info" then
                  if L26 == "table" then
                    for L29, L30 in L26, L27, L28 do
                      if L29 == "name" then
                        L3.filename = L30
                      elseif L29 == "creationDate" then
                        L3.creationDate = L30
                      end
                    end
                  end
                end
              end
            elseif L19 == "infoHash" then
              if L21 == nil then
                L3.filename = L20
              end
            elseif L19 == "files" then
              L24 = "uri"
              if L21 and L21 ~= "" then
                if L22 == nil then
                  L3.filename = L21
                end
              end
              if A2 then
                if L22 then
                  L24 = L22
                  if L23 ~= nil then
                    L3.files = L22
                  end
                end
              end
            elseif L21 then
              L3[L19] = L20
            end
          end
        end
        if L16 then
          if L16 then
            if L16 ~= "0" then
              L19 = ".0"
              L3.completedRatio = L16
          end
        end
        else
          L3.completedRatio = 0
        end
        if L16 == nil then
          L3.errorCode = 0
          L3.errorMessage = ""
        end
        if L3 then
          if L16 ~= nil then
            L16(L17, L18)
            L3 = L16
          end
        end
      end
    end
  end
  return L5
end
function L9(A0)
  local L1
  L1 = #A0
  if L1 ~= 16 then
    L1 = false
    return L1
  end
  L1 = true
  return L1
end
function L10(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = {}
  L2 = 0
  if L3 == "table" then
    for L6, L7 in L3, L4, L5 do
      for L11, L12 in L8, L9, L10 do
        if L11 == "code" then
          if L12 ~= 0 then
            L1.errorCode = L12
            L2 = L12
          end
        elseif L11 == "message" then
          L1.errorMassage = L12
        else
          L13 = _UPVALUE0_
          L14 = L12
          L13 = L13(L14)
          if L13 then
            L13 = table
            L13 = L13.insert
            L14 = L1
            L15 = L12
            L13(L14, L15)
          end
        end
      end
    end
  else
    L3(L4, L5)
  end
  return L3, L4
end
function L11(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = {}
  L2 = {}
  L3 = 0
  L4 = "system.multicall"
  L5 = "[["
  L6 = #A0
  for L10, L11 in L7, L8, L9 do
    L6 = L6 - 1
    L12 = L5
    L13 = "{'methodName':'aria2.tellStatus','params':['"
    L14 = L11
    L15 = "']}"
    L5 = L12 .. L13 .. L14 .. L15
    if 0 < L6 then
      L12 = L5
      L13 = ","
      L5 = L12 .. L13
    end
  end
  L5 = L7 .. L8
  L5 = L7
  L10 = L5
  L3 = L8
  L1 = L7
  if L3 then
    L10 = L3
    L7(L8, L9)
    L3 = 2914
  else
    L10 = true
    L7(L8, L9, L10)
    L3 = 0
  end
  return L7, L8
end
getTaskInfo = L11
function L11(A0)
  local L1, L2
  L1 = {}
  L1.complete_record_file = true
  L1.error_record_file = true
  L1.ondownload_record_file = true
  L2 = L1[A0]
  if L2 then
    L2 = false
    return L2
  else
    L2 = true
    return L2
  end
end
function L12(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = 0
  L4 = _UPVALUE0_
  L5 = A1
  L4 = L4(L5)
  if L4 then
    L4 = 0
    L5 = 2915
    return L4, L5
  end
  L5 = L2
  L4 = L2.get
  L6 = "aria2"
  L4 = L4(L5, L6, L7, L8)
  if not L4 or L4 == "" then
    L5 = 0
    L6 = 2926
    return L5, L6
  end
  L5 = io
  L5 = L5.open
  L6 = L4
  L5 = L5(L6, L7)
  L6 = assert
  L6(L7, L8)
  L6 = {}
  for L10 in L7, L8, L9 do
    if L10 and L10 ~= "" then
      L3 = L3 + 1
      L11 = json
      L11 = L11.decode
      L12 = L10
      L11 = L11(L12)
      L6 = L11
      L11 = table
      L11 = L11.insert
      L12 = A0
      L13 = L6
      L11(L12, L13)
      L11 = {}
      L6 = L11
    end
  end
  L7(L8)
  return L7, L8
end
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "aria2"
  L5 = "main"
  L6 = "script"
  L2 = L2(L3, L4, L5, L6)
  L3 = 0
  L4 = L2
  L5 = " ondownload "
  L6 = "read"
  L4 = L4 .. L5 .. L6
  L5 = io
  L5 = L5.popen
  L6 = L4
  L5 = L5(L6)
  L6 = assert
  L7 = L5
  L6(L7, L8)
  L7 = L5
  L6 = L5.read
  L6 = L6(L7, L8)
  L7 = {}
  for L11 in L8, L9, L10 do
    if L11 and L11 ~= "" then
      L12 = json
      L12 = L12.decode
      L13 = L11
      L12 = L12(L13)
      L7 = L12
      L12 = table
      L12 = L12.insert
      L13 = A0
      L14 = L7
      L12(L13, L14)
      L3 = L3 + 1
    end
  end
  return L3
end
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "nixio.fs"
  L3 = L3(L4)
  L4 = 0
  L5 = _UPVALUE0_
  L6 = A1
  L5 = L5(L6)
  if L5 then
    L5 = 0
    L6 = 2915
    return L5, L6
  end
  L6 = L2
  L5 = L2.get
  L7 = "aria2"
  L8 = "main"
  L9 = A1
  L5 = L5(L6, L7, L8, L9)
  if not L5 or L5 == "" then
    L6 = 0
    L7 = 2926
    return L6, L7
  end
  L6 = _UPVALUE1_
  L7 = A0
  L6 = L6(L7)
  L4 = L6
  L6 = L4
  L7 = 0
  return L6, L7
end
function L15()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "xiaoqiang.common.XQFunction"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "aria2"
  L5 = "main"
  L6 = "script"
  L2 = L2(L3, L4, L5, L6)
  L3 = L2
  L4 = " ondownload "
  L5 = "sync"
  L3 = L3 .. L4 .. L5
  L4 = L0.forkExec
  L5 = L3
  L4(L5)
end
function L16()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "aria2"
  L4 = "main"
  L5 = "lock"
  L1 = L1(L2, L3, L4, L5)
  L2 = "ps|grep -c "
  L3 = L1
  L2 = L2 .. L3
  L3 = io
  L3 = L3.popen
  L4 = L2
  L3 = L3(L4)
  L4 = assert
  L5 = L3
  L6 = "run cmd fail"
  L4(L5, L6)
  L5 = L3
  L4 = L3.read
  L6 = "*all"
  L4 = L4(L5, L6)
  L5 = string
  L5 = L5.gsub
  L6 = L4
  L7 = "\n"
  L8 = ""
  L5 = L5(L6, L7, L8)
  L4 = L5
  L5 = tonumber
  L6 = L4
  L5 = L5(L6)
  L4 = L5
  if 2 < L4 then
    L5 = true
    return L5
  else
    L5 = false
    return L5
  end
end
function L17()
  local L0, L1, L2, L3, L4, L5, L6, L7
  L1 = {}
  L1.ondownload_num = 0
  L1.complete_num = 0
  L1.error_num = 0
  L2 = {}
  L3 = {}
  L4 = {}
  L5 = _UPVALUE0_
  L5 = L5()
  if L5 then
    L5 = L1
    L6 = 2925
    return L5, L6
  else
    L5 = _UPVALUE1_
    L5()
  end
  L5 = _UPVALUE2_
  L6 = L2
  L7 = "ondownload_record_file"
  L5, L6 = L5(L6, L7)
  L0 = L6
  L1.ondownload_num = L5
  if L0 ~= 0 then
    L5 = L1
    L6 = L0
    return L5, L6
  end
  L1.ondownload = L2
  L5 = _UPVALUE3_
  L6 = L3
  L7 = "complete_record_file"
  L5, L6 = L5(L6, L7)
  L0 = L6
  L1.complete_num = L5
  if L0 ~= 0 then
    L5 = L1
    L6 = L0
    return L5, L6
  end
  L1.complete = L3
  L5 = _UPVALUE3_
  L6 = L4
  L7 = "error_record_file"
  L5, L6 = L5(L6, L7)
  L0 = L6
  L1.error_num = L5
  if L0 ~= 0 then
    L5 = L1
    L6 = L0
    return L5, L6
  end
  L1.error = L4
  L5 = L1
  L6 = L0
  return L5, L6
end
tellAll = L17
function L17(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = require
  L6 = "xiaoqiang.common.XQFunction"
  L5 = L5(L6)
  L7 = L4
  L6 = L4.get
  L8 = "aria2"
  L9 = "main"
  L10 = "script"
  L6 = L6(L7, L8, L9, L10)
  L7 = L6
  L8 = " basic_record update "
  L9 = A0
  L10 = " "
  L11 = A1
  L12 = " "
  L13 = A2
  L14 = " "
  L15 = A3
  L7 = L7 .. L8 .. L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15
  L8 = L5.forkExec
  L9 = L7
  L8(L9)
end
function L18(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = require
  L6 = "xiaoqiang.common.XQFunction"
  L5 = L5(L6)
  L7 = L4
  L6 = L4.get
  L8 = "aria2"
  L9 = "main"
  L10 = "script"
  L6 = L6(L7, L8, L9, L10)
  L7 = L6
  L8 = " ondownload backup_update "
  L9 = A0
  L10 = " "
  L11 = A1
  L12 = " "
  L13 = A2
  L14 = " "
  L15 = A3
  L7 = L7 .. L8 .. L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15
  L8 = L5.forkExec
  L9 = L7
  L8(L9)
end
function L19(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L2 = L2(L3, L4, L5, L6)
  L3 = io
  L3 = L3.open
  L3 = L3(L4, L5)
  L4(L5, L6)
  for L7 in L4, L5, L6 do
    if L7 and L7 ~= "" then
      L8 = json
      L8 = L8.decode
      L8 = L8(L9)
      for L12, L13 in L9, L10, L11 do
        if L12 == "followedby" and L13 == A0 then
          L14 = L8.gid
          return L14
        end
      end
    end
  end
  return L4
end
function L20(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L3 = 0
  L4 = tostring
  L5 = A2
  L4 = L4(L5)
  L5 = nil
  if not A0 then
    return L6
  end
  for L9 = L6, L7, L8 do
    if L10 == "table" then
      for L13, L14 in L10, L11, L12 do
        L15 = type
        L16 = L13
        L15 = L15(L16)
        if L15 == "number" then
          L15 = type
          L16 = L14
          L15 = L15(L16)
          if L15 == "string" then
            L15 = _UPVALUE0_
            L16 = L14
            L15 = L15(L16)
            if L15 then
              L15 = _UPVALUE1_
              L16 = L14
              L15 = L15(L16)
              L5 = L15
              if L5 then
                L15 = _UPVALUE0_
                L16 = L5
                L15 = L15(L16)
                if L15 then
                  goto lbl_61
                end
              end
              L15 = _UPVALUE2_
              L16 = "gid"
              L17 = L14
              L18 = "pause"
              L19 = L4
              L15(L16, L17, L18, L19)
              L15 = _UPVALUE3_
              L16 = "gid"
              L17 = L14
              L18 = "pause"
              L19 = L4
              L15(L16, L17, L18, L19)
              ::lbl_61::
              L3 = L3 + 1
            end
          end
        end
      end
    elseif L10 == "string" then
      if not L10 then
        goto lbl_101
      end
      L5 = L10
      if L5 then
        if L10 then
          goto lbl_98
        end
      end
      L13 = "pause"
      L14 = L4
      L10(L11, L12, L13, L14)
      L13 = "pause"
      L14 = L4
      L10(L11, L12, L13, L14)
      ::lbl_98::
      L3 = L3 + 1
    else
      return L3
    end
    ::lbl_101::
  end
  return L3
end
function L21(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = "system.multicall"
  L2 = "[["
  L3 = 0
  L4, L5 = nil, nil
  for L9, L10 in L6, L7, L8 do
    L11 = _UPVALUE0_
    L12 = L10
    L11 = L11(L12)
    if L11 then
      L3 = L3 + 1
      L11 = L2
      L12 = "{'methodName':'aria2.forcePause','params':['"
      L13 = L10
      L14 = "']}"
      L2 = L11 .. L12 .. L13 .. L14
    end
  end
  L2 = L6 .. L7
  L2 = L6
  L9 = L2
  L4 = L6
  L5 = L7
  L4 = L6
  L9 = true
  if 0 < L6 then
    L5 = 0
  else
    L5 = 2904
  end
  return L7, L8
end
pause = L21
function L21(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = 0
  L2 = nil
  L3 = "system.multicall"
  L4 = "[["
  L5 = 0
  for L9, L10 in L6, L7, L8 do
    L11 = _UPVALUE0_
    L12 = L10
    L11 = L11(L12)
    if L11 then
      L5 = L5 + 1
      L11 = L4
      L12 = "{'methodName':'aria2.unpause','params':['"
      L13 = L10
      L14 = "']}"
      L4 = L11 .. L12 .. L13 .. L14
    end
  end
  L4 = L6 .. L7
  L4 = L6
  L9 = L4
  L2 = L6
  L1 = L7
  L2 = L6
  L9 = false
  if 0 < L6 then
    L1 = 0
  else
    L1 = 2904
  end
  return L7, L8
end
unpause = L21
function L21()
  local L0, L1, L2, L3, L4, L5
  L0 = "aria2.pauseAll"
  L1 = nil
  L2 = json
  L2 = L2.rpc
  L2 = L2.call
  L3 = _UPVALUE0_
  L4 = L0
  L2 = L2(L3, L4)
  result = L2
  L2 = _UPVALUE1_
  L3 = result
  L2, L3 = L2(L3)
  L1 = L3
  result = L2
  if L1 ~= 0 then
    L2 = _UPVALUE2_
    L2 = L2.log
    L3 = 4
    L4 = "pauseAll "
    L5 = L1
    L4 = L4 .. L5
    L2(L3, L4)
    L1 = 2920
  end
  L2 = result
  L3 = L1
  return L2, L3
end
pauseAll = L21
function L21()
  local L0, L1, L2, L3, L4, L5
  L0 = "aria2.unpauseAll"
  L1 = nil
  L2 = json
  L2 = L2.rpc
  L2 = L2.call
  L3 = _UPVALUE0_
  L4 = L0
  L2, L3 = L2(L3, L4)
  L1 = L3
  result = L2
  L2 = _UPVALUE1_
  L3 = result
  L2, L3 = L2(L3)
  L1 = L3
  result = L2
  if L1 ~= 0 then
    L2 = _UPVALUE2_
    L2 = L2.log
    L3 = 4
    L4 = "unpauseAll "
    L5 = L1
    L4 = L4 .. L5
    L2(L3, L4)
    L1 = 2921
  end
  L2 = result
  L3 = L1
  return L2, L3
end
unpauseAll = L21
function L21(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L4 = L1
  L3 = L1.get
  L5 = "aria2"
  L6 = "main"
  L7 = "script"
  L3 = L3(L4, L5, L6, L7)
  L4 = L3
  L5 = L4
  L6 = " basic_record "
  L7 = "delete "
  L8 = A0
  L4 = L5 .. L6 .. L7 .. L8
  L5 = L2.forkExec
  L6 = L4
  L5(L6)
end
function L22(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L4 = L1
  L3 = L1.get
  L5 = "aria2"
  L6 = "main"
  L7 = "script"
  L3 = L3(L4, L5, L6, L7)
  L4 = L3
  L5 = L4
  L6 = " ondownload "
  L7 = "backup_delete "
  L8 = A0
  L4 = L5 .. L6 .. L7 .. L8
  L5 = L2.forkExec
  L6 = L4
  L5(L6)
end
function L23(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = 0
  L2 = nil
  for L6 = L3, L4, L5 do
    if L7 == "string" then
      if L7 then
        L2 = L7
        if L2 then
          if L7 then
            L7(L8)
            L7(L8)
        end
        else
          L7(L8)
          L7(L8)
        end
        L1 = L1 + 1
      end
    elseif L7 == "table" then
      for L10, L11 in L7, L8, L9 do
        L12 = _UPVALUE0_
        L13 = L11
        L12 = L12(L13)
        if L12 then
          L12 = _UPVALUE1_
          L13 = L11
          L12 = L12(L13)
          L2 = L12
          if L2 then
            L12 = _UPVALUE0_
            L13 = L2
            L12 = L12(L13)
            if L12 then
              L12 = _UPVALUE2_
              L13 = L2
              L12(L13)
              L12 = _UPVALUE3_
              L13 = L2
              L12(L13)
          end
          else
            L12 = _UPVALUE2_
            L13 = L11
            L12(L13)
            L12 = _UPVALUE3_
            L13 = L11
            L12(L13)
          end
          L1 = L1 + 1
        end
      end
    end
  end
  return L1
end
function L24(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = 0
  L2 = nil
  L3 = "system.multicall"
  L4 = "[["
  for L8, L9 in L5, L6, L7 do
    L10 = _UPVALUE0_
    L11 = L9
    L10 = L10(L11)
    if L10 then
      L10 = L4
      L11 = "{'methodName':'aria2.remove','params':['"
      L12 = L9
      L13 = "']}"
      L4 = L10 .. L11 .. L12 .. L13
    end
  end
  L4 = L5 .. L6
  L4 = L5
  L8 = L4
  L2 = L5
  L1 = L6
  L2 = L5
  if 0 < L5 then
    L1 = 0
  else
    L1 = 2906
  end
  return L6, L7
end
remove = L24
function L24(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  L3 = A2[A1]
  if not A0 then
    return L4
  end
  if L4 == "table" then
    for L7, L8 in L4, L5, L6 do
      L9 = type
      L10 = L7
      L9 = L9(L10)
      if L9 == "number" then
        L9 = type
        L10 = L8
        L9 = L9(L10)
        if L9 == "string" then
          L9 = _UPVALUE0_
          L10 = L8
          L9 = L9(L10)
          if L9 then
            L3.gid = L8
          end
        end
      end
    end
  elseif L4 == "string" then
    if L4 then
      L3.gid = A0
    end
  else
    return L4
  end
  return L4
end
function L25(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = A1
  for L6 = L3, L4, L5 do
    L7 = A0[L6]
    if not L7 then
      break
    end
    L8 = L7.gid
    if L8 then
      L8 = _UPVALUE0_
      L9 = L7.gid
      L8 = L8(L9)
      if L8 then
        goto lbl_24
      end
    end
    L8 = table
    L8 = L8.remove
    L9 = A0
    L10 = L6
    L8(L9, L10)
    L2 = L2 - 1
    ::lbl_24::
  end
  return L2
end
function L26(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = 0
  for L7 = L4, L5, L6 do
    L8 = _UPVALUE0_
    L9 = A0[L7]
    L10 = L7
    L11 = A2
    L8(L9, L10, L11)
  end
  return L4
end
function L27(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = 0
  L3 = nil
  if not A1 or A1 == 0 then
    return L4
  end
  for L7 = L4, L5, L6 do
    L3 = A0[L7]
    L8 = _UPVALUE0_
    L9 = L3.gid
    L8 = L8(L9)
    followingGid = L8
    L8 = followingGid
    if L8 then
      L8 = _UPVALUE1_
      L9 = followingGid
      L8 = L8(L9)
      if L8 then
        goto lbl_38
      end
    end
    L8 = _UPVALUE2_
    L9 = "gid"
    L10 = L3.gid
    L11 = "select-file"
    L12 = L3["select-file"]
    L8(L9, L10, L11, L12)
    L8 = _UPVALUE3_
    L9 = "gid"
    L10 = L3.gid
    L11 = "select-file"
    L12 = L3["select-file"]
    L8(L9, L10, L11, L12)
    ::lbl_38::
  end
  return L2
end
function L28(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L2 = "system.multicall"
  L3, L4, L5 = nil, nil, nil
  L6 = 0
  L7 = {}
  L8 = {}
  L9 = "[["
  for L13, L14 in L10, L11, L12 do
    L6 = L6 + 1
    L8.pause = false
    L8["select-file"] = A1
    L15 = _UPVALUE0_
    L15 = L15.log
    L16 = 5
    L17 = "#gid="
    L18 = L14
    L19 = " select="
    L20 = A1
    L17 = L17 .. L18 .. L19 .. L20
    L15(L16, L17)
    L15 = L9
    L16 = "{'methodName':'aria2.changeOption','params':['"
    L17 = L14
    L18 = "'"
    L19 = "{'select-file':'"
    L20 = A1
    L21 = "'}]}"
    L9 = L15 .. L16 .. L17 .. L18 .. L19 .. L20 .. L21
    L15 = L9
    L16 = "{'methodName':'aria2.unpause','params':['"
    L17 = L14
    L18 = "']}"
    L9 = L15 .. L16 .. L17 .. L18
    L15 = table
    L15 = L15.insert
    L16 = L7
    L17 = L8
    L15(L16, L17)
    L15 = {}
    L8 = L15
  end
  L9 = L10 .. L11
  L9 = L10
  L13 = L9
  L3 = L10
  L4 = L11
  L3 = L10
  L13 = L7
  if 0 < L10 then
    L13 = L10
    L11(L12, L13)
    L4 = 0
  else
    L4 = 2904
  end
  return L11, L12
end
changeOption = L28
function L28(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L4 = L1
  L3 = L1.get
  L3 = L3(L4, L5, L6, L7)
  L4 = L3
  L4 = L5 .. L6 .. L7
  for L8, L9 in L5, L6, L7 do
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = 5
    L12 = "clean "
    L13 = L9
    L12 = L12 .. L13
    L10(L11, L12)
    L10 = L2.forkExec
    L11 = L4
    L12 = L9
    L11 = L11 .. L12
    L10(L11)
  end
  return L5
end
clean = L28
function L28(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L4 = L1
  L3 = L1.get
  L3 = L3(L4, L5, L6, L7)
  L4 = L3
  L4 = L5 .. L6 .. L7
  for L8, L9 in L5, L6, L7 do
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = 5
    L12 = "error delete : "
    L13 = L9
    L12 = L12 .. L13
    L10(L11, L12)
    L10 = _UPVALUE1_
    L11 = L9
    L10 = L10(L11)
    if L10 then
      L10 = _UPVALUE2_
      L11 = L9
      L10 = L10(L11)
      if L10 then
        L11 = _UPVALUE1_
        L12 = L10
        L11 = L11(L12)
        if L11 then
          L11 = _UPVALUE3_
          L12 = L10
          L11(L12)
          L11 = _UPVALUE4_
          L12 = L10
          L11(L12)
      end
      else
        L11 = _UPVALUE3_
        L12 = L9
        L11(L12)
        L11 = _UPVALUE4_
        L12 = L9
        L11(L12)
      end
    end
    L10 = L2.forkExec
    L11 = L4
    L12 = L9
    L11 = L11 .. L12
    L10(L11)
  end
  return L5
end
errorDelete = L28
function L28(A0)
  local L1, L2, L3
  L1 = "du -sk '"
  L2 = A0
  L3 = "'|awk '{printf $1 * 1024}'"
  L1 = L1 .. L2 .. L3
  L2 = luci
  L2 = L2.util
  L2 = L2.exec
  L3 = L1
  L2 = L2(L3)
  return L2
end
function L29(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "nixio.fs"
  L2 = L2(L3)
  L3 = "/lost%+found"
  if not A0 or A0 == "" then
    L4 = 2907
    return L4
  end
  L4 = L2.realpath
  L5 = A0
  L4 = L4(L5)
  if L4 == nil then
    L5 = 2908
    return L5
  end
  if A1 then
    L5 = string
    L5 = L5.find
    L6 = L4
    L7 = "/mnt"
    L5 = L5(L6, L7)
    if L5 == nil then
      L5 = 2917
      return L5
    end
  else
    L5 = string
    L5 = L5.find
    L6 = L4
    L7 = "/mnt/"
    L5 = L5(L6, L7)
    if L5 == nil then
      L5 = 2917
      return L5
    end
    L5 = string
    L5 = L5.find
    L6 = L4
    L7 = L3
    L8 = #L3
    L5 = L5(L6, L7, L8)
    if L5 ~= nil then
      L5 = 2922
      return L5
    end
  end
  L5 = 0
  return L5
end
function L30()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "aria2"
  L4 = "main"
  L5 = "pid"
  L1 = L1(L2, L3, L4, L5)
  L2 = io
  L2 = L2.open
  L3 = L1
  L2 = L2(L3)
  L3 = nil
  if L2 then
    L5 = L2
    L4 = L2.read
    L6 = "*all"
    L4 = L4(L5, L6)
    L3 = L4
  end
  if L3 then
    L4 = string
    L4 = L4.gsub
    L5 = L3
    L6 = "\n"
    L7 = ""
    L4 = L4(L5, L6, L7)
    L3 = L4
  else
    L4 = ""
    return L4
  end
  if L3 then
    L4 = tonumber
    L5 = L3
    L4 = L4(L5)
    L3 = L4
  else
    L4 = ""
    return L4
  end
  if not L3 or L3 == "" then
    L4 = ""
    return L4
  end
  L4 = "ps | awk '{ print $1 }' | grep -e '^"
  L5 = L3
  L6 = "'"
  L4 = L4 .. L5 .. L6
  L5 = io
  L5 = L5.popen
  L6 = L4
  L5 = L5(L6)
  if L5 then
    L7 = L5
    L6 = L5.read
    L8 = "*all"
    return L6(L7, L8)
  end
  L6 = ""
  return L6
end
function L31(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = {}
  L2 = {}
  L3 = 0
  L4 = _UPVALUE0_
  L4 = L4()
  if L4 == "" then
    L4 = "0"
    if L4 then
      goto lbl_12
    end
  end
  L4 = "1"
  ::lbl_12::
  L5 = io
  L5 = L5.open
  L6 = A0
  L5 = L5(L6)
  if not L5 then
    L6 = _UPVALUE1_
    L6 = L6.log
    L6(L7, L8)
    L6 = nil
    return L6, L7
  end
  L6 = L5.read
  L6 = L6(L7, L8)
  for L10 in L7, L8, L9 do
    L2.path = L10
    L11 = _UPVALUE2_
    L12 = L10
    L13 = "/"
    L11 = L11(L12, L13)
    L2.name = L11
    L11 = io
    L11 = L11.open
    L12 = L10
    L13 = "rb"
    L11 = L11(L12, L13)
    if not L11 then
      L12 = _UPVALUE1_
      L12 = L12.log
      L13 = 5
      L14 = "file open failed: "
      L15 = L10
      L14 = L14 .. L15
      L12(L13, L14)
      L12 = nil
      L13 = 2916
      return L12, L13
    end
    L12 = _UPVALUE3_
    L13 = L10
    L12 = L12(L13)
    L2.size = L12
    if L2 then
      L12 = next
      L13 = L2
      L12 = L12(L13)
      if L12 ~= nil then
        L12 = table
        L12 = L12.insert
        L13 = L1
        L14 = L2
        L12(L13, L14)
        L12 = {}
        L2 = L12
      end
    end
  end
  return L7, L8, L9
end
getSearchResult = L31
function L31(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L4 = 0
  L5 = {}
  L7 = L2
  L6 = L2.get
  L8 = "aria2"
  L9 = "main"
  L10 = "search"
  L6 = L6(L7, L8, L9, L10)
  L8 = L2
  L7 = L2.get
  L9 = "aria2"
  L10 = "main"
  L11 = "script"
  L7 = L7(L8, L9, L10, L11)
  L8 = nil
  L9 = _UPVALUE0_
  L10 = A0
  L11 = true
  L9 = L9(L10, L11)
  if L9 ~= 0 then
    L10 = nil
    L11 = L9
    return L10, L11
  end
  if A1 ~= "start" and A1 ~= "stop" and A1 ~= "get" then
    L10 = nil
    L11 = 2918
    return L10, L11
  end
  L10 = {}
  function L11()
    local L0, L1, L2, L3, L4
    L0 = os
    L0 = L0.execute
    L1 = _UPVALUE0_
    L2 = " search "
    L3 = "stop"
    L1 = L1 .. L2 .. L3
    L0(L1)
    L0 = _UPVALUE0_
    L1 = " search "
    L2 = _UPVALUE1_
    L3 = " "
    L4 = _UPVALUE2_
    L0 = L0 .. L1 .. L2 .. L3 .. L4
    L1 = _UPVALUE3_
    L1 = L1.forkExec
    L2 = L0
    L1(L2)
  end
  L10.start = L11
  function L11()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE0_
    L1 = " search "
    L2 = _UPVALUE1_
    L3 = " "
    L4 = _UPVALUE2_
    L0 = L0 .. L1 .. L2 .. L3 .. L4
    L1 = _UPVALUE3_
    L1 = L1.forkExec
    L2 = L0
    L1(L2)
  end
  L10.stop = L11
  function L11()
    local L0, L1, L2
    L0 = getSearchResult
    L1 = _UPVALUE3_
    L0, L1, L2 = L0(L1)
    _UPVALUE2_ = L2
    _UPVALUE1_ = L1
    _UPVALUE0_ = L0
  end
  L10.get = L11
  function L11()
    local L0, L1
    L0 = 2916
    _UPVALUE0_ = L0
  end
  L10[""] = L11
  L11 = L10[A1]
  if L11 then
    L12 = L11
    L12()
  else
    L4 = 2915
  end
  L12 = L5
  L13 = L4
  L14 = L8
  return L12, L13, L14
end
searchBitTorrentFile = L31
function L31(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "aria2"
  L5 = "main"
  L6 = "input_file"
  L2 = L2(L3, L4, L5, L6)
  L3 = io
  L3 = L3.open
  L4 = L2
  L5 = "a"
  L3 = L3(L4, L5)
  L4 = assert
  L5 = L3
  L6 = "read file is nil"
  L4(L5, L6)
  L5 = L3
  L4 = L3.write
  L6 = A0.link
  L7 = "\n"
  L6 = L6 .. L7
  L4(L5, L6)
  L5 = L3
  L4 = L3.write
  L6 = " gid="
  L7 = A0.gid
  L8 = "\n"
  L6 = L6 .. L7 .. L8
  L4(L5, L6)
  L5 = L3
  L4 = L3.write
  L6 = " dir="
  L7 = A0.dir
  L8 = "\n"
  L6 = L6 .. L7 .. L8
  L4(L5, L6)
  L5 = L3
  L4 = L3.write
  L6 = " pause=true\n"
  L4(L5, L6)
  L5 = L3
  L4 = L3.write
  L6 = " select-file=\n"
  L4(L5, L6)
  L4 = A0.pause
  if L4 then
    L5 = L3
    L4 = L3.write
    L6 = " pause="
    L7 = tostring
    L8 = A0.pause
    L7 = L7(L8)
    L8 = "\n"
    L6 = L6 .. L7 .. L8
    L4(L5, L6)
  end
  L5 = L3
  L4 = L3.close
  L4(L5)
end
function L32(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "aria2"
  L5 = "main"
  L6 = "basic_file"
  L2 = L2(L3, L4, L5, L6)
  L3 = io
  L3 = L3.open
  L4 = L2
  L5 = "a"
  L3 = L3(L4, L5)
  L4 = assert
  L5 = L3
  L6 = "read file is nil"
  L4(L5, L6)
  L4 = A0.gid
  if L4 then
    L4 = _UPVALUE0_
    L5 = A0.gid
    L4 = L4(L5)
    if L4 then
      L4 = json
      L4 = L4.encode
      L5 = A0
      L4 = L4(L5)
      L6 = L3
      L5 = L3.write
      L7 = L4
      L8 = "\n"
      L7 = L7 .. L8
      L5(L6, L7)
    end
  end
  L5 = L3
  L4 = L3.close
  L4(L5)
end
function L33(A0, A1)
  local L2, L3, L4, L5, L6, L7
  for L5 = L2, L3, L4 do
    L6 = _UPVALUE0_
    L7 = A0[L5]
    L6(L7)
    L6 = _UPVALUE1_
    L7 = A0[L5]
    L6(L7)
  end
end
function L34(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L2 = L2(L3, L4, L5, L6)
  L3 = io
  L3 = L3.open
  L3 = L3(L4, L5)
  L4(L5, L6)
  for L7 in L4, L5, L6 do
    if L7 and L7 ~= "" then
      L8 = json
      L8 = L8.decode
      L8 = L8(L9)
      for L12, L13 in L9, L10, L11 do
        if L12 == "link" and A0 == L13 then
          L14 = true
          return L14
        end
      end
    end
  end
  return L4
end
function L35(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "luci.sys"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L5 = "aria2"
  L6 = "main"
  L7 = "basic_file"
  L3 = L3(L4, L5, L6, L7)
  L4 = "grep -sq -m 1 '"
  L5 = "\"md5\": \""
  L6 = A0
  L7 = "\"' "
  L8 = L3
  L4 = L4 .. L5 .. L6 .. L7 .. L8
  L5 = L1.call
  L6 = L4
  L5 = L5(L6)
  L5 = L5 == 0
  return L5
end
function L36(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12
  if A3 and A3 == "pause" then
    L4 = A0
    L5 = "{'methodName':'aria2.addUri','params':['token:Just4Aria2 c',['"
    L6 = A1
    L7 = "']"
    L8 = "{'dir':'"
    L9 = A2
    L10 = "','pause':'true'"
    L11 = "}"
    L12 = "]}"
    A0 = L4 .. L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11 .. L12
  else
    L4 = A0
    L5 = "{'methodName':'aria2.addUri','params':['token:Just4Aria2 c',['"
    L6 = A1
    L7 = "']"
    L8 = "{'dir':'"
    L9 = A2
    L10 = "'}"
    L11 = "]}"
    A0 = L4 .. L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
  end
  return A0
end
function L37(A0, A1)
  local L2, L3, L4, L5
  L2 = A0
  L3 = "{'methodName':'aria2.changeGlobalOption','params':[{'dir':'"
  L4 = A1
  L5 = "'}]}"
  A0 = L2 .. L3 .. L4 .. L5
  return A0
end
function L38(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = "system.multicall"
  L6 = "[["
  L7 = {}
  L8 = 0
  L9 = {}
  L10 = {}
  L11 = 0
  L12 = _UPVALUE0_
  L12 = L12(L13, L14)
  if L12 ~= 0 then
    return L13, L14
  end
  if L13 ~= "table" then
    L8 = 2915
  else
    for L16, L17 in L13, L14, L15 do
      if L16 == "uris" then
        if L18 == "table" then
          for L21, L22 in L18, L19, L20 do
            if A3 then
              L23 = _UPVALUE1_
              L24 = L6
              L25 = L22
              L26 = A1
              L27 = A2
              L23(L24, L25, L26, L27)
            else
              L23 = _UPVALUE2_
              L24 = L22
              L23 = L23(L24)
              if not L23 then
                L11 = L11 + 1
                L10.link = L22
                L10.dir = A1
                L10.linktype = "uri"
                L23 = table
                L23 = L23.insert
                L24 = L9
                L25 = L10
                L23(L24, L25)
                L23 = _UPVALUE1_
                L24 = L6
                L25 = L22
                L26 = A1
                L27 = A2
                L23(L24, L25, L26, L27)
              end
            end
          end
      end
      elseif L18 == "string" then
        if A3 then
          L21 = A1
          L22 = A2
          L6 = L18
        elseif not L18 then
          L11 = L11 + 1
          L10.link = L17
          L10.dir = A1
          L10.linktype = "uri"
          L18(L19, L20)
          L10 = L18
          L21 = A1
          L22 = A2
          L6 = L18
        end
      else
        L8 = 2913
        L21 = " "
        L22 = L17
        L23 = ": not a table, check json format"
        L18(L19, L20)
        return L18, L19
      end
    end
  end
  L16 = "main"
  L17 = "dir"
  if A1 ~= L13 then
    L16 = "aria2"
    L17 = "main"
    L14(L15, L16, L17, L18, L19)
    L16 = "aria2"
    L14(L15, L16)
    L16 = A1
    L6 = L14
  end
  L6 = L14 .. L15
  L6 = L14
  L16 = L5
  L17 = L6
  L7 = L14
  L8 = L15
  L7 = L14
  if L8 ~= 0 then
    L8 = 2912
  end
  if not A3 then
    L16 = L11
    L17 = L9
    if 0 < L14 then
      L16 = L9
      L17 = L14
      L15(L16, L17)
      L8 = 0
    else
      L8 = 2911
    end
  end
  return L14, L15
end
addUri = L38
function L38(A0, A1)
  local L2, L3, L4, L5
  L2 = #A1
  L3 = string
  L3 = L3.sub
  L4 = A0
  L5 = 0 - L2
  L3 = L3(L4, L5)
  if L3 == A1 then
    L4 = 0
    return L4
  end
  L4 = 1
  return L4
end
function L39(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L3 = A0
  L2 = L2(L3)
  L3 = tonumber
  L4 = L2
  L5 = ".0"
  L4 = L4 .. L5
  L3 = L3(L4)
  L4 = tonumber
  L5 = A1
  L6 = ".0"
  L5 = L5 .. L6
  L4 = L4(L5)
  if L3 > L4 then
    L3 = 1
    return L3
  end
  L3 = 0
  return L3
end
function L40(A0)
  local L1, L2, L3, L4
  L1 = 0
  L2 = _UPVALUE0_
  L3 = A0
  L4 = ".torrent"
  L2 = L2(L3, L4)
  L1 = L2
  if L1 ~= 0 then
    L2 = 2923
    return L2
  end
  L2 = _UPVALUE1_
  L3 = A0
  L4 = "47185920"
  L2 = L2(L3, L4)
  L1 = L2
  if L1 ~= 0 then
    L2 = 2924
    return L2
  end
  L2 = 0
  return L2
end
function L41(A0)
  local L1, L2, L3, L4, L5
  L1 = "base64 "
  L2 = "'"
  L3 = A0
  L4 = "'"
  L1 = L1 .. L2 .. L3 .. L4
  L2 = io
  L2 = L2.popen
  L3 = L1
  L2 = L2(L3)
  L3 = assert
  L4 = L2
  L5 = "base64Encode fail"
  L3(L4, L5)
  L4 = L2
  L3 = L2.read
  L5 = "*all"
  L3 = L3(L4, L5)
  return L3
end
function L42(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21
  L4 = require
  L5 = "luci.model.uci"
  L4 = L4(L5)
  L4 = L4.cursor
  L4 = L4()
  L5 = require
  L6 = "xiaoqiang.util.XQCryptoUtil"
  L5 = L5(L6)
  L6 = {}
  L7 = nil
  L8 = {}
  L9 = {}
  L10 = "system.multicall"
  L11 = "[["
  L12 = 0
  L13 = nil
  L14 = _UPVALUE0_
  L15 = A1
  L16 = false
  L14 = L14(L15, L16)
  if L14 ~= 0 then
    L15 = nil
    L16 = L14
    return L15, L16
  end
  L15 = _UPVALUE0_
  L16 = A0
  L17 = false
  L15 = L15(L16, L17)
  L14 = L15
  if L14 ~= 0 then
    L15 = nil
    L16 = L14
    return L15, L16
  end
  L15 = _UPVALUE1_
  L16 = A0
  L15 = L15(L16)
  L14 = L15
  if L14 ~= 0 then
    L15 = nil
    L16 = L14
    return L15, L16
  end
  L15 = L5.md5File
  L16 = A0
  L15 = L15(L16)
  L13 = L15
  if not L13 then
    L15 = nil
    L16 = 2901
    return L15, L16
  end
  if not A3 then
    L15 = _UPVALUE2_
    L16 = L13
    L15 = L15(L16)
    if L15 then
      L15 = nil
      L16 = 2911
      return L15, L16
    end
  end
  L15 = _UPVALUE3_
  L16 = A0
  L15 = L15(L16)
  L12 = L15
  if A2 and A2 == "pause" then
    L15 = L11
    L16 = "{'methodName':'aria2.addTorrent','params':['"
    L17 = L12
    L18 = "',"
    L19 = "[''],{'pause':'true','dir':'"
    L20 = A1
    L21 = "'}]}"
    L11 = L15 .. L16 .. L17 .. L18 .. L19 .. L20 .. L21
  else
    L15 = L11
    L16 = "{'methodName':'aria2.addTorrent','params':['"
    L17 = L12
    L18 = "',"
    L19 = "[''],{'dir':'"
    L20 = A1
    L21 = "'}]}"
    L11 = L15 .. L16 .. L17 .. L18 .. L19 .. L20 .. L21
  end
  if not A3 then
    L9.linktype = "torrent"
    L9.link = A0
    L9.dir = A1
    L9.md5 = L13
    L15 = table
    L15 = L15.insert
    L16 = L8
    L17 = L9
    L15(L16, L17)
  end
  L16 = L4
  L15 = L4.get
  L17 = "aria2"
  L18 = "main"
  L19 = "dir"
  L15 = L15(L16, L17, L18, L19)
  if A1 ~= L15 then
    L17 = L4
    L16 = L4.set
    L18 = "aria2"
    L19 = "main"
    L20 = "dir"
    L21 = A1
    L16(L17, L18, L19, L20, L21)
    L17 = L4
    L16 = L4.commit
    L18 = "aria2"
    L16(L17, L18)
    L16 = L11
    L17 = "{'methodName':'aria2.changeGlobalOption','params':[{'dir':'"
    L18 = A1
    L19 = "'}]}"
    L11 = L16 .. L17 .. L18 .. L19
  end
  L16 = L11
  L17 = "]]"
  L11 = L16 .. L17
  L16 = json
  L16 = L16.decode
  L17 = L11
  L16 = L16(L17)
  L11 = L16
  L16 = json
  L16 = L16.rpc
  L16 = L16.call
  L17 = _UPVALUE4_
  L18 = L10
  L19 = L11
  L16 = L16(L17, L18, L19)
  L6 = L16
  L16 = _UPVALUE5_
  L17 = L6
  L16, L17 = L16(L17)
  L7 = L17
  L6 = L16
  if not L7 then
    L7 = 0
  else
    L7 = 2901
  end
  if not A3 then
    L16 = _UPVALUE6_
    L17 = L6
    L18 = 1
    L19 = L8
    L16 = L16(L17, L18, L19)
    if 0 < L16 then
      L17 = _UPVALUE7_
      L18 = L8
      L19 = L16
      L17(L18, L19)
      L7 = 0
    else
      L7 = 2901
    end
  end
  L16 = L6
  L17 = L7
  return L16, L17
end
addTorrent = L42
function L42(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L3 = L1
  L2 = L1.get
  L4 = "aria2"
  L2 = L2(L3, L4, L5, L6)
  L3 = nil
  L4 = ""
  if A0 == "" then
    return L4
  end
  L3 = L5
  L5(L6, L7)
  for L8 in L5, L6, L7 do
    if L8 and L8 ~= "" then
      L9 = pcall
      L10 = json
      L10 = L10.decode
      L11 = L8
      L9, L10 = L9(L10, L11)
      if L9 then
        L11 = L10.gid
        if L11 == A0 then
          L11 = L10.path
          L4 = L11 or L4
          if not L11 then
            L4 = "/path/not/exist"
          end
        end
      end
    end
    if L4 ~= "" then
      break
    end
  end
  L5(L6)
  return L4
end
filePathGet = L42
function L42(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = A0
  L3 = false
  L1 = L1(L2, L3)
  return L1
end
checkPath = L42
function L42(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L4 = L1
  L3 = L1.get
  L5 = "aria2"
  L6 = "main"
  L7 = "script"
  L3 = L3(L4, L5, L6, L7)
  L4 = L3
  L5 = " complete_record modify "
  L6 = A0
  L4 = L4 .. L5 .. L6
  L5 = L2.forkExec
  L6 = L4
  L5(L6)
end
fileNotExist = L42
function L42()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.get
  L3 = "aria2"
  L4 = "main"
  L5 = "status"
  L1 = L1(L2, L3, L4, L5)
  L2 = L1
  L3 = 0
  return L2, L3
end
getStatus = L42
function L42(A0)
  local L1, L2
  L1 = {}
  L1[0] = true
  L1[1] = true
  L2 = L1[A0]
  return L2
end
function L43(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = tonumber
  L3 = A0
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L3 = nil
    L4 = 2915
    return L3, L4
  end
  L3 = tonumber
  L5 = L1
  L4 = L1.get
  L6 = "aria2"
  L7 = "main"
  L8 = "status"
  L4, L5, L6, L7, L8, L9 = L4(L5, L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8, L9)
  if L3 ~= L2 then
    L5 = L1
    L4 = L1.set
    L6 = "aria2"
    L7 = "main"
    L8 = "status"
    L9 = L2
    L4(L5, L6, L7, L8, L9)
    L5 = L1
    L4 = L1.commit
    L6 = "aria2"
    L4(L5, L6)
  end
  L4 = L2
  L5 = 0
  return L4, L5
end
setStatus = L43
function L43(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L4 = L2
  L3 = L2.get
  L3 = L3(L4, L5, L6, L7)
  L4 = io
  L4 = L4.open
  L4 = L4(L5, L6)
  L5(L6, L7)
  for L8 in L5, L6, L7 do
    if L8 and L8 ~= "" then
      L9 = json
      L9 = L9.decode
      L10 = L8
      L9 = L9(L10)
      L10 = L9.gid
      if L10 ~= A1 then
        L10 = L9.followedby
        if L10 ~= A1 then
          goto lbl_48
        end
      end
      L10 = L9.link
      A0.link = L10
      L10 = L9.dir
      A0.dir = L10
      L10 = L9.linktype
      A0.linktype = L10
      L10 = L9.select_file
      if L10 then
        L10 = L9.select_file
        A0.select_file = L10
      end
    end
    ::lbl_48::
  end
  L5(L6)
end
function L44(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L1 = require
  L2 = "luci.model.uci"
  L1 = L1(L2)
  L1 = L1.cursor
  L1 = L1()
  L2 = require
  L3 = "nixio.fs"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.common.XQFunction"
  L3 = L3(L4)
  L5 = L1
  L4 = L1.get
  L6 = "aria2"
  L7 = "main"
  L4 = L4(L5, L6, L7, L8)
  L5 = {}
  L6 = nil
  L7 = io
  L7 = L7.open
  L7 = L7(L8, L9)
  L8(L9, L10)
  for L11 in L8, L9, L10 do
    if L11 and L11 ~= "" then
      L12 = json
      L12 = L12.decode
      L13 = L11
      L12 = L12(L13)
      L13 = L12.gid
      if L13 == A0 then
        L13 = L12.dir
        L14 = "/"
        L15 = L12.filename
        L13 = L13 .. L14 .. L15
        L5.file = L13
        L13 = L12.dir
        L14 = "/"
        L15 = L12.filename
        L16 = ".aria2"
        L13 = L13 .. L14 .. L15 .. L16
        L5[".aria2"] = L13
        L13 = L5.file
        if L13 then
          L13 = L2.realpath
          L14 = L5.file
          L13 = L13(L14)
          if L13 then
            L13 = "rm -r '"
            L14 = L5.file
            L15 = "'"
            L6 = L13 .. L14 .. L15
            L13 = L3.forkExec
            L14 = L6
            L13(L14)
          end
        end
        L13 = L5[".aria2"]
        if L13 then
          L13 = L2.realpath
          L14 = L5[".aria2"]
          L13 = L13(L14)
          if L13 then
            L13 = "rm '"
            L14 = L5[".aria2"]
            L15 = "'"
            L6 = L13 .. L14 .. L15
            L13 = L3.forkExec
            L14 = L6
            L13(L14)
          end
        end
        L14 = L7
        L13 = L7.close
        L13(L14)
        return
      end
    end
  end
  L8(L9)
end
function L45(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = {}
  L2, L3, L4 = nil, nil, nil
  L5 = {}
  L6 = _UPVALUE0_
  L7 = L1
  L8 = A0[1]
  L6(L7, L8)
  L6 = _UPVALUE1_
  L7 = A0[1]
  L6(L7)
  L6 = L1.linktype
  if L6 == "torrent" then
    L6 = addTorrent
    L7 = L1.link
    L8 = L1.dir
    L9 = ""
    L10 = true
    L6, L7 = L6(L7, L8, L9, L10)
    L3 = L7
    L2 = L6
  else
    L6 = L1.linktype
    if L6 == "uri" then
      L6 = table
      L6 = L6.insert
      L7 = L5
      L8 = L1.link
      L6(L7, L8)
      L6 = addUri
      L7 = L5
      L8 = L1.dir
      L9 = ""
      L10 = true
      L6, L7 = L6(L7, L8, L9, L10)
      L3 = L7
      L2 = L6
    end
  end
  if L3 ~= 0 then
    L6 = L2
    L7 = L3
    return L6, L7
  end
  L4 = L2[1]
  if L4 then
    L6 = _UPVALUE2_
    L7 = L4
    L6 = L6(L7)
    if L6 then
      goto lbl_55
    end
  end
  L6 = L2
  L7 = 2927
  do return L6, L7 end
  ::lbl_55::
  L6 = _UPVALUE3_
  L7 = "gid"
  L8 = A0[1]
  L9 = "gid"
  L10 = L4
  L6(L7, L8, L9, L10)
  L6 = _UPVALUE3_
  L7 = "followedby"
  L8 = A0[1]
  L9 = "gid"
  L10 = L4
  L6(L7, L8, L9, L10)
  L6 = errorDelete
  L7 = A0
  L6(L7)
  L1.gid = L4
  L6 = _UPVALUE4_
  L7 = L1
  L6(L7)
  L6 = L2
  L7 = L3
  return L6, L7
end
restart = L45
