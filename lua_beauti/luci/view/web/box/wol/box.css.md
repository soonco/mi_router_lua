# box.css.htm - 网络唤醒样式

## 文件作用
定义 Wake-on-LAN 网络唤醒功能界面的 CSS 样式。

## 样式规则

### 容器样式
```css
#wol_box {}
```
WOL 功能的主容器，当前为空样式。

### 段落样式
```css
[id="wol_box"] p {
    text-align: left;
    font-size: large;
    margin-left: 12px;
}
```

| 属性 | 值 | 说明 |
|------|-----|------|
| text-align | left | 左对齐 |
| font-size | large | 大号字体 |
| margin-left | 12px | 左边距 |

## 页面原理
使用简洁的样式定义，主要依赖基础样式 `bc.css` 提供的通用样式。配置编辑区的文本框样式在 HTML 中内联定义。

## 依赖关系
- 基础样式 `bc.css`
- 被 `box.htm.htm` 引用
