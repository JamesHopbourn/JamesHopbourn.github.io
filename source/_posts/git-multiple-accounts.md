---
title: git 多账号配置
date: 2020-01-28 16:04
tags: git
categories: 
---

<script type="text/x-mathjax-config">
MathJax.Hub.Config({tex2jax: {inlineMath:[['$','$']]}});
</script>
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
	MathJax.Hub.Config({
 TeX: {extensions: ["mhchem.js"]}
});
</script>
<script src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_HTML"></script>

TL;DR: 生成两个不同的公私钥添加到两个 GitHub 账号，新建 SSH config 文件，Done.

<!-- more -->

如果存在全局设置，请先取消

```
 git config --global --unset user.name
 git config --global --unset user.email  
```

~$CuSO_{4}$~

生成公私钥并添加到 GitHub 账号的 SSH key 中

```
ssh-keygen -t rsa -b 4096 -C "jameshopbourn@gmail.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/james/.ssh/id_rsa): /Users/james/.ssh/id_rsa_personal

ssh-keygen -t rsa -b 4096 -C "jameshopbourn@protonmail.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/james/.ssh/id_rsa): /Users/james/.ssh/id_rsa_company
```

连通性测试：
```
ssh -T personal
ssh -T company
```

vim ~/.ssh/config
然后复制以下内容到 config 文件

```
# 个人帐户
Host personal
   HostName github.com
   User git
   IdentityFile ~/.ssh/id_rsa_personal

# 公司账户
Host company
   HostName github.com
   User git
   IdentityFile ~/.ssh/id_rsa_company
```

clone 仓库：
```
原先命令：gcl git@github.com:Username/test.git
修改命令：gcl git@github.com:company/test.git
```
