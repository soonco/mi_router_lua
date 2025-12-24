local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
L0 = {}
L0._NAME = "Lua-cURL"
L0._VERSION = "0.3.13"
L0._LICENSE = "MIT"
L0._COPYRIGHT = "Copyright (c) 2014-2021 Alexey Melnichuk"
function L1(A0)
  local L1, L2, L3
  L1 = string
  L1 = L1.match
  L2 = A0
  L3 = "%((.-)%)"
  L1 = L1(L2, L3)
  if not L1 then
    L1 = string
    L1 = L1.match
    L2 = A0
    L3 = ": (%x+)$"
    L1 = L1(L2, L3)
  end
  return L1
end
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7
  A1 = A1 or A1
  for L5, L6 in L2, L3, L4 do
    A1[L5] = L6
  end
  return A1
end
function L3(A0)
  local L1
  function L1(A0, ...)
    local L2, L3, L4, L5
    L2 = A0._handle
    L3 = _UPVALUE0_
    L2 = L2[L3]
    L3 = A0._handle
    L4, L5 = ...
    L2, L3 = L2(L3, L4, L5)
    L4 = A0._handle
    if L2 == L4 then
      return A0
    end
    L4 = L2
    L5 = L3
    return L4, L5
  end
  return L1
end
function L4(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = "setopt_"
  A0 = L2 .. L3
  L2 = _UPVALUE0_
  L2 = L2(L3)
  for L6, L7 in L3, L4, L5 do
    L2[L7] = L7
  end
  return L3
end
function L5()
  local L0, L1
  L0 = {}
  L1 = {}
  L0.resp = L1
  L1 = {}
  L0._ = L1
  function L1(A0, A1, ...)
    local L3, L4, L5, L6, L7, L8
    L3 = assert
    L5 = A1
    L4 = A1.getinfo_response_code
    L4, L5, L6, L7, L8 = L4(L5)
    L3 = L3(L4, L5, L6, L7, L8)
    L4 = A0._
    L4 = L4[A1]
    if not L4 then
      L4 = A0._
      L5 = {}
      L4[A1] = L5
    end
    L4 = A0._
    L4 = L4[A1]
    L5 = A0.resp
    L5 = L5[A1]
    if L5 ~= L3 then
      L5 = #L4
      L5 = L5 + 1
      L6 = {}
      L7 = "response"
      L8 = L3
      L6[1] = L7
      L6[2] = L8
      L4[L5] = L6
      L5 = A0.resp
      L5[A1] = L3
    end
    L5 = #L4
    L5 = L5 + 1
    L6 = {}
    L7, L8 = ...
    L6[1] = L7
    L6[2] = L8
    L4[L5] = L6
  end
  L0.append = L1
  function L1(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8
    for L4, L5 in L1, L2, L3 do
      L6 = table
      L6 = L6.remove
      L7 = L5
      L8 = 1
      L6 = L6(L7, L8)
      if L6 then
        L7 = L4
        L8 = L6
        return L7, L8
      end
    end
  end
  L0.next = L1
  return L0
end
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = require
  L3 = "lcurl.safe"
  L2 = L2(L3)
  L3 = _UPVALUE0_
  L3 = L3()
  function L4(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8
    if not L1 then
      for L4, L5 in L1, L2, L3 do
        if L4 ~= "n" then
          L7 = L5
          L6 = L5.setopt_writefunction
          function L8(A0)
            local L1, L2, L3, L4, L5
            L1 = _UPVALUE0_
            L2 = L1
            L1 = L1.append
            L3 = _UPVALUE1_
            L4 = "data"
            L5 = A0
            L1(L2, L3, L4, L5)
          end
          L6(L7, L8)
          L7 = L5
          L6 = L5.setopt_headerfunction
          function L8(A0)
            local L1, L2, L3, L4, L5
            L1 = _UPVALUE0_
            L2 = L1
            L1 = L1.append
            L3 = _UPVALUE1_
            L4 = "header"
            L5 = A0
            L1(L2, L3, L4, L5)
          end
          L6(L7, L8)
        end
      end
      A0._easy_mark = true
    end
    return L1
  end
  L5 = L4
  L6 = A0
  L5 = L5(L6)
  if 0 == L5 then
    return
  end
  L5 = assert
  L6 = A1
  L7 = A0
  L6, L7 = L6(L7)
  L5(L6, L7)
  function L5()
    local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
    L0 = _UPVALUE0_
    L1 = _UPVALUE1_
    L0 = L0(L1)
    while true do
      L1 = _UPVALUE2_
      L2 = L1
      L1 = L1.next
      L1, L2 = L1(L2)
      if L2 then
        L3 = L2[2]
        L4 = L2[1]
        L5 = L1
        return L3, L4, L5
      end
      if L0 == 0 then
        break
      end
      L3 = _UPVALUE1_
      L4 = L3
      L3 = L3.wait
      L3(L4)
      L3 = assert
      L4 = _UPVALUE3_
      L5 = _UPVALUE1_
      L4, L5, L6, L7, L8, L9, L10, L11 = L4(L5)
      L3 = L3(L4, L5, L6, L7, L8, L9, L10, L11)
      if L0 >= L3 then
        while true do
          L4 = assert
          L5 = _UPVALUE1_
          L6 = L5
          L5 = L5.info_read
          L5, L6, L7, L8, L9, L10, L11 = L5(L6)
          L4, L5, L6 = L4(L5, L6, L7, L8, L9, L10, L11)
          if L4 == 0 then
            break
          end
          if L5 then
            L8 = L4
            L7 = L4.getinfo_response_code
            L7 = L7(L8)
            L5 = L7 or L5
            if not L7 then
            end
            L7 = _UPVALUE2_
            L8 = L7
            L7 = L7.append
            L9 = L4
            L10 = "done"
            L11 = L5
            L7(L8, L9, L10, L11)
          else
            L7 = _UPVALUE2_
            L8 = L7
            L7 = L7.append
            L9 = L4
            L10 = "error"
            L11 = L6
            L7(L8, L9, L10, L11)
          end
          L7 = _UPVALUE1_
          L8 = L7
          L7 = L7.remove_handle
          L9 = L4
          L7(L8, L9)
          L8 = L4
          L7 = L4.unsetopt_headerfunction
          L7(L8)
          L8 = L4
          L7 = L4.unsetopt_writefunction
          L7(L8)
        end
      end
      L0 = L3
    end
  end
  return L5
end
function L7(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L3 = type
  L4 = A2
  L3 = L3(L4)
  if L3 == "string" then
    L5 = A0
    L4 = A0.add_content
    L6 = A1
    L7 = A2
    return L4(L5, L6, L7)
  end
  L4 = assert
  L5 = type
  L6 = A1
  L5 = L5(L6)
  L5 = L5 == "string"
  L4(L5)
  L4 = assert
  L5 = L3 == "table"
  L4(L5)
  L4 = assert
  L5 = A2.name
  L5 = L5 == nil
  L4(L5)
  L4 = assert
  L5 = A2.type
  L5 = L5 == nil
  L4(L5)
  L4 = assert
  L5 = A2.headers
  L5 = L5 == nil
  L4(L5)
  L4 = A2.stream
  if L4 then
    L4 = type
    L5 = A2.stream
    L4 = L4(L5)
    if L4 == "function" then
      L5 = assert
      L6 = type
      L7 = A2.length
      L6 = L6(L7)
      L6 = L6 == "number"
      L5(L6)
      L5 = A2.length
      L7 = A0
      L6 = A0.add_stream
      L8 = A1
      L9 = A2.name
      L10 = A2.type
      L11 = A2.headers
      L12 = L5
      L13 = A2.stream
      return L6(L7, L8, L9, L10, L11, L12, L13)
    end
    if L4 == "table" or L4 == "userdata" then
      L5 = A2.length
      if not L5 then
        L5 = assert
        L6 = A2.stream
        L7 = L6
        L6 = L6.length
        L6, L7, L8, L9, L10, L11, L12, L13 = L6(L7)
        L5 = L5(L6, L7, L8, L9, L10, L11, L12, L13)
      end
      L6 = assert
      L7 = type
      L8 = L5
      L7 = L7(L8)
      L7 = L7 == "number"
      L6(L7)
      L7 = A0
      L6 = A0.add_stream
      L8 = A1
      L9 = A2.name
      L10 = A2.type
      L11 = A2.headers
      L12 = L5
      L13 = A2.stream
      return L6(L7, L8, L9, L10, L11, L12, L13)
    end
    L5 = error
    L6 = "Unsupported stream type: "
    L7 = L4
    L6 = L6 .. L7
    L5(L6)
  end
  L4 = A2.file
  if L4 then
    L4 = assert
    L5 = type
    L6 = A2.file
    L5 = L5(L6)
    L5 = L5 == "string"
    L4(L5)
    L5 = A0
    L4 = A0.add_file
    L6 = A1
    L7 = A2.file
    L8 = A2.type
    L9 = A2.filename
    L10 = A2.headers
    return L4(L5, L6, L7, L8, L9, L10)
  end
  L4 = A2.data
  if L4 then
    L4 = assert
    L5 = type
    L6 = A2.data
    L5 = L5(L6)
    L5 = L5 == "string"
    L4(L5)
    L4 = assert
    L5 = type
    L6 = A2.name
    L5 = L5(L6)
    L5 = L5 == "string"
    L4(L5)
    L5 = A0
    L4 = A0.add_buffer
    L6 = A1
    L7 = A2.name
    L8 = A2.data
    L9 = A2.type
    L10 = A2.headers
    return L4(L5, L6, L7, L8, L9, L10)
  end
  L4 = A2[1]
  L4 = L4 or L4
  if L4 then
    L5 = assert
    L6 = type
    L7 = L4
    L6 = L6(L7)
    L6 = L6 == "string"
    L5(L6)
    L5 = A2.type
    if L5 then
      L6 = A0
      L5 = A0.add_content
      L7 = A1
      L8 = L4
      L9 = A2.type
      L10 = A2.headers
      return L5(L6, L7, L8, L9, L10)
    end
    L6 = A0
    L5 = A0.add_content
    L7 = A1
    L8 = L4
    L9 = A2.headers
    return L5(L6, L7, L8, L9)
  end
  return A0
end
function L8(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  for L5, L6 in L2, L3, L4 do
    L7 = _UPVALUE0_
    L8 = A0
    L9 = L5
    L10 = L6
    L7, L8 = L7(L8, L9, L10)
    if not L7 then
      L9 = nil
      L10 = L8
      return L9, L10
    end
  end
  return A0
end
function L9(A0, A1)
  local L2, L3
  L2 = {}
  L3 = A1 or L3
  if not A1 then
    L3 = "LcURL Unknown"
  end
  L2.__type = L3
  function L3(A0, A1)
    local L2, L3, L4
    L2 = _UPVALUE0_
    L2 = L2[A1]
    if not L2 then
      L3 = A0._handle
      L3 = L3[A1]
      if L3 then
        L3 = _UPVALUE1_
        L4 = A1
        L3 = L3(L4)
        L2 = L3
        L3 = _UPVALUE0_
        L3[A1] = L2
      end
    end
    return L2
  end
  L2.__index = L3
  function L3(A0, ...)
    local L2, L3, L4, L5, L6, L7
    L2 = _UPVALUE0_
    L2, L3 = L2()
    if not L2 then
      L4 = nil
      L5 = L3
      return L4, L5
    end
    L4 = setmetatable
    L5 = {}
    L5._handle = L2
    L6 = A0
    L4 = L4(L5, L6)
    L5 = A0.__init
    if L5 then
      L5 = A0.__init
      L6 = L4
      L7 = ...
      return L5(L6, L7)
    end
    return L4
  end
  L2.new = L3
  function L3(A0)
    local L1
    L1 = A0._handle
    return L1
  end
  L2.handle = L3
  return L2
end
function L10(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  L2 = _UPVALUE0_
  L3 = A1.easy
  L4 = "LcURL Easy"
  L2 = L2(L3, L4)
  L3 = _UPVALUE1_
  L4 = "perform"
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L5 = "setopt_share"
  L4 = L4(L5)
  L5 = _UPVALUE1_
  L6 = "setopt_readfunction"
  L5 = L5(L6)
  L6 = {}
  function L7(A0, ...)
    local L2, L3, L4
    L2 = A0._rd_ud
    L3 = _UPVALUE0_
    if L2 == L3 then
      L2 = A0._rd_fn
      L3, L4 = ...
      return L2(L3, L4)
    end
    L2 = A0._rd_fn
    L3 = A0._rd_ud
    L4 = ...
    return L2(L3, L4)
  end
  L2._call_readfunction = L7
  function L7(A0, A1, ...)
    local L3, L4, L5, L6
    L3 = assert
    L4 = A1
    L3(L4)
    L3 = select
    L4 = "#"
    L5, L6 = ...
    L3 = L3(L4, L5, L6)
    if L3 == 0 then
      L3 = type
      L4 = A1
      L3 = L3(L4)
      if L3 == "function" then
        A0._rd_fn = A1
        L3 = _UPVALUE0_
        A0._rd_ud = L3
      else
        L3 = assert
        L4 = A1.read
        L3 = L3(L4)
        A0._rd_fn = L3
        A0._rd_ud = A1
      end
    else
      A0._rd_fn = A1
      L3 = (...)
      A0._ud_fn = L3
    end
    L3 = _UPVALUE1_
    L4 = A0
    L5 = A1
    L6 = ...
    return L3(L4, L5, L6)
  end
  L2.setopt_readfunction = L7
  function L7(A0, A1)
    local L2, L3, L4, L5, L6
    if not A1 then
      L2 = {}
      A1 = L2
    end
    L2 = A1.errorfunction
    L2 = L2 or L2
    L3 = A1.readfunction
    if L3 then
      L4 = A0
      L3 = A0.setopt_readfunction
      L5 = A1.readfunction
      L3, L4 = L3(L4, L5)
      if not L3 then
        L5 = L2
        L6 = L4
        return L5(L6)
      end
    end
    L3 = A1.writefunction
    if L3 then
      L4 = A0
      L3 = A0.setopt_writefunction
      L5 = A1.writefunction
      L3, L4 = L3(L4, L5)
      if not L3 then
        L5 = L2
        L6 = L4
        return L5(L6)
      end
    end
    L3 = A1.headerfunction
    if L3 then
      L4 = A0
      L3 = A0.setopt_headerfunction
      L5 = A1.headerfunction
      L3, L4 = L3(L4, L5)
      if not L3 then
        L5 = L2
        L6 = L4
        return L5(L6)
      end
    end
    L3 = _UPVALUE0_
    L4 = A0
    L3, L4 = L3(L4)
    if not L3 then
      L5 = L2
      L6 = L4
      return L5(L6)
    end
    return A0
  end
  L2.perform = L7
  function L7(A0, A1)
    local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19
    L2 = _UPVALUE0_
    L2 = L2.form
    L2 = L2()
    L3 = true
    L4 = nil
    for L8, L9 in L5, L6, L7 do
      L10 = type
      L11 = L9
      L10 = L10(L11)
      if L10 == "string" then
        L11 = L2
        L10 = L2.add_content
        L12 = L8
        L13 = L9
        L10, L11 = L10(L11, L12, L13)
        L4 = L11
        L3 = L10
      else
        L10 = assert
        L11 = type
        L12 = L9
        L11 = L11(L12)
        L11 = L11 == "table"
        L10(L11)
        L10 = L9.stream_length
        if L10 then
          L10 = assert
          L11 = tonumber
          L12 = L9.stream_length
          L11, L12, L13, L14, L15, L16, L17, L18, L19 = L11(L12)
          L10 = L10(L11, L12, L13, L14, L15, L16, L17, L18, L19)
          L11 = assert
          L12 = L9.file
          L11(L12)
          L11 = L9.stream
          if L11 then
            L12 = L2
            L11 = L2.add_stream
            L13 = L8
            L14 = L9.file
            L15 = L9.type
            L16 = L9.headers
            L17 = L10
            L18 = L9.stream
            L11, L12 = L11(L12, L13, L14, L15, L16, L17, L18)
            L4 = L12
            L3 = L11
          else
            L12 = L2
            L11 = L2.add_stream
            L13 = L8
            L14 = L9.file
            L15 = L9.type
            L16 = L9.headers
            L17 = L10
            L18 = A0._call_readfunction
            L19 = A0
            L11, L12 = L11(L12, L13, L14, L15, L16, L17, L18, L19)
            L4 = L12
            L3 = L11
          end
        else
          L10 = L9.data
          if L10 then
            L11 = L2
            L10 = L2.add_buffer
            L12 = L8
            L13 = L9.file
            L14 = L9.data
            L15 = L9.type
            L16 = L9.headers
            L10, L11 = L10(L11, L12, L13, L14, L15, L16)
            L4 = L11
            L3 = L10
          else
            L11 = L2
            L10 = L2.add_file
            L12 = L8
            L13 = L9.file
            L14 = L9.type
            L15 = L9.filename
            L16 = L9.headers
            L10, L11 = L10(L11, L12, L13, L14, L15, L16)
            L4 = L11
            L3 = L10
          end
        end
      end
      if not L3 then
        break
      end
    end
    if not L3 then
      L5(L6)
      return L5, L6
    end
    L4 = L6
    L3 = L5
    if not L3 then
      L5(L6)
      return L5, L6
    end
    return A0
  end
  L2.post = L7
  function L7(A0, A1)
    local L2, L3, L4, L5
    L2 = _UPVALUE0_
    L3 = A0
    L5 = A1
    L4 = A1.handle
    L4, L5 = L4(L5)
    return L2(L3, L4, L5)
  end
  L2.setopt_share = L7
  L7 = _UPVALUE2_
  L8 = "proxytype"
  L9 = {}
  L10 = A1.PROXY_HTTP
  L9.HTTP = L10
  L10 = A1.PROXY_HTTP_1_0
  L9.HTTP_1_0 = L10
  L10 = A1.PROXY_SOCKS4
  L9.SOCKS4 = L10
  L10 = A1.PROXY_SOCKS5
  L9.SOCKS5 = L10
  L10 = A1.PROXY_SOCKS4A
  L9.SOCKS4A = L10
  L10 = A1.PROXY_SOCKS5_HOSTNAME
  L9.SOCKS5_HOSTNAME = L10
  L10 = A1.PROXY_HTTPS
  L9.HTTPS = L10
  L7 = L7(L8, L9)
  L2.setopt_proxytype = L7
  L7 = _UPVALUE2_
  L8 = "httpauth"
  L9 = {}
  L10 = A1.AUTH_NONE
  L9.NONE = L10
  L10 = A1.AUTH_BASIC
  L9.BASIC = L10
  L10 = A1.AUTH_DIGEST
  L9.DIGEST = L10
  L10 = A1.AUTH_GSSNEGOTIATE
  L9.GSSNEGOTIATE = L10
  L10 = A1.AUTH_NEGOTIATE
  L9.NEGOTIATE = L10
  L10 = A1.AUTH_NTLM
  L9.NTLM = L10
  L10 = A1.AUTH_DIGEST_IE
  L9.DIGEST_IE = L10
  L10 = A1.AUTH_GSSAPI
  L9.GSSAPI = L10
  L10 = A1.AUTH_NTLM_WB
  L9.NTLM_WB = L10
  L10 = A1.AUTH_ONLY
  L9.ONLY = L10
  L10 = A1.AUTH_ANY
  L9.ANY = L10
  L10 = A1.AUTH_ANYSAFE
  L9.ANYSAFE = L10
  L10 = A1.AUTH_BEARER
  L9.BEARER = L10
  L7 = L7(L8, L9)
  L2.setopt_httpauth = L7
  L7 = _UPVALUE2_
  L8 = "ssh_auth_types"
  L9 = {}
  L10 = A1.SSH_AUTH_NONE
  L9.NONE = L10
  L10 = A1.SSH_AUTH_ANY
  L9.ANY = L10
  L10 = A1.SSH_AUTH_PUBLICKEY
  L9.PUBLICKEY = L10
  L10 = A1.SSH_AUTH_PASSWORD
  L9.PASSWORD = L10
  L10 = A1.SSH_AUTH_HOST
  L9.HOST = L10
  L10 = A1.SSH_AUTH_GSSAPI
  L9.GSSAPI = L10
  L10 = A1.SSH_AUTH_KEYBOARD
  L9.KEYBOARD = L10
  L10 = A1.SSH_AUTH_AGENT
  L9.AGENT = L10
  L10 = A1.SSH_AUTH_DEFAULT
  L9.DEFAULT = L10
  L7 = L7(L8, L9)
  L2.setopt_ssh_auth_types = L7
  L3 = _UPVALUE0_
  L4 = A1.multi
  L5 = "LcURL Multi"
  L3 = L3(L4, L5)
  L4 = _UPVALUE1_
  L5 = "perform"
  L4 = L4(L5)
  L5 = _UPVALUE1_
  L6 = "add_handle"
  L5 = L5(L6)
  L6 = _UPVALUE1_
  L7 = "remove_handle"
  L6 = L6(L7)
  function L7(A0)
    local L1
    L1 = {}
    L1.n = 0
    A0._easy = L1
    return A0
  end
  L3.__init = L7
  function L7(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L2 = A0
    L3 = _UPVALUE1_
    return L1(L2, L3)
  end
  L3.perform = L7
  function L7(A0, A1)
    local L2, L3, L4, L5, L6, L7, L8
    L2 = assert
    L3 = A0._easy
    L3 = L3.n
    L3 = 0 <= L3
    L2(L3)
    L3 = A1
    L2 = A1.handle
    L2 = L2(L3)
    L3 = A0._easy
    L3 = L3[L2]
    if L3 then
      return A0
    end
    L3 = _UPVALUE0_
    L4 = A0
    L5 = L2
    L3, L4 = L3(L4, L5)
    if not L3 then
      L5 = nil
      L6 = L4
      return L5, L6
    end
    L5 = A0._easy
    L6 = A0._easy
    L7 = A1
    L8 = A0._easy
    L8 = L8.n
    L8 = L8 + 1
    L6.n = L8
    L5[L2] = L7
    A0._easy_mark = nil
    return A0
  end
  L3.add_handle = L7
  function L7(A0, A1)
    local L2, L3, L4, L5, L6
    L3 = A1
    L2 = A1.handle
    L2 = L2(L3)
    L3 = A0._easy
    L3 = L3[L2]
    if L3 then
      L3 = A0._easy
      L4 = A0._easy
      L5 = nil
      L6 = A0._easy
      L6 = L6.n
      L6 = L6 - 1
      L4.n = L6
      L3[L2] = L5
    end
    L3 = assert
    L4 = A0._easy
    L4 = L4.n
    L4 = 0 <= L4
    L3(L4)
    L3 = _UPVALUE0_
    L4 = A0
    L5 = L2
    return L3(L4, L5)
  end
  L3.remove_handle = L7
  function L7(A0, ...)
    local L2, L3, L4, L5, L6, L7, L8, L9
    while true do
      L3 = A0
      L2 = A0.handle
      L2 = L2(L3)
      L3 = L2
      L2 = L2.info_read
      L4, L5, L6, L7, L8, L9 = ...
      L2, L3, L4 = L2(L3, L4, L5, L6, L7, L8, L9)
      if not L2 then
        L5 = nil
        L6 = L3
        return L5, L6
      end
      if L2 == 0 then
        return L2
      end
      L5 = A0._easy
      L5 = L5[L2]
      if L5 then
        L6 = (...)
        if L6 then
          L6 = A0._easy
          L7 = A0._easy
          L8 = nil
          L9 = A0._easy
          L9 = L9.n
          L9 = L9 - 1
          L7.n = L9
          L6[L2] = L8
        end
        L6 = L5
        L7 = L3
        L8 = L4
        return L6, L7, L8
      end
    end
  end
  L3.info_read = L7
  L4 = _UPVALUE0_
  L5 = A1.share
  L6 = "LcURL Share"
  L4 = L4(L5, L6)
  L5 = _UPVALUE2_
  L6 = "share"
  L7 = {}
  L8 = A1.LOCK_DATA_COOKIE
  L7.COOKIE = L8
  L8 = A1.LOCK_DATA_DNS
  L7.DNS = L8
  L8 = A1.LOCK_DATA_SSL_SESSION
  L7.SSL_SESSION = L8
  L5 = L5(L6, L7)
  L4.setopt_share = L5
  L5 = assert
  L6 = A0.easy_init
  L6 = L6 == nil
  L5(L6)
  function L5()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.new
    return L0(L1)
  end
  A0.easy_init = L5
  L5 = assert
  L6 = A0.multi_init
  L6 = L6 == nil
  L5(L6)
  function L5()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.new
    return L0(L1)
  end
  A0.multi_init = L5
  L5 = assert
  L6 = A0.share_init
  L6 = L6 == nil
  L5(L6)
  function L5()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.new
    return L0(L1)
  end
  A0.share_init = L5
end
function L11(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = _UPVALUE0_
  L3 = A1.form
  L4 = "LcURL Form"
  L2 = L2(L3, L4)
  function L3(A0, A1)
    local L2, L3, L4
    if A1 then
      L3 = A0
      L2 = A0.add
      L4 = A1
      return L2(L3, L4)
    end
    return A0
  end
  L2.__init = L3
  function L3(A0, A1)
    local L2, L3, L4
    L2 = _UPVALUE0_
    L3 = A0
    L4 = A1
    return L2(L3, L4)
  end
  L2.add = L3
  function L3(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = _UPVALUE0_
    L2 = tostring
    L3 = A0._handle
    L2, L3, L4, L5, L6 = L2(L3)
    L1 = L1(L2, L3, L4, L5, L6)
    L2 = string
    L2 = L2.format
    L3 = "%s %s (%s)"
    L4 = _UPVALUE1_
    L4 = L4._NAME
    L5 = "Form"
    L6 = L1
    return L2(L3, L4, L5, L6)
  end
  L2.__tostring = L3
  L3 = _UPVALUE0_
  L4 = A1.easy
  L5 = "LcURL Easy"
  L3 = L3(L4, L5)
  function L4(A0, A1)
    local L2, L3, L4
    if A1 then
      L3 = A0
      L2 = A0.setopt
      L4 = A1
      return L2(L3, L4)
    end
    return A0
  end
  L3.__init = L4
  L4 = _UPVALUE4_
  L5 = "perform"
  L4 = L4(L5)
  function L5(A0, A1)
    local L2, L3, L4, L5
    if A1 then
      L3 = A0
      L2 = A0.setopt
      L4 = A1
      L2, L3 = L2(L3, L4)
      if not L2 then
        L4 = nil
        L5 = L3
        return L4, L5
      end
    end
    L2 = _UPVALUE0_
    L3 = A0
    return L2(L3)
  end
  L3.perform = L5
  L5 = _UPVALUE4_
  L6 = "setopt_httppost"
  L5 = L5(L6)
  function L6(A0, A1)
    local L2, L3, L4, L5
    L2 = _UPVALUE0_
    L3 = A0
    L5 = A1
    L4 = A1.handle
    L4, L5 = L4(L5)
    return L2(L3, L4, L5)
  end
  L3.setopt_httppost = L6
  L6 = A1.OPT_STREAM_DEPENDS
  if L6 then
    L6 = _UPVALUE4_
    L7 = "setopt_stream_depends"
    L6 = L6(L7)
    function L7(A0, A1)
      local L2, L3, L4, L5
      L2 = _UPVALUE0_
      L3 = A0
      L5 = A1
      L4 = A1.handle
      L4, L5 = L4(L5)
      return L2(L3, L4, L5)
    end
    L3.setopt_stream_depends = L7
    L7 = _UPVALUE4_
    L8 = "setopt_stream_depends_e"
    L7 = L7(L8)
    function L8(A0, A1)
      local L2, L3, L4, L5
      L2 = _UPVALUE0_
      L3 = A0
      L5 = A1
      L4 = A1.handle
      L4, L5 = L4(L5)
      return L2(L3, L4, L5)
    end
    L3.setopt_stream_depends_e = L8
  end
  L6 = _UPVALUE4_
  L7 = "setopt"
  L6 = L6(L7)
  L7 = {}
  L8 = A1.OPT_HTTPPOST
  L8 = L8 or L8
  L7[L8] = "setopt_httppost"
  L8 = A1.OPT_STREAM_DEPENDS
  L8 = L8 or L8
  L7[L8] = "setopt_stream_depends"
  L8 = A1.OPT_STREAM_DEPENDS_E
  L8 = L8 or L8
  L7[L8] = "setopt_stream_depends_e"
  L7[true] = nil
  function L8(A0, A1, A2)
    local L3, L4, L5, L6, L7, L8, L9, L10
    L3 = type
    L4 = A1
    L3 = L3(L4)
    if L3 == "table" then
      L3 = A1
      L4 = nil
      L5 = L3.httppost
      if not L5 then
        L5 = _UPVALUE0_
        L5 = L5.OPT_HTTPPOST
        L5 = L3[L5]
      end
      if L5 then
        L6 = L5._handle
        if L6 then
          L3 = L4 or L3
          if not L4 then
            L6 = _UPVALUE1_
            L7 = L3
            L6 = L6(L7)
            L3 = L6
          end
          L4 = L3
          L6 = L3.httppost
          if L6 then
            L7 = L5
            L6 = L5.handle
            L6 = L6(L7)
            L3.httppost = L6
          end
          L6 = _UPVALUE0_
          L6 = L6.OPT_HTTPPOST
          L6 = L3[L6]
          if L6 then
            L6 = _UPVALUE0_
            L6 = L6.OPT_HTTPPOST
            L8 = L5
            L7 = L5.handle
            L7 = L7(L8)
            L3[L6] = L7
          end
        end
      end
      L6 = L3.stream_depends
      if not L6 then
        L6 = _UPVALUE0_
        L6 = L6.OPT_STREAM_DEPENDS
        L6 = L3[L6]
      end
      if L6 then
        L7 = L6._handle
        if L7 then
          L3 = L4 or L3
          if not L4 then
            L7 = _UPVALUE1_
            L8 = L3
            L7 = L7(L8)
            L3 = L7
          end
          L4 = L3
          L7 = L3.stream_depends
          if L7 then
            L8 = L6
            L7 = L6.handle
            L7 = L7(L8)
            L3.stream_depends = L7
          end
          L7 = _UPVALUE0_
          L7 = L7.OPT_STREAM_DEPENDS
          L7 = L3[L7]
          if L7 then
            L7 = _UPVALUE0_
            L7 = L7.OPT_STREAM_DEPENDS
            L9 = L6
            L8 = L6.handle
            L8 = L8(L9)
            L3[L7] = L8
          end
        end
      end
      L7 = L3.stream_depends_e
      if not L7 then
        L7 = _UPVALUE0_
        L7 = L7.OPT_STREAM_DEPENDS_E
        L7 = L3[L7]
      end
      if L7 then
        L8 = L7._handle
        if L8 then
          L3 = L4 or L3
          if not L4 then
            L8 = _UPVALUE1_
            L9 = L3
            L8 = L8(L9)
            L3 = L8
          end
          L4 = L3
          L8 = L3.stream_depends_e
          if L8 then
            L9 = L7
            L8 = L7.handle
            L8 = L8(L9)
            L3.stream_depends_e = L8
          end
          L8 = _UPVALUE0_
          L8 = L8.OPT_STREAM_DEPENDS_E
          L8 = L3[L8]
          if L8 then
            L8 = _UPVALUE0_
            L8 = L8.OPT_STREAM_DEPENDS_E
            L10 = L7
            L9 = L7.handle
            L9 = L9(L10)
            L3[L8] = L9
          end
        end
      end
      L8 = _UPVALUE2_
      L9 = A0
      L10 = L3
      return L8(L9, L10)
    end
    L3 = _UPVALUE3_
    L3 = L3[A1]
    if L3 then
      L4 = A0[L3]
      L5 = A0
      L6 = A2
      return L4(L5, L6)
    end
    L4 = _UPVALUE2_
    L5 = A0
    L6 = A1
    L7 = A2
    return L4(L5, L6, L7)
  end
  L3.setopt = L8
  function L8(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = _UPVALUE0_
    L2 = tostring
    L3 = A0._handle
    L2, L3, L4, L5, L6 = L2(L3)
    L1 = L1(L2, L3, L4, L5, L6)
    L2 = string
    L2 = L2.format
    L3 = "%s %s (%s)"
    L4 = _UPVALUE1_
    L4 = L4._NAME
    L5 = "Easy"
    L6 = L1
    return L2(L3, L4, L5, L6)
  end
  L3.__tostring = L8
  L4 = _UPVALUE0_
  L5 = A1.multi
  L6 = "LcURL Multi"
  L4 = L4(L5, L6)
  L5 = _UPVALUE4_
  L6 = "add_handle"
  L5 = L5(L6)
  L6 = _UPVALUE4_
  L7 = "remove_handle"
  L6 = L6(L7)
  function L7(A0, A1)
    local L2, L3, L4
    L2 = {}
    L2.n = 0
    A0._easy = L2
    if A1 then
      L3 = A0
      L2 = A0.setopt
      L4 = A1
      L2(L3, L4)
    end
    return A0
  end
  L4.__init = L7
  function L7(A0)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L2 = A0
    L3 = A0.perform
    return L1(L2, L3)
  end
  L4.iperform = L7
  function L7(A0, A1)
    local L2, L3, L4, L5, L6, L7, L8
    L2 = assert
    L3 = A0._easy
    L3 = L3.n
    L3 = 0 <= L3
    L2(L3)
    L3 = A1
    L2 = A1.handle
    L2 = L2(L3)
    L3 = A0._easy
    L3 = L3[L2]
    if L3 then
      L3 = nil
      L4 = _UPVALUE0_
      L4 = L4.error
      L5 = _UPVALUE0_
      L5 = L5.ERROR_MULTI
      L6 = _UPVALUE0_
      L6 = L6.E_MULTI_ADDED_ALREADY
      if not L6 then
        L6 = _UPVALUE0_
        L6 = L6.E_MULTI_BAD_EASY_HANDLE
      end
      L4, L5, L6, L7, L8 = L4(L5, L6)
      return L3, L4, L5, L6, L7, L8
    end
    L3 = _UPVALUE1_
    L4 = A0
    L5 = L2
    L3, L4 = L3(L4, L5)
    if not L3 then
      L5 = nil
      L6 = L4
      return L5, L6
    end
    L5 = A0._easy
    L6 = A0._easy
    L7 = A1
    L8 = A0._easy
    L8 = L8.n
    L8 = L8 + 1
    L6.n = L8
    L5[L2] = L7
    A0._easy_mark = nil
    return A0
  end
  L4.add_handle = L7
  function L7(A0, A1)
    local L2, L3, L4, L5, L6
    L3 = A1
    L2 = A1.handle
    L2 = L2(L3)
    L3 = A0._easy
    L3 = L3[L2]
    if L3 then
      L3 = A0._easy
      L4 = A0._easy
      L5 = nil
      L6 = A0._easy
      L6 = L6.n
      L6 = L6 - 1
      L4.n = L6
      L3[L2] = L5
    end
    L3 = assert
    L4 = A0._easy
    L4 = L4.n
    L4 = 0 <= L4
    L3(L4)
    L3 = _UPVALUE0_
    L4 = A0
    L5 = L2
    return L3(L4, L5)
  end
  L4.remove_handle = L7
  function L7(A0, ...)
    local L2, L3, L4, L5, L6, L7, L8, L9
    while true do
      L3 = A0
      L2 = A0.handle
      L2 = L2(L3)
      L3 = L2
      L2 = L2.info_read
      L4, L5, L6, L7, L8, L9 = ...
      L2, L3, L4 = L2(L3, L4, L5, L6, L7, L8, L9)
      if not L2 then
        L5 = nil
        L6 = L3
        return L5, L6
      end
      if L2 == 0 then
        return L2
      end
      L5 = A0._easy
      L5 = L5[L2]
      if L5 then
        L6 = (...)
        if L6 then
          L6 = A0._easy
          L7 = A0._easy
          L8 = nil
          L9 = A0._easy
          L9 = L9.n
          L9 = L9 - 1
          L7.n = L9
          L6[L2] = L8
        end
        L6 = L5
        L7 = L3
        L8 = L4
        return L6, L7, L8
      end
    end
  end
  L4.info_read = L7
  function L7(...)
    local L1, L2, L3, L4, L5, L6, L7
    L1 = select
    L2 = "#"
    L3, L4, L5, L6, L7 = ...
    L1 = L1(L2, L3, L4, L5, L6, L7)
    L2, L3, L4 = nil, nil, nil
    if 2 <= L1 then
      L5 = true
      L6 = assert
      L7 = ...
      L6, L7 = L6(L7)
      L3 = L7
      L2 = L6
      L4 = L5
    else
      L5 = assert
      L6, L7 = ...
      L5 = L5(L6, L7)
      L2 = L5
      L5 = type
      L6 = L2
      L5 = L5(L6)
      if L5 ~= "function" then
        L5 = true
        L6 = assert
        L7 = L2.socket
        L6 = L6(L7)
        L3 = L2
        L2 = L6
        L4 = L5
      end
    end
    if L4 then
      function L5(...)
        local L1, L2, L3
        L1 = _UPVALUE0_
        L2 = _UPVALUE1_
        L3 = ...
        return L1(L2, L3)
      end
      return L5
    end
    function L5(...)
      local L1, L2
      L1 = _UPVALUE0_
      L2 = ...
      return L1(L2)
    end
    return L5
  end
  function L8(A0, A1)
    local L2, L3, L4
    L2 = setmetatable
    L3 = {}
    L3.value = A0
    L4 = {}
    L4.__mode = "v"
    L2 = L2(L3, L4)
    function L3(A0, ...)
      local L2, L3, L4, L5
      L2 = _UPVALUE0_
      L2 = L2.value
      L2 = L2._easy
      L2 = L2[A0]
      if L2 then
        L3 = _UPVALUE1_
        L4 = L2
        L5 = ...
        return L3(L4, L5)
      end
      L3 = 0
      return L3
    end
    return L3
  end
  L9 = _UPVALUE4_
  L10 = "setopt_socketfunction"
  L9 = L9(L10)
  function L10(A0, ...)
    local L2, L3, L4, L5, L6, L7
    L2 = _UPVALUE0_
    L3, L4, L5, L6, L7 = ...
    L2 = L2(L3, L4, L5, L6, L7)
    L3 = _UPVALUE1_
    L4 = A0
    L5 = _UPVALUE2_
    L6 = A0
    L7 = L2
    L5, L6, L7 = L5(L6, L7)
    return L3(L4, L5, L6, L7)
  end
  L4.setopt_socketfunction = L10
  L10 = _UPVALUE4_
  L11 = "setopt"
  L10 = L10(L11)
  function L11(A0, A1, A2)
    local L3, L4, L5, L6, L7
    L3 = type
    L4 = A1
    L3 = L3(L4)
    if L3 == "table" then
      L3 = A1
      L4 = L3.socketfunction
      if not L4 then
        L4 = _UPVALUE0_
        L4 = L4.OPT_SOCKETFUNCTION
        L4 = L3[L4]
      end
      if L4 then
        L5 = _UPVALUE1_
        L6 = L3
        L5 = L5(L6)
        L3 = L5
        L5 = _UPVALUE2_
        L6 = A0
        L7 = L4
        L5 = L5(L6, L7)
        L6 = L3.socketfunction
        if L6 then
          L3.socketfunction = L5
        end
        L6 = _UPVALUE0_
        L6 = L6.OPT_SOCKETFUNCTION
        L6 = L3[L6]
        if L6 then
          L6 = _UPVALUE0_
          L6 = L6.OPT_SOCKETFUNCTION
          L3[L6] = L5
        end
      end
      L5 = _UPVALUE3_
      L6 = A0
      L7 = L3
      return L5(L6, L7)
    end
    L3 = _UPVALUE0_
    L3 = L3.OPT_SOCKETFUNCTION
    if A1 == L3 then
      L4 = A0
      L3 = A0.setopt_socketfunction
      L5 = A2
      return L3(L4, L5)
    end
    L3 = _UPVALUE3_
    L4 = A0
    L5 = A1
    L6 = A2
    return L3(L4, L5, L6)
  end
  L4.setopt = L11
  function L11(A0)
    local L1, L2, L3, L4, L5, L6
    L1 = _UPVALUE0_
    L2 = tostring
    L3 = A0._handle
    L2, L3, L4, L5, L6 = L2(L3)
    L1 = L1(L2, L3, L4, L5, L6)
    L2 = string
    L2 = L2.format
    L3 = "%s %s (%s)"
    L4 = _UPVALUE1_
    L4 = L4._NAME
    L5 = "Multi"
    L6 = L1
    return L2(L3, L4, L5, L6)
  end
  L4.__tostring = L11
  L5 = setmetatable
  L6 = A0
  L7 = {}
  L7.__index = A1
  L5(L6, L7)
  function L5(...)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.new
    L3 = ...
    return L1(L2, L3)
  end
  A0.form = L5
  function L5(...)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.new
    L3 = ...
    return L1(L2, L3)
  end
  A0.easy = L5
  function L5(...)
    local L1, L2, L3
    L1 = _UPVALUE0_
    L2 = L1
    L1 = L1.new
    L3 = ...
    return L1(L2, L3)
  end
  A0.multi = L5
end
function L12(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L2 = _UPVALUE1_
  L1 = L1(L2)
  L2 = _UPVALUE2_
  L3 = L1
  L4 = A0
  L2(L3, L4)
  L2 = _UPVALUE3_
  L3 = L1
  L4 = A0
  L2(L3, L4)
  return L1
end
return L12
