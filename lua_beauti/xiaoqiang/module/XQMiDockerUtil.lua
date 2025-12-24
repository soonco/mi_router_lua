--[[
  小米路由器Docker工具模块 (XQMiDockerUtil)
  功能: 管理路由器上的Docker容器服务
  
  主要功能:
  - Docker服务状态管理
  - 容器管理
  - 镜像管理
]]

module("xiaoqiang.module.XQMiDockerUtil", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

-- Docker服务状态常量
DOCKER_STATUS_STOPPED = 0    -- 已停止
DOCKER_STATUS_RUNNING = 1    -- 运行中
DOCKER_STATUS_ERROR = 2      -- 错误

--[[
  检查Docker服务是否可用
  @return true/false
]]
function isDockerAvailable()
    local luciUtil = require("luci.util")
    
    -- 检查docker命令是否存在
    local result = luciUtil.exec("which docker 2>/dev/null")
    
    if result and #result > 0 then
        return true
    else
        return false
    end
end

--[[
  获取Docker服务状态
  @return 状态信息表
]]
function getDockerStatus()
    local luciUtil = require("luci.util")
    local result = {}
    
    -- 检查Docker是否可用
    if not isDockerAvailable() then
        result.available = 0
        result.status = DOCKER_STATUS_ERROR
        result.message = "Docker not installed"
        return result
    end
    
    result.available = 1
    
    -- 检查Docker服务状态
    local statusOutput = luciUtil.exec("docker info 2>&1")
    
    if statusOutput and statusOutput:match("Server Version") then
        result.status = DOCKER_STATUS_RUNNING
        
        -- 获取版本信息
        local version = statusOutput:match("Server Version: ([%d%.]+)")
        if version then
            result.version = version
        end
        
        -- 获取容器数量
        local containers = statusOutput:match("Containers: (%d+)")
        if containers then
            result.containers = tonumber(containers)
        end
        
        -- 获取运行中的容器数量
        local running = statusOutput:match("Running: (%d+)")
        if running then
            result.running = tonumber(running)
        end
        
        -- 获取镜像数量
        local images = statusOutput:match("Images: (%d+)")
        if images then
            result.images = tonumber(images)
        end
    else
        result.status = DOCKER_STATUS_STOPPED
        result.message = "Docker service not running"
    end
    
    return result
end

--[[
  启动Docker服务
  @return 0=成功, 1=失败
]]
function startDocker()
    if not isDockerAvailable() then
        return 1
    end
    
    XQFunction.forkExec("/etc/init.d/docker start")
    return 0
end

--[[
  停止Docker服务
  @return 0=成功, 1=失败
]]
function stopDocker()
    if not isDockerAvailable() then
        return 1
    end
    
    XQFunction.forkExec("/etc/init.d/docker stop")
    return 0
end

--[[
  重启Docker服务
  @return 0=成功, 1=失败
]]
function restartDocker()
    if not isDockerAvailable() then
        return 1
    end
    
    XQFunction.forkExec("/etc/init.d/docker restart")
    return 0
end

--[[
  获取容器列表
  @param all 是否包含已停止的容器
  @return 容器列表
]]
function getContainerList(all)
    local luciUtil = require("luci.util")
    local result = {}
    
    if not isDockerAvailable() then
        return result
    end
    
    -- 构建命令
    local cmd = "docker ps --format '{{.ID}}|{{.Names}}|{{.Image}}|{{.Status}}|{{.Ports}}'"
    if all then
        cmd = "docker ps -a --format '{{.ID}}|{{.Names}}|{{.Image}}|{{.Status}}|{{.Ports}}'"
    end
    
    local output = luciUtil.exec(cmd .. " 2>/dev/null")
    
    if output and #output > 0 then
        for line in output:gmatch("[^\r\n]+") do
            local parts = {}
            for part in line:gmatch("[^|]+") do
                table.insert(parts, part)
            end
            
            if #parts >= 4 then
                local container = {}
                container.id = parts[1]
                container.name = parts[2]
                container.image = parts[3]
                container.status = parts[4]
                container.ports = parts[5] or ""
                
                -- 判断运行状态
                if container.status:match("^Up") then
                    container.running = 1
                else
                    container.running = 0
                end
                
                table.insert(result, container)
            end
        end
    end
    
    return result
end

--[[
  启动容器
  @param containerId 容器ID或名称
  @return 0=成功, 1=失败
]]
function startContainer(containerId)
    local luciUtil = require("luci.util")
    
    if not isDockerAvailable() or XQFunction.isStrNil(containerId) then
        return 1
    end
    
    local cmd = string.format("docker start %s 2>&1", containerId)
    local output = luciUtil.exec(cmd)
    
    if output and output:match(containerId) then
        return 0
    else
        return 1
    end
end

--[[
  停止容器
  @param containerId 容器ID或名称
  @return 0=成功, 1=失败
]]
function stopContainer(containerId)
    local luciUtil = require("luci.util")
    
    if not isDockerAvailable() or XQFunction.isStrNil(containerId) then
        return 1
    end
    
    local cmd = string.format("docker stop %s 2>&1", containerId)
    local output = luciUtil.exec(cmd)
    
    if output and output:match(containerId) then
        return 0
    else
        return 1
    end
end

--[[
  重启容器
  @param containerId 容器ID或名称
  @return 0=成功, 1=失败
]]
function restartContainer(containerId)
    local luciUtil = require("luci.util")
    
    if not isDockerAvailable() or XQFunction.isStrNil(containerId) then
        return 1
    end
    
    local cmd = string.format("docker restart %s 2>&1", containerId)
    local output = luciUtil.exec(cmd)
    
    if output and output:match(containerId) then
        return 0
    else
        return 1
    end
end

--[[
  删除容器
  @param containerId 容器ID或名称
  @param force 是否强制删除运行中的容器
  @return 0=成功, 1=失败
]]
function removeContainer(containerId, force)
    local luciUtil = require("luci.util")
    
    if not isDockerAvailable() or XQFunction.isStrNil(containerId) then
        return 1
    end
    
    local cmd = "docker rm"
    if force then
        cmd = cmd .. " -f"
    end
    cmd = string.format("%s %s 2>&1", cmd, containerId)
    
    local output = luciUtil.exec(cmd)
    
    if output and output:match(containerId) then
        return 0
    else
        return 1
    end
end

--[[
  获取镜像列表
  @return 镜像列表
]]
function getImageList()
    local luciUtil = require("luci.util")
    local result = {}
    
    if not isDockerAvailable() then
        return result
    end
    
    local cmd = "docker images --format '{{.ID}}|{{.Repository}}|{{.Tag}}|{{.Size}}' 2>/dev/null"
    local output = luciUtil.exec(cmd)
    
    if output and #output > 0 then
        for line in output:gmatch("[^\r\n]+") do
            local parts = {}
            for part in line:gmatch("[^|]+") do
                table.insert(parts, part)
            end
            
            if #parts >= 4 then
                local image = {}
                image.id = parts[1]
                image.repository = parts[2]
                image.tag = parts[3]
                image.size = parts[4]
                table.insert(result, image)
            end
        end
    end
    
    return result
end

--[[
  删除镜像
  @param imageId 镜像ID或名称
  @param force 是否强制删除
  @return 0=成功, 1=失败
]]
function removeImage(imageId, force)
    local luciUtil = require("luci.util")
    
    if not isDockerAvailable() or XQFunction.isStrNil(imageId) then
        return 1
    end
    
    local cmd = "docker rmi"
    if force then
        cmd = cmd .. " -f"
    end
    cmd = string.format("%s %s 2>&1", cmd, imageId)
    
    local output = luciUtil.exec(cmd)
    
    if output and (output:match("Untagged") or output:match("Deleted")) then
        return 0
    else
        return 1
    end
end

--[[
  拉取镜像
  @param imageName 镜像名称
  @return 0=成功, 1=失败
]]
function pullImage(imageName)
    if not isDockerAvailable() or XQFunction.isStrNil(imageName) then
        return 1
    end
    
    -- 异步拉取镜像
    local cmd = string.format("docker pull %s &", imageName)
    XQFunction.forkExec(cmd)
    
    return 0
end

--[[
  获取容器日志
  @param containerId 容器ID或名称
  @param lines 日志行数
  @return 日志内容
]]
function getContainerLogs(containerId, lines)
    local luciUtil = require("luci.util")
    
    if not isDockerAvailable() or XQFunction.isStrNil(containerId) then
        return ""
    end
    
    lines = lines or 100
    local cmd = string.format("docker logs --tail %d %s 2>&1", lines, containerId)
    local output = luciUtil.exec(cmd)
    
    return output or ""
end

--[[
  获取容器详细信息
  @param containerId 容器ID或名称
  @return 容器详细信息
]]
function getContainerInfo(containerId)
    local luciUtil = require("luci.util")
    local json = require("luci.jsonc")
    
    if not isDockerAvailable() or XQFunction.isStrNil(containerId) then
        return nil
    end
    
    local cmd = string.format("docker inspect %s 2>/dev/null", containerId)
    local output = luciUtil.exec(cmd)
    
    if output and #output > 0 then
        local parsed = json.parse(output)
        if parsed and #parsed > 0 then
            return parsed[1]
        end
    end
    
    return nil
end
