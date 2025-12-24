--[[
    服务错误工具模块
    提供统一的错误码和错误消息管理
    用于将错误码转换为用户友好的错误提示信息
]]

module("service.util.ServiceErrorUtil", package.seeall)

--[[
    根据错误码获取对应的错误消息
    @param errorCode 错误码（数字）
    @return 翻译后的错误消息字符串
]]
function getErrorMessage(errorCode)
    -- 错误码与错误消息的映射表
    local ERROR_MESSAGES = {
        -- 通用错误
        [0]    = _(""),                           -- 无错误/成功
        [1]    = _("parameter missing"),          -- 参数缺失
        [2]    = _("Parameter empty"),            -- 参数为空
        [3]    = _("Parameter format error"),     -- 参数格式错误
        [5]    = _("invalid app id"),             -- 无效的应用 ID
        
        -- 设备相关错误
        [1056] = _("invalid device id"),          -- 无效的设备 ID
        [1057] = _("resource is not ready"),      -- 资源未就绪
        
        -- 数据中心错误
        [1559] = _("datacenter error"),           -- 数据中心错误
        [2010] = _("datacenter error"),           -- 数据中心错误
    }
    
    -- 查找错误消息
    local errorMessage = ERROR_MESSAGES[errorCode]
    
    if errorMessage == nil then
        -- 未知错误码，返回默认的"未知错误"消息
        -- 原始字符串: "未知错误" (UTF-8 编码)
        return translate(_("未知错误"))
    else
        -- 返回对应的错误消息
        return translate(errorMessage)
    end
end
