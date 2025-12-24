local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
L0 = module
L1 = "xiaoqiang.util.XQSecureUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0(L1)
L0 = require
L1 = "luci.sys"
L0(L1)
L0 = require
L1 = "bit"
L0 = L0(L1)
L1 = require
L2 = "nixio"
L1 = L1(L2)
L2 = require
L3 = "nixio.util"
L2(L3)
L2 = require
L3 = "nixio.fs"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.XQLog"
L3 = L3(L4)
L4 = require
L5 = "xssFilter"
L4 = L4(L5)
L4 = L4.new
L4 = L4()
L5 = require
L6 = "xiaoqiang.common.XQFunction"
L5 = L5(L6)
L6 = require
L7 = "xiaoqiang.XQPreference"
L6 = L6(L7)
L7 = require
L8 = "xiaoqiang.util.XQCryptoUtil"
L7 = L7(L8)
L8 = "a2ffa5c9be07488bbb04a3a47d3c5f6a"
L9 = "echo -e '%s' | openssl aes-128-cbc -d -K '%s' -iv '64175472480004614961023454661220' -base64"
L10 = "echo -e '%s' | /usr/bin/aes_crypt -b -d -k '%s' -i 64175472480004614961023454661220 -"
L11 = "/etc/tmp"
L12 = "/etc/tmp/luci-nonce"
function L13(A0)
  local L1, L2, L3
  L1 = #A0
  L2 = A0
  L1 = A0.match
  L3 = "^[a-fA-F0-9]+$"
  L1 = L1(L2, L3)
  L1 = not L1
  L1 = A0 and L1
  return L1
end
checkid = L13
function L13()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.mkdir
  L1 = _UPVALUE1_
  L2 = 700
  L0(L1, L2)
  L0 = _UPVALUE0_
  L0 = L0.mkdir
  L1 = _UPVALUE2_
  L2 = 700
  L0(L1, L2)
  L0 = sane
  L0 = L0()
  if not L0 then
    L0 = error
    L1 = "Security Exception: Nonce path is not sane!"
    L0(L1)
  end
end
prepare = L13
function L13(A0)
  local L1, L2, L3, L4
  L1 = luci
  L1 = L1.sys
  L1 = L1.process
  L1 = L1.info
  L2 = "uid"
  L1 = L1(L2)
  L2 = _UPVALUE0_
  L2 = L2.stat
  L3 = A0 or L3
  if not A0 then
    L3 = _UPVALUE1_
  end
  L4 = "uid"
  L2 = L2(L3, L4)
  L1 = L1 == L2
  return L1
end
sane = L13
function L13(A0)
  local L1, L2, L3, L4, L5
  if A0 then
    L1 = checkid
    L2 = A0
    L1 = L1(L2)
    if L1 then
      goto lbl_10
    end
  end
  L1 = nil
  do return L1 end
  ::lbl_10::
  L1 = sane
  L2 = _UPVALUE0_
  L3 = "/"
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1 = L1(L2)
  if not L1 then
    L1 = nil
    return L1
  end
  L1 = _UPVALUE1_
  L1 = L1.readfile
  L2 = _UPVALUE0_
  L3 = "/"
  L4 = A0
  L2 = L2 .. L3 .. L4
  L1 = L1(L2)
  L2 = loadstring
  L3 = L1
  L2 = L2(L3)
  L3 = setfenv
  L4 = L2
  L5 = {}
  L3(L4, L5)
  L3 = L2
  L3 = L3()
  L4 = type
  L5 = L3
  L4 = L4(L5)
  if L4 ~= "table" then
    L4 = nil
    return L4
  end
  return L3
end
readNonce = L13
function L13(A0, A1)
  local L2, L3, L4, L5
  L2 = sane
  L2 = L2()
  if not L2 then
    L2 = prepare
    L2()
  end
  L2 = checkid
  L3 = A0
  L2 = L2(L3)
  if L2 then
    L2 = type
    L3 = A1
    L2 = L2(L3)
    if L2 == "table" then
      goto lbl_18
    end
  end
  do return end
  ::lbl_18::
  L2 = luci
  L2 = L2.util
  L2 = L2.get_bytecode
  L3 = A1
  L2 = L2(L3)
  A1 = L2
  L2 = _UPVALUE0_
  L2 = L2.open
  L3 = _UPVALUE1_
  L4 = "/"
  L5 = A0
  L3 = L3 .. L4 .. L5
  L4 = "w"
  L5 = 600
  L2 = L2(L3, L4, L5)
  L4 = L2
  L3 = L2.writeall
  L5 = A1
  L3(L4, L5)
  L4 = L2
  L3 = L2.close
  L3(L4)
