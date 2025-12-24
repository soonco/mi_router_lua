--[[
  LuaSocket URL 解析模块
  
  功能说明:
  - URL编码/解码
  - URL解析和构建
  - 相对URL转绝对URL
  - 路径规范化
  
  主要函数:
  - escape(s): URL编码
  - unescape(s): URL解码
  - parse(url, default): 解析URL为组件表
  - build(parsed): 从组件表构建URL
  - absolute(base, relative): 将相对URL转为绝对URL
  - parse_path(path): 解析路径
  - build_path(parsed, unsafe): 构建路径
]]

local string = require("string")
local _G = _G
local table = require("table")
local socket = require("socket")

socket.url = {}

local url = socket.url

url._VERSION = "URL 1.0.3"

function url.escape(s)
    return string.gsub(s, "([^A-Za-z0-9_])", function(c)
        return string.format("%%%02x", string.byte(c))
    end)
end

local function make_set(t)
    local s = {}
    for _, v in ipairs(t) do
        s[v] = 1
    end
    return s
end

local segment_set = make_set {
    "-", "_", ".", "!", "~", "*", "'", "(", ")",
    ":", "@", "&", "=", "+", "$", ","
}

function url.escape_segment(s)
    return string.gsub(s, "([^A-Za-z0-9_])", function(c)
        if segment_set[c] then
            return c
        else
            return string.format("%%%02x", string.byte(c))
        end
    end)
end

function url.unescape(s)
    return string.gsub(s, "%%(%x%x)", function(hex)
        return string.char(_G.tonumber(hex, 16))
    end)
end

local function absolute_path(base_path, relative_path)
    if string.sub(relative_path, 1, 1) == "/" then
        return relative_path
    end
    
    local path = string.gsub(base_path, "[^/]*$", "") .. relative_path
    
    path = string.gsub(path, "([^/]*%./)", function(s)
        if s ~= "./" then return s else return "" end
    end)
    
    path = string.gsub(path, "/%.$", "/")
    
    local prev
    while prev ~= path do
        prev = path
        path = string.gsub(prev, "([^/]*/%.%./)", function(s)
            if s ~= "../../" then return "" else return s end
        end)
    end
    
    path = string.gsub(prev, "([^/]*/%.%.)$", function(s)
        if s ~= "../.." then return "" else return s end
    end)
    
    return path
end

function url.parse(url_string, default)
    local parsed = {}
    
    if default then
        for k, v in pairs(default) do
            parsed[k] = v
        end
    end
    
    if not url_string or url_string == "" then
        return parsed
    end
    
    url_string = string.gsub(url_string, "#(.*)$", function(f)
        parsed.fragment = f
        return ""
    end)
    
    url_string = string.gsub(url_string, "^([%w][%w%+%-%.]*)%:", function(s)
        parsed.scheme = s
        return ""
    end)
    
    url_string = string.gsub(url_string, "^//([^/]*)", function(a)
        parsed.authority = a
        return ""
    end)
    
    url_string = string.gsub(url_string, "%?(.*)$", function(q)
        parsed.query = q
        return ""
    end)
    
    url_string = string.gsub(url_string, "%;(.*)$", function(p)
        parsed.params = p
        return ""
    end)
    
    if url_string ~= "" then
        parsed.path = url_string
    end
    
    local authority = parsed.authority
    if not authority then
        return parsed
    end
    
    authority = string.gsub(authority, "^([^@]*)@", function(u)
        parsed.userinfo = u
        return ""
    end)
    
    authority = string.gsub(authority, ":([^:%]]*)$", function(p)
        parsed.port = p
        return ""
    end)
    
    if authority ~= "" then
        local host = string.match(authority, "^%[(.+)%]$")
        parsed.host = host or authority
    end
    
    local userinfo = parsed.userinfo
    if not userinfo then
        return parsed
    end
    
    userinfo = string.gsub(userinfo, ":([^:]*)$", function(p)
        parsed.password = p
        return ""
    end)
    
    parsed.user = userinfo
    
    return parsed
end

function url.build(parsed)
    local ppath = url.parse_path(parsed.path or "")
    local path = url.build_path(ppath)
    
    if parsed.params then
        path = path .. ";" .. parsed.params
    end
    
    if parsed.query then
        path = path .. "?" .. parsed.query
    end
    
    local authority = parsed.authority
    if parsed.host then
        authority = parsed.host
        if string.find(authority, ":") then
            authority = "[" .. authority .. "]"
        end
        if parsed.port then
            authority = authority .. ":" .. parsed.port
        end
        local userinfo = parsed.userinfo
        if parsed.user then
            userinfo = parsed.user
            if parsed.password then
                userinfo = userinfo .. ":" .. parsed.password
            end
        end
        if userinfo then
            authority = userinfo .. "@" .. authority
        end
    end
    
    if authority then
        path = "//" .. authority .. path
    end
    
    if parsed.scheme then
        path = parsed.scheme .. ":" .. path
    end
    
    if parsed.fragment then
        path = path .. "#" .. parsed.fragment
    end
    
    return path
end

function url.absolute(base, relative)
    local base_parsed
    
    if type(base) == "table" then
        base_parsed = base
        base = url.build(base_parsed)
    else
        base_parsed = url.parse(base)
    end
    
    local relative_parsed = url.parse(relative)
    
    if not base_parsed then
        return relative
    elseif not relative_parsed then
        return base
    elseif relative_parsed.scheme then
        return relative
    else
        relative_parsed.scheme = base_parsed.scheme
        
        if not relative_parsed.authority then
            relative_parsed.authority = base_parsed.authority
            
            if not relative_parsed.path then
                relative_parsed.path = base_parsed.path
                if not relative_parsed.params then
                    relative_parsed.params = base_parsed.params
                    if not relative_parsed.query then
                        relative_parsed.query = base_parsed.query
                    end
                end
            else
                relative_parsed.path = absolute_path(base_parsed.path or "", relative_parsed.path)
            end
        end
        
        return url.build(relative_parsed)
    end
end

function url.parse_path(path)
    local parsed = {}
    path = path or ""
    
    string.gsub(path, "([^/]+)", function(s)
        table.insert(parsed, s)
    end)
    
    for i = 1, #parsed do
        parsed[i] = url.unescape(parsed[i])
    end
    
    if string.sub(path, 1, 1) == "/" then
        parsed.is_absolute = 1
    end
    
    if string.sub(path, -1, -1) == "/" then
        parsed.is_directory = 1
    end
    
    return parsed
end

function url.build_path(parsed, unsafe)
    local path = ""
    local n = #parsed
    
    if unsafe then
        for i = 1, n - 1 do
            path = path .. parsed[i] .. "/"
        end
        if n > 0 then
            path = path .. parsed[n]
            if parsed.is_directory then
                path = path .. "/"
            end
        end
    else
        for i = 1, n - 1 do
            path = path .. url.escape_segment(parsed[i]) .. "/"
        end
        if n > 0 then
            path = path .. url.escape_segment(parsed[n])
            if parsed.is_directory then
                path = path .. "/"
            end
        end
    end
    
    if parsed.is_absolute then
        path = "/" .. path
    end
    
    return path
end

return url
