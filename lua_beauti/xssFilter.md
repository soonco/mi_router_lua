# xssFilter.lua - XSS 过滤器模块

## 工作原理

本模块用于过滤和清理 HTML 内容中的潜在 XSS（跨站脚本攻击）代码，支持白名单标签、属性验证和自定义处理器。

过滤流程：
1. UTF-8 编码验证（如果 iconv 库可用）
2. 将 HTML 解析为 DOM 树
3. 遍历 DOM 树，验证每个标签和属性
4. 不在白名单中的标签使用处理器处理
5. 重新构建安全的 HTML 字符串

安全机制：
- 标签白名单：只允许预定义的安全标签
- 属性验证：检查属性值是否符合安全规则
- 自定义验证函数：支持复杂的安全检查逻辑

## 接口

### 构造函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `new(allowedTags, genericAttrs, tagsHandler)` | allowedTags: 允许的标签配置<br>genericAttrs: 通用属性配置<br>tagsHandler: 标签处理函数 | XSSFilter 实例 | 创建过滤器实例 |

### 实例方法

| 方法 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `filter:filter(htmlContent)` | htmlContent: HTML 内容 | 过滤后的 HTML, 错误信息 | 过滤 HTML 内容 |
| `filter:init(allowedTags, genericAttrs)` | 配置参数 | 无 | 初始化过滤器配置 |

### 预定义处理器

| 函数 | 说明 |
|------|------|
| `REPLACE_TAGS(match, tagName, reason, content)` | 将不允许的标签替换为可见提示 |
| `REMOVE_TAGS(match, tagName, reason, content)` | 移除标签但保留内容 |

### 预定义配置

| 变量 | 说明 |
|------|------|
| `ALLOWED_TAGS` | 允许的 HTML 标签白名单 |
| `EXTRA_TAGS` | 额外允许的标签（特殊处理） |
| `GENERIC_ATTRIBUTES` | 通用属性白名单（class, alt, title） |

## 外部引用

| 模块 | 说明 |
|------|------|
| `iconv` | UTF-8 编码验证（可选） |