end
writeNonce = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    return A0
  end
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 == "string" then
    L1 = _UPVALUE1_
    L2 = L1
    L1 = L1.filter
    L3 = A0
    L1, L2 = L1(L2, L3)
    if L1 then
      return L1
    else
      L3 = require
      L4 = "xiaoqiang.XQLog"
      L3 = L3(L4)
      L4 = L3.log
      L5 = 4
      L6 = "XSS Warning:"
      L7 = A0
      L6 = L6 .. L7
      L4(L5, L6)
      L4 = nil
      return L4
    end
  else
    return A0
  end
end
xssCheck = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = require
  L2 = "luci.sys"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.sauth"
  L2 = L2(L3)
  L3 = {}
  L4 = L1.uniqueid
  L5 = 16
  L4 = L4(L5)
  L5 = tostring
  L6 = A0
  L5 = L5(L6)
  L3.type = L5
  L5 = L2.write
  L6 = L4
  L7 = L3
  L5(L6, L7)
  return L4
end
generateRedirectKey = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = false
    return L1
  end
  L1 = require
  L2 = "luci.sys"
  L1 = L1(L2)
  L2 = require
  L3 = "luci.sauth"
  L2 = L2(L3)
  L3 = L2.read
  L4 = A0
  L3 = L3(L4)
  if L3 then
    L4 = type
    L5 = L3
    L4 = L4(L5)
    if L4 == "table" then
      L4 = L2.kill
      L5 = A0
      L4(L5)
      L4 = L1.uptime
      L4 = L4()
      L5 = L3.atime
      L5 = L4 - L5
      if 10 < L5 then
        L5 = false
        return L5
      else
        L5 = tostring
        L6 = L3.type
        return L5(L6)
      end
    end
  end
  L4 = false
  return L4
end
checkRedirectKey = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  end
  L1 = math
  L1 = L1.ceil
  L2 = #A0
  L2 = L2 / 64
  L1 = L1(L2)
  L2 = {}
  for L6 = L3, L4, L5 do
    if L6 ~= L1 then
      L7 = table
      L7 = L7.insert
      L8 = L2
      L9 = string
      L9 = L9.sub
      L10 = A0
      L11 = L6 - 1
      L11 = L11 * 64
      L11 = 1 + L11
      L12 = 64 * L6
      L9, L10, L11, L12 = L9(L10, L11, L12)
      L7(L8, L9, L10, L11, L12)
    else
      L7 = table
      L7 = L7.insert
      L8 = L2
      L9 = string
      L9 = L9.sub
      L10 = A0
      L11 = L6 - 1
      L11 = L11 * 64
      L11 = 1 + L11
      L12 = -1
      L9, L10, L11, L12 = L9(L10, L11, L12)
      L7(L8, L9, L10, L11, L12)
    end
  end
  return L3(L4, L5)
