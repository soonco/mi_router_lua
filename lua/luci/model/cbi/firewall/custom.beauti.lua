--[[
    防火墙自定义规则编辑器
    
    功能说明:
    - 提供自定义iptables规则的编辑界面
    - 规则存储在 /etc/firewall.user 文件中
    - 在系统防火墙启动时自动加载执行
    - 适用于高级用户添加复杂的防火墙规则
    
    使用场景:
    - 添加Web界面不支持的高级规则
    - 自定义NAT规则
    - 特殊的流量控制规则
    - 端口敲门(Port Knocking)等高级功能
    
    安全提示:
    - 错误的规则可能导致网络中断
    - 修改前请备份现有规则
    - 建议通过SSH保持连接以便恢复
    
    配置文件: /etc/firewall.user
]]

local fileSystem = require("nixio.fs")

-- 自定义规则文件路径
local CUSTOM_RULES_FILE = "/etc/firewall.user"

-- ============================================================
-- 创建简单表单 (SimpleForm)
-- ============================================================
-- SimpleForm不绑定UCI配置，直接操作文件

local customRulesForm = SimpleForm(
    "firewall",
    translate("Custom Rules"),
    translate(
        "Custom rules allow you to execute arbitrary iptables commands " ..
        "which are not otherwise covered by the firewall framework. " ..
        "The commands are executed after each firewall restart, right after " ..
        "the default ruleset has been loaded."
    )
)

-- 禁用表单重置按钮
customRulesForm.reset = false

-- 提交按钮文字
customRulesForm.submit = translate("Save")

-- ============================================================
-- 规则编辑区域 (TextArea)
-- ============================================================

local rulesTextArea = customRulesForm:field(
    TextValue,
    "rules"
)

-- 隐藏标签
rulesTextArea.rmempty = true

-- 设置文本框行数
rulesTextArea.rows = 20

-- 读取当前规则文件内容
function rulesTextArea.cfgvalue(self, section)
    -- 从文件读取现有规则
    return fileSystem.readfile(CUSTOM_RULES_FILE) or ""
end

-- 保存规则到文件
function rulesTextArea.write(self, section, value)
    -- 规范化换行符并写入文件
    if value then
        -- 将Windows换行符(\r\n)转换为Unix换行符(\n)
        value = value:gsub("\r\n?", "\n")
        fileSystem.writefile(CUSTOM_RULES_FILE, value)
    end
end

return customRulesForm
