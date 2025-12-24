# box.htm.htm - ZeroTier HTML模板

## 文件作用
提供 ZeroTier 虚拟网络服务的用户界面，包含状态显示、服务控制和网络管理。

## 使用的 API

### Lua 模块
| 模块 | 说明 |
|------|------|
| `luci.sys` | 系统命令执行 |

## 页面原理

### 界面结构
1. **标题**: "Zerotier设置"
2. **状态显示**: 显示当前网络连接状态
3. **服务控制**:
   - 停止按钮
   - 重启按钮
4. **网络管理**:
   - 加入网络（输入网络ID）
   - 离开网络（输入网络ID）

### 状态获取
```lua
<%=luci.sys.exec("source /etc/profile >/dev/null && zerotier-cli listnetworks")%>
```
显示当前已加入的 ZeroTier 网络列表。

### 表单字段
| 字段 | 说明 |
|------|------|
| url1 | 状态显示（只读） |
| url2 | 加入网络的 ID |
| url3 | 离开网络的 ID |

## 依赖关系
- `box.js.htm` - 交互逻辑
- `box.css.htm` - 样式定义
- `box.lua.htm` - 后端处理

## 使用说明
1. 查看当前网络状态
2. 输入 16 位网络 ID 加入网络
3. 在 ZeroTier Central 授权设备
4. 等待网络连接建立
