local L0, L1, L2
L0 = module
L1 = "service.util.ServiceErrorUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
function L0(A0)
  local L1, L2, L3, L4
  L1 = {}
  L2 = _
  L3 = ""
  L2 = L2(L3)
  L1[0] = L2
  L2 = _
  L3 = "parameter missing"
  L2 = L2(L3)
  L1[1] = L2
  L2 = _
  L3 = "Parameter empty"
  L2 = L2(L3)
  L1[2] = L2
  L2 = _
  L3 = "Parameter format error"
  L2 = L2(L3)
  L1[3] = L2
  L2 = _
  L3 = "invalid app id"
  L2 = L2(L3)
  L1[5] = L2
  L2 = _
  L3 = "invalid device id"
  L2 = L2(L3)
  L1[1056] = L2
  L2 = _
  L3 = "resource is not ready"
  L2 = L2(L3)
  L1[1057] = L2
  L2 = _
  L3 = "datacenter error"
  L2 = L2(L3)
  L1[1559] = L2
  L2 = _
  L3 = "datacenter error"
  L2 = L2(L3)
  L1[2010] = L2
  L2 = L1[A0]
  if L2 == nil then
    L2 = translate
    L3 = _
    L4 = "\230\156\170\231\159\165\233\148\153\232\175\175"
    L3, L4 = L3(L4)
    return L2(L3, L4)
  else
    L2 = translate
    L3 = L1[A0]
    return L2(L3)
  end
end
getErrorMessage = L0
