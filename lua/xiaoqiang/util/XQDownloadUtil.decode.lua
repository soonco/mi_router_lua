local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33
L0 = module
L1 = "xiaoqiang.util.XQDownloadUtil"
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
L3 = "xiaoqiang.XQPreference"
L2 = L2(L3)
L3 = require
L4 = "nixio.fs"
L3 = L3(L4)
L4 = require
L5 = "luci.fs"
L4 = L4(L5)
L5 = require
L6 = "luci.util"
L5 = L5(L6)
L6 = require
L7 = "xiaoqiang.XQLog"
L6 = L6(L7)
L7 = require
L8 = "xiaoqiang.util.XQCryptoUtil"
L7 = L7(L8)
L8 = tostring
L9 = L5.trim
L10 = L5.exec
L11 = "uci -q get misc.ota_pred.download_time"
L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L10(L11)
L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L9(L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
L8 = L8(L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
L9 = "/tmp/rom.bin"
L10 = "DOWNLOAD_FILE_PATH"
L11 = "curl"
L12 = require
L13 = "xiaoqiang.util.XQSysUtil"
L12 = L12(L13)
L13 = L1.CPE_MODEM_LENGTH_FILE
L14 = L1.CPE_HEADER_CACHE_FILEPATH
L15 = L1.CPE_MODEM_CACHE_FILEPATH
L16 = L1.CPE_SIGN_CACHE_FILEPATH
L17 = L1.CPE_HEADER_LENGTH
L18 = L1.CPE_SIGN_LENGTH
L19 = "/tmp/modemSlice.bin"
L20 = {}
L21 = {}
L21.size = L17
L21.path = L14
L22 = {}
L22.size = 0
L22.path = L15
L23 = {}
L23.size = L18
L23.path = L16
L24 = {}
L24.size = 0
L24.path = L9
L20[1] = L21
L20[2] = L22
L20[3] = L23
L20[4] = L24
CPE_FIRMWARE_INFO = L20
L20 = L0.isStrNil
L21 = L8
L20 = L20(L21)
if L20 then
  L8 = "30"
end
L20 = L11
L21 = " --retry 3 -m "
L22 = L8
L23 = " -s -f -o %s %s"
L20 = L20 .. L21 .. L22 .. L23
L21 = L11
L22 = " --retry 3 -m 10 -s -f -I -o /dev/null %s"
L21 = L21 .. L22
L22 = L11
L23 = " --range %d-%d --retry 3 -m "
L24 = L8
L25 = " -s -f -o %s %s"
L22 = L22 .. L23 .. L24 .. L25
function L23(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = os
  L1 = L1.execute
  L2 = string
  L2 = L2.format
  L3 = _UPVALUE1_
  L4 = A0
  L2, L3, L4 = L2(L3, L4)
  L1 = L1(L2, L3, L4)
  L1 = 0 == L1
  return L1
end
function L24(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = _UPVALUE1_
  L2 = _UPVALUE2_
  L2 = L2.access
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = _UPVALUE2_
    L2 = L2.unlink
    L3 = L1
    L2(L3)
  end
  L2 = _UPVALUE3_
  L2 = L2.exec
  L3 = string
  L3 = L3.format
  L4 = _UPVALUE4_
  L5 = 4
  L6 = 7
  L7 = L1
  L8 = A0
  L3, L4, L5, L6, L7, L8, L9, L10, L11 = L3(L4, L5, L6, L7, L8)
  L2(L3, L4, L5, L6, L7, L8, L9, L10, L11)
  L2 = io
  L2 = L2.open
  L3 = L1
  L4 = "r"
  L2 = L2(L3, L4)
  if L2 then
    L4 = L2
    L3 = L2.read
    L3 = L3(L4)
    L4 = string
    L4 = L4.format
    L5 = "%02x%02x%02x%02x"
    L7 = L3
    L6 = L3.byte
    L8 = 4
    L6 = L6(L7, L8)
    L8 = L3
    L7 = L3.byte
    L9 = 3
    L7 = L7(L8, L9)
    L9 = L3
    L8 = L3.byte
    L10 = 2
    L8 = L8(L9, L10)
    L10 = L3
    L9 = L3.byte
    L11 = 1
    L9, L10, L11 = L9(L10, L11)
    L4 = L4(L5, L6, L7, L8, L9, L10, L11)
    L5 = _UPVALUE5_
    L5 = L5.log
    L6 = 6
    L7 = "get cpe modem length success"
    L8 = L4
    L7 = L7 .. L8
    L5(L6, L7)
    L5 = tonumber
    L6 = L4
    L7 = 16
    return L5(L6, L7)
  else
    L3 = _UPVALUE5_
    L3 = L3.log
    L4 = 6
    L5 = "get cpe modem length false"
    L3(L4, L5)
    L3 = false
    return L3
  end
end
function L25(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L4 = _UPVALUE0_
  L4 = L4.CPE_UPLOAD_CPE_ROM_SLICE_SIZE
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L6 = A0
  L5 = L5(L6)
  if L5 then
    L5 = false
    return L5
  end
  L5 = string
  L5 = L5.find
  L6 = A3
  L7 = "mtd"
  L5 = L5(L6, L7)
  if not L5 then
    L5 = _UPVALUE2_
    L5 = L5.access
    L6 = A3
    L5 = L5(L6)
    if L5 then
      L5 = _UPVALUE2_
      L5 = L5.unlink
      L6 = A3
      L5(L6)
    end
    L5 = _UPVALUE3_
    L5 = L5.exec
    L6 = string
    L6 = L6.format
    L7 = _UPVALUE4_
    L8 = A1
    L9 = A2
    L10 = A3
    L11 = A0
    L6, L7, L8, L9, L10, L11, L12, L13 = L6(L7, L8, L9, L10, L11)
    L5(L6, L7, L8, L9, L10, L11, L12, L13)
    L5 = true
    return L5
  else
    L5 = _UPVALUE3_
    L5 = L5.exec
    L6 = "mtd erase %s >/dev/null 2>/dev/null"
    L7 = A3
    L5(L6, L7)
    L5 = A2 - A1
    L5 = L5 + 1
    L6 = 0
    while 0 < L5 do
      L7 = _UPVALUE2_
      L7 = L7.access
      L8 = _UPVALUE5_
      L7 = L7(L8)
      if L7 then
        L7 = _UPVALUE2_
        L7 = L7.unlink
        L8 = _UPVALUE5_
        L7(L8)
      end
      if L4 < L5 then
        downSize = L4
      else
        downSize = L5
      end
      L7 = _UPVALUE3_
      L7 = L7.exec
      L8 = string
      L8 = L8.format
      L9 = _UPVALUE4_
      L10 = A1
      L11 = downSize
      L11 = A1 + L11
      L11 = L11 - 1
      L12 = _UPVALUE5_
      L13 = A0
      L8, L9, L10, L11, L12, L13 = L8(L9, L10, L11, L12, L13)
      L7(L8, L9, L10, L11, L12, L13)
      L7 = downSize
      A1 = A1 + L7
      L7 = downSize
      L5 = L5 - L7
      L7 = _UPVALUE3_
      L7 = L7.exec
      L8 = string
      L8 = L8.format
      L9 = "nandwrite -p -s %d %s %s"
      L10 = L6
      L11 = A3
      L12 = _UPVALUE5_
      L8, L9, L10, L11, L12, L13 = L8(L9, L10, L11, L12)
      L7(L8, L9, L10, L11, L12, L13)
      L7 = downSize
      L6 = L6 + L7
    end
    L7 = _UPVALUE2_
    L7 = L7.access
    L8 = _UPVALUE5_
    L7 = L7(L8)
    if L7 then
      L7 = _UPVALUE2_
      L7 = L7.unlink
      L8 = _UPVALUE5_
      L7(L8)
    end
    L7 = true
    return L7
  end
end
function L26(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = string
  L1 = L1.find
  L2 = A0
  L3 = "[^%w:/?&%%.=#_-]"
  L1 = L1(L2, L3)
  if L1 then
    L1 = false
    return L1
  end
  L1 = true
  return L1
end
function L27(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE1_
    L1 = L1.log
    L2 = 6
    L3 = "resource not exist: "
    L4 = A0
    L3 = L3 .. L4
    L1(L2, L3)
    L1 = false
    return L1
  end
  L1 = _UPVALUE2_
  L2 = _UPVALUE3_
  L2 = L2.set
  L3 = _UPVALUE4_
  L4 = L1
  L2(L3, L4)
  L2 = _UPVALUE5_
  L2 = L2.access
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = _UPVALUE5_
    L2 = L2.unlink
    L3 = L1
    L2(L3)
  end
  L2 = _UPVALUE6_
  L2 = L2.exec
  L3 = string
  L3 = L3.format
  L4 = _UPVALUE7_
  L5 = L1
  L6 = A0
  L3, L4, L5, L6 = L3(L4, L5, L6)
  L2(L3, L4, L5, L6)
  L2 = _UPVALUE8_
  L2 = L2.md5File
  L3 = L1
  L2 = L2(L3)
  L3 = L1
  return L2, L3
end
function L28()
  local L0, L1, L2, L3
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.get
  L2 = _UPVALUE1_
  L2 = L2.PREF_ROM_FULLSIZE
  L3 = nil
  L1 = L1(L2, L3)
  if L1 then
    L2 = tonumber
    L3 = L1
    L2 = L2(L3)
    L1 = L2
    L2 = L0.checkTmpSpace
    L3 = L1
    L2 = L2(L3)
    if L2 then
      L2 = true
      return L2
    end
  end
  L2 = false
  return L2
end
function L29(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE1_
    L1 = L1.log
    L2 = 6
    L3 = "download url invalid"
    L1(L2, L3)
    L1 = false
    return L1
  end
  L1 = _UPVALUE2_
  L1 = L1.get
  L2 = _UPVALUE3_
  L2 = L2.PREF_ROM_FULLSIZE
  L3 = nil
  L1 = L1(L2, L3)
  L2 = nil
  L3 = _UPVALUE4_
  L4 = A0
  L3 = L3(L4)
  L4 = _UPVALUE5_
  L3 = L3 - L4
  if L3 < 0 then
    L4 = _UPVALUE1_
    L4 = L4.log
    L4(L5, L6)
    L4 = false
    return L4
  end
  L4 = 0
  L5.size = L3
  L5.size = L6
  if 0 < L5 then
    L5(L6, L7)
    for L8, L9 in L5, L6, L7 do
      if L9 then
        L10 = L9.size
        if L10 then
          L10 = L9.path
          if L10 then
            L10 = _UPVALUE7_
            L11 = A0
            L12 = L4
            L13 = L9.size
            L13 = L4 + L13
            L13 = L13 - 1
            L14 = L9.path
            L10 = L10(L11, L12, L13, L14)
            L2 = L10
            if not L2 then
              L10 = _UPVALUE1_
              L10 = L10.log
              L11 = 6
              L12 = "download full cpe firmware failed "
              L10(L11, L12)
              L10 = false
              return L10
            end
            L10 = L9.size
            L4 = L4 + L10
          end
        end
      end
    end
  else
    L5(L6, L7)
    return L5
  end
  L5(L6, L7)
  return L5, L6
end
syncDownloadForCpe = L29
function L29(A0)
  local L1, L2, L3, L4, L5
  L3 = _UPVALUE0_
  L4 = A0
  L3 = L3(L4)
  if not L3 then
    L3 = _UPVALUE1_
    L3 = L3.log
    L4 = 6
    L5 = "download url invalid"
    L3(L4, L5)
    L3 = false
    return L3
  end
  L3 = _UPVALUE2_
  L3 = L3()
  if not L3 then
    L3 = _UPVALUE1_
    L3 = L3.log
    L4 = 6
    L5 = "download space not enough"
    L3(L4, L5)
    L3 = false
    return L3
  end
  L3 = _UPVALUE3_
  L4 = A0
  L3, L4 = L3(L4)
  L2 = L4
  L1 = L3
  if L1 then
    L3 = _UPVALUE1_
    L3 = L3.log
    L4 = 6
    L5 = "download finished"
    L3(L4, L5)
    L3 = L1
    L4 = L2
    return L3, L4
  end
  L3 = _UPVALUE1_
  L3 = L3.log
  L4 = 6
  L5 = "download failed"
  L3(L4, L5)
  L3 = false
  return L3
end
syncDownload = L29
L29 = "set -o pipefail; "
L30 = L11
L31 = " --retry 3 -m 10 -s -f -I -X GET \"$url\" | awk 'BEGIN{IGNORECASE = 1}/^content-length:/{print $2}'"
L29 = L29 .. L30 .. L31
L30 = L11
L31 = " --retry 3 -m "
L32 = L8
L33 = " -s -f -o \"$dest\" \"$url\""
L30 = L30 .. L31 .. L32 .. L33
function L31()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = _UPVALUE0_
  L1 = L1.waitExec
  L2 = "/bin/sh"
  L3 = "-c"
  L4 = _UPVALUE1_
  L1, L2, L3 = L1(L2, L3, L4)
  L4 = tonumber
  L5 = L3
  L4 = L4(L5)
  L3 = L4
  L4 = L3 or L4
  if L3 then
    L4 = L0.checkTmpSpace
    L5 = L3
    L4 = L2 == 0 and L4
  end
  return L4
end
function L32(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L2 = _UPVALUE1_
  L2 = L2.access
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = _UPVALUE1_
    L2 = L2.unlink
    L3 = L1
    L2(L3)
  end
  L2 = nixio
  L2 = L2.setenv
  L3 = "dest"
  L4 = L1
  L2(L3, L4)
  L2 = _UPVALUE2_
  L2 = L2.exec
  L3 = _UPVALUE3_
  L2(L3)
  L2 = _UPVALUE4_
  L2 = L2.md5File
  L3 = L1
  L2 = L2(L3)
  L3 = L1
  return L2, L3
end
function L33(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  if not L1 then
    L1 = _UPVALUE1_
    L1 = L1.log
    L2 = 6
    L3 = "download url invalid"
    L1(L2, L3)
    L1 = false
    return L1
  end
  L1 = require
  L2 = "nixio"
  L1 = L1(L2)
  L2 = L1.setenv
  L3 = "url"
  L4 = A0
  L2(L3, L4)
  L2 = _UPVALUE2_
  L2 = L2()
  if not L2 then
    L2 = _UPVALUE1_
    L2 = L2.log
    L3 = 6
    L4 = "download space not enough"
    L2(L3, L4)
    L2 = false
    return L2
  end
  L2, L3 = nil, nil
  L4 = _UPVALUE3_
  L5 = A0
  L4, L5 = L4(L5)
  L3 = L5
  L2 = L4
  if L2 then
    L4 = _UPVALUE1_
    L4 = L4.log
    L5 = 6
    L6 = "download finished"
    L4(L5, L6)
    L4 = L2
    L5 = L3
    return L4, L5
  end
  L4 = _UPVALUE1_
  L4 = L4.log
  L5 = 6
  L6 = "download failed"
  L4(L5, L6)
  L4 = false
  return L4
end
syncDownloadV2 = L33
function L33()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = _UPVALUE0_
  L0 = L0.get
  L1 = _UPVALUE1_
  L2 = nil
  L0 = L0(L1, L2)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.get
  L3 = _UPVALUE2_
  L3 = L3.PREF_ROM_FULLSIZE
  L4 = nil
  L2, L3, L4, L5, L6, L7, L8 = L2(L3, L4)
  L1 = L1(L2, L3, L4, L5, L6, L7, L8)
  L2 = 0
  L3 = 0
  L4 = 0
  if L0 and L1 and 0 < L1 then
    L5 = _UPVALUE3_
    L5 = L5.access
    L6 = L0
    L5 = L5(L6)
    if L5 then
      L5 = math
      L5 = L5.modf
      L6 = _UPVALUE4_
      L6 = L6.stat
      L7 = L0
      L6 = L6(L7)
      L6 = L6.size
      L5 = L5(L6)
      L6 = getCpeModemLengthFromFile
      L6 = L6()
      L5 = L5 + L6
      L6 = _UPVALUE5_
      L5 = L5 + L6
      L6 = _UPVALUE6_
      L3 = L5 + L6
      L5 = math
      L5 = L5.modf
      L6 = L3 / L1
      L6 = L6 * 100
      L5 = L5(L6)
      L2 = L5
    else
      L5 = _UPVALUE3_
      L5 = L5.access
      L6 = _UPVALUE7_
      L5 = L5(L6)
      if L5 then
        L5 = getCpeModemLengthFromFile
        L5 = L5()
        L6 = _UPVALUE5_
        L5 = L5 + L6
        L6 = _UPVALUE6_
        L3 = L5 + L6
        L5 = math
        L5 = L5.modf
        L6 = L3 / L1
        L6 = L6 * 100
        L5 = L5(L6)
        L2 = L5
      else
        L5 = _UPVALUE3_
        L5 = L5.access
        L6 = _UPVALUE8_
        L5 = L5(L6)
        if L5 then
          L5 = tonumber
          L6 = _UPVALUE9_
          L6 = L6.trim
          L7 = _UPVALUE9_
          L7 = L7.exec
          L8 = "find /tmp -name modemSlice*|sed 's/[^0-9]//g'"
          L7, L8 = L7(L8)
          L6, L7, L8 = L6(L7, L8)
          L5 = L5(L6, L7, L8)
          L4 = L5
          if L4 and 0 < L4 then
            L5 = _UPVALUE5_
            L3 = L4 + L5
            L5 = math
            L5 = L5.modf
            L6 = L3 / L1
            L6 = L6 * 100
            L5 = L5(L6)
            L2 = L5
          end
        end
      end
    end
  end
  if L2 < 1 then
    L2 = 1
  elseif 100 < L2 then
    L2 = 100
  end
  return L2
end
downloadPercentForCpe = L33
function L33()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = _UPVALUE0_
  L0 = L0.get
  L1 = _UPVALUE1_
  L2 = nil
  L0 = L0(L1, L2)
  L1 = tonumber
  L2 = _UPVALUE0_
  L2 = L2.get
  L3 = _UPVALUE2_
  L3 = L3.PREF_ROM_FULLSIZE
  L4 = nil
  L2, L3, L4, L5, L6 = L2(L3, L4)
  L1 = L1(L2, L3, L4, L5, L6)
  L2 = 0
  L3 = 0
  if L0 and L1 and 0 < L1 then
    L4 = _UPVALUE3_
    L4 = L4.access
    L5 = L0
    L4 = L4(L5)
    if L4 then
      L4 = math
      L4 = L4.modf
      L5 = _UPVALUE4_
      L5 = L5.stat
      L6 = L0
      L5 = L5(L6)
      L5 = L5.size
      L4 = L4(L5)
      L3 = L4
      L4 = math
      L4 = L4.modf
      L5 = L3 / L1
      L5 = L5 * 100
      L4 = L4(L5)
      L2 = L4
      if L2 < 1 then
        L2 = 1
      elseif 100 < L2 then
        L2 = 100
      end
    end
  end
  return L2
end
downloadPercent = L33
function L33()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = _UPVALUE0_
  L0 = L0.get
  L1 = _UPVALUE1_
  L2 = nil
  L0 = L0(L1, L2)
  L1 = _UPVALUE2_
  L1 = L1.exec
  L2 = "pgrep -l -f "
  L3 = _UPVALUE3_
  L4 = "|grep -E '^[0-9]+ "
  L5 = string
  L5 = L5.format
  L6 = _UPVALUE4_
  L7 = L0
  L8 = ""
  L5 = L5(L6, L7, L8)
  L6 = "'|awk '{print $1}'"
  L2 = L2 .. L3 .. L4 .. L5 .. L6
  L1 = L1(L2)
  if L1 then
    L2 = _UPVALUE5_
    L2 = L2.log
    L3 = 6
    L4 = "kill process "
    L5 = _UPVALUE2_
    L5 = L5.trim
    L6 = L1
    L5 = L5(L6)
    L6 = " to cancel download"
    L4 = L4 .. L5 .. L6
    L2(L3, L4)
    L2 = os
    L2 = L2.execute
    L3 = "kill "
    L4 = _UPVALUE2_
    L4 = L4.trim
    L5 = L1
    L4 = L4(L5)
    L3 = L3 .. L4
    L2(L3)
  end
  if L0 then
    L2 = _UPVALUE6_
    L2 = L2.access
    L3 = L0
    L2 = L2(L3)
    if L2 then
      L2 = _UPVALUE6_
      L2 = L2.unlink
      L3 = L0
      L2(L3)
    end
  end
  L2 = true
  return L2
end
cancelDownload = L33
