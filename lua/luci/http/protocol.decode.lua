local L0, L1, L2, L3, L4, L5, L6
L0 = module
L1 = "luci.http.protocol"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0 = L0(L1)
L1 = require
L2 = "luci.ltn12"
L1 = L1(L2)
L2 = 65536
HTTP_MAX_CONTENT = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6
  function L2(A0)
    local L1, L2, L3, L4
    L1 = string
    L1 = L1.char
    L2 = tonumber
    L3 = A0
    L4 = 16
    L2, L3, L4 = L2(L3, L4)
    return L1(L2, L3, L4)
  end
  L3 = type
  L4 = A0
  L3 = L3(L4)
  if L3 == "string" then
    if not A1 then
      L4 = A0
      L3 = A0.gsub
      L5 = "+"
      L6 = " "
      L3 = L3(L4, L5, L6)
      A0 = L3
    end
    L4 = A0
    L3 = A0.gsub
    L5 = "%%([a-fA-F0-9][a-fA-F0-9])"
    L6 = L2
    L3 = L3(L4, L5, L6)
    A0 = L3
  end
  return A0
end
urldecode = L2
function L2(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L2 = A1 or L2
  if not A1 then
    L2 = {}
  end
  if L3 then
    L6 = "%1"
    A0 = L3
  end
  for L6 in L3, L4, L5 do
    L7 = urldecode
    L9 = L6
    L8 = L6.match
    L10 = "^([^=]+)"
    L8, L9, L10, L11 = L8(L9, L10)
    L7 = L7(L8, L9, L10, L11)
    L8 = urldecode
    L10 = L6
    L9 = L6.match
    L11 = "^[^=]+=(.+)$"
    L9, L10, L11 = L9(L10, L11)
    L8 = L8(L9, L10, L11)
    L9 = type
    L10 = L7
    L9 = L9(L10)
    if L9 == "string" then
      L10 = L7
      L9 = L7.len
      L9 = L9(L10)
      if 0 < L9 then
        L9 = type
        L10 = L8
        L9 = L9(L10)
        if L9 ~= "string" then
          L8 = ""
        end
        L9 = L2[L7]
        if not L9 then
          L2[L7] = L8
        else
          L9 = type
          L10 = L2[L7]
          L9 = L9(L10)
          if L9 ~= "table" then
            L9 = {}
            L10 = L2[L7]
            L11 = L8
            L9[1] = L10
            L9[2] = L11
            L2[L7] = L9
          else
            L9 = table
            L9 = L9.insert
            L10 = L2[L7]
            L11 = L8
            L9(L10, L11)
          end
        end
      end
    end
  end
  return L2
end
urldecode_params = L2
function L2(A0)
  local L1, L2, L3, L4, L5
  function L1(A0)
    local L1, L2, L3, L4
    L1 = string
    L1 = L1.format
    L2 = "%%%02x"
    L3 = string
    L3 = L3.byte
    L4 = A0
    L3, L4 = L3(L4)
    return L1(L2, L3, L4)
  end
  L2 = type
  L3 = A0
  L2 = L2(L3)
  if L2 == "string" then
    L3 = A0
    L2 = A0.gsub
    L4 = "([^a-zA-Z0-9$_%-%.%+!*'(),])"
    L5 = L1
    L2 = L2(L3, L4, L5)
    A0 = L2
  end
  return A0
end
urlencode = L2
function L2(A0)
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
xqurlencode = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L1 = ""
  for L5, L6 in L2, L3, L4 do
    if L7 == "table" then
      for L10, L11 in L7, L8, L9 do
        L12 = L1
        L13 = #L1
        if 0 < L13 then
          L13 = "&"
          if L13 then
            goto lbl_23
          end
        end
        L13 = ""
        ::lbl_23::
        L14 = urlencode
        L15 = L5
        L14 = L14(L15)
        L15 = "="
        L16 = xqurlencode
        L17 = L11
        L16 = L16(L17)
        L1 = L12 .. L13 .. L14 .. L15 .. L16
      end
    else
      if 0 < L8 then
        if L8 then
          goto lbl_42
        end
      end
      ::lbl_42::
      L10 = L5
      L10 = "="
      L11 = xqurlencode
      L12 = L6
      L11 = L11(L12)
      L1 = L7 .. L8 .. L9 .. L10 .. L11
    end
  end
  return L1
end
xq_urlencode_params = L2
function L2(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
  L1 = ""
  for L5, L6 in L2, L3, L4 do
    if L7 == "table" then
      for L10, L11 in L7, L8, L9 do
        L12 = L1
        L13 = #L1
        if 0 < L13 then
          L13 = "&"
          if L13 then
            goto lbl_23
          end
        end
        L13 = ""
        ::lbl_23::
        L14 = urlencode
        L15 = L5
        L14 = L14(L15)
        L15 = "="
        L16 = urlencode
        L17 = L11
        L16 = L16(L17)
        L1 = L12 .. L13 .. L14 .. L15 .. L16
      end
    else
      if 0 < L8 then
        if L8 then
          goto lbl_42
        end
      end
      ::lbl_42::
      L10 = L5
      L10 = "="
      L11 = urlencode
      L12 = L6
      L11 = L11(L12)
      L1 = L7 .. L8 .. L9 .. L10 .. L11
    end
  end
  return L1
end
urlencode_params = L2
function L2(A0, A1)
  local L2, L3, L4
  L2 = A0[A1]
  if L2 == nil then
    A0[A1] = ""
  else
    L2 = type
    L3 = A0[A1]
    L2 = L2(L3)
    if L2 == "string" then
      L2 = {}
      L3 = A0[A1]
      L4 = ""
      L2[1] = L3
      L2[2] = L4
      A0[A1] = L2
    else
      L2 = table
      L2 = L2.insert
      L3 = A0[A1]
      L4 = ""
      L2(L3, L4)
    end
  end
end
function L3(A0, A1, A2)
  local L3, L4, L5, L6
  L3 = type
  L4 = A0[A1]
  L3 = L3(L4)
  if L3 == "table" then
    L3 = A0[A1]
    L4 = A0[A1]
    L4 = #L4
    L5 = A0[A1]
    L6 = A0[A1]
    L6 = #L6
    L5 = L5[L6]
    L6 = A2
    L5 = L5 .. L6
    L3[L4] = L5
  else
    L3 = A0[A1]
    L4 = A2
    L3 = L3 .. L4
    A0[A1] = L3
  end
end
function L4(A0, A1, A2)
  local L3, L4, L5, L6, L7
  if A2 then
    L3 = type
    L4 = A0[A1]
    L3 = L3(L4)
    if L3 == "table" then
      L3 = A0[A1]
      L4 = A0[A1]
      L4 = #L4
      L5 = A2
      L6 = A0[A1]
      L7 = A0[A1]
      L7 = #L7
      L6 = L6[L7]
      L5 = L5(L6)
      L3[L4] = L5
    else
      L3 = A2
      L4 = A0[A1]
      L3 = L3(L4)
      A0[A1] = L3
    end
  end
end
L5 = {}
function L6(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10
  if A1 ~= nil then
    L3 = #A1
    if L3 == 0 then
      L3 = true
      L4 = nil
      return L3, L4
    end
    L4 = A1
    L3 = A1.match
    L5 = "^([A-Z]+) ([^ ]+) HTTP/([01]%.[019])$"
    L3, L4, L5 = L3(L4, L5)
    if L3 then
      A0.type = "request"
      L7 = L3
      L6 = L3.lower
      L6 = L6(L7)
      A0.request_method = L6
      A0.request_uri = L4
      L6 = tonumber
      L7 = L5
      L6 = L6(L7)
      A0.http_version = L6
      L6 = {}
      A0.headers = L6
      L6 = true
      function L7(A0)
        local L1, L2, L3
        L1 = _UPVALUE0_
        L1 = L1.headers
        L2 = _UPVALUE1_
        L3 = A0
        return L1(L2, L3)
      end
      return L6, L7
    else
      L7 = A1
      L6 = A1.match
      L8 = "^HTTP/([01]%.[019]) ([0-9]+) ([^\r\n]+)$"
      L6, L7, L8 = L6(L7, L8)
      if L7 then
        A0.type = "response"
        A0.status_code = L7
        A0.status_message = L8
        L9 = tonumber
        L10 = L6
        L9 = L9(L10)
        A0.http_version = L9
        L9 = {}
        A0.headers = L9
        L9 = true
        function L10(A0)
          local L1, L2, L3
          L1 = _UPVALUE0_
          L1 = L1.headers
          L2 = _UPVALUE1_
          L3 = A0
          return L1(L2, L3)
        end
        return L9, L10
      end
    end
  end
  L3 = nil
  L4 = "Invalid HTTP message magic"
  return L3, L4
end
L5.magic = L6
function L6(A0, A1)
  local L2, L3, L4, L5
  if A1 ~= nil then
    L3 = A1
    L2 = A1.match
    L4 = "^([A-Za-z][A-Za-z0-9%-_]+): +(.+)$"
    L2, L3 = L2(L3, L4)
    L4 = type
    L5 = L2
    L4 = L4(L5)
    if L4 == "string" then
      L5 = L2
      L4 = L2.len
      L4 = L4(L5)
      if 0 < L4 then
        L4 = type
        L5 = L3
        L4 = L4(L5)
        if L4 == "string" then
          L5 = L3
          L4 = L3.len
          L4 = L4(L5)
          if 0 < L4 then
            L4 = A0.headers
            L4[L2] = L3
            L4 = true
            L5 = nil
            return L4, L5
        end
      end
    end
    else
      L4 = #A1
      if L4 == 0 then
        L4 = false
        L5 = nil
        return L4, L5
      else
        L4 = nil
        L5 = "Invalid HTTP header received"
        return L4, L5
      end
    end
  else
    L2 = nil
    L3 = "Unexpected EOF"
    return L2, L3
  end
end
L5.headers = L6
function L6(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.source
  L1 = L1.simplify
  function L2()
    local L0, L1, L2, L3, L4, L5, L6
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.receive
    L2 = "*l"
    L0, L1, L2 = L0(L1, L2)
    if L0 == nil then
      if L1 ~= "timeout" then
        L3 = nil
        if L2 then
          L4 = "Line exceeds maximum allowed length"
          if L4 then
            goto lbl_16
          end
        end
        L4 = "Unexpected EOF"
        ::lbl_16::
        return L3, L4
      else
        L3 = nil
        L4 = L1
        return L3, L4
      end
    elseif L0 ~= nil then
      L4 = L0
      L3 = L0.gsub
      L5 = "\r$"
      L6 = ""
      L3 = L3(L4, L5, L6)
      L0 = L3
      L3 = L0
      L4 = nil
      return L3, L4
    end
  end
  return L1(L2)
end
header_source = L6
function L6(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  if A1 then
    L3 = A1.env
    L3 = L3.CONTENT_TYPE
    if L3 then
      L3 = A1.env
      L3 = L3.CONTENT_TYPE
      L4 = L3
      L3 = L3.match
      L5 = "^multipart/form%-data; boundary=(.+)$"
      L3 = L3(L4, L5)
      A1.mime_boundary = L3
    end
  end
  L3 = A1.mime_boundary
  if not L3 then
    L3 = nil
    L4 = "Invalid Content-Type found"
    return L3, L4
  end
  L3 = 0
  L4 = false
  L5, L6, L7 = nil, nil, nil
  function L8(A0, A1)
    local L2, L3, L4, L5, L6
    repeat
      L4 = A0
      L3 = A0.gsub
      L5 = "^([A-Z][A-Za-z0-9%-_]+): +([^\r\n]+)\r\n"
      function L6(A0, A1)
        local L2
        L2 = _UPVALUE0_
        L2 = L2.headers
        L2[A0] = A1
        L2 = ""
        return L2
      end
      L3, L4 = L3(L4, L5, L6)
      L2 = L4
      A0 = L3
    until L2 == 0
    L4 = A0
    L3 = A0.gsub
    L5 = "^\r\n"
    L6 = ""
    L3, L4 = L3(L4, L5, L6)
    L2 = L4
    A0 = L3
    if 0 < L2 then
      L3 = A1.headers
      L3 = L3["Content-Disposition"]
      if L3 then
        L3 = A1.headers
        L3 = L3["Content-Disposition"]
        L4 = L3
        L3 = L3.match
        L5 = "^form%-data; "
        L3 = L3(L4, L5)
        if L3 then
          L3 = A1.headers
          L3 = L3["Content-Disposition"]
          L4 = L3
          L3 = L3.match
          L5 = "name=\"(.-)\""
          L3 = L3(L4, L5)
          A1.name = L3
          L3 = A1.headers
          L3 = L3["Content-Disposition"]
          L4 = L3
          L3 = L3.match
          L5 = "filename=\"(.+)\"$"
          L3 = L3(L4, L5)
          A1.file = L3
        end
      end
      L3 = A1.headers
      L3 = L3["Content-Type"]
      if not L3 then
        L3 = A1.headers
        L3["Content-Type"] = "text/plain"
      end
      L3 = A1.name
      if L3 then
        L3 = A1.file
        if L3 then
          L3 = _UPVALUE0_
          if L3 then
            L3 = _UPVALUE1_
            L4 = _UPVALUE2_
            L4 = L4.params
            L5 = A1.name
            L3(L4, L5)
            L3 = _UPVALUE3_
            L4 = _UPVALUE2_
            L4 = L4.params
            L5 = A1.name
            L6 = A1.file
            L3(L4, L5, L6)
            L3 = _UPVALUE0_
            _UPVALUE4_ = L3
        end
      end
      else
        L3 = A1.name
        if L3 then
          L3 = _UPVALUE1_
          L4 = _UPVALUE2_
          L4 = L4.params
          L5 = A1.name
          L3(L4, L5)
          function L3(A0, A1, A2)
            local L3, L4, L5, L6
            L3 = _UPVALUE0_
            L4 = _UPVALUE1_
            L4 = L4.params
            L5 = _UPVALUE2_
            L5 = L5.name
            L6 = A1
            L3(L4, L5, L6)
          end
          _UPVALUE4_ = L3
        else
          L3 = nil
          _UPVALUE4_ = L3
        end
      end
      L3 = A0
      L4 = true
      return L3, L4
    end
    L3 = A0
    L4 = false
    return L3, L4
  end
  function L9(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
    L1 = _UPVALUE0_
    if A0 then
      L2 = #A0
      if L2 then
        goto lbl_8
      end
    end
    L2 = 0
    ::lbl_8::
    L1 = L1 + L2
    _UPVALUE0_ = L1
    L1 = _UPVALUE1_
    L1 = L1.env
    L1 = L1.CONTENT_LENGTH
    if L1 then
      L1 = _UPVALUE0_
      L2 = tonumber
      L3 = _UPVALUE1_
      L3 = L3.env
      L3 = L3.CONTENT_LENGTH
      L2 = L2(L3)
      L2 = L2 + 2
      if L1 > L2 then
        L1 = nil
        L2 = "Message body size exceeds Content-Length"
        return L1, L2
      end
    end
    if A0 then
      L1 = _UPVALUE2_
      if not L1 then
        L1 = "\r\n"
        L2 = A0
        L1 = L1 .. L2
        _UPVALUE2_ = L1
    end
    else
      L1 = _UPVALUE2_
      if L1 then
        L1 = _UPVALUE2_
        L2 = A0 or L2
        if not A0 then
          L2 = ""
        end
        L1 = L1 .. L2
        L2, L3, L4 = nil, nil, nil
        repeat
          L6 = L1
          L5 = L1.find
          L7 = "\r\n--"
          L8 = _UPVALUE1_
          L8 = L8.mime_boundary
          L9 = "\r\n"
          L7 = L7 .. L8 .. L9
          L8 = 1
          L9 = true
          L5, L6 = L5(L6, L7, L8, L9)
          L3 = L6
          L2 = L5
          if not L2 then
            L6 = L1
            L5 = L1.find
            L7 = "\r\n--"
            L8 = _UPVALUE1_
            L8 = L8.mime_boundary
            L9 = "--\r\n"
            L7 = L7 .. L8 .. L9
            L8 = 1
            L9 = true
            L5, L6 = L5(L6, L7, L8, L9)
            L3 = L6
            L2 = L5
          end
          if L2 then
            L6 = L1
            L5 = L1.sub
            L7 = 1
            L8 = L2 - 1
            L5 = L5(L6, L7, L8)
            L6 = _UPVALUE3_
            if L6 then
              L6 = _UPVALUE4_
              L7 = L5
              L8 = _UPVALUE5_
              L6, L7 = L6(L7, L8)
              eof = L7
              L5 = L6
              L6 = eof
              if not L6 then
                L6 = nil
                L7 = "Invalid MIME section header"
                return L6, L7
              else
                L6 = _UPVALUE5_
                L6 = L6.name
                if not L6 then
                  L6 = nil
                  L7 = "Invalid Content-Disposition header"
                  return L6, L7
                end
              end
            end
            L6 = _UPVALUE6_
            if L6 then
              L6 = _UPVALUE6_
              L7 = _UPVALUE5_
              L8 = L5
              L9 = true
              L6(L7, L8, L9)
            end
            L6 = {}
            L7 = {}
            L6.headers = L7
            _UPVALUE5_ = L6
            L4 = L4 or L4
            L6 = _UPVALUE4_
            L8 = L1
            L7 = L1.sub
            L9 = L3 + 1
            L10 = #L1
            L7 = L7(L8, L9, L10)
            L8 = _UPVALUE5_
            L6, L7 = L6(L7, L8)
            eof = L7
            L1 = L6
            L6 = eof
            L6 = not L6
            _UPVALUE3_ = L6
          end
        until not L2
        if L4 then
          L5 = L1
          L1 = nil
          _UPVALUE2_ = L5
        else
          L5 = _UPVALUE3_
          if L5 then
            L5 = _UPVALUE4_
            L6 = L1
            L7 = _UPVALUE5_
            L5, L6 = L5(L6, L7)
            eof = L6
            _UPVALUE2_ = L5
            L5 = eof
            L5 = not L5
            _UPVALUE3_ = L5
          else
            L5 = _UPVALUE6_
            L6 = _UPVALUE5_
            L7 = _UPVALUE2_
            L8 = false
            L5(L6, L7, L8)
            L5 = A0
            A0 = nil
            _UPVALUE2_ = L5
          end
        end
      end
    end
    L1 = true
    return L1
  end
  L10 = _UPVALUE2_
  L10 = L10.pump
  L10 = L10.all
  L11 = A0
  L12 = L9
  return L10(L11, L12)
end
mimedecode_message_body = L6
function L6(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = 0
  L3 = nil
  function L4(A0)
    local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
    L1 = _UPVALUE0_
    if A0 then
      L2 = #A0
      if L2 then
        goto lbl_8
      end
    end
    L2 = 0
    ::lbl_8::
    L1 = L1 + L2
    _UPVALUE0_ = L1
    L1 = _UPVALUE1_
    L1 = L1.env
    L1 = L1.CONTENT_LENGTH
    if L1 then
      L1 = _UPVALUE0_
      L2 = tonumber
      L3 = _UPVALUE1_
      L3 = L3.env
      L3 = L3.CONTENT_LENGTH
      L2 = L2(L3)
      L2 = L2 + 2
      if L1 > L2 then
        L1 = nil
        L2 = "Message body size exceeds Content-Length"
        return L1, L2
    end
    else
      L1 = _UPVALUE0_
      L2 = HTTP_MAX_CONTENT
      if L1 > L2 then
        L1 = nil
        L2 = "Message body size exceeds maximum allowed length"
        return L1, L2
      end
    end
    L1 = _UPVALUE2_
    if not L1 and A0 then
      _UPVALUE2_ = A0
    else
      L1 = _UPVALUE2_
      if L1 then
        L1 = _UPVALUE2_
        L2 = A0 or L2
        if not A0 then
          L2 = "&"
        end
        L1 = L1 .. L2
        L2, L3 = nil, nil
        repeat
          L5 = L1
          L4 = L1.find
          L6 = "^.-[;&]"
          L4, L5 = L4(L5, L6)
          L3 = L5
          L2 = L4
          if L2 then
            L5 = L1
            L4 = L1.sub
            L6 = L2
            L7 = L3 - 1
            L4 = L4(L5, L6, L7)
            L6 = L4
            L5 = L4.match
            L7 = "^(.-)="
            L5 = L5(L6, L7)
            L7 = L4
            L6 = L4.match
            L8 = "=([^%s]*)%s*$"
            L6 = L6(L7, L8)
            if L5 then
              L7 = #L5
              if 0 < L7 then
                L7 = _UPVALUE3_
                L8 = _UPVALUE1_
                L8 = L8.params
                L9 = L5
                L7(L8, L9)
                L7 = _UPVALUE4_
                L8 = _UPVALUE1_
                L8 = L8.params
                L9 = L5
                L10 = L6
                L7(L8, L9, L10)
                L7 = _UPVALUE5_
                L8 = _UPVALUE1_
                L8 = L8.params
                L9 = L5
                L10 = urldecode
                L7(L8, L9, L10)
            end
            else
              L5 = "invalid_param"
              L7 = _UPVALUE3_
              L8 = _UPVALUE1_
              L8 = L8.params
              L9 = L5
              L7(L8, L9)
              L7 = _UPVALUE4_
              L8 = _UPVALUE1_
              L8 = L8.params
              L9 = L5
              L10 = L4
              L7(L8, L9, L10)
              L7 = _UPVALUE5_
              L8 = _UPVALUE1_
              L8 = L8.params
              L9 = L5
              L10 = urldecode
              L7(L8, L9, L10)
            end
            L8 = L1
            L7 = L1.sub
            L9 = L3 + 1
            L10 = #L1
            L7 = L7(L8, L9, L10)
            L1 = L7
          end
        until not L2
        _UPVALUE2_ = L1
      end
    end
    L1 = true
    return L1
  end
  L5 = _UPVALUE3_
  L5 = L5.pump
  L5 = L5.all
  L6 = A0
  L7 = L4
  return L5(L6, L7)
end
urldecode_message_body = L6
function L6(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L1 = true
  L2 = {}
  L3 = _UPVALUE0_
  L3 = L3.sink
  L3 = L3.simplify
  L3 = L3(L4)
  while L1 do
    err = L5
    L1 = L4
    if not L1 then
      if L4 then
        return L4, L5
    end
    elseif not L1 then
      if L4 ~= "get" then
        if L4 ~= "post" then
          goto lbl_48
        end
      end
      if L4 then
        L2.params = L4
      ::lbl_48::
      else
        L2.params = L4
      end
      L4.CONTENT_LENGTH = L5
      L4.CONTENT_TYPE = L5
      L4.REQUEST_METHOD = L5
      L4.REQUEST_URI = L5
      L7 = "?.+$"
      L8 = ""
      L4.SCRIPT_NAME = L5
      L4.SCRIPT_FILENAME = ""
      L7 = "%.1f"
      L8 = L2.http_version
      L4.SERVER_PROTOCOL = L5
      L7 = "?"
      if L5 then
        L7 = "^.+?"
        L8 = ""
        if L5 then
          goto lbl_96
        end
      end
      ::lbl_96::
      L4.QUERY_STRING = L5
      L2.env = L4
      L7 = "Accept-Charset"
      L8 = "Accept-Encoding"
      L9 = "Accept-Language"
      L10 = "Connection"
      L11 = "Cookie"
      L12 = "Host"
      L13 = "Referer"
      L14 = "User-Agent"
      L15 = "X-Forwarded-For"
      L5[1] = L6
      L5[2] = L7
      L5[3] = L8
      L5[4] = L9
      L5[5] = L10
      L5[6] = L11
      L5[7] = L12
      L5[8] = L13
      L5[9] = L14
      L5[10] = L15
      for L7, L8 in L4, L5, L6 do
        L9 = "HTTP_"
        L11 = L8
        L10 = L8.upper
        L10 = L10(L11)
        L11 = L10
        L10 = L10.gsub
        L12 = "%-"
        L13 = "_"
        L10 = L10(L11, L12, L13)
        L9 = L9 .. L10
        L10 = L2.headers
        L10 = L10[L8]
        L11 = L2.env
        L11[L9] = L10
      end
    end
  end
  return L2
end
parse_message_header = L6
function L6(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = A1.env
  L3 = L3.REQUEST_METHOD
  if L3 == "POST" then
    L3 = A1.env
    L3 = L3.CONTENT_TYPE
    if L3 then
      L3 = A1.env
      L3 = L3.CONTENT_TYPE
      L4 = L3
      L3 = L3.match
      L5 = "^multipart/form%-data"
      L3 = L3(L4, L5)
      if L3 then
        L3 = mimedecode_message_body
        L4 = A0
        L5 = A1
        L6 = A2
        return L3(L4, L5, L6)
    end
  end
  else
    L3 = A1.env
    L3 = L3.REQUEST_METHOD
    if L3 == "POST" then
      L3 = A1.env
      L3 = L3.CONTENT_TYPE
      if L3 then
        L3 = A1.env
        L3 = L3.CONTENT_TYPE
        L4 = L3
        L3 = L3.match
        L5 = "^application/x%-www%-form%-urlencoded"
        L3 = L3(L4, L5)
        if L3 then
          L3 = urldecode_message_body
          L4 = A0
          L5 = A1
          L6 = A2
          return L3(L4, L5, L6)
      end
    end
    else
      L3 = nil
      L4 = type
      L5 = A2
      L4 = L4(L5)
      if L4 == "function" then
        L3 = A2
      else
        A1.content = ""
        A1.content_length = 0
        function L3(A0, A1)
          local L2, L3, L4
          if A0 then
            L2 = _UPVALUE0_
            L2 = L2.content_length
            L3 = #A0
            L2 = L2 + L3
            L3 = HTTP_MAX_CONTENT
            if L2 <= L3 then
              L2 = _UPVALUE0_
              L3 = _UPVALUE0_
              L3 = L3.content
              L4 = A0
              L3 = L3 .. L4
              L2.content = L3
              L2 = _UPVALUE0_
              L3 = _UPVALUE0_
              L3 = L3.content_length
              L4 = #A0
              L3 = L3 + L4
              L2.content_length = L3
              L2 = true
              return L2
            else
              L2 = nil
              L3 = "POST data exceeds maximum allowed length"
              return L2, L3
            end
          end
          L2 = true
          return L2
        end
      end
      while true do
        L4 = _UPVALUE0_
        L4 = L4.pump
        L4 = L4.step
        L5 = A0
        L6 = L3
        L4, L5 = L4(L5, L6)
        if not L4 and L5 then
          L6 = nil
          L7 = L5
          return L6, L7
        elseif not L5 then
          L6 = true
          return L6
        end
      end
      L4 = true
      return L4
    end
  end
end
parse_message_body = L6
L6 = {}
L6[200] = "OK"
L6[206] = "Partial Content"
L6[301] = "Moved Permanently"
L6[302] = "Found"
L6[304] = "Not Modified"
L6[400] = "Bad Request"
L6[403] = "Forbidden"
L6[404] = "Not Found"
L6[405] = "Method Not Allowed"
L6[408] = "Request Time-out"
L6[411] = "Length Required"
L6[412] = "Precondition Failed"
L6[416] = "Requested range not satisfiable"
L6[500] = "Internal Server Error"
L6[503] = "Server Unavailable"
statusmsg = L6
