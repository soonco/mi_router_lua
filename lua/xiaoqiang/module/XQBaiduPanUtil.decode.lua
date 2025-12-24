local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
L0 = module
L1 = "xiaoqiang.module.XQBaiduPanUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.http"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.XQLog"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQFunction"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.util.XQCryptoUtil"
L3 = L3(L4)
L4 = require
L5 = "luci.model.uci"
L4 = L4(L5)
L4 = L4.cursor
L4 = L4()
L5 = require
L6 = "nixio.fs"
L5 = L5(L6)
L6 = require
L7 = "json"
L6 = L6(L7)
L7 = require
L8 = "luci.util"
L7 = L7(L8)
L8 = "/\230\157\165\232\135\170\231\153\190\229\186\166\231\189\145\231\155\152/"
L9 = nil
L10 = 6
L11 = 100
L12 = {}
L12.NO_ERRNO = 1600
L12.ERROR_NOW_RUNNING = 1601
L12.ERROR_FILE_NO_EXIST = 1604
L12.ERROR_UPLOADLIST_FULL = 1605
L12.ERROR_DOWNLOADLIST_FULL = 1606
L12.ERROR_INTERNAL = 1660
L12.ERROR_PEER_INFO = 1661
L12.ERROR_CONFIG_TRANS = 1662
L12.ERROR_INVALID_MODE = 1663
L12.ERROR_INVALID_SIZE = 1664
L12.ERROR_INVALID_LENGTH = 1665
L12.ERROR_INVALID_PARAMETER = 1666
L12.ERROR_INVALID_DISK = 1667
L12.ERROR_PAUSE = 1668
L12.ERROR_UBUS_CALL_FAILED = 1669
L12.ERROR_DIR_OR_FILE_NAME_EXCEPT = 1670
BDPAN_ERROR_CODE = L12
function L12()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "lock /var/run/baidupan.lock"
  L0(L1)
end
lock = L12
function L12()
  local L0, L1
  L0 = os
  L0 = L0.execute
  L1 = "lock -u /var/run/baidupan.lock"
  L0(L1)
end
unlock = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = "stat -c %s '"
  L2 = A0
  L3 = "'"
  L1 = L1 .. L2 .. L3
  L2 = luci
  L2 = L2.util
  L2 = L2.exec
  L3 = L1
  L2 = L2(L3)
  L4 = L2
  L3 = L2.sub
  L5 = 1
  L6 = #L2
  L6 = L6 - 1
  L3 = L3(L4, L5, L6)
  L2 = L3
  L3 = tonumber
  L4 = L2
  L5 = ".0"
  L4 = L4 .. L5
  L3 = L3(L4)
  L3 = L3 or L3
  return L3
