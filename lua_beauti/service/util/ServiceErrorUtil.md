# ServiceErrorUtil.lua - 服务错误工具模块

## 工作原理

本模块提供统一的错误码和错误消息管理功能。通过维护一个错误码到错误消息的映射表，将数字错误码转换为用户友好的错误提示信息。

### 错误码分类

| 错误码范围 | 类别 | 说明 |
|------------|------|------|
| 0-10 | 通用错误 | 参数相关错误 |
| 1000-1999 | 设备错误 | 设备相关错误 |
| 2000-2999 | 数据中心错误 | 后端服务错误 |

## 接口

### 函数

| 函数 | 参数 | 返回值 | 说明 |
|------|------|--------|------|
| `getErrorMessage(errorCode)` | errorCode: 错误码(数字) | string | 根据错误码获取对应的错误消息 |

### 错误码映射表

| 错误码 | 错误消息 |
|--------|----------|
| 0 | (空字符串，表示成功) |
| 1 | parameter missing |
| 2 | Parameter empty |
| 3 | Parameter format error |
| 5 | invalid app id |
| 1056 | invalid device id |
| 1057 | resource is not ready |
| 1559 | datacenter error |
| 2010 | datacenter error |
| 其他 | 未知错误 |

## 外部引用

本模块使用 LuCI 的国际化函数 `_()` 和 `translate()` 进行错误消息的本地化处理。
