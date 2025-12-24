--[[
  小米路由器版本信息模块
  
  功能说明:
  - 定义Web界面版本号
  - 定义默认路由器IP地址
  - 定义各平台客户端下载地址
  
  版本信息:
  - webVersion: Web界面版本号
  - webDefaultHost: 默认路由器管理地址
  
  客户端下载地址:
  - PC客户端 (Windows)
  - Mac客户端 (macOS)
  - Android客户端 (APK)
]]

module("xiaoqiang.XQVersion")

-- Web界面版本号
webVersion = "0.0.3"

-- 默认路由器管理IP地址
webDefaultHost = "192.168.31.1"

-- PC客户端下载地址 (Windows)
-- 路由器本地下载
pcClientRouter = "http://bigota.miwifi.com/xiaoqiang/client/xqpc_client.exe"
-- 服务器下载
pcClientServer = "http://bigota.miwifi.com/xiaoqiang/client/xqpc_client.exe"

-- Mac客户端下载地址 (macOS)
-- 路由器本地下载
macClientRouter = "http://bigota.miwifi.com/xiaoqiang/client/xqmac_client.dmg"
-- 服务器下载
macClientServer = "http://bigota.miwifi.com/xiaoqiang/client/xqmac_client.dmg"

-- Android客户端下载地址
-- 路由器本地下载路径
androidClientRouter = "/client/xqapp.apk"
-- 服务器下载
androidClientServer = "http://bigota.miwifi.com/xiaoqiang/client/xqapp.apk"