end
_file_size = L12
function L12(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = "w+b"
  L3 = io
  L3 = L3.open
  L4 = A0
  L5 = L2
  L3 = L3(L4, L5)
  if L3 then
    L5 = L3
    L4 = L3.write
    L6 = A1
    L4 = L4(L5, L6)
    if L4 == nil then
      L4 = false
      return L4
    end
    L4 = io
    L4 = L4.close
    L5 = L3
    L4(L5)
    L4 = true
    return L4
  else
    L4 = false
    return L4
  end
end
function L13(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.stat
  L2 = A0
  L3 = "type"
  L1 = L1(L2, L3)
  L1 = L1 == "dir"
  return L1
end
function L14(A0)
  local L1, L2, L3
  L1 = io
  L1 = L1.open
  L2 = A0
  L3 = "r"
  L1 = L1(L2, L3)
  if not L1 then
    L2 = false
    return L2
  end
  L3 = L1
  L2 = L1.close
  L2(L3)
  L2 = true
  return L2
end
_file_exists = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = false
  L2 = io
  L2 = L2.open
  L3 = A0
  L4 = "r"
  L2 = L2(L3, L4)
  if L2 then
    L4 = L2
    L3 = L2.read
    L3 = L3(L4)
    L4 = io
    L4 = L4.close
    L5 = L2
    L4(L5)
    if L3 ~= nil then
      L4 = string
      L4 = L4.match
      L5 = L3
      L6 = "31360"
      L4 = L4(L5, L6)
      if L4 then
        L1 = true
      end
    end
  end
  return L1
end
checkTimeoutFile = L14
function L14(A0)
  local L1, L2, L3, L4
  if A0 then
    L1 = string
    L1 = L1.gsub
    L2 = A0
    L3 = "\r?\n"
    L4 = "\r\n"
    L1 = L1(L2, L3, L4)
    A0 = L1
    L1 = string
    L1 = L1.gsub
    L2 = A0
    L3 = "([^%w%-%.%_%~ ])"
    function L4(A0)
      local L1, L2, L3, L4
      L1 = string
      L1 = L1.format
      L2 = "%%%02X"
      L3 = string
      L3 = L3.byte
      L4 = A0
      L3, L4 = L3(L4)
      return L1(L2, L3, L4)
    end
    L1 = L1(L2, L3, L4)
    A0 = L1
    L1 = string
    L1 = L1.gsub
    L2 = A0
    L3 = " "
    L4 = "+"
    L1 = L1(L2, L3, L4)
    A0 = L1
  end
  return A0
end
xqurlencode = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = 3
  L2 = nil
  for L6 = L3, L4, L5 do
    L7 = luci
    L7 = L7.util
    L7 = L7.exec
    L8 = A0
    L7 = L7(L8)
    L2 = L7
    if L2 == nil or L2 == "" then
      L7 = _UPVALUE0_
      L7 = L7.log
      L8 = _UPVALUE1_
      L9 = "test execUrl loop: "
      L10 = L6
      L7(L8, L9, L10)
      L7 = os
      L7 = L7.execute
      L8 = "sleep 1"
      L7(L8)
    else
      break
    end
  end
  return L2
end
execUrl = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = 0
  L3 = 0
  L4 = _file_size
  L5 = A0
  L4 = L4(L5)
  if A1 == "0" then
    L3 = 4294967296
  elseif A1 == "1" then
    L3 = 10737418240
  elseif A1 == "2" then
    L3 = 21474836480
  end
  if L4 > L3 or L4 <= 0 then
    L5 = BDPAN_ERROR_CODE
    L2 = L5.ERROR_INVALID_SIZE
  end
  L5 = _UPVALUE0_
  L5 = L5.log
  L6 = _UPVALUE1_
  L7 = "current size: "
  L8 = L4
  L9 = " max_size: "
  L10 = L3
  L11 = " res: "
  L12 = L2
  L7 = L7 .. L8 .. L9 .. L10 .. L11 .. L12
  L5(L6, L7)
  return L2
end
userFileSize = L14
function L14(A0)
  local L1, L2, L3, L4, L5
  L2 = A0
  L1 = A0.gsub
  L3 = "%s+"
  L4 = ""
  L1 = L1(L2, L3, L4)
  L2 = string
  L2 = L2.gsub
  L3 = L1
  L4 = "%s+"
  L5 = ""
  L2 = L2(L3, L4, L5)
  L1 = L2
  return L1
end
formatFileName = L14
function L14(A0)
  local L1, L2, L3, L4, L5
  L1 = _UPVALUE0_
  L1 = L1.log
  L2 = _UPVALUE1_
  L3 = "BAIDUPAN getFilename url: "
  L4 = A0
  L3 = L3 .. L4
  L1(L2, L3)
  L2 = A0
  L1 = A0.match
  L3 = "([^/]+)$"
  L1 = L1(L2, L3)
  L2 = _UPVALUE0_
  L2 = L2.log
  L3 = _UPVALUE1_
  L4 = "BAIDUPAN getFilename filename: "
  L5 = L1
  L4 = L4 .. L5
  L2(L3, L4)
  L2 = formatFileName
  L3 = L1
  L2 = L2(L3)
  L1 = L2
  L2 = _UPVALUE0_
  L2 = L2.log
  L3 = _UPVALUE1_
  L4 = "BAIDUPAN getFilename format filename: "
  L5 = L1
  L4 = L4 .. L5
  L2(L3, L4)
  return L1
end
getFileName = L14
function L14(A0)
  local L1, L2, L3, L4
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "[^\128-\193]"
  L4 = ""
  L1, L2 = L1(L2, L3, L4)
  if 32 < L2 then
    L3 = BDPAN_ERROR_CODE
    L3 = L3.ERROR_INVALID_LENGTH
    return L3
  end
end
checkFileName = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = io
  L1 = L1.open
  L2 = A0
  L3 = "rb"
  L1 = L1(L2, L3)
  if L1 then
    L3 = L1
    L2 = L1.read
    L4 = "*a"
    L2 = L2(L3, L4)
    L4 = L1
    L3 = L1.close
    L3(L4)
    L3 = string
    L3 = L3.sub
    L4 = L2
    L5 = 1
    L6 = -2
    L3 = L3(L4, L5, L6)
    L2 = L3
    return L2
  else
    L2 = "0"
    return L2
  end
end
getFilePauseStat = L14
function L14(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8
  L4 = A0
  L5 = ":4:"
  L6 = A1
  L7 = ":"
  L8 = A2
  L4 = L4 .. L5 .. L6 .. L7 .. L8
  L5 = sendMsgtoBaidupan
  L6 = "0"
  L7 = L4
  L5(L6, L7)
end
puaseUpload = L14
function L14(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L4 = os
  L4 = L4.time
  L4 = L4()
  L5 = A0
  L6 = ":1:"
  L7 = A1
  L8 = ":"
  L9 = A2
  L10 = ":"
  L11 = L4
  L12 = ":"
  L13 = A3
  L5 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11 .. L12 .. L13
  L6 = sendMsgtoBaidupan
  L7 = "0"
  L8 = L5
  L6(L7, L8)
end
continueUpload = L14
function L14(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11
  if not (A0 and A2) or not A1 then
    L4 = _UPVALUE0_
    L4 = L4.log
    L5 = _UPVALUE1_
    L6 = "invalid input parameters!"
    L4(L5, L6)
    L4 = BDPAN_ERROR_CODE
    L4 = L4.ERROR_INTERNAL
    return L4
  end
  L4 = _UPVALUE0_
  L4 = L4.log
  L5 = _UPVALUE1_
  L6 = "get config from peer: "
  L7 = A0
  L8 = " create file"
  L9 = A2
  L6 = L6 .. L7 .. L8 .. L9
  L4(L5, L6)
  L4 = nil
  if A3 == "0" then
    L5 = "curl -k -L '"
    L6 = A0
    L7 = "&access_token="
    L8 = A1
    L9 = "' -o '"
    L10 = A2
    L11 = "' -H 'User-Agent: pan.baidu.com' -w %{http_code}"
    L4 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
  else
    L5 = "curl -k -L -C - '"
    L6 = A0
    L7 = "&access_token="
    L8 = A1
    L9 = "' -o '"
    L10 = A2
    L11 = "' -H 'User-Agent: pan.baidu.com' -w %{http_code}"
    L4 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
  end
  L5 = _UPVALUE0_
  L5 = L5.log
  L6 = _UPVALUE1_
  L7 = "BAIDUPAN getFileFromDlin URL: "
  L8 = L4
  L7 = L7 .. L8
  L5(L6, L7)
  L5 = luci
  L5 = L5.util
  L5 = L5.exec
  L6 = L4
  L5 = L5(L6)
  if L5 == nil or L5 == "" then
    L6 = BDPAN_ERROR_CODE
    L6 = L6.ERROR_PAUSE
    return L6
  else
    L6 = _UPVALUE0_
    L6 = L6.log
    L7 = _UPVALUE1_
    L8 = "BAIDUPAN getFileFromDlink: result: "
    L9 = L5
    L8 = L8 .. L9
    L6(L7, L8)
  end
  L6 = _UPVALUE0_
  L6 = L6.log
  L7 = _UPVALUE1_
  L8 = "BAIDUPAN getFileFromDlink success"
  L6(L7, L8)
  return L5
end
getFileFromDlink = L14
function L14(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L4 = {}
  L5 = 0
  if not (A0 and A1 and A2) or not A3 then
    L6 = _UPVALUE0_
    L6 = L6.log
    L7 = _UPVALUE1_
    L8 = "invalid input parameters!"
    L6(L7, L8)
    L6 = BDPAN_ERROR_CODE
    L6 = L6.ERROR_INTERNAL
    return L6
  end
  L6 = A3.size
  L7 = "curl -k \"https://pan.baidu.com/rest/2.0/xpan/file?method=create&access_token="
  L8 = A1
  L9 = "\" -d 'path="
  L10 = A0
  L11 = "&size="
  L12 = L6
  L13 = "&isdir=0&rtype=3&uploadid="
  L14 = A3.uploadid
  L15 = "&block_list=[\""
  L16 = A3.block_list
  L17 = "\"]' -H \"User-Agent: pan.baidu.com\""
  L7 = L7 .. L8 .. L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15 .. L16 .. L17
  L8 = execUrl
  L9 = L7
  L8 = L8(L9)
  L9 = _UPVALUE0_
  L9 = L9.log
  L10 = _UPVALUE1_
  L11 = "BAIDUPAN routerCreateFilePost result: "
  L12 = L8
  L11 = L11 .. L12
  L9(L10, L11)
  if L8 == nil or L8 == "" then
    L9 = BDPAN_ERROR_CODE
    L9 = L9.ERROR_INTERNAL
    return L9
  else
    L9 = _UPVALUE2_
    L9 = L9.decode
    L10 = L8
    L9 = L9(L10)
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = _UPVALUE1_
    L12 = "BAIDUPAN routerCreateFilePost errno: "
    L13 = L9.errno
    L12 = L12 .. L13
    L10(L11, L12)
    L5 = L9.errno
  end
  L9 = _UPVALUE0_
  L9 = L9.log
  L10 = _UPVALUE1_
  L11 = "BAIDUPAN routerCreateFilePost success"
  L9(L10, L11)
  return L5
end
routerCreateFilePost = L14
function L14(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35
  L5 = {}
  L6 = 0
  L7 = "/tmp/baidupan/"
  L8 = A4
  L7 = L7 .. L8
  L8 = _UPVALUE0_
  L8 = L8.log
  L9 = _UPVALUE1_
  L10 = "router_upload_file_post respone:  "
  L11 = A3.block_list_count
  L12 = " max_size: "
  L13 = A3.max_size
  L14 = " "
  L15 = A2
  L10 = L10 .. L11 .. L12 .. L13 .. L14 .. L15
  L8(L9, L10)
  L8 = A3.uploadid
  L9 = A3.size
  L10 = A3.block_list_count
  L11 = A3.max_size
  L12 = require
  L13 = "luci.util"
  L12 = L12(L13)
  if not (A0 and A1) or not A2 then
    L13 = _UPVALUE0_
    L13 = L13.log
    L14 = _UPVALUE1_
    L15 = "invalid input parameters!"
    L13(L14, L15)
    L13 = BDPAN_ERROR_CODE
    L13 = L13.ERROR_INTERNAL
    return L13
  end
  L13 = getBaidupanConfigDir
  L13 = L13()
  L14 = _UPVALUE0_
  L14 = L14.log
  L15 = _UPVALUE1_
  L16 = "post config to peer: "
  L16 = L16 .. L17 .. L18 .. L19
  L14(L15, L16)
  L14 = io
  L14 = L14.open
  L15 = A2
  L16 = "rb"
  L14 = L14(L15, L16)
  if not L14 then
    L15 = _UPVALUE0_
    L15 = L15.log
    L16 = _UPVALUE1_
    L15(L16, L17)
    L15 = BDPAN_ERROR_CODE
    L15 = L15.ERROR_INTERNAL
    return L15
  end
  L15 = L13
  L16 = "/.baidupan/tmp/"
  L15 = L15 .. L16 .. L17
  L16 = xqurlencode
  L16 = L16(L17)
  for L20 = L17, L18, L19 do
    L21 = getFilePauseStat
    L21 = L21(L22)
    L25 = L21
    L26 = " i = "
    L27 = L20
    L22(L23, L24)
    if L21 == "1" then
      L22(L23, L24)
      L25 = A4
      L26 = L9
      L22(L23, L24, L25, L26)
      for L25 = L22, L23, L24 do
        L26 = getFilePauseStat
        L27 = L15
        L26 = L26(L27)
        L21 = L26
        L26 = _UPVALUE0_
        L26 = L26.log
        L27 = _UPVALUE1_
        L28 = "file :"
        L29 = A2
        L30 = " pause: "
        L31 = L21
        L32 = " j = "
        L33 = L25
        L34 = " i = "
        L35 = L20
        L28 = L28 .. L29 .. L30 .. L31 .. L32 .. L33 .. L34 .. L35
        L26(L27, L28)
        if L21 == "0" then
          break
        end
        L26 = os
        L26 = L26.execute
        L27 = "sleep 1"
        L26(L27)
      end
      L25 = A4
      L26 = L9
      L22(L23, L24, L25, L26)
    end
    if not L22 then
      L23(L24)
      L25 = "file read failed "
      L23(L24, L25)
      return L23
    end
    L25 = L22
    L23(L24, L25)
    if not L23 then
      L25 = L14
      L24(L25)
      L25 = _UPVALUE1_
      L26 = "file calculate checksum failed: "
      L27 = A2
      L26 = L26 .. L27
      L24(L25, L26)
      return L24
    end
    L25 = "curl -k -F 'file=@"
    L26 = L7
    L27 = "' 'https://d.pcs.baidu.com/rest/2.0/pcs/superfile2?access_token="
    L28 = A1
    L29 = "&method=upload&type=tmpfile&path="
    L30 = L16
    L31 = "&uploadid="
    L32 = L8
    L33 = "&partseq="
    L34 = L24
    L35 = "'"
    L25 = L25 .. L26 .. L27 .. L28 .. L29 .. L30 .. L31 .. L32 .. L33 .. L34 .. L35
    L26 = execUrl
    L27 = L25
    L26 = L26(L27)
    L27 = _UPVALUE0_
    L27 = L27.log
    L28 = _UPVALUE1_
    L29 = "BAIDUPAN router_upload_file_post result: "
    L30 = L26
    L29 = L29 .. L30
    L27(L28, L29)
    if L26 == nil or L26 == "" then
      L27 = BDPAN_ERROR_CODE
      L27 = L27.ERROR_INTERNAL
      return L27
    else
      L27 = _UPVALUE4_
      L27 = L27.decode
      L28 = L26
      L27 = L27(L28)
      L28 = L27.errno
      if L28 then
        L6 = L27.errno
      end
    end
    L27 = "echo '"
    L28 = L20
    L29 = "' > '"
    L30 = L15
    L31 = "_tmp'"
    L27 = L27 .. L28 .. L29 .. L30 .. L31
    L28 = _UPVALUE0_
    L28 = L28.log
    L29 = _UPVALUE1_
    L30 = "BAIDUPAN pause cmd : "
    L31 = L27
    L30 = L30 .. L31
    L28(L29, L30)
    L28 = luci
    L28 = L28.util
    L28 = L28.exec
    L29 = L27
    L28(L29)
  end
  L17(L18)
  L18(L19)
  L20 = "_tmp'"
  L18(L19)
  L18(L19)
  L20 = "everything seems ok with config post!"
  L18(L19, L20)
  return L6
end
routerUploadFilePost = L14
function L14(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24
  L6 = {}
  L7 = "/tmp/baidupan/"
  L8 = A4
  L7 = L7 .. L8
  L8 = nil
  L9 = os
  L9 = L9.time
  L9 = L9()
  if not (A0 and A1) or not A2 then
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = _UPVALUE1_
    L12 = "invalid input parameters!"
    L10(L11, L12)
    L10 = BDPAN_ERROR_CODE
    L10 = L10.ERROR_INTERNAL
    return L10
  end
  L10 = io
  L10 = L10.open
  L11 = A2
  L12 = "rb"
  L10 = L10(L11, L12)
  if not L10 then
    L11 = _UPVALUE0_
    L11 = L11.log
    L12 = _UPVALUE1_
    L13 = "file open failed: "
    L13 = L13 .. L14
    L11(L12, L13)
    L11 = BDPAN_ERROR_CODE
    L11 = L11.ERROR_INTERNAL
    return L11
  end
  L11 = getLocalFileSize
  L12 = A2
  L13 = A3
  L11, L12, L13 = L11(L12, L13)
  L17 = L12
  L18 = " max_size: "
  L19 = L13
  L20 = " count: "
  L21 = L11
  L14(L15, L16)
  L17 = ":"
  L18 = A4
  L19 = ":"
  L20 = L9
  L21 = ":"
  L22 = L12
  L8 = L14 .. L15 .. L16 .. L17 .. L18 .. L19 .. L20 .. L21 .. L22
  L14(L15, L16)
  for L17 = L14, L15, L16 do
    L19 = L10
    L18 = L10.read
    L20 = L13
    L18 = L18(L19, L20)
    if not L18 then
      break
    end
    L19 = _UPVALUE2_
    L20 = L7
    L21 = L18
    L19(L20, L21)
    L19 = _UPVALUE3_
    L19 = L19.md5File
    L20 = L7
    L19 = L19(L20)
    if not L19 then
      L20 = io
      L20 = L20.close
      L21 = L10
      L20(L21)
      L20 = _UPVALUE0_
      L20 = L20.log
      L21 = _UPVALUE1_
      L22 = "file calculate checksum failed: "
      L23 = A2
      L22 = L22 .. L23
      L20(L21, L22)
      L20 = BDPAN_ERROR_CODE
      L20 = L20.ERROR_INTERNAL
      return L20
    elseif not L5 then
      L5 = L19
    else
      L20 = L5
      L21 = "\",\""
      L22 = L19
      L5 = L20 .. L21 .. L22
    end
  end
  L14(L15)
  L6.size = L12
  L6.block_list = L5
  L6.block_list_count = L11
  L6.max_size = L13
  L17 = A0
  L18 = "&size="
  L19 = L12
  L20 = "&isdir=0&autoinit=1&rtype=3&block_list=[\""
  L21 = L5
  L22 = "\"]' -H \"User-Agent: pan.baidu.com\""
  if L15 == nil or L15 == "" then
    return L16
  else
    L17 = L15
    L17 = _UPVALUE0_
    L17 = L17.log
    L18 = _UPVALUE1_
    L19 = "BAIDUPAN router_post: errno: "
    L20 = L16.errno
    L21 = " uploadid: "
    L22 = L16.uploadid
    L19 = L19 .. L20 .. L21 .. L22
    L17(L18, L19)
    L17 = L16.uploadid
    L6.uploadid = L17
  end
  L9 = L16
  L17 = ":1:"
  L18 = L11
  L19 = ":"
  L20 = A4
  L21 = ":"
  L22 = L9
  L23 = ":"
  L24 = L12
  L8 = L16 .. L17 .. L18 .. L19 .. L20 .. L21 .. L22 .. L23 .. L24
  L17 = "0"
  L18 = L8
  L16(L17, L18)
  return L6
end
routerPost = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = A0
  L3 = A1
  L2 = L2 .. L3
  L3 = _UPVALUE0_
  L4 = L2
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.log
  L5 = _UPVALUE2_
  L6 = "creat_baidupan_dir: "
  L7 = L2
  L6 = L6 .. L7
  L4(L5, L6)
  if not L3 then
    L4 = _UPVALUE1_
    L4 = L4.log
    L5 = _UPVALUE2_
    L6 = "create dir success!"
    L4(L5, L6)
    L4 = os
    L4 = L4.execute
    L5 = "mkdir -p "
    L6 = L2
    L7 = " >/dev/null 2>&1"
    L5 = L5 .. L6 .. L7
    L4(L5)
  end
end
creat_baidupan_dir = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = tonumber
  L4 = A0
  L3 = L3(L4)
  L4 = _file_size
  L5 = A1
  L4 = L4(L5)
  L5 = _UPVALUE0_
  L5 = L5.log
  L6 = _UPVALUE1_
  L7 = "BAIDUPAN getBaiduToRouterStatus current filename : "
  L8 = A1
  L9 = " file_size: "
  L10 = L4
  L11 = " max size: "
  L12 = L3
  L7 = L7 .. L8 .. L9 .. L10 .. L11 .. L12
  L5(L6, L7)
  L5 = tostring
  L6 = math
  L6 = L6.floor
  L7 = L4 / L3
  L7 = L7 * 100
  L6 = L6(L7)
  L7 = "%"
  L6 = L6 .. L7
  L5 = L5(L6)
  L6 = _UPVALUE0_
  L6 = L6.log
  L7 = _UPVALUE1_
  L8 = "getBaiduToRouterStatus: "
  L9 = L5
  L8 = L8 .. L9
  L6(L7, L8)
  return L5
end
getBaiduToRouterStatus = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _file_size
  L3 = A1
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.log
  L4 = _UPVALUE1_
  L5 = "BAIDUPAN getDownloadRouterStatus current filename : "
  L6 = A1
  L7 = " file_size: "
  L8 = L2
  L9 = " max size: "
  L10 = A0
  L5 = L5 .. L6 .. L7 .. L8 .. L9 .. L10
  L3(L4, L5)
  L3 = tostring
  L4 = math
  L4 = L4.floor
  L5 = L2 / A0
  L5 = L5 * 100
  L4 = L4(L5)
  L5 = "%"
  L4 = L4 .. L5
  L3 = L3(L4)
  return L3
end
getDownloadRouterStatus = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = 0
  L3 = nil
  L4 = require
  L4 = L4(L5)
  for L8, L9 in L5, L6, L7 do
    L10 = _UPVALUE0_
    L10 = L10.log
    L11 = _UPVALUE1_
    L12 = "BAIDUPAN local file: "
    L13 = L9
    L12 = L12 .. L13
    L10(L11, L12)
    L10 = userFileSize
    L11 = L9
    L12 = A1
    L10 = L10(L11, L12)
    L2 = L10
    if L2 ~= 0 then
      return L2
    end
  end
  return L3
end
parsesLocalDire = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = {}
  for L5, L6 in L2, L3, L4 do
    L7 = string
    L7 = L7.split
    L8 = L6
    L9 = ":"
    L7 = L7(L8, L9)
    L8 = L7[1]
    L1.filename = L8
    L8 = L7[2]
    L1.status = L8
    L8 = L7[3]
    L1.size = L8
    L8 = _UPVALUE0_
    L8 = L8.log
    L9 = _UPVALUE1_
    L10 = "BAIDUPAN local file: "
    L11 = L1.filename
    L12 = " status: "
    L13 = L7[2]
    L10 = L10 .. L11 .. L12 .. L13
    L8(L9, L10)
  end
  return L1
end
parseList = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = 0
  L2 = nil
  for L6, L7 in L3, L4, L5 do
    L8 = string
    L8 = L8.gsub
    L9 = L7.filename
    L10 = "%s+"
    L11 = ""
    L8 = L8(L9, L10, L11)
    L7.filename = L8
    L8 = _UPVALUE0_
    L8 = L8.log
    L9 = _UPVALUE1_
    L10 = "BAIDUPAN parseDlink dlink: "
    L11 = L7.dlink
    L12 = " filename: "
    L13 = L7.filename
    L14 = " size: "
    L15 = L7.size
    L10 = L10 .. L11 .. L12 .. L13 .. L14 .. L15
    L8(L9, L10)
  end
  return L2
end
parseDlink = L14
function L14()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = getBaidupanConfigDir
  L0 = L0()
  L1 = creat_baidupan_dir
  L2 = L0
  L3 = _UPVALUE0_
  L1(L2, L3)
  L1 = L0
  L2 = _UPVALUE0_
  L0 = L1 .. L2
  L1 = _UPVALUE1_
  L2 = L1
  L1 = L1.get
  L3 = "baidupan"
  L4 = "user"
  L5 = "localdir"
  L1 = L1(L2, L3, L4, L5)
  if L1 and L1 == L0 then
    return L0
  end
  L2 = "uci set baidupan.user.localdir='"
  L3 = L0
  L4 = "';uci commit baidupan;"
  L2 = L2 .. L3 .. L4
  L3 = _UPVALUE2_
  L3 = L3.log
  L4 = _UPVALUE3_
  L5 = "BAIDUPAN getLocalPanDire add_dir: "
  L6 = L2
  L5 = L5 .. L6
  L3(L4, L5)
  L3 = handleBaidupanUci
  L4 = L2
  L3(L4)
  return L0
end
getLocalPanDire = L14
function L14()
  local L0, L1, L2, L3, L4, L5
  L0 = getBaidupanConfigDir
  L0 = L0()
  L1 = "/.baidupan/"
  L2 = creat_baidupan_dir
  L3 = L0
  L4 = L1
  L2(L3, L4)
  L2 = creat_baidupan_dir
  L3 = "/etc"
  L4 = L1
  L2(L3, L4)
  L1 = "/.baidupan/tmp/"
  L2 = creat_baidupan_dir
  L3 = L0
  L4 = L1
  L2(L3, L4)
  L2 = L0
  L3 = "/.baidupan/"
  L1 = L2 .. L3
  L2 = _UPVALUE0_
  L2 = L2.log
  L3 = _UPVALUE1_
  L4 = "BAIDUPAN defult mount disk dir: "
  L5 = L1
  L4 = L4 .. L5
  L2(L3, L4)
  return L1
end
creatBaidupanConfigDir = L14
function L14()
  local L0, L1, L2, L3, L4, L5, L6
  L1 = "block info | awk -F 'MOUNT' '{print $2}' | awk -F '\"' 'NR==1{print $2}'"
  L2 = luci
  L2 = L2.util
  L2 = L2.exec
  L3 = L1
  L2 = L2(L3)
  L3 = string
  L3 = L3.gsub
  L4 = L2
  L5 = "^[%s\n\r\t]*(.-)[%s\n\r\t]*$"
  L6 = "%1"
  L3 = L3(L4, L5, L6)
  L2 = L3
  if L2 then
    L0 = L2
  end
  L3 = _UPVALUE0_
  L3 = L3.log
  L4 = _UPVALUE1_
  L5 = "BAIDUPAN getBaidupanConfigDir mount disk: "
  L6 = L2
  L5 = L5 .. L6
  L3(L4, L5)
  return L0
end
getBaidupanConfigDir = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "baidupan"
  L4 = "user"
  L5 = "name"
  L1 = L1(L2, L3, L4, L5)
  L2 = "/etc/.baidupan/"
  L3 = _file_exists
  L4 = L2
  L3 = L3(L4)
  if L1 and L1 == A0 and L3 == true then
    L4 = false
    return L4
  else
    L4 = "uci set baidupan.user.name='"
    L5 = A0
    L6 = "';uci commit baidupan;"
    L4 = L4 .. L5 .. L6
    L5 = handleBaidupanUci
    L6 = L4
    L5(L6)
    L5 = creatBaidupanConfigDir
    L5()
    L5 = true
    return L5
  end
end
setUserName = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = A0 or L1
  if not A0 then
    L1 = ""
  end
  L2 = "pgrep -f \"baidupan.lua .* "
  L3 = L1
  L2 = L2 .. L3 .. L4
  L3 = _UPVALUE0_
  L3 = L3.log
  L3(L4, L5)
  L3 = luci
  L3 = L3.util
  L3 = L3.execl
  L3 = L3(L4)
  for L7, L8 in L4, L5, L6 do
    L9 = _UPVALUE0_
    L9 = L9.log
    L10 = _UPVALUE1_
    L11 = "BAIDUPAN kill_baidupan_process pid: "
    L12 = L8
    L11 = L11 .. L12
    L9(L10, L11)
    if L8 == nil or L8 == "" then
      break
    end
    L9 = "echo `pstree -p "
    L10 = L8
    L11 = "`|awk 'BEGIN{ FS=\"(\" ; RS=\")\" } NF>1 { print $NF }'|xargs kill -9 &>/dev/nul"
    L2 = L9 .. L10 .. L11
    L9 = _UPVALUE0_
    L9 = L9.log
    L10 = _UPVALUE1_
    L11 = "BAIDUPAN kill_baidupan_process cmd_str: "
    L12 = L2
    L11 = L11 .. L12
    L9(L10, L11)
    L9 = luci
    L9 = L9.util
    L9 = L9.exec
    L10 = L2
    L9 = L9(L10)
  end
end
kill_baidupan_process = L14
function L14(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L3 = getBaidupanConfigDir
  L3 = L3()
  L4 = L3
  L5 = "/.baidupan/tmp/"
  L4 = L4 .. L5
  L5 = "/etc/.baidupan/"
  L6 = _UPVALUE0_
  L6 = L6.log
  L6(L7, L8)
  if A0 == "1" then
    L6 = kill_baidupan_process
    L6()
    if A1 == "0" then
      L6 = "rm -rf "
      L6 = L6 .. L7 .. L8
      L7(L8)
      L6 = L7 .. L8 .. L9
      L7(L8)
    elseif A1 == "1" then
      L6 = "rm -rf "
      L6 = L6 .. L7 .. L8
      L7(L8)
    else
      L6 = _UPVALUE0_
      L6 = L6.log
      L6(L7, L8)
    end
  else
    L6 = _UPVALUE2_
    L6 = L6.decode
    L6 = L6(L7)
    for L10, L11 in L7, L8, L9 do
      L12 = type
      L13 = L11
      L12 = L12(L13)
      if L12 == "string" then
        L13 = L11
        L12 = L11.match
        L14 = "^[a-fA-F0-9]+$"
        L12 = L12(L13, L14)
        if L12 then
          goto lbl_82
        end
      end
      L12 = _UPVALUE0_
      L12 = L12.log
      L13 = _UPVALUE1_
      L14 = "BAIDUPAN deleteTransportList error: Invalid actionid detected"
      L12(L13, L14)
      L12 = false
      do return L12 end
      ::lbl_82::
      L12 = _UPVALUE0_
      L12 = L12.log
      L13 = _UPVALUE1_
      L14 = "BAIDUPAN actionid : "
      L15 = L11
      L14 = L14 .. L15
      L12(L13, L14)
      L12 = kill_baidupan_process
      L13 = L11
      L12(L13)
      if A1 == "0" then
        L12 = "rm -rf "
        L13 = L5
        L14 = "upload_"
        L15 = L11
        L12 = L12 .. L13 .. L14 .. L15
        L13 = _UPVALUE0_
        L13 = L13.log
        L14 = _UPVALUE1_
        L15 = "BAIDUPAN last del_upload_list: "
        L16 = L12
        L15 = L15 .. L16
        L13(L14, L15)
        L13 = luci
        L13 = L13.util
        L13 = L13.exec
        L14 = L12
        L13(L14)
      elseif A1 == "1" then
        L12 = "rm -rf "
        L13 = L5
        L14 = "download_"
        L15 = L11
        L12 = L12 .. L13 .. L14 .. L15
        L13 = _UPVALUE0_
        L13 = L13.log
        L14 = _UPVALUE1_
        L15 = "BAIDUPAN last del_download_list: "
        L16 = L12
        L15 = L15 .. L16
        L13(L14, L15)
        L13 = luci
        L13 = L13.util
        L13 = L13.exec
        L14 = L12
        L13(L14)
      else
        L12 = _UPVALUE0_
        L12 = L12.log
        L13 = _UPVALUE1_
        L14 = "BAIDUPAN last deleteTransportList error "
        L12(L13, L14)
      end
    end
  end
  L6 = true
  return L6
end
deleteTransportList = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L4 = _file_size
  L5 = A0
  L4 = L4(L5)
  if A1 == "0" then
    L3 = 4194304
    L5 = math
    L5 = L5.ceil
    L6 = L4 / L3
    L5 = L5(L6)
    L2 = L5
  elseif A1 == "1" then
    L3 = 16777216
    L5 = math
    L5 = L5.ceil
    L6 = L4 / L3
    L5 = L5(L6)
    L2 = L5
  elseif A1 == "2" then
    L3 = 33554432
    L5 = math
    L5 = L5.ceil
    L6 = L4 / L3
    L5 = L5(L6)
    L2 = L5
  end
  L5 = L2
  L6 = L4
  L7 = L3
  return L5, L6, L7
end
getLocalFileSize = L14
function L14(A0)
  local L1, L2, L3, L4, L5
  L1 = string
  L1 = L1.format
  L2 = "/usr/sbin/baidupan_uci_lock.sh \"%s\""
  L3 = A0
  L1 = L1(L2, L3)
  L2 = _UPVALUE0_
  L2 = L2.log
  L3 = baidupan_debug_level
  L4 = "BAIDUPAN handleBaidupanUci: "
  L5 = L1
  L4 = L4 .. L5
  L2(L3, L4)
  L2 = luci
  L2 = L2.util
  L2 = L2.exec
  L3 = L1
  L2(L3)
end
handleBaidupanUci = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = {}
  L2 = {}
  L1.uploading = L2
  L2 = {}
  L1.error = L2
  L2 = {}
  L1.finished = L2
  L2 = {}
  L3 = require
  L4 = "luci.util"
  L3 = L3(L4)
  L4 = require
  L4 = L4(L5)
  for L8, L9 in L5, L6, L7 do
    L10 = L3.split
    L11 = L9
    L12 = ":"
    L10 = L10(L11, L12)
    L11 = tonumber
    L12 = L10[2]
    L11 = L11(L12)
    if L11 == 1 or L11 == 0 or L11 == 4 or L11 == 7 then
      L12 = table
      L12 = L12.insert
      L13 = L1.uploading
      L14 = L9
      L12(L13, L14)
    elseif L11 == 2 then
      L12 = table
      L12 = L12.insert
      L13 = L1.finished
      L14 = L9
      L12(L13, L14)
    else
      L12 = table
      L12 = L12.insert
      L13 = L1.error
      L14 = L9
      L12(L13, L14)
    end
  end
  return L1
end
splitList = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L2 = {}
  for L6, L7 in L3, L4, L5 do
    L8 = getFileName
    L9 = L7
    L8 = L8(L9)
    file_name = L8
    L9 = L7
    L8 = L7.match
    L10 = "(.*[/\\])"
    L8 = L8(L9, L10)
    dir_name = L8
    L8 = _UPVALUE0_
    L8 = L8.log
    L9 = _UPVALUE1_
    L10 = "BAIDUPAN local file: "
    L11 = L7
    L12 = "file name: "
    L13 = file_name
    L14 = " dir: "
    L15 = dir_name
    L10 = L10 .. L11 .. L12 .. L13 .. L14 .. L15
    L8(L9, L10)
    L8 = string
    L8 = L8.find
    L9 = file_name
    L10 = A1
    L8 = L8(L9, L10)
    if L8 ~= nil then
      L9 = string
      L9 = L9.gsub
      L10 = file_name
      L11 = A1
      L12 = "_"
      L9 = L9(L10, L11, L12)
      L10 = dir_name
      L11 = file_name
      L9 = L10 .. L11
      L10 = "mv \""
      L11 = L7
      L12 = "\" \""
      L13 = L9
      L14 = "\""
      L10 = L10 .. L11 .. L12 .. L13 .. L14
      L11 = _UPVALUE0_
      L11 = L11.log
      L12 = _UPVALUE1_
      L13 = "BAIDUPAN rename cmd: "
      L14 = L10
      L13 = L13 .. L14
      L11(L12, L13)
      L11 = luci
      L11 = L11.util
      L11 = L11.exec
      L12 = L10
      L11(L12)
      L11 = table
      L11 = L11.insert
      L12 = L2
      L13 = L9
      L11(L12, L13)
    else
      L9 = _UPVALUE0_
      L9 = L9.log
      L10 = _UPVALUE1_
      L11 = "BAIDUPAN local file: "
      L12 = L7
      L11 = L11 .. L12
      L9(L10, L11)
      L9 = table
      L9 = L9.insert
      L10 = L2
      L11 = L7
      L9(L10, L11)
    end
  end
  return L2
end
handleFileDirname = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  L2 = {}
  L3 = {}
  L4 = require
  L5 = "luci.util"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.XQLog"
  L5 = L5(L6)
  L6 = L5.log
  L7 = _UPVALUE0_
  L8 = "BAIDUPAN checkLocalFileName: "
  L6(L7, L8)
  L6 = _UPVALUE1_
  L6 = L6.decode
  L7 = A0
  L6 = L6(L7)
  L7 = handleFileDirname
  L8 = L6
  L9 = " "
  L7 = L7(L8, L9)
  L6 = L7
  L7 = handleFileDirname
  L8 = L6
  L9 = "'"
  L7 = L7(L8, L9)
  L1 = L7
  L7 = _UPVALUE1_
  L7 = L7.encode
  L8 = L1
  return L7(L8)
end
checkLocalFileName = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L1 = {}
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L3 = L2.log
  L3(L4, L5)
  L3 = _UPVALUE1_
  L3 = L3.decode
  L3 = L3(L4)
  for L7, L8 in L4, L5, L6 do
    L9 = L2.log
    L10 = _UPVALUE0_
    L11 = "BAIDUPAN remote file: "
    L12 = L8.filename
    L11 = L11 .. L12
    L9(L10, L11)
    L9 = string
    L9 = L9.find
    L10 = L8.filename
    L11 = ":"
    L9 = L9(L10, L11)
    if L9 ~= nil then
      L10 = string
      L10 = L10.gsub
      L11 = L8.filename
      L12 = ":"
      L13 = "_"
      L10 = L10(L11, L12, L13)
      L8.filename = L10
    end
    L10 = string
    L10 = L10.find
    L11 = L8.filename
    L12 = " "
    L10 = L10(L11, L12)
    L9 = L10
    if L9 ~= nil then
      L10 = string
      L10 = L10.gsub
      L11 = L8.filename
      L12 = " "
      L13 = "_"
      L10 = L10(L11, L12, L13)
      L8.filename = L10
    end
    L10 = table
    L10 = L10.insert
    L11 = L1
    L12 = L8
    L10(L11, L12)
  end
  return L4(L5)
end
checkRemoteFileName = L14
function L14(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.log
  L3 = _UPVALUE1_
  L4 = " BAIDUPAN function: sendMsgtoBaidupan"
  L2(L3, L4)
  L2 = {}
  L2.type = A0
  L2.cmd = A1
  L3 = callUbus
  L4 = "settaskstatus"
  L5 = L2
  L3 = L3(L4, L5)
  L4 = _UPVALUE2_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L4 = false
    return L4
  end
  L4 = true
  return L4
end
sendMsgtoBaidupan = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = getBaidupanConfigDir
  L1 = L1()
  L2 = "rm -rf "
  L3 = L1
  L4 = "/.baidupan/tmp/"
  L5 = A0
  L6 = "*"
  L2 = L2 .. L3 .. L4 .. L5 .. L6
  L3 = _UPVALUE0_
  L3 = L3.log
  L4 = _UPVALUE1_
  L5 = "BAIDUPAN cleanUploadRepeatEnv 2: "
  L6 = L2
  L5 = L5 .. L6
  L3(L4, L5)
  L3 = _UPVALUE2_
  L3 = L3.exec
  L4 = L2
  L3(L4)
end
cleanUploadRepeatEnv = L14
function L14(A0)
  local L1, L2, L3, L4, L5
  L1 = string
  L1 = L1.len
  L2 = A0
  L1 = L1(L2)
  L2 = 0
  while L1 > L2 do
    L3 = string
    L3 = L3.byte
    L4 = A0
    L5 = L2 + 1
    L3 = L3(L4, L5)
    if 240 <= L3 then
      L4 = true
      return L4
    elseif 224 <= L3 then
      L2 = L2 + 3
    elseif 192 <= L3 then
      L2 = L2 + 2
    else
      L2 = L2 + 1
    end
  end
  L3 = false
  return L3
end
vaildUtf8Str = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.XQLog"
  L2 = L2(L3)
  L3 = L2.log
  L3(L4, L5)
  L3 = _UPVALUE1_
  L3 = L3.decode
  L3 = L3(L4)
  for L7, L8 in L4, L5, L6 do
    L9 = _file_exists
    L10 = L8
    L9 = L9(L10)
    ret = L9
    L9 = ret
    if not L9 then
      L9 = ret
      return L9
    end
    L9 = getFileName
    L10 = L8
    L9 = L9(L10)
    L10 = vaildUtf8Str
    L11 = L9
    L10 = L10(L11)
    if L10 == true then
      L11 = L2.log
      L12 = _UPVALUE0_
      L13 = "A single character exceeds 4 bytes"
      L11(L12, L13)
      L11 = false
      return L11
    end
    L11 = string
    L11 = L11.find
    L12 = L8
    L13 = ":"
    L11 = L11(L12, L13)
    if L11 ~= nil then
      L12 = false
      return L12
    end
    L12 = string
    L12 = L12.find
    L13 = L8
    L14 = "|"
    L12 = L12(L13, L14)
    if L12 ~= nil then
      L13 = false
      return L13
    end
  end
  return L4
end
checkFileFormat = L14
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2 = ""
  L3 = require
  L4 = "ubus"
  L3 = L3(L4)
  L4 = L3.connect
  L4 = L4()
  if L4 then
    L6 = L4
    L5 = L4.call
    L7 = "baidupan_action"
    L8 = A0
    L9 = A1
    L5 = L5(L6, L7, L8, L9)
    L2 = L5
    L6 = L4
    L5 = L4.close
    L5(L6)
  end
  return L2
end
callUbus = L14
function L14()
  local L0, L1, L2, L3
  L0 = 0
  L1 = _UPVALUE0_
  L1 = L1.exec
  L2 = "block info"
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if not L2 then
    L0 = 1
  end
  return L0
end
function L15(A0)
  local L1, L2, L3, L4
  L1 = 0
  L2 = _UPVALUE0_
  L2 = L2.exec
  L3 = "block info | grep "
  L4 = A0
  L3 = L3 .. L4
  L2 = L2(L3)
  L3 = _UPVALUE1_
  L3 = L3.isStrNil
  L4 = L2
  L3 = L3(L4)
  if not L3 then
    L1 = 1
  end
  return L1
end
function L16(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = require
  L2 = "xiaoqiang.module.XQStorage"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "baidupan"
  L5 = "user"
  L6 = "uuid"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = L1.getStorageUuidByMountPath
  L4 = A0
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L4 = 1589
    return L4
  end
  if L2 ~= L3 then
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.set
    L6 = "baidupan"
    L7 = "user"
    L8 = "uuid"
    L9 = L3
    L4(L5, L6, L7, L8, L9)
    L4 = _UPVALUE0_
    L5 = L4
    L4 = L4.commit
    L6 = "baidupan"
    L4(L5, L6)
  end
  L4 = getLocalPanDire
  L4 = L4()
  L5 = type
  L6 = L4
  L5 = L5(L6)
  if L5 == "number" then
    L5 = 1502
    return L5
  end
  L5 = _UPVALUE1_
  L5 = L5.forkExec
  L6 = "/etc/init.d/baidupan restart"
  L5(L6)
  L5 = 0
  return L5
end
setBaidupanPath = L16
function L16()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = {}
  L1 = require
  L2 = "xiaoqiang.module.XQStorage"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L3 = L2
  L2 = L2.get
  L4 = "baidupan"
  L5 = "user"
  L6 = "uuid"
  L2 = L2(L3, L4, L5, L6)
  L2 = L2 or L2
  L3 = _UPVALUE1_
  L3 = L3()
  L4 = _UPVALUE2_
  L4 = L4.isStrNil
  L5 = L2
  L4 = L4(L5)
  if L4 then
    if L3 == 0 then
      L0.bindStatus = "0"
    else
      L0.bindStatus = "1"
    end
  else
    L4 = _UPVALUE3_
    L5 = L2
    L4 = L4(L5)
    if L3 == 0 then
      L0.bindStatus = "2"
    elseif L4 == 0 then
      L0.bindStatus = "4"
    else
      L0.bindStatus = "3"
    end
  end
  L4 = L1.getStorageMountPathByUuid
  L5 = L2
  L4 = L4(L5)
  L0.path = L4
  return L0
end
getBaidupanPath = L16
