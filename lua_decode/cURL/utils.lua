local L0, L1
function L0(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  A0 = A0 or A0
  L1 = require
  L2 = "path"
  L1 = L1(L2)
  L2 = setmetatable
  L3 = {}
  L4 = {}
  L4.__index = L5
  L2 = L2(L3, L4)
  function L3(A0, A1, A2)
    local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
    L3 = 1
    L4 = {}
    while true do
      L5 = #A0
      if not (L3 <= L5) then
        break
      end
      L5 = string
      L5 = L5.find
      L6 = A0
      L7 = A1
      L8 = L3
      L9 = A2
      L5, L6 = L5(L6, L7, L8, L9)
      if L5 then
        L7 = table
        L7 = L7.insert
        L8 = L4
        L9 = string
        L9 = L9.sub
        L10 = A0
        L11 = L3
        L12 = L5 - 1
        L9 = L9(L10, L11, L12)
        L7(L8, L9)
        L3 = L6 + 1
      else
        L7 = table
        L7 = L7.insert
        L8 = L4
        L9 = string
        L9 = L9.sub
        L10 = A0
        L11 = L3
        L9 = L9(L10, L11)
        L7(L8, L9)
        break
      end
    end
    return L4
  end
  L4 = L2.CURL_CA_BUNDLE
  if L4 then
    L4 = L1.isfile
    L4 = L4(L5)
    if L4 then
      L4 = L2.CURL_CA_BUNDLE
      return L4
    end
  end
  L4 = L2.SSL_CERT_DIR
  if L4 then
    L4 = L1.isdir
    L4 = L4(L5)
    if L4 then
      L4 = nil
      return L4, L5
    end
  end
  L4 = L2.SSL_CERT_FILE
  if L4 then
    L4 = L1.isfile
    L4 = L4(L5)
    if L4 then
      L4 = L2.SSL_CERT_FILE
      return L4
    end
  end
  L4 = L1.IS_WINDOWS
  if not L4 then
    return
  end
  L4 = {}
  L8 = "System32"
  L8 = L2.windir
  L9 = "SysWOW64"
  L8 = L2.windir
  L4[1] = L5
  L4[2] = L6
  L4[3] = L7
  L4[4] = L8
  L8 = ";"
  L8, L9, L10, L11, L12 = L6(L7, L8)
  for L8, L9 in L5, L6, L7 do
    L10 = #L4
    L10 = L10 + 1
    L4[L10] = L9
  end
  for L8, L9 in L5, L6, L7 do
    L10 = L1.fullpath
    L11 = L9
    L10 = L10(L11)
    L9 = L10
    L10 = L1.isdir
    L11 = L9
    L10 = L10(L11)
    if L10 then
      L10 = L1.join
      L11 = L9
      L12 = A0
      L10 = L10(L11, L12)
      L9 = L10
      L10 = L1.isfile
      L11 = L9
      L10 = L10(L11)
      if L10 then
        return L9
      end
    end
  end
end
L1 = {}
L1.find_ca_bundle = L0
return L1
