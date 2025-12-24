# box.htm.htm - 配置备份HTML模板

## 文件作用
提供配置备份功能的用户界面，包含备份和恢复操作的表单控件。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.sys` | 系统命令执行 |
| `string.split` | 字符串分割 |

## 页面原理

### 数据获取
```lua
-- 获取可备份的功能列表
files_names = luci.sys.exec("du -d 1 "..xxx_path.."/xxxbox | ...")

-- 获取已有的备份文件列表
files_names_baks = luci.sys.exec("du -d 1 /mnt/sda/mi_bak/*.xxxbak | ...")
```

### 界面结构
1. **标题**: "备份管理"
2. **单独备份区域**:
   - 下拉选择框（可备份项）
   - "快速备份"按钮
   - "全部备份"按钮
3. **备份恢复区域**:
   - 下拉选择框（已有备份）
   - "快速恢复"按钮
   - "全部恢复"按钮
4. **说明文字**: 功能介绍

### 特殊选项
- `xxxconf`: 扩展功能的配置文件，包含导航、指令、免密信息

## 依赖关系
- `box.js.htm` - 交互逻辑
- `box.css.htm` - 样式定义
- `box.lua.htm` - 后端处理

## AJAX 标记
```html
<!-- config_bak_box_ajax_start -->
<!-- config_bak_box_ajax_end -->
```
用于标记可动态更新的内容区域。
