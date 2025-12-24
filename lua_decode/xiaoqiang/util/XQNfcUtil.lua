local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
L0 = module
L1 = "xiaoqiang.util.XQNfcUtil"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "xiaoqiang.common.XQFunction"
L0 = L0(L1)
L1 = require
L2 = "luci.model.uci"
L1 = L1(L2)
L1 = L1.cursor
L1 = L1()
L2 = {}
L3 = {}
L4 = 4193
L5 = 1
L3[1] = L4
L3[2] = L5
L2["802.1X_Enabled"] = L3
L3 = {}
L4 = 4097
L5 = 2
L3[1] = L4
L3[2] = L5
L2.AP_Channel = L3
L3 = {}
L4 = 4183
L5 = 1
L3[1] = L4
L3[2] = L5
L2.AP_Setup_Locked = L3
L3 = {}
L4 = 4098
L5 = 2
L3[1] = L4
L3[2] = L5
L2.Association_State = L3
L3 = {}
L4 = 4099
L5 = 2
L3[1] = L4
L3[2] = L5
L2.Authentication_Type = L3
L3 = {}
L4 = 4101
L5 = 8
L3[1] = L4
L3[2] = L5
L2.Authenticator = L3
L3 = {}
L4 = 4104
L5 = 2
L3[1] = L4
L3[2] = L5
L2.Configuration_Methods = L3
L3 = {}
L4 = 4110
L5 = 0
L3[1] = L4
L3[2] = L5
L2.Credential = L3
L3 = {}
L4 = 4113
L5 = 32
L3[1] = L4
L3[2] = L5
L2.Device_Name = L3
L3 = {}
L4 = 4114
L5 = 2
L3[1] = L4
L3[2] = L5
L2.Device_Password_ID = L3
L3 = {}
L4 = 4173
L5 = 64
L3[1] = L4
L3[2] = L5
L2.EAP_Identity = L3
L3 = {}
L4 = 4185
L5 = 8
L3[1] = L4
L3[2] = L5
L2.EAP_Type = L3
L3 = {}
L4 = 4116
L5 = 32
L3[1] = L4
L3[2] = L5
L2["E-Hash1"] = L3
L3 = {}
L4 = 4117
L5 = 32
L3[1] = L4
L3[2] = L5
L2["E-Hash2"] = L3
L3 = {}
L4 = 4120
L5 = 0
L3[1] = L4
L3[2] = L5
L2.Encrypted_Settings = L3
L3 = {}
L4 = 4111
L5 = 2
L3[1] = L4
L3[2] = L5
L2.Encryption_Type = L3
L3 = {}
L4 = 4128
L5 = 6
L3[1] = L4
L3[2] = L5
L2.MAC_Address = L3
L3 = {}
L4 = 4129
L5 = 64
L3[1] = L4
L3[2] = L5
L2.Manufacturer = L3
L3 = {}
L4 = 4131
L5 = 32
L3[1] = L4
L3[2] = L5
L2.Model_Name = L3
L3 = {}
L4 = 4132
L5 = 32
L3[1] = L4
L3[2] = L5
L2.Model_Number = L3
L3 = {}
L4 = 4134
L5 = 1
L3[1] = L4
L3[2] = L5
L2.Network_Index = L3
L3 = {}
L4 = 4135
L5 = 64
L3[1] = L4
L3[2] = L5
L2.Network_Key = L3
L3 = {}
L4 = 4136
L5 = 1
L3[1] = L4
L3[2] = L5
L2.Network_Key_Index = L3
L3 = {}
L4 = 4141
L5 = 4
L3[1] = L4
L3[2] = L5
L2.OS_Version = L3
L3 = {}
L4 = 4178
L5 = 2
L3[1] = L4
L3[2] = L5
L2.Permitted_Configuration_Methods = L3
L3 = {}
L4 = 4143
L5 = 1
L3[1] = L4
L3[2] = L5
L2.Power_Level = L3
L3 = {}
L4 = 4147
L5 = 1
L3[1] = L4
L3[2] = L5
L2.Radio_Enabled = L3
L3 = {}
L4 = 4156
L5 = 1
L3[1] = L4
L3[2] = L5
L2.RF_Bands = L3
L3 = {}
L4 = 4162
L5 = 32
L3[1] = L4
L3[2] = L5
L2.Serial_Number = L3
L3 = {}
L4 = 4165
L5 = 32
L3[1] = L4
L3[2] = L5
L2.SSID = L3
L3 = {}
L4 = 4166
L5 = 1
L3[1] = L4
L3[2] = L5
L2.Total_Networks = L3
L3 = {}
L4 = 4193
L5 = 1
L3[1] = L4
L3[2] = L5
L2.Vendor_Extension = L3
L3 = {}
L4 = 4170
L5 = 1
L3[1] = L4
L3[2] = L5
L2.Version = L3
L3 = {}
L4 = 4164
L5 = 1
L3[1] = L4
L3[2] = L5
L2["Wi-Fi_Simple_Configuration_State"] = L3
L3 = {}
L3.Not_Associated = 0
L3.Connection_Success = 1
L3.Configuration_Failure = 2
L3.Association_Failure = 3
L3.IP_Failure = 4
L4 = {}
L4.Open = 1
L4["WPA-Personal"] = 2
L4.Shared = 4
L4["WPA-Enterprise"] = 8
L4["WPA2-Enterprise"] = 16
L4["WPA2-Personal"] = 32
L4.SAE = 32
L5 = {}
L5.USBA = 1
L5.Ethernet = 2
L5.Label = 4
L5.Display = 8
L5.External_NFC_Token = 16
L5.Integrated_NFC_Token = 32
L5.NFC_Interface = 64
L5.Pushbutton = 128
L5.Keypad = 256
L5.Virtual_Pushbutton = 640
L5.Physical_Pushbutton = 1152
L5["Reserved)"] = 2176
L5.P2Ps = 4096
L5.Virtual_Display_PIN = 8200
L5.Physical_Display_PIN = 16392
L6 = {}
L6.None = 1
L6.WEP = 2
L6.TKIP = 4
L6.AES = 8
L6["AES/TKIP"] = 12
L7 = {}
L7["2.4GHz"] = 1
L7["5GHz"] = 2
L7["60GHz"] = 4
L8 = "0x61 0x70 0x70 0x6c 0x69 0x63 0x61 0x74 0x69 0x6f 0x6e 0x2f 0x76 0x6e 0x64 0x2e 0x77 0x66 0x61 0x2e 0x77 0x73 0x63"
L9 = "0xd2 0x17"
L10 = "0x03"
L11 = "0xfe"
function L12()
  local L0, L1, L2, L3, L4, L5
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "xiaoqiang"
  L3 = "common"
  L4 = "INITTED"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  L1 = _UPVALUE0_
  L2 = L1
  L1 = L1.get
  L3 = "wireless"
  L4 = "nfc_2g"
  L5 = "ssid"
  L1 = L1(L2, L3, L4, L5)
  L1 = L1 or L1
  if L1 == "NO" then
    L2 = false
    return L2
  end
  if L0 == "NO" then
    L2 = true
    return L2
  end
  L2 = false
  return L2
