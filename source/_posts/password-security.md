---
title: 如何妥善保存密码密钥
date: 2020-02-09 22:35
tags: 审查, 安全, 隐私, 密钥, 密码
---

1. 账号密码全部保存 1Password，脑子放空只记住主密码，主密码要有一定安全性
2. 能开启两步验证的账号都开启
例如：Google、Dropbox、GitHub、Microsoft、Facebook
3. 密码长度能多长就多长 反正都是自动填充

<!-- more -->

4. 密码全部用 1Password 随机生成 不能重复
例如：密码设置到最长长度，字母 1/2、数字 1/4、符号 1/4
5. 不要过于信任 Touch ID，因为它可以被欺骗也可以「被」认证，Face ID 同理
6. 归档敏感文件使用 7z 固实压缩并加密文件名，密码不少于 36 位，用 1Password 生成
macOS 解压缩软件推荐使用 Keka
```
brew cask install keka
```
7. 抹除敏感文件需要用 shred 擦写 36 次或以上
```
brew install coreutils
gshred -f -v -z -u --iterations=36 文件名
```
8. SSH、GPG 私钥备份到 1Password, passphrase 不少于 36 位
```
ssh-keygen -t rsa -b 4096 -C "个人邮箱"
```
9. SSH 私钥配置 ssh-agent 每次重启后要求重新输入密码
```
vim ~/.zshrc

plugins=(... ssh-agent ...)
```
10. GPG 私钥配置 gpg-agent 每次重启后要求重新输入密码
```
vim ~/.zshrc

plugins=(... gpg-agent ...)
```
11. 二次验证备用码保存到 VeraCrypt 卷中，VeraCrypt 密码随机生存离线保存，保证 VeraCrypt 密码与网络隔离且多份安全保存
```
brew install p7zip qrencode
vim password.txt
7z a -t7z password.7z password.txt
xxd password.7z > password.txt
qrencode -r password.txt -o password.png
```
12. 常用敏感文件使用 VeraCrypt 加密，iCloud 同步。iOS 客户端: Disk Decipher，macOS 客户端: VeraCrypt。建议配合隐藏卷和 keyfile 使用。keyfile 保存在 TF卡，遇到审查直接剪断 TF卡
13. 特别重要或者敏感的账号配置 [Yubikey](https://zh.wikipedia.org/zh-cn/YubiKey) 硬件物理认证
14. 能用 SSH 尽量用 SSH，比如使用 SSH 连接 GitHub 而不是 HTTPS，使用 SSH 协议而不是 HTTPS 协议的好处: [使用 GitHub 的几种方式——兼谈安全性和隐匿性的经验](https://program-think.blogspot.com/2016/03/GitHub-Security-Tips.html)