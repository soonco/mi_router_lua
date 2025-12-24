--[[
    配置扫描控制器模块 (Config Scanner Controller Module)
    
    功能说明:
    - 提供路由器配置安全扫描的API接口
    - 支持异步扫描任务管理
    - 检测配置中的安全风险
    
    API端点:
    - /api/config_scanner/overview: 获取扫描概览
    - /api/config_scanner/config: 配置扫描项
    - /api/config_scanner/start: 启动扫描
    - /api/config_scanner/get_status: 获取扫描状态
    - /api/config_scanner/stop: 停止扫描
    
    依赖模块:
    - xiaoqiang.XQFeatures: 功能特性
    - luci.http: HTTP处理
    - config_scan.main_scanner: 主扫描器
]]

module("luci.controller.config_scan.index", package.seeall)

local XQFeatures = require("xiaoqiang.XQFeatures").FEATURES
local http = require("luci.http")

local BASE_PATH = "/tmp/config_scan"
local IDS_PATH = BASE_PATH .. "/meta/ids"
local RESULT_PATH = BASE_PATH .. "/meta/result"
local PIDS_PATH = BASE_PATH .. "/meta/pids"
local MAX_CONCURRENT = 4

math.randomseed(os.time())

function index()
    local api_node = node("api", "config_scanner")
    api_node.sysauth = "admin"
    api_node.sysauth_authenticator = "htmlauth"
    api_node.index = true
    
    entry({"api", "config_scanner", "overview"}, call("overview"), "")
    entry({"api", "config_scanner", "config"}, call("config"), "")
    entry({"api", "config_scanner", "start"}, call("start"), "")
    entry({"api", "config_scanner", "get_status"}, call("get_status"), "")
    entry({"api", "config_scanner", "stop"}, call("stop"), "")
end

local function get_uptime()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local _, _, uptime = XQFunction.waitExec("awk", "/^now/ {print $3; exit}", "/proc/timer_list")
    return math.floor(tonumber(uptime / 1000000000))
end

local function ensure_dirs()
    os.execute("mkdir -p " .. IDS_PATH)
    os.execute("mkdir -p " .. RESULT_PATH)
    os.execute("mkdir -p " .. PIDS_PATH)
end

local function acquire_lock()
    local fcntl = require("posix.fcntl")
    local unistd = require("posix.unistd")
    local stat = require("posix.sys.stat")
    
    local fd = fcntl.open("/tmp/lock/config_scan.lock", 
        fcntl.O_CREAT + fcntl.O_WRONLY + fcntl.O_TRUNC, 
        stat.IRWXU)
    
    fcntl.fcntl(fd, fcntl.F_SETLKW, {
        l_type = fcntl.F_WRLCK,
        l_whence = fcntl.SEEK_SET,
        l_start = 0,
        l_len = 0
    })
    
    return fd
end

local function release_lock(fd)
    local unistd = require("posix.unistd")
    unistd.close(fd)
end

local function write_file(dir, filename, content)
    local nixio = require("nixio")
    local f = nixio.open(dir .. "/" .. filename, "w")
    f:write(content)
    f:close()
end

local function read_file(dir, filename)
    local nixio = require("nixio")
    local f = nixio.open(dir .. "/" .. filename, "r")
    if not f then
        return nil
    end
    local content = f:read(1024)
    f:close()
    return tonumber(content)
end

local function list_work_ids(dir)
    local ids_map = {}
    local ids_list = {}
    local nixio = require("nixio")
    
    local files = nixio.fs.dir(dir)
    if not files then
        return ids_map, ids_list
    end
    
    for file in files do
        if file ~= "." and file ~= ".." then
            local ts = read_file(dir, file)
            ids_map[file] = ts
            table.insert(ids_list, {
                workid = file,
                ts = ts
            })
        end
    end
    
    return ids_map, ids_list
end

local function remove_work(workid)
    os.remove(IDS_PATH .. "/" .. workid)
    os.remove(RESULT_PATH .. "/" .. workid)
    os.remove(PIDS_PATH .. "/" .. workid)
    os.execute("rm -r " .. BASE_PATH .. "/" .. workid)
end

local function cleanup_old_works()
    local now = get_uptime()
    local _, ids_list = list_work_ids(IDS_PATH)
    
    for _, item in ipairs(ids_list) do
        if item.ts < now - 10 then
            remove_work(item.workid)
        end
    end
end

local function create_work_id()
    ensure_dirs()
    cleanup_old_works()
    
    local ids_map, ids_list = list_work_ids(IDS_PATH)
    local _, pids_list = list_work_ids(PIDS_PATH)
    
    local running_count = #ids_list - #pids_list
    if running_count >= MAX_CONCURRENT or #pids_list >= MAX_CONCURRENT * 2 then
        return nil
    end
    
    local workid = tostring(math.random(1000))
    while ids_map[workid] do
        workid = tostring(math.random(1000))
    end
    
    write_file(IDS_PATH, workid, get_uptime())
    return workid
