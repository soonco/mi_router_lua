local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13
L0 = module
L1 = "xiaoqiang.module.XQEBit"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "json"
L0 = L0(L1)
L1 = require
L2 = "xiaoqiang.XQLog"
L1 = L1(L2)
L2 = require
L3 = "xiaoqiang.common.XQFunction"
L2 = L2(L3)
L3 = require
L4 = "xiaoqiang.util.XQHttpUtil"
L3 = L3(L4)
L4 = require
L5 = "luci.http.protocol"
L4 = L4(L5)
L5 = "APP_MIOFGBVQ"
L6 = "2ErNCyfk8HZoH432T7Em0K16"
L7 = "http://218.85.118.9:8000/api2/user/query"
L8 = "http://218.85.118.9:8000/api2/task/query"
L9 = "http://218.85.118.9:8000/api2/speedup/open"
L10 = "http://218.85.118.9:8000/api2/speedup/close"
L11 = "http://218.85.118.9:8000/api2/speedup/query"
L12 = "http://218.85.118.9:8000/api2/speedup/check"
function L13()
  local L0, L1, L2, L3, L4, L5
  L0 = require
  L1 = "xiaoqiang.util.XQCryptoUtil"
  L0 = L0(L1)
  L1 = os
  L1 = L1.time
  L1 = L1()
  L2 = _UPVALUE0_
  L3 = tostring
  L4 = L1
  L3 = L3(L4)
  L4 = _UPVALUE1_
  L2 = L2 .. L3 .. L4
  L3 = L1
  L4 = L0.md5Str
  L5 = L2
  L4, L5 = L4(L5)
  return L3, L4, L5
end
genSecret = L13
function L13()
  local L0, L1, L2
  L0 = require
  L1 = "xiaoqiang.util.XQLanWanUtil"
  L0 = L0(L1)
  L1 = L0.ubusWanStatus
  L1 = L1()
  if L1 then
    L2 = L1.ipv4
    if L2 then
      L2 = L1.ipv4
      L2 = #L2
      if 0 < L2 then
        L2 = L1.ipv4
        L2 = L2[1]
        L2 = L2.ip
        return L2
      end
    end
  end
  L2 = nil
  return L2
end
wanip = L13
function L13(A0, A1, A2)
  local L3, L4, L5, L6, L7, L8
  L3 = {}
  L4 = _UPVALUE0_
  L3.app = L4
  L3.timestamp = A0
  L3.secret = A1
  L3.task_id = A2
  L4 = _UPVALUE1_
  L4 = L4.httpPostRequest
  L5 = _UPVALUE2_
  L6 = _UPVALUE3_
  L6 = L6.encode
  L7 = L3
  L6 = L6(L7)
  L7 = nil
  L8 = "application/json"
  L4 = L4(L5, L6, L7, L8)
  if L4 then
    L5 = L4.code
    if L5 then
      L5 = L4.code
      if L5 == 200 then
        L5 = _UPVALUE3_
        L5 = L5.decode
        L6 = L4.res
        return L5(L6)
    end
  end
  else
    L5 = _UPVALUE4_
    L5 = L5.log
    L6 = 4
    L7 = "XQEBit task/query failed"
    L8 = L4
    L5(L6, L7, L8)
    L5 = nil
    return L5
  end
end
task_query = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10
  L1 = genSecret
  L1, L2 = L1()
  L3 = nil
  if not A0 then
    L4 = wanip
    L4 = L4()
    L3 = L4
    if not L3 then
      L4 = nil
      return L4
    end
  else
    L3 = A0
  end
  L4 = {}
  L5 = _UPVALUE0_
  L4.app = L5
  L4.timestamp = L1
  L4.secret = L2
  L4._type = 0
  L4.data = L3
  L5 = _UPVALUE1_
  L5 = L5.httpPostRequest
  L6 = _UPVALUE2_
  L7 = _UPVALUE3_
  L7 = L7.encode
  L8 = L4
  L7 = L7(L8)
  L8 = nil
  L9 = "application/json"
  L5 = L5(L6, L7, L8, L9)
  if L5 then
    L6 = L5.code
    if L6 then
      L6 = L5.code
      if L6 == 200 then
        L6 = _UPVALUE3_
        L6 = L6.decode
        L7 = L5.res
        L6 = L6(L7)
        L7 = L6.task_id
        if L7 then
          L7 = task_query
          L8 = L1
          L9 = L2
          L10 = L6.task_id
          return L7(L8, L9, L10)
        end
    end
  end
  else
    L6 = _UPVALUE4_
    L6 = L6.log
    L7 = 4
    L8 = "XQEBit user/query failed"
    L9 = L5
    L6(L7, L8, L9)
  end
  L6 = nil
  return L6
