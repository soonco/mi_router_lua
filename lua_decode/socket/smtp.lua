local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20, L21, L22
L0 = _G
L1 = require
L2 = "coroutine"
L1 = L1(L2)
L2 = require
L3 = "string"
L2 = L2(L3)
L3 = require
L4 = "math"
L3 = L3(L4)
L4 = require
L5 = "os"
L4 = L4(L5)
L5 = require
L6 = "socket"
L5 = L5(L6)
L6 = require
L7 = "socket.tp"
L6 = L6(L7)
L7 = require
L8 = "ltn12"
L7 = L7(L8)
L8 = require
L9 = "socket.headers"
L8 = L8(L9)
L9 = require
L10 = "mime"
L9 = L9(L10)
L10 = {}
L5.smtp = L10
L10 = L5.smtp
L10.TIMEOUT = 60
L10.SERVER = "localhost"
L10.PORT = 25
L11 = L4.getenv
L12 = "SERVER_NAME"
L11 = L11(L12)
L11 = L11 or L11
L10.DOMAIN = L11
L10.ZONE = "-0000"
L11 = {}
L12 = {}
L11.__index = L12
L12 = L11.__index
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = A0.try
  L3 = A0.tp
  L4 = L3
  L3 = L3.check
  L5 = "2.."
  L3, L4, L5, L6, L7 = L3(L4, L5)
  L2(L3, L4, L5, L6, L7)
  L2 = A0.try
  L3 = A0.tp
  L4 = L3
  L3 = L3.command
  L5 = "EHLO"
  L6 = A1 or L6
  if not A1 then
    L6 = _UPVALUE0_
    L6 = L6.DOMAIN
  end
  L3, L4, L5, L6, L7 = L3(L4, L5, L6)
  L2(L3, L4, L5, L6, L7)
  L2 = _UPVALUE1_
  L2 = L2.skip
  L3 = 1
  L4 = A0.try
  L5 = A0.tp
  L6 = L5
  L5 = L5.check
  L7 = "2.."
  L5, L6, L7 = L5(L6, L7)
  L4, L5, L6, L7 = L4(L5, L6, L7)
  return L2(L3, L4, L5, L6, L7)
end
L12.greet = L13
L12 = L11.__index
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = A0.try
  L3 = A0.tp
  L4 = L3
  L3 = L3.command
  L5 = "MAIL"
  L6 = "FROM:"
  L7 = A1
  L6 = L6 .. L7
  L3, L4, L5, L6, L7 = L3(L4, L5, L6)
  L2(L3, L4, L5, L6, L7)
  L2 = A0.try
  L3 = A0.tp
  L4 = L3
  L3 = L3.check
  L5 = "2.."
  L3, L4, L5, L6, L7 = L3(L4, L5)
  return L2(L3, L4, L5, L6, L7)
end
L12.mail = L13
L12 = L11.__index
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7
  L2 = A0.try
  L3 = A0.tp
  L4 = L3
  L3 = L3.command
  L5 = "RCPT"
  L6 = "TO:"
  L7 = A1
  L6 = L6 .. L7
  L3, L4, L5, L6, L7 = L3(L4, L5, L6)
  L2(L3, L4, L5, L6, L7)
  L2 = A0.try
  L3 = A0.tp
  L4 = L3
  L3 = L3.check
  L5 = "2.."
  L3, L4, L5, L6, L7 = L3(L4, L5)
  return L2(L3, L4, L5, L6, L7)
end
L12.rcpt = L13
L12 = L11.__index
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.command
  L6 = "DATA"
  L4, L5, L6, L7 = L4(L5, L6)
  L3(L4, L5, L6, L7)
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.check
  L6 = "3.."
  L4, L5, L6, L7 = L4(L5, L6)
  L3(L4, L5, L6, L7)
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.source
  L6 = A1
  L7 = A2
  L4, L5, L6, L7 = L4(L5, L6, L7)
  L3(L4, L5, L6, L7)
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.send
  L6 = "\r\n.\r\n"
  L4, L5, L6, L7 = L4(L5, L6)
  L3(L4, L5, L6, L7)
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.check
  L6 = "2.."
  L4, L5, L6, L7 = L4(L5, L6)
  return L3(L4, L5, L6, L7)
