--[[
  小米路由器网桥工具模块
  
  功能说明:
  - 读取Linux网桥(bridge)的MAC地址表
  - 获取网桥端口映射信息
  - 用于设备发现和网络诊断
  
  网桥概念:
  - Linux网桥(br-lan, br-guest)用于连接多个网络接口
  - 网桥维护MAC地址转发表，记录设备MAC与端口的对应关系
  - 通过读取/sys/class/net/<bridge>/brforward获取MAC表
  
  主要函数:
  - get_macs(bridge): 获取网桥的MAC地址表
  - get_port_map(bridge): 获取端口号到接口名的映射
  - print_br_macs(bridge): 打印网桥MAC表（调试用）
  - print_all_macs(): 打印所有网桥MAC表
]]

module("xiaoqiang.util.XQBrUtil", package.seeall)

local luci_util = require("luci.util")
local cjson = require("cjson")

-- 获取网桥的MAC地址表
-- @param bridge 网桥名称 (如 "br-lan", "br-guest")
-- @return table MAC地址列表，每项包含 {no, dev, mac, is_local, ageing}
function get_macs(bridge)
    local br_path = "/sys/class/net/" .. bridge .. "/brif"
    
    -- 检查网桥是否存在
    local file = io.open(br_path)
    if file == nil then
        return nil
    end
    file:close()
    
    -- 获取端口映射
    local port_map = get_port_map(bridge)
    
    if bridge == nil then
        return nil
    end
    
    -- 读取MAC转发表
    -- brforward文件格式: 端口号;MAC地址;是否本地;老化时间
    local cmd = "cat /sys/class/net/" .. bridge .. "/brforward"
    local macs_table = luci_util.execl(cmd)
    
    local result = {}
    
    for _, line in ipairs(macs_table) do
        local entry = {}
        local fields = luci_util.split(line, ";")
        
        -- 端口号
        entry.no = fields[1]
        
        -- 根据端口号获取设备名
        entry.dev = port_map[tonumber(entry.no)]
        
        -- MAC地址
        entry.mac = fields[2]
        
        -- 是否为本地地址 (1=本地, 0=学习到的)
        entry.is_local = fields[3]
        
        -- 老化时间（秒）
        entry.ageing = luci_util.trim(fields[4])
        
        table.insert(result, entry)
    end
    
    return result
end

-- 获取网桥端口号到接口名的映射
-- @param bridge 网桥名称
-- @return table 端口号到接口名的映射表
function get_port_map(bridge)
    local port_map = {}
    
    -- 列出网桥下的所有接口
    local cmd = "ls /sys/class/net/" .. bridge .. "/brif"
    local files = luci_util.execl(cmd)
    
    for _, ifname in ipairs(files) do
        -- 读取每个接口的端口号
        local port_file = "/sys/class/net/" .. bridge .. "/brif/" .. ifname .. "/port_no"
        local file = io.open(port_file)
        
        if file == nil then
            return nil
        end
        
        local port_no = file:read("*a")
        file:close()
        
        -- 建立端口号到接口名的映射
        port_map[tonumber(port_no)] = ifname
    end
    
    return port_map
end

-- 打印网桥MAC地址表（调试用）
-- @param bridge 网桥名称
function print_br_macs(bridge)
    local macs = get_macs(bridge)
    
    if macs == nil then
        print("Bridge not found: " .. bridge)
        return
    end
    
    -- 打印表头
    print(string.format("%3s\t%s\t%s\t%s\t\t%8s", "No", "Dev", "MAC", "Local", "Ageing"))
    
    -- 打印每条记录
    for _, entry in ipairs(macs) do
        print(string.format("%3s\t%s\t%s\t%s\t\t%8s",
            entry.no,
            entry.dev,
            entry.mac,
            entry.is_local,
            entry.ageing))
    end
end

-- 打印所有网桥的MAC地址表
function print_all_macs()
    local bridges = {"br-lan", "br-guest"}
    
    for _, bridge in ipairs(bridges) do
        print("\n=== " .. bridge .. " ===")
        print_br_macs(bridge)
    end
end
