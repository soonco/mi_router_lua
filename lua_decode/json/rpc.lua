local L0, L1, L2, L3, L4
L0 = require
L1 = "json"
L0 = L0(L1)
L1 = {}
L0.rpc = L1
L1 = require
L2 = "json"
L1 = L1(L2)
L2 = require
L3 = "socket.http"
L2 = L2(L3)
L3 = L1.rpc
function L4(A0)
  local L1, L2, L3, L4, L5
  L1 = {}
  L2 = {}
  function L3(A0, A1)
    local L2
    function L2(...)
      local L1, L2, L3, L4
      L1 = _UPVALUE0_
      L1 = L1.rpc
      L1 = L1.call
      L2 = _UPVALUE1_
      L3 = _UPVALUE2_
      L4 = ...
      return L1(L2, L3, L4)
    end
    return L2
  end
  L2.__index = L3
  L3 = setmetatable
  L4 = L1
  L5 = L2
  L3(L4, L5)
  return L1
end
L3.proxy = L4
L3 = L1.rpc
function L4(A0, A1, ...)
  local L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
  L3 = {}
  L4 = tostring
  L5 = math
  L5 = L5.random
  L5, L6, L7, L8, L9, L10, L11, L12, L13, L14 = L5()
  L4 = L4(L5, L6, L7, L8, L9, L10, L11, L12, L13, L14)
  L3.id = L4
  L3.method = A1
  L4 = (...)
  L3.params = L4
  L4, L5, L6 = nil, nil, nil
  L7 = _UPVALUE0_
  L7 = L7.encode
  L8 = L3
  L7 = L7(L8)
  L8 = require
  L9 = "ltn12"
  L8 = L8(L9)
  L9 = {}
  L10 = _UPVALUE1_
  L10 = L10.request
  L11 = {}
  L11.url = A0
  L12 = L8.sink
  L12 = L12.table
  L13 = L9
  L12 = L12(L13)
  L11.sink = L12
  L11.method = "POST"
  L12 = {}
  L12["content-type"] = "application/json-rpc"
  L13 = string
  L13 = L13.len
  L14 = L7
  L13 = L13(L14)
  L12["content-length"] = L13
  L11.headers = L12
  L12 = L8.source
  L12 = L12.string
  L13 = L7
  L12 = L12(L13)
  L11.source = L12
  L10, L11 = L10(L11)
  L6 = L11
  L4 = L10
  L10 = table
  L10 = L10.concat
  L11 = L9
  L10 = L10(L11)
  L4 = L10
  if L6 ~= 200 then
    L10 = nil
    L11 = "HTTP ERROR: "
    L12 = L6
    L11 = L11 .. L12
    return L10, L11
  end
  L10 = _UPVALUE0_
  L10 = L10.decode
  L11 = L4
  L10 = L10(L11)
  L5 = L10
  L10 = L5.result
  if L10 then
    L10 = L5.result
    L11 = nil
    return L10, L11
  else
    L10 = nil
    L11 = L5.error
    return L10, L11
  end
end
L3.call = L4
