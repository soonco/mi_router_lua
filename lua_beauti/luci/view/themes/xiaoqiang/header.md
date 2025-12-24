# header.htm - 小米路由器主题页头

## 文件作用
小米路由器主题的页头模板，提供基础的 XHTML 文档声明。

## 页面原理

### 文档结构
```xml
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" ...>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="..." lang="...">
```

### 语言设置
使用 `luci.i18n.context.lang` 动态设置页面语言属性，支持多语言界面。

## 依赖关系
- 属于 `themes/xiaoqiang` 主题的一部分
- 需要配合 `footer.htm` 使用

## 与 OpenWrt 主题的区别
小米路由器主题的 header 非常简洁，仅包含文档声明，实际的页面结构和导航由以下文件提供：
- `web/inc/head.htm` - HTML head 部分
- `web/inc/header.htm` - 页面头部导航
- 各功能页面自行引入所需组件

## 备注
这种设计使得小米路由器的 Web 界面更加灵活，不同页面可以有不同的布局结构。
