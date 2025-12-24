local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15, L16, L17, L18, L19, L20
L0 = require
L1 = "table"
L0 = L0(L1)
L1 = require
L2 = "nixio"
L1 = L1(L2)
L2 = getmetatable
L3 = assert
L4 = pairs
L5 = type
L6 = tostring
L7 = module
L8 = "nixio.util"
L7(L8)
L7 = L1.const
L7 = L7.buffersize
L8 = 65536
L9 = L1.meta_socket
L10 = L1.meta_tls_socket
L11 = L1.meta_file
L12 = L1.uname
L12 = L12()
L13 = L12.sysname
L13 = L13 == "Linux"
function L14(A0, A1)
  local L2, L3, L4, L5, L6, L7, L8
  L2 = A1 or L2
  if not A1 then
    L2 = {}
  end
  if A0 then
    for L6 in L3, L4, L5 do
      L7 = #L2
      L7 = L7 + 1
      L2[L7] = L6
    end
  end
  return L2
end
consume = L14
L14 = {}
L14.is_socket = L15
L14.is_tls_socket = L15
L14.is_file = L15
L14.readall = L15
L14.recvall = L15
L14.writeall = L15
L14.sendall = L15
L14.linesource = L15
L14.blocksource = L15
L14.sink = L15
L14.copy = L15
L14.copyz = L15
if L10 then
  L10.close = L15
  L10.getsockname = L15
  L10.getpeername = L15
  L10.getsockopt = L15
  L10.getopt = L15
  L10.setsockopt = L15
  L10.setopt = L15
end
for L18, L19 in L15, L16, L17 do
  L11[L18] = L19
  L9[L18] = L19
  if L10 then
    L10[L18] = L19
  end
end
