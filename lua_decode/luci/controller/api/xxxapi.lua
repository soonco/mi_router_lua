module("luci.controller.api.xxxapi", package.seeall)

function index()
    local page   = node("api","xxxapi")
    page.target  = firstchild()
    page.title   = ("")
    page.order   = 300
    page.sysauth = "admin"
    page.sysauth_authenticator = "jsonauth"
    page.index = true
    entry({"api", "xxxapi"}, firstchild(), _(""), 300)
    entry({"api", "xxxapi", "xxxinfo"}, call("xxxinfo"), _(""), 301)
    entry({"api", "xxxapi", "download"}, call("xxxload"), _(""), 302)
    entry({"api", "xxxapi", "disk_info"}, call("get_disk_info_html"), _(""), 303)
    entry({"api", "xxxapi", "xxx_json"}, call("xxx_json"), _(""), 304)
    entry({"api", "xxxapi", "box_load"}, call("box_load"), _(""), 305)
    entry({"api", "xxxapi", "box_exec"}, call("box_exec"), _(""), 306)
    entry({"api", "xxxapi", "get_dhcp_mac"}, call("get_dhcp_mac"), _(""), 307)
    entry({"api", "xxxapi", "get_firewall"}, call("get_firewall"), _(""), 308)
    entry({"api", "xxxapi", "xxx_save"}, call("xxx_save"), _(""), 309)
    entry({"api", "xxxapi", "sys_info"}, call("sys_info"), _(""), 310)
    entry({"api", "xxxapi", "get_info"}, call("get_info"), _(""), 310)
    entry({"api", "xxxapi", "get_xjc"}, call("get_xjc"), _(""), 310)
    entry({"api", "xxxapi", "get_opkg_list"}, call("get_opkg_list"), _(""), 310)
    entry({"api", "xxxapi", "get_opkg_all_list"}, call("get_opkg_all_list"), _(""), 310)
    entry({"api", "xxxapi", "xxx_exec"}, call("xxx_exec"), _(""), 310)
    entry({"api", "xxxapi", "ssh_exec"}, call("ssh_exec"), _(""), 310)
    entry({"api", "xxxapi", "opkg_exc"}, call("opkg_exc"), _(""), 310)
    entry({"api", "xxxapi", "set_opkg_path"}, call("set_opkg_path"), _(""), 310)
    entry({"api", "xxxapi", "get_route"}, call("get_route"), _(""), 310)
    entry({"api", "xxxapi", "route_form_sub"}, call("route_form_sub"), _(""), 310)
    entry({"api", "xxxapi", "xxxboxfunc"}, call("xxxboxfunc"), _(""), 310)
    entry({"api", "xxxapi", "get_dhcp"}, call("get_dhcp"), _(""), 310)
    entry({"api", "xxxapi", "get_network"}, call("get_network"), _(""), 310)
    entry({"api", "xxxapi", "get_wireless"}, call("get_wireless"), _(""), 310)
    entry({"api", "xxxapi", "network_form_sub"}, call("network_form_sub"), _(""), 310)
    entry({"api", "xxxapi", "wireless_form_sub"}, call("wireless_form_sub"), _(""), 310)
    entry({"api", "xxxapi", "dhcp_form_sub"}, call("dhcp_form_sub"), _(""), 310)
    entry({"api", "xxxapi", "firewall_zone_form_sub"}, call("firewall_zone_form_sub"), _(""), 310)
    entry({"api", "xxxapi", "firewall_rule_form_sub"}, call("firewall_rule_form_sub"), _(""), 310)
    entry({"api", "xxxapi", "net_save"}, call("net_save"), _(""), 310)
end

local LuciHttp = require("luci.http")
local LuciJson = require("json")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQErrorUtil = require("xiaoqiang.util.XQErrorUtil")

-- 截取中间字符串
local function Str_Cut(str, s_begin, s_end)
	local StrLen = string.len(str)
	local s_begin_Len = string.len(s_begin)
	local s_end_Len = string.len(s_end)
	local s_begin_x = string.find(str, s_begin, 1)
	if not s_begin_x then
		s_begin_x = 0
	end
	local s_end_x = string.find(str, s_end, s_begin_x + 1)
	if not s_end_x then
		s_end_x = StrLen + 1
	end
	local rs = (string.sub(str, s_begin_x + s_begin_Len, s_end_x - 1))
	return rs
end

