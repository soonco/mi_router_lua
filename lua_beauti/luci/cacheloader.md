# cacheloader.lua - 缓存加载器模块

## 工作原理

LuCI 缓存加载器模块，根据配置决定是否启用字节码缓存机制。

工作流程：
1. 加载 LuCI 配置模块
2. 检查 `ccache.enable` 配置项
3. 如果启用，调用 `ccache.cache_ondemand()` 启动按需缓存

按需缓存机制：
- 模块首次加载时自动编译为字节码
- 缓存编译后的字节码到文件系统
- 后续加载直接使用缓存的字节码，提高加载速度

## 接口

### 模块行为

| 配置项 | 值 | 行为 |
|--------|-----|------|
| `config.ccache.enable` | "1" | 启用按需缓存 |
| `config.ccache.enable` | 其他 | 不启用缓存 |

### 配置示例

```
# /etc/config/luci
config core 'ccache'
    option enable '1'
```

## 外部引用

| 模块 | 用途 |
|------|------|
| `luci.config` | 读取 LuCI 配置 |
| `luci.ccache` | 字节码缓存实现 |
