---
--- 小米路由器服务模块索引
--- 模块路径: luci.controller.service.index
---
--- 功能概述:
---   服务模块的根节点配置
---   作为service子模块的入口点
---
--- 子模块:
---   - service/cachecenter: 缓存中心服务
---   - service/datacenter: 数据中心服务
---   - service/internal: 内部服务接口
---
--- 依赖模块:
---   无外部依赖
---

module("luci.controller.service.index", package.seeall)

--- 模块路由注册入口
function index()
    --- 创建服务模块根节点
    local serviceNode = node("service")
    serviceNode.target = firstchild()
    serviceNode.title = _("")
    serviceNode.order = nil
    serviceNode.sysauth = "admin"                   -- 需要管理员认证
    serviceNode.sysauth_authenticator = "jsonauth"  -- JSON认证方式
    serviceNode.index = true
end
