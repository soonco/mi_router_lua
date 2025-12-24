local L0, L1, L2, L3
L0 = module
L1 = "xiaoqiang.util.XQCryptoUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function L2(A0)
  local L1, L2, L3, L4, L5
  L2 = A0
  L1 = A0.gsub
  L3 = "."
  function L4(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9
    L1 = ""
    L2 = A0.byte
    L2 = L2(L3)
    for L6 = L3, L4, L5 do
      L7 = L1
      L8 = 2 ^ L6
      L8 = L2 % L8
      L9 = L6 - 1
      L9 = 2 ^ L9
      L9 = L2 % L9
      L8 = L8 - L9
      if 0 < L8 then
        L8 = "1"
        if L8 then
          goto lbl_21
        end
      end
      L8 = "0"
      ::lbl_21::
      L1 = L7 .. L8
    end
    return L1
  end
  L1 = L1(L2, L3, L4)
  L2 = "0000"
  L1 = L1 .. L2
  L2 = L1
  L1 = L1.gsub
  L3 = "%d%d%d?%d?%d?%d?"
  function L4(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9
    L1 = #A0
    if L1 < 6 then
      L1 = ""
      return L1
    end
    L1 = 0
    for L5 = L2, L3, L4 do
      L7 = A0
      L6 = A0.sub
      L8 = L5
      L9 = L5
      L6 = L6(L7, L8, L9)
      if L6 == "1" then
        L6 = 6 - L5
        L6 = 2 ^ L6
        if L6 then
          goto lbl_22
        end
      end
      L6 = 0
      ::lbl_22::
      L1 = L1 + L6
    end
    L5 = L1 + 1
    return L2(L3, L4, L5)
  end
  L1 = L1(L2, L3, L4)
  L2 = {}
  L3 = ""
  L4 = "=="
  L5 = "="
  L2[1] = L3
  L2[2] = L4
  L2[3] = L5
  L3 = #A0
  L3 = L3 % 3
  L3 = L3 + 1
  L2 = L2[L3]
  L1 = L1 .. L2
  return L1
end
binaryBase64Enc = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = string
  L1 = L1.gsub
  L2 = A0
  L3 = "[^"
  L4 = _UPVALUE0_
  L5 = "=]"
  L3 = L3 .. L4 .. L5
  L4 = ""
  L1 = L1(L2, L3, L4)
  A0 = L1
  L2 = A0
  L1 = A0.gsub
  L3 = "."
  function L4(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9
    if A0 == "=" then
      L1 = ""
      return L1
    end
    L1 = ""
    L2 = _UPVALUE0_
    L2 = L2.find
    L2 = L2(L3, L4)
    L2 = L2 - 1
    for L6 = L3, L4, L5 do
      L7 = L1
      L8 = 2 ^ L6
      L8 = L2 % L8
      L9 = L6 - 1
      L9 = 2 ^ L9
      L9 = L2 % L9
      L8 = L8 - L9
      if 0 < L8 then
        L8 = "1"
        if L8 then
          goto lbl_28
        end
      end
      L8 = "0"
      ::lbl_28::
      L1 = L7 .. L8
    end
    return L1
  end
  L1 = L1(L2, L3, L4)
  L2 = L1
  L1 = L1.gsub
  L3 = "%d%d%d?%d?%d?%d?%d?%d?"
  function L4(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9
    L1 = #A0
    if L1 ~= 8 then
      L1 = ""
      return L1
    end
    L1 = 0
    for L5 = L2, L3, L4 do
      L7 = A0
      L6 = A0.sub
      L8 = L5
      L9 = L5
      L6 = L6(L7, L8, L9)
      if L6 == "1" then
        L6 = 8 - L5
        L6 = 2 ^ L6
        if L6 then
          goto lbl_22
        end
      end
      L6 = 0
      ::lbl_22::
      L1 = L1 + L6
    end
    return L2(L3)
  end
  L1 = L1(L2, L3, L4)
  return L1
end
binaryBase64Dec = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.trim
  L3 = L1.exec
  L4 = _UPVALUE0_
  L4 = L4._cmdformat
  L5 = A0
  L4 = L4(L5)
  L4 = "/usr/bin/md5sum \"%s\"|/usr/bin/cut -d' ' -f1" % L4
  L3, L4, L5 = L3(L4)
  return L2(L3, L4, L5)
end
md5File = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.trim
  L3 = L1.exec
  L4 = _UPVALUE0_
  L4 = L4._cmdformat
  L5 = A0
  L4 = L4(L5)
  L4 = "/bin/echo -n \"%s\"|/usr/bin/md5sum|/usr/bin/cut -d' ' -f1" % L4
  L3, L4, L5 = L3(L4)
  return L2(L3, L4, L5)
end
md5Str = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  L1 = require
  L2 = "luci.util"
  L1 = L1(L2)
  L2 = L1.trim
  L3 = L1.exec
  L4 = _UPVALUE0_
  L4 = L4._cmdformat
  L5 = A0
  L4 = L4(L5)
  L4 = "/bin/echo -n \"%s\"|openssl dgst -r -sha256|/usr/bin/cut -d' ' -f1" % L4
  L3, L4, L5 = L3(L4)
  return L2(L3, L4, L5)
end
sha256 = L2
function L2(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.gsub
  L3 = ".."
  function L4(A0)
    local L1, L2, L3, L4
    L1 = string
    L1 = L1.char
    L2 = base
    L2 = L2.tonumber
    L3 = A0
    L4 = 16
    L2, L3, L4 = L2(L3, L4)
    return L1(L2, L3, L4)
  end
  return L1(L2, L3, L4)
end
function L3(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = sha256
  L3 = A0
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
sha256_binary = L3
function L3(A0)
  local L1, L2
  L1 = sha256_binary
  L2 = A0
  return L1(L2)
end
sha256Binary = L3
function L3(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "mime"
  L1 = L1(L2)
  L2 = md5Str
  L3 = L1.b64
  L4 = A0
  L3, L4 = L3(L4)
  return L2(L3, L4)
end
md5Base64Str = L3
function L3(A0)
  local L1, L2, L3
  L1 = require
  L2 = "sha1"
  L1 = L1(L2)
  L2 = L1.sha1
  L3 = A0
  return L2(L3)
end
sha1 = L3
function L3(A0)
  local L1, L2, L3
  L1 = require
  L2 = "sha1"
  L1 = L1(L2)
  L2 = L1.sha1_binary
  L3 = A0
  return L2(L3)
end
sha1Binary = L3
function L3(A0)
  local L1, L2, L3
  L1 = binaryBase64Enc
  L2 = sha1Binary
  L3 = A0
  L2, L3 = L2(L3)
  return L1(L2, L3)
end
hash4SHA1 = L3
function L3(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.gsub
  L3 = "(.)"
  function L4(A0)
    local L1, L2, L3, L4
    L1 = string
    L1 = L1.format
    L2 = "%02x"
    L3 = string
    L3 = L3.byte
    L4 = A0
    L3, L4 = L3(L4)
    return L1(L2, L3, L4)
  end
  L1 = L1(L2, L3, L4)
  return L1
end
binToHex = L3
function L3(A0)
  local L1, L2, L3, L4
  L2 = A0
  L1 = A0.gsub
  L3 = "(%x%x)"
  function L4(A0)
    local L1, L2, L3, L4
    L1 = string
    L1 = L1.char
    L2 = tonumber
    L3 = A0
    L4 = 16
    L2, L3, L4 = L2(L3, L4)
    return L1(L2, L3, L4)
  end
  L1 = L1(L2, L3, L4)
  return L1
end
hextobin = L3
