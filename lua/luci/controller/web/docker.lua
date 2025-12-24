module("luci.controller.web.docker", package.seeall)
function index()
    local page   = node("web","docker")
        page.target  = firstchild()
        page.title   = ("")
        page.order   = 100
        page.sysauth = "admin"
        page.sysauth_authenticator = "jsonauth"
        page.index = true
        entry({"web", "docker", "index"}, template("web/docker"), _("axinsTools"), 81)
end