-- base64编码
local base_tmp = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding
local function base64_enc(data)
	return ((data:gsub('.', function(x)
		local r, base_tmp = '', x:byte()
		for i = 8, 1, - 1 do
			r = r .. (base_tmp % 2 ^ i - base_tmp % 2 ^ (i - 1) > 0 and '1' or '0')
		end
		return r;
	end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (# x < 6) then
			return ''
		end
		local c = 0
		for i = 1, 6 do
			c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0)
		end
		return base_tmp:sub(c + 1, c + 1)
	end) .. ({
		'',
		'==',
		'='
	})[# data % 3 + 1])
end

-- base64解码
local function base64_dec(data)
	data = string.gsub(data, '[^' .. base_tmp .. '=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then
			return ''
		end
		local r, f = '', (base_tmp:find(x) - 1)
		for i = 6, 1, - 1 do
			r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0')
		end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (# x ~= 8) then
			return ''
		end
		local c = 0
		for i = 1, 8 do
			c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0)
		end
		return string.char(c)
	end))
end

-- URL解码
local function urlDecode(s)
	s = string.gsub(s, '%%(%x%x)', function(h)
		return string.char(tonumber(h, 16))
	end)
	return s
end

-- 文件判断
function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- 定义变量
local xxx_path = luci.sys.exec("echo -n $(uci get lyq.xxx_path)");
if xxx_path == "" then
	xxx_path = "/data"
end
local xxx_list_file_path = xxx_path .. "/xxxweb/xxx.json"
--文件操作
-- 1    xxx        xxx数据文件
-- 2    user_auto  开机自启数据文件
-- 3    distfeeds  OPKG链接数据文件
-- 4    fstab      开机挂载数据文件
-- 5    auto_start 硬盘自启数据文件
local mtd="/mnt/mtd/box/"
local sda="/mnt/sda/mi_box/"
file_path_arr = {xxx_path.."/xxxweb/xxx.json",xxx_path.."/xxxcon/user_auto.sh","/etc/opkg/distfeeds.conf","/etc/fstab","/mnt/docker_disk/auto_start.sh",xxx_path.."/xxxcon/box_list.json",xxx_path.."/xxxcon/usr_lib/lua/luci/view/zt_exc_cy.htm",xxx_path.."/xxxcon/usr_lib/lua/luci/view/zt_exc_jb.htm"}
local xxx_id=tonumber(luci.http.formvalue("xxx_save_id"))

-- 指令合集
function get_dhcp_mac()
	local leases = luci.sys.exec("cat /tmp/dhcp.leases")
	leases = string.gsub(leases, "\r\n", "!@.@!")
	leases = string.gsub(leases, "\n", "!@.@!")
	local mac_list = string.split(leases, '!@.@!')
	mac_json_tmp = "["
	mac_list_tmp = ""
	mac_tmp = ""
	for i = 1, # mac_list - 1, 1 do
		mac_list_tmp = string.split(mac_list[i], " ")
		random = math.random(9) .. math.random(9) .. math.random(9) .. math.random(9)
		mac_tmp = mac_tmp .. "{\"time\":\"" .. mac_list_tmp[1] .. "_" .. random .. "\",\"data\":\"" .. mac_list_tmp[2] .. "\",\"tag\":\"" .. mac_list_tmp[3] .. "\",\"name\":\"" .. mac_list_tmp[4] .. "\",\"title\": \"\",\"class\": \"mac\"},"
	end
	mac_json_tmp = mac_json_tmp .. mac_tmp .. "]"
	mac_json_tmp = string.gsub(mac_json_tmp, "},]", "}]")
	luci.http.write(mac_json_tmp)
	luci.http.close()
end

-- 获取信息
function get_info()
	if luci.sys.exec("echo -n $(mpstat | awk '{print $11}' | sed -n '4p')") ~= "" then
		LuciHttp.write_json(luci.sys.exec("echo -n {'\"'info'\"':[$(ubus call trafficd wan),$(ubus call system info),{$(echo \\\"cpu\\\":\"$(echo -n $(mpstat | awk '{print $11}' | sed -n '4p'))\")},$(ubus call trafficd hw)]}"))
	else
		LuciHttp.write_json(luci.sys.exec("echo -n {'\"'info'\"':[$(ubus call trafficd wan),$(ubus call system info),{$(echo \\\"cpu\\\":\"$(mpstat -o JSON | grep idle | jsonfilter -e '@.idle')\")},$(ubus call trafficd hw)]}"))
	end
	luci.http.close()
end

-- 获取opkg list
function get_opkg_list()
	-- LuciHttp.write(luci.sys.exec("cat /usr/lib/opkg/status | sed 's/: /\":\"/g' | sed 's/^/\"/g' | sed 's/$/\",/g' | sed 's/\"\"/},{/g' | sed '1d' | sed '$d' | sed '1s/^/{/' | sed '$a\}' | sed ':a;N;$!ba;s/,\\n},{,/}|\\/|\\/|{/g' | sed 's/,},{,/},{/' | sed ':a;N;$!ba;s/,\\n}/}/g'"))
	LuciHttp.write(luci.sys.exec("echo {$(opkg list-installed  | grep ' - ' | sed 's/ - /\\t/g'  | awk '{print $1\":::\"$2}' | sed 's/:::/\":\"/g' | sed ':a;N;$!ba;s/\\n/\",\\n/g' | sed 's/^/\"/g')\\\"}"))
	luci.http.close()
end

-- 获取opkg all list
function get_opkg_all_list()
	local opkg_abcef_butt_set = luci.http.formvalue("opkg_abcef_butt_set")
	LuciHttp.write(luci.sys.exec("echo {$(opkg list | grep ' - ' | grep -i '^"..opkg_abcef_butt_set.."' | sed 's/ - /\\t/g'  | awk '{print $1\":::\"$2}' | sed 's/:::/\":\"/g' | sed ':a;N;$!ba;s/\\n/\",\\n/g' | sed 's/^/\"/g')\\\"}"))
	luci.http.close()
end

-- 获取网页所需
function get_xjc()
	local p = luci.http.formvalue("p")
	LuciHttp.write(io.open(xxx_path.."/xxxweb/xjc/"..p):read("*a"))
	io.close()
	luci.http.close()
end

-- 获取get_route列表
function get_route()
	luci.http.write(luci.sys.exec("route"))
	luci.http.close()
end

-- 获取get_dhcp列表
function get_dhcp()
	dhcp_list=luci.sys.exec("uci show dhcp | grep -v \"='\"")
	local dhcp_list_arr = string.split(dhcp_list, '\n')
	json=""
	for i = 1, # dhcp_list_arr - 1, 1 do
		if json ~= "" then json=json.."," end
		dhcp_conf = string.split(dhcp_list_arr[i], "=")
		dhcp_section=dhcp_conf[1]
		dhcp_class=dhcp_conf[2]
		dhcp_cname=string.split(dhcp_conf[1], ".")[2]
		dhcp_interface=luci.sys.exec("echo -n $(uci get "..dhcp_section..".interface)")
		dhcp_addr=luci.sys.exec("echo -n $(uci get network."..dhcp_interface..".ipaddr)")
		if(dhcp_addr=="") then
			dhcp_addr=luci.sys.exec("echo -n $(ubus call network.interface."..dhcp_interface.." status | grep 'address' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')")
		end
		dhcp_start=luci.sys.exec("echo -n $(uci get "..dhcp_section..".start)")
		dhcp_limit=luci.sys.exec("echo -n $(uci get "..dhcp_section..".limit)")
		dhcp_leasetime=luci.sys.exec("echo -n $(uci get "..dhcp_section..".leasetime)")		json=json..'{"dhcp_class":"'..dhcp_class..'","dhcp_addr":"'..dhcp_addr..'","dhcp_cname":"'..dhcp_cname..'","dhcp_interface":"'..dhcp_interface..'","dhcp_start":"'..dhcp_start..'","dhcp_limit":"'..dhcp_limit..'","dhcp_leasetime":"'..dhcp_leasetime..'"}'
	end
	luci.http.write('{"list":['..json..']}')
	luci.http.close()
end

-- 获取get_network列表
function get_network()
	network_list=luci.sys.exec("uci show network | grep -v \"='\"")
	local network_list_arr = string.split(network_list, '\n')
	json=""
	for i = 1, # network_list_arr - 1, 1 do
		if json ~= "" then json=json.."," end
		network_conf = string.split(network_list_arr[i], "=")
		network_section=network_conf[1]
		network_class=network_conf[2]
		network_cname=string.split(network_conf[1], ".")[2]
		network_ifname=luci.sys.exec("echo -n $(uci get "..network_section..".ifname)")
		network_addr=luci.sys.exec("echo -n $(uci get "..network_section..".ipaddr)")
		if(network_addr=="") then
			network_addr=luci.sys.exec("echo -n $(ubus call network.interface."..network_cname.." status | grep 'address' | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')")
		end
		network_macaddr=luci.sys.exec("echo -n $(uci get "..network_section..".macaddr)")
		network_proto=luci.sys.exec("echo -n $(uci get "..network_section..".proto)")
		network_netmask=luci.sys.exec("echo -n $(uci get "..network_section..".netmask)")
		if(network_netmask=="") then
			network_netmask=luci.sys.exec("echo -n $(ubus call network.interface."..network_cname.." status | grep 'mask' | grep -oE '[0-9]{1,3}' | head -n 1)")
		end	json=json..'{"network_class":"'..network_class..'","network_addr":"'..network_addr..'","network_cname":"'..network_cname..'","network_ifname":"'..network_ifname..'","network_macaddr":"'..network_macaddr..'","network_proto":"'..network_proto..'","network_netmask":"'..network_netmask..'"}'
	end
	luci.http.write('{"list":['..json..']}')
	luci.http.close()
end



-- 获取get_wireless列表
function get_wireless()
	wireless_list=luci.sys.exec("uci show wireless | grep -v \"='\"")
	local wireless_list_arr = string.split(wireless_list, '\n')
	json=""
	for i = 1, # wireless_list_arr - 1, 1 do
		if json ~= "" then json=json.."," end
		wireless_conf = string.split(wireless_list_arr[i], "=")
		wireless_section=wireless_conf[1]
		wireless_class=wireless_conf[2]
		wireless_cname=string.split(wireless_conf[1], ".")[2]
		wireless_ifname=luci.sys.exec("echo -n $(uci get "..wireless_section..".ifname)")
		wireless_network=luci.sys.exec("echo -n $(uci get "..wireless_section..".network)")
		wireless_device=luci.sys.exec("echo -n $(uci get "..wireless_section..".device)")
		wireless_mode=luci.sys.exec("echo -n $(uci get "..wireless_section..".mode)")
		wireless_ssid=luci.sys.exec("echo -n $(uci get "..wireless_section..".ssid)")
		wireless_hidden=luci.sys.exec("echo -n $(uci get "..wireless_section..".hidden)")
		wireless_key=luci.sys.exec("echo -n $(uci get "..wireless_section..".key)")	json=json..'{"wireless_class":"'..wireless_class..'","wireless_network":"'..wireless_network..'","wireless_cname":"'..wireless_cname..'","wireless_ifname":"'..wireless_ifname..'","wireless_device":"'..wireless_device..'","wireless_hidden":"'..wireless_hidden..'","wireless_mode":"'..wireless_mode..'","wireless_key":"'..wireless_key..'","wireless_ssid":"'..wireless_ssid..'"}'
	end
	luci.http.write('{"list":['..json..']}')
	luci.http.close()
end

-- 获取get_firewall列表
function get_firewall()
	firewall_list=luci.sys.exec("uci show firewall | grep -v \"='\"")
	local firewall_list_arr = string.split(firewall_list, '\n')
	json=""
	for i = 1, # firewall_list_arr - 1, 1 do
		if json ~= "" then json=json.."," end
		firewall_conf = string.split(firewall_list_arr[i], "=")
		firewall_section=firewall_conf[1]
		firewall_class=firewall_conf[2]
		firewall_cname=string.split(firewall_conf[1], ".")[2]
		firewall_title=luci.sys.exec("echo -n $(uci get "..firewall_section..".name)")

		firewall_src=luci.sys.exec("echo -n $(uci get "..firewall_section..".src)")
		firewall_src_port=luci.sys.exec("echo -n $(uci get "..firewall_section..".src_port)")
		firewall_dest=luci.sys.exec("echo -n $(uci get "..firewall_section..".dest)")
		firewall_dest_port=luci.sys.exec("echo -n $(uci get "..firewall_section..".dest_port)")

		firewall_proto=luci.sys.exec("echo -n $(uci get "..firewall_section..".proto)")

		firewall_target=luci.sys.exec("echo -n $(uci get "..firewall_section..".target)")

		firewall_input=luci.sys.exec("echo -n $(uci get "..firewall_section..".input)")
		firewall_forward=luci.sys.exec("echo -n $(uci get "..firewall_section..".forward)")
		firewall_output=luci.sys.exec("echo -n $(uci get "..firewall_section..".output)")

		firewall_network=luci.sys.exec("echo -n $(uci get "..firewall_section..".network)")
		firewall_family=luci.sys.exec("echo -n $(uci get "..firewall_section..".family)")

		json=json..'{"firewall_class":"'..firewall_class..'","firewall_network":"'..firewall_network..'","firewall_cname":"'..firewall_cname..'","firewall_title":"'..firewall_title..'","firewall_src":"'..firewall_src..'","firewall_src_port":"'..firewall_src_port..'","firewall_dest":"'..firewall_dest..'","firewall_dest_port":"'..firewall_dest_port..'","firewall_proto":"'..firewall_proto..'","firewall_target":"'..firewall_target..'","firewall_input":"'..firewall_input..'","firewall_forward":"'..firewall_forward..'","firewall_output":"'..firewall_output..'","firewall_network":"'..firewall_network..'","firewall_family":"'..firewall_family..'"}'
	end
	luci.http.write('{"list":['..json..']}')
	luci.http.close()
end
-- route表单提交
function route_form_sub()
	rtype = luci.http.formvalue("type")
	route_cname = luci.http.formvalue("route_cname")
	route_Destination = luci.http.formvalue("route_Destination")
	route_Gateway = luci.http.formvalue("route_Gateway")
	route_Genmask = luci.http.formvalue("route_Genmask")
	route_Metric = luci.http.formvalue("route_Metric")
	if route_Destination ~= "" then Destination = " -net "..route_Destination else rtype = "" end
	if rtype == "新增" then
		if route_Genmask ~= "" then  Genmask = " netmask "..route_Genmask else Genmask = "" end
		if route_Gateway ~= "" then Gateway = " gw "..route_Gateway else Gateway = "" end
		if route_Metric ~= "0" then  Metric = " metric "..route_Metric else Metric = "" end
		luci.http.write("route add "..Destination..Genmask..Gateway..Metric)
		luci.http.write(luci.sys.exec("route add "..Destination..Genmask..Gateway..Metric))
	elseif rtype == "保存" then
		if route_Genmask ~= "" then  Genmask = " netmask "..route_Genmask else Genmask =  "" end
		luci.http.write(luci.sys.exec("route del  -net "..route_cname..Genmask))
		if route_Genmask ~= "" then  Genmask = " netmask "..route_Genmask else Genmask = "" end
		if route_Gateway ~= "" then Gateway = " gw "..route_Gateway else Gateway = "" end
		if route_Metric ~= "0" then  Metric = " metric "..route_Metric else Metric = "" end
		luci.http.write(luci.sys.exec("route add "..Destination..Genmask..Gateway..Metric.." && echo 保存完成 || echo 保存失败"))
	elseif rtype == "删除" then
		if route_Genmask ~= "" then  Genmask = " netmask  "..route_Genmask else Genmask =  "" end
		luci.http.write(luci.sys.exec("route del -net "..route_cname..Genmask.." && echo 删除完成 || echo 删除失败"))
	else
		luci.http.write("提交无效")
	end
	luci.http.close()
end

-- 接口设置表单提交
function network_form_sub()
	rtype = luci.http.formvalue("type")
	cname = luci.http.formvalue("network_cname")
	addr = luci.http.formvalue("network_addr")
	name = luci.http.formvalue("network_name")
	ifname = luci.http.formvalue("network_ifname")
	netmask = luci.http.formvalue("network_netmask")
	macaddr = luci.http.formvalue("network_macaddr")
	luci.sys.exec("rm -rf /tmp/.uci")
	if rtype == "新增" then
		cname2="network."..cname
		ipaddr2="grep -v network."..cname..".ipaddr="
		ifname2="grep -v network."..cname..".ifname="
		netmask2="grep -v network."..cname..".netmask="
		macaddr2="grep -v network."..cname..".macaddr="
		luci.sys.exec("sh -c \"$(uci show "..cname2.." | "..ipaddr2.." | "..ifname2.." | "..netmask2.." | "..macaddr2.." | sed 's/"..cname2.."/network."..name.."/g' | sed 's/^/uci set /')\"")
		luci.sys.exec("sh -c \"$(uci set network."..name..".ipaddr='"..addr.."')\"")
		luci.sys.exec("sh -c \"$(uci set network."..name..".ifname='"..ifname.."')\"")
		luci.sys.exec("sh -c \"$(uci set network."..name..".netmask='"..netmask.."')\"")
		luci.sys.exec("sh -c \"$(uci set network."..name..".macaddr='"..macaddr.."')\"")
	elseif rtype == "保存" then
		luci.sys.exec("sh -c \"$(uci set network."..name..".ipaddr='"..addr.."')\"")
		luci.sys.exec("sh -c \"$(uci set network."..name..".ifname='"..ifname.."')\"")
		luci.sys.exec("sh -c \"$(uci set network."..name..".netmask='"..netmask.."')\"")
		luci.sys.exec("sh -c \"$(uci set network."..name..".macaddr='"..macaddr.."')\"")
	elseif rtype == "删除" then
		luci.sys.exec("uci delete network."..cname)
	else
		luci.http.write("提交无效"..rtype)
	end
	luci.http.write(luci.sys.exec("uci changes"))
	luci.http.close()
end


-- 接口设置表单提交
function wireless_form_sub()
	rtype = luci.http.formvalue("type")
	cname = luci.http.formvalue("wireless_cname")
	name = luci.http.formvalue("wireless_name")
	device = luci.http.formvalue("wireless_device")
	ifname = luci.http.formvalue("wireless_ifname")
	network = luci.http.formvalue("wireless_network")
	hidden = luci.http.formvalue("wireless_hidden")
	ssid = luci.http.formvalue("wireless_ssid")
	key = luci.http.formvalue("wireless_key")
	luci.sys.exec("rm -rf /tmp/.uci")
	if rtype == "新增" then
		cname2="wireless."..cname
		device2="grep -v wireless."..cname..".device="
		ifname2="grep -v wireless."..cname..".ifname="
		network2="grep -v wireless."..cname..".network="
		hidden2="grep -v wireless."..cname..".hidden="
		ssid2="grep -v wireless."..cname..".ssid="
		key2="grep -v wireless."..cname..".key="
		luci.sys.exec("sh -c \"$(uci show "..cname2.." | "..device2.." | "..ifname2.." | "..network2.." | "..hidden2.." | "..ssid2.." | "..key2.." | sed 's/"..cname2.."/wireless."..name.."/g' | sed 's/^/uci set /')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".device='"..device.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".ifname='"..ifname.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".network='"..network.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".hidden='"..hidden.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".ssid='"..ssid.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".key='"..key.."')\"")
	elseif rtype == "保存" then
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".device='"..device.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".ifname='"..ifname.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".network='"..network.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".hidden='"..hidden.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".ssid='"..ssid.."')\"")
		luci.sys.exec("sh -c \"$(uci set wireless."..name..".key='"..key.."')\"")
	elseif rtype == "删除" then
		luci.sys.exec("uci delete wireless."..cname)
	else
		luci.http.write("提交无效"..rtype)
	end
	luci.http.write(luci.sys.exec("uci changes"))
	luci.http.close()
end

-- DHCP设置表单提交
function dhcp_form_sub()
	rtype = luci.http.formvalue("type")
	cname = luci.http.formvalue("dhcp_cname")
	name = luci.http.formvalue("dhcp_name")
	interface = luci.http.formvalue("dhcp_interface")
	start = luci.http.formvalue("dhcp_start")
	limit = luci.http.formvalue("dhcp_limit")
	leasetime = luci.http.formvalue("dhcp_leasetime")
	luci.sys.exec("rm -rf /tmp/.uci")
	if rtype == "新增" then
		cname2="dhcp."..cname
		interface2="grep -v dhcp."..cname..".interface="
		start2="grep -v dhcp."..cname..".start="
		limit2="grep -v dhcp."..cname..".limit="
		leasetime2="grep -v dhcp."..cname..".leasetime="
		luci.sys.exec("sh -c \"$(uci show "..cname2.." | "..interface2.." | "..start2.." | "..limit2.." | "..leasetime2.." | sed 's/"..cname2.."/dhcp."..name.."/g' | sed 's/^/uci set /')\"")
		luci.sys.exec("sh -c \"$(uci set dhcp."..name..".interface='"..interface.."')\"")
		luci.sys.exec("sh -c \"$(uci set dhcp."..name..".start='"..start.."')\"")
		luci.sys.exec("sh -c \"$(uci set dhcp."..name..".limit='"..limit.."')\"")
		luci.sys.exec("sh -c \"$(uci set dhcp."..name..".leasetime='"..leasetime.."')\"")
	elseif rtype == "保存" then
		luci.sys.exec("sh -c \"$(uci set dhcp."..name..".interface='"..interface.."')\"")
		luci.sys.exec("sh -c \"$(uci set dhcp."..name..".start='"..start.."')\"")
		luci.sys.exec("sh -c \"$(uci set dhcp."..name..".limit='"..limit.."')\"")
		luci.sys.exec("sh -c \"$(uci set dhcp."..name..".leasetime='"..leasetime.."')\"")
	elseif rtype == "删除" then
		luci.sys.exec("uci delete dhcp."..cname)
	else
		luci.http.write("提交无效"..rtype)
	end
	luci.http.write(luci.sys.exec("uci changes"))
	luci.http.close()
end

-- firewall_zone设置表单提交
function firewall_zone_form_sub()
	rtype = luci.http.formvalue("type")
	cname = luci.http.formvalue("firewall_zone_cname")
	name = luci.http.formvalue("firewall_zone_name")
	title = luci.http.formvalue("firewall_zone_title")
	input = luci.http.formvalue("firewall_zone_input")
	output = luci.http.formvalue("firewall_zone_output")
	forward = luci.http.formvalue("firewall_zone_forward")
	network = luci.http.formvalue("firewall_zone_network")
	luci.sys.exec("rm -rf /tmp/.uci")
	if rtype == "新增" then
		cname2="firewall."..cname
		title2="grep -v firewall."..cname..".name="
		input2="grep -v firewall."..cname..".input="
		output2="grep -v firewall."..cname..".output="
		forward2="grep -v firewall."..cname..".forward="
		network2="grep -v firewall."..cname..".network="
		leasetime2="grep -v firewall."..cname..".leasetime="
		luci.sys.exec("sh -c \"$(uci show "..cname2.." | "..title2.." | "..input2.." | "..output2.." | "..forward2.." | "..network2.." | sed 's/"..cname2.."/firewall."..name.."/g' | sed 's/^/uci set /')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".name='"..title.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".input='"..input.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".output='"..output.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".forward='"..forward.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".network='"..network.."')\"")
	elseif rtype == "保存" then
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".name='"..title.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".input='"..input.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".output='"..output.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".forward='"..forward.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".network='"..network.."')\"")
	elseif rtype == "删除" then
		luci.sys.exec("uci delete firewall."..cname)
	else
		luci.http.write("提交无效"..rtype)
	end
	luci.http.write(luci.sys.exec("uci changes"))
	luci.http.close()
