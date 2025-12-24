--[[
  小米路由器eBit宽带加速模块 (XQEBit)
  
  功能说明:
  - 与eBit宽带加速服务进行API交互
  - 提供宽带加速的开启、关闭、查询功能
  - 支持用户信息查询和任务状态查询
  - 通过运营商合作实现网络加速
  
  API服务器:
  - 服务地址: http://218.85.118.9:8000/api2/
  - 使用JSON格式进行数据交换
  - 需要APP_ID和密钥进行身份验证
  
  主要功能:
  - basic_info_query: 查询用户基本信息
  - speed_up_open: 开启宽带加速
  - speed_up_close: 关闭宽带加速
  - speed_up_query: 查询加速状态
  - speed_up_check: 检查是否支持加速
--]]

-- 定义模块
module("xiaoqiang.module.XQEBit", package.seeall)

-- 引入JSON处理模块
local json = require("json")

-- 引入日志模块
local XQLog = require("xiaoqiang.XQLog")

-- 引入通用函数模块
local XQFunction = require("xiaoqiang.common.XQFunction")

-- 引入HTTP工具模块
local XQHttpUtil = require("xiaoqiang.util.XQHttpUtil")

-- 引入HTTP协议模块
local protocol = require("luci.http.protocol")

-- eBit API配置常量
local APP_ID = "APP_MIOFGBVQ"                                    -- 应用ID
local APP_SECRET = "2ErNCyfk8HZoH432T7Em0K16"                    -- 应用密钥
local API_USER_QUERY = "http://218.85.118.9:8000/api2/user/query"      -- 用户查询接口
local API_TASK_QUERY = "http://218.85.118.9:8000/api2/task/query"      -- 任务查询接口
local API_SPEEDUP_OPEN = "http://218.85.118.9:8000/api2/speedup/open"  -- 开启加速接口
local API_SPEEDUP_CLOSE = "http://218.85.118.9:8000/api2/speedup/close" -- 关闭加速接口
local API_SPEEDUP_QUERY = "http://218.85.118.9:8000/api2/speedup/query" -- 查询加速接口
local API_SPEEDUP_CHECK = "http://218.85.118.9:8000/api2/speedup/check" -- 检查加速接口

--[[
  生成API请求签名
  
  签名算法:
  1. 获取当前时间戳
  2. 拼接: APP_ID + 时间戳 + APP_SECRET
  3. 对拼接字符串进行MD5哈希
  
  @return number 时间戳
  @return string MD5签名
--]]
function genSecret()
    local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")
    
    -- 获取当前时间戳
    local timestamp = os.time()
    
    -- 构建待签名字符串: APP_ID + 时间戳 + APP_SECRET
    local signStr = APP_ID .. tostring(timestamp) .. APP_SECRET
    
    -- 计算MD5签名
    local secret = XQCryptoUtil.md5Str(signStr)
    
    return timestamp, secret
end

--[[
  获取WAN口IP地址
  
  @return string WAN口IP地址，如果获取失败返回nil
--]]
function wanip()
    local XQLanWanUtil = require("xiaoqiang.util.XQLanWanUtil")
    
    -- 获取WAN口状态
    local wanStatus = XQLanWanUtil.ubusWanStatus()
    
    if wanStatus then
        local ipv4 = wanStatus.ipv4
        if ipv4 then
            -- 检查是否有IPv4地址
            if #ipv4 > 0 then
                -- 返回第一个IPv4地址
                return ipv4[1].ip
            end
        end
    end
    
    return nil
end

--[[
  查询任务状态
  
  @param timestamp number 时间戳
  @param secret string 签名
  @param taskId string 任务ID
  @return table 任务信息，失败返回nil
--]]
function task_query(timestamp, secret, taskId)
    local params = {}
    
    -- 构建请求参数
    params.app = APP_ID
    params.timestamp = timestamp
    params.secret = secret
    params.task_id = taskId
    
    -- 发送POST请求
    local response = XQHttpUtil.httpPostRequest(
        API_TASK_QUERY,
        json.encode(params),
        nil,
        "application/json"
    )
    
    if response then
        local code = response.code
        if code then
            if code == 200 then
                -- 解析响应JSON
                return json.decode(response.res)
            end
        end
    else
        XQLog.log(4, "XQEBit task/query failed", response)
        return nil
    end
end

--[[
  查询用户基本信息
  
  @param ip string 可选，指定IP地址，不指定则自动获取WAN口IP
  @return table 用户信息，失败返回nil
--]]
function basic_info_query(ip)
    -- 生成签名
    local timestamp, secret = genSecret()
    local wanIp = nil
    
    -- 获取IP地址
    if not ip then
        wanIp = wanip()
        if not wanIp then
            return nil
        end
    else
        wanIp = ip
    end
    
    -- 构建请求参数
    local params = {}
    params.app = APP_ID
    params.timestamp = timestamp
    params.secret = secret
    params._type = 0  -- 查询类型: 0表示按IP查询
    params.data = wanIp
    
    -- 发送POST请求
    local response = XQHttpUtil.httpPostRequest(
        API_USER_QUERY,
        json.encode(params),
        nil,
        "application/json"
    )
    
    if response then
        local code = response.code
        if code then
            if code == 200 then
                -- 解析响应
                local result = json.decode(response.res)
                
                -- 如果返回了任务ID，继续查询任务状态
                if result.task_id then
                    return task_query(timestamp, secret, result.task_id)
                end
            end
        end
    else
        XQLog.log(4, "XQEBit user/query failed", response)
    end
    
    return nil
