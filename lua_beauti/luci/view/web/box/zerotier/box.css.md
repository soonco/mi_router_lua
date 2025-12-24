# box.css.htm - ZeroTier样式

## 文件作用
定义 ZeroTier 虚拟网络服务界面的 CSS 样式。

## 样式规则

### 容器样式
```css
#zerotier_box {}
```
ZeroTier 功能的主容器，当前为空样式。

### 段落样式
```css
[id="zerotier_box"] p {
    text-align: left;
    font-size: large;
    margin-left: 12px;
}
```

### 文本框样式
```css
[id="zerotier_box"] textarea {
    width: 549px;
    height: auto;
    overflow: hidden;
    border: 1px solid #FFF;
}
```

| 属性 | 值 | 说明 |
|------|-----|------|
| width | 549px | 固定宽度 |
| height | auto | 自适应高度 |
| overflow | hidden | 隐藏溢出 |
| border | 1px solid #FFF | 白色边框（几乎不可见） |

## 设计特点
- 状态文本框使用白色边框，视觉上融入背景
- 自适应高度显示网络状态信息

## 依赖关系
- 基础样式 `bc.css`
- 被 `box.htm.htm` 引用