end
basic_info_query = L13
function L13(A0, A1, A2, A3, A4)
  local L5, L6, L7, L8, L9, L10, L11, L12, L13
  if not A4 then
    L5 = wanip
    L5 = L5()
    A4 = L5
  end
  L5 = genSecret
  L5, L6 = L5()
  L7 = {}
  L8 = _UPVALUE0_
  L7.app = L8
  L7.timestamp = L5
  L7.secret = L6
  L7.ip_addr = A4
  L7.dial_acct = A3
  L8 = {}
  L9 = A0
  L10 = A1
  L8[1] = L9
  L8[2] = L10
  L7.bandwidths = L8
  L7.duration = A2
  L8 = _UPVALUE1_
  L8 = L8.httpPostRequest
  L9 = _UPVALUE2_
  L10 = _UPVALUE3_
  L10 = L10.encode
  L11 = L7
  L10 = L10(L11)
  L11 = nil
  L12 = "application/json"
  L8 = L8(L9, L10, L11, L12)
  if L8 then
    L9 = L8.code
    if L9 then
      L9 = L8.code
      if L9 == 200 then
        L9 = _UPVALUE3_
        L9 = L9.decode
        L10 = L8.res
        L9 = L9(L10)
        L10 = L9.task_id
        if L10 then
          L10 = task_query
          L11 = L5
          L12 = L6
          L13 = L9.task_id
          return L10(L11, L12, L13)
        end
    end
  end
  else
    L9 = _UPVALUE4_
    L9 = L9.log
    L10 = 4
    L11 = "XQEBit speedup/open failed"
    L12 = L8
    L9(L10, L11, L12)
  end
  L9 = nil
  return L9
end
speed_up_open = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = genSecret
  L1, L2 = L1()
  L3 = {}
  L4 = _UPVALUE0_
  L3.app = L4
  L3.timestamp = L1
  L3.secret = L2
  L3.channel_id = A0
  L4 = _UPVALUE1_
  L4 = L4.httpPostRequest
  L5 = _UPVALUE2_
  L6 = _UPVALUE3_
  L6 = L6.encode
  L7 = L3
  L6 = L6(L7)
  L7 = nil
  L8 = "application/json"
  L4 = L4(L5, L6, L7, L8)
  if L4 then
    L5 = L4.code
    if L5 then
      L5 = L4.code
      if L5 == 200 then
        L5 = _UPVALUE3_
        L5 = L5.decode
        L6 = L4.res
        L5 = L5(L6)
        L6 = L5.task_id
        if L6 then
          L6 = task_query
          L7 = L1
          L8 = L2
          L9 = L5.task_id
          return L6(L7, L8, L9)
        end
    end
  end
  else
    L5 = _UPVALUE4_
    L5 = L5.log
    L6 = 4
    L7 = "XQEBit speedup/close failed"
    L8 = L4
    L5(L6, L7, L8)
  end
  L5 = nil
  return L5
end
speed_up_close = L13
function L13(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9
  L1 = genSecret
  L1, L2 = L1()
  L3 = {}
  L4 = _UPVALUE0_
  L3.app = L4
  L3.timestamp = L1
  L3.secret = L2
  L3.channel_id = A0
  L4 = _UPVALUE1_
  L4 = L4.httpPostRequest
  L5 = _UPVALUE2_
  L6 = _UPVALUE3_
  L6 = L6.encode
  L7 = L3
  L6 = L6(L7)
  L7 = nil
  L8 = "application/json"
  L4 = L4(L5, L6, L7, L8)
  if L4 then
    L5 = L4.code
    if L5 then
      L5 = L4.code
      if L5 == 200 then
        L5 = _UPVALUE3_
        L5 = L5.decode
        L6 = L4.res
        L5 = L5(L6)
        L6 = L5.task_id
        if L6 then
          L6 = task_query
          L7 = L1
          L8 = L2
          L9 = L5.task_id
          return L6(L7, L8, L9)
        end
    end
  end
  else
    L5 = _UPVALUE4_
    L5 = L5.log
    L6 = 4
    L7 = "XQEBit speedup/query failed"
    L8 = L4
    L5(L6, L7, L8)
  end
  L5 = nil
  return L5
end
speed_up_query = L13
function L13(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8, L9, L10
  if not A1 then
    L2 = wanip
    L2 = L2()
    A1 = L2
  end
  L2 = genSecret
  L2, L3 = L2()
  L4 = {}
  L5 = _UPVALUE0_
  L4.app = L5
  L4.timestamp = L2
  L4.secret = L3
  L4.ip_addr = A1
  L4.dial_acct = A0
  L5 = _UPVALUE1_
  L5 = L5.httpPostRequest
  L6 = _UPVALUE2_
  L7 = _UPVALUE3_
  L7 = L7.encode
  L8 = L4
  L7 = L7(L8)
  L8 = nil
  L9 = "application/json"
  L5 = L5(L6, L7, L8, L9)
  if L5 then
    L6 = L5.code
    if L6 then
      L6 = L5.code
      if L6 == 200 then
        L6 = _UPVALUE3_
        L6 = L6.decode
        L7 = L5.res
        L6 = L6(L7)
        L7 = L6.task_id
        if L7 then
          L7 = task_query
          L8 = L2
          L9 = L3
          L10 = L6.task_id
          return L7(L8, L9, L10)
        end
    end
  end
  else
    L6 = _UPVALUE4_
    L6 = L6.log
    L7 = 4
    L8 = "XQEBit speedup/check failed"
    L9 = L5
    L6(L7, L8, L9)
  end
  L6 = nil
  return L6
end
speed_up_check = L13