end
nfc_is_default = L12
function L12()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "misc"
  L3 = "nfc"
  L4 = "nfc_support"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  if L0 == "0" then
    L1 = false
    return L1
  end
  L1 = true
  return L1
end
nfc_is_supported = L12
function L12()
  local L0, L1, L2, L3, L4
  L0 = _UPVALUE0_
  L1 = L0
  L0 = L0.get
  L2 = "nfc"
  L3 = "nfc"
  L4 = "nfc_enable"
  L0 = L0(L1, L2, L3, L4)
  L0 = L0 or L0
  if L0 == "0" then
    L1 = false
    return L1
  end
  L1 = true
  return L1
end
nfc_is_enabled = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L1 = ""
  for L5 = L2, L3, L4 do
    L6 = L1
    L7 = string
    L7 = L7.format
    L8 = "0x%02x "
    L9 = string
    L9 = L9.byte
    L10 = A0
    L11 = L5
    L9, L10, L11 = L9(L10, L11)
    L7 = L7(L8, L9, L10, L11)
    L1 = L6 .. L7
  end
  L5 = string
  L5 = L5.len
  L6 = L1
  L5 = L5(L6)
  L5 = L5 - 1
  L1 = L2
  return L1
end
str_to_i2c = L12
function L12(A0)
  local L1, L2, L3, L4, L5
  L1 = ""
  L2 = string
  L2 = L2.format
  L3 = "0x%02x"
  L4 = math
  L4 = L4.floor
  L5 = A0
  L4, L5 = L4(L5)
  L2 = L2(L3, L4, L5)
  L1 = L2
  return L1