end
ciphertextFormat = L13
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A1
  L3 = L3(L4)
  if not L3 then
    L4 = A1
    L3 = A1.match
    L5 = "\""
    L3 = L3(L4, L5)
    if not L3 then
      L4 = A1
      L3 = A1.match
      L5 = " "
      L3 = L3(L4, L5)
      if not L3 then
        L4 = A1
        L3 = A1.match
        L5 = "'"
        L3 = L3(L4, L5)
        if not L3 then
          goto lbl_24
        end
      end
    end
  end
  L3 = nil
  do return L3 end
  ::lbl_24::
  L3 = _UPVALUE1_
  L3 = L3.get_ext
  L4 = A0
  L5 = ""
  L6 = "account"
  L7 = A2
  L3 = L3(L4, L5, L6, L7)
  L4 = string
  L4 = L4.format
  L5 = _UPVALUE2_
  L6 = ciphertextFormat
  L7 = A1
  L6 = L6(L7)
  L7 = L3
  L4 = L4(L5, L6, L7)
  L5 = string
  L5 = L5.format
  L6 = _UPVALUE3_
  L7 = A1
  L8 = L3
  L5 = L5(L6, L7, L8)
  L6 = os
  L6 = L6.execute
  L7 = L4
  L8 = "> /dev/null"
  L7 = L7 .. L8
  L6 = L6(L7)
  if L6 == 0 then
    L6 = luci
    L6 = L6.util
    L6 = L6.trim
    L7 = luci
    L7 = L7.util
    L7 = L7.exec
    L8 = L4
    L7, L8 = L7(L8)
    return L6(L7, L8)
  else
    L6 = os
    L6 = L6.execute
    L7 = L5
    L8 = "> /dev/null"
    L7 = L7 .. L8
    L6 = L6(L7)
    if L6 == 0 then
      L6 = luci
      L6 = L6.util
      L6 = L6.trim
      L7 = luci
      L7 = L7.util
      L7 = L7.exec
      L8 = L5
      L7, L8 = L7(L8)
      return L6(L7, L8)
    end
  end
  L6 = nil
  return L6
end
decCiphertext = L13
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = A1
    L2 = L2(L3)
    if not L2 then
      goto lbl_15
    end
  end
  L2 = false
  do return L2 end
  ::lbl_15::
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = L2.getEncryptMode
  L3 = L3()
  L4 = nil
  if L3 == 1 then
    L5 = _UPVALUE1_
    L5 = L5.sha256
    L6 = A1
    L7 = _UPVALUE2_
    L6 = L6 .. L7
    L5 = L5(L6)
    L4 = L5
  else
    L5 = _UPVALUE1_
    L5 = L5.sha1
    L6 = A1
    L7 = _UPVALUE2_
    L6 = L6 .. L7
    L5 = L5(L6)
    L4 = L5
  end
  L5 = _UPVALUE3_
  L5 = L5.set
  L6 = A0
  L7 = L4
  L8 = "account"
  L5(L6, L7, L8)
  L5 = true
  return L5
end
savePlaintextPwd = L13
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = A1
    L2 = L2(L3)
    if not L2 then
      goto lbl_15
    end
  end
  L2 = false
  do return L2 end
  ::lbl_15::
  L2 = require
  L3 = "luci.model.uci"
  L2 = L2(L3)
  L2 = L2.cursor
  L2 = L2()
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = L3.getEncryptMode
  L4 = L4()
  L5 = _UPVALUE1_
  L5 = L5.sha1
  L6 = A1
  L7 = _UPVALUE2_
  L6 = L6 .. L7
  L5 = L5(L6)
  if L4 == 1 then
    L6 = _UPVALUE1_
    L6 = L6.sha256
    L7 = A1
    L8 = _UPVALUE2_
    L7 = L7 .. L8
    L6 = L6(L7)
    L8 = L2
    L7 = L2.set
    L9 = "account"
    L10 = "common"
    L11 = A0
    L12 = L6
    L7(L8, L9, L10, L11, L12)
    L8 = L2
    L7 = L2.set
    L9 = "account"
    L10 = "legacy"
    L11 = A0
    L12 = L5
    L7(L8, L9, L10, L11, L12)
  else
    L7 = L2
    L6 = L2.set
    L8 = "account"
    L9 = "common"
    L10 = A0
    L11 = L5
    L6(L7, L8, L9, L10, L11)
  end
  L7 = L2
  L6 = L2.commit
  L8 = "account"
  L6(L7, L8)
  L6 = true
  return L6
end
savePlaintextPwdEx = L13
function L13(A0, A1)
  local L2, L3, L4, L5, L6
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = A1
    L2 = L2(L3)
    if not L2 then
      goto lbl_15
    end
  end
  L2 = false
  do return L2 end
  ::lbl_15::
  L2 = decCiphertext
  L3 = A0
  L4 = A1
  L2 = L2(L3, L4)
  if L2 then
    L3 = _UPVALUE1_
    L3 = L3.set
    L4 = A0
    L5 = L2
    L6 = "account"
    L3(L4, L5, L6)
    L3 = true
    return L3
  end
  L3 = false
  return L3
