# box.lua.htm - 配置备份后端逻辑

## 文件作用
提供扩展功能配置的备份和恢复功能，支持单个或批量备份/恢复操作。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.http` | HTTP 请求处理 |
| `luci.sys` | 系统命令执行 |

### 系统命令
| 命令 | 说明 |
|------|------|
| `mkdir` | 创建备份目录 |
| `cp` | 复制文件 |
| `tar` | 打包/解包文件 |
| `uci get` | 读取 UCI 配置 |

## 页面原理

### 工具函数
- **base64_dec()**: Base64 解码函数
- **urlDecode()**: URL 解码函数

### 支持的操作

#### 配置备份 (mac=conf_bak 或 conf_bak_all)
1. 解码文件名参数
2. 如果是 `xxxconf`，复制 xxx.json 到备份目录
3. 其他配置使用 tar 打包多个路径

#### 配置恢复 (mac=conf_rec 或 conf_rec_all)
1. 解码文件名参数
2. 如果是 `xxxconf`，从备份恢复 xxx.json
3. 其他配置使用 tar 解包到根目录

### 备份路径
- 备份目录: `/mnt/sda/mi_bak/`
- 备份文件扩展名: `.xxxbak`

### 备份范围
```bash
$(uci get lyq.xxx_path)/xxxbox/{name}
/tmp/xxxbox_tmp/{name}
/mnt/sda/mi_box/{name}.tar
/mnt/mtd/box/{name}.tar
```

## 依赖关系
- UCI 配置 `lyq.xxx_path`
- 外部存储设备 `/mnt/sda/`

## 安全说明
备份文件存储在外部存储设备上，请确保存储设备已正确挂载。