end

-- firewall_rule设置表单提交
function firewall_rule_form_sub()
	rtype = luci.http.formvalue("type")
	cname = luci.http.formvalue("firewall_rule_cname")
	name = luci.http.formvalue("firewall_rule_name")
	title = luci.http.formvalue("firewall_rule_title")
	family = luci.http.formvalue("firewall_rule_family")
	src = luci.http.formvalue("firewall_rule_src")
	src_port = luci.http.formvalue("firewall_rule_src_port")
	proto = luci.http.formvalue("firewall_rule_proto")
	dest = luci.http.formvalue("firewall_rule_dest")
	dest_port = luci.http.formvalue("firewall_rule_dest_port")
	target = luci.http.formvalue("firewall_rule_target")
	luci.sys.exec("rm -rf /tmp/.uci")
	if rtype == "新增" then
		cname2="firewall."..cname
		title2="grep -v firewall."..cname..".name="
		family2="grep -v firewall."..cname..".family="
		src2="grep -v firewall."..cname..".src="
		src_port2="grep -v firewall."..cname..".src_port="
		proto2="grep -v firewall."..cname..".proto="
		dest2="grep -v firewall."..cname..".dest="
		dest_port2="grep -v firewall."..cname..".dest_port="
		target2="grep -v firewall."..cname..".target="
		luci.sys.exec("sh -c \"$(uci show "..cname2.." | "..title2.." | "..family2.." | "..src2.." | "..src_port2.." | "..proto2.." | "..dest2.." | "..dest_port2.." | "..target2.." | sed 's/"..cname2.."/firewall."..name.."/g' | sed 's/^/uci set /')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".name='"..title.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".family='"..family.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".src='"..src.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".src_port='"..src_port.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".proto='"..proto.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".dest='"..dest.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".dest_port='"..dest_port.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".target='"..target.."')\"")
	elseif rtype == "保存" then
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".name='"..title.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".family='"..family.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".src='"..src.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".src_port='"..src_port.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".proto='"..proto.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".dest='"..dest.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".dest_port='"..dest_port.."')\"")
		luci.sys.exec("sh -c \"$(uci set firewall."..name..".target='"..target.."')\"")
	elseif rtype == "删除" then
		luci.sys.exec("uci delete firewall."..cname)
	else
		luci.http.write("提交无效"..rtype)
	end
	luci.http.write(luci.sys.exec("uci changes"))
	luci.http.close()