end
saveCiphertextPwd = L13
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = require
  L3 = "xiaoqiang.common.XQFunction"
  L2 = L2(L3)
  L3 = L2.isStrNil
  L4 = A1
  L3 = L3(L4)
  if L3 then
    L3 = true
    return L3
  end
  L3 = decCiphertext
  L4 = A0
  L5 = A1
  L6 = "legacy"
  L3 = L3(L4, L5, L6)
  if L3 then
    L4 = _UPVALUE0_
    L4 = L4.set_ext
    L5 = A0
    L6 = L3
    L7 = "account"
    L8 = "legacy"
    L4(L5, L6, L7, L8)
    L4 = true
    return L4
  end
  L4 = false
  return L4
end
saveCiphertextLegacyPwd = L13
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2.isStrNil
  L3 = A0
  L2 = L2(L3)
  if not L2 then
    L2 = _UPVALUE0_
    L2 = L2.isStrNil
    L3 = A1
    L2 = L2(L3)
    if not L2 then
      goto lbl_15
    end
  end
  L2 = false
  do return L2 end
  ::lbl_15::
  L2 = require
  L3 = "xiaoqiang.util.XQSysUtil"
  L2 = L2(L3)
  L3 = L2.getEncryptMode
  L3 = L3()
  L4 = _UPVALUE1_
  L4 = L4.get
  L5 = A0
  L6 = ""
  L7 = "account"
  L4 = L4(L5, L6, L7)
  L5 = nil
  if L3 == 1 then
    L6 = _UPVALUE2_
    L6 = L6.sha256
    L7 = A1
    L8 = _UPVALUE3_
    L7 = L7 .. L8
    L6 = L6(L7)
    L5 = L6
  else
    L6 = _UPVALUE2_
    L6 = L6.sha1
    L7 = A1
    L8 = _UPVALUE3_
    L7 = L7 .. L8
    L6 = L6(L7)
    L5 = L6
  end
  if L4 == L5 then
    L6 = true
    return L6
  else
    L6 = false
    return L6
  end
end
checkPlaintextPwd = L13
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11
  L3 = require
  L4 = "xiaoqiang.util.XQSysUtil"
  L3 = L3(L4)
  L4 = L3.getEncryptMode
  L4 = L4()
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = A0
  L5 = L5(L6)
  if L5 then
    L5 = false
    return L5
  end
  L5 = _UPVALUE1_
  L5 = L5.get
  L6 = A0
  L7 = nil
  L8 = "account"
  L5 = L5(L6, L7, L8)
  if L5 then
    L6 = _UPVALUE0_
    L6 = L6.isStrNil
    L7 = A2
    L6 = L6(L7)
    if not L6 then
      L6 = _UPVALUE0_
      L6 = L6.isStrNil
      L7 = A1
      L6 = L6(L7)
      if not L6 then
        if L4 == 1 then
          L6 = _UPVALUE2_
          L6 = L6.sha256
          L7 = A1
          L8 = L5
          L7 = L7 .. L8
          L6 = L6(L7)
          if L6 == A2 then
            L6 = true
            return L6
          end
        else
          L6 = _UPVALUE2_
          L6 = L6.sha1
          L7 = A1
          L8 = L5
          L7 = L7 .. L8
          L6 = L6(L7)
          if L6 == A2 then
            L6 = true
            return L6
          end
        end
      end
    end
  end
  L6 = _UPVALUE3_
  L6 = L6.log
  L7 = 4
  L8 = luci
  L8 = L8.http
  L8 = L8.getenv
  L9 = "REMOTE_ADDR"
  L8 = L8(L9)
  L8 = L8 or L8
  L9 = " Authentication failed"
  L8 = L8 .. L9
  L9 = A1
  L10 = L5
  L11 = A2
  L6(L7, L8, L9, L10, L11)
  L6 = false
  return L6
