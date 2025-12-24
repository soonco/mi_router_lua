# zt_exc_jb.htm - Lucky 安装脚本

## 文件作用
记录 Lucky 工具的一键安装命令，用于在路由器上快速部署 Lucky 服务。

## 安装命令
```bash
URL="http://release.ilucky.net:66"
curl -o /tmp/install.sh "$URL/install.sh" && sh /tmp/install.sh "$URL"
```

## 执行流程
1. **设置源地址**: 定义 Lucky 发布服务器 URL
2. **下载脚本**: 使用 curl 下载安装脚本到 `/tmp/install.sh`
3. **执行安装**: 运行安装脚本并传入源地址参数

## Lucky 简介
Lucky 是一款多功能网络工具，常用功能包括：
- DDNS 动态域名解析
- 端口转发
- 反向代理
- Wake-on-LAN

## 使用场景
此文件主要作为安装命令的备忘，不参与实际页面渲染。在需要安装 Lucky 时可直接复制执行。

## 注意事项
- 需要路由器能够访问外网
- 需要 curl 工具支持
- 安装前确保有足够的存储空间