end

-- 表单提交
function net_save()
	butt = luci.http.formvalue("butt")
	name = luci.http.formvalue("name")
	name = string.split(name, "_")[1]
	rtype = luci.http.formvalue("type")
	data = luci.http.formvalue("data")
	if butt == "ok" then
		luci.http.write(luci.sys.exec("echo '"..data.."' | base64 -d "))
			luci.sys.exec("rm -rf /tmp/.uci/"..name)
			luci.sys.exec("sh -c \"$(echo '"..data.."' | base64 -d | sed 's/^/uci set /' | sed 's/uci set -/uci delete /')\"")
			luci.http.write(luci.sys.exec("uci commit "..name))
	elseif butt == "no" then
		luci.http.write(luci.sys.exec("rm -rf /tmp/.uci"))
	else
		luci.http.write("提交无效,无法"..butt)
	end
	luci.http.close()
end

function xxxboxfunc()
	enabled = luci.http.formvalue("enabled")
	state = luci.http.formvalue("state")
	if enabled == "self" then
		if state == "stop" then
			luci.sys.exec("uci -q set lyq.autostart=stop&&uci commit")
		else
			luci.sys.exec("uci -q set lyq.autostart=start&&uci commit")
		end
		luci.sys.exec("reboot")
	end
	if enabled == "uninstall" then
		if state == "start" then
			luci.sys.exec(xxx_path.."/xxxcon/xxxbox uninstall_xxxbox")
		end
	end
end
-- opkg
function opkg_exc()
	local opkg_exc = luci.http.formvalue("opkg_exc")
	local opkg_name = luci.http.formvalue("opkg_name")
	exec_str="opkg -d $(echo -n $(uci -q get lyq.opkg_path)) "..opkg_exc.." "..opkg_name
	luci.sys.exec("kill $(ps | grep 62312 | grep -v grep | awk '{print $1}' | head -n 1)")
	luci.sys.exec("kill $(ps | grep 62312 | grep -v grep | awk '{print $1}' | head -n 1)")
	exec_str="/tmp/xxxbox_tmp/xxx_ttyd -p 62312 -u 62312 -q "..exec_str.." > /dev/null 2>&1 &"
	luci.sys.exec(exec_str)
	luci.http.close()
end

function set_opkg_path()
	luci.http.write(luci.sys.exec("uci set lyq.opkg_path=" .. luci.http.formvalue("opkg_path") .. " && uci commit lyq"))
	luci.http.close()
end

-- 保存
function xxx_save()
	file_path = file_path_arr[xxx_id]
	local form_base64 = luci.http.formvalue("xxx_base64")
	luci.http.write("保存成功")
	local file = io.open(file_path, "w")
	io.output(file)
	io.write(urlDecode(base64_dec(form_base64)))
	io.close()
	luci.http.close()
end
--执行命令
function ssh_exec()
	luci.sys.exec("kill $(ps | grep 62312 | grep -v grep | awk '{print $1}' | head -n 1)")
	luci.sys.exec("kill $(ps | grep 62312 | grep -v grep | awk '{print $1}' | head -n 1)")
	exec=base64_enc(urlDecode(base64_dec(luci.http.formvalue("exec"))))
	luci.sys.exec("echo '"..exec.."' | base64 -d>/tmp/tmp/shexec")
	exec="/tmp/xxxbox_tmp/xxx_ttyd -p 62312 -u 62312 -q sh /tmp/tmp/shexec > /dev/null 2>&1 &"
	luci.sys.exec(exec)
	luci.http.close()
