---
--- 小米路由器MIPCTL控制面板模块
--- 模块路径: luci.controller.mipctl.index
---
--- 功能概述:
---   提供MIPCTL管理界面的路由配置
---   MIPCTL是小米路由器的设备控制面板
---
--- 页面路由:
---   /mipctl - MIPCTL主页面(使用mipctl/home模板)
---
--- 依赖模块:
---   无外部依赖
---

module("luci.controller.mipctl.index", package.seeall)

--- 模块路由注册入口
function index()
    --- 创建MIPCTL节点
    local mipctlNode = node("mipctl")
    mipctlNode.target = firstchild()
    mipctlNode.title = _("")
    mipctlNode.order = 110
    mipctlNode.sysauth = "admin"                   -- 需要管理员认证
    mipctlNode.mediaurlbase = "/xiaoqiang/mipctl"  -- 静态资源基础路径
    mipctlNode.sysauth_authenticator = "htmlauth"  -- HTML表单认证方式
    mipctlNode.index = true

    --- 注册MIPCTL主页面路由
    --- 使用模板渲染方式
    entry({"mipctl"}, template("mipctl/home"), _(""), 1, 13)
end
