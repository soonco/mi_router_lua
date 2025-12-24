--[[
    LuaSec SSL/TLS 模块
    提供 SSL/TLS 加密连接功能
    版本: 0.9
]]

-- 导入核心模块
local sslCore = require("ssl.core")
local sslContext = require("ssl.context")
local sslX509 = require("ssl.x509")
local sslConfig = require("ssl.config")

-- 兼容性处理：table.unpack 或 unpack
local unpack = table.unpack or unpack

-- 创建弱引用表，用于存储连接与上下文的关联
local connectionContexts = setmetatable({}, { __mode = "k" })

--[[
    调用函数并处理参数
    支持将表参数展开后传递给函数
    @param func 要调用的函数
    @param params 参数（可以是表或单个值）
    @param context SSL 上下文
    @return 函数调用结果
]]
local function callWithParams(func, params, context)
    if params then
        if type(params) == "table" then
            return func(context, unpack(params))
        else
            return func(context, params)
        end
    end
    return true
end

--[[
    编码 ALPN（应用层协议协商）协议列表
    将协议名称列表编码为 ALPN 格式字符串
    @param protocols 协议名称列表
    @return 编码后的字符串，或 nil 和错误信息
]]
local function encodeALPN(protocols)
    local result = ""
    
    for _, protocol in ipairs(protocols) do
        if type(protocol) ~= "string" then
            return nil
        end
        
        local length = #protocol
        if length == 0 then
            return nil, "invalid ALPN name (empty string)"
        elseif length > 255 then
            return nil, "invalid ALPN name (length > 255)"
        end
        
        result = result .. string.char(length) .. protocol
    end
    
    if result == "" then
        return nil, nil
    end
    
    return result
end

