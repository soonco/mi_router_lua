# zt_exc_cy.htm - 常用命令速查表

## 文件作用
记录路由器系统管理常用的 Shell 命令，作为开发和运维的快速参考文档。

## 命令列表

### 磁盘与存储
| 命令 | 说明 |
|------|------|
| `fdisk -l \| grep 'Disk'` | 查看磁盘空间 |
| `blkid` | 查看磁盘信息（UUID、文件系统类型等） |
| `mount` | 查看/管理挂载信息 |
| `cat /proc/mtd` | 查看 MTD 分区信息 |

### 网络管理
| 命令 | 说明 |
|------|------|
| `route` | 查看/管理路由表 |
| `brctl` | 网桥管理工具 |

### SSH UI 工具
| 命令 | 说明 |
|------|------|
| `htop` | 进程管理（交互式） |
| `cfdisk` | 磁盘分区管理（交互式） |
| `iftop` | 实时流量监控 |

### 条件判断
```bash
# 查找文件判断
[ -n "$(find /etc/rc.d -name 'filename')" ] && echo true || echo false

# 查找文本判断
[ -n "$(cat /etc/passwd | grep 'root')" ] && echo true || echo false
```

## 使用场景
此文件主要用于开发调试和系统运维时的命令参考，不参与实际页面渲染。
