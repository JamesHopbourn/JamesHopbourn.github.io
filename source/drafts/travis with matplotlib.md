---
title: Matplotlib with Travis-CI  
date: 2020-02-05 21:40
tags: [Matplotlib, travis, 自动化]
categories:
---

思路：使用 Matplotlib 配合 Travis-CI 生成图片供 GitHub 引用
master 分支存放代码文件 develop 用于存放生成的图片供 master 分支引用

<!-- more -->

TL,DR:
1. GitHub 新建仓库
2. clone 仓库,推送 develop 分支到 GitHub
3. 新建 master 分支,新建 .travis.yml Demo.py README.md 文件

新建 .travis.yml Demo.py 文件
```
git clone ssh://james/JamesHopbourn/Travis-with-Matplotlib
cd Travis-with-Matplotlib

vim .travis.yml
vim Demo.py

git add -A
git commit -m 'Demo.py'
git push
```

.travis.yml 文件编辑
```
before_install:
# 安装中文字体
- sudo apt-get install -y fonts-wqy-microhei
- sudo fc-cache -f -v

# 安装 matplotlib
- python -m pip install matplotlib --user

# git 设置
- git config --global user.name "James Hopbourn"
- git config --global user.email "jameshopbourn@hotmail.com"

# 新建 public 目录,python 程序执行后生成的图片保存到 public 目录
script:
- mkdir -p public
- python Demo.py

# 成功之后进入 public 目录将 public 目录内的内容上传到 develop 分支
after_success:
- cd ./public
- git init
- git add --all .
- git commit -m "Travis-CI 自动化编译"
- git push --force https://${hexo}@github.com/JustinPual/develop.git
 develop
```

新建 develop 分支推送回远程
```
git checkout -b develop
git push --set-upstream origin develop
```