end
L12.data = L13
L12 = L11.__index
function L13(A0)
  local L1, L2, L3, L4
  L1 = A0.try
  L2 = A0.tp
  L3 = L2
  L2 = L2.command
  L4 = "QUIT"
  L2, L3, L4 = L2(L3, L4)
  L1(L2, L3, L4)
  L1 = A0.try
  L2 = A0.tp
  L3 = L2
  L2 = L2.check
  L4 = "2.."
  L2, L3, L4 = L2(L3, L4)
  return L1(L2, L3, L4)
end
L12.quit = L13
L12 = L11.__index
function L13(A0)
  local L1, L2
  L1 = A0.tp
  L2 = L1
  L1 = L1.close
  return L1(L2)
end
L12.close = L13
L12 = L11.__index
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.command
  L6 = "AUTH"
  L7 = "LOGIN"
  L4, L5, L6, L7 = L4(L5, L6, L7)
  L3(L4, L5, L6, L7)
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.check
  L6 = "3.."
  L4, L5, L6, L7 = L4(L5, L6)
  L3(L4, L5, L6, L7)
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.send
  L6 = _UPVALUE0_
  L6 = L6.b64
  L7 = A1
  L6 = L6(L7)
  L7 = "\r\n"
  L6 = L6 .. L7
  L4, L5, L6, L7 = L4(L5, L6)
  L3(L4, L5, L6, L7)
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.check
  L6 = "3.."
  L4, L5, L6, L7 = L4(L5, L6)
  L3(L4, L5, L6, L7)
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.send
  L6 = _UPVALUE0_
  L6 = L6.b64
  L7 = A2
  L6 = L6(L7)
  L7 = "\r\n"
  L6 = L6 .. L7
  L4, L5, L6, L7 = L4(L5, L6)
  L3(L4, L5, L6, L7)
  L3 = A0.try
  L4 = A0.tp
  L5 = L4
  L4 = L4.check
  L6 = "2.."
  L4, L5, L6, L7 = L4(L5, L6)
  return L3(L4, L5, L6, L7)
end
L12.login = L13
L12 = L11.__index
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = "PLAIN "
  L4 = _UPVALUE0_
  L4 = L4.b64
  L5 = "\000"
  L6 = A1
  L7 = "\000"
  L8 = A2
  L5 = L5 .. L6 .. L7 .. L8
  L4 = L4(L5)
  L3 = L3 .. L4
  L4 = A0.try
  L5 = A0.tp
  L6 = L5
  L5 = L5.command
  L7 = "AUTH"
  L8 = L3
  L5, L6, L7, L8 = L5(L6, L7, L8)
  L4(L5, L6, L7, L8)
  L4 = A0.try
  L5 = A0.tp
  L6 = L5
  L5 = L5.check
  L7 = "2.."
  L5, L6, L7, L8 = L5(L6, L7)
  return L4(L5, L6, L7, L8)
end
L12.plain = L13
L12 = L11.__index
function L13(A0, A1, A2, A3)
  local L4, L5, L6, L7
  if not A1 or not A2 then
    L4 = 1
    return L4
  end
  L4 = _UPVALUE0_
  L4 = L4.find
  L5 = A3
  L6 = [[
AUTH[^
]+LOGIN]]
  L4 = L4(L5, L6)
  if L4 then
    L5 = A0
    L4 = A0.login
    L6 = A1
    L7 = A2
    return L4(L5, L6, L7)
  else
    L4 = _UPVALUE0_
    L4 = L4.find
    L5 = A3
    L6 = [[
AUTH[^
]+PLAIN]]
    L4 = L4(L5, L6)
    if L4 then
      L5 = A0
      L4 = A0.plain
      L6 = A1
      L7 = A2
      return L4(L5, L6, L7)
    else
      L4 = A0.try
      L5 = nil
      L6 = "authentication not supported"
      L4(L5, L6)
    end
  end
