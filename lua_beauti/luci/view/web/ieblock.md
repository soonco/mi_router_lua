# ieblock.htm - IE6浏览器拦截页面

## 文件作用
当用户使用 IE6 内核浏览器访问时显示此页面，提示用户升级浏览器。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `xiaoqiang.XQVersion` | 获取 Web 版本号 |

## 页面原理

### 浏览器检测
使用 IE 条件注释检测浏览器版本：
```html
<!--[if lt IE 7]><html class="ie6 oldie" lang="zh"><![endif]-->
<!--[if IE 7]><html class="ie7 oldie" lang="zh"><![endif]-->
<!--[if IE 8]><html class="ie8 oldie" lang="zh"><![endif]-->
<!--[if gt IE 8]><!--> <html lang="zh"> <!--<![endif]-->
```

### 页面内容
1. **警告图标** - 显示警告提示
2. **错误说明** - 告知用户不支持 IE6
3. **解决方案** - 提供浏览器升级链接
   - Microsoft IE 最新版
   - Chrome 浏览器
   - Firefox 浏览器

## 依赖关系
- `web/css/bc.css` - 基础样式
- `diagnosis/css/neterr.css` - 错误页样式

## 设计说明
此页面采用简洁设计，确保在 IE6 下也能正常显示基本内容，引导用户升级到现代浏览器。
