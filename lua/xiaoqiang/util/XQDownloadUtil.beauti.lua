--[[
  下载工具模块 (XQDownloadUtil)
  提供固件下载、CPE固件下载、下载进度查询等功能
  主要用于OTA升级和固件更新
]]--

module("xiaoqiang.util.XQDownloadUtil", package.seeall)

local XQFunction = require("xiaoqiang.common.XQFunction")
local XQConfigs = require("xiaoqiang.common.XQConfigs")
local XQPreference = require("xiaoqiang.XQPreference")
local nixio = require("nixio.fs")
local LuciFs = require("luci.fs")
local LuciUtil = require("luci.util")
local XQLog = require("xiaoqiang.XQLog")
local XQCryptoUtil = require("xiaoqiang.util.XQCryptoUtil")

local DOWNLOAD_TIMEOUT = tostring(LuciUtil.trim(LuciUtil.exec("uci -q get misc.ota_pred.download_time")))
local ROM_DOWNLOAD_PATH = "/tmp/rom.bin"
local DOWNLOAD_FILE_PATH = "DOWNLOAD_FILE_PATH"
local CURL_CMD = "curl"

local XQSysUtil = require("xiaoqiang.util.XQSysUtil")

local CPE_MODEM_LENGTH_FILE = XQConfigs.CPE_MODEM_LENGTH_FILE
local CPE_HEADER_CACHE_FILEPATH = XQConfigs.CPE_HEADER_CACHE_FILEPATH
local CPE_MODEM_CACHE_FILEPATH = XQConfigs.CPE_MODEM_CACHE_FILEPATH
local CPE_SIGN_CACHE_FILEPATH = XQConfigs.CPE_SIGN_CACHE_FILEPATH
local CPE_HEADER_LENGTH = XQConfigs.CPE_HEADER_LENGTH
local CPE_SIGN_LENGTH = XQConfigs.CPE_SIGN_LENGTH
local MODEM_SLICE_PATH = "/tmp/modemSlice.bin"

CPE_FIRMWARE_INFO = {
    [1] = { size = CPE_HEADER_LENGTH, path = CPE_HEADER_CACHE_FILEPATH },
    [2] = { size = 0, path = CPE_MODEM_CACHE_FILEPATH },
    [3] = { size = CPE_SIGN_LENGTH, path = CPE_SIGN_CACHE_FILEPATH },
    [4] = { size = 0, path = ROM_DOWNLOAD_PATH }
}

if XQFunction.isStrNil(DOWNLOAD_TIMEOUT) then
    DOWNLOAD_TIMEOUT = "30"
end

local CURL_DOWNLOAD_CMD = CURL_CMD .. " --retry 3 -m " .. DOWNLOAD_TIMEOUT .. " -s -f -o %s %s"
local CURL_CHECK_CMD = CURL_CMD .. " --retry 3 -m 10 -s -f -I -o /dev/null %s"
local CURL_RANGE_CMD = CURL_CMD .. " --range %d-%d --retry 3 -m " .. DOWNLOAD_TIMEOUT .. " -s -f -o %s %s"

--[[
  检查URL资源是否存在
  @param url 资源URL
  @return 是否存在
]]--
local function checkResourceExists(url)
    if XQFunction.isStrNil(url) then
        return false
    end
    
    local result = os.execute(string.format(CURL_CHECK_CMD, url))
    return result == 0
end

--[[
  从CPE固件文件中获取Modem长度
  @param url 固件URL
  @return Modem长度（字节），失败返回false
]]--
local function getCpeModemLengthFromUrl(url)
    if XQFunction.isStrNil(url) then
        return false
    end
    
    local tempFile = CPE_MODEM_LENGTH_FILE
    
    if nixio.access(tempFile) then
        nixio.unlink(tempFile)
    end
    
    LuciUtil.exec(string.format(CURL_RANGE_CMD, 4, 7, tempFile, url))
    
    local file = io.open(tempFile, "r")
    if file then
        local data = file:read()
        local hexStr = string.format("%02x%02x%02x%02x",
            data:byte(4),
            data:byte(3),
            data:byte(2),
            data:byte(1)
        )
        
        XQLog.log(6, "get cpe modem length success" .. hexStr)
        return tonumber(hexStr, 16)
    else
        XQLog.log(6, "get cpe modem length false")
        return false
    end
end

--[[
  从本地文件获取CPE Modem长度
  @return Modem长度（字节）
]]--
function getCpeModemLengthFromFile()
    local file = io.open(CPE_MODEM_LENGTH_FILE, "r")
    if file then
        local data = file:read()
        local hexStr = string.format("%02x%02x%02x%02x",
            data:byte(4),
            data:byte(3),
            data:byte(2),
            data:byte(1)
        )
        return tonumber(hexStr, 16)
    end
    return 0
end