end
checkUser = L13
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18
  L2 = require
  L3 = "luci.util"
  L2 = L2(L3)
  L3 = require
  L4 = "luci.sys"
  L3 = L3(L4)
  L4 = require
  L5 = "xiaoqiang.util.XQCryptoUtil"
  L4 = L4(L5)
  if A0 and A1 then
    L5 = _UPVALUE0_
    L5 = L5.macFormat
    L6 = A1
    L5 = L5(L6)
    A1 = L5
    L5 = L2.split
    L6 = A0
    L7 = "_"
    L5 = L5(L6, L7)
    L6 = #L5
    if L6 ~= 4 then
      L6 = _UPVALUE1_
      L6 = L6.log
      L7 = 6
      L8 = "Nonce check failed!: Illegal"
      L9 = A0
      L10 = " remote MAC address:"
      L11 = A1
      L8 = L8 .. L9 .. L10 .. L11
      L6(L7, L8)
      L6 = false
      return L6
    end
    L6 = tonumber
    L7 = L5[1]
    L6 = L6(L7)
    L7 = tostring
    L8 = L5[2]
    L7 = L7(L8)
    L8 = tonumber
    L9 = L5[3]
    L8 = L8(L9)
    if L6 and L7 then
      L9 = require
      L10 = "xiaoqiang.util.XQSysUtil"
      L9 = L9(L10)
      L10 = L9.getEncryptMode
      L10 = L10()
      L11 = nil
      if L10 == 1 then
        L12 = L4.sha256
        L13 = L6
        L14 = L7
        L13 = L13 .. L14
        L12 = L12(L13)
        L11 = L12
      else
        L12 = L4.sha1
        L13 = L6
        L14 = L7
        L13 = L13 .. L14
        L12 = L12(L13)
        L11 = L12
      end
      if 4 < L6 then
        L12 = _UPVALUE1_
        L12 = L12.log
        L13 = 6
        L14 = "Nonce check failed! Type error:"
        L15 = A0
        L16 = " remote MAC address:"
        L17 = A1
        L14 = L14 .. L15 .. L16 .. L17
        L12(L13, L14)
        L12 = false
        return L12
      end
      L12 = readNonce
      L13 = L11
      L12 = L12(L13)
      if L12 then
        L13 = type
        L14 = L12
        L13 = L13(L14)
        if L13 == "table" then
          L13 = tonumber
          L14 = L12.mark
          L13 = L13(L14)
          if L8 > L13 then
            L13 = L12.mac
            if A1 ~= L13 then
              L13 = _UPVALUE1_
              L13 = L13.log
              L14 = 6
              L15 = "Mac address changed: "
              L16 = L12.mac
              L17 = " --> "
              L18 = A1
              L15 = L15 .. L16 .. L17 .. L18
              L16 = L12
              L17 = A0
              L13(L14, L15, L16, L17)
            end
            L13 = tostring
            L14 = L8
            L13 = L13(L14)
            L12.mark = L13
            L13 = writeNonce
            L14 = L11
            L15 = L12
            L13(L14, L15)
            L13 = true
            return L13
          else
            L13 = _UPVALUE1_
            L13 = L13.log
            L14 = 6
            L15 = "Nonce check failed!: Not match"
            L16 = A0
            L17 = " remote MAC address:"
            L18 = A1
            L15 = L15 .. L16 .. L17 .. L18
            L16 = L12
            L13(L14, L15, L16)
          end
      end
      else
        L13 = {}
        L12 = L13
        L13 = tostring
        L14 = L8
        L13 = L13(L14)
        L12.mark = L13
        L12.mac = A1
        L13 = writeNonce
        L14 = L11
        L15 = L12
        L13(L14, L15)
        L13 = true
        return L13
      end
    end
  end
  L5 = false
  return L5
