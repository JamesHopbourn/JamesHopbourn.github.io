---
title: Quantumult 快速入门教程
date: 2020-12-18 20:35
tags: iOS
categories: 
---

Quantumult 快速入门教程，主要是奔着去除微信广告的功能去的。

<!-- more -->

1. 通过美区 App Store 下载 Quantumult X
如果这步遇到困难请在 Telegram 联系 @Rocket_Girls 代购

2. 添加订阅地址
把自己购买的线路节点订阅地址复制到剪切板之后
打开 Quantumult X → 右下角按钮 → 节点分类 → 引用（订阅） → 右上角 + 号 → 粘贴 URL

3. 添加配置文件
打开 Quantumult X → 右下角按钮 → 右上角 🔗 图标 → 关联新的配置 → 粘贴下面这个链接 → 好
```
https://raw.githubusercontent.com/alpha87/QuantumultX-Profiles/master/quantumultX_profile.conf
```

4. 修改规则模式
打开 Quantumult X → 右下角按钮 → 滑到底部 → 其他设置 → 选择「规则分流」

5. 安装 VPN 配置
打开 Quantumult X → 点击右上角按钮 → 安装 VPN 配置

6. 添加重写规则
打开 Quantumult X → 右下角按钮 → 滑到底部 → 配置文件分类 → 编辑 → 找到 [rewrite_local] 所在行 → 粘贴以下内容 → 点击右上角保存
```
; 去除微信公众号文章内广告
^https?:\/\/mp\.weixin\.qq\.com\/mp\/getappmsgad url script-response-body WeChat.js

; 访问电脑版知乎
^https?:\/\/www\.zhihu\.com\/ url request-header (\r\n)User-Agent:.+(\r\n) request-header $1User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36$2

; DuckDuckGo 关键词重定向搜索
^https:\/\/duckduckgo.com\/\?q=db\+([^&]+).+ url 302 https://m.douban.com/search/?query=$1
^https:\/\/duckduckgo.com\/\?q=ddg\+([^&]+).+ url 302 https://duckduckgo.com/?ia=about&q=$1
^https:\/\/duckduckgo.com\/\?q=bd\+([^&]+).+ url 302 https://www.baidu.com/s?wd=$1
^https:\/\/duckduckgo.com\/\?q=gh\+([^&]+).+ url 302 https://github.com/search?q=$1
^https:\/\/duckduckgo.com\/\?q=gm\+([^&]+).+ url 302 https://www.google.com/search?&tbm=isch&q=$1
^https:\/\/duckduckgo.com\/\?q=yd\+([^&]+).+ url 302 https://dict.youdao.com/search?q=$1
^https:\/\/duckduckgo.com\/\?q=([^&]+).+ url 302 https://www.google.com/search?q=$1
```

7. 添加 MitM 主机名
打开 Quantumult X → 右下角按钮 → 滑到底部 → 配置文件分类 → 编辑 → 找到 [rewrite_local] 所在行 → 粘贴以下内容 → 点击右上角保存
```
hostname = mp.weixin.qq.com, www.zhihu.com, duckduckgo.com
```

8. 修改 Safari 搜索引擎
打开设置 → Safari 浏览器 → 搜索引擎 → DuckDuckGo

9. 生成 MitM 根证书
打开 Quantumult X → 右下角按钮 → 滑到 MitM 分类 → 点击生成证书

10. 安装 MitM 根证书
打开 Quantumult X → 右下角按钮 → 滑到 MitM 分类 → 点击配置证书

11. 开启重写功能
打开 Quantumult X → 右下角按钮 → 滑到重写分类 → 点击开启重写
打开 Quantumult X → 右下角按钮 → 滑到 MitM 分类 → 点击开启 MitM

12. 添加 WeChat.js 重写脚本
打开文件 → 我的 iPhone → Quantumult X → Scripts → 新建文件：WecChat.js → 粘贴以下内容
```
/**
 * @supported 
 */

// 去除微信公众号文章内广告
var obj = JSON.parse($response.body);
obj.advertisement_num = 0;
obj.advertisement_info = [];
delete obj.appid;
$done({ body: JSON.stringify(obj) });
```

13. 重启 Quantumult X 查看效果
- 微信公众号尾部的广告屏蔽
- 知乎不会强制要求跳转客户端
- 在 Safari 搜索栏可以使用关键词：db ddg bd gh gm yd 直接跳转搜索网页，如果不带关键词默认重定向至 Google 搜索  
  
[Rules / 分流/去广告规则：Surge / Shadowrocket / Quantumult/ Quantumult X 及详细配置步骤教程（萌新小白版本）](https://limbopro.xyz/archives/2561.html)  
[alpha87/QuantumultX](https://github.com/alpha87/QuantumultX-Profiles)  
[QuantumultX 配置文件以及常用的脚本推荐](https://www.lijianxun.top/106.html)  