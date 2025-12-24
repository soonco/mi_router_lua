--[[
  小米路由器消息盒子模块 (XQMessageBox)
  功能: 管理路由器系统消息和通知
  
  主要功能:
  - 系统消息管理
  - 消息推送
  - 消息已读状态管理
]]

module("xiaoqiang.module.XQMessageBox", package.seeall)

-- 引入依赖模块
local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")

-- 消息类型常量
MSG_TYPE_SYSTEM = 1          -- 系统消息
MSG_TYPE_SECURITY = 2        -- 安全消息
MSG_TYPE_UPDATE = 3          -- 更新消息
MSG_TYPE_DEVICE = 4          -- 设备消息
MSG_TYPE_PLUGIN = 5          -- 插件消息

-- 消息优先级常量
MSG_PRIORITY_LOW = 1         -- 低优先级
MSG_PRIORITY_NORMAL = 2      -- 普通优先级
MSG_PRIORITY_HIGH = 3        -- 高优先级

-- 消息存储文件路径
MSG_STORAGE_PATH = "/tmp/message_box.json"

--[[
  获取所有消息列表
  @param msgType 消息类型(可选，不提供则获取所有类型)
  @param unreadOnly 是否只获取未读消息
  @return 消息列表
]]
function getMessages(msgType, unreadOnly)
    local json = require("luci.jsonc")
    local fs = require("nixio.fs")
    local result = {}
    
    -- 读取消息存储文件
    local content = fs.readfile(MSG_STORAGE_PATH)
    if not content or #content == 0 then
        return result
    end
    
    local messages = json.parse(content)
    if not messages or type(messages) ~= "table" then
        return result
    end
    
    -- 过滤消息
    for _, msg in ipairs(messages) do
        local include = true
        
        -- 按类型过滤
        if msgType and msg.type ~= msgType then
            include = false
        end
        
        -- 按已读状态过滤
        if unreadOnly and msg.read == 1 then
            include = false
        end
        
        if include then
            table.insert(result, msg)
        end
    end
    
    -- 按时间倒序排列
    table.sort(result, function(a, b)
        return (a.timestamp or 0) > (b.timestamp or 0)
    end)
    
    return result
end

--[[
  获取未读消息数量
  @param msgType 消息类型(可选)
  @return 未读消息数量
]]
function getUnreadCount(msgType)
    local messages = getMessages(msgType, true)
    return #messages
end

--[[
  添加新消息
  @param msgType 消息类型
  @param title 消息标题
  @param content 消息内容
  @param priority 优先级(可选，默认普通)
  @param extra 额外数据(可选)
  @return 消息ID
]]
function addMessage(msgType, title, content, priority, extra)
    local json = require("luci.jsonc")
    local fs = require("nixio.fs")
    
    -- 参数校验
    if not msgType or XQFunction.isStrNil(title) then
        return nil
    end
    
    -- 读取现有消息
    local existingContent = fs.readfile(MSG_STORAGE_PATH)
    local messages = {}
    if existingContent and #existingContent > 0 then
        messages = json.parse(existingContent) or {}
    end
    
    -- 生成消息ID
    local msgId = string.format("%d_%d", os.time(), math.random(1000, 9999))
    
    -- 创建新消息
    local newMsg = {
        id = msgId,
        type = msgType,
        title = title,
        content = content or "",
        priority = priority or MSG_PRIORITY_NORMAL,
        timestamp = os.time(),
        read = 0,
        extra = extra
    }
    
    -- 添加到消息列表
    table.insert(messages, 1, newMsg)
    
    -- 限制消息数量(最多保留100条)
    while #messages > 100 do
        table.remove(messages)
    end
    
    -- 保存消息
    fs.writefile(MSG_STORAGE_PATH, json.stringify(messages))
    
    return msgId
end

--[[
  标记消息为已读
  @param msgId 消息ID(可选，不提供则标记所有消息)
  @return 0=成功, 1=消息不存在
]]
function markAsRead(msgId)
    local json = require("luci.jsonc")
    local fs = require("nixio.fs")
    
    -- 读取消息
    local content = fs.readfile(MSG_STORAGE_PATH)
    if not content or #content == 0 then
        return 1
    end
    
    local messages = json.parse(content)
    if not messages or type(messages) ~= "table" then
        return 1
    end
    
    local found = false
    
    -- 标记消息
    for _, msg in ipairs(messages) do
        if msgId then
            -- 标记指定消息
            if msg.id == msgId then
                msg.read = 1
                found = true
                break
            end
        else
            -- 标记所有消息
            msg.read = 1
            found = true
        end
    end
    
    if not found and msgId then
        return 1
    end
    
    -- 保存消息
    fs.writefile(MSG_STORAGE_PATH, json.stringify(messages))
    
    return 0
end

