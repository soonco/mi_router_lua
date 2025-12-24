# XQMiDockerUtil.lua - Docker工具模块

## 概述

`XQMiDockerUtil` 是小米路由器的Docker容器管理模块，提供Docker服务和容器的管理功能。该模块支持Docker服务的启停、容器的生命周期管理、镜像管理等操作，适用于支持Docker的高端路由器型号。

## 工作原理

```
┌─────────────────────────────────────────────────────────────────┐
│                    Docker管理架构                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐                                              │
│  │  API请求      │                                              │
│  └──────┬───────┘                                              │
│         │                                                       │
│         ▼                                                       │
│  ┌──────────────────────────────────────────────────────┐      │
│  │                 XQMiDockerUtil                        │      │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐     │      │
│  │  │ 服务管理    │  │ 容器管理    │  │ 镜像管理    │     │      │
│  │  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘     │      │
│  └────────┼───────────────┼───────────────┼─────────────┘      │
│           │               │               │                     │
│           ▼               ▼               ▼                     │
│  ┌─────────────────────────────────────────────────────┐       │
│  │                  Docker CLI                          │       │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐          │       │
│  │  │ docker   │  │ docker   │  │ docker   │          │       │
│  │  │ info     │  │ ps       │  │ images   │          │       │
│  │  └──────────┘  └──────────┘  └──────────┘          │       │
│  └─────────────────────────────────────────────────────┘       │
│           │                                                     │
│           ▼                                                     │
│  ┌─────────────────────────────────────────────────────┐       │
│  │                Docker Daemon                         │       │
│  │  /etc/init.d/docker (服务控制)                       │       │
│  └─────────────────────────────────────────────────────┘       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Docker服务状态

```
DOCKER_STATUS
├── STOPPED (0)   -- 已停止
├── RUNNING (1)   -- 运行中
└── ERROR (2)     -- 错误/不可用
```

## 接口列表

### 常量

| 常量名 | 值 | 说明 |
|--------|-----|------|
| `DOCKER_STATUS_STOPPED` | 0 | Docker服务已停止 |
| `DOCKER_STATUS_RUNNING` | 1 | Docker服务运行中 |
| `DOCKER_STATUS_ERROR` | 2 | Docker服务错误 |

### 服务管理函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `isDockerAvailable()` | 无 | boolean | 检查Docker是否可用 |
| `getDockerStatus()` | 无 | table | 获取Docker服务状态 |
| `startDocker()` | 无 | number | 启动Docker服务 |
| `stopDocker()` | 无 | number | 停止Docker服务 |
| `restartDocker()` | 无 | number | 重启Docker服务 |

### 容器管理函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getContainerList(all)` | all: boolean | table | 获取容器列表 |
| `startContainer(containerId)` | containerId: string | number | 启动容器 |
| `stopContainer(containerId)` | containerId: string | number | 停止容器 |
| `restartContainer(containerId)` | containerId: string | number | 重启容器 |
| `removeContainer(containerId, force)` | containerId: string, force: boolean | number | 删除容器 |
| `getContainerLogs(containerId, lines)` | containerId: string, lines: number | string | 获取容器日志 |
| `getContainerInfo(containerId)` | containerId: string | table/nil | 获取容器详细信息 |

### 镜像管理函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `getImageList()` | 无 | table | 获取镜像列表 |
| `removeImage(imageId, force)` | imageId: string, force: boolean | number | 删除镜像 |
| `pullImage(imageName)` | imageName: string | number | 拉取镜像 |

### 返回值说明

**getDockerStatus 返回结构:**
```lua
{
    available = 1,       -- 是否可用
    status = 1,          -- 服务状态
    version = "20.10.7", -- Docker版本
    containers = 5,      -- 容器总数
    running = 2,         -- 运行中容器数
    images = 10,         -- 镜像数量
    message = ""         -- 错误信息
}
```

**容器列表项结构:**
```lua
{
    id = "abc123",           -- 容器ID
    name = "my-container",   -- 容器名称
    image = "nginx:latest",  -- 镜像名称
    status = "Up 2 hours",   -- 状态描述
    ports = "80/tcp",        -- 端口映射
    running = 1              -- 是否运行中
}
```

**镜像列表项结构:**
```lua
{
    id = "sha256:abc",       -- 镜像ID
    repository = "nginx",    -- 仓库名
    tag = "latest",          -- 标签
    size = "133MB"           -- 大小
}
```

## 外部依赖

| 依赖模块 | 用途 |
|----------|------|
| `xiaoqiang.common.XQFunction` | 通用函数（字符串检查、异步执行） |
| `xiaoqiang.common.XQConfigs` | 配置常量 |
| `luci.util` | 命令执行 |
| `luci.jsonc` | JSON解析（容器详情） |

### 系统依赖

| 命令/服务 | 用途 |
|-----------|------|
| `docker` | Docker CLI命令 |
| `/etc/init.d/docker` | Docker服务控制脚本 |

## 被引用情况

| 引用模块 | 用途 |
|----------|------|
| API控制器 | Docker管理接口 |
| 插件系统 | 容器化插件管理 |

## 关键代码说明

### Docker可用性检查

```lua
function isDockerAvailable()
    local result = luciUtil.exec("which docker 2>/dev/null")
    if result and #result > 0 then
        return true
    end
    return false
end
```

### 获取Docker状态信息

```lua
function getDockerStatus()
    local statusOutput = luciUtil.exec("docker info 2>&1")
    
    if statusOutput:match("Server Version") then
        result.status = DOCKER_STATUS_RUNNING
        result.version = statusOutput:match("Server Version: ([%d%.]+)")
        result.containers = tonumber(statusOutput:match("Containers: (%d+)"))
        result.running = tonumber(statusOutput:match("Running: (%d+)"))
        result.images = tonumber(statusOutput:match("Images: (%d+)"))
    end
end
```

### 容器列表解析

```lua
function getContainerList(all)
    -- 使用自定义格式输出便于解析
    local cmd = "docker ps --format '{{.ID}}|{{.Names}}|{{.Image}}|{{.Status}}|{{.Ports}}'"
    if all then
        cmd = "docker ps -a --format '...'"
    end
    
    -- 解析输出
    for line in output:gmatch("[^\r\n]+") do
        local parts = {}
        for part in line:gmatch("[^|]+") do
            table.insert(parts, part)
        end
        -- 构建容器信息对象
        container.running = container.status:match("^Up") and 1 or 0
    end
end
```

### 异步镜像拉取

```lua
function pullImage(imageName)
    -- 异步执行，不阻塞请求
    local cmd = string.format("docker pull %s &", imageName)
    XQFunction.forkExec(cmd)
    return 0
end
```

### 容器详细信息获取

```lua
function getContainerInfo(containerId)
    local cmd = string.format("docker inspect %s 2>/dev/null", containerId)
    local output = luciUtil.exec(cmd)
    
    -- docker inspect返回JSON数组
    local parsed = json.parse(output)
    if parsed and #parsed > 0 then
        return parsed[1]
    end
end
```
