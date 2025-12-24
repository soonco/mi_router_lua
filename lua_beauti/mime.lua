--[[
  MIME 编码/解码模块
  
  功能说明:
  - Base64 编码/解码
  - Quoted-Printable 编码/解码
  - 文本换行处理
  - SMTP 点填充(dot-stuffing)
  
  主要函数:
  - encode(type, data): 编码数据
  - decode(type, data): 解码数据
  - wrap(type, data): 文本换行
  - normalize(marker): 规范化行结束符
  - stuff(): SMTP点填充
  
  支持的编码类型:
  - base64: Base64编码
  - quoted-printable: QP编码
]]

local _G = _G
local ltn12 = require("ltn12")
local mime_core = require("mime.core")
local io = require("io")
local string = require("string")

local mime = mime_core

mime.encodet = {}
mime.decodet = {}
mime.wrapt = {}

local function choose_handler(handlers)
    return function(name, data1, data2)
        if type(name) ~= "string" then
            data2 = data1
            data1 = name
            name = "default"
        end
        
        local handler = handlers[name or "nil"]
        
        if not handler then
            _G.error("unknown key (" .. _G.tostring(name) .. ")", 3)
        else
            return handler(data1, data2)
        end
    end
end

mime.encodet.base64 = function()
    return ltn12.filter.cycle(mime_core.b64, "")
end

mime.encodet["quoted-printable"] = function(mode)
    local marker = (mode == "binary") and "=0D=0A" or "\r\n"
    return ltn12.filter.cycle(mime_core.qp, "", marker)
end

mime.decodet.base64 = function()
    return ltn12.filter.cycle(mime_core.unb64, "")
end

mime.decodet["quoted-printable"] = function()
    return ltn12.filter.cycle(mime_core.unqp, "")
end

local function get_length(data)
    if data then
        if data == "" then
            return "''"
        else
            return string.len(data)
        end
    else
        return "nil"
    end
end

mime.wrapt.text = function(length)
    length = length or 76
    return ltn12.filter.cycle(mime_core.wrp, length, length)
end

mime.wrapt.base64 = mime.wrapt.text
mime.wrapt.default = mime.wrapt.text

mime.wrapt["quoted-printable"] = function()
    return ltn12.filter.cycle(mime_core.qpwrp, 76, 76)
end

mime.encode = choose_handler(mime.encodet)
mime.decode = choose_handler(mime.decodet)
mime.wrap = choose_handler(mime.wrapt)

function mime.normalize(marker)
    return ltn12.filter.cycle(mime_core.eol, 0, marker)
end

function mime.stuff()
    return ltn12.filter.cycle(mime_core.dot, 2)
end

return mime