end
function xxx_exec()
	local sda = "/mnt/sda"
	sda = string.gsub(sda, "\r\n", "")
	sda = string.gsub(sda, "\n", "")
	sda = string.gsub(sda, " ", "")
	if xxx_id == 1 then
		luci.http.write(luci.sys.exec("sh -c 'opkg update > /dev/null 2>&1 &'"))
	elseif xxx_id == 2 then
		luci.http.write(luci.sys.exec("sh -c 'mount -a > /dev/null 2>&1 &'"))
	elseif xxx_id == 3 then
		luci.http.write(luci.sys.exec("sh -c '" .. xxx_path .. "/xxxcon/autostart > /dev/null 2>&1 &'"))
	elseif xxx_id == 4 then
		luci.http.write(luci.sys.exec("sh -c 'sh " .. xxx_path .. "/xxxcon/user_auto.sh > /dev/null 2>&1 &'"))
	else
		if 9999 < xxx_id then
			local xxx_list = io.open(xxx_list_file_path):read("*a")
			io.close()
			local cjson = require("cjson")
			xxx_list = cjson.decode(xxx_list)
			local exc_log = luci.sys.exec(xxx_list["xxx"][xxx_id - 9999]["data"]);
			exc_log = string.gsub(exc_log, "\r\n", "<br>")
			exc_log = string.gsub(exc_log, "\n", "<br>")
			exc_log = string.gsub(exc_log, " ", "&nbsp;")
			luci.http.write(exc_log)
			luci.http.close()
		else
			luci.http.write("无效指令...")
			luci.http.close()
		end
	end
	luci.http.write("正在后台运行中...")
	luci.http.close()
end
function sys_info()
	local name = luci.http.formvalue("name")
	luci.http.write('‘前置标记’')
	if name == "cpu" then
		luci.http.write(luci.sys.exec("cat /proc/cpuinfo"))
	end
	if name == "ram" then
		luci.http.write(luci.sys.exec("free&cat /proc/meminfo"))
	end
	if name == "df" then
		luci.http.write(luci.sys.exec("df&mount"))
	end
	if name == "cgroup" then
		luci.http.write(luci.sys.exec("cat /proc/cgroups"))
	end
	if name == "pro" then
		luci.http.write(luci.sys.exec("ps"))
	end
	if name == "ip" then
		luci.http.write(luci.sys.exec("ifconfig"))
	end
	if name == "sys" then
		luci.http.write(luci.sys.exec("bootinfo"))
	end
	luci.http.close()
end


function xxxinfo()
	local result = {
		["code"] = 0
	}
	result.code = 160
	if result.code ~= 0 then
		result["msg"] = XQErrorUtil.getErrorMessage(result.code)
	end
	LuciHttp.write_json(result)
end

function xxxload()
	local result = {
		["code"] = 0
	}
	result.code = 161
	if result.code ~= 0 then
		result["msg"] = XQErrorUtil.getErrorMessage(result.code)
	end
	LuciHttp.write_json(result)
end


function get_disk_info_html()
	luci.sys.exec(xxx_path.."/xxxcon/xxxbox mtdb_disk_mount");
	luci.sys.exec(xxx_path.."/xxxcon/xxxbox sda_disk_mount");
	disk_info_html = '<div style="margin-top: 8px;">下载地址：<a href="https://github.com/V2023H/xxx_box" target="_blank">https://github.com/V2023H/xxx_box/tree/main/new_tar</a>'
	issd = luci.sys.exec("echo $(/bin/df |/bin/grep /dev/sd >/dev/null && echo '1' || echo '0')")
	mtd_use = luci.sys.exec("df -h /mnt/mtd/box/ | sed -n '2p' | awk '{print $5}'")
	sda_use = luci.sys.exec("df -h /mnt/sda/mi_box | sed -n '2p' | awk '{print $5}'")
	tmp_total = luci.sys.exec("df -h /tmp | sed -n '2p' | awk '{print $2}'")
	tmp_used = luci.sys.exec("df -h /tmp | sed -n '2p' | awk '{print $3}'")
	tmp_use = luci.sys.exec("df -h /tmp | sed -n '2p' | awk '{print $5}' | sed 's/%//'")
	free_Mem_total = luci.sys.exec("free | grep Mem | awk '{print $2}'")
	free_Mem_used = luci.sys.exec("free | grep Mem | awk '{print $3}'")
	free_Swap_total = luci.sys.exec("free | grep Swap | awk '{print $2}'")
	free_Swap_used = luci.sys.exec("free | grep Swap | awk '{print $3}'")
	mnt_set_radio_mode = luci.sys.exec("echo -n \"$(uci get lyq.xxx_set_radio_mode)\"")
	mnt_set_radio_mode_mtd = ""
	mnt_set_radio_mode_sda = ""
	if mnt_set_radio_mode == "mtd" then
		xxx_total = luci.sys.exec("df -h /mnt/mtd/ | sed -n '2p' | awk '{print $2}'")
		xxx_used = luci.sys.exec("df -h /mnt/mtd/ | sed -n '2p' | awk '{print $3}'")
		xxx_use = luci.sys.exec("df -h /mnt/mtd/ | sed -n '2p' | awk '{print $5}' | sed 's/%//'")
		mnt_set_radio_mode_mtd = "checked"
	else
		xxx_total = luci.sys.exec("df -h /mnt/sda | sed -n '2p' | awk '{print $2}'")
		xxx_used = luci.sys.exec("df -h /mnt/sda | sed -n '2p' | awk '{print $3}'")
		xxx_use = luci.sys.exec("df -h /mnt/sda | sed -n '2p' | awk '{print $5}' | sed 's/%//'")
		mnt_set_radio_mode_sda = "checked"
	end
	disk_info_html = disk_info_html .. '<br>下载目录： <input type="radio" name="mnt_checked" id="mtd_checked" onchange="xxx_box_exec(\'mnt_radio_change\',\'mtd\',this);" ' .. mnt_set_radio_mode_mtd .. '><a href="#" onclick="'..luci.sys.exec("[ $(pidof xxx_ghfs) ] || echo -n 'return;'")..'window.open(\'http://\'+document.domain+\':63333/\', \'_blank\');">系统(' .. mtd_use .. ') /mnt/mtd/box</a> &nbsp;&nbsp;&nbsp;&nbsp;'
	if issd == "1\n" then
		disk_info_html = disk_info_html .. '<input type="radio" name="mnt_checked" id="sda_checked" onchange="xxx_box_exec(\'mnt_radio_change\',\'sda\',this);" ' .. mnt_set_radio_mode_sda .. '><a href="#" onclick="'..luci.sys.exec("[ $(pidof xxx_ghfs) ] || echo -n 'return;'")..'window.open(\'http://\'+document.domain+\':62222/mi_box\', \'_blank\');">硬盘(' .. sda_use .. ') /mnt/sda/mi_box</a>'
	end
	disk_info_html = disk_info_html .. '<br><div style="    display: inline-block;">'
	divwidth=math.ceil(xxx_use*1.6)
	disk_info_html = disk_info_html .. '<div class="disk_info_back0"><div class="disk_info_back1">插件目录：' ..xxx_used.."/"..xxx_total..'</div><div style="width: '..divwidth..'px;background-color: '..getbackc(divwidth)..';" class="disk_info_back2"></div></div>'
	divwidth=math.ceil(free_Mem_used/free_Mem_total*100*1.6)
	disk_info_html = disk_info_html .. '<div class="disk_info_back0"><div class="disk_info_back1">系统内存：'..math.ceil(free_Mem_used / 1024)..'MB/'..math.ceil(free_Mem_total / 1024).. 'MB'..'</div><div style="width: '..divwidth..'px;background-color: '..getbackc(divwidth)..';" class="disk_info_back2"></div></div>'
	divwidth=math.ceil(free_Swap_used/free_Swap_total*100*1.6)
	disk_info_html = disk_info_html .. '<div class="disk_info_back0"><div class="disk_info_back1">虚拟内存：'..math.ceil(free_Swap_used / 1024) .. 'MB/' .. math.ceil(free_Swap_total / 1024) .. 'MB'..'</div><div style="width: '..divwidth..'px;background-color: '..getbackc(divwidth)..';"class="disk_info_back2"></div></div>'
	divwidth=math.ceil(tmp_use*1.6)
	disk_info_html = disk_info_html .. '<div class="disk_info_back0"><div onclick="window.open(url_qym()+\':61111\')" class="disk_info_back1">临时空间：'..tmp_used .. "/" .. tmp_total..'</div><div style="width: '..divwidth..'px;background-color: '..getbackc(divwidth)..';" class="disk_info_back2"></div>'
	disk_info_html = disk_info_html .. '</div></div>'
	luci.http.write("{\"code\":1,\"msg\":\"" .. base64_enc(disk_info_html) .. "\"}")
	luci.http.close()