--[[
  下载固件分片并写入存储
  @param url 下载URL
  @param startOffset 起始偏移
  @param endOffset 结束偏移
  @param destPath 目标路径（可以是文件或MTD分区）
  @return 是否成功
]]--
local function downloadAndWriteSlice(url, startOffset, endOffset, destPath)
    local sliceSize = XQConfigs.CPE_UPLOAD_CPE_ROM_SLICE_SIZE
    
    if XQFunction.isStrNil(url) then
        return false
    end
    
    if not string.find(destPath, "mtd") then
        if nixio.access(destPath) then
            nixio.unlink(destPath)
        end
        
        LuciUtil.exec(string.format(CURL_RANGE_CMD, startOffset, endOffset, destPath, url))
        return true
    else
        LuciUtil.exec(string.format("mtd erase %s >/dev/null 2>/dev/null", destPath))
        
        local remainingSize = endOffset - startOffset + 1
        local writeOffset = 0
        
        while remainingSize > 0 do
            if nixio.access(MODEM_SLICE_PATH) then
                nixio.unlink(MODEM_SLICE_PATH)
            end
            
            local downloadSize = (sliceSize < remainingSize) and sliceSize or remainingSize
            
            LuciUtil.exec(string.format(CURL_RANGE_CMD, 
                startOffset, 
                startOffset + downloadSize - 1, 
                MODEM_SLICE_PATH, 
                url
            ))
            
            startOffset = startOffset + downloadSize
            remainingSize = remainingSize - downloadSize
            
            LuciUtil.exec(string.format("nandwrite -p -s %d %s %s", 
                writeOffset, 
                destPath, 
                MODEM_SLICE_PATH
            ))
            
            writeOffset = writeOffset + downloadSize
        end
        
        if nixio.access(MODEM_SLICE_PATH) then
            nixio.unlink(MODEM_SLICE_PATH)
        end
        
        return true
    end
end

--[[
  验证URL格式是否合法
  @param url URL字符串
  @return 是否合法
]]--
local function isValidUrl(url)
    if XQFunction.isStrNil(url) then
        return false
    end
    
    if string.find(url, "[^%w:/?&%%.=#_-]") then
        return false
    end
    
    return true
end

--[[
  执行实际的下载操作
  @param url 下载URL
  @return MD5值, 文件路径
]]--
local function doDownload(url)
    if not checkResourceExists(url) then
        XQLog.log(6, "resource not exist: " .. url)
        return false
    end
    
    local downloadPath = ROM_DOWNLOAD_PATH
    XQPreference.set(DOWNLOAD_FILE_PATH, downloadPath)
    
    if nixio.access(downloadPath) then
        nixio.unlink(downloadPath)
    end
    
    LuciUtil.exec(string.format(CURL_DOWNLOAD_CMD, downloadPath, url))
    
    local md5 = XQCryptoUtil.md5File(downloadPath)
    return md5, downloadPath
end

--[[
  检查是否有足够的临时空间
  @return 是否有足够空间
]]--
local function checkTmpSpace()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local downloadPath = XQPreference.get(XQConfigs.PREF_ROM_FULLSIZE, nil)
    
    if downloadPath then
        local fileSize = tonumber(downloadPath)
        if XQSysUtil.checkTmpSpace(fileSize) then
            return true
        end
    end
    
    return false
end

--[[
  同步下载CPE固件
  @param url 固件URL
  @return 是否成功, 文件路径
]]--
function syncDownloadForCpe(url)
    if not isValidUrl(url) then
        XQLog.log(6, "download url invalid")
        return false
    end
    
    local fullSize = XQPreference.get(XQConfigs.PREF_ROM_FULLSIZE, nil)
    local success = nil
    
    local modemLength = getCpeModemLengthFromUrl(url)
    local romStartOffset = modemLength - CPE_SIGN_LENGTH
    
    if romStartOffset < 0 then
        XQLog.log(6, "invalid modem length")
        return false
    end
    
    local currentOffset = 0
    
    CPE_FIRMWARE_INFO[4].size = romStartOffset
    CPE_FIRMWARE_INFO[2].size = modemLength
    
    for _, info in ipairs(CPE_FIRMWARE_INFO) do
        if info and info.size and info.path then
            success = downloadAndWriteSlice(url, currentOffset, currentOffset + info.size - 1, info.path)
            
            if not success then
                XQLog.log(6, "download full cpe firmware failed ")
                return false
            end
            
            currentOffset = currentOffset + info.size
        end
    end
    
    return success, ROM_DOWNLOAD_PATH
end

--[[
  同步下载固件
  @param url 固件URL
  @return MD5值, 文件路径
]]--
function syncDownload(url)
    if not isValidUrl(url) then
        XQLog.log(6, "download url invalid")
        return false
    end
    
    if not checkTmpSpace() then
        XQLog.log(6, "download space not enough")
        return false
    end
    
    local md5, filePath = doDownload(url)
    
    if md5 then
        XQLog.log(6, "download finished")
        return md5, filePath
    end
    
    XQLog.log(6, "download failed")
    return false
end

local CURL_GET_SIZE_CMD = "set -o pipefail; " .. CURL_CMD .. 
    " --retry 3 -m 10 -s -f -I -X GET \"$url\" | awk 'BEGIN{IGNORECASE = 1}/^content-length:/{print $2}'"
local CURL_DOWNLOAD_V2_CMD = CURL_CMD .. " --retry 3 -m " .. DOWNLOAD_TIMEOUT .. " -s -f -o \"$dest\" \"$url\""

