---
title: git commit GPG sign 
date: 2020-02-06 00:37
tags: git
categories:
---

使用 GPG 签名 commit 信息

<!-- more -->

安装 GPG
```
brew install gnupg
```

生成公私钥
```
简单版本
gpg --generate-key

完整版本
gpg --full-generate-key

查看信息
gpg --list-keys --keyid-format SHORT
```

发送公私钥(如果需要)
```
发送公钥
gpg --keyserver hkp://pool.sks-keyservers.net --send-keys gpg -a --export 140A9123A5C9FCA6178E2A04BC7A876AA744BDCF 

检查公钥
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 140A9123A5C9FCA6178E2A04BC7A876AA744BDCF
```

输出公钥并设置 GitHub GPG
```
gpg -a --export 140A9123A5C9FCA6178E2A04BC7A876AA744BDCF|pbcopy 
```

配置并测试 GPG sign
```
git config --global user.signingkey 140A9123A5C9FCA6178E2A04BC7A876AA744BDCF
git config --global commit.gpgsign true
git commit -m 'gpg sign test'
```

#### Reference
[Git:使用GPG签名Commit](https://juejin.im/post/5da3ec32e51d45784d3f865d)