end
checkNonce = L13
L13 = "xiaoqiang-web"
function L14()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16
  L0 = require
  L1 = "luci.http.protocol"
  L0 = L0(L1)
  L1 = require
  L2 = "xiaoqiang.common.XQConfigs"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.util.XQCryptoUtil"
  L2 = L2(L3)
  L3 = nil
  L4 = "http://miwifi.com/cgi-bin/luci/web/xmaccount"
  L5 = "followup="
  L6 = L4
  L5 = L5 .. L6
  L6 = require
  L7 = "xiaoqiang.util.XQSysUtil"
  L6 = L6(L7)
  L7 = L6.getEncryptMode
  L7 = L7()
  L8 = nil
  if L7 == 1 then
    L9 = L2.binaryBase64Enc
    L10 = L2.sha256Binary
    L11 = L5
    L10, L11, L12, L13, L14, L15, L16 = L10(L11)
    L9 = L9(L10, L11, L12, L13, L14, L15, L16)
    L8 = L9
  else
    L9 = L2.binaryBase64Enc
    L10 = L2.sha1Binary
    L11 = L5
    L10, L11, L12, L13, L14, L15, L16 = L10(L11)
    L9 = L9(L10, L11, L12, L13, L14, L15, L16)
    L8 = L9
  end
  L9 = L1.SERVER_CONFIG
  if L9 == 0 then
    L9 = L1.PASSPORT_CONFIG_ONLINE_URL
    L10 = "?callback="
    L11 = L0.urlencode
    L12 = L1.XQ_SERVER_ONLINE_STS_URL
    L13 = "?sign="
    L14 = L8
    L15 = "&followup="
    L16 = L4
    L12 = L12 .. L13 .. L14 .. L15 .. L16
    L11 = L11(L12)
    L12 = "&sid="
    L13 = _UPVALUE0_
    L3 = L9 .. L10 .. L11 .. L12 .. L13
  else
    L9 = L1.SERVER_CONFIG
    if L9 == 1 then
      L9 = L1.PASSPORT_CONFIG_PREVIEW_URL
      L10 = "?callback="
      L11 = L0.urlencode
      L12 = L1.XQ_SERVER_STAGING_STS_URL
      L13 = "?sign="
      L14 = L8
      L15 = "&followup="
      L16 = L4
      L12 = L12 .. L13 .. L14 .. L15 .. L16
      L11 = L11(L12)
      L12 = "&sid="
      L13 = _UPVALUE0_
      L3 = L9 .. L10 .. L11 .. L12 .. L13
    end
  end
  return L3
end
passportLoginUrl = L14
function L14()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = require
  L1 = "xiaoqiang.util.XQSysUtil"
  L0 = L0(L1)
  L1 = require
  L2 = "luci.http.protocol"
  L1 = L1(L2)
  L2 = require
  L3 = "xiaoqiang.common.XQConfigs"
  L2 = L2(L3)
  L3 = nil
  L4 = L0.getPassportBindInfo
  L4 = L4()
  L5 = _UPVALUE0_
  L5 = L5.isStrNil
  L6 = L4
  L5 = L5(L6)
  if L5 then
    L5 = ""
    return L5
  end
  L5 = "http://miwifi.com/cgi-bin/luci/web/home"
  L6 = L2.SERVER_CONFIG
  if L6 == 0 then
    L6 = L2.PASSPORT_LOGOUT_ONLINE_URL
    L7 = "?callback="
    L8 = L1.urlencode
    L9 = L5
    L8 = L8(L9)
    L9 = "&sid="
    L10 = _UPVALUE1_
    L11 = "&userId="
    L12 = L4
    L3 = L6 .. L7 .. L8 .. L9 .. L10 .. L11 .. L12
  else
    L6 = L2.SERVER_CONFIG
    if L6 == 1 then
      L6 = L2.PASSPORT_LOGOUT_PREVIEW_URL
      L7 = "?callback="
      L8 = L1.urlencode
      L9 = L5
      L8 = L8(L9)
      L9 = "&sid="
      L10 = _UPVALUE1_
      L11 = "&userId="
      L12 = L4
      L3 = L6 .. L7 .. L8 .. L9 .. L10 .. L11 .. L12
    end
  end
  return L3
end
passportLogoutUrl = L14
function L14(A0)
  local L1, L2, L3, L4, L5
  L1 = 0
  L2 = {}
  L2.l = 0.5
  L3 = _UPVALUE0_
  L3 = L3.isStrNil
  L4 = A0
  L3 = L3(L4)
  if L3 then
    L3 = 1
    return L3
  end
  L3 = #A0
  if L3 < 6 then
    L3 = 1
    return L3
  else
    L3 = L2.l
    L4 = math
    L4 = L4.sqrt
    L5 = #A0
    L5 = L5 - 6
    L5 = L5 / 2
    L4 = L4(L5)
    L3 = L3 * L4
    if 2 < L3 then
      L3 = 1
    end
    L1 = L1 + L3
  end
  L4 = A0
  L3 = A0.match
  L5 = "%d"
  L3 = L3(L4, L5)
  if L3 then
    L1 = L1 + 1
  end
  L4 = A0
  L3 = A0.match
  L5 = "%l"
  L3 = L3(L4, L5)
  if L3 then
    L1 = L1 + 1
  end
  L4 = A0
  L3 = A0.match
  L5 = "%u"
  L3 = L3(L4, L5)
  if L3 then
    L1 = L1 + 1
  end
  L4 = A0
  L3 = A0.match
  L5 = "%W"
  L3 = L3(L4, L5)
  if L3 then
    L1 = L1 + 1
  end
  if L1 < 2 then
    L3 = 1
    return L3
  elseif L1 < 3 then
    L3 = 2
    return L3
  else
    L3 = 3
    return L3
  end