--[[
  检查V2版本下载空间
  @return 是否有足够空间
]]--
local function checkTmpSpaceV2()
    local XQSysUtil = require("xiaoqiang.util.XQSysUtil")
    local exitCode, output, fileSize = XQFunction.waitExec("/bin/sh", "-c", CURL_GET_SIZE_CMD)
    
    fileSize = tonumber(fileSize)
    
    if exitCode == 0 and fileSize then
        return XQSysUtil.checkTmpSpace(fileSize)
    end
    
    return false
end

--[[
  执行V2版本下载
  @param url 下载URL
  @return MD5值, 文件路径
]]--
local function doDownloadV2(url)
    local downloadPath = ROM_DOWNLOAD_PATH
    
    if nixio.access(downloadPath) then
        nixio.unlink(downloadPath)
    end
    
    nixio.setenv("dest", downloadPath)
    LuciUtil.exec(CURL_DOWNLOAD_V2_CMD)
    
    local md5 = XQCryptoUtil.md5File(downloadPath)
    return md5, downloadPath
end

--[[
  同步下载V2版本（改进版）
  @param url 固件URL
  @return MD5值, 文件路径
]]--
function syncDownloadV2(url)
    if not isValidUrl(url) then
        XQLog.log(6, "download url invalid")
        return false
    end
    
    local nixio = require("nixio")
    nixio.setenv("url", url)
    
    if not checkTmpSpaceV2() then
        XQLog.log(6, "download space not enough")
        return false
    end
    
    local md5, filePath = doDownloadV2(url)
    
    if md5 then
        XQLog.log(6, "download finished")
        return md5, filePath
    end
    
    XQLog.log(6, "download failed")
    return false
end

--[[
  获取CPE固件下载进度百分比
  @return 下载进度百分比 (1-100)
]]--
function downloadPercentForCpe()
    local downloadPath = XQPreference.get(DOWNLOAD_FILE_PATH, nil)
    local fullSize = tonumber(XQPreference.get(XQConfigs.PREF_ROM_FULLSIZE, nil))
    
    local percent = 0
    local downloadedSize = 0
    local sliceNum = 0
    
    if downloadPath and fullSize and fullSize > 0 then
        if nixio.access(downloadPath) then
            local fileSize = math.modf(nixio.stat(downloadPath).size)
            local modemLength = getCpeModemLengthFromFile()
            downloadedSize = fileSize + modemLength + CPE_HEADER_LENGTH + CPE_SIGN_LENGTH
            percent = math.modf(downloadedSize / fullSize * 100)
        elseif nixio.access(CPE_SIGN_CACHE_FILEPATH) then
            local modemLength = getCpeModemLengthFromFile()
            downloadedSize = modemLength + CPE_HEADER_LENGTH + CPE_SIGN_LENGTH
            percent = math.modf(downloadedSize / fullSize * 100)
        elseif nixio.access(CPE_MODEM_CACHE_FILEPATH) then
            sliceNum = tonumber(LuciUtil.trim(LuciUtil.exec("find /tmp -name modemSlice*|sed 's/[^0-9]//g'")))
            
            if sliceNum and sliceNum > 0 then
                downloadedSize = sliceNum + CPE_HEADER_LENGTH
                percent = math.modf(downloadedSize / fullSize * 100)
            end
        end
    end
    
    if percent < 1 then
        percent = 1
    elseif percent > 100 then
        percent = 100
    end
    
    return percent
end

--[[
  获取普通固件下载进度百分比
  @return 下载进度百分比 (0-100)
]]--
function downloadPercent()
    local downloadPath = XQPreference.get(DOWNLOAD_FILE_PATH, nil)
    local fullSize = tonumber(XQPreference.get(XQConfigs.PREF_ROM_FULLSIZE, nil))
    
    local percent = 0
    local downloadedSize = 0
    
    if downloadPath and fullSize and fullSize > 0 then
        if nixio.access(downloadPath) then
            downloadedSize = math.modf(nixio.stat(downloadPath).size)
            percent = math.modf(downloadedSize / fullSize * 100)
            
            if percent < 1 then
                percent = 1
            elseif percent > 100 then
                percent = 100
            end
        end
    end
    
    return percent
end

--[[
  取消下载任务
  @return 是否成功
]]--
function cancelDownload()
    local downloadPath = XQPreference.get(DOWNLOAD_FILE_PATH, nil)
    
    local processCmd = "pgrep -l -f " .. CURL_CMD .. 
        "|grep -E '^[0-9]+ " .. 
        string.format(CURL_DOWNLOAD_CMD, downloadPath, "") .. 
        "'|awk '{print $1}'"
    
    local pid = LuciUtil.exec(processCmd)
    
    if pid then
        XQLog.log(6, "kill process " .. LuciUtil.trim(pid) .. " to cancel download")
        os.execute("kill " .. LuciUtil.trim(pid))
    end
    
    if downloadPath then
        if nixio.access(downloadPath) then
            nixio.unlink(downloadPath)
        end
    end
    
    return true
end
