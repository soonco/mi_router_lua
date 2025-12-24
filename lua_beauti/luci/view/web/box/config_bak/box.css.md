# box.css.htm - 配置备份样式

## 文件作用
定义配置备份功能界面的 CSS 样式。

## 样式规则

### 容器样式
```css
#config_bak_box {}
```
配置备份功能的主容器，当前为空样式。

### 标题样式
```css
[id="config_bak_box"] p {
    text-align: left;
    font-size: large;
    position: absolute;
    font-size: 50px;
    margin-left: 50px;
    color: #2673bf;
}
```

| 属性 | 值 | 说明 |
|------|-----|------|
| text-align | left | 左对齐 |
| font-size | 50px | 大号字体 |
| position | absolute | 绝对定位 |
| margin-left | 50px | 左边距 |
| color | #2673bf | 蓝色文字 |

## 页面原理
使用属性选择器 `[id="config_bak_box"]` 来选择元素，这种方式与 `#config_bak_box` 效果相同，但优先级较低。

## 依赖关系
- 基础样式 `bc.css`
- 被 `box.htm.htm` 引用
