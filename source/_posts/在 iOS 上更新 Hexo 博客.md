---
title: 在 iOS 上更新 Hexo 博客
date: 2019-10-04 23:04
tags: 流程
---

最终实现效果：
1. MWeb 编辑文章 
2. Working Copy 上传文章 
3. Travis-CI 自动部署 
4. Bark 推送更新完成通知

<!-- more -->

# 需要的软件
iOS：MWeb(60¥ 内购)、Working Copy（108¥/年 订阅）、Bark（免费）

# macOS 端操作
### Hexo
下载安装 Homebrew：/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
下载安装 Node：brew install node
下载安装 Hexo：npm install hexo-cli -g
新建博客文件夹：hexo init blog
进入文件夹：cd blog
安装相关程序：npm install

### GitHub
新建 GitHub 博客仓库
clone 博客仓库到本地
新建并切换分支
上传博客源代码
创建 token

### Travis-CI
关联博客仓库配置 token

# iOS 端操作
### Bark
下载好 Bark 后获取设备唯一标识符，构造更新提醒推送链接，设备唯一标识符为图中红色高亮部分。
![](/media/15702021204276.jpg)


链接格式如下：
```
https://api.day.app/设备唯一标识符/Hexo%20%E5%8D%9A%E5%AE%A2%E6%9B%B4%E6%96%B0%E5%AE%8C%E6%88%90?url=博客地址
```
「Hexo%20%E5%8D%9A%E5%AE%A2%E6%9B%B4%E6%96%B0%E5%AE%8C%E6%88%90」是「Hexo 博客更新完成」编码后的形式，你也可以替换成提示文本，但是注意需要进行 URL 编码。
构造好了 URL 链接可以把链接粘贴到 Safari 里面去打开，如果你的链接正确会给你推送提醒：Hexo 博客更新完成，点击通知后可以转到你的博客。
如果测试没有问题，就可以把 URL 推送链接添加到 .travis.yml 的 git push 的下面一行，个人建议是在 git push 和 URL 之间加一个 20 秒的 sleep，因为部署到网站需要一点时间。我的修改后配置如下：
```
git push --quiet --force https://${hexo}@github.com/JamesHopbourn/JamesHopbourn.github.io.git master
sleep 20
curl https://api.day.app/oQ3DDZqR3TLmsyLSscVerH/Hexo%20%E5%8D%9A%E5%AE%A2%E6%9B%B4%E6%96%B0%E5%AE%8C%E6%88%90?url=https://jameshopbourn.github.io/
```

### Working Copy
将 GitHub 上的博客仓库 clone 到本地。点击右上角的「+」并选择「Clone repository」初次使用需要登录你的 GitHub 账号后选择你的博客项目然后 clone 下来。

![](/media/15702020493448.jpg)

### MWeb
![](/media/15702016171330.jpg)
<center>添加 source 外部文件夹</center> 

![](/media/15702017101305.jpg)
<center>设置媒体文件夹名和路径</center>


![](/media/15702018281789.jpg)
<center>收藏 _posts 文件夹</center>
