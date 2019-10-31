---
title: macOS 少用命令
date: 2019-10-31 09:58:38
tags: 终端
---

监控文件变化情况，例如变化执行具体指令
```
用法：fswatch -0 被监控文件 | xargs -0 -n1 -I{} 变化后执行的命令
例子：fswatch -0 test.c | xargs -0 -n1 -I{} gcc test.c -o test
```

批量创建有序文件/文件夹
```
touch {1..10}.txt
mkdir {1..10}
```

一次性定时执行命令

```
command | at 12:00
```

计算命令执行时间

```
time gcc test.c 
```

查看 SIP 状态及关闭 SIP：

```
csrutil status
csrutil disable
```

tmux [Tmux 快捷键 & 速查表 · GitHub](https://gist.github.com/ryerh/14b7c24dfd623ef8edc7)
 
文件夹或者文件比较

```
diff -rq directory1 directory2
diff (file input 1) (file input 2)
```

Brew 查看文件路径

```
brew --prefix wget
```

pip 查看软件包路径

```
Pip show condo
```

终端执行 AppleScript 脚本

```
osascript scriptname

```


bwm-ng 端口速度

Base64 相关

```
base64 <<< string
base64 -D <<< string

base64 -in file
base64 -D -in file
```

iperf 内网测试

lolcat 彩色文本输出

echo bboysoul is a bad guy | pv -qL 10 打字效果输出

yes 一只输出

mycli

thefuck 错误自动修正

hydra 暴力破解

crunch 字典生成

wtf 短语查询

ag

tig

htop 进程监控工具

cloc 代码概览工具

mc 文本编辑工具
