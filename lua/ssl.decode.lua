local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
L0 = require
L1 = "ssl.core"
L0 = L0(L1)
L1 = require
L2 = "ssl.context"
L1 = L1(L2)
L2 = require
L3 = "ssl.x509"
L2 = L2(L3)
L3 = require
L4 = "ssl.config"
L3 = L3(L4)
L4 = table
L4 = L4.unpack
L4 = L4 or L4
L5 = setmetatable
L6 = {}
L7 = {}
L7.__mode = "k"
L5 = L5(L6, L7)
function L6(A0, A1, A2)
  local L3, L4, L5, L6
  if A1 then
    L3 = type
    L4 = A1
    L3 = L3(L4)
    if L3 == "table" then
      L3 = A0
      L4 = A2
      L5 = _UPVALUE0_
      L6 = A1
      L5, L6 = L5(L6)
      return L3(L4, L5, L6)
    else
      L3 = A0
      L4 = A2
      L5 = A1
      return L3(L4, L5)
    end
  end
  L3 = true
  return L3
end
function L7(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = ""
  for L5, L6 in L2, L3, L4 do
    L7 = type
    L8 = L6
    L7 = L7(L8)
    if L7 ~= "string" then
      L7 = nil
      return L7
    end
    L7 = #L6
    if L7 == 0 then
      L8 = nil
      L9 = "invalid ALPN name (empty string)"
      return L8, L9
    elseif 255 < L7 then
      L8 = nil
      L9 = "invalid ALPN name (length > 255)"
      return L8, L9
    end
    L8 = L1
    L9 = string
    L9 = L9.char
    L10 = L7
    L9 = L9(L10)
    L10 = L6
    L1 = L8 .. L9 .. L10
  end
  if L1 == "" then
    return L2, L3
  end
  return L1
end
function L8(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = 1
  L2 = {}
  while true do
    L3 = #A0
    if not (L1 < L3) then
      break
    end
    L4 = A0
    L3 = A0.byte
    L5 = L1
    L3 = L3(L4, L5)
    L4 = #L2
    L4 = L4 + 1
    L6 = A0
    L5 = A0.sub
    L7 = L1 + 1
    L8 = L1 + L3
    L5 = L5(L6, L7, L8)
    L2[L4] = L5
    L4 = L1 + L3
    L1 = L4 + 1
  end
  return L2
end
function L9(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L4 = _UPVALUE0_
  L4 = L4.create
  L4 = L4(L5)
  L2 = L5
  L3 = L4
  if not L3 then
    L4 = nil
    return L4, L5
  end
  L4 = _UPVALUE0_
  L4 = L4.setmode
  L4 = L4(L5, L6)
  L2 = L5
  L1 = L4
  if not L1 then
    L4 = nil
    return L4, L5
  end
  L4 = A0.certificates
  if not L4 then
    L6.certificate = L7
    L6.key = L7
    L6.password = L7
    L5[1] = L6
    L4 = L5
  end
  for L8, L9 in L5, L6, L7 do
    L10 = L9.key
    if L10 then
      L10 = L9.password
      if L10 then
        L10 = type
        L11 = L9.password
        L10 = L10(L11)
        if L10 ~= "function" then
          L10 = type
          L11 = L9.password
          L10 = L10(L11)
          if L10 ~= "string" then
            L10 = nil
            L11 = "invalid password type"
            return L10, L11
          end
        end
      end
      L10 = _UPVALUE0_
      L10 = L10.loadkey
      L11 = L3
      L12 = L9.key
      L13 = L9.password
      L10, L11 = L10(L11, L12, L13)
      L2 = L11
      L1 = L10
      if not L1 then
        L10 = nil
        L11 = L2
        return L10, L11
      end
    end
    L10 = L9.certificate
    if L10 then
      L10 = _UPVALUE0_
      L10 = L10.loadcert
      L11 = L3
      L12 = L9.certificate
      L10, L11 = L10(L11, L12)
      L2 = L11
      L1 = L10
      if not L1 then
        L10 = nil
        L11 = L2
        return L10, L11
      end
      L10 = L9.key
      if L10 then
        L10 = _UPVALUE0_
        L10 = L10.checkkey
        if L10 then
          L10 = _UPVALUE0_
          L10 = L10.checkkey
          L11 = L3
          L10 = L10(L11)
          L1 = L10
          if not L1 then
            L10 = nil
            L11 = "private key does not match public key"
            return L10, L11
          end
        end
      end
    end
  end
  if not L5 then
    if not L5 then
      goto lbl_126
    end
  end
  L8 = A0.capath
  L2 = L6
  L1 = L5
  if not L1 then
    return L5, L6
  end
  ::lbl_126::
  if L5 then
    L2 = L6
    L1 = L5
    if not L1 then
      return L5, L6
    end
  end
  if L5 then
    L2 = L6
    L1 = L5
    if not L1 then
      return L5, L6
    end
  end
  L8 = L3
  L2 = L6
  L1 = L5
  if not L1 then
    return L5, L6
  end
  L8 = L3
  L2 = L6
  L1 = L5
  if not L1 then
    return L5, L6
  end
  if L5 then
    L2 = L6
    L1 = L5
    if not L1 then
      return L5, L6
    end
  end
  if L5 then
    if L5 ~= "function" then
      return L5, L6
    end
    L5(L6, L7)
  end
  if not L5 then
    if not L5 then
      if not L5 then
        goto lbl_227
      end
    end
    return L5, L6
  end
  ::lbl_227::
  if L5 then
    if L5 then
      L2 = L6
      L1 = L5
      if not L1 then
        return L5, L6
      end
  end
  elseif L5 then
    L2 = L6
    L1 = L5
    if not L1 then
      return L5, L6
    end
  end
  if L5 then
    if L5 then
      L8 = L3
      L2 = L6
      L1 = L5
      if not L1 then
        return L5, L6
      end
    end
  end
  if L5 == "server" then
    if L5 then
      if L5 == "function" then
        function L8(A0)
          local L1, L2, L3
          L1 = _UPVALUE0_
          L2 = _UPVALUE1_
          L3 = A0
          L2, L3 = L2(L3)
          L1 = L1(L2, L3)
          L2 = type
          L3 = L1
          L2 = L2(L3)
          if L2 == "string" then
            L2 = {}
            L3 = L1
            L2[1] = L3
            L1 = L2
          else
            L2 = type
            L3 = L1
            L2 = L2(L3)
            if L2 ~= "table" then
              L2 = nil
              return L2
            end
          end
          L2 = _UPVALUE2_
          L3 = L1
          L2 = L2(L3)
          return L2
        end
        L2 = L7
        L1 = L6
        if not L1 then
          return L6, L7
        end
      elseif L5 == "table" then
        L2 = L7
        L1 = L6
        if not L1 then
          return L6, L7
        end
        function L8()
          local L0, L1
          L0 = _UPVALUE0_
          L1 = _UPVALUE1_
          L0 = L0(L1)
          return L0
        end
        L2 = L7
        L1 = L6
        if not L1 then
          return L6, L7
        end
      else
        return L5, L6
      end
  end
  elseif L5 == "client" then
    if L5 then
      if L6 == "string" then
        L8 = A0.alpn
        L7[1] = L8
        L2 = L7
      elseif L6 == "table" then
        L2 = L7
      else
        return L6, L7
      end
      if not L5 then
        return L6, L7
      end
      L8 = L5
      L2 = L7
      L1 = L6
      if not L1 then
        return L6, L7
      end
    end
  end
  if L5 then
    if L5 then
      L5(L6)
    end
  end
  return L3
end
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L4 = type
  L5 = A1
  L4 = L4(L5)
  if L4 == "table" then
    L4 = _UPVALUE0_
    L5 = A1
    L4, L5 = L4(L5)
    L3 = L5
    L2 = L4
    if not L2 then
      L4 = nil
      L5 = L3
      return L4, L5
    end
  else
    L2 = A1
  end
  L4 = _UPVALUE1_
  L4 = L4.create
  L5 = L2
  L4, L5 = L4(L5)
  if L4 then
    L6 = _UPVALUE1_
    L6 = L6.setfd
    L7 = L4
    L9 = A0
    L8 = A0.getfd
    L8, L9 = L8(L9)
    L6(L7, L8, L9)
    L7 = A0
    L6 = A0.setfd
    L8 = _UPVALUE1_
    L8 = L8.SOCKET_INVALID
    L6(L7, L8)
    L6 = _UPVALUE2_
    L6[L4] = L2
    return L4
  end
  L6 = nil
  L7 = L5
  return L6, L7
end
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L6 = _UPVALUE0_
  L6 = L6.compression
  L7 = A0
  L6, L7 = L6(L7)
  L4 = L7
  L3 = L6
  if L4 then
    L6 = L3
    L7 = L4
    return L6, L7
  end
  if A1 == "compression" then
    return L3
  end
  L6 = {}
  L6.compression = L3
  L7 = _UPVALUE0_
  L7 = L7.info
  L8 = A0
  L7, L8, L9, L10 = L7(L8)
  L5 = L10
  L6.algbits = L9
  L6.bits = L8
  L2 = L7
  if L2 then
    L7 = string
    L7 = L7.match
    L8 = L2
    L9 = "^(%S+)%s+(%S+)%s+Kx=(%S+)%s+Au=(%S+)%s+Enc=(%S+)%s+Mac=(%S+)"
    L7, L8, L9, L10, L11, L12 = L7(L8, L9)
    L6.mac = L12
    L6.encryption = L11
    L6.authentication = L10
    L6.key = L9
    L6.protocol = L8
    L6.cipher = L7
    L7 = string
    L7 = L7.match
    L8 = L2
    L9 = "%sexport%s*$"
    L7 = L7(L8, L9)
    L7 = L7 ~= nil
    L6.export = L7
  end
  if L5 then
    L6.protocol = L5
  end
  if A1 then
    L7 = L6[A1]
    return L7
  end
  L7 = next
  L8 = L6
  L7 = L7(L8)
  L7 = L7 and L7
  return L7
end
L12 = L0.setmethod
L13 = "info"
L14 = L11
L12(L13, L14)
L12 = {}
L12._VERSION = "0.9"
L13 = L0.copyright
L13 = L13()
L12._COPYRIGHT = L13
L12.config = L3
L13 = L2.load
L12.loadcertificate = L13
L12.newcontext = L9
L12.wrap = L10
return L12
