---
title: git create & push repository form CLI 
date: 2020-02-05 21:40
tags: git
categories:
---

TL;DR: brew install hub
hub create repository name

<!-- more -->

1. brew install hub
2. mkdir test && cd test && git init
3. hub create test

Personally, I'd like to use ssh protocol connect to GitHub, so need change repository remote's URL

```
git remote set-url origin ssh://personal/JamesHopbourn/test
git push -u origin master
```

#### 参考资料
[hub 中文文档](http://llever.com/hub-zh/hub-create.1.zh.html)