end
checkStrong = L14
L14 = {}
L15 = "'"
L16 = ";"
L17 = "nvram"
L18 = "dropbear"
L19 = "bdata"
L14[1] = L15
L14[2] = L16
L14[3] = L17
L14[4] = L18
L14[5] = L19
KEY_WORDS = L14
function L14(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  if L1 then
    return L1
  else
    A0 = L1
  end
  for L4, L5 in L1, L2, L3 do
    L7 = A0
    L6 = A0.match
    L8 = L5
    L6 = L6(L7, L8)
    if L6 then
      L6 = require
      L7 = "xiaoqiang.XQLog"
      L6 = L6(L7)
      L7 = L6.log
      L8 = 6
      L9 = "Keyword Warning:"
      L10 = A0
      L9 = L9 .. L10
      L7(L8, L9)
      L7 = false
      return L7
    end
  end
  return L1
end
_keyWordsFilter = L14
function L14(A0)
  local L1, L2
  L1 = _keyWordsFilter
  L2 = A0
  return L1(L2)
end
cmdSafeCheck = L14
L14 = [=[
[`;|$&
]]=]
L15 = {}
L15.name = 1
L15.password = 1
L15.password2g = 1
L15.password5g = 1
L15.password5g2 = 1
L15.pppoeName = 1
L15.pppoePwd = 1
L15.pwd = 1
L15.pwd1 = 1
L15.pwd2 = 1
L15.pwd3 = 1
L15.newPwd = 1
L15.service = 1
L15.ssid = 1
L15.ssid1 = 1
L15.ssid2 = 1
L15.ssid3 = 1
L15.ssid2g = 1
L15.ssid5g = 1
L15.ssid5g2 = 1
L15.username = 1
L15.apn = 1
L15.pdp = 1
L15.user = 1
L15.passwd = 1
L15.contact_phone = 1
L15.phoneList = 1
L15.msgtext = 1
L15.acs_username = 1
L15.acs_password = 1
L15.conn_username = 1
L15.conn_password = 1
function L16(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if not A0 or not A1 then
    return A1
  end
  L2 = _UPVALUE0_
  L2 = L2[A0]
  if L2 then
    return A1
  end
  L2 = string
  L2 = L2.find
  L3 = A1
  L4 = _UPVALUE1_
  L2 = L2(L3, L4)
  if L2 then
    L2 = _UPVALUE2_
    L2 = L2.log
    L3 = 3
    L4 = "hackCheck match key:"
    L5 = A0
    L6 = " val:"
    L7 = A1
    L4 = L4 .. L5 .. L6 .. L7
    L2(L3, L4)
    L2 = nil
    return L2
  end
  return A1
end
hackCheck = L16
function L16(A0)
  local L1, L2, L3
  L1 = string
  L1 = L1.find
  L2 = A0
  L3 = _UPVALUE0_
  L1 = L1(L2, L3)
  if L1 then
    L1 = ""
    return L1
  end
  return A0
end
hackCharsCheck = L16
function L16(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.isStrNil
  L2 = A0
  L1 = L1(L2)
  if L1 then
    L1 = ""
    return L1
  else
    L2 = A0
    L1 = A0.gsub
    L3 = "\\"
    L4 = "\\\\"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "`"
    L4 = "\\`"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "\""
    L4 = "\\\""
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "%$"
    L4 = "\\$"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "%&"
    L4 = "\\&"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "%|"
    L4 = "\\|"
    L1 = L1(L2, L3, L4)
    L2 = L1
    L1 = L1.gsub
    L3 = "%;"
    L4 = "\\;"
    return L1(L2, L3, L4)
  end
end
parseCmdline = L16
