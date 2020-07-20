---
title: git 的一些技巧
date: 2020-02-05 21:40
tags: git
categories:
---

### 配置两个或多个 git 账号
TL;DR: 生成两个不同的公私钥添加到两个 GitHub 账号，新建 SSH config 文件，Done.

<!-- more -->

生成公私钥并添加到 GitHub 账号的 SSH key 中

```
➜  ~ ssh-keygen -t rsa -b 4096 -C "个人邮箱"
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/james/.ssh/id_rsa): /Users/james/.ssh/id_rsa_personal
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/james/.ssh/id_rsa_personal.
Your public key has been saved in /Users/james/.ssh/id_rsa_personal_pub.
The key fingerprint is:
SHA256:O3KyKB6lj5GKCr3NMzCj+uqq2DLJQ1BiTrpUOT/MMmc jameshopbourn@gmail.com
The key's randomart image is:
+---[RSA 4096]----+
|    .            |
|.o.+             |
|=o. =            |
|oo o E           |
|o.  * . S        |
|.o++     .       |
|+o*+  o +        |
|O=.Oo. = .       |
|/BB.=o.          |
+----[SHA256]-----+

➜  ~ ssh-keygen -t rsa -b 4096 -C "公司邮箱"
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/james/.ssh/id_rsa): /Users/james/.ssh/id_rsa_company
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/james/.ssh/id_rsa_company.
Your public key has been saved in /Users/james/.ssh/id_rsa_company_pub.
The key fingerprint is:
SHA256:O3KyKB6lj5GKCr3NMzCj+uqq2DLJQ1BiTrpUOT/MMmc jameshopbourn@protonmail.com
The key's randomart image is:
+---[RSA 4096]----+
|    .            |
|.o.+             |
|=o. =            |
|oo o E           |
|o.  * . S        |
|.o++     .       |
|+o*+  o +        |
|O=.Oo. = .       |
|/BB.=o.          |
+----[SHA256]-----+
```

上传公钥到 GitHub 
```
➜  ~ cat ~/.ssh/id_rsa_personal.pub|pbcopy

➜  ~ cat ~/.ssh/id_rsa_company.pub|pbcopy
```

连通性测试：
```
➜  ~ ssh -T personal
Hi JamesHopbourn! You've successfully authenticated, but GitHub does not provide shell access.
➜  ~ ssh -T company
Hi Username! You've successfully authenticated, but GitHub does not provide shell access.
```

vim ~/.ssh/config
然后复制以下内容到 config 文件

```
Host personal
   User git
   HostName github.com
   IdentityFile ~/.ssh/id_rsa_personal
   ProxyCommand nc -X 5 -x 127.0.0.1:6153 %h %p

Host company
   User git
   HostName github.com
   IdentityFile ~/.ssh/id_rsa_company
   ProxyCommand nc -X 5 -x 127.0.0.1:6153 %h %p
```

clone 仓库：
```
原先命令：git clone git@github.com:Username/test.git
修改命令：git clone git@personal:Username/test.git
```

觉得这样太麻烦？我觉得也是，所以可以在 .zshrc 中添加以下两个 function，然后 source .zshrc 就可以了，配置好之后直接复制地址栏里的 URL 然后在终端输入 personal 或者 company 就可以了

```
personal(){
url=$(pbpaste|sed 's/https:\/\/github.com\//ssh:\/\/personal\//')
git clone $url && cd $(basename $(pbpaste))
}

company(){
url=$(pbpaste|sed 's/https:\/\/github.com\//ssh:\/\/company\//')
git clone $url && cd $(basename $(pbpaste))
}
```

![](/media/200201gitclone.png)

再打开 Surge Dashboard 看一下，可以看到 nc 转发代理也是正常工作的。

![](/media/200203sshlog.png)

一个 alias 从终端打开 GitHub 仓库 URL

```
alias go="open `git remote -v|awk '/fetch/{print $2}'|perl -pe 's/git.*?:|ssh:\/\/.*?\//https:\/\/github.com\//'|sed 's/\.git$//'`"
```

如果你有使用 hub 也可以使用 hub browse 命令实现

### git commit 添加 GPG 签名认证
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
gpg --list-keys --keyid-format LONG
```

发送公钥到公钥服务器 (如果需要)
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

### 从命令行创建 GitHub 仓库
1. brew install hub
2. git init test && cd test && hub create test 

我个人习惯使用 SSH 协议连接，所以需要的可以在这里修改一下

```
git remote set-url origin ssh://personal/JamesHopbourn/test
git push -u origin master
```

### git 删掉指定内容
```
echo test.txt filter=rm_conf >> .gitattributes
echo -e "username: jameshopbourn\npassword: mypassword" > test.txt
git config filter.rm_conf.clean "sed 's/password:.*/password:/'"
git add -A ; git commit -m 'sed test' ; git push
```

### git clone 指定文件夹
```
建议先添加代理
vim ~/.subversion/servers

[global]
http-proxy-host = 127.0.0.1
http-proxy-port = 6152
http-proxy-compression = no

查看仓库中的目录
svn ls https://github.com/JamesHopbourn/Apple-Automation/trunk

现在仓库中的指定目录
svn checkout https://github.com/JamesHopbourn/Apple-Automation/trunk/Shortcuts ~/Desktop

svn status
svn add *
svn commit -m "SVN commit"
```

### passprash + ssh-agent
```
vim ~/.ssh/config
```

在需要配置 ssh-agent 的 host 中添加: AddKeysToAgent yes
```
Host personal
  User git
  HostName github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa_personal
  ProxyCommand nc -X 5 -x 127.0.0.1:6153 %h %p
```

vim ~/.zshrc
```
plugin=(... ssh-agent)

zstyle :omz:plugins:ssh-agent lifetime 4h
zstyle :omz:plugins:ssh-agent identities id_rsa_personal id_rsa_company 
```

### git alias
```
git config --global alias.last 'log -1'
```

### git 忽略文件
```
vim .gitignore

#忽略C文件夹下的.o文件
C/*.o
#忽略根目录下的 .DS_Store 文件
.DS_Store
#忽略所有目录下的 .DS_Store 文件
.DS_Store?
#忽略整个
Objective-C/build
```

### hub pull request 
```
hub clone https://github.com/JamesHopbourn/Roadbike-knowledge 
cd Roadbike-knowledge
hub fork
git remote set-url origin https://github.com/Username/Roadbike-knowledge

git checkout -b test

vim test.txt
gaa
gcsm test.txt
git push --set-upstream origin test

hub pull-request --base JamesHopbourn:master --head Username:test -m 测试内容
```

### travis-CI with python
[matplotlib with Travis-CI](https://jameshopbourn.github.io/2020/02/16/travis%20with%20matplotlib)

### hide git push email

### 参考文章
[使用 GitHub 的几种方式——兼谈安全性和隐匿性的经验](https://program-think.blogspot.com/2016/03/GitHub-Security-Tips.html)
[Git:使用GPG签名Commit](https://juejin.im/post/5da3ec32e51d45784d3f865d)
[hub 中文文档](http://llever.com/hub-zh/hub-create.1.zh.html)

