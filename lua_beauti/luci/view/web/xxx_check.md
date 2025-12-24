# xxx_check.htm - 消息提示组件

## 文件作用
提供全局消息提示功能的 CSS 样式和 JavaScript 实现，用于在页面顶部显示临时通知消息。

## 组件功能

### 消息类型
默认提供通用消息样式，可扩展支持：
- 成功消息
- 警告消息
- 错误消息
- 信息提示

### 动画效果
- **进入动画**: `messageFadeInDown` - 从上方滑入
- **退出动画**: `messageFadeOutUp` - 向上滑出淡出

## 使用方法

### 基本调用
```javascript
$.message("提示内容");
```

### 完整配置
```javascript
$.message({
    type: "default",      // 消息类型
    content: "提示内容",   // 消息文本
    time: 2000,           // 显示时长(ms)
    autoClose: true,      // 自动关闭
    onClose: function(){} // 关闭回调
});
```

## 样式说明

### 消息容器
```css
.YiJia_message {
    position: fixed;
    top: 30px;
    left: 50%;
    z-index: 99999999;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.12);
}
```

### 自适应定位
如果页面存在 `.header_tps` 元素，消息位置自动调整到 90px。

## 依赖关系
- jQuery 库
- 需要在页面中引入此文件

## 特性
- 同一时间只显示一条消息
- 新消息会替换旧消息
- 支持自定义显示时长
- 支持关闭回调函数
