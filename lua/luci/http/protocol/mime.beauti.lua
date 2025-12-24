--[[
    LuCI HTTP MIME 类型模块
    用于处理文件扩展名与 MIME 类型的映射
    
    主要功能:
    - 文件扩展名到 MIME 类型的转换
    - MIME 类型到文件扩展名的转换
]]

module("luci.http.protocol.mime", package.seeall)

require("luci.util")

-- MIME 类型映射表
-- 键为文件扩展名，值为对应的 MIME 类型
MIME_TYPES = {
    -- 文本类型
    txt   = "text/plain",
    js    = "text/javascript",
    css   = "text/css",
    htm   = "text/html",
    html  = "text/html",
    patch = "text/x-patch",
    c     = "text/x-csrc",
    h     = "text/x-chdr",
    o     = "text/x-object",
    ko    = "text/x-object",
    
    -- 图片类型
    bmp   = "image/bmp",
    gif   = "image/gif",
    png   = "image/png",
    jpg   = "image/jpeg",
    jpeg  = "image/jpeg",
    svg   = "image/svg+xml",
    
    -- 应用类型
    zip   = "application/zip",
    pdf   = "application/pdf",
    xml   = "application/xml",
    xsl   = "application/xml",
    doc   = "application/msword",
    ppt   = "application/vnd.ms-powerpoint",
    xls   = "application/vnd.ms-excel",
    odt   = "application/vnd.oasis.opendocument.text",
    odp   = "application/vnd.oasis.opendocument.presentation",
    pl    = "application/x-perl",
    sh    = "application/x-shellscript",
    php   = "application/x-php",
    deb   = "application/x-deb",
    iso   = "application/x-cd-image",
    tgz   = "application/x-compressed-tar",
    
    -- 音频类型
    mp3   = "audio/mpeg",
    ogg   = "audio/x-vorbis+ogg",
    wav   = "audio/x-wav",
    
    -- 视频类型
    mpg   = "video/mpeg",
    mpeg  = "video/mpeg",
    avi   = "video/x-msvideo"
}

--[[
    根据文件名或路径获取对应的 MIME 类型
    
    @param filename 文件名或文件路径
    @return MIME 类型字符串，未知类型返回 "application/octet-stream"
]]
function to_mime(filename)
    if type(filename) == "string" then
        -- 提取文件扩展名（最后一个点之后的部分）
        local extension = filename:match("[^%.]+$")
        
        if extension then
            -- 转换为小写并查找对应的 MIME 类型
            local ext_lower = extension:lower()
            local mime_type = MIME_TYPES[ext_lower]
            
            if mime_type then
                return mime_type
            end
        end
    end
    
    -- 默认返回二进制流类型
    return "application/octet-stream"
end

--[[
    根据 MIME 类型获取对应的文件扩展名
    
    @param mime_type MIME 类型字符串
    @return 文件扩展名，未找到返回 nil
]]
function to_ext(mime_type)
    if type(mime_type) == "string" then
        for extension, mime in pairs(MIME_TYPES) do
            if mime == mime_type then
                return extension
            end
        end
    end
    
    return nil
end
