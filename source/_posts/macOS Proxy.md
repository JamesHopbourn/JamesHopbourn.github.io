---
title: macOS 代理配置
date: 2019-11-01 16:10:00
tags: 代理, Surge
---

常规代理：互联网请求 → Surge → AdGuard → 服务器

如果主线路被屏蔽：互联网请求 → Surge → v2ray → AdGuard → 服务器

如果有抓包的需求：互联网请求 → Chalres → Surge → AdGuard → 服务器

匿名上网：Tor 浏览器 → Surge → v2ray → AdGuard → 中转节点 → 服务器

<!-- more -->

## 配置 v2ray
v2ray GUI 版本用的不是很习惯，个人使用命令行版本，可以从 [v2ray GitHub release](https://github.com/v2ray/v2ray-core/releases) 页面下载。下载后更新 config.json 配置文件即可。
在终端依次输入以下命令后关闭窗口即可让 v2ray 在后台运行，请注意需要将路径改为你存放 v2ray 文件的路径：
```
nohup /Applications/v2ray-macos/v2ray >> /tmp/v2ray.log &
exit
exit
```
![](/media/v2ray.png)

## 配置 Tor 浏览器
打开 Tor 后将代理设置为 Surge 的监听端口，地址为 127.0.0.1
![](/media/Tor.png)

## 配置 Charles
如果需要在使用 Charles 的同时让它和 Surge 共存需要点击 Proxy → External Proxy Settings.. 设置转发给 Surge，如果需要解密 https 流量还需要添加证书并信任。
![](/media/Charles.png)
