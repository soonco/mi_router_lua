local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17
L0 = require
L1 = "luci.ltn12"
L0 = L0(L1)
L1 = require
L2 = "luci.http.protocol"
L1 = L1(L2)
L2 = require
L3 = "luci.util"
L2 = L2(L3)
L3 = require
L4 = "string"
L3 = L3(L4)
L4 = require
L5 = "coroutine"
L4 = L4(L5)
L5 = require
L6 = "table"
L5 = L5(L6)
L6 = require
L7 = "xiaoqiang.util.XQSecureUtil"
L6 = L6(L7)
L7 = require
L8 = "xiaoqiang.util.XQParam"
L7 = L7(L8)
L8 = require
L9 = "xiaoqiang.XQLog"
L8 = L8(L9)
L9 = ipairs
L10 = pairs
L11 = next
L12 = type
L13 = tostring
L14 = error
L15 = module
L16 = "luci.http"
L17 = package
L17 = L17.seeall
L15(L16, L17)
L15 = L2.threadlocal
L15 = L15()
context = L15
L15 = L2.class
L15 = L15()
Request = L15
L15 = Request
function L16(A0, A1, A2, A3)
  local L4, L5, L6
  A0.input = A2
  A0.error = A3
  function L4()
    local L0, L1
  end
  A0.filehandler = L4
  L4 = {}
  L4.env = A1
  L5 = {}
  L4.headers = L5
  L5 = _UPVALUE0_
  L5 = L5.urldecode_params
  L6 = A1.QUERY_STRING
  L6 = L6 or L6
  L5 = L5(L6)
  L4.params = L5
  A0.message = L4
  A0.parsed_input = false
end
L15.__init__ = L16
L15 = Request
function L16(A0, A1, A2)
  local L3, L4
  if not A2 then
    L3 = A0.parsed_input
    if not L3 then
      L4 = A0
      L3 = A0._parse_input
      L3(L4)
    end
  end
  if A1 then
    L3 = A0.message
    L3 = L3.params
    L3 = L3[A1]
    return L3
  else
    L3 = A0.message
    L3 = L3.params
    return L3
  end