end

function getbackc(divwidth)
	if divwidth<math.ceil(6*1.6) then
		divcolor="white"
	elseif divwidth>math.ceil(90*1.6) then
		divcolor="gainsboro"
	elseif divwidth>math.ceil(70*1.6) then
		divcolor="gainsboro"
	else
		divcolor="gainsboro"
	end
	return divcolor
end


function xxx_json()
	local xxx_list = io.open(xxx_list_file_path):read("*a")
	io.close()
	if xxx_list == "" then
		luci.http.close()
	end
	local cjson = require("cjson")
	xxx_list = cjson.decode(xxx_list)
    -- 检测程序端口状态
	local allstr = luci.sys.exec("echo `/bin/netstat -anp | awk '{print $4}' | grep : | awk '{print $0\"P \"}'`")
	for i = 1, # xxx_list["xxx"], 1 do
		if xxx_list["xxx"][i]["class"] == "box" then
			url = xxx_list["xxx"][i]["data"]
			url_arr = string.split(url, '//')
			if # url_arr > 1 then
				url_prot = Str_Cut(url_arr[2], ":", "/")
				if not tonumber(url_prot) then
					url_prot = "66666"
				end
			else
				url_prot = "66666"
			end
			if url_prot == "66666" or not string.find(url, ":") or not string.find(url, "//") then
				xxx_list["xxx"][i]["tag"] = "66666"
			elseif url_prot ~= 0 and string.find(allstr, ":" .. url_prot .. "P") then
				xxx_list["xxx"][i]["tag"] = url_prot
			else
				xxx_list["xxx"][i]["tag"] = 0
			end
		end
	end
	luci.http.write_json(xxx_list)
	luci.http.close()
end



function box_load()

