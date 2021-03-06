---
title: CTF 二维码出题解题思路
date: 2019-12-30 20:05
tags: CTF
categories: 
---
## 题目
昨天晚上没睡着突然有个这么个想法，觉得还行，故意挖了个坑会让人觉得这是个二进制去处理

<link href="http://apps.bdimg.com/libs/highlight.js/9.1.0/styles/default.min.css" rel="stylesheet">
<script src="http://apps.bdimg.com/libs/highlight.js/9.1.0/highlight.min.js"></script>
<script>hljs.initHighlightingOnLoad();</script>

<!-- more -->

H4sIAPHrCV4AA4VSWw7AIAj732nk/pebZmG0pUQSDcqrBSJQ1pZzf3qIrF/QJ99l
q1j0TB1t6lk+N8+s6HMyTkTFOJkdH89cY51FaxbW/oP3PIGpr5zD9UXz+04rImag
DKfJ9X4yc90aroh7gnFaR7Ez+z7J3nufU6v5Xep7wgx9XtSeF2yR0OxzAwAA

## 出题
```
生成 flag 二维码的 ASCII：qrencode -t ASCII 'flag:jbcool' > new.txt
井号和空格替换：sed -i '' -e 's/ /0/g' -e 's/#/1/g' new.txt
压缩为一行数字：tr  "\n" " " < new.txt > edit.txt
删去多余的空格：sed -i '' -e 's/ //g' edit.txt
压缩 01 字符：cat edit.txt | gzip > edit.zip
base64 编码：openssl base64 -in edit.zip > base.txt
```

## 解题
1. base64 解码

```
openssl base64 -d -in base.txt > edit.zip
unzip edit.zip
```

2. 由于已经将多行文本压缩为一行，所以需要先对这一行数字进行分割，写一个小脚本实现：

```
var character = process.argv[2];

function isInteger(obj) {
    return obj%1 === 0
}

for (var i=0;i<50;i++)
{
	line = character/i
	if (isInteger(line) == true){
	console.log(i +'行:'+ line)
	}
}
```

3. 计算文件字符数并减去 1 字符的空格，然后运行这个 JS

```
wc news.txt
       1       1     883 news.txt
node 191227\ 行数判断.js 882
1行:882
2行:441
3行:294
6行:147
7行:126
9行:98
14行:63
18行:49
21行:42
42行:21
49行:1
```

4. 大概排除一下，盲猜应该是属于 14、18、21 这三个比较有可能，我直接用 21 来演示：

```
fold -w 42 news.txt > flag.txt
111111111111110000110011110011111111111111
110000000000110011110011000011000000000011
110011111100110011110000110011001111110011
110011111100110000110011000011001111110011
110011111100110011000000110011001111110011
110000000000110011000011110011000000000011
111111111111110011001100110011111111111111
000000000000000011111111110000000000000000
111100110000111100111100000011111100111100
000011000011000011111100001100111100111111
110000111100111111001100110000110000110011
001100000011001100000011000011111111001100
001100110000111111000000110000001100001111
000000000000000011001111001111110011000011
111111111111110011110000001111111100111100
110000000000110000000011110000111100000011
110011111100110000000011001100001100001100
110011111100110011001100000000111111001111
110011111100110000000000111100111111000011
110000000000110011110011001100110011000000
111111111111110011000000000011000000001100
```

5. 恢复正常二维码并扫描得到 flag

```
空格替换为数字0：sed -i '' -e 's/0/ /g' flag.txt
井号替换为数字1：sed -i '' -e 's/1/#/g' flag.txt
```

ACSII 二维码在网页上显示字符密度较低无法扫描，可能需要用文本编辑器稍微缩放一下：

```
##############    ##  ####  ##############
##          ##  ####  ##    ##          ##
##  ######  ##  ####    ##  ##  ######  ##
##  ######  ##    ##  ##    ##  ######  ##
##  ######  ##  ##      ##  ##  ######  ##
##          ##  ##    ####  ##          ##
##############  ##  ##  ##  ##############
                ##########                
####  ##    ####  ####      ######  ####  
    ##    ##    ######    ##  ####  ######
##    ####  ######  ##  ##    ##    ##  ##
  ##      ##  ##      ##    ########  ##  
  ##  ##    ######      ##      ##    ####
                ##  ####  ######  ##    ##
##############  ####      ########  ####  
##          ##        ####    ####      ##
##  ######  ##        ##  ##    ##    ##  
##  ######  ##  ##  ##        ######  ####
##  ######  ##          ####  ######    ##
##          ##  ####  ##  ##  ##  ##      
##############  ##          ##        ##  
```

## 彩蛋
嫌不够难的话，把 base64 结果大小写互转一下，decode 一下懵逼了。

```
var text = process.argv[2];
var text = text.split("");

for(var i=0;i<text.length;i++){
if(text[i] == text[i].toLowerCase())text[i]  = text[i].toUpperCase();
else if(text[i] == text[i].toUpperCase())text[i] = text[i].toLowerCase();
}

text = text.join("");
console.log("\n大小写互换之后的结果是：\n"+text);
```

大小写转换后的结果：

```
h4SiaphRcv4aa4vswW7aiaJ732NK/PEBzMg0PuqsdCQRbsjq1PzZF3QiRf/qj99L
Q1J0tb1T6LK+n8+S6hmYtKtfojKDh89Cy51fAXBw/Op3pigPR5Zd9uxZ+04RiMAG
dkFj9x4YC90AROH7GNfAr7eZ+Z7j3NUFu6V5xEP7WGX9xTsEf2Yr0oXZaWaa
```

进行 base64 decode 后的结果：

```
���j�Qr�k���nډ�{�cJ����4>�t$n�����t"E���KCRt��S貾�ϒ����_�2���B˝_pp��w�(G�]��Y�N��vAc�
                  �D�������������y�C�Xe��;f+҅�if�%
```