--[[
  删除消息
  @param msgId 消息ID(可选，不提供则删除所有消息)
  @return 0=成功, 1=消息不存在
]]
function deleteMessage(msgId)
    local json = require("luci.jsonc")
    local fs = require("nixio.fs")
    
    if not msgId then
        -- 删除所有消息
        fs.writefile(MSG_STORAGE_PATH, "[]")
        return 0
    end
    
    -- 读取消息
    local content = fs.readfile(MSG_STORAGE_PATH)
    if not content or #content == 0 then
        return 1
    end
    
    local messages = json.parse(content)
    if not messages or type(messages) ~= "table" then
        return 1
    end
    
    -- 查找并删除消息
    local found = false
    for i, msg in ipairs(messages) do
        if msg.id == msgId then
            table.remove(messages, i)
            found = true
            break
        end
    end
    
    if not found then
        return 1
    end
    
    -- 保存消息
    fs.writefile(MSG_STORAGE_PATH, json.stringify(messages))
    
    return 0
end

--[[
  删除指定类型的所有消息
  @param msgType 消息类型
  @return 删除的消息数量
]]
function deleteByType(msgType)
    local json = require("luci.jsonc")
    local fs = require("nixio.fs")
    
    -- 读取消息
    local content = fs.readfile(MSG_STORAGE_PATH)
    if not content or #content == 0 then
        return 0
    end
    
    local messages = json.parse(content)
    if not messages or type(messages) ~= "table" then
        return 0
    end
    
    -- 过滤消息
    local newMessages = {}
    local deletedCount = 0
    
    for _, msg in ipairs(messages) do
        if msg.type ~= msgType then
            table.insert(newMessages, msg)
        else
            deletedCount = deletedCount + 1
        end
    end
    
    -- 保存消息
    fs.writefile(MSG_STORAGE_PATH, json.stringify(newMessages))
    
    return deletedCount
end

--[[
  获取消息详情
  @param msgId 消息ID
  @return 消息详情
]]
function getMessageDetail(msgId)
    local json = require("luci.jsonc")
    local fs = require("nixio.fs")
    
    if XQFunction.isStrNil(msgId) then
        return nil
    end
    
    -- 读取消息
    local content = fs.readfile(MSG_STORAGE_PATH)
    if not content or #content == 0 then
        return nil
    end
    
    local messages = json.parse(content)
    if not messages or type(messages) ~= "table" then
        return nil
    end
    
    -- 查找消息
    for _, msg in ipairs(messages) do
        if msg.id == msgId then
            return msg
        end
    end
    
    return nil
end

--[[
  发送系统通知
  @param title 通知标题
  @param content 通知内容
  @param priority 优先级
  @return 消息ID
]]
function sendSystemNotification(title, content, priority)
    return addMessage(MSG_TYPE_SYSTEM, title, content, priority)
end

--[[
  发送安全警告
  @param title 警告标题
  @param content 警告内容
  @param extra 额外信息(如攻击来源IP等)
  @return 消息ID
]]
function sendSecurityAlert(title, content, extra)
    return addMessage(MSG_TYPE_SECURITY, title, content, MSG_PRIORITY_HIGH, extra)
end

--[[
  发送设备通知
  @param deviceName 设备名称
  @param action 动作(如"上线"、"下线")
  @param extra 额外信息
  @return 消息ID
]]
function sendDeviceNotification(deviceName, action, extra)
    local title = string.format("设备%s", action)
    local content = string.format("设备 %s %s", deviceName, action)
    return addMessage(MSG_TYPE_DEVICE, title, content, MSG_PRIORITY_NORMAL, extra)
end

--[[
  发送更新通知
  @param version 新版本号
  @param changelog 更新日志
  @return 消息ID
]]
function sendUpdateNotification(version, changelog)
    local title = "系统更新可用"
    local content = string.format("新版本 %s 可用", version)
    local extra = {
        version = version,
        changelog = changelog
    }
    return addMessage(MSG_TYPE_UPDATE, title, content, MSG_PRIORITY_NORMAL, extra)
end

--[[
  清理过期消息
  @param days 保留天数(默认30天)
  @return 清理的消息数量
]]
function cleanExpiredMessages(days)
    local json = require("luci.jsonc")
    local fs = require("nixio.fs")
    
    days = days or 30
    local expireTime = os.time() - (days * 24 * 60 * 60)
    
    -- 读取消息
    local content = fs.readfile(MSG_STORAGE_PATH)
    if not content or #content == 0 then
        return 0
    end
    
    local messages = json.parse(content)
    if not messages or type(messages) ~= "table" then
        return 0
    end
    
    -- 过滤过期消息
    local newMessages = {}
    local cleanedCount = 0
    
    for _, msg in ipairs(messages) do
        if msg.timestamp and msg.timestamp >= expireTime then
            table.insert(newMessages, msg)
        else
            cleanedCount = cleanedCount + 1
        end
    end
    
    -- 保存消息
    fs.writefile(MSG_STORAGE_PATH, json.stringify(newMessages))
    
    return cleanedCount
end