end
byte_to_i2c = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "bit"
  L1 = L1(L2)
  L2 = ""
  L3 = string
  L3 = L3.format
  L4 = "0x%02x 0x%02x"
  L5 = L1.rshift
  L6 = A0
  L7 = 8
  L5 = L5(L6, L7)
  L6 = L1.band
  L7 = A0
  L8 = 255
  L6, L7, L8 = L6(L7, L8)
  L3 = L3(L4, L5, L6, L7, L8)
  L2 = L3
  return L2
end
word_to_i2c = L12
function L12(A0)
  local L1, L2, L3, L4, L5, L6, L7, L8
  L1 = require
  L2 = "bit"
  L1 = L1(L2)
  L2 = ""
  L3 = word_to_i2c
  L4 = L1.rshift
  L5 = A0
  L6 = 16
  L4, L5, L6, L7, L8 = L4(L5, L6)
  L3 = L3(L4, L5, L6, L7, L8)
  L4 = " "
  L5 = word_to_i2c
  L6 = L1.band
  L7 = A0
  L8 = 65535
  L6, L7, L8 = L6(L7, L8)
  L5 = L5(L6, L7, L8)
  L2 = L3 .. L4 .. L5
  return L2
end
uint32_to_i2c = L12
function L12(A0)
  local L1, L2, L3
  L1 = 0
  L2 = string
  L2 = L2.len
  L3 = A0
  L2 = L2(L3)
  L2 = L2 + 1
  L1 = L2 / 5
  return L1
end
i2c_strlen = L12
function L12()
  local L0, L1, L2
  L0 = _UPVALUE0_
  L0 = L0.forkExec
  L1 = string
  L1 = L1.format
  L2 = "/sbin/nfc disable"
  L1, L2 = L1(L2)
  L0(L1, L2)
