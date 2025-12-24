## 任务概述

为 `/Users/soonco/fsdownload/Luci/lua_beauti/luci/view` 目录下的 **159 个 .htm 文件** 生成对应的 markdown 说明文件。

## 文件分类

根据分析，这些文件可分为以下几类：

| 类型 | 数量 | 说明 |
|------|------|------|
| 页面模板 (.htm) | ~80 | 完整页面，包含 HTML 结构和 Lua 逻辑 |
| JavaScript 模板 (.js.htm) | ~20 | 嵌入式 JavaScript 代码 |
| CSS 模板 (.css.htm) | ~8 | 嵌入式样式代码 |
| Lua 后端逻辑 (.lua.htm) | ~10 | 服务端处理逻辑 |
| HTML 片段 (.htm.htm) | ~8 | HTML 模板片段 |

## 说明文件内容结构

每个 `.md` 文件将包含：

```markdown
# 文件名 - 功能简述

## 文件作用
描述该文件的主要功能和用途

## 使用的 API
- 列出调用的 Lua 模块和 API
- 列出调用的后端接口

## 页面原理
- 页面加载流程
- 数据获取方式
- 用户交互逻辑

## 依赖关系
- 引入的其他模板文件
- 依赖的 CSS/JS 资源

## 关键代码说明
重要代码段的解释
```

## 执行计划

1. **批量处理** - 按目录分批处理文件
   - 根目录文件 (10个)
   - diagnosis/ (1个)
   - firewall/ (3个)
   - mipctl/ (1个)
   - themes/ (4个)
   - url_fw/ (1个)
   - web/ 主目录 (约15个)
   - web/apsetting/ (6个)
   - web/box/ 各子目录 (约32个)
   - web/inc/ (约55个)
   - web/init/ (7个)
   - web/setting/ (18个)
   - web/wan2/ (5个)

2. **生成位置** - 每个 `.md` 文件与原 `.htm` 文件同目录
   - 例如：`index.htm` → `index.htm.md`

3. **自动化处理** - 读取每个文件内容，分析后生成说明文档

## 预计输出

共生成 **159 个** markdown 说明文件，覆盖所有 .htm 文件。