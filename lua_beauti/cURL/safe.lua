--[[
================================================================================
cURL 安全模式封装模块 (cURL Safe Mode Wrapper)
================================================================================

功能说明：
  本模块是 Lua-cURL 库的安全模式入口。
  与标准 cURL 模块的区别是使用 lcurl.safe 作为底层库，
  提供更安全的错误处理机制。

安全模式特点：
  - 错误不会抛出异常，而是返回 nil 和错误信息
  - 更适合需要优雅处理错误的场景
  - API 与标准 cURL 模块完全兼容

使用示例：
  local cURL = require("cURL.safe")
  
  local easy, err = cURL.easy()
  if not easy then
      print("创建失败:", err)
      return
  end
  
  local ok, err = easy:setopt_url("http://example.com")
  if not ok then
      print("设置 URL 失败:", err)
  end

依赖：
  - lcurl.safe: 底层安全模式 cURL 绑定
  - cURL.impl.cURL: Lua 层封装实现

================================================================================
--]]

-- 加载底层安全模式 lcurl 库
local lcurl = require("lcurl.safe")

-- 加载 cURL 实现模块
local cURLImpl = require("cURL.impl.cURL")

-- 使用安全模式 lcurl 初始化并返回 cURL 对象
return cURLImpl(lcurl)