end

local function update_work_timestamp(workid)
    local ids_map = list_work_ids(IDS_PATH)
    if ids_map[workid] then
        write_file(IDS_PATH, workid, get_uptime())
    end
end

function _overview()
    local main_scanner = require("config_scan.main_scanner")
    return main_scanner.overview()
end

function overview()
    local result = _overview()
    result.code = 0
    http.write_json(result)
end

function config()
    ensure_dirs()
    
    local uci = require("luci.model.uci").cursor()
    local overview_data = _overview()
    local form_data = http.formvaluetable()
    
    for key, value in pairs(form_data) do
        if overview_data[key] ~= nil then
            uci:set("config_scan", key, "node")
            if value == "1" then
                uci:set("config_scan", key, "ignored", "0")
            elseif value == "0" then
                uci:set("config_scan", key, "ignored", "1")
            end
        end
    end
    
    uci:commit("config_scan")
    http.write_json({ code = 0 })
end

function scan(workid)
    local main_scanner = require("config_scan.main_scanner")
    local work_path = BASE_PATH .. "/" .. workid
    
    main_scanner.scan(work_path)
    
    local result = _overview()
    remove_work(workid)
    
    http.write_json(result)
end

function start()
    ensure_dirs()
    
    local workid = create_work_id()
    if not workid then
        http.write_json({
            code = -1,
            msg = "resource busy"
        })
        return
    end
    
    local nixio = require("nixio")
    local work_path = BASE_PATH .. "/" .. workid
    nixio.fs.mkdir(work_path)
    
    local main_scanner = require("config_scan.main_scanner")
    main_scanner.prepare(work_path)
    
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local pid = XQFunction.forkExec2("lua", "-e",
        string.format('require("luci.controller.config_scan.index").scan("%s")', workid))
    
    write_file(PIDS_PATH, workid, pid)
    
    http.write_json({
        code = 0,
        meta = {
            work_id = workid
        }
    })
end

function _get_status(workid)
    local ids_map = list_work_ids(IDS_PATH)
    local pids_map = list_work_ids(PIDS_PATH)
    
    if not ids_map[workid] then
        return nil
    end
    
    local is_done = pids_map[workid] ~= nil
    
    local XQFunction = require("xiaoqiang.common.XQFunction")
    local work_path = BASE_PATH .. "/" .. workid
    
    local _, _, output = XQFunction.waitExec("find", work_path, "-name", "display")
    
    local running_item = nil
    local items = {}
    
    for line in output:gmatch("[^\n]+") do
        local parts = {}
        for part in line:gmatch("[^/]+") do
            table.insert(parts, part)
        end
        
        if #parts > 0 then
            local item_path = line:sub(1, -8)
            local status_file = item_path .. "/status"
            local status = read_file(item_path, "status")
            
            local item = {
                status = status
            }
            
            if status == 1 then
                running_item = parts[#parts - 2]
            end
            
            if status == 2 then
                local score = read_file(item_path, "score")
                item.secure = score and 1 or 0
                
                local enable_file = io.open(item_path .. "/enable_scan", "r")
                item.enable_scan = enable_file and 1 or 0
                if enable_file then
                    enable_file:close()
                end
            end
            
            items[parts[#parts - 2]] = item
        end
    end
    
    local meta = {}
    meta.status = is_done and 2 or 1
    meta.score = read_file(work_path .. "/meta", "score")
    meta.running = running_item
    items.meta = meta
    
    update_work_timestamp(workid)
    
    return items
end

function get_status()
    ensure_dirs()
    
    local workid = http.formvalue("work_id", nil)
    local result = _get_status(workid)
    
    if not result then
        http.write_json({ code = -1 })
        return
    end
    
    result.code = 0
    http.write_json(result)
end

local function kill_process(workid)
    local nixio = require("nixio")
    local pid = read_file(PIDS_PATH, workid)
    
    nixio.setenv("pid", tostring(pid))
    os.execute([[
        kill "$pid";
        while kill -0 "$pid"; do 
            kill "$pid";
            sleep 1;
        done
    ]])
end

function stop()
    ensure_dirs()
    
    local workid = http.formvalue("work_id", nil)
    local ids_map = list_work_ids(IDS_PATH)
    local pids_map = list_work_ids(PIDS_PATH)
    
    if not ids_map[workid] then
        http.write_json({ code = -1 })
        return
    end
    
    if not pids_map[workid] then
        kill_process(workid)
        remove_work(workid)
    end
    
    local result = _get_status(workid)
    result.code = 0
    http.write_json(result)
end
