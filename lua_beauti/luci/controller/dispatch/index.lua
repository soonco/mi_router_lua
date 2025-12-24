-- LuCI 调度控制器索引模块
-- 用于定义 /dispatch 路由节点及其配置

-- 定义模块，使用 package.seeall 使模块可以访问全局环境
module("luci.controller.dispatch.index", package.seeall)

-- 索引函数：定义路由结构和页面入口
-- 该函数会被 LuCI 调度器自动调用以注册路由
function index()
    -- 获取根节点
    local rootNode = node()
    
    -- 如果根节点没有设置目标，则设置默认目标为 "dispatch"
    if not rootNode.target then
        rootNode.target = alias("dispatch")
        rootNode.index = true
    end
    
    -- 创建 "dispatch" 节点
    local dispatchNode = node("dispatch")
    
    -- 设置节点属性
    dispatchNode.target = firstchild()          -- 目标：第一个子节点
    dispatchNode.title = _("")                   -- 标题：空字符串（国际化）
    dispatchNode.order = 1                       -- 排序优先级：1
    dispatchNode.sysauth = "admin"               -- 系统认证：需要 admin 权限
    dispatchNode.mediaurlbase = "/xiaoqiang/dispatch"  -- 媒体资源基础 URL
    dispatchNode.sysauth_authenticator = "htmlauth"    -- 认证方式：HTML 表单认证
    dispatchNode.index = true                    -- 是否为索引节点
    
    -- 注册页面入口
    -- entry(路径, 目标, 标题, 排序, 权限级别)
    entry(
        { "dispatch" },                          -- 路由路径：/dispatch
        template("index"),                       -- 目标：渲染 index 模板
        _("跳转"),                               -- 标题："跳转"（"\232\183\179\232\275\172" 的 UTF-8 解码）
        1,                                       -- 排序优先级：1
        9                                        -- 权限级别：9
    )
end
