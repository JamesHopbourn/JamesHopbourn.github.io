---
title: matplotlib with Travis-CI  
date: 2020-02-16 01:00
tags: [matplotlib, travis, Travis-ci, 自动化]
categories:
---

思路: develop 分支存储 matplotlib 代码,git push 之后交由 Travis-CI 云端编译,编译成功后推送到 master 分支供 develop 分支 markdown 引用

原因: 之所以要在 GitHub 上使用 matplotlib + Travis-CI 是因为我把投资报表存储在 GitHub 上，想加点可视化的折线图,于是便有了这般折腾

<!-- more -->

---

TL,DR:
1. GitHub 新建仓库
2. clone 仓库,新建 develop 分支后创建 Demo.py 文件推送回远程仓库
3. 新建 master 分支,推送到远程仓库
4. 在 develop 分支下编辑 .travis.yml 推送远程仓库
5. 在 develop 分支下编辑 README.md 推送远程仓库

---

clone 仓库,新建 develop 分支后创建 Demo.py 文件推送回远程仓库
```
克隆远程仓库
git clone https://github.com/JamesHopbourn/matplotlib-with-travis

进入仓库目录
cd  matplotlib-with-travis

新建 develop 分支
git checkout -b develop

新建 Demo.py 脚本
vim Demo.py

添加修改内容
git add .

添加修改注释
git commit -m 'add Demo.py'

推送远程仓库
git push -u origin develop
```

---

新建 master 分支并推送回远程仓库
```
新建 master 分支
git checkout -b master

推送远程仓库
git push -u origin master
```

---

打开 Travis-CI 项目设置界面设置 token 值为 GitHub 申请的 token,指定 develop 分支使用
![](/media/200216token.png)

---

```
切换回 develop 分支
git checkout develop

新建 .travis.yml 配置文件
vim .travis.yml

.travis.yml 内容
before_install:
# 安装 matplotlib
- python -m pip install matplotlib --user

# git 设置
- git config --global user.name "James Hopbourn"
- git config --global user.email "jameshopbourn@gmail.com"

# 新建 public 目录,python 程序执行后生成的图片保存到 public 目录
script:
- mkdir -p public
- python Demo.py

# 成功之后进入 public 目录将 public 目录内的内容上传到 develop 分支
after_success:
- cd  public
- git init
- git add .
- git commit -m "Travis CI Auto Builder"
- git push --force https://${token}@github.com/JamesHopbourn/matplotlib-with-travis.git
 master 
```

---

推送回远程仓库,等待云端编译完成
```
添加修改内容
git add .

添加修改注释
git commit -m '.travis.yml'

推送远程仓库
git push
```

---

云端编译完成后在 master 分支下找到图片的 download 连接,切换到 develop 分支,引用图片使用
```
切换到 develop 分支
git checkout develop

编辑 README.md
vim README.md

README.md 内容
![](https://raw.githubusercontent.com/JamesHopbourn/matplotlib-with-travis/master/Demo.png)

添加修改内容
git add .

添加修改注释
git commit -m 'README.md'

推送远程仓库
git push
```

---

[matplotlib-with-travis](https://github.com/JamesHopbourn/matplotlib-with-travis)

![](/media/200216diagram.png)