--[[
    解码 ALPN 协议列表
    将 ALPN 格式字符串解码为协议名称列表
    @param encoded 编码的 ALPN 字符串
    @return 协议名称列表
]]
local function decodeALPN(encoded)
    local pos = 1
    local protocols = {}
    
    while pos < #encoded do
        local length = encoded:byte(pos)
        local nextPos = pos + length
        protocols[#protocols + 1] = encoded:sub(pos + 1, nextPos)
        pos = nextPos + 1
    end
    
    return protocols
end

--[[
    创建新的 SSL 上下文
    @param config SSL 配置表
    @return SSL 上下文，或 nil 和错误信息
]]
local function newContext(config)
    local success, errorMsg
    
    -- 创建上下文
    local context, err = sslContext.create(config.mode)
    if not context then
        return nil, err
    end
    
    -- 设置模式
    success, errorMsg = sslContext.setmode(context, config.mode)
    if not success then
        return nil, errorMsg
    end
    
    -- 处理证书配置
    local certificates = config.certificates
    if not certificates then
        certificates = {{
            certificate = config.certificate,
            key = config.key,
            password = config.password
        }}
    end
    
    -- 加载证书和密钥
    for _, cert in ipairs(certificates) do
        -- 加载私钥
        if cert.key then
            if cert.password then
                local pwdType = type(cert.password)
                if pwdType ~= "function" and pwdType ~= "string" then
                    return nil, "invalid password type"
                end
            end
            
            success, errorMsg = sslContext.loadkey(context, cert.key, cert.password)
            if not success then
                return nil, errorMsg
            end
        end
        
        -- 加载证书
        if cert.certificate then
            success, errorMsg = sslContext.loadcert(context, cert.certificate)
            if not success then
                return nil, errorMsg
            end
            
            -- 验证密钥与证书是否匹配
            if cert.key and sslContext.checkkey then
                success = sslContext.checkkey(context)
                if not success then
                    return nil, "private key does not match public key"
                end
            end
        end
    end
    
    -- 加载 CA 证书路径
    if config.cafile or config.capath then
        success, errorMsg = sslContext.locations(context, config.cafile, config.capath)
        if not success then
            return nil, errorMsg
        end
    end
    
    -- 设置验证模式
    if config.verify then
        success, errorMsg = sslContext.setverify(context, config.verify)
        if not success then
            return nil, errorMsg
        end
    end
    
    -- 设置验证深度
    if config.depth then
        success, errorMsg = sslContext.setdepth(context, config.depth)
        if not success then
            return nil, errorMsg
        end
    end
    
    -- 设置选项
    if config.options then
        success, errorMsg = sslContext.setoptions(context, config.options)
        if not success then
            return nil, errorMsg
        end
    end
    
    -- 设置密码套件
    if config.ciphers then
        success, errorMsg = sslContext.setcipher(context, config.ciphers)
        if not success then
            return nil, errorMsg
        end
    end
    
    -- 设置 DH 参数
    if config.dhparam then
        success, errorMsg = sslContext.setdh(context, config.dhparam)
        if not success then
            return nil, errorMsg
        end
    end
    
    -- 设置验证回调
    if config.verifyext and type(config.verifyext) == "function" then
        sslContext.setverifyext(context, config.verifyext)
    end
    
    -- 设置曲线
    if config.curve then
        success, errorMsg = sslContext.setcurve(context, config.curve)
        if not success then
            return nil, errorMsg
        end
    end
    
    -- 设置曲线列表
    if config.curveslist then
        success, errorMsg = sslContext.setcurveslist(context, config.curveslist)
        if not success then
            return nil, errorMsg
        end
    end
    
    -- 处理 ALPN（服务器模式）
    if config.mode == "server" and config.alpn then
        if type(config.alpn) == "function" then
            -- ALPN 回调函数
            local alpnCallback = function(clientProtocols)
                local decoded = decodeALPN(clientProtocols)
                local selected = config.alpn(decoded)
                
                if type(selected) == "string" then
                    selected = { selected }
                elseif type(selected) ~= "table" then
                    return nil
                end
                
                return encodeALPN(selected)
            end
            
            success, errorMsg = sslContext.setalpn(context, alpnCallback)
            if not success then
                return nil, errorMsg
            end
        elseif type(config.alpn) == "table" then
            -- ALPN 协议列表
            local encoded, err = encodeALPN(config.alpn)
            if not encoded then
                return nil, err
            end
            
            local alpnCallback = function()
                return encoded
            end
            
            success, errorMsg = sslContext.setalpn(context, alpnCallback)
            if not success then
                return nil, errorMsg
            end
        else
            return nil, "invalid alpn type"
        end
    -- 处理 ALPN（客户端模式）
    elseif config.mode == "client" and config.alpn then
        local protocols
        if type(config.alpn) == "string" then
            protocols = { config.alpn }
        elseif type(config.alpn) == "table" then
            protocols = config.alpn
        else
            return nil, "invalid alpn type"
        end
        
        local encoded, err = encodeALPN(protocols)
        if not encoded then
            return nil, err
        end
        
        success, errorMsg = sslContext.setalpncb(context, encoded)
        if not success then
            return nil, errorMsg
        end
    end
    
    -- 设置 SNI 回调
    if config.sni and type(config.sni) == "function" then
        sslContext.setsni(context, config.sni)
    end
    
    return context
end

--[[
    包装 socket 为 SSL 连接
    @param socket 原始 socket 对象
    @param params SSL 配置或上下文
    @return SSL 连接对象，或 nil 和错误信息
]]
local function wrap(socket, params)
    local context, errorMsg
    
    -- 如果参数是表，则创建新上下文
    if type(params) == "table" then
        context, errorMsg = newContext(params)
        if not context then
            return nil, errorMsg
        end
    else
        context = params
    end
    
    -- 创建 SSL 连接
    local sslConnection, err = sslCore.create(context)
    if sslConnection then
        -- 将原始 socket 的文件描述符传递给 SSL 连接
        sslCore.setfd(sslConnection, socket:getfd())
        socket:setfd(sslCore.SOCKET_INVALID)
        
        -- 保存上下文引用
        connectionContexts[sslConnection] = context
        
        return sslConnection
    end
    
    return nil, err
end

--[[
    获取 SSL 连接信息
    @param connection SSL 连接对象
    @param field 要获取的字段名（可选）
    @return 连接信息表或指定字段值
]]
local function getInfo(connection, field)
    -- 获取压缩信息
    local compression, err = sslCore.compression(connection)
    if err then
        return compression, err
    end
    
    if field == "compression" then
        return compression
    end
    
    -- 构建信息表
    local info = {
        compression = compression
    }
    
    -- 获取加密信息
    local cipher, bits, algbits, protocol = sslCore.info(connection)
    info.bits = bits
    info.algbits = algbits
    
    if cipher then
        -- 解析密码套件详细信息
        local cipherName, cipherProtocol, keyExchange, auth, encryption, mac = 
            string.match(cipher, "^(%S+)%s+(%S+)%s+Kx=(%S+)%s+Au=(%S+)%s+Enc=(%S+)%s+Mac=(%S+)")
        
        info.cipher = cipherName
        info.protocol = cipherProtocol
        info.key = keyExchange
        info.authentication = auth
        info.encryption = encryption
        info.mac = mac
        
        -- 检查是否为导出级密码
        info.export = string.match(cipher, "%sexport%s*$") ~= nil
    end
    
    if protocol then
        info.protocol = protocol
    end
    
    -- 返回指定字段或整个信息表
    if field then
        return info[field]
    end
    
    return next(info) and info
end

-- 注册 info 方法到 SSL 核心
sslCore.setmethod("info", getInfo)

-- 导出模块
local ssl = {
    _VERSION = "0.9",
    _COPYRIGHT = sslCore.copyright(),
    config = sslConfig,
    loadcertificate = sslX509.load,
    newcontext = newContext,
    wrap = wrap
}

return ssl
