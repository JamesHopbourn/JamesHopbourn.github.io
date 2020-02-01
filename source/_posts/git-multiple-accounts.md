---
title: git 多账号配置
date: 2020-01-28 16:04
tags: git
categories: 
---

TL;DR: 生成两个不同的公私钥添加到两个 GitHub 账号，新建 SSH config 文件，Done.

<!-- more -->

生成公私钥并添加到 GitHub 账号的 SSH key 中

```
➜  ~ ssh-keygen -t rsa -b 4096 -C "jameshopbourn@gmail.com"
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

➜  ~ ssh-keygen -t rsa -b 4096 -C "jameshopbourn@protonmail.com"
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
   HostName github.com
   User git
   IdentityFile ~/.ssh/id_rsa_personal

Host company
   HostName github.com
   User git
   IdentityFile ~/.ssh/id_rsa_company
```

clone 仓库：
```
原先命令：git clone git@github.com:Username/test.git
修改命令：git clone git@personal:Username/test.git
```

觉得这样太麻烦？我觉得也是，所以可以在 .zshrc 中添加以下两个 function，然后 source .zshrc 就可以了，配置好之后直接复制地址栏里的 URL 然后在终端输入 personal 或者 company 就可以了

```
personal(){
text=$(pbpaste)
text=$(echo $text|sed 's/https:\/\/github.com\//git@personal:/')
text=$(echo $text|sed 's/$/&.git/g')
git clone $text && cd $(basename $(pbpaste) .git)
}

company(){
text=$(pbpaste)
text=$(echo $text|sed 's/https:\/\/github.com\//git@company:/')
text=$(echo $text|sed 's/$/&.git/g')
git clone $text && cd $(basename $(pbpaste) .git)
}
```

![](/media/200201gitclone.png)
