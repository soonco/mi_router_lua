-- LuCI CGI 服务器网关接口模块
-- 用于处理 CGI 请求，作为 Web 服务器和 LuCI 框架之间的桥梁

-- 记录脚本开始执行的时间（用于性能分析）
exectime = os.clock()

-- 定义模块，使用 package.seeall 使模块可以访问全局环境
module("luci.sgi.cgi", package.seeall)

-- 加载依赖模块
local ltn12 = require("luci.ltn12")
require("nixio.util")
require("luci.http")
require("luci.sys")
require("luci.dispatcher")

-- 创建输入源（用于读取 HTTP 请求体）
-- @param handle file - 输入文件句柄（通常是 stdin）
-- @param contentLength number - 请求体的内容长度
-- @return function - ltn12 兼容的数据源函数
local function createInputSource(handle, contentLength)
    contentLength = contentLength or 0
    local blockSize = ltn12.BLOCKSIZE
    
    return function()
        -- 如果没有更多数据可读，关闭句柄并返回 nil
        if contentLength < 1 then
            handle:close()
            return nil
        end
        
        -- 计算本次读取的字节数（不超过块大小和剩余长度）
        local readSize
        if contentLength > blockSize then
            readSize = blockSize
        else
            readSize = contentLength
        end
        
        -- 更新剩余长度
        contentLength = contentLength - readSize
        
        -- 从句柄读取数据
        local data = handle:read(readSize)
        if not data then
            handle:close()
        end
        
        return data
    end
end

-- 修复 os.execute 函数
-- 使用 xiaoqiang 的 waitExec 替代标准的 os.execute
-- 这样可以更好地处理命令执行的返回值
local function fixOsExecute()
    local XQFunction = require("xiaoqiang.common.XQFunction")
    
    os.execute = function(command)
        local status, exitCode = XQFunction.waitExec("/bin/sh", "-c", command)
        
        if status == "exited" then
            -- 正常退出：返回退出码 * 256
            return 256 * exitCode
        elseif status == "stopped" then
            -- 被停止：返回退出码 * 256 + 127
            return 256 * exitCode + 127
        else
            -- 其他情况：直接返回退出码
            return exitCode
        end
    end
end

-- CGI 主运行函数
-- 处理 HTTP 请求并调用 LuCI 调度器
function run()
    -- 修复 os.execute 函数
    fixOsExecute()
    
    -- 创建 HTTP 请求对象
    local request = luci.http.Request(
        -- 获取所有环境变量
        luci.sys.getenv(),
        -- 创建输入源，从 stdin 读取请求体
        createInputSource(
            io.stdin,
            tonumber(luci.sys.getenv("CONTENT_LENGTH"))
        ),
        -- 错误输出到 stderr
        ltn12.sink.file(io.stderr)
    )
    
    -- 创建协程来运行 HTTP 调度器
    local dispatcherCoroutine = coroutine.create(luci.dispatcher.httpdispatch)
    
    -- 用于累积 HTTP 响应头
    local headers = ""
    -- 标记输出是否仍然打开
    local outputOpen = true
    
    -- 主循环：处理调度器协程的输出
    while true do
        -- 检查协程是否已结束
        if coroutine.status(dispatcherCoroutine) == "dead" then
            break
        end
        
        -- 恢复协程执行，传入请求对象
        local ok, messageType, arg1, arg2 = coroutine.resume(dispatcherCoroutine, request)
        
        -- 如果协程执行出错，返回 500 错误
        if not ok then
            print("Status: 500 Internal Server Error")
            print("Content-Type: text/plain\n")
            print(messageType)  -- messageType 此时包含错误信息
            break
        end
        
        -- 只有在输出仍然打开时才处理消息
        if outputOpen then
            if messageType == 1 then
                -- 消息类型 1：设置 HTTP 状态码
                -- arg1 = 状态码, arg2 = 状态描述
                io.write("Status: " .. tostring(arg1) .. " " .. arg2 .. "\r\n")
                
            elseif messageType == 2 then
                -- 消息类型 2：添加 HTTP 响应头
                -- arg1 = 头名称, arg2 = 头值
                headers = headers .. arg1 .. ": " .. arg2 .. "\r\n"
                
            elseif messageType == 3 then
                -- 消息类型 3：完成响应头，开始响应体
                io.write(headers)
                io.write("\r\n")
                
            elseif messageType == 4 then
                -- 消息类型 4：写入响应体内容
                -- arg1 = 要写入的内容
                io.write(tostring(arg1 or ""))
                
            elseif messageType == 5 then
                -- 消息类型 5：关闭输出
                io.flush()
                io.close()
                outputOpen = false
                
            elseif messageType == 6 then
                -- 消息类型 6：零拷贝传输文件内容
                -- arg1 = 文件句柄, arg2 = 传输大小
                arg1:copyz(nixio.stdout, arg2)
                arg1:close()
            end
        end
    end
end