end
nfc_disable = L12
function L12()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14, L15
  L0 = require
  L1 = "xiaoqiang.util.XQWifiUtil"
  L0 = L0(L1)
  L1 = {}
  L2 = {}
  L3 = 0
  L4 = ""
  L5 = ""
  L6 = _UPVALUE0_
  L7 = L6
  L6 = L6.get
  L8 = "misc"
  L6 = L6(L7, L8, L9, L10)
  L6 = L6 or L6
  L7 = _UPVALUE0_
  L8 = L7
  L7 = L7.get
  L7 = L7(L8, L9, L10, L11)
  L7 = L7 or L7
  L8 = _UPVALUE0_
  L8 = L8.get
  L12 = "ifname_5GH"
  L8 = L8(L9, L10, L11, L12)
  L8 = L8 or L8
  L1 = L9
  for L12, L13 in L9, L10, L11 do
    L14 = L13.ifname
    if L14 == L7 then
      L14 = L13.status
      if L14 == "1" then
        L2 = L13
        L3 = 1
        break
      end
    end
  end
  if L3 == 0 then
    for L12, L13 in L9, L10, L11 do
      L14 = L13.ifname
      if L14 == L8 then
        L14 = L13.status
        if L14 == "1" then
          L2 = L13
          L3 = 1
          break
        end
      end
    end
  end
  if L3 == 0 then
    for L12, L13 in L9, L10, L11 do
      L14 = L13.ifname
      if L14 == L6 then
        L14 = L13.status
        if L14 == "1" then
          L2 = L13
          L3 = 1
          break
        end
      end
    end
  end
  if L3 == 0 then
    for L12, L13 in L9, L10, L11 do
      L14 = L13.status
      if L14 == "1" then
        L2 = L13
        L3 = 1
        break
      end
    end
  end
  if L9 == 1 then
    L2.ssid = L9
    L2.password = L9
  end
  if L3 == 0 then
    L4 = "no_tag"
    return L4
  end
  L12 = word_to_i2c
  L13 = _UPVALUE2_
  L13 = L13.Network_Index
  L13 = L13[2]
  L12 = L12(L13)
  L13 = " "
  L14 = "0x01"
  L15 = " "
  L4 = L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15
  L12 = word_to_i2c
  L13 = string
  L13 = L13.len
  L14 = L2.ssid
  L13, L14, L15 = L13(L14)
  L12 = L12(L13, L14, L15)
  L13 = " "
  L14 = str_to_i2c
  L15 = L2.ssid
  L14 = L14(L15)
  L15 = " "
  L4 = L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15
  if L9 ~= "psk2+ccmp" then
    if L9 ~= "ccmp" then
      goto lbl_163
    end
  end
  L5 = L9.SAE
  goto lbl_180
  ::lbl_163::
  if L9 == "psk2" then
    L5 = L9["WPA2-Personal"]
  elseif L9 == "mixed-psk" then
    L5 = L9 + L10
  else
    L5 = L9.Open
  end
  ::lbl_180::
  L12 = word_to_i2c
  L13 = _UPVALUE2_
  L13 = L13.Authentication_Type
  L13 = L13[2]
  L12 = L12(L13)
  L13 = " "
  L14 = word_to_i2c
  L15 = L5
  L14 = L14(L15)
  L15 = " "
  L4 = L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15
  if L9 == "none" then
    L5 = L9.None
  else
    L5 = L9.AES
  end
  L12 = word_to_i2c
  L13 = _UPVALUE2_
  L13 = L13.Encryption_Type
  L13 = L13[2]
  L12 = L12(L13)
  L13 = " "
  L14 = word_to_i2c
  L15 = L5
  L14 = L14(L15)
  L15 = " "
  L4 = L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15
  if L9 ~= "none" then
    L12 = word_to_i2c
    L13 = string
    L13 = L13.len
    L14 = L2.password
    L13, L14, L15 = L13(L14)
    L12 = L12(L13, L14, L15)
    L13 = " "
    L14 = str_to_i2c
    L15 = L2.password
    L14 = L14(L15)
    L15 = " "
    L4 = L9 .. L10 .. L11 .. L12 .. L13 .. L14 .. L15
  end
  L12 = word_to_i2c
  L13 = _UPVALUE2_
  L13 = L13.MAC_Address
  L13 = L13[2]
  L12 = L12(L13)
  L13 = " "
  L14 = "0xff 0xff 0xff 0xff 0xff 0xff"
  L4 = L9 .. L10 .. L11 .. L12 .. L13 .. L14
  L12 = i2c_strlen
  L13 = L4
  L12, L13, L14, L15 = L12(L13)
  L12 = " "
  L13 = L4
  L4 = L9 .. L10 .. L11 .. L12 .. L13
  return L4