end
L12.auth = L13
L12 = L11.__index
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9
  L2(L3, L4)
  if L2 == "table" then
    for L5, L6 in L2, L3, L4 do
      L8 = A0
      L7 = A0.rcpt
      L9 = L6
      L7(L8, L9)
    end
  else
    L2(L3, L4)
  end
  L5 = A1.source
  L6 = _UPVALUE2_
  L6 = L6.stuff
  L6, L7, L8, L9 = L6()
  L5 = A1.step
  L2(L3, L4, L5)
end
L12.send = L13
function L12(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = _UPVALUE0_
  L3 = L3.try
  L4 = _UPVALUE1_
  L4 = L4.connect
  L5 = A0 or L5
  if not A0 then
    L5 = _UPVALUE2_
    L5 = L5.SERVER
  end
  L6 = A1 or L6
  if not A1 then
    L6 = _UPVALUE2_
    L6 = L6.PORT
  end
  L7 = _UPVALUE2_
  L7 = L7.TIMEOUT
  L8 = A2
  L4, L5, L6, L7, L8 = L4(L5, L6, L7, L8)
  L3 = L3(L4, L5, L6, L7, L8)
  L4 = _UPVALUE3_
  L4 = L4.setmetatable
  L5 = {}
  L5.tp = L3
  L6 = _UPVALUE4_
  L4 = L4(L5, L6)
  L5 = _UPVALUE0_
  L5 = L5.newtry
  function L6()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = L0
    L0 = L0.close
    L0(L1)
  end
  L5 = L5(L6)
  L4.try = L5
  return L4
end
L10.open = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = {}
  if not A0 then
  end
  for L5, L6 in L2, L3, L4 do
    L7 = _UPVALUE1_
    L7 = L7.lower
    L8 = L5
    L7 = L7(L8)
    L1[L7] = L6
  end
  return L1
end
L13 = 0
function L14()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L0 = L0 + 1
  _UPVALUE0_ = L0
  L0 = _UPVALUE1_
  L0 = L0.format
  L1 = "%s%05d==%05u"
  L2 = _UPVALUE2_
  L2 = L2.date
  L3 = "%d%m%Y%H%M%S"
  L2 = L2(L3)
  L3 = _UPVALUE3_
  L3 = L3.random
  L4 = 0
  L5 = 99999
  L3 = L3(L4, L5)
  L4 = _UPVALUE0_
  return L0(L1, L2, L3, L4)
end
L15 = nil
function L16(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L1 = _UPVALUE0_
  L1 = L1.canonic
  L2 = "\r\n"
  for L6, L7 in L3, L4, L5 do
    L8 = L1[L6]
    L8 = L8 or L8
    L9 = ": "
    L10 = L7
    L11 = "\r\n"
    L12 = L2
    L2 = L8 .. L9 .. L10 .. L11 .. L12
  end
  L3(L4)
end
function L17(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = _UPVALUE0_
  L1 = L1()
  L2 = _UPVALUE1_
  L2 = L2(L3)
  L2["content-type"] = L3
  L6 = "\""
  L2["content-type"] = L3
  L3(L4)
  if L3 then
    L3(L4)
    L3(L4)
  end
  for L6, L7 in L3, L4, L5 do
    L8 = _UPVALUE3_
    L8 = L8.yield
    L9 = "\r\n--"
    L10 = L1
    L11 = "\r\n"
    L9 = L9 .. L10 .. L11
    L8(L9)
    L8 = _UPVALUE5_
    L9 = L7
    L8(L9)
  end
  L6 = "--\r\n\r\n"
  L3(L4)
  if L3 then
    L3(L4)
    L3(L4)
  end
end
function L18(A0)
  local L1, L2, L3, L4, L5, L6
  L1 = _UPVALUE0_
  L2 = A0.headers
  L2 = L2 or L2
  L1 = L1(L2)
  L2 = L1["content-type"]
  L2 = L2 or L2
  L1["content-type"] = L2
  L2 = _UPVALUE1_
  L3 = L1
  L2(L3)
  while "text/plain; charset=\"iso-8859-1\"" do
    L2 = A0.body
    L2, L3 = L2()
    if L3 then
      L4 = _UPVALUE2_
      L4 = L4.yield
      L5 = nil
      L6 = L3
      L4(L5, L6)
    elseif L2 then
      L4 = _UPVALUE2_
      L4 = L4.yield
      L5 = L2
      L4(L5)
    else
      break
    end
  end
end
function L19(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = A0.headers
  L2 = L2 or L2
  L1 = L1(L2)
  L2 = L1["content-type"]
  L2 = L2 or L2
  L1["content-type"] = L2
  L2 = _UPVALUE1_
  L3 = L1
  L2(L3)
  L2 = _UPVALUE2_
  L2 = L2.yield
  L3 = A0.body
  L2(L3)
end
function L15(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L1 = L1.type
  L2 = A0.body
  L1 = L1(L2)
  if L1 == "table" then
    L1 = _UPVALUE1_
    L2 = A0
    L1(L2)
  else
    L1 = _UPVALUE0_
    L1 = L1.type
    L2 = A0.body
    L1 = L1(L2)
    if L1 == "function" then
      L1 = _UPVALUE2_
      L2 = A0
      L1(L2)
    else
      L1 = _UPVALUE3_
      L2 = A0
      L1(L2)
    end
  end
end
function L20(A0)
  local L1, L2, L3
  L1 = _UPVALUE0_
  L2 = A0.headers
  L1 = L1(L2)
  L2 = L1.date
  if not L2 then
    L2 = _UPVALUE1_
    L2 = L2.date
    L3 = "!%a, %d %b %Y %H:%M:%S "
    L2 = L2(L3)
    L3 = A0.zone
    if not L3 then
      L3 = _UPVALUE2_
      L3 = L3.ZONE
    end
    L2 = L2 .. L3
  end
  L1.date = L2
  L2 = L1["x-mailer"]
  if not L2 then
    L2 = _UPVALUE3_
    L2 = L2._VERSION
  end
  L1["x-mailer"] = L2
  L1["mime-version"] = "1.0"
  return L1
end
function L21(A0)
  local L1, L2
  L1 = _UPVALUE0_
  L2 = A0
  L1 = L1(L2)
  A0.headers = L1
  L1 = _UPVALUE1_
  L1 = L1.create
  function L2()
    local L0, L1
    L0 = _UPVALUE0_
    L1 = _UPVALUE1_
    L0(L1)
  end
  L1 = L1(L2)
  function L2()
    local L0, L1, L2, L3, L4
    L0 = _UPVALUE0_
    L0 = L0.resume
    L1 = _UPVALUE1_
    L0, L1, L2 = L0(L1)
    if L0 then
      L3 = L1
      L4 = L2
      return L3, L4
    else
      L3 = nil
      L4 = L1
      return L3, L4
    end
  end
  return L2
end
L10.message = L21
L21 = L5.protect
function L22(A0)
  local L1, L2, L3, L4, L5, L6, L7
  L1 = _UPVALUE0_
  L1 = L1.open
  L2 = A0.server
  L3 = A0.port
  L4 = A0.create
  L1 = L1(L2, L3, L4)
  L3 = L1
  L2 = L1.greet
  L4 = A0.domain
  L2 = L2(L3, L4)
  L4 = L1
  L3 = L1.auth
  L5 = A0.user
  L6 = A0.password
  L7 = L2
  L3(L4, L5, L6, L7)
  L4 = L1
  L3 = L1.send
  L5 = A0
  L3(L4, L5)
  L4 = L1
  L3 = L1.quit
  L3(L4)
  L4 = L1
  L3 = L1.close
  return L3(L4)
end
L21 = L21(L22)
L10.send = L21
return L10
