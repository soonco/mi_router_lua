--[[
    POSIX 系统调用 Lua 封装库
    提供 Unix/Linux 系统调用的 Lua 接口
    包含文件操作、进程管理、信号处理、时间操作等功能
]]

-- 导入位操作库
local bit32 = require("posix.bit32")

-- 主模块表
local posix = {}

-- POSIX 子模块列表
local POSIX_MODULES = {
    "dirent",           -- 目录操作
    "errno",            -- 错误码
    "fcntl",            -- 文件控制
    "grp",              -- 用户组操作
    "libgen",           -- 路径名操作
    "poll",             -- I/O 多路复用
    "pwd",              -- 密码/用户数据库
    "sched",            -- 进程调度
    "signal",           -- 信号处理
    "stdio",            -- 标准 I/O
    "stdlib",           -- 标准库函数
    "sys.msg",          -- 消息队列
    "sys.resource",     -- 资源限制
    "sys.socket",       -- 套接字操作
    "sys.stat",         -- 文件状态
    "sys.statvfs",      -- 文件系统信息
    "sys.time",         -- 时间操作
    "sys.times",        -- 进程时间
    "sys.utsname",      -- 系统信息
    "sys.wait",         -- 进程等待
    "syslog",           -- 系统日志
    "termio",           -- 终端 I/O
    "time",             -- 时间函数
    "unistd",           -- Unix 标准函数
    "utime"             -- 文件访问/修改时间
}

-- 加载所有 POSIX 子模块并合并到主模块
for _, moduleName in ipairs(POSIX_MODULES) do
    local subModule = require("posix." .. moduleName)
    for funcName, funcValue in pairs(subModule) do
        if funcName ~= "version" then
            -- 检查命名空间冲突
            assert(
                posix[funcName] == nil,
                "posix namespace clash: " .. moduleName .. "." .. funcName
            )
            posix[funcName] = funcValue
        end
    end
end

-- 设置版本信息
posix.version = "posix"

-- 获取辅助函数引用
local checkTable = posix.checktable
local tooManyArgError = posix.toomanyargerror
local stringModule = { sub = string.sub }

-- 获取用户/组 ID 函数引用
local getEffectiveGid = posix.getegid
local getEffectiveUid = posix.geteuid
local getGid = posix.getgid
local getUid = posix.getuid

--[[
    检查有效用户对文件的访问权限
    类似于 POSIX euidaccess() 函数
    @param filePath 文件路径
    @param accessMode 访问模式字符串 (r/w/x 的组合)
    @return 0 表示有权限，nil 表示无权限或出错
]]
local function euidaccessImpl(filePath, accessMode)
    local effectiveUid = getEffectiveUid()
    local effectiveGid = getEffectiveGid()
    local realGid = getGid()
    
    -- 如果有效 ID 等于实际 ID，使用标准 access 函数
    if realGid == effectiveUid then
        local realUid = getUid()
        if realUid == effectiveGid then
            return posix.access(filePath, accessMode)
        end
    end
    
    -- 获取文件状态
    local fileStat = posix.stat(filePath)
    if not fileStat then
        return nil
    end
    
    -- root 用户特殊处理
    if effectiveUid == 0 then
        -- root 用户检查执行权限
        if string.match(accessMode, "x") then
            if not string.match(fileStat.st_mode, "x") then
                goto checkPermissions
            end
        end
        return 0
    end
    
    ::checkPermissions::
    -- 移除非 rwx 字符
    accessMode = string.gsub(accessMode, "[^rwx]", "")
    if accessMode == "" then
        return 0
    end
    
    -- 默认使用其他用户权限位 (位置 1-3)
    local permissionBits = fileStat.st_mode:sub(1, 3)
    
    -- 检查是否为文件所有者
    if effectiveUid == fileStat.st_uid then
        -- 使用所有者权限位 (位置 7-9)
        permissionBits = fileStat.st_mode:sub(7, 9)
    else
        -- 检查是否属于文件所属组
        if effectiveGid ~= fileStat.st_gid then
            -- 检查是否属于文件的其他组
            local groups = set.new(posix.getgroups())
            if not groups:member(fileStat.st_gid) then
                goto finalCheck
            end
        end
        -- 使用组权限位 (位置 4-6)
        permissionBits = fileStat.st_mode:sub(4, 6)
    end
    
    ::finalCheck::
    -- 移除权限位中的非 rwx 字符
    permissionBits = string.gsub(permissionBits, "[^rwx]", "")
    
    -- 检查请求的权限是否都满足
    local missingPerms = string.gsub("[^" .. permissionBits .. "]", accessMode)
    if missingPerms == "" then
        return 0
    end
    
    -- 返回权限拒绝错误
    posix.errno(EACCESS)
