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

Personally, I'd like to use ssh protocol connect to GitHub, so I need set the
origin URL

```
git remote set-url origin ssh://personal/JamesHopbourn/test
git push -u origin master
```
