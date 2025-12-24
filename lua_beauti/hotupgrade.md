# hotupgrade.lua - 热升级模块

## 工作原理

本模块提供路由器固件热升级功能，支持增量补丁下载和应用，无需完整刷机即可更新系统组件。

升级流程：
1. 检查补丁是否已应用（调用 `hotupgrade.sh check`）
2. 如果未应用，下载补丁文件并验证哈希值
3. 执行补丁应用（调用 `hotupgrade.sh`）
4. 清理临时文件

日志记录：
- 使用 syslog 记录热升级过程中的关键信息
- 日志级别为 WARNING (4)

## 接口

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `hotupgrade_log(...)` | 可变参数 | 无 | 记录热升级日志到 syslog |
| `hotupgrade_download(url, expected_hash)` | url: 下载地址<br>expected_hash: 期望的哈希值 | 本地文件路径或 nil | 下载并验证补丁文件 |
| `hotupgrade_upgrade(upgrade_list)` | upgrade_list: 升级任务列表 | 无 | 执行热升级流程 |

### 升级任务结构

```lua
{
    hotupgradeName = "补丁名称",
    link = "下载链接",
    hash = "文件哈希值"
}
```

## 外部引用

| 模块 | 说明 |
|------|------|
| `luci.fs` | 文件系统操作 |
| `luci.util` | 工具函数 |
| `json` | JSON 编解码 |
| `posix` | POSIX 系统调用（syslog） |
| `xiaoqiang.util.XQDownloadUtil` | 下载工具 |
| `xiaoqiang.common.XQFunction` | 通用函数（waitExec） |