end

--[[
  开启宽带加速
  
  @param upBandwidth number 上行带宽 (Kbps)
  @param downBandwidth number 下行带宽 (Kbps)
  @param duration number 加速时长 (秒)
  @param dialAccount string 拨号账号
  @param ip string 可选，指定IP地址
  @return table 加速结果，失败返回nil
--]]
function speed_up_open(upBandwidth, downBandwidth, duration, dialAccount, ip)
    -- 获取IP地址
    if not ip then
        ip = wanip()
    end
    
    -- 生成签名
    local timestamp, secret = genSecret()
    
    -- 构建请求参数
    local params = {}
    params.app = APP_ID
    params.timestamp = timestamp
    params.secret = secret
    params.ip_addr = ip
    params.dial_acct = dialAccount
    
    -- 设置带宽参数 [上行, 下行]
    params.bandwidths = {upBandwidth, downBandwidth}
    params.duration = duration
    
    -- 发送POST请求
    local response = XQHttpUtil.httpPostRequest(
        API_SPEEDUP_OPEN,
        json.encode(params),
        nil,
        "application/json"
    )
    
    if response then
        local code = response.code
        if code then
            if code == 200 then
                -- 解析响应
                local result = json.decode(response.res)
                
                -- 如果返回了任务ID，继续查询任务状态
                if result.task_id then
                    return task_query(timestamp, secret, result.task_id)
                end
            end
        end
    else
        XQLog.log(4, "XQEBit speedup/open failed", response)
    end
    
    return nil
end

--[[
  关闭宽带加速
  
  @param channelId string 加速通道ID
  @return table 关闭结果，失败返回nil
--]]
function speed_up_close(channelId)
    -- 生成签名
    local timestamp, secret = genSecret()
    
    -- 构建请求参数
    local params = {}
    params.app = APP_ID
    params.timestamp = timestamp
    params.secret = secret
    params.channel_id = channelId
    
    -- 发送POST请求
    local response = XQHttpUtil.httpPostRequest(
        API_SPEEDUP_CLOSE,
        json.encode(params),
        nil,
        "application/json"
    )
    
    if response then
        local code = response.code
        if code then
            if code == 200 then
                -- 解析响应
                local result = json.decode(response.res)
                
                -- 如果返回了任务ID，继续查询任务状态
                if result.task_id then
                    return task_query(timestamp, secret, result.task_id)
                end
            end
        end
    else
        XQLog.log(4, "XQEBit speedup/close failed", response)
    end
    
    return nil
end

--[[
  查询加速状态
  
  @param channelId string 加速通道ID
  @return table 加速状态信息，失败返回nil
--]]
function speed_up_query(channelId)
    -- 生成签名
    local timestamp, secret = genSecret()
    
    -- 构建请求参数
    local params = {}
    params.app = APP_ID
    params.timestamp = timestamp
    params.secret = secret
    params.channel_id = channelId
    
    -- 发送POST请求
    local response = XQHttpUtil.httpPostRequest(
        API_SPEEDUP_QUERY,
        json.encode(params),
        nil,
        "application/json"
    )
    
    if response then
        local code = response.code
        if code then
            if code == 200 then
                -- 解析响应
                local result = json.decode(response.res)
                
                -- 如果返回了任务ID，继续查询任务状态
                if result.task_id then
                    return task_query(timestamp, secret, result.task_id)
                end
            end
        end
    else
        XQLog.log(4, "XQEBit speedup/query failed", response)
    end
    
    return nil
end

--[[
  检查是否支持宽带加速
  
  @param dialAccount string 拨号账号
  @param ip string 可选，指定IP地址
  @return table 检查结果，失败返回nil
--]]
function speed_up_check(dialAccount, ip)
    -- 获取IP地址
    if not ip then
        ip = wanip()
    end
    
    -- 生成签名
    local timestamp, secret = genSecret()
    
    -- 构建请求参数
    local params = {}
    params.app = APP_ID
    params.timestamp = timestamp
    params.secret = secret
    params.ip_addr = ip
    params.dial_acct = dialAccount
    
    -- 发送POST请求
    local response = XQHttpUtil.httpPostRequest(
        API_SPEEDUP_CHECK,
        json.encode(params),
        nil,
        "application/json"
    )
    
    if response then
        local code = response.code
        if code then
            if code == 200 then
                -- 解析响应
                local result = json.decode(response.res)
                
                -- 如果返回了任务ID，继续查询任务状态
                if result.task_id then
                    return task_query(timestamp, secret, result.task_id)
                end
            end
        end
    else
        XQLog.log(4, "XQEBit speedup/check failed", response)
    end
    
    return nil
end
