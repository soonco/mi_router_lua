# head.htm - HTML文档头部模板

## 文件作用
提供所有页面的 HTML 文档头部，包含 DOCTYPE 声明、IE 兼容性处理和基础 meta 标签。

## 页面原理

### IE 兼容性处理
```html
<!--[if lt IE 7]><html class="ie6 oldie" lang="zh"><![endif]-->
<!--[if IE 7]><html class="ie7 oldie" lang="zh"><![endif]-->
<!--[if IE 8]><html class="ie8 oldie" lang="zh"><![endif]-->
<!--[if gt IE 8]><!--> <html lang="zh"> <!--<![endif]-->
```
使用条件注释为不同版本 IE 添加特定 class，便于 CSS 针对性处理。

### IE6 重定向
```html
<!--[if lt IE 7]>
<meta http-equiv="refresh" content="0; url=http://miwifi.com/cgi-bin/luci/web/ieblock" />
<![endif]-->
```
IE6 及以下版本自动重定向到不支持提示页面。

### Meta 标签
| 标签 | 说明 |
|------|------|
| X-UA-Compatible | 使用最新渲染引擎 |
| Content-Type | UTF-8 编码 |
| renderer | webkit 渲染（国产浏览器） |

## 依赖关系
- 被所有页面通过 `<%include("web/inc/head")%>` 引入
- 需要配合 `</head>` 和 `<body>` 标签使用

## 注意事项
此文件只包含 `<head>` 的开始部分，不包含结束标签。