--文件操作
-- 1    xxx        xxx数据文件
-- 2    user_auto  开机自启数据文件
-- 3    distfeeds  OPKG链接数据文件
-- 4    fstab      开机挂载数据文件
-- 5    auto_start 硬盘自启数据文件
	local mtd = "/mnt/mtd/box/"
	local sda = "/mnt/sda/mi_box/"
	file_path_arr = {
		xxx_path .. "/xxxweb/xxx.json",
		xxx_path .. "/xxxcon/user_auto.sh",
		"/etc/opkg/distfeeds.conf",
		"/etc/fstab",
		"/mnt/docker_disk/auto_start.sh",
		xxx_path .. "/xxxcon/box_list.json",
		xxx_path .. "/xxxcon/usr_lib/lua/luci/view/zt_exc_cy.htm",
		xxx_path .. "/xxxcon/usr_lib/lua/luci/view/zt_exc_jb.htm"
	}
	local xxx_id = tonumber(luci.http.formvalue("xxx_save_id"))
	local rr = luci.http.formvalue("rr")
	rrsp = string.split(rr, '-_-')
	up_msg = ""
	if rrsp[1] == "update" then
		file_itmp_path = "/tmp/tmp/" .. rrsp[2]
		tar_list_show = luci.sys.exec("tar -tJf " .. file_itmp_path .. " | tr '\\n' '|'")
		if string.find(tar_list_show, 'call', 1) then
			file_save_path = luci.sys.exec("echo -n \"$(df | grep -q /mnt/sda && echo /mnt/sda/mi_box/ || echo /mnt/mtd/box/)\"")
			file_save_name_path = file_save_path .. rrsp[2]
			file_save_dir_size = luci.sys.exec("echo -n \"$(df " .. file_save_path .. " | grep /mnt | awk '{print $4}')\"")
			file_save_size = luci.sys.exec("echo -n \"$(du " .. file_itmp_path .. " | grep /tmp | awk '{print $1}')\"")
			if file_save_dir_size - file_save_size < 2000 then
				up_msg = "上传效验失败1，" .. file_save_path .. "空间不足！"
			else
				up_msg = "上传效验成功1," .. file_save_name_path .. "！"
				luci.sys.exec("mv -f " .. file_itmp_path .. " " .. file_save_name_path)
			end
		elseif string.find(tar_list_show, 'xxxbox_data', 1) then
			up_msg = "上传效验成功2！"
		else
			up_msg = "上传效验失败3！" .. file_itmp_path
			luci.sys.exec("rm -rf " .. file_itmp_path)
		end
	end
	file_path = file_path_arr[xxx_id]
	box_list = io.open(file_path):read("*a")
	io.close()
        --读取文件内容
	if xxx_id == 7 or xxx_id == 8 then
		luci.http.write_json("{\"code\":1,\"msg\":\"" .. base64_enc(box_list) .. "\"}")
		luci.http.close()
	end
	local cjson = require("cjson")
	box_list = cjson.decode(box_list)
        -- 本地安装包
	my_instal_list = luci.sys.exec(xxx_path .. "/xxxcon/xxxapi get_instal_list false")
	my_instal_list = string.split(my_instal_list, '\n')
	update_list = ""
	for i = 1, # my_instal_list - 1, 1 do
		my_box_list_box_info = {}
		my_box_list_box_info['ID'] = (9000 + i)

		my_box_list_box_info['download'] = my_instal_list[i]
		my_box_list_box_info['model'] = "@7000,@ax9000"
		my_box_list_box_info['name'] = string.gsub(string.match(my_instal_list[i], "[^%/]+%w$"), ".tar", "")

		-- 使用说明
		info_usage_exec = "cat " .. xxx_path .. "/xxxbox/" .. my_box_list_box_info['name'] .. "/call | grep info_usage= | sed 's/info_usage=\"//' | sed 's/.$//'"
		info_usage = luci.sys.exec(info_usage_exec)
		if info_usage ~= "" then
			my_box_list_box_info['content'] = info_usage
		else
			my_box_list_box_info['content'] = "本地安装包,直接安装即可。>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"

		end
		my_box_list_box_info['sha'] = ""
		my_box_list_box_info['title'] = "本地"
		my_box_list_box_info['url'] = ""
		my_box_list_box_info['class'] = "other"
		my_box_list_box_info['version'] = "0.0.0"
		box_list["box"][# box_list["box"] + 1] = my_box_list_box_info
	end
	box_list["is_rom_exists"] = file_exists("/tmp/tmp/xxx_install")
	luci.sys.exec("ps > /tmp/.pstmpxxx")
	luci.sys.exec("netstat -anp > /tmp/.netstattmpxxx")
	local LuciFs = require("luci.fs")
	if mnt_set_radio_mode == "mtd" then
		xxx_ava = luci.sys.exec("echo -n $(df -m /mnt/mtd/box/ | sed -n '2p' | awk '{print $4}')")
	else
		xxx_ava = luci.sys.exec("echo -n $(df -m /mnt/sda/mi_box | sed -n '2p' | awk '{print $4}')")
	end
	box_list["xxx_ava"]=xxx_ava
	box_list["tmp_ava"]=luci.sys.exec("echo -n $(df -m /tmp | sed -n '2p' | awk '{print $4}')")
	box_list["xxx_dep"]=luci.sys.exec("[ -n \"$(pidof dockerd)\" ] && echo -n dockerd")
	box_list["xxx_dep"]=box_list["xxx_dep"]..luci.sys.exec("[ -n \"$(pidof xxx_ttyd)\" ] && echo -n terminal")
	box_list["xxx_dep"]=box_list["xxx_dep"]..luci.sys.exec("[ -n \"$(source /etc/profile>/dev/null && which python3)\" ] && echo -n python3")
	box_list["xxx_dep"]=box_list["xxx_dep"]..luci.sys.exec("[ -n \"$(source /etc/profile>/dev/null && which node)\" ] && echo -n node")
	luci.sys.exec("$("..xxx_path.."/xxxcon/xxxbox docker) ps -a > /tmp/tmp/.dockerps")
	luci.sys.exec("source /etc/profile>/dev/null && npm -g list > /tmp/tmp/.nodelist")
	for i in ipairs(box_list["box"]) do
		repeat
				-- 型号匹配,不匹配则移除
			local model = luci.sys.exec("uci get lyq.model")
			model = string.gsub(model, "\n", "")
			box_model = box_list["box"][i]["model"]
			a, b = string.find(box_model, "@" .. model)
			if a then
				box_list["box"][i]["is_model"] = true
			else
				box_list["box"][i]["is_model"] = false
			end

                -- 安装状态
			if box_list["box"][i]["class"]=="dockerd" then
				local strarr = string.split(box_list["box"][i]["download"], ' ')
				str=strarr[#strarr]
				local strarr = string.split(str, ':')
				str=strarr[1]
				is_install = luci.sys.exec("cat /tmp/tmp/.dockerps | awk  '{print $2}' | grep "..str.." >/dev/null && echo -n true || echo -n false")
				if is_install == "true" then
					box_list["box"][i]["is_install"] = true
				else
					box_list["box"][i]["is_install"] = false
				end
			elseif box_list["box"][i]["class"]=="node" then
				local strarr = string.split(box_list["box"][i]["download"], ' ')
				str=strarr[#strarr]
				is_install = luci.sys.exec("cat /tmp/tmp/.nodelist | grep "..str.." >/dev/null && echo -n true || echo -n false")
				if is_install == "true" then
					box_list["box"][i]["is_install"] = true
				else
					box_list["box"][i]["is_install"] = false
				end
			else
				local f = io.open(xxx_path .. "/xxxbox/" .. box_list["box"][i]["name"], 'r');
				is_install = true;
				if f ~= nil then
					io.close(f)
					box_list["box"][i]["is_install"] = true
				else
					box_list["box"][i]["is_install"] = false
				end
			end


                -- 内存模式不显示安装状态
			if luci.sys.exec("echo -n $(uci get lyq.xxx_set_radio_mode)") == "ram" then
				box_list["box"][i]["is_install"] = true
			end
                -- 运行状态
			is_run = true
			state_str = luci.sys.exec("echo -n \"$("..xxx_path.."/xxxbox/" .. box_list["box"][i]["name"] .. "/call state | grep 已 | grep -v grep)\"")
			if state_str == "" then
				if luci.sys.exec("cat /tmp/.pstmpxxx | grep /xxxbox/" .. box_list["box"][i]["name"] .. " | grep -v grep") ~= "" then
					box_list["box"][i]["is_run"] = true
				elseif luci.sys.exec("cat /tmp/.pstmpxxx | grep {" .. box_list["box"][i]["name"] .. "} | grep -v grep") ~= "" then
					box_list["box"][i]["is_run"] = true
				elseif luci.sys.exec("cat /tmp/.pstmpxxx | grep ' " .. box_list["box"][i]["name"] .. ":' | grep -v grep") ~= "" then
					box_list["box"][i]["is_run"] = true
				else
					box_list["box"][i]["is_run"] = false
				end
			else
				if string.find(state_str, '已开启', 1) then
					box_list["box"][i]["is_run"] = true
				else
					box_list["box"][i]["is_run"] = false
				end
			end
                -- 储存位置 文件大小
			filepath1 = xxx_path .. "/mtd/box/" .. box_list["box"][i]["name"] .. ".tar"
			if file_exists(filepath1) then
				filepath1_tmp = math.floor(LuciFs.stat(filepath1, "size") / 1024)
			else
				filepath1_tmp = ""
			end
			filepath2 = "/mnt/sda/mi_box/" .. box_list["box"][i]["name"] .. ".tar"
			if file_exists(filepath2) then
				filepath2_tmp = math.floor(LuciFs.stat(filepath2, "size") / 1024)
			else
				filepath2_tmp = ""
			end
			filepath3 = "/tmp/xxxbox_data/xxxbox/" .. box_list["box"][i]["name"] .. ".tar"
			if file_exists(filepath3) then
				filepath3_tmp = math.floor(LuciFs.stat(filepath3, "size") / 1024)
			else
				filepath3_tmp = ""
			end
			if filepath1_tmp ~= "0\n" and filepath1_tmp ~= "" then
				box_list["box"][i]["disk_path"] = "mtd"
				file_size = filepath1_tmp
				file_path = filepath1
			elseif filepath2_tmp ~= "0\n" and filepath2_tmp ~= "" then
				box_list["box"][i]["disk_path"] = "sda"
				file_size = filepath2_tmp
				file_path = filepath2
			elseif filepath3_tmp ~= "0\n" and filepath3_tmp ~= "" then
				box_list["box"][i]["disk_path"] = "tmp"
				file_size = filepath3_tmp
				file_path = filepath3
			else
				box_list["box"][i]["disk_path"] = ""
				file_size = ""
				file_path = ""
			end
			box_list["box"][i]["file_path"] = file_path
			if file_size=="" then
				box_list["box"][i]["file_size"] = box_list["box"][i]["size"]
			else
				box_list["box"][i]["file_size"] = string.gsub(file_size, "\n", "")
			end
                -- 内存模式不显示文件大小 -- 内存模式位置处于临时空间
			if luci.sys.exec("echo -n $(uci get lyq.xxx_set_radio_mode)") == "ram" then
				if file_exists(xxx_path .. "/xxxbox/" .. box_list["box"][i]["name"] .. "/call") then
					box_list["box"][i]["file_path"] = "临时空间"
					box_list["box"][i]["disk_path"] = "tmp"
					box_list["box"][i]["file_size"] = "1"
				else
					box_list["box"][i]["file_path"] = "尚未加载"
					box_list["box"][i]["disk_path"] = "null"
					box_list["box"][i]["file_size"] = "0"
				end
			end
                -- 自启状态
			if luci.sys.exec("echo -n $(cat $(uci get lyq.user_auto) | grep '#" .. box_list["box"][i]["name"] .. " auto start' | grep -v grep)") == "" then
				box_list["box"][i]["is_service_run"] = false
			else
				box_list["box"][i]["is_service_run"] = true
			end

                -- 端口状态，检查打开端口
			url = luci.sys.exec("source " .. xxx_path .. "/xxxbox/" .. box_list["box"][i]["name"] .. "/call > /dev/null && echo -n $open_url")
			url_prot = luci.sys.exec("echo '" .. url .. "' | awk -F'[/:]' '{print $5}'")
			box_list["box"][i]["url"] = url
			if string.find(url, 'http', 1) == 1 then
				open_prot = luci.sys.exec("cat /tmp/.netstattmpxxx | grep :" .. url_prot .. " |  grep tcp | grep LISTEN | awk '{print $4}' | grep -v grep | sed 's|.*:||' |sed 's/://g'")
				if string.find(open_prot, url_prot, 1) or url_prot == "80\n" then
					box_list["box"][i]["url"] = url
				end
			end

                -- 使用说明
			info_usage_exec = "cat " .. xxx_path .. "/xxxbox/" .. box_list["box"][i]["name"] .. "/call | grep info_usage= | sed 's/info_usage=\"//' | sed 's/.$//'"
			info_usage = luci.sys.exec(info_usage_exec)
			info_usage = string.gsub(info_usage, "\n", "")
			info_usage = string.gsub(info_usage, "$open_url", url)
			if box_list["box"][i]["is_install"] and info_usage ~= "" then
				box_list["box"][i]["content"] = info_usage
			end
                -- 参数+说明
			if luci.sys.exec("cat " .. xxx_path .. "/xxxbox/" .. box_list["box"][i]["name"] .. "/call | grep prm=") ~= "" then
				prm = luci.sys.exec("source " .. xxx_path .. "/xxxbox/" .. box_list["box"][i]["name"] .. "/call > /dev/null && echo -n $prm")
				prm_usage = luci.sys.exec("source " .. xxx_path .. "/xxxbox/" .. box_list["box"][i]["name"] .. "/call > /dev/null && echo -n $prm_usage")
				prm = string.gsub(prm, "\n", "")
				prm_usage = string.gsub(prm_usage, "\"", "“")
				prm_usage = string.gsub(prm_usage, "\'", "‘")
				box_list["box"][i]["prm"] = prm
				box_list["box"][i]["prm_usage"] = prm_usage
			end
                -- 安装包状态
			if file_exists(mtd .. box_list["box"][i]["name"] .. ".tar") or file_exists(sda .. box_list["box"][i]["name"] .. ".tar") then
				box_list["box"][i]["tar_state"] = true
			else
				box_list["box"][i]["tar_state"] = false
			end
			if string.find(update_list, box_list["box"][i]["name"]) then
				box_list["box"][i]["update"] = true
			else
				box_list["box"][i]["update"] = false
			end
			class=luci.sys.exec("source " .. xxx_path .. "/xxxbox/" .. box_list["box"][i]["name"] .. "/call > /dev/null && echo -n $file_class")
			if class~="" then
				box_list["box"][i]["class"] = class
			end

			if box_list["box"][i]["class"]=="dockerd" then
				box_list["box"][i]["file_path"] = str
				if box_list["box"][i]["is_install"] == true then
					box_list["box"][i]["content"]=box_list["box"][i]["content2"]
					is_run_int = luci.sys.exec("cat /tmp/tmp/.dockerps | awk  '{print $2}' | grep -n "..str.." | awk -F':' '{print $1}' | tr -d '\\n'")
					is_run = luci.sys.exec("cat /tmp/tmp/.dockerps | sed -n '"..is_run_int.."p' | awk '{print $5 $6 $7 $8 $9}' | grep Up >/dev/null && echo -n true || echo -n false")
					if is_run == "true" then box_list["box"][i]["is_run"]=true end
					if is_run == "true" then box_list["box"][i]["url"]=string.split(box_list["box"][i]["content2"], '，')[1] end
				 end
			end
		until true
	end
	box_list["up_msg"] = up_msg
	luci.http.write_json(box_list)
	luci.http.close()
end




function box_exec()
	box = xxx_path .. "/xxxcon/xxxbox "
	xxxapi = xxx_path .. "/xxxcon/xxxapi "
	luci.sys.exec("chmod 777 " .. box)
	box = "source /etc/profile >/dev/null && " .. box
	local exec_name = luci.http.formvalue("exec_name")
	local box_name = luci.http.formvalue("box_name")
	box_name_sda = "/mnt/sda/mi_box/" .. box_name .. ".tar"
	box_name_mtd = "/mnt/mtd/box/" .. box_name .. ".tar"
	if exec_name == "install" then
		if file_exists(box_name_sda) then
			http_write = (luci.sys.exec(box .. "install " .. box_name_sda))
		elseif file_exists(box_name_mtd) then
			http_write = (luci.sys.exec(box .. "install " .. box_name_mtd))
		else
			http_write = ("找不到安装包")
		end
		if url_prot ~= 0 and string.find(http_write, "安装成功") then
			http_write = "安装成功"
		end
	elseif exec_name == "down_install" then
		local down_url = luci.http.formvalue("down_url")
		local down_path = luci.http.formvalue("down_path")
		down_url = urlDecode(base64_dec(down_url))
		down_path = urlDecode(base64_dec(down_path))
		if down_path == "sda" then
			down_path = box_name_sda
		elseif down_path == "mtd" then
			down_path = box_name_mtd
		end
		http_write = (luci.sys.exec(box .. "down_file " .. down_url .. " " .. down_path))
	elseif exec_name == "down_xxx_install" then
		file_path = file_path_arr[6]
		box_list = io.open(file_path):read("*a")
		io.close()
		local cjson = require("cjson")
		box_list = cjson.decode(box_list)
		down_url = box_list["down_xxx_url"]
		down_path = "/tmp/tmp/xxx_install"
		http_write = (luci.sys.exec(box .. "down_file " .. down_url .. " " .. down_path))
	elseif exec_name == "xxx_install" then
		http_write = (luci.sys.exec(box .. "install_rom /tmp/tmp/xxx_install"))
	elseif exec_name == "down_file" then
		local down_url = luci.http.formvalue("down_url")
		local down_path = luci.http.formvalue("down_path")
		down_url = urlDecode(base64_dec(down_url))
		down_path = urlDecode(base64_dec(down_path))
		http_write = (luci.sys.exec(box .. "down_file \"" .. down_url .. "\" \"" .. down_path .. "\""))
	elseif exec_name == "uninstall" then
		http_write = (luci.sys.exec(box .. "uninstall " .. box_name))
	elseif exec_name == "start" then
		if luci.sys.exec("echo -n $(uci get lyq.xxx_set_radio_mode)") == "ram" then
			http_write = (luci.sys.exec(box .. "start_tmp_run " .. box_name))
		else
			http_write = (luci.sys.exec(box .. box_name .. " start"))
		end
	elseif exec_name == "stop" then
		http_write = (luci.sys.exec(box .. box_name .. " stop"))
	elseif exec_name == "enable" then
		if luci.sys.exec("echo -n $(uci get lyq.xxx_set_radio_mode)") == "ram" then
			http_write = (luci.sys.exec(box .. "auto_start_tmp_run " .. box_name))
		else
			http_write = (luci.sys.exec(xxxapi .. box_name .. " enable"))
		end
	elseif exec_name == "disable" then
		if luci.sys.exec("echo -n $(uci get lyq.xxx_set_radio_mode)") == "ram" then
			http_write = (luci.sys.exec(box .. "auto_start_tmp_run " .. box_name))
		else
			http_write = (luci.sys.exec(xxxapi .. box_name .. " disable"))
		end
	elseif exec_name == "update" then
		local down_path = luci.http.formvalue("down_path")
		down_path = urlDecode(base64_dec(down_path))
		http_write = (luci.sys.exec(box .. box_name .. " update \"" .. down_path .. "\""))
		http_write = ("更新完成")
	elseif exec_name == "xxx_app_update" then
		http_write = luci.sys.exec("echo -n \"$("..box.."checkupdate)\"")
	elseif exec_name == "set_prm" then
		http_write = (luci.sys.exec(box .. box_name .. " set_prm '" .. luci.http.formvalue("new_prm") .. "'"))
	elseif exec_name == "del_tar" then
		http_write = (luci.sys.exec("rm -rf " .. sda .. box_name .. ".tar >/dev/null"))
		http_write = (luci.sys.exec("rm -rf " .. mtd .. box_name .. ".tar >/dev/null"))
		http_write = ("删除完成")
	elseif exec_name == "update_box_list_json" then
		http_write = (luci.sys.exec(box .. "update_box_list_json"))
	elseif exec_name == "xxx_update" then
		http_write = (luci.sys.exec(box .. "xxx_update true"))
	elseif exec_name == "down_xxx_box_json" then
		http_write = (luci.sys.exec(box .. exec_name))
	elseif exec_name == "xxx_init" then
		http_write = (luci.sys.exec(box .. exec_name))
	elseif exec_name == "reinstall_init" then
		http_write = (luci.sys.exec(box .. exec_name))
	elseif exec_name == "uninstall_all" then
		http_write = (luci.sys.exec(box .. exec_name))
	elseif exec_name == "switch_path_mtd" then
		http_write = (luci.sys.exec(box .. exec_name .. " " .. box_name))
	elseif exec_name == "switch_path_sda" then
		http_write = (luci.sys.exec(box .. exec_name .. " " .. box_name))
	elseif exec_name == "chack_disksize" then
		http_write = (luci.sys.exec("echo 1 | " .. box .. exec_name .. " nosh"))
	elseif exec_name == "xxx_checkbox_change" then
		http_write = (luci.sys.exec("uci set lyq." .. box_name .. "=" .. luci.http.formvalue("hide") .. " && uci commit lyq"))
	elseif exec_name == "xxx_radio_change" then
		http_write = (luci.sys.exec("uci set lyq.xxx_set_radio_mode=" .. box_name .. " && uci commit lyq"))
	elseif exec_name == "mnt_radio_change" then
		http_write = (luci.sys.exec("uci set lyq.xxx_set_radio_mode=" .. box_name .. " && uci commit lyq"))
	elseif exec_name == "xxx_source_list_url" then
		http_write = (luci.sys.exec("uci set lyq.xxx_source_list_url=" .. urlDecode(base64_dec(luci.http.formvalue("source_url"))) .. " && uci commit lyq"))
	elseif exec_name == "xxx_down_all_tar_url" then
		http_write = (luci.sys.exec("uci set lyq.xxx_down_all_tar_url=" .. urlDecode(base64_dec(luci.http.formvalue("down_url"))) .. " && uci commit lyq"))
	elseif exec_name == "restart_network" then
		http_write = (luci.sys.exec("/etc/init.d/network restart"))
	elseif exec_name == "restart_firewall" then
		http_write = (luci.sys.exec("/etc/init.d/firewall restart"))
	elseif exec_name == "restart_system" then
		http_write = (luci.sys.exec("reboot"))
	else
		http_write = ("无效指令")
	end
	luci.http.write_json("{\"code\":1,\"msg\":\"" .. base64_enc(http_write) .. "\"}")
	luci.http.close()
end
