--[[
================================================================================
cURL 库封装模块 (cURL Library Wrapper)
================================================================================

功能说明：
  本模块是 Lua-cURL 库的主入口，提供 HTTP/HTTPS 网络请求功能。
  它加载底层的 lcurl 库，并使用 cURL.impl.cURL 模块进行封装。

主要功能：
  - HTTP GET/POST 请求
  - HTTPS 安全连接
  - 文件上传/下载
  - Cookie 管理
  - 代理支持
  - 多路复用（Multi）支持

使用示例：
  local cURL = require("cURL")
  
  -- 简单 GET 请求
  local easy = cURL.easy()
  easy:setopt_url("http://example.com")
  easy:perform()
  
  -- POST 请求
  easy:setopt_url("http://example.com/api")
  easy:setopt_postfields("key=value")
  easy:perform()

依赖：
  - lcurl: 底层 C 语言 cURL 绑定
  - cURL.impl.cURL: Lua 层封装实现

================================================================================
--]]

-- 加载底层 lcurl 库
local lcurl = require("lcurl")

-- 加载 cURL 实现模块
local cURLImpl = require("cURL.impl.cURL")

-- 使用 lcurl 初始化并返回 cURL 对象
return cURLImpl(lcurl)
