---
title: CTF 压缩包伪加密
date: 2020-01-01 09:39
tags: CTF
categories: 
---

## 原理
第一行 0x06 位置处的 0000 是全局方式标记，看是否加密，可以只看第一个00，第二字节00可以忽略。00表示无加密，01表示有加密。只要是偶数就是无加密，例如00,02,04等，奇数就是有加密，例如01,03,09 等。

<!-- more -->

![](/media/zipfakeencrypt.png)

## 新建压缩包：

```
vim flag.txt
7z a -tzip flag.zip flag.txt
```


## 加密

```
导出十六进制：
xxd flag.zip flag.dump
使用 sed 配合正则表达式进行替换：
sed -i '' -E '1s/[0-9]{4}/0100/4' flag.dump
导出新压缩包：
xxd -r flag.dump > FakeEncrypt-flag.zip
```

## 破解

```
导出十六进制：
xxd FakeEncrypt-flag.zip flag.dump
使用 sed 配合正则表达式进行替换：
sed -i '' -E '1s/[0-9]{4}/0000/4' flag.dump
导出新压缩包：
xxd -r flag.dump > UnFakeEncrypt-flag.zip
```

## 彩蛋
嫌这样操作太麻烦，在实际运用中不方便可以添加一个 function 到 zshrc 里面：

```
fakeency(){
xxd $1 $1.dump
sed -i '' -E '1s/[0-9]{4}/0100/4' $1.dump
xxd -r $1.dump > FakeEncrypt-$1
rm $1.dump
}

unency(){
xxd $1 $1.dump
sed -i '' -E '1s/[0-9]{4}/0000/4' $1.dump
xxd -r $1.dump > UnFakeEncrypt-$1
rm $1.dump
}
```
