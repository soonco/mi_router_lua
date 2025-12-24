## 任务概述
为 `/Users/soonco/fsdownload/Luci/lua_beauti` 目录中所有没有对应 `.md` 文件的 `.lua` 文件生成 Markdown 文档，包含工作原理、接口、外部引用。

## 需要处理的文件清单

根据分析，以下 **约 100 个 Lua 文件** 缺少对应的 `.md` 文档：

### 1. 根目录文件 (19个)
- `cURL.lua`, `checks.lua`, `slaxdom.lua`, `aeslua.lua`, `hotupgrade.lua`
- `xssFilter.lua`, `mime.lua`, `ssl.lua`, `socket.lua`, `logging.lua`
- `bit.lua`, `rc4.lua`, `posix.lua`, `slaxml.lua`, `ltn12.lua`
- `traffic.lua`, `sha1.lua`, `json.lua`, `miqos.lua`

### 2. aeslua/ 子目录 (5个)
- `aes.lua`, `buffer.lua`, `ciphermode.lua`, `gf.lua`, `util.lua`

### 3. cURL/ 子目录 (3个)
- `safe.lua`, `utils.lua`, `impl/cURL.lua`

### 4. config_scan/ 子目录 (12个)
- `DMZ.lua`, `UPnP.lua`, `anti_squatter.lua`, `common.lua`, `main_scanner.lua`
- `newest_rom.lua`, `port_mapping.lua`, `rom_auto_updating.lua`, `system.lua`
- `wifi_encryption.lua`, `wifi_passwd_security.lua`, `wireless.lua`

### 5. json/ 子目录 (1个)
- `rpc.lua`

### 6. logging/ 子目录 (6个)
- `console.lua`, `email.lua`, `file.lua`, `rolling_file.lua`, `socket.lua`, `sql.lua`

### 7. miqos/ 子目录 (7个)
- `command.lua`, `common.lua`, `rule_by_host.lua`, `rule_by_noifb.lua`
- `rule_by_prio.lua`, `rule_by_service.lua`, `rule_by_wangzhe.lua`

### 8. nixio/ 子目录 (2个)
- `fs.lua`, `util.lua`

### 9. sec_center/ 子目录 (4个)
- `config_scanner.lua`, `content_filter.lua`, `gateway_security.lua`, `log.lua`

### 10. service/util/ 子目录 (1个)
- `ServiceErrorUtil.lua`

### 11. socket/ 子目录 (6个)
- `ftp.lua`, `headers.lua`, `http.lua`, `smtp.lua`, `tp.lua`, `url.lua`

### 12. ssl/ 子目录 (1个)
- `https.lua`

### 13. luci/ 子目录 (约 40+ 个)
- `cacheloader.lua`, `debug.lua`, `verk.lua`, `version.lua`
- `cbi/datatypes.lua`
- `controller/` 下多个文件
- `http/protocol/` 下文件
- `model/` 下多个文件
- `sgi/cgi.lua`
- `sys/` 下文件
- `tools/` 下文件

### 14. xiaoqiang/module/ (1个)
- `XQAPModule.lua`

## 执行计划

1. **批量读取并分析每个 Lua 文件**
   - 识别模块功能和工作原理
   - 提取导出的函数/接口
   - 记录外部依赖 (require 语句)

2. **生成 Markdown 文档**
   - 文件名格式：`原文件名.md` (如 `cURL.lua` → `cURL.lua.md`)
   - 文档结构：
     ```markdown
     # 文件名 - 模块描述
     
     ## 工作原理
     描述模块的主要功能和工作机制
     
     ## 接口/导出函数
     列出所有公开的函数及其参数说明
     
     ## 外部引用
     列出所有 require 的依赖模块
     ```

3. **如遇到美化文件内容不完整，参考 `/Users/soonco/fsdownload/Luci/lua_decode` 目录的对应文件**

## 预计工作量
- 约 100 个文件需要处理
- 每个文件需要阅读、分析、生成文档
- 将按目录分批处理以提高效率

是否确认开始执行此计划？