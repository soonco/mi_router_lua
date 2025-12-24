--[[
    网络诊断控制器模块 (Network Diagnosis Controller Module)
    
    功能说明:
    - 提供网络诊断相关的页面和API接口
    - 显示网络连接错误信息和解决方案
    
    路由:
    - /diagnosis: 诊断首页
    - /diagnosis/wanerr: WAN口错误信息
    - /diagnosis/errindex: 错误索引页
    
    依赖模块:
    - luci.http: HTTP处理
]]

module("luci.controller.diagnosis.index", package.seeall)

function index()
    local root_node = node()
    if not root_node.target then
        root_node.target = alias("diagnosis")
        root_node.index = true
    end
    
    local diag_node = node("diagnosis")
    diag_node.target = firstchild()
    diag_node.title = _("")
    diag_node.order = 110
    diag_node.sysauth = "admin"
    diag_node.mediaurlbase = "/xiaoqiang/diagnosis"
    diag_node.sysauth_authenticator = "htmlauth"
    diag_node.index = true
    
    entry({"diagnosis"}, template("diagnosis/home"), _("首页"), 1, 9)
    entry({"diagnosis", "wanerr"}, call("action_wanerr"), _(""), 2, 9)
    entry({"diagnosis", "errindex"}, call("action_errindex"), _(""), 3, 9)
end

--[[
    WAN口错误信息API
    
    返回无法访问Internet时的诊断建议
]]
function action_wanerr()
    local result = {
        code = 0,
        data = {
            a = _("无法访问Internet"),
            b = _("1、请确保WAN口已用网线连接到因特网（如入户宽带、光猫等）"),
            c = _("2、请确认网线是否插紧或损坏，光猫是否连接电源"),
            d = _("3、若仍然无法上网，请联系您的宽带运营商"),
            e = _("小米路由器技术支持")
        }
    }
    
    luci.http.write_json(result)
end

--[[
    错误索引页API
    
    返回网络连接问题的诊断入口信息
]]
function action_errindex()
    local result = {
        code = 0,
        data = {
            a = _("对不起，小米路由器出现网络连接问题无法打开网页"),
            b = _("立即进行网络诊断"),
            c = _("小米路由器技术支持")
        }
    }
    
    luci.http.write_json(result)
end
