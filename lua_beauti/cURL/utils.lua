--[[
================================================================================
cURL 工具函数模块 (cURL Utilities Module)
================================================================================

功能说明：
  本模块提供 cURL 库的辅助工具函数，主要用于：
  - 查找系统 CA 证书包（用于 HTTPS 验证）
  - 字符串分割等辅助功能

主要接口：
  - utils.find_ca_bundle(filename) : 查找 CA 证书文件路径

CA 证书查找顺序：
  1. 环境变量 CURL_CA_BUNDLE
  2. 环境变量 SSL_CERT_DIR（目录）
  3. 环境变量 SSL_CERT_FILE
  4. Windows 系统目录（System32、SysWOW64 等）
  5. PATH 环境变量中的目录

================================================================================
--]]

--[[
--------------------------------------------------------------------------------
函数: find_ca_bundle(filename)
--------------------------------------------------------------------------------
功能: 查找系统中的 CA 证书包文件

参数:
  filename - 要查找的证书文件名（可选，默认查找标准位置）

返回值:
  string - CA 证书文件的完整路径
  或
  nil, string - 如果找到的是目录，返回 nil 和目录路径

说明:
  此函数按以下顺序查找 CA 证书：
  1. CURL_CA_BUNDLE 环境变量指定的文件
  2. SSL_CERT_DIR 环境变量指定的目录
  3. SSL_CERT_FILE 环境变量指定的文件
  4. Windows 系统目录
  5. PATH 中的各个目录

  在 HTTPS 请求时，cURL 需要 CA 证书来验证服务器身份。
--------------------------------------------------------------------------------
--]]
local function find_ca_bundle(filename)
    filename = filename or "ca-bundle.crt"
    
    local path = require("path")
    
    local env = setmetatable({}, { __index = _G })
    
    local function split(str, sep, plain)
        local pos = 1
        local result = {}
        
        while pos <= #str do
            local startPos, endPos = string.find(str, sep, pos, plain)
            if startPos then
                table.insert(result, string.sub(str, pos, startPos - 1))
                pos = endPos + 1
            else
                table.insert(result, string.sub(str, pos))
                break
            end
        end
        
        return result
    end
    
    if env.CURL_CA_BUNDLE then
        if path.isfile(env.CURL_CA_BUNDLE) then
            return env.CURL_CA_BUNDLE
        end
    end
    
    if env.SSL_CERT_DIR then
        if path.isdir(env.SSL_CERT_DIR) then
            return nil, env.SSL_CERT_DIR
        end
    end
    
    if env.SSL_CERT_FILE then
        if path.isfile(env.SSL_CERT_FILE) then
            return env.SSL_CERT_FILE
        end
    end
    
    if not path.IS_WINDOWS then
        return nil
    end
    
    local searchPaths = {
        path.join(env.windir or "", "System32"),
        path.join(env.windir or "", "SysWOW64"),
    }
    
    local pathDirs = split(env.PATH or "", ";")
    for _, dir in ipairs(pathDirs) do
        searchPaths[#searchPaths + 1] = dir
    end
    
    for _, searchDir in ipairs(searchPaths) do
        local fullPath = path.fullpath(searchDir)
        if path.isdir(fullPath) then
            local certPath = path.join(fullPath, filename)
            if path.isfile(certPath) then
                return certPath
            end
        end
    end
    
    return nil
end

local utils = {}
utils.find_ca_bundle = find_ca_bundle

return utils
