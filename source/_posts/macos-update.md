---
title: 使用 git 管理软件列表
date: 2020-01-01 22:00
tags: macOS
categories: 
---

## 思路
用户目录下clone GitHub 上面创建好的 dotfile 仓库，zshrc 配置更新 function

<!-- more -->

## zshrc function
function 功能：导出现在安装的 Homebrew、pip、npm、mas 软件清单，与原始清单取并集

```
update(){
    dir="$HOME/dotfile/Backup"
    echo "$(brew list -1 >> $dir/brew.txt && sort -n $dir/brew.txt | uniq)" > $dir/brew.txt
    echo "$(brew cask list -1 >> $dir/cask.txt && sort -n $dir/cask.txt | uniq)" > $dir/cask.txt
    echo "$(mas list| awk '{print $1}' >> $dir/mas.txt && sort -n $dir/mas.txt | uniq)" > $dir/mas.txt
    echo "$(pip freeze 2>/dev/null >> $dir/pip.txt && sort -n $dir/pip.txt | uniq)" > $dir/pip.txt
    echo "$(pip3 freeze >> $dir/pip3.txt && sort -n $dir/pip3.txt | uniq)" > $dir/pip3.txt
    echo "$(npm ls -g --depth 0 >> $dir/npm.txt && sort -n $dir/npm.txt | uniq)" > $dir/npm.txt
  }
```

## 更新软件清单
安装一下 tomcat 来进行测试
![](/media/brewtomcat.png)

```
cd ~/dotfile
gaa;gcsm 'tomcat';gp 
```

![](/media/gittomcat.png)