end
update_wifi_tag = L12
function L12()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11
  L0 = ""
  L1 = ""
  L2 = ""
  L3 = ""
  L4 = ""
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.get
  L7 = "wireless"
  L8 = "nfc_2g"
  L9 = "ssid"
  L5 = L5(L6, L7, L8, L9)
  L2 = L5
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.get
  L7 = "wireless"
  L8 = "nfc_2g"
  L9 = "key"
  L5 = L5(L6, L7, L8, L9)
  L4 = L5
  L5 = _UPVALUE0_
  L6 = L5
  L5 = L5.get
  L7 = "wireless"
  L8 = "nfc_2g"
  L9 = "encryption"
  L5 = L5(L6, L7, L8, L9)
  L3 = L5
  L5 = L0
  L6 = word_to_i2c
  L7 = _UPVALUE1_
  L7 = L7.Network_Index
  L7 = L7[1]
  L6 = L6(L7)
  L7 = " "
  L8 = word_to_i2c
  L9 = _UPVALUE1_
  L9 = L9.Network_Index
  L9 = L9[2]
  L8 = L8(L9)
  L9 = " "
  L10 = "0x01"
  L11 = " "
  L0 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
  L5 = L0
  L6 = word_to_i2c
  L7 = _UPVALUE1_
  L7 = L7.SSID
  L7 = L7[1]
  L6 = L6(L7)
  L7 = " "
  L8 = word_to_i2c
  L9 = string
  L9 = L9.len
  L10 = L2
  L9, L10, L11 = L9(L10)
  L8 = L8(L9, L10, L11)
  L9 = " "
  L10 = str_to_i2c
  L11 = L2
  L10 = L10(L11)
  L11 = " "
  L0 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
  if L3 == "psk2+ccmp" or L3 == "ccmp" then
    L5 = _UPVALUE2_
    L1 = L5.SAE
  elseif L3 == "psk2" then
    L5 = _UPVALUE2_
    L1 = L5["WPA2-Personal"]
  elseif L3 == "mixed-psk" then
    L5 = _UPVALUE2_
    L5 = L5["WPA2-Personal"]
    L6 = _UPVALUE2_
    L6 = L6["WPA-Personal"]
    L1 = L5 + L6
  else
    L5 = _UPVALUE2_
    L1 = L5.Open
  end
  L5 = L0
  L6 = word_to_i2c
  L7 = _UPVALUE1_
  L7 = L7.Authentication_Type
  L7 = L7[1]
  L6 = L6(L7)
  L7 = " "
  L8 = word_to_i2c
  L9 = _UPVALUE1_
  L9 = L9.Authentication_Type
  L9 = L9[2]
  L8 = L8(L9)
  L9 = " "
  L10 = word_to_i2c
  L11 = L1
  L10 = L10(L11)
  L11 = " "
  L0 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
  if L3 == "none" then
    L5 = _UPVALUE3_
    L1 = L5.None
  else
    L5 = _UPVALUE3_
    L1 = L5.AES
  end
  L5 = L0
  L6 = word_to_i2c
  L7 = _UPVALUE1_
  L7 = L7.Encryption_Type
  L7 = L7[1]
  L6 = L6(L7)
  L7 = " "
  L8 = word_to_i2c
  L9 = _UPVALUE1_
  L9 = L9.Encryption_Type
  L9 = L9[2]
  L8 = L8(L9)
  L9 = " "
  L10 = word_to_i2c
  L11 = L1
  L10 = L10(L11)
  L11 = " "
  L0 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
  L5 = L0
  L6 = word_to_i2c
  L7 = _UPVALUE1_
  L7 = L7.Network_Key
  L7 = L7[1]
  L6 = L6(L7)
  L7 = " "
  L8 = word_to_i2c
  L9 = string
  L9 = L9.len
  L10 = L4
  L9, L10, L11 = L9(L10)
  L8 = L8(L9, L10, L11)
  L9 = " "
  L10 = str_to_i2c
  L11 = L4
  L10 = L10(L11)
  L11 = " "
  L0 = L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11
  L5 = L0
  L6 = word_to_i2c
  L7 = _UPVALUE1_
  L7 = L7.MAC_Address
  L7 = L7[1]
  L6 = L6(L7)
  L7 = " "
  L8 = word_to_i2c
  L9 = _UPVALUE1_
  L9 = L9.MAC_Address
  L9 = L9[2]
  L8 = L8(L9)
  L9 = " "
  L10 = "0xff 0xff 0xff 0xff 0xff 0xff"
  L0 = L5 .. L6 .. L7 .. L8 .. L9 .. L10
  L5 = word_to_i2c
  L6 = _UPVALUE1_
  L6 = L6.Credential
  L6 = L6[1]
  L5 = L5(L6)
  L6 = " "
  L7 = word_to_i2c
  L8 = i2c_strlen
  L9 = L0
  L8, L9, L10, L11 = L8(L9)
  L7 = L7(L8, L9, L10, L11)
  L8 = " "
  L9 = L0
  L0 = L5 .. L6 .. L7 .. L8 .. L9
  return L0