end
L15.formvalue = L16
L15 = Request
function L16(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
  L2 = {}
  if A1 then
    L3 = A1
    L3 = L3 .. L4
    if L3 then
      goto lbl_10
      A1 = L3 or A1
    end
  end
  A1 = "."
  ::lbl_10::
  L3 = A0.parsed_input
  if not L3 then
    L3 = A0._parse_input
    L3(L4)
  end
  L3 = A0.message
  L3 = L3.params
  L3 = L3[nil]
  for L7, L8 in L4, L5, L6 do
    L10 = L7
    L9 = L7.find
    L11 = A1
    L12 = 1
    L13 = true
    L9 = L9(L10, L11, L12, L13)
    if L9 == 1 then
      L10 = L7
      L9 = L7.sub
      L11 = #A1
      L11 = L11 + 1
      L9 = L9(L10, L11)
      L10 = _UPVALUE1_
      L11 = L8
      L10 = L10(L11)
      L2[L9] = L10
    end
  end
  return L2
end
L15.formvaluetable = L16
L15 = Request
function L16(A0)
  local L1, L2
  L1 = A0.parsed_input
  if not L1 then
    L2 = A0
    L1 = A0._parse_input
    L1(L2)
  end
  L1 = A0.message
  L1 = L1.content
  L2 = A0.message
  L2 = L2.content_length
  return L1, L2
end
L15.content = L16
L15 = Request
function L16(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = _UPVALUE0_
  L2 = L2.gsub
  L3 = ";"
  L5 = A0
  L4 = A0.getenv
  L6 = "HTTP_COOKIE"
  L4 = L4(L5, L6)
  L4 = L4 or L4
  L5 = ";"
  L3 = L3 .. L4 .. L5
  L4 = "%s*;%s*"
  L5 = ";"
  L2 = L2(L3, L4, L5)
  L3 = ";"
  L4 = A1
  L5 = "=(.-);"
  L3 = L3 .. L4 .. L5
  L5 = L2
  L4 = L2.find
  L6 = L3
  L4, L5, L6 = L4(L5, L6)
  L7 = L6 or L7
  if L6 then
    L7 = urldecode
    L8 = L6
    L7 = L7(L8)
  end
  return L7
end
L15.getcookie = L16
L15 = Request
function L16(A0, A1)
  local L2
  if A1 then
    L2 = A0.message
    L2 = L2.env
    L2 = L2[A1]
    return L2
  else
    L2 = A0.message
    L2 = L2.env
    return L2
  end
end
L15.getenv = L16
L15 = Request
function L16(A0, A1)
  A0.filehandler = A1
end
L15.setfilehandler = L16
L15 = Request
function L16(A0)
  local L1, L2, L3, L4
  L1 = _UPVALUE0_
  L1 = L1.parse_message_body
  L2 = A0.input
  L3 = A0.message
  L4 = A0.filehandler
  L1(L2, L3, L4)
  A0.parsed_input = true
end
L15._parse_input = L16
function L15()
  local L0, L1
  L0 = context
  L0 = L0.eoh
  if not L0 then
    L0 = context
    L0.eoh = true
    L0 = _UPVALUE0_
    L0 = L0.yield
    L1 = 3
    L0(L1)
  end
  L0 = context
  L0 = L0.closed
  if not L0 then
    L0 = context
    L0.closed = true
    L0 = _UPVALUE0_
    L0 = L0.yield
    L1 = 5
    L0(L1)
  end
end
close = L15
function L15()
  local L0, L1
  L0 = context
  L0 = L0.request
  L1 = L0
  L0 = L0.content
  return L0(L1)
end
content = L15
function L15(A0, A1)
  local L2, L3, L4, L5
  L2 = context
  L2 = L2.request
  L3 = L2
  L2 = L2.formvalue
  L4 = A0
  L5 = A1
  return L2(L3, L4, L5)
end
formvalue_unsafe = L15
function L15(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = context
  L3 = L3.request
  L4 = L3
  L3 = L3.formvalue
  L5 = A0
  L6 = A1
  L3 = L3(L4, L5, L6)
  if A2 then
    L4 = _UPVALUE0_
    L4 = L4.verify
    L5 = L3
    L6 = A2
    L4 = L4(L5, L6)
    if L4 == false then
      L4 = _UPVALUE1_
      L4 = L4.log
      L5 = 3
      L6 = "verify false key:"
      L7 = A0
      L8 = " val:"
      L6 = L6 .. L7 .. L8
      L7 = L3
      L4(L5, L6, L7)
      L3 = nil
    end
    return L3
  else
    L4 = _UPVALUE2_
    L4 = L4.hackCheck
    L5 = A0
    L6 = L3
    return L4(L5, L6)
  end
end
formvalue = L15
function L15(A0, A1)
  local L2, L3, L4, L5
  L2 = context
  L2 = L2.request
  L3 = L2
  L2 = L2.formvalue
  L4 = A0
  L5 = A1
  L2 = L2(L3, L4, L5)
  L3 = _UPVALUE0_
  L3 = L3.xssCheck
  L4 = L2
  return L3(L4)
end
xqformvalue = L15
function L15(A0)
  local L1, L2, L3
  L1 = context
  L1 = L1.request
  L2 = L1
  L1 = L1.formvaluetable
  L3 = A0
  return L1(L2, L3)
end
formvaluetable = L15
function L15(A0)
  local L1, L2, L3
  L1 = context
  L1 = L1.request
  L2 = L1
  L1 = L1.getcookie
  L3 = A0
  return L1(L2, L3)
end
getcookie = L15
function L15(A0)
  local L1, L2, L3
  L1 = context
  L1 = L1.request
  L2 = L1
  L1 = L1.getenv
  L3 = A0
  return L1(L2, L3)
end
getenv = L15
function L15(A0)
  local L1, L2, L3
  L1 = context
  L1 = L1.request
  L2 = L1
  L1 = L1.setfilehandler
  L3 = A0
  return L1(L2, L3)
end
setfilehandler = L15
function L15(A0, A1)
  local L2, L3, L4, L5
  L2 = context
  L2 = L2.headers
  if not L2 then
    L2 = context
    L3 = {}
    L2.headers = L3
  end
  L2 = context
  L2 = L2.headers
  L4 = A0
  L3 = A0.lower
  L3 = L3(L4)
  L2[L3] = A1
  L2 = _UPVALUE0_
  L2 = L2.yield
  L3 = 2
  L4 = A0
  L5 = A1
  L2(L3, L4, L5)
end
header = L15
function L15(A0)
  local L1, L2, L3, L4, L5
  L1 = context
  L1 = L1.headers
  if L1 then
    L1 = context
    L1 = L1.headers
    L1 = L1["content-type"]
    if L1 then
      goto lbl_36
    end
  end
  if A0 == "application/xhtml+xml" then
    L1 = getenv
    L2 = "HTTP_ACCEPT"
    L1 = L1(L2)
    if L1 then
      L1 = getenv
      L2 = "HTTP_ACCEPT"
      L1 = L1(L2)
      L2 = L1
      L1 = L1.find
      L3 = "application/xhtml+xml"
      L4 = nil
      L5 = true
      L1 = L1(L2, L3, L4, L5)
      if L1 then
        goto lbl_28
      end
    end
    A0 = "text/html; charset=UTF-8"
    ::lbl_28::
    L1 = header
    L2 = "Vary"
    L3 = "Accept"
    L1(L2, L3)
  end
  L1 = header
  L2 = "Content-Type"
  L3 = A0
  L1(L2, L3)
  ::lbl_36::
end
prepare_content = L15
function L15()
  local L0, L1
  L0 = context
  L0 = L0.request
  L0 = L0.input
  return L0
end
source = L15
function L15(A0, A1)
  local L2, L3, L4, L5
  A0 = A0 or A0
  A1 = A1 or A1
  L2 = context
  L2.status = A0
  L2 = _UPVALUE0_
  L2 = L2.yield
  L3 = 1
  L4 = A0
  L5 = A1
  L2(L3, L4, L5)
end
status = L15
function L15(A0, A1, A2, A3)
  local L4, L5, L6, L7, L8
  if not A0 then
    if A1 then
      L4 = _UPVALUE0_
      L5 = A1
      L4(L5)
    else
      L4 = close
      L4()
    end
    L4 = true
    return L4
  else
    L4 = #A0
    if L4 == 0 then
      L4 = true
      return L4
    else
      L4 = context
      L4 = L4.eoh
      if not L4 then
        L4 = context
        L4 = L4.status
        if not L4 then
          L4 = status
          L4()
        end
        L4 = context
        L4 = L4.headers
        if L4 then
          L4 = context
          L4 = L4.headers
          L4 = L4["content-type"]
          if L4 then
            goto lbl_50
          end
        end
        if A2 then
          L4 = header
          L5 = "Content-Type"
          L6 = "text/javascript; charset=utf-8"
          L4(L5, L6)
        else
          L4 = header
          L5 = "Content-Type"
          L6 = "text/html; charset=utf-8"
          L4(L5, L6)
        end
        ::lbl_50::
        L4 = context
        L4 = L4.headers
        L4 = L4["cache-control"]
        if not L4 then
          L4 = header
          L5 = "Cache-Control"
          L6 = "no-cache"
          L4(L5, L6)
          L4 = header
          L5 = "Expires"
          L6 = "0"
          L4(L5, L6)
        end
        if A3 then
          L4 = context
          L4 = L4.headers
          L4 = L4["Content-Length"]
          if not L4 then
            L4 = header
            L5 = "Content-Length"
            L6 = _UPVALUE1_
            L7 = _UPVALUE2_
            L7 = L7.len
            L8 = A0
            L7, L8 = L7(L8)
            L6, L7, L8 = L6(L7, L8)
            L4(L5, L6, L7, L8)
          end
        end
        L4 = context
        L4.eoh = true
        L4 = _UPVALUE3_
        L4 = L4.yield
        L5 = 3
        L4(L5)
      end
      L4 = _UPVALUE3_
      L4 = L4.yield
      L5 = 4
      L6 = A0
      L4(L5, L6)
      L4 = true
      return L4
    end
  end
end
write = L15
function L15(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = 4194304
  L2 = io
  L2 = L2.open
  L3 = A0
  L4 = "r"
  L2 = L2(L3, L4)
  if not L2 then
    L3 = status
    L4 = 404
    L5 = "Not Found"
    L3(L4, L5)
    L3 = close
    L3()
    return
  end
  L4 = L2
  L3 = L2.seek
  L5 = "end"
  L3 = L3(L4, L5)
  L5 = L2
  L4 = L2.seek
  L6 = "set"
  L4(L5, L6)
  L4 = context
  L4 = L4.status
  if not L4 then
    L4 = status
    L4()
  end
  L4 = header
  L5 = "Content-Type"
  L6 = "text/plain; charset=utf-8"
  L4(L5, L6)
  L4 = header
  L5 = "Content-Length"
  L6 = _UPVALUE0_
  L7 = L3
  L6, L7, L8 = L6(L7)
  L4(L5, L6, L7, L8)
  L4 = header
  L5 = "Cache-Control"
  L6 = "no-cache"
  L4(L5, L6)
  L4 = header
  L5 = "Expires"
  L6 = "0"
  L4(L5, L6)
  L4 = context
  L4.eoh = true
  L4 = _UPVALUE1_
  L4 = L4.yield
  L5 = 3
  L4(L5)
  while true do
    L5 = L2
    L4 = L2.read
    L6 = 0
    L4 = L4(L5, L6)
    if not L4 then
      break
    end
    L4 = _UPVALUE1_
    L4 = L4.yield
    L5 = 4
    L7 = L2
    L6 = L2.read
    L8 = L1
    L6, L7, L8 = L6(L7, L8)
    L4(L5, L6, L7, L8)
  end
  L5 = L2
  L4 = L2.close
  L4(L5)
  L4 = close
  L4()
end
write_file = L15
function L15(A0, A1)
  local L2, L3, L4, L5
  L2 = _UPVALUE0_
  L2 = L2.yield
  L3 = 6
  L4 = A0
  L5 = A1
  L2(L3, L4, L5)
end
splice = L15
function L15(A0)
  local L1, L2, L3
  L1 = status
  L2 = 302
  L3 = "Found"
  L1(L2, L3)
  L1 = header
  L2 = "Location"
  L3 = A0
  L1(L2, L3)
  L1 = close
  L1()
end
redirect = L15
function L15(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = {}
  L1[1] = L2
  for L5, L6 in L2, L3, L4 do
    L7 = #L1
    if 1 < L7 then
      L7 = #L1
      L7 = L7 + 1
      L1[L7] = "&"
    end
    L7 = #L1
    L7 = L7 + 1
    L8 = urldecode
    L9 = L5
    L8 = L8(L9)
    L1[L7] = L8
    L7 = #L1
    L7 = L7 + 1
    L1[L7] = "="
    L7 = #L1
    L7 = L7 + 1
    L8 = urldecode
    L9 = L6
    L8 = L8(L9)
    L1[L7] = L8
  end
  return L2(L3, L4)
end
build_querystring = L15
L15 = L1.urldecode
urldecode = L15
L15 = L1.urlencode
urlencode = L15
function L15(A0)
  local L1, L2, L3, L4, L5, L6
  if A0 == nil then
    L1 = write
    L2 = "null"
    L1(L2)
  else
    L1 = _UPVALUE0_
    L2 = A0
    L1 = L1(L2)
    if L1 == "table" then
      L1 = require
      L2 = "luci.json"
      L1 = L1(L2)
      L2 = write
      L3 = L1.encode
      L4 = A0
      L3 = L3(L4)
      L4 = nil
      L5 = false
      L6 = true
      L2(L3, L4, L5, L6)
    else
      L1 = _UPVALUE0_
      L2 = A0
      L1 = L1(L2)
      if L1 ~= "number" then
        L1 = _UPVALUE0_
        L2 = A0
        L1 = L1(L2)
        if L1 ~= "boolean" then
          goto lbl_46
        end
      end
      if A0 ~= A0 then
        L1 = write
        L2 = "Number.NaN"
        L1(L2)
      else
        L1 = write
        L2 = _UPVALUE1_
        L3 = A0
        L2, L3, L4, L5, L6 = L2(L3)
        L1(L2, L3, L4, L5, L6)
        goto lbl_56
        ::lbl_46::
        L1 = write
        L2 = _UPVALUE1_
        L3 = A0
        L2 = L2(L3)
        L3 = L2
        L2 = L2.gsub
        L4 = "[\"%z\001-\031]"
        function L5(A0)
          local L1, L2, L3
          L2 = A0
          L1 = A0.byte
          L3 = 1
          L1 = L1(L2, L3)
          L1 = "\\u%04x" % L1
          return L1
        end
        L2 = L2(L3, L4, L5)
        L2 = "\"%s\"" % L2
        L1(L2)
      end
    end
  end
  ::lbl_56::
end
writeJsonNoLog = L15
function L15(A0)
  local L1, L2, L3, L4
  L1 = require
  L2 = "xiaoqiang.XQLog"
  L1 = L1(L2)
  L2 = L1.log
  L3 = 7
  L4 = A0
  L2(L3, L4)
  L2 = writeJsonNoLog
  L3 = A0
  L2(L3)
end
write_json = L15
function L15(A0, A1)
  local L2, L3, L4, L5, L6, L7
  if A0 == nil then
    L2 = write
    L3 = "null"
    L2(L3)
  else
    L2 = _UPVALUE0_
    L3 = A0
    L2 = L2(L3)
    if L2 == "table" then
      L2 = require
      L3 = "luci.json"
      L2 = L2(L3)
      if A1 then
        L3 = write
        L4 = A1
        L5 = "("
        L6 = L2.encode
        L7 = A0
        L6 = L6(L7)
        L7 = ");"
        L4 = L4 .. L5 .. L6 .. L7
        L5 = nil
        L6 = true
        L3(L4, L5, L6)
      else
        L3 = write
        L4 = "jsonpHandler("
        L5 = L2.encode
        L6 = A0
        L5 = L5(L6)
        L6 = ");"
        L4 = L4 .. L5 .. L6
        L5 = nil
        L6 = true
        L3(L4, L5, L6)
      end
    else
      L2 = _UPVALUE0_
      L3 = A0
      L2 = L2(L3)
      if L2 ~= "number" then
        L2 = _UPVALUE0_
        L3 = A0
        L2 = L2(L3)
        if L2 ~= "boolean" then
          goto lbl_62
        end
      end
      if A0 ~= A0 then
        L2 = write
        L3 = "Number.NaN"
        L2(L3)
      else
        L2 = write
        L3 = _UPVALUE1_
        L4 = A0
        L3, L4, L5, L6, L7 = L3(L4)
        L2(L3, L4, L5, L6, L7)
        goto lbl_91
        ::lbl_62::
        if A1 then
          L2 = write
          L3 = A1
          L4 = _UPVALUE1_
          L5 = A0
          L4 = L4(L5)
          L5 = L4
          L4 = L4.gsub
          L6 = "[\"%z\001-\031]"
          function L7(A0)
            local L1, L2, L3
            L2 = A0
            L1 = A0.byte
            L3 = 1
            L1 = L1(L2, L3)
            L1 = "\\u%04x" % L1
            return L1
          end
          L4 = L4(L5, L6, L7)
          L4 = "(\"%s\");" % L4
          L3 = L3 .. L4
          L4 = nil
          L5 = true
          L2(L3, L4, L5)
        else
          L2 = write
          L3 = _UPVALUE1_
          L4 = A0
          L3 = L3(L4)
          L4 = L3
          L3 = L3.gsub
          L5 = "[\"%z\001-\031]"
          function L6(A0)
            local L1, L2, L3
            L2 = A0
            L1 = A0.byte
            L3 = 1
            L1 = L1(L2, L3)
            L1 = "\\u%04x" % L1
            return L1
          end
          L3 = L3(L4, L5, L6)
          L3 = "jsonpHandler(\"%s\");" % L3
          L4 = nil
          L5 = true
          L2(L3, L4, L5)
        end
      end
    end
  end
  ::lbl_91::
end
write_jsonp = L15
