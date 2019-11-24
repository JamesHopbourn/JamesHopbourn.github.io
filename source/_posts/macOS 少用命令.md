---
title: macOS 少用命令
date: 2019-10-31 09:58:38
tags: 终端
---

监控文件变化情况，例如变化执行具体指令
```
用法：fswatch -0 被监控文件 | xargs -0 -n1 -I{} 变化后执行的命令
例子：fswatch -0 test.c | xargs -0 -n1 -I{} gcc test.c -o test
```

批量创建有序文件/文件夹
```
touch {1..10}.txt
mkdir {1..10}
```
<!-- more -->

一次性定时执行命令

```
command | at 12:00
```

计算命令执行时间

```
time gcc test.c 
```

查看 SIP 状态及关闭 SIP：

```
csrutil status
csrutil disable
```

tmux [Tmux 快捷键 & 速查表 · GitHub](https://gist.github.com/ryerh/14b7c24dfd623ef8edc7)
 
文件夹或者文件比较

```
diff -rq directory1 directory2
diff (file input 1) (file input 2)
```

curl [参考文章](https://coderlt.coding.me/2016/03/22/mac-command-curl/)
```
post：curl -D "name=xxx&age=xxx" 127.0.0.1:8899/post
头信息：curl -i www.sina.com
通信过程：curl -v www.sina.com
发送表单：curl --form username=xxxx --form password=xxx https://sm.ms/api/v2/token

```

Brew 查看文件路径

```
brew --prefix wget
```

pip 查看软件包路径

```
pip show condo
```

[convert 命令](https://www.thalib.in/notes/2016-10-31-linux-create-image-commandline.html)
[ImageMagick使用心得](http://www.charry.org/docs/linux/ImageMagick/ImageMagick.html)
```
纯色图片：convert -size 640x480 xc:black empty.jpg
反转图片颜色：convert input.png -channel RGB -negate output.png
文本转图片：convert -fill white -pointsize 60 -font helvetica -draw 'text 10,80 "Hello, World!"' hello.jpg  helloworld.jpg
在图像的10,80 位置采用60磅的全黑Helvetica字体写上 Hello, World! 
convert -size 300x150 xc:black -pointsize 20 -fill white -draw 'text 120,120 "Here is the TEXT"' image-with-text.jpg
```

终端执行 AppleScript 脚本

```
osascript scriptname

```

VPS 性能测试

```
快速测试：
wget -qO- https://ilemonrain.com/download/shell/LemonBench.sh | bash -s fast
完整测试：
wget -qO- https://ilemonrain.com/download/shell/LemonBench.sh | bash -s full

```

say 命令输出文件
```
say '测试音频文件' -o 音频文件.aiff
say -f file -o file.aiff
```

二进制下编辑文件
```
$ xxd file1 file1.dump
$ cat file1.dump 
00000000: 736f 6d65 2063 6f6e 7465 6e74 206f 6620  some content of 
00000010: 6669 6c65 310a                           file1.
$ vim file1.dump 
# magic editing...
$ cat file1.dump
00000000: 736f 6d65 4d41 4749 4321 6e74 206f 6620  some content of 
00000010: 6669 6c65 310a                           file1.
$ xxd -r file1.dump 
someMAGIC!nt of file1
```

vim 集成：
```
先用二进制方式打开文件 vim FILE -b
在正常模式下输入魔法 :%!xxd
修改
退出到正常模式，继续魔法 :%!xxd -r
```
[xxd (从新手到菜鸟的Linux教程)](https://zhuanlan.zhihu.com/p/24883064)

[进制转换](http://www.freecls.com/a/2712/7a)
[shell - How to convert a text file to binary file using linux commands - Stack Overflow](https://stackoverflow.com/questions/28242813/how-to-convert-a-text-file-to-binary-file-using-linux-commands)
```
以16进制文本显示
xxd -p -l 16 1.jpg
ffd8ffe000104a464946000101010060

十六进制转二进制
echo -n 'ffd8ff' | xxd -b

文件二进制显示
xxd -b file
```

shell 运算符
```
同时执行：command A & command B & command C
与或：brew install tig && say '安装成功' || say '安装失败'
顺序：brew install tig ; say '命令执行完成'
```

设置文件/文件夹不可见
```
chflags hidden /path/to/file
chflags nohidden /path/to/file
```

axel 多线程下载
```
axel -n 10 -o /tmp/ http://www.jsdig.com/lnmp.tar.gz
```

文件备份
```
cp file{,.$(date -r file "+%y%m%d")}
```

显示一个文件并且在每行开头添加行号
```
cat test.txt | nl
     1  line 1 
     2  line 2
```

在以普通用户打开的VIM当中保存一个ROOT用户文件
```
:w !sudo tee %
```

bwm-ng 端口速度

Base64 相关
```
base64 <<< string
base64 -D <<< string

openssl base64 -in base.png > base.txt
openssl base64 -d -in base.txt > base.png

data:image/png;base64,
data:image/svg+xml;base64,

base64 -in file
base64 -D -in file
```

md5 相关
```
md5 -s string
md5 file
```

批量按照文件名压缩
```
ls -1 * | xargs -n 1 bash -c 'zip "$0".zip "$0"'
```

zip 显隐术
```
zip -P password output.zip input.txt
cat test.png output.zip > final.png
unzip final.png
```

echo bboysoul is a bad guy | pv -qL 10 打字效果输出

hydra 暴力破解

crunch 字典生成

ag 高级搜索

htop 进程监控工具

cloc 代码概览工具

mc 文本编辑工具

qrencode 二维码生成

bc命令 [ubuntu 下二进制 ，十进制，十六进制的转换 - 程序人生 - CSDN博客](https://blog.csdn.net/Harith/article/details/12185713)
