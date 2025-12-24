# box.css.htm - UCI编辑器样式

## 文件作用
定义 UCI 配置编辑器界面的 CSS 样式。

## 样式规则

### 搜索区域
```css
.search_path {
    display: inline-block;
    border-radius: 70px 0px 0px 70px;
    width: 42px;
    height: 30px;
    line-height: 30px;
    padding-left: 8px;
    margin-left: 40px;
}
```

### 搜索输入框
```css
[name="search_text"] {
    width: 550px;
    height: 28px;
}
```

### 搜索按钮
```css
[name="search_butt"] {
    border-radius: 0px 70px 70px 0px;
    width: 50px;
    height: 31px;
}
```

### 结果项
```css
[name="search_res"] {
    margin-top: 5px;
    display: flex;
}
```

### 结果路径
```css
.search_res_path {
    display: inline-block;
    width: 300px;
    border-radius: 70px 0px 0px 70px;
    height: 30px;
    line-height: 30px;
    padding-left: 8px;
    margin-left: 60px;
}
```

### 结果输入框
```css
[name="search_res_text"] {
    width: 300px;
    border-radius: 0px 70px 70px 0px;
    height: 28px;
}
```

### 保存按钮
```css
[name="save_butt"] {
    border-radius: 70px;
    width: 80px;
    margin-top: 10px;
    height: 31px;
}
```

## 设计特点
- 使用圆角设计，视觉效果柔和
- Flex 布局实现响应式排列
- 统一的高度和间距