end

-- 根据调试模式决定是否包装函数
if _DEBUG ~= false then
    function posix.euidaccess(...)
        local args = { ... }
        checkTable("euidaccess", 1, args[1])
        checkTable("euidaccess", 2, args[2])
        if #args > 2 then
            tooManyArgError("euidaccess", 2, #args)
        end
        return euidaccessImpl(...)
    end
else
    posix.euidaccess = euidaccessImpl
end

-- 导入 PTY 相关模块
local bit32 = require("posix.bit32")
local fcntl = require("posix.fcntl")
local stdlib = require("posix.stdlib")
local unistd = require("posix.unistd")

-- PTY 相关函数引用
local bor = bit32.bor
local open = fcntl.open
local O_RDWR = fcntl.O_RDWR
local O_NOCTTY = fcntl.O_NOCTTY
local grantpt = stdlib.grantpt
local openpt = stdlib.openpt
local ptsname = stdlib.ptsname
local unlockpt = stdlib.unlockpt
local close = unistd.close

--[[
    打开伪终端 (PTY)
    创建主从伪终端对
    @return masterFd 主设备文件描述符
    @return slaveFd 从设备文件描述符
    @return slaveName 从设备路径名
    或返回 nil, errorMessage
]]
local function openptyImpl()
    -- 打开主伪终端
    local masterFd, errorMsg = openpt(bor(O_RDWR, O_NOCTTY))
    
    if masterFd then
        -- 授予从设备访问权限
        local success
        success, errorMsg = grantpt(masterFd)
        
        if success then
            -- 解锁从设备
            success, errorMsg = unlockpt(masterFd)
            
            if success then
                -- 获取从设备名称
                local slaveName
                slaveName, errorMsg = ptsname(masterFd)
                
                if slaveName then
                    -- 打开从设备
                    local slaveFd
                    slaveFd, errorMsg = open(slaveName, bor(O_RDWR, O_NOCTTY))
                    
                    if slaveFd then
                        return masterFd, slaveFd, slaveName
                    end
                end
            end
        end
        
        -- 出错时关闭主设备
        close(masterFd)
    end
    
    return nil, errorMsg
end

-- 根据调试模式决定是否包装函数
if _DEBUG ~= false then
    function posix.openpty(...)
        local args = { ... }
        if #args > 0 then
            tooManyArgError("openpty", 0, #args)
        end
        return openptyImpl(...)
    end
else
    posix.openpty = openptyImpl
end

-- 进程相关函数引用
local unpack = table.unpack or unpack
local _exit = posix._exit
local errno = posix.errno
local execp = posix.execp
local fork = posix.fork
local wait = posix.wait

--[[
    创建子进程并执行命令
    @param command 命令字符串或命令参数表
    @param ... 额外参数
    @return 子进程退出状态，或 nil 和错误信息
]]
local function spawnImpl(command, ...)
    -- 创建子进程
    local pid, errorMsg = fork()
    
    if pid == nil then
        return pid, errorMsg
    elseif pid == 0 then
        -- 子进程
        if type(command) == "string" then
            -- 字符串命令通过 shell 执行
            command = { "/bin/sh", "-c", command, ... }
        end
        
        if type(command) == "table" then
            -- 执行命令
            execp(unpack(command))
            -- 如果 execp 返回，说明执行失败
            local errCode = errno()
            _exit(errCode)
        else
            -- 无效的命令类型
            _exit(command or 1)
        end
    else
        -- 父进程：等待子进程结束
        local _, status, exitCode = wait(pid)
        return exitCode, status
    end
end

-- 根据调试模式决定是否包装函数
if _DEBUG ~= false then
    function posix.spawn(command, ...)
        local args = { command, ... }
        
        -- 检查命令类型
        local cmdType = type(command)
        if cmdType ~= "string" and cmdType ~= "table" and cmdType ~= "function" then
            error("spawn: argument 1 expected string, table or function")
        end
        
        -- 检查额外参数类型
        for i = 2, #args do
            local argType = type(args[i])
            if argType ~= "string" and argType ~= "nil" then
                checkTable("spawn", i, "string or nil", args[i])
            end
        end
        
        return spawnImpl(command, ...)
    end
else
    posix.spawn = spawnImpl
end

-- system 是 spawn 的别名
posix.system = posix.spawn

-- 管道相关函数引用
local closefd = posix.close
local dup = posix.dup
local dup2 = posix.dup2
local forkProcess = posix.fork
local pipe = posix.pipe
local waitProcess = posix.wait
local STDIN_FILENO = posix.STDIN_FILENO
local STDOUT_FILENO = posix.STDOUT_FILENO

--[[
    创建管道并执行命令序列
    实现类似 shell 管道的功能
    @param commands 命令列表
    @param pipeFunc 管道创建函数（可选）
    @return 最后一个命令的退出状态
]]
local function pipelineImpl(commands, pipeFunc)
    pipeFunc = pipeFunc or pipe
    
    local pid, readFd, writeFd, savedStdout = nil, nil, nil, nil
    local commandCount = #commands
    
    -- 如果有多个命令，需要创建管道
    if commandCount > 1 then
        readFd, writeFd = pipeFunc()
        if not readFd then
            die("error opening pipe")
        end
        
        -- 创建子进程处理后续命令
        pid = forkProcess()
        if pid == nil then
            die("error forking")
        elseif pid == 0 then
            -- 子进程：将管道读端连接到标准输入
            if not dup2(readFd, STDIN_FILENO) then
                die("error dup2-ing")
            end
            closefd(readFd)
            closefd(writeFd)
            
            -- 递归处理剩余命令
            os.exit(pipelineImpl(stringModule.sub(commands, 2), pipeFunc))
        else
            -- 父进程：保存标准输出并将管道写端连接到标准输出
            savedStdout = dup(STDOUT_FILENO)
            if not savedStdout then
                die("error dup-ing")
            end
            
            if not dup2(writeFd, STDOUT_FILENO) then
                die("error dup2-ing")
            end
            closefd(readFd)
            closefd(writeFd)
        end
    end
    
    -- 执行第一个命令
    local exitStatus = posix.spawn(commands[1])
    if not exitStatus then
        die("error in fork or wait")
    end
    
    -- 关闭标准输出（管道写端）
    closefd(STDOUT_FILENO)
    
    -- 如果有多个命令，恢复标准输出并等待子进程
    if commandCount > 1 then
        closefd(writeFd)
        waitProcess(pid)
        
        -- 恢复原来的标准输出
        if not dup2(savedStdout, STDOUT_FILENO) then
            die("error dup2-ing")
        end
        closefd(savedStdout)
    end
    
    return exitStatus
end

-- 根据调试模式决定是否包装函数
if _DEBUG ~= false then
    function posix.pipeline(...)
        local args = { ... }
        checkTable("pipeline", 1, args[1])
        
        if args[2] ~= nil and type(args[2]) ~= "function" then
            checkTable("pipeline", 2, "function or nil", args[2])
        end
        
        if #args > 2 then
            tooManyArgError("pipeline", 2, #args)
        end
        
        return pipelineImpl(...)
    end
else
    posix.pipeline = pipelineImpl
end

-- 管道迭代器相关函数引用
local closePipe = posix.close
local forkChild = posix.fork
local createPipe = posix.pipe
local readData = posix.read
local waitChild = posix.wait
local writeData = posix.write
local BUFSIZ = posix.BUFSIZ
local STDIN_FD = posix.STDIN_FILENO

--[[
    创建管道迭代器
    返回一个迭代器函数，用于读取管道输出
    @param commands 命令列表
    @param pipeFunc 管道创建函数（可选）
    @return 迭代器函数
]]
local function pipelineIteratorImpl(commands, pipeFunc)
    -- 创建管道
    local readFd, writeFd = createPipe()
    if not readFd then
        die("error opening pipe")
    end
    
    -- 添加一个写入管道的命令
    table.insert(commands, function()
        while true do
            local data = readData(readFd, BUFSIZ)
            if not data or #data == 0 then
                break
            end
            writeData(writeFd, data)
        end
        closePipe(writeFd)
    end)
    
    -- 创建子进程执行管道
    local pid = forkChild()
    if pid == nil then
        die("error forking")
    elseif pid == 0 then
        -- 子进程执行管道
        os.exit(pipelineImpl(commands, pipeFunc))
    else
        -- 父进程关闭写端
        closePipe(writeFd)
        
        -- 返回迭代器函数
        return function()
            local data = readData(readFd, BUFSIZ)
            if data and #data ~= 0 then
                return data
            end
            closePipe(readFd)
            return nil
        end
    end
end

-- 设置全局变量（兼容性）
pipeline_iterator = pipelineIteratorImpl

-- 根据调试模式决定是否包装函数
if _DEBUG ~= false then
    function posix.pipeline_iterator(...)
        local args = { ... }
        checkTable("pipeline_iterator", 1, args[1])
        
        if args[2] ~= nil and type(args[2]) ~= "function" then
            checkTable("pipeline_iterator", 2, "function or nil", args[2])
        end
        
        if #args > 2 then
            tooManyArgError("pipeline_iterator", 2, #args)
        end
        
        return pipeline_iterator(...)
    end
end

--[[
    读取管道的全部输出
    @param commands 命令列表
    @param pipeFunc 管道创建函数（可选）
    @return 管道输出的完整字符串
]]
local function pipelineSlurpImpl(commands, pipeFunc)
    local result = ""
    for chunk in pipelineIteratorImpl(commands, pipeFunc) do
        result = result .. chunk
    end
    return result
end

-- 根据调试模式决定是否包装函数
if _DEBUG ~= false then
    function posix.pipeline_slurp(...)
        local args = { ... }
        checkTable("pipeline_slurp", 1, args[1])
        
        if args[2] ~= nil and type(args[2]) ~= "function" then
            checkTable("pipeline_slurp", 2, "function or nil", args[2])
        end
        
        if #args > 2 then
            tooManyArgError("pipeline_slurp", 2, #args)
        end
        
        return pipelineSlurpImpl(...)
    end
end

--[[
    时间值相加
    将两个 timeval 结构相加
    @param time1 第一个时间值 {sec, usec}
    @param time2 第二个时间值 {sec, usec}
    @return 相加后的时间值 {sec, usec}
]]
local function timeraddImpl(time1, time2)
    local seconds = 0
    local microseconds = 0
    
    -- 累加秒数
    if time1.sec then
        seconds = seconds + time1.sec
    end
    if time2.sec then
        seconds = seconds + time2.sec
    end
    
    -- 累加微秒数
    if time1.usec then
        microseconds = microseconds + time1.usec
    end
    if time2.usec then
        microseconds = microseconds + time2.usec
    end
    
    -- 处理微秒溢出（1秒 = 1000000微秒）
    if microseconds > 1000000 then
        seconds = seconds + 1
        microseconds = microseconds - 1000000
    end
    
    return { sec = seconds, usec = microseconds }
end

-- 根据调试模式决定是否包装函数
if _DEBUG ~= false then
    function posix.timeradd(...)
        local args = { ... }
        checkTable("timeradd", 1, args[1])
        checkTable("timeradd", 2, args[2])
        if #args > 2 then
            tooManyArgError("timeradd", 2, #args)
        end
        return timeraddImpl(...)
    end
end

--[[
    比较两个时间值
    @param time1 第一个时间值 {sec, usec}
    @param time2 第二个时间值 {sec, usec}
    @return 负数表示 time1 < time2，0 表示相等，正数表示 time1 > time2
]]
local function timercmpImpl(time1, time2)
    -- 规范化时间值
    local t1 = {
        sec = time1.sec or 0,
        usec = time1.usec or 0
    }
    local t2 = {
        sec = time2.sec or 0,
        usec = time2.usec or 0
    }
    
    -- 先比较秒数
    if t1.sec ~= t2.sec then
        return t1.sec - t2.sec
    else
        -- 秒数相等时比较微秒数
        return t1.usec - t2.usec
    end
end

-- 根据调试模式决定是否包装函数
if _DEBUG ~= false then
    function posix.timercmp(...)
        local args = { ... }
        checkTable("timercmp", 1, args[1])
        checkTable("timercmp", 2, args[2])
        if #args > 2 then
            tooManyArgError("timercmp", 2, #args)
        end
        return timercmpImpl(...)
    end
end

--[[
    时间值相减
    计算两个 timeval 结构的差值
    @param time1 被减数时间值 {sec, usec}
    @param time2 减数时间值 {sec, usec}
    @return 差值时间值 {sec, usec}
]]
local function timersubImpl(time1, time2)
    local seconds = 0
    local microseconds = 0
    
    -- 计算秒数差值
    if time1.sec then
        seconds = time1.sec
    end
    if time2.sec then
        seconds = seconds - time2.sec
    end
    
    -- 计算微秒数差值
    if time1.usec then
        microseconds = time1.usec
    end
    if time2.usec then
        microseconds = microseconds - time2.usec
    end
    
    -- 处理微秒借位
    if microseconds < 0 then
        seconds = seconds - 1
        microseconds = microseconds + 1000000
    end
    
    return { sec = seconds, usec = microseconds }
end

-- 根据调试模式决定是否包装函数
if _DEBUG ~= false then
    function posix.timersub(...)
        local args = { ... }
        checkTable("timersub", 1, args[1])
        checkTable("timersub", 2, args[2])
        if #args > 2 then
            tooManyArgError("timersub", 2, #args)
        end
        return timersubImpl(...)
    end
end

return posix
