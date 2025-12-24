--[[
    API控制器索引模块 (API Controller Index Module)
    
    功能说明:
    - API模块的根节点定义
    - 设置API的默认认证方式
    - 所有/api/*路由的父节点
    
    认证方式:
    - sysauth: admin (需要管理员权限)
    - sysauth_authenticator: jsonauth (JSON格式认证)
]]

module("luci.controller.api.index", package.seeall)

--[[
    路由索引函数
    
    定义API根节点的属性
]]
function index()
    local api_node = node("api")
    api_node.target = firstchild()
    api_node.title = _("")
    api_node.order = 10
    api_node.sysauth = "admin"
    api_node.sysauth_authenticator = "jsonauth"
    api_node.index = true
end
