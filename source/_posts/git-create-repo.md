---
title: git create & push repository form CLI 
date: 2020-02-05 21:40
tags: git
categories:
---

TL;DR: brew install hub ; hub create repository name

<!-- more -->

1. brew install hub
2. mkdir test && cd test && git init
3. hub create test

我个人一般是使用 ssh 协议连接 GitHub，所以需要设置 URL

```
git remote add origin ssh://personal/JamesHopbourn/test
git push origin master
``
