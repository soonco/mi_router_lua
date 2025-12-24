--[[
    LuCI HTTP 日期处理模块
    用于处理 HTTP 协议中的日期格式转换和比较
    
    主要功能:
    - 时区偏移计算
    - HTTP 日期格式与 Unix 时间戳互转
    - 日期比较
]]

module("luci.http.protocol.date", package.seeall)

require("luci.sys.zoneinfo")

-- 月份名称数组（英文缩写）
MONTHS = {
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
}

--[[
    计算时区偏移量（秒）
    @param timezone 时区字符串，如 "+0800"、"-0500" 或时区名称如 "pst"
    @return 时区偏移秒数，无效输入返回 0
]]
function tz_offset(timezone)
    if type(timezone) == "string" then
        -- 尝试解析数字格式的时区偏移，如 "+0800"
        local sign, offset_value = timezone:match("([%+%-])([0-9]+)")
        
        -- 确定正负号
        local multiplier
        if sign == "+" then
            multiplier = 1
        else
            multiplier = -1
        end
        
        -- 转换偏移值
        if offset_value then
            offset_value = tonumber(offset_value)
        end
        
        -- 计算秒数偏移
        if multiplier and offset_value then
            local hours = math.floor(offset_value / 100)
            local minutes = offset_value % 100
            local total_minutes = hours * 60 + minutes
            return multiplier * 60 * total_minutes
        else
            -- 尝试从时区信息表中查找
            local tz_lower = timezone:lower()
            local tz_data = luci.sys.zoneinfo.OFFSET[tz_lower]
            if tz_data then
                return luci.sys.zoneinfo.OFFSET[tz_lower]
            end
        end
    end
    
    return 0
end

--[[
    将 HTTP 日期格式转换为 Unix 时间戳
    HTTP 日期格式示例: "Mon, 01 Jan 2024 12:00:00 GMT"
    
    @param http_date HTTP 格式的日期字符串
    @return Unix 时间戳，解析失败返回 0
]]
function to_unix(http_date)
    -- 解析 HTTP 日期格式
    -- 格式: "Day, DD Mon YYYY HH:MM:SS TZ"
    local pattern = "([A-Z][a-z][a-z]), ([0-9]+) " ..
                   "([A-Z][a-z][a-z]) ([0-9]+) " ..
                   "([0-9]+):([0-9]+):([0-9]+) " ..
                   "([A-Z0-9%+%-]+)"
    
    local weekday, day, month_name, year, hour, minute, second, timezone = 
        http_date:match(pattern)
    
    if day and month_name and year and hour and minute and second then
        -- 查找月份索引
        local month_index = 1
        for i = 1, 12 do
            if MONTHS[i] == month_name then
                month_index = i
                break
            end
        end
        
        -- 构建时间表
        local time_table = {
            year = year,
            month = month_index,
            day = day,
            hour = hour,
            min = minute,
            sec = second
        }
        
        -- 转换为 Unix 时间戳并应用时区偏移
        local timestamp = os.time(time_table)
        local tz_off = tz_offset(timezone)
        return timestamp - tz_off
    end
    
    return 0
end

--[[
    将 Unix 时间戳转换为 HTTP 日期格式
    
    @param timestamp Unix 时间戳
    @return HTTP 格式的日期字符串，如 "Mon, 01 Jan 2024 12:00:00 GMT"
]]
function to_http(timestamp)
    return os.date("%a, %d %b %Y %H:%M:%S GMT", timestamp)
end

--[[
    比较两个日期
    支持 Unix 时间戳或 HTTP 日期格式字符串
    
    @param date1 第一个日期
    @param date2 第二个日期
    @return 0 表示相等，-1 表示 date1 < date2，1 表示 date1 > date2
]]
function compare(date1, date2)
    -- 如果是字符串格式（包含非数字字符），转换为 Unix 时间戳
    if date1:match("[^0-9]") then
        date1 = to_unix(date1)
    end
    
    if date2:match("[^0-9]") then
        date2 = to_unix(date2)
    end
    
    -- 比较时间戳
    if date1 == date2 then
        return 0
    elseif date1 < date2 then
        return -1
    else
        return 1
    end
end
