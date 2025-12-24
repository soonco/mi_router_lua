local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39
L0 = module
L1 = "xiaoqiang.util.XQNetUtil"
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
L3 = "luci.http.protocol"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.util.XQHttpUtil"
L3 = L3(L4)
L4 = require
L5 = "xiaoqiang.util.XQSysUtil"
L4 = L4(L5)
L5 = "8007236f-a2d6-4847-ac83-c49395ad6d65"
L6 = nil
function L7()
  local L0, L1
  L0 = _UPVALUE0_
  return L0
end
getToken = L7
function L7()
  local L0, L1
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = L0.getDefaultMacAddress
  return L1()
end
getMacAddr = L7
function L7()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.GET_NVRAM_SN
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L2 = nil
    return L2
  else
    L2 = L0.trim
    L3 = L1
    L2 = L2(L3)
    L1 = L2
  end
  return L1
end
getSN = L7
function L7()
  local L0, L1, L2
  L0 = getSN
  L0 = L0()
  L0 = L0 or L0
  L1 = "miwifi-"
  L2 = L0
  L1 = L1 .. L2
  return L1
end
getUserAgent = L7
function L7(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L4 = require
  L5 = "xiaoqiang.util.XQCryptoUtil"
  L4 = L4(L5)
  if A0 == nil or A2 == nil then
    L5 = nil
    return L5
  end
  L5 = _UPVALUE0_
  L5 = L5.getTime
  L5 = L5()
  L6 = table
  L6 = L6.insert
  L7 = A2
  L8 = {}
  L9 = "time"
  L10 = L5
  L8[1] = L9
  L8[2] = L10
  L6(L7, L8)
  L6 = table
  L6 = L6.sort
  L7 = A2
  function L8(A0, A1)
    local L2, L3
    L2 = A0[1]
    L3 = A1[1]
    L2 = L2 < L3
    return L2
  end
  L6(L7, L8)
  L6 = ""
  L7 = table
  L7 = L7.foreach
  L8 = A2
  function L9(A0, A1)
    local L2, L3, L4, L5, L6
    L2 = _UPVALUE0_
    L3 = A1[1]
    L4 = "="
    L5 = A1[2]
    L6 = "&"
    L2 = L2 .. L3 .. L4 .. L5 .. L6
    _UPVALUE0_ = L2
  end
  L7(L8, L9)
  if A3 ~= nil and A3 ~= "" then
    L7 = L6
    L8 = A3
    L6 = L7 .. L8
  end
  L7 = L4.md5Base64Str
  L8 = L6
  L7 = L7(L8)
  L8 = getToken
  L8 = L8()
  L9 = string
  L9 = L9.find
  L10 = A0
  L11 = A1
  L10 = L10 .. L11
  L11 = "/v2/"
  L9 = L9(L10, L11)
  L9 = L9 ~= nil
  L10 = _UPVALUE0_
  L10 = L10.isStrNil
  L11 = L8
  L10 = L10(L11)
  if L10 or L9 then
    L8 = _UPVALUE1_
  end
  L10 = ""
  L11 = string
  L11 = L11.find
  L12 = A0
  L13 = A1
  L12 = L12 .. L13
  L13 = "?"
  L11 = L11(L12, L13)
  if L11 == nil then
    L11 = A0
    L12 = A1
    L13 = "?s="
    L14 = L7
    L15 = "&time="
    L16 = L5
    L17 = "&token="
    L18 = _UPVALUE2_
    L18 = L18.urlencode
    L19 = L8
    L18 = L18(L19)
    L10 = L11 .. L12 .. L13 .. L14 .. L15 .. L16 .. L17 .. L18
  else
    L11 = A0
    L12 = A1
    L13 = "&s="
    L14 = L7
    L15 = "&time="
    L16 = L5
    L17 = "&token="
    L18 = _UPVALUE2_
    L18 = L18.urlencode
    L19 = L8
    L18 = L18(L19)
    L10 = L11 .. L12 .. L13 .. L14 .. L15 .. L16 .. L17 .. L18
  end
  return L10
end
cryptUrl = L7
L7 = luci
L7 = L7.util
L7 = L7.trim
L8 = luci
L8 = L8.util
L8 = L8.exec
L9 = "uci get /etc/config/miwifi.server.LOG"
L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L8(L9)
L7 = L7(L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
L8 = "https://"
L9 = L7
L10 = "/xiaoqiang_log/"
L8 = L8 .. L9 .. L10
L9 = "https://"
L10 = L7
L11 = "/xiaoqiang_config/"
L9 = L9 .. L10 .. L11
L10 = "false-row-key"
L11 = "curl -k -i -f -X PUT %s%s -H \"Content-Type: application/json\" --data @%s 2>/dev/null"
L12 = "Qzo="
L13 = {}
L13.M = "TTo="
L13.B = "Qjo="
L13.X = "WDo="
L13.Y = "WTo="
L13.Z = "Wjo="
function L14()
  local L0, L1, L2, L3, L4
  L0 = getMacAddr
  L0 = L0()
  L1 = string
  L1 = L1.format
  L2 = "%012d"
  L3 = os
  L3 = L3.time
  L3, L4 = L3()
  L1 = L1(L2, L3, L4)
  L2 = L0
  L3 = "-"
  L4 = L1
  L2 = L2 .. L3 .. L4
  return L2
end
generateLogKey = L14
function L14(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L3 = require
  L4 = "json"
  L3 = L3(L4)
  L4 = _UPVALUE0_
  L4 = L4[A1]
  L5 = _UPVALUE1_
  L5 = L5.isStrNil
  L6 = L4
  L5 = L5(L6)
  if L5 then
    L5 = false
    return L5
  end
  L5 = require
  L6 = "mime"
  L5 = L5(L6)
  L6 = L5.b64
  L7 = A2
  L6 = L6(L7)
  if not L6 then
    L6 = L5.b64
    L7 = generateLogKey
    L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18 = L7()
    L6 = L6(L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18)
  end
  L7 = luci
  L7 = L7.util
  L7 = L7.exec
  L8 = "/usr/bin/base64 "
  L9 = A0
  L8 = L8 .. L9
  L7 = L7(L8)
  L8 = {}
  L8.column = L4
  L9 = string
  L9 = L9.gsub
  L10 = L7
  L11 = "\n"
  L12 = ""
  L9 = L9(L10, L11, L12)
  L8["$"] = L9
  L9 = {}
  L10 = L8
  L9[1] = L10
  L10 = {}
  L10.key = L6
  L10.Cell = L9
  L11 = {}
  L11.Row = L10
  L12 = L3.encode
  L13 = L11
  L12 = L12(L13)
  L13 = io
  L13 = L13.open
  L14 = _UPVALUE2_
  L14 = L14.XQ_LOG_JSON_FILEPATH
  L15 = "w"
  L13 = L13(L14, L15)
  if L13 then
    L15 = L13
    L14 = L13.write
    L16 = L12
    L14(L15, L16)
    L15 = L13
    L14 = L13.close
    L14(L15)
  end
  L14 = string
  L14 = L14.format
  L15 = _UPVALUE3_
  L16 = _UPVALUE4_
  L17 = _UPVALUE5_
  L18 = _UPVALUE2_
  L18 = L18.XQ_LOG_JSON_FILEPATH
  L14 = L14(L15, L16, L17, L18)
  L15 = luci
  L15 = L15.util
  L15 = L15.exec
  L16 = L14
  L15 = L15(L16)
  if L15 == nil or L15 == "" then
    L16 = false
    return L16
  else
    L16 = string
    L16 = L16.find
    L17 = L15
    L18 = "OK"
    L16 = L16(L17, L18)
    if L16 ~= nil then
      L16 = true
      return L16
    else
      L16 = false
      return L16
    end
  end
end
uploadLogFile = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L1 = require
  L2 = "mime"
  L1 = L1(L2)
  L2 = require
  L3 = "json"
  L2 = L2(L3)
  L3 = getMacAddr
  L3 = L3()
  if L3 == nil then
    L4 = false
    return L4
  end
  L4 = luci
  L4 = L4.util
  L4 = L4.exec
  L5 = "/usr/bin/base64 "
  L6 = A0
  L5 = L5 .. L6
  L4 = L4(L5)
  L5 = L1.b64
  L6 = L3
  L5 = L5(L6)
  L6 = {}
  L7 = _UPVALUE0_
  L6.column = L7
  L7 = string
  L7 = L7.gsub
  L8 = L4
  L9 = "\n"
  L10 = ""
  L7 = L7(L8, L9, L10)
  L6["$"] = L7
  L7 = {}
  L8 = L6
  L7[1] = L8
  L8 = {}
  L8.key = L5
  L8.Cell = L7
  L9 = {}
  L9.Row = L8
  L10 = L2.encode
  L11 = L9
  L10 = L10(L11)
  L11 = io
  L11 = L11.open
  L12 = _UPVALUE1_
  L12 = L12.XQ_CONFIG_JSON_FILEPATH
  L13 = "w"
  L11 = L11(L12, L13)
  if L11 then
    L13 = L11
    L12 = L11.write
    L14 = L10
    L12(L13, L14)
    L13 = L11
    L12 = L11.close
    L12(L13)
  end
  L12 = string
  L12 = L12.format
  L13 = _UPVALUE2_
  L14 = _UPVALUE3_
  L15 = _UPVALUE4_
  L16 = _UPVALUE1_
  L16 = L16.XQ_CONFIG_JSON_FILEPATH
  L12 = L12(L13, L14, L15, L16)
  L13 = luci
  L13 = L13.util
  L13 = L13.exec
  L14 = L12
  L13 = L13(L14)
  if L13 == nil or L13 == "" then
    L14 = false
    return L14
  else
    L14 = string
    L14 = L14.find
    L15 = L13
    L16 = "OK"
    L14 = L14(L15, L16)
    if L14 ~= nil then
      L14 = true
      return L14
    else
      L14 = false
      return L14
    end
  end
end
uploadConfigFile = L14
L14 = L1.LOG_ZIP_FILEPATH
L15 = "tar.gz"
L16 = "https://"
L17 = L7
L18 = "/log/lite/common/%s"
L16 = L16 .. L17 .. L18
L17 = "curl -k -i -X POST -F 'id=%s' -F '_n=%s' -F '_t=%s' -F 'extra_data={\"version\":\"%s\", \"sn\":\"%s\", \"suffix\":\""
L18 = L15
L19 = "\"}' -F 'mode=%s' -F 'key=%s' -F 'payload=@"
L20 = L14
L21 = "' %s"
L17 = L17 .. L18 .. L19 .. L20 .. L21
function L18()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8
  L0 = getDeviceId
  L0 = L0()
  L0 = L0 or L0
  L1 = _UPVALUE0_
  L1 = L1.getHardware
  L1 = L1()
  L1 = L1 or L1
  L2 = os
  L2 = L2.time
  L2 = L2()
  L3 = "common-"
  L4 = L1
  L5 = "-"
  L6 = L0
  L7 = "-"
  L8 = L2
  L3 = L3 .. L4 .. L5 .. L6 .. L7 .. L8
  return L3
end
generateLogKeyV2 = L18
function L18(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
  L1 = require
  L2 = "luci.sys"
  L1 = L1(L2)
  L2 = getDeviceId
  L2 = L2()
  L2 = L2 or L2
  L3 = L1.uniqueid
  L4 = 10
  L3 = L3(L4)
  L4 = os
  L4 = L4.time
  L4 = L4()
  L5 = _UPVALUE0_
  L5 = L5.getRomVersion
  L5 = L5()
  L6 = getSN
  L6 = L6()
  L6 = L6 or L6
  L7 = _UPVALUE0_
  L7 = L7.getHardware
  L7 = L7()
  L7 = L7 or L7
  L8 = string
  L8 = L8.format
  L9 = _UPVALUE1_
  L10 = L7
  L8 = L8(L9, L10)
  L9 = ""
  if A0 then
    L9 = "useRomTime"
    L11 = A0
    L10 = A0.match
    L12 = "%-(%d+)$"
    L10 = L10(L11, L12)
    L4 = L10
  else
    A0 = ""
  end
  L10 = string
  L10 = L10.format
  L11 = _UPVALUE2_
  L12 = L2
  L13 = L3
  L14 = L4
  L15 = L5
  L16 = L6
  L17 = L9
  L18 = A0
  L19 = L8
  L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19)
  L11 = luci
  L11 = L11.util
  L11 = L11.exec
  L12 = L10
  L11 = L11(L12)
  if L11 == nil or L11 == "" then
    L12 = false
    return L12
  else
    L12 = string
    L12 = L12.find
    L13 = L11
    L14 = "\"code\":0"
    L12 = L12(L13, L14)
    if L12 ~= nil then
      L12 = true
      return L12
    else
      L12 = false
      return L12
    end
  end
end
uploadLogV2 = L18
L18 = "https://account.xiaomi.com/"
L19 = "http://account.preview.n.xiaomi.net/"
L20 = "pass/serviceLoginAuth"
L21 = "pass/serviceLogin?sid=xiaoqiang"
function L22(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33
  L2 = require
  L3 = "json"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.XQLog"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQDBUtil"
  L4 = L4(L5)
  L5 = require
  L6 = "xiaoqiang.util.XQSysUtil"
  L5 = L5(L6)
  L6 = require
  L7 = "xiaoqiang.util.XQCryptoUtil"
  L6 = L6(L7)
  L7, L8, L9, L10, L11, L12, L13 = nil, nil, nil, nil, nil, nil, nil
  L14 = {}
  L15 = {}
  L16 = "user"
  L17 = A0
  L15[1] = L16
  L15[2] = L17
  L16 = {}
  L17 = "hash"
  L18 = string
  L18 = L18.upper
  L19 = A1
  L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L18(L19)
  L16[1] = L17
  L16[2] = L18
  L16[3] = L19
  L16[4] = L20
  L16[5] = L21
  L16[6] = L22
  L16[7] = L23
  L16[8] = L24
  L16[9] = L25
  L16[10] = L26
  L16[11] = L27
  L16[12] = L28
  L16[13] = L29
  L16[14] = L30
  L16[15] = L31
  L16[16] = L32
  L16[17] = L33
  L17 = {}
  L18 = "sid"
  L19 = "xiaoqiang"
  L17[1] = L18
  L17[2] = L19
  L18 = {}
  L19 = "deviceId"
  L20 = getSN
  L20 = L20()
  L20 = L20 or L20
  L18[1] = L19
  L18[2] = L20
  L14[1] = L15
  L14[2] = L16
  L14[3] = L17
  L14[4] = L18
  L15 = nil
  L16 = _UPVALUE0_
  L16 = L16.SERVER_CONFIG
  if L16 == 1 then
    L16 = _UPVALUE1_
    L17 = _UPVALUE2_
    L15 = L16 .. L17
  else
    L16 = _UPVALUE3_
    L17 = _UPVALUE2_
    L15 = L16 .. L17
  end
  L16 = ""
  L17 = table
  L17 = L17.foreach
  L18 = L14
  function L19(A0, A1)
    local L2, L3, L4, L5, L6
    L2 = _UPVALUE0_
    L3 = A1[1]
    L4 = "="
    L5 = A1[2]
    L6 = "&"
    L2 = L2 .. L3 .. L4 .. L5 .. L6
    _UPVALUE0_ = L2
  end
  L17(L18, L19)
  L17 = _UPVALUE4_
  L17 = L17.httpPostRequest
  L18 = L15
  L19 = string
  L19 = L19.sub
  L20 = L16
  L21 = 1
  L22 = -2
  L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L19(L20, L21, L22)
  L17 = L17(L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
  L18 = L17.code
  if L18 == 302 then
    L18 = L17.headers
    L18 = L18["extension-pragma"]
    L19 = L17.headers
    L19 = L19["set-cookie"]
    L20 = L2.decode
    L21 = L18
    L20 = L20(L21)
    L21 = L17.headers
    L12 = L21.location
    L22 = L19
    L21 = L19.match
    L23 = "userId=(%d+);"
    L21 = L21(L22, L23)
    L7 = L21
    L22 = L19
    L21 = L19.match
    L23 = "passToken=(%S+);"
    L21 = L21(L22, L23)
    L9 = L21
    L22 = L19
    L21 = L19.match
    L23 = "domain=(%S+);"
    L21 = L21(L22, L23)
    L13 = L21
    L22 = L18
    L21 = L18.match
    L23 = "%S+\"nonce\":(%d+),%S+"
    L21 = L21(L22, L23)
    L8 = L21
    L10 = L20.ssecurity
    L11 = L20.psecurity
    L21 = L3.log
    L22 = 7
    L23 = "XiaomiLogin Step1 Succeed:"
    L24 = L17
    L21(L22, L23, L24)
    L21 = "nonce="
    L22 = L8
    L23 = "&"
    L24 = L10
    L21 = L21 .. L22 .. L23 .. L24
    L22 = L6.binaryBase64Enc
    L23 = L6.sha1Binary
    L24 = L21
    L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33 = L23(L24)
    L22 = L22(L23, L24, L25, L26, L27, L28, L29, L30, L31, L32, L33)
    L23 = _UPVALUE5_
    L23 = L23.xq_urlencode_params
    L24 = {}
    L24.uuid = L7
    L24.clientSign = L22
    L23 = L23(L24)
    L24 = L12
    L25 = "&"
    L26 = L23
    L24 = L24 .. L25 .. L26
    L25 = _UPVALUE4_
    L25 = L25.httpGetRequest
    L26 = L24
    L25 = L25(L26)
    L26 = nil
    L27 = L25.code
    if L27 == 200 then
      L27 = type
      L28 = L25.headers
      L27 = L27(L28)
      if L27 == "table" then
        L27 = L25.headers
        L27 = L27["set-cookie"]
        if L27 then
          L29 = L27
          L28 = L27.match
          L30 = "serviceToken=(%S+);"
          L28 = L28(L29, L30)
          L26 = L28
        end
    end
    else
      L27 = L25.code
      if L27 == 401 then
        L27 = L3.log
        L28 = 3
        L29 = "XiaomiLogin Step2 401 Failed:"
        L30 = L24
        L31 = L25
        L27(L28, L29, L30, L31)
        L27 = {}
        L27.code = 2
        return L27
      end
    end
    L27 = L10
    L28 = _UPVALUE6_
    L28 = L28.isStrNil
    L29 = L7
    L28 = L28(L29)
    if not L28 then
      L28 = _UPVALUE6_
      L28 = L28.isStrNil
      L29 = L9
      L28 = L28(L29)
      if not L28 then
        L28 = _UPVALUE6_
        L28 = L28.isStrNil
        L29 = L26
        L28 = L28(L29)
        if not L28 then
          L28 = _UPVALUE6_
          L28 = L28.isStrNil
          L29 = L27
          L28 = L28(L29)
          if not L28 then
            L28 = _UPVALUE6_
            L28 = L28.isStrNil
            L29 = L10
            L28 = L28(L29)
            if not L28 then
              L28 = L3.log
              L29 = 7
              L30 = "XiaomiLogin Step2 succeed:"
              L31 = L7
              L30 = L30 .. L31
              L28(L29, L30)
              L28 = L4.savePassport
              L29 = L7
              L30 = L9
              L31 = L26
              L32 = L27
              L33 = L10
              L28(L29, L30, L31, L32, L33)
              L28 = {}
              L28.code = 0
              L28.uuid = L7
              L28.token = L9
              L28.stoken = L26
              L28.sid = L27
              L28.ssecurity = L10
              return L28
          end
        end
      end
    end
    else
      L28 = L3.log
      L29 = 3
      L30 = "XiaomiLogin Step2 Failed:"
      L31 = {}
      L31.step2url = L24
      L32 = L7 or L32
      if not L7 then
        L32 = ""
      end
      L31.userId = L32
      L32 = L9 or L32
      if not L9 then
        L32 = ""
      end
      L31.passToken = L32
      L32 = L10 or L32
      if not L10 then
        L32 = ""
      end
      L31.ssecurity = L32
      L28(L29, L30, L31)
      L28 = {}
      L28.code = 2
      return L28
    end
  else
    L18 = L17.code
    if L18 == 200 then
      L18 = L3.log
      L19 = 3
      L20 = "XiaomiLogin Step1 Username/Password Error:"
      L21 = L14
      L22 = L17
      L18(L19, L20, L21, L22)
      L18 = {}
      L18.code = 1
      return L18
    else
      L18 = L3.log
      L19 = 3
      L20 = "XiaomiLogin Step1 Service Unreachable:"
      L21 = L14
      L22 = L17
      L18(L19, L20, L21, L22)
      L18 = {}
      L18.code = 3
      return L18
    end
  end
end
xiaomiLogin = L22
function L22(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQDBUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    L3 = L1.getBindUUID
    L3 = L3()
    A0 = L3
  end
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    L3 = false
    return L3
  end
  L3 = L2.fetchPassport
  L4 = A0
  L3 = L3(L4)
  L3 = L3[1]
  if not L3 then
    L4 = false
    return L4
  end
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = L3.token
  L4 = L4(L5)
  if L4 then
    L4 = false
    return L4
  end
  L4 = L3.token
  _UPVALUE1_ = L4
  return L3
end
getPassport = L22
function L22(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  else
    L1 = string
    L1 = L1.gsub
    L2 = A0
    L3 = ".jpg"
    L4 = "_150.jpg"
    return L1(L2, L3, L4)
  end
end
generateOrigIconUrl = L22
L22 = "http://api.account.xiaomi.com/pass/usersCard?ids="
function L23(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "json"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    L3 = L2.getBindUUID
    L3 = L3()
    A0 = L3
    L3 = _UPVALUE0_
    L3 = L3.isStrNil
    L4 = A0
    L3 = L3(L4)
    if L3 then
      L3 = false
      return L3
    end
  end
  L3 = _UPVALUE1_
  L3 = L3.httpGetRequest
  L4 = _UPVALUE2_
  L5 = A0
  L4 = L4 .. L5
  L3 = L3(L4)
  L4 = L3.code
  if L4 ~= 200 then
    L4 = false
    return L4
  end
  L4 = L1.decode
  L5 = L3.res
  L4 = L4(L5)
  if L4 then
    L5 = string
    L5 = L5.upper
    L6 = L4.result
    L5 = L5(L6)
    if L5 == "OK" then
      L5 = L4.data
      L5 = L5.list
      L6 = L5[1]
      if L6 then
        L6 = {}
        L7 = L5[1]
        L7 = L7.aliasNick
        L7 = L7 or L7
        L6.aliasNick = L7
        L7 = L5[1]
        L7 = L7.miliaoNick
        L7 = L7 or L7
        L6.miliaoNick = L7
        L7 = L5[1]
        L7 = L7.userId
        L7 = L7 or L7
        L6.userId = L7
        L7 = L5[1]
        L7 = L7.miliaoIcon
        L7 = L7 or L7
        L6.miliaoIcon = L7
        L7 = generateOrigIconUrl
        L8 = L6.miliaoIcon
        L7 = L7(L8)
        L6.miliaoIconOrig = L7
        L7 = L2.setBindUserInfo
        L8 = L6
        L7(L8)
        return L6
      end
    end
  end
  L5 = false
  return L5
end
getUserInfo = L23
L23 = luci
L23 = L23.util
L23 = L23.trim
L24 = luci
L24 = L24.util
L24 = L24.exec
L25 = L1.SERVER_CONFIG_ONLINE_URL
L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39 = L24(L25)
L23 = L23(L24, L25, L26, L27, L28, L29, L30, L31, L32, L33, L34, L35, L36, L37, L38, L39)
L24 = "https://"
L25 = L23
L24 = L24 .. L25
L25 = L1.SERVER_CONFIG
if L25 == 1 then
  L24 = L1.SERVER_CONFIG_STAGING_URL
else
  L25 = L1.SERVER_CONFIG
  if L25 == 2 then
    L24 = L1.SERVER_CONFIG_PREVIEW_URL
  end
end
L25 = "/rs/grayupgrade"
L26 = "/rs/parent_control/feature_lib"
L27 = "/rs/grayupgrade/v2/r01"
L28 = "/rs/grayupgrade/recovery"
L29 = "/s/admin/deviceList"
L30 = "/s/device/adminList"
L31 = "/s/register"
L32 = "/s/admin/promote"
L33 = "/s/admin/dismiss"
L34 = "/s/plugin/enable"
L35 = "/s/plugin/disable"
L36 = "/s/plugin/list"
L37 = "/s/plugin/detail"
L38 = "/s/device/name"
function L39()
  local L0, L1, L2, L3
  L0 = require
  L1 = "luci.util"
  L0 = L0(L1)
  L1 = L0.exec
  L2 = _UPVALUE0_
  L2 = L2.XQ_DEVICE_ID
  L1 = L1(L2)
  L2 = _UPVALUE1_
  L2 = L2.isStrNil
  L3 = L1
  L2 = L2(L3)
  if L2 then
    L1 = ""
  end
  L2 = L0.trim
  L3 = L1
  return L2(L3)
end
getDeviceId = L39
function L39()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = {}
  L2 = {}
  L3 = "hardware"
  L4 = _UPVALUE0_
  L4 = L4.getHardware
  L4, L5, L6, L7, L8, L9, L10, L11 = L4()
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L2[4] = L6
  L2[5] = L7
  L2[6] = L8
  L2[7] = L9
  L2[8] = L10
  L2[9] = L11
  L1[1] = L2
  L2 = {}
  L3 = table
  L3 = L3.foreach
  L4 = L1
  function L5(A0, A1)
    local L2, L3, L4
    L2 = _UPVALUE0_
    L3 = A1[1]
    L4 = A1[2]
    L2[L3] = L4
  end
  L3(L4, L5)
  L3 = _UPVALUE1_
  L3 = L3.urlencode_params
  L4 = L2
  L3 = L3(L4)
  L4 = _UPVALUE2_
  L5 = "?"
  L6 = L3
  L4 = L4 .. L5 .. L6
  L5 = cryptUrl
  L6 = _UPVALUE3_
  L7 = L4
  L8 = L1
  L9 = _UPVALUE4_
  L5 = L5(L6, L7, L8, L9)
  L6 = _UPVALUE5_
  L6 = L6.httpGetRequest
  L7 = L5
  L6 = L6(L7)
  L7 = L6.code
  if L7 ~= 200 then
    L7 = false
    return L7
  end
  L7 = nil
  function L8(A0)
    local L1, L2
    L1 = _UPVALUE1_
    L1 = L1.decode
    L2 = A0
    L1 = L1(L2)
    _UPVALUE0_ = L1
  end
  L9 = pcall
  L10 = L8
  L11 = L6.res
  L9 = L9(L10, L11)
  if not L9 then
    L9 = false
    return L9
  end
  if not L7 then
    L9 = false
    return L9
  end
  L9 = tonumber
  L10 = L7.code
  L9 = L9(L10)
  if L9 == 0 then
    L9 = {}
    L10 = L7.data
    if L10 then
      L10 = L7.data
      L10 = L10.downloadUrl
      L9.downloadUrl = L10
      L10 = L7.data
      L10 = L10.fullHash
      L9.fullHash = L10
      L10 = L7.data
      L10 = L10.fileSize
      L9.fileSize = L10
      L10 = L7.data
      L10 = L10.version
      L9.version = L10
    else
      L9 = false
    end
    return L9
  else
    L9 = false
    return L9
  end
end
checkPctlDPIUpgrade = L39
function L39(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L4 = require
  L5 = "json"
  L4 = L4(L5)
  L5 = {}
  L6 = {}
  L7 = "version"
  L8 = A0
  L6[1] = L7
  L6[2] = L8
  L7 = {}
  L8 = "hardware"
  L9 = "r01"
  L7[1] = L8
  L7[2] = L9
  L8 = {}
  L9 = "channel"
  L10 = A1
  L8[1] = L9
  L8[2] = L10
  L9 = {}
  L10 = "filterID"
  L11 = A2
  L9[1] = L10
  L9[2] = L11
  L10 = {}
  L11 = "countryCode"
  L12 = A3
  L10[1] = L11
  L10[2] = L12
  L5[1] = L6
  L5[2] = L7
  L5[3] = L8
  L5[4] = L9
  L5[5] = L10
  L6 = {}
  L7 = table
  L7 = L7.foreach
  L8 = L5
  function L9(A0, A1)
    local L2, L3, L4
    L2 = _UPVALUE0_
    L3 = A1[1]
    L4 = A1[2]
    L2[L3] = L4
  end
  L7(L8, L9)
  L7 = _UPVALUE0_
  L7 = L7.urlencode_params
  L8 = L6
  L7 = L7(L8)
  L8 = _UPVALUE1_
  L9 = "?"
  L10 = L7
  L8 = L8 .. L9 .. L10
  L9 = cryptUrl
  L10 = _UPVALUE2_
  L11 = L8
  L12 = L5
  L13 = _UPVALUE3_
  L9 = L9(L10, L11, L12, L13)
  L10 = _UPVALUE4_
  L10 = L10.httpGetRequest
  L11 = L9
  L10 = L10(L11)
  L11 = L10.code
  if L11 ~= 200 then
    L11 = false
    return L11
  end
  L11 = nil
  function L12(A0)
    local L1, L2
    L1 = _UPVALUE1_
    L1 = L1.decode
    L2 = A0
    L1 = L1(L2)
    _UPVALUE0_ = L1
  end
  L13 = pcall
  L14 = L12
  L15 = L10.res
  L13 = L13(L14, L15)
  if not L13 then
    L13 = false
    return L13
  end
  if not L11 then
    L13 = false
    return L13
  end
  L13 = tonumber
  L14 = L11.code
  L13 = L13(L14)
  if L13 == 0 then
    L13 = {}
    L14 = L11.data
    if L14 then
      L14 = L11.data
      L14 = L14.upgradeInfo
      if L14 then
        L14 = L11.data
        L14 = L14.upgradeInfo
        L14 = L14.link
        if L14 then
          L13.needUpdate = 1
          L14 = L11.data
          L14 = L14.upgradeInfo
          L14 = L14.link
          L13.downloadUrl = L14
          L14 = L11.data
          L14 = L14.upgradeInfo
          L14 = L14.hash
          L13.fullHash = L14
          L14 = L11.data
          L14 = L14.upgradeInfo
          L14 = L14.size
          L13.fileSize = L14
          L14 = L11.data
          L14 = L14.upgradeInfo
          L14 = L14.toVersion
          L13.version = L14
          L14 = L11.data
          L14 = L14.upgradeInfo
          L14 = L14.description
          L13.description = L14
      end
    end
    else
      L13.needUpdate = 0
    end
    return L13
  else
    L13 = false
    return L13
  end
end
checkEcosUpgrade = L39
function L39(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = string
  L1 = L1.find
  L2 = A0
  L3 = "_ispver"
  L1, L2 = L1(L2, L3)
  if L2 == nil then
    L3 = ""
    return L3
  end
  L3 = string
  L3 = L3.sub
  L4 = A0
  L5 = L2 + 2
  L3 = L3(L4, L5)
  L4 = _UPVALUE0_
  L4 = L4.isStrNil
  L5 = L3
  L4 = L4(L5)
  if L4 then
    L4 = ""
    return L4
  end
  L4 = string
  L4 = L4.find
  L5 = L3
  L6 = "_"
  L4, L5 = L4(L5, L6)
  L1 = L5
  L2 = L4
  if L2 == nil then
    L4 = string
    L4 = L4.find
    L5 = L3
    L6 = ".bin"
    L4, L5 = L4(L5, L6)
    L1 = L5
    L2 = L4
    if L2 == nil then
      L4 = ""
      return L4
    end
  end
  L4 = string
  L4 = L4.sub
  L5 = L3
  L6 = 1
  L7 = L2 - 1
  return L4(L5, L6, L7)
end
get_ispver = L39
function L39()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26
  L0 = require
  L1 = "json"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.util.XQSysUtil"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.XQPreference"
  L2 = L2(L3)
  L3 = require
  L4 = "xiaoqiang.util.XQCryptoUtil"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.XQCountryCode"
  L4 = L4(L5)
  L5 = require
  L6 = "luci.util"
  L5 = L5(L6)
  L6 = require
  L7 = "luci.model.uci"
  L6 = L6(L7)
  L6 = L6.cursor
  L6 = L6()
  L7 = L1.getMiscHardwareInfo
  L7 = L7()
  L8 = L7.recovery
  if L8 == 1 then
    L8 = true
    if L8 then
      goto lbl_33
    end
  end
  L8 = false
  ::lbl_33::
  L9 = {}
  if L8 then
    L10 = L1.getNvramConfigs
    L10 = L10()
    L11 = {}
    L12 = {}
    L13 = "deviceID"
    L14 = ""
    L12[1] = L13
    L12[2] = L14
    L13 = {}
    L14 = "rom"
    L15 = L10.rom_ver
    L13[1] = L14
    L13[2] = L15
    L14 = {}
    L15 = "hardware"
    L16 = L1.getHardware
    L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L16()
    L14[1] = L15
    L14[2] = L16
    L14[3] = L17
    L14[4] = L18
    L14[5] = L19
    L14[6] = L20
    L14[7] = L21
    L14[8] = L22
    L14[9] = L23
    L14[10] = L24
    L14[11] = L25
    L14[12] = L26
    L15 = {}
    L16 = "cfe"
    L17 = L10.uboot
    L15[1] = L16
    L15[2] = L17
    L16 = {}
    L17 = "linux"
    L18 = L10.linux
    L16[1] = L17
    L16[2] = L18
    L17 = {}
    L18 = "ramfs"
    L19 = L10.ramfs
    L17[1] = L18
    L17[2] = L19
    L18 = {}
    L19 = "sqafs"
    L20 = L10.sqafs
    L18[1] = L19
    L18[2] = L20
    L19 = {}
    L20 = "rootfs"
    L21 = L10.rootfs
    L19[1] = L20
    L19[2] = L21
    L20 = {}
    L21 = "channel"
    L22 = L10.rom_channel
    L20[1] = L21
    L20[2] = L22
    L21 = {}
    L22 = "serialNumber"
    L23 = _UPVALUE0_
    L23 = L23.nvramGet
    L24 = "SN"
    L25 = ""
    L23, L24, L25, L26 = L23(L24, L25)
    L21[1] = L22
    L21[2] = L23
    L21[3] = L24
    L21[4] = L25
    L21[5] = L26
    L22 = {}
    L23 = "ispCode"
    L24 = L1.getISPCode
    L24, L25, L26 = L24()
    L22[1] = L23
    L22[2] = L24
    L22[3] = L25
    L22[4] = L26
    L11[1] = L12
    L11[2] = L13
    L11[3] = L14
    L11[4] = L15
    L11[5] = L16
    L11[6] = L17
    L11[7] = L18
    L11[8] = L19
    L11[9] = L20
    L11[10] = L21
    L11[11] = L22
    L9 = L11
  else
    L10 = L1.specialRegionEnable
    L10 = L10()
    if 1 == L10 then
      L10 = {}
      L11 = {}
      L12 = "deviceID"
      L13 = getDeviceId
      L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L13()
      L11[1] = L12
      L11[2] = L13
      L11[3] = L14
      L11[4] = L15
      L11[5] = L16
      L11[6] = L17
      L11[7] = L18
      L11[8] = L19
      L11[9] = L20
      L11[10] = L21
      L11[11] = L22
      L11[12] = L23
      L11[13] = L24
      L11[14] = L25
      L11[15] = L26
      L12 = {}
      L13 = "rom"
      L14 = L1.getRomVersion
      L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L14()
      L12[1] = L13
      L12[2] = L14
      L12[3] = L15
      L12[4] = L16
      L12[5] = L17
      L12[6] = L18
      L12[7] = L19
      L12[8] = L20
      L12[9] = L21
      L12[10] = L22
      L12[11] = L23
      L12[12] = L24
      L12[13] = L25
      L12[14] = L26
      L13 = {}
      L14 = "hardware"
      L15 = L1.getHardware
      L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L15()
      L13[1] = L14
      L13[2] = L15
      L13[3] = L16
      L13[4] = L17
      L13[5] = L18
      L13[6] = L19
      L13[7] = L20
      L13[8] = L21
      L13[9] = L22
      L13[10] = L23
      L13[11] = L24
      L13[12] = L25
      L13[13] = L26
      L14 = {}
      L15 = "cfe"
      L16 = L1.getCFEVersion
      L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L16()
      L14[1] = L15
      L14[2] = L16
      L14[3] = L17
      L14[4] = L18
      L14[5] = L19
      L14[6] = L20
      L14[7] = L21
      L14[8] = L22
      L14[9] = L23
      L14[10] = L24
      L14[11] = L25
      L14[12] = L26
      L15 = {}
      L16 = "linux"
      L17 = L1.getKernelVersion
      L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L17()
      L15[1] = L16
      L15[2] = L17
      L15[3] = L18
      L15[4] = L19
      L15[5] = L20
      L15[6] = L21
      L15[7] = L22
      L15[8] = L23
      L15[9] = L24
      L15[10] = L25
      L15[11] = L26
      L16 = {}
      L17 = "ramfs"
      L18 = L1.getRamFsVersion
      L18, L19, L20, L21, L22, L23, L24, L25, L26 = L18()
      L16[1] = L17
      L16[2] = L18
      L16[3] = L19
      L16[4] = L20
      L16[5] = L21
      L16[6] = L22
      L16[7] = L23
      L16[8] = L24
      L16[9] = L25
      L16[10] = L26
      L17 = {}
      L18 = "sqafs"
      L19 = L1.getSqaFsVersion
      L19, L20, L21, L22, L23, L24, L25, L26 = L19()
      L17[1] = L18
      L17[2] = L19
      L17[3] = L20
      L17[4] = L21
      L17[5] = L22
      L17[6] = L23
      L17[7] = L24
      L17[8] = L25
      L17[9] = L26
      L18 = {}
      L19 = "rootfs"
      L20 = L1.getRootFsVersion
      L20, L21, L22, L23, L24, L25, L26 = L20()
      L18[1] = L19
      L18[2] = L20
      L18[3] = L21
      L18[4] = L22
      L18[5] = L23
      L18[6] = L24
      L18[7] = L25
      L18[8] = L26
      L19 = {}
      L20 = "channel"
      L21 = L1.getChannel
      L21, L22, L23, L24, L25, L26 = L21()
      L19[1] = L20
      L19[2] = L21
      L19[3] = L22
      L19[4] = L23
      L19[5] = L24
      L19[6] = L25
      L19[7] = L26
      L20 = {}
      L21 = "countryCode"
      L22 = L4.getCurrentCountryCode
      L22, L23, L24, L25, L26 = L22()
      L20[1] = L21
      L20[2] = L22
      L20[3] = L23
      L20[4] = L24
      L20[5] = L25
      L20[6] = L26
      L21 = {}
      L22 = "bCountryCode"
      L23 = L4.getBDataRegion
      L23, L24, L25, L26 = L23()
      L21[1] = L22
      L21[2] = L23
      L21[3] = L24
      L21[4] = L25
      L21[5] = L26
      L22 = {}
      L23 = "locale"
      L24 = L4.getCurrentJLan
      L24, L25, L26 = L24()
      L22[1] = L23
      L22[2] = L24
      L22[3] = L25
      L22[4] = L26
      L23 = {}
      L24 = "serialNumber"
      L25 = getSN
      L25 = L25()
      L25 = L25 or L25
      L23[1] = L24
      L23[2] = L25
      L24 = {}
      L25 = "ispCode"
      L26 = L1.getISPCode
      L26 = L26()
      L24[1] = L25
      L24[2] = L26
      L10[1] = L11
      L10[2] = L12
      L10[3] = L13
      L10[4] = L14
      L10[5] = L15
      L10[6] = L16
      L10[7] = L17
      L10[8] = L18
      L10[9] = L19
      L10[10] = L20
      L10[11] = L21
      L10[12] = L22
      L10[13] = L23
      L10[14] = L24
      L9 = L10
    else
      L10 = {}
      L11 = {}
      L12 = "deviceID"
      L13 = getDeviceId
      L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L13()
      L11[1] = L12
      L11[2] = L13
      L11[3] = L14
      L11[4] = L15
      L11[5] = L16
      L11[6] = L17
      L11[7] = L18
      L11[8] = L19
      L11[9] = L20
      L11[10] = L21
      L11[11] = L22
      L11[12] = L23
      L11[13] = L24
      L11[14] = L25
      L11[15] = L26
      L12 = {}
      L13 = "rom"
      L14 = L1.getRomVersion
      L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L14()
      L12[1] = L13
      L12[2] = L14
      L12[3] = L15
      L12[4] = L16
      L12[5] = L17
      L12[6] = L18
      L12[7] = L19
      L12[8] = L20
      L12[9] = L21
      L12[10] = L22
      L12[11] = L23
      L12[12] = L24
      L12[13] = L25
      L12[14] = L26
      L13 = {}
      L14 = "hardware"
      L15 = L1.getHardware
      L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L15()
      L13[1] = L14
      L13[2] = L15
      L13[3] = L16
      L13[4] = L17
      L13[5] = L18
      L13[6] = L19
      L13[7] = L20
      L13[8] = L21
      L13[9] = L22
      L13[10] = L23
      L13[11] = L24
      L13[12] = L25
      L13[13] = L26
      L14 = {}
      L15 = "cfe"
      L16 = L1.getCFEVersion
      L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L16()
      L14[1] = L15
      L14[2] = L16
      L14[3] = L17
      L14[4] = L18
      L14[5] = L19
      L14[6] = L20
      L14[7] = L21
      L14[8] = L22
      L14[9] = L23
      L14[10] = L24
      L14[11] = L25
      L14[12] = L26
      L15 = {}
      L16 = "linux"
      L17 = L1.getKernelVersion
      L17, L18, L19, L20, L21, L22, L23, L24, L25, L26 = L17()
      L15[1] = L16
      L15[2] = L17
      L15[3] = L18
      L15[4] = L19
      L15[5] = L20
      L15[6] = L21
      L15[7] = L22
      L15[8] = L23
      L15[9] = L24
      L15[10] = L25
      L15[11] = L26
      L16 = {}
      L17 = "ramfs"
      L18 = L1.getRamFsVersion
      L18, L19, L20, L21, L22, L23, L24, L25, L26 = L18()
      L16[1] = L17
      L16[2] = L18
      L16[3] = L19
      L16[4] = L20
      L16[5] = L21
      L16[6] = L22
      L16[7] = L23
      L16[8] = L24
      L16[9] = L25
      L16[10] = L26
      L17 = {}
      L18 = "sqafs"
      L19 = L1.getSqaFsVersion
      L19, L20, L21, L22, L23, L24, L25, L26 = L19()
      L17[1] = L18
      L17[2] = L19
      L17[3] = L20
      L17[4] = L21
      L17[5] = L22
      L17[6] = L23
      L17[7] = L24
      L17[8] = L25
      L17[9] = L26
      L18 = {}
      L19 = "rootfs"
      L20 = L1.getRootFsVersion
      L20, L21, L22, L23, L24, L25, L26 = L20()
      L18[1] = L19
      L18[2] = L20
      L18[3] = L21
      L18[4] = L22
      L18[5] = L23
      L18[6] = L24
      L18[7] = L25
      L18[8] = L26
      L19 = {}
      L20 = "channel"
      L21 = L1.getChannel
      L21, L22, L23, L24, L25, L26 = L21()
      L19[1] = L20
      L19[2] = L21
      L19[3] = L22
      L19[4] = L23
      L19[5] = L24
      L19[6] = L25
      L19[7] = L26
      L20 = {}
      L21 = "countryCode"
      L22 = L4.getCurrentCountryCode
      L22, L23, L24, L25, L26 = L22()
      L20[1] = L21
      L20[2] = L22
      L20[3] = L23
      L20[4] = L24
      L20[5] = L25
      L20[6] = L26
      L21 = {}
      L22 = "locale"
      L23 = L4.getCurrentJLan
      L23, L24, L25, L26 = L23()
      L21[1] = L22
      L21[2] = L23
      L21[3] = L24
      L21[4] = L25
      L21[5] = L26
      L22 = {}
      L23 = "serialNumber"
      L24 = getSN
      L24 = L24()
      L24 = L24 or L24
      L22[1] = L23
      L22[2] = L24
      L23 = {}
      L24 = "ispCode"
      L25 = L1.getISPCode
      L25, L26 = L25()
      L23[1] = L24
      L23[2] = L25
      L23[3] = L26
      L10[1] = L11
      L10[2] = L12
      L10[3] = L13
      L10[4] = L14
      L10[5] = L15
      L10[6] = L16
      L10[7] = L17
      L10[8] = L18
      L10[9] = L19
      L10[10] = L20
      L10[11] = L21
      L10[12] = L22
      L10[13] = L23
      L9 = L10
    end
  end
  L10 = {}
  L11 = table
  L11 = L11.foreach
  L12 = L9
  function L13(A0, A1)
    local L2, L3, L4
    L2 = _UPVALUE0_
    L3 = A1[1]
    L4 = A1[2]
    L2[L3] = L4
  end
  L11(L12, L13)
  L11 = _UPVALUE1_
  L11 = L11.urlencode_params
  L12 = L10
  L11 = L11(L12)
  if L8 then
    L12 = _UPVALUE2_
    if L12 then
      goto lbl_261
    end
  end
  L12 = _UPVALUE3_
  ::lbl_261::
  L13 = "?"
  L14 = L11
  L12 = L12 .. L13 .. L14
  L13 = cryptUrl
  L14 = _UPVALUE4_
  L15 = L12
  L16 = L9
  L17 = _UPVALUE5_
  L13 = L13(L14, L15, L16, L17)
  L14 = _UPVALUE6_
  L14 = L14.httpGetRequest
  L15 = L13
  L14 = L14(L15)
  L15 = L14.code
  if L15 ~= 200 then
    L15 = false
    return L15
  end
  L15 = nil
  function L16(A0)
    local L1, L2
    L1 = _UPVALUE1_
    L1 = L1.decode
    L2 = A0
    L1 = L1(L2)
    _UPVALUE0_ = L1
  end
  L17 = pcall
  L18 = L16
  L19 = L14.res
  L17 = L17(L18, L19)
  if not L17 then
    L17 = false
    return L17
  end
  if not L15 then
    L17 = false
    return L17
  end
  L17 = tonumber
  L18 = L15.code
  L17 = L17(L18)
  if L17 == 0 then
    L17 = {}
    L18 = L15.data
    if L18 then
      L18 = L15.data
      L18 = L18.link
      if L18 then
        L18 = _UPVALUE0_
        L18 = L18.parseEnter2br
        L19 = luci
        L19 = L19.util
        L19 = L19.trim
        L20 = L15.data
        L20 = L20.description
        L19, L20, L21, L22, L23, L24, L25, L26 = L19(L20)
        L18 = L18(L19, L20, L21, L22, L23, L24, L25, L26)
        L19 = tonumber
        L20 = L15.data
        L20 = L20.weight
        L19 = L19(L20)
        L17.needUpdate = 1
        L20 = L15.data
        L20 = L20.link
        L17.downloadUrl = L20
        L20 = L15.data
        L20 = L20.hash
        L17.fullHash = L20
        L20 = L15.data
        L20 = L20.size
        L17.fileSize = L20
        L20 = L15.data
        L20 = L20.toVersion
        L17.version = L20
        L20 = _UPVALUE0_
        L20 = L20.getFeature
        L21 = "0"
        L22 = "system"
        L23 = "dt_spec"
        L20 = L20(L21, L22, L23)
        if L20 == "1" then
          L20 = get_ispver
          L21 = L17.downloadUrl
          L20 = L20(L21)
          L17.ispver = L20
          L20 = _UPVALUE0_
          L20 = L20.isStrNil
          L21 = L15.data
          L21 = L21.buildTime
          L20 = L20(L21)
          if L20 then
            L20 = L1.getRomBuildtime
            L20 = L20()
            L17.buildTime = L20
          else
            L20 = L5.trim
            L21 = os
            L21 = L21.date
            L22 = "%Y/%m/%d"
            L23 = tonumber
            L24 = L15.data
            L24 = L24.buildTime
            L23 = L23(L24)
            L23 = L23 / 1000
            L21, L22, L23, L24, L25, L26 = L21(L22, L23)
            L20 = L20(L21, L22, L23, L24, L25, L26)
            L17.buildTime = L20
          end
        end
        L20 = L19 or L20
        if not L19 then
          L20 = 1
        end
        L17.weight = L20
        L20 = L15.data
        L20 = L20.changelogUrl
        L17.changelogUrl = L20
        L17.changeLog = L18
    end
    else
      L18 = require
      L19 = "xiaoqiang.module.XQMessageBox"
      L18 = L18(L19)
      L19 = L18.removeMessage
      L20 = 1
      L19(L20)
      L19 = ""
      L20 = L15.data
      if L20 then
        L20 = L15.data
        L20 = L20.description
        if L20 then
          L20 = _UPVALUE0_
          L20 = L20.parseEnter2br
          L21 = luci
          L21 = L21.util
          L21 = L21.trim
          L22 = L15.data
          L22 = L22.description
          L21, L22, L23, L24, L25, L26 = L21(L22)
          L20 = L20(L21, L22, L23, L24, L25, L26)
          L19 = L20
        end
      end
      L17.needUpdate = 0
      L20 = L1.getRomVersion
      L20 = L20()
      L17.version = L20
      L17.changeLog = L19
    end
    L18 = L15.data
    if L18 then
      L18 = L15.data
      L18 = L18.otherParam
      if L18 then
        L18 = L15.data
        L18 = L18.otherParam
        if L18 ~= "" then
          L18 = L0.decode
          L19 = L15.data
          L19 = L19.otherParam
          L18 = L18(L19)
          L17.otherParam = L18
        end
      end
    end
    return L17
  else
    L17 = false
    return L17
  end
end
checkUpgrade = L39
function L39(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8
  L4 = require
  L5 = "xiaoqiang.util.XQCryptoUtil"
  L4 = L4(L5)
  L5 = ""
  if A2 then
    L6 = #A2
    if 0 < L6 then
      L6 = table
      L6 = L6.sort
      L7 = A2
      function L8(A0, A1)
        local L2, L3
        L2 = A0[1]
        L3 = A1[1]
        L2 = L2 < L3
        return L2
      end
      L6(L7, L8)
      L6 = table
      L6 = L6.foreach
      L7 = A2
      function L8(A0, A1)
        local L2, L3, L4, L5, L6
        L2 = _UPVALUE0_
        L3 = A1[1]
        L4 = "="
        L5 = A1[2]
        L6 = "&"
        L2 = L2 .. L3 .. L4 .. L5 .. L6
        _UPVALUE0_ = L2
      end
      L6(L7, L8)
    end
  end
  L6 = L5
  L7 = A3
  L5 = L6 .. L7
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L7 = A1
  L6 = L6(L7)
  if not L6 then
    L6 = A1
    L7 = "&"
    L8 = L5
    L5 = L6 .. L7 .. L8
  end
  L6 = _UPVALUE0_
  L6 = L6.isStrNil
  L7 = A0
  L6 = L6(L7)
  if not L6 then
    L6 = string
    L6 = L6.upper
    L7 = A0
    L6 = L6(L7)
    L7 = "&"
    L8 = L5
    L5 = L6 .. L7 .. L8
  end
  L6 = L4.hash4SHA1
  L7 = L5
  return L6(L7)
end
generateSignature = L39
function L39(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22, L23, L24, L25, L26, L27, L28, L29
  L4 = require
  L5 = "json"
  L4 = L4(L5)
  L5 = require
  L6 = "xqcrypto"
  L5 = L5(L6)
  L6 = require
  L7 = "luci.util"
  L6 = L6(L7)
  L7 = require
  L8 = "xiaoqiang.XQLog"
  L7 = L7(L8)
  L8 = require
  L9 = "xiaoqiang.util.XQCryptoUtil"
  L8 = L8(L9)
  L9 = getPassport
  L10 = A3
  L9 = L9(L10)
  L10 = string
  L10 = L10.upper
  L11 = A0
  L10 = L10(L11)
  A0 = L10
  if not L9 then
    L10 = L7.log
    L11 = 3
    L12 = "XQRequest: Passport missing "
    L13 = A1
    L12 = L12 .. L13
    L10(L11, L12)
    L10 = false
    return L10
  end
  L10 = L5.generateNonce
  L10 = L10()
  L11 = {}
  L12 = {}
  L13 = {}
  L14 = {}
  L15 = L9.uuid
  L11.userId = L15
  L15 = L9.stoken
  L11.serviceToken = L15
  L15 = L5.generateSessionSecurity
  L16 = L10
  L15 = L15(L16, L17)
  L16 = ""
  if A2 then
    if L17 == "table" then
      L17(L18, L19)
      for L20, L21 in L17, L18, L19 do
        L22(L23, L24)
      end
  end
  else
    A2 = L17
  end
  L20[1] = L21
  L20[2] = L22
  L18(L19, L20)
  L18(L19, L20)
  for L21, L22 in L18, L19, L20 do
    L25 = ";;"
    L16 = L23 .. L24 .. L25
  end
  L25, L26, L27, L28, L29 = L20(L21, L22, L23)
  if L19 then
    if 0 < L20 then
      for L23, L24 in L20, L21, L22 do
        L25 = table
        L25 = L25.insert
        L26 = L12
        L27 = {}
        L28 = L24[1]
        L29 = L19[L23]
        L27[1] = L28
        L27[2] = L29
        L25(L26, L27)
        L25 = table
        L25 = L25.insert
        L26 = L14
        L27 = {}
        L28 = L24[1]
        L29 = L19[L23]
        L27[1] = L28
        L27[2] = L29
        L25(L26, L27)
      end
    end
  end
  L25 = L15
  for L25, L26 in L22, L23, L24 do
    L27 = L26[1]
    if L27 == "rc4_hash__" then
    end
  end
  L25 = "signature"
  L26 = L21
  L24[1] = L25
  L24[2] = L26
  L22(L23, L24)
  L25 = "_nonce"
  L26 = L10
  L24[1] = L25
  L24[2] = L26
  L22(L23, L24)
  L25 = "rc4_hash__"
  L26 = L20
  L24[1] = L25
  L24[2] = L26
  L22(L23, L24)
  function L25(A0, A1)
    local L2, L3, L4
    L2 = _UPVALUE0_
    L3 = A1[1]
    L4 = A1[2]
    L2[L3] = L4
  end
  L23(L24, L25)
  if A0 == "GET" then
    L25 = _UPVALUE1_
    L25 = L25.httpGetRequest
    L26 = _UPVALUE2_
    L27 = A1
    L26 = L26 .. L27
    L27 = L23
    L28 = L11
    L25 = L25(L26, L27, L28)
  elseif A0 == "POST" then
    L25 = _UPVALUE1_
    L25 = L25.httpPostRequest
    L26 = _UPVALUE2_
    L27 = A1
    L26 = L26 .. L27
    L27 = L23
    L28 = L11
    L25 = L25(L26, L27, L28)
  end
  L25 = L24.code
  if L25 == 200 then
    L25 = L5.decryptResult
    L26 = L15
    L27 = L24.res
    L25 = L25(L26, L27)
    L26 = _UPVALUE3_
    L26 = L26.isStrNil
    L27 = L25
    L26 = L26(L27)
    if not L26 then
      L26 = string
      L26 = L26.gsub
      L27 = L25
      L28 = "u201c"
      L29 = "\""
      L26 = L26(L27, L28, L29)
      L25 = L26
      L26 = string
      L26 = L26.gsub
      L27 = L25
      L28 = "u201d"
      L29 = "\""
      L26 = L26(L27, L28, L29)
      L25 = L26
      L26 = L7.log
      L27 = 7
      L28 = "XQRequest succeed:"
      L29 = L25
      L28 = L28 .. L29
      L26(L27, L28)
      L26 = L4.decode
      L27 = L25
      return L26(L27)
    end
  else
    L25 = L24.code
    if L25 == 401 then
      L25 = L7.log
      L26 = 3
      L27 = "XQRequest 401:"
      L28 = _UPVALUE2_
      L29 = A1
      L27 = L27 .. L28 .. L29
      L28 = "QueryString:"
      L29 = L23
      L28 = L28 .. L29
      L29 = L14
      L25(L26, L27, L28, L29)
      L25 = {}
      L25.code = 401
      return L25
    end
  end
  L25 = L7.log
  L26 = 3
  L27 = "XQRequest Failed:"
  L28 = _UPVALUE2_
  L29 = A1
  L27 = L27 .. L28 .. L29
  L28 = "QueryString:"
  L29 = L23
  L28 = L28 .. L29
  L29 = L14
  L25(L26, L27, L28, L29)
  L25 = false
  return L25
end
doRequest = L39