end
default_wifi_tag = L12
function L12()
  local L0, L1, L2, L3, L4, L5, L6
  L0 = require
  L1 = "luci.model.uci"
  L0 = L0(L1)
  L0 = L0.cursor
  L0 = L0()
  L2 = L0
  L1 = L0.set
  L3 = "nfc"
  L4 = "nfc"
  L5 = "mesh_sync_disabled"
  L6 = "1"
  L1(L2, L3, L4, L5, L6)
  L2 = L0
  L1 = L0.commit
  L3 = "nfc"
  L1(L2, L3)
end
nfc_mesh_sync_disable = L12
function L12()
  local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12
  L0 = ""
  L1 = 0
  L2 = 0
  L3 = nfc_is_supported
  L3 = L3()
  L4 = nfc_is_enabled
  L4 = L4()
  L5 = nfc_is_default
  L5 = L5()
  if L3 == false or L4 == false then
    L6 = 0
    return L6
  end
  if L5 == true then
    L6 = default_wifi_tag
    L6 = L6()
    L0 = L6
  else
    L6 = update_wifi_tag
    L6 = L6()
    L0 = L6
  end
  if L0 == "no_tag" then
    L6 = nfc_disable
    L6()
    L6 = 0
    return L6
  end
  L6 = i2c_strlen
  L7 = L0
  L6 = L6(L7)
  L1 = L6
  if L0 == "" then
    L6 = _UPVALUE0_
    L7 = " "
    L8 = byte_to_i2c
    L9 = L1
    L8 = L8(L9)
    L9 = " "
    L10 = _UPVALUE1_
    L0 = L6 .. L7 .. L8 .. L9 .. L10
  else
    L6 = _UPVALUE0_
    L7 = " "
    L8 = byte_to_i2c
    L9 = L1
    L8 = L8(L9)
    L9 = " "
    L10 = _UPVALUE1_
    L11 = " "
    L12 = L0
    L0 = L6 .. L7 .. L8 .. L9 .. L10 .. L11 .. L12
  end
  L6 = i2c_strlen
  L7 = L0
  L6 = L6(L7)
  L2 = L6
  if L2 <= 255 then
    L6 = _UPVALUE2_
    L7 = " "
    L8 = byte_to_i2c
    L9 = L2
    L8 = L8(L9)
    L9 = " "
    L10 = L0
    L11 = " "
    L12 = _UPVALUE3_
    L0 = L6 .. L7 .. L8 .. L9 .. L10 .. L11 .. L12
  else
    L6 = _UPVALUE2_
    L7 = " "
    L8 = uint32_to_i2c
    L9 = L2
    L8 = L8(L9)
    L9 = " "
    L10 = L0
    L11 = " "
    L12 = _UPVALUE3_
    L0 = L6 .. L7 .. L8 .. L9 .. L10 .. L11 .. L12
  end
  L6 = _UPVALUE4_
  L6 = L6.forkExec
  L7 = string
  L7 = L7.format
  L8 = "/sbin/nfc update '%s' %d"
  L9 = L0
  L10 = math
  L10 = L10.floor
  L11 = i2c_strlen
  L12 = L0
  L11, L12 = L11(L12)
  L10, L11, L12 = L10(L11, L12)
  L7, L8, L9, L10, L11, L12 = L7(L8, L9, L10, L11, L12)
  L6(L7, L8, L9, L10, L11, L12)
end
nfc_update = L12
