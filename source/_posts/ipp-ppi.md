---
title: i++ 和 ++i 区别
date: 2020-12-30 21:40
tags: C语言
categories:
---

以汇编的角度来看 i++ 和 ++i 区别

<!-- more -->

### 初次小试：i++
```
#include <stdio.h>

int main(){
	int i = 1;
	i++;
}
```
```
pbpaste > i++.c && gcc i++.c -o i++ && objdump -d -j .text -M intel i++|gsed '1,7d ; s/^.\{36\}//'|awk '{printf("%02d %s\n", NR, $0)}'
01 push   rbp
02 mov    rbp,rsp
03 xor    eax,eax
04 mov    DWORD PTR [rbp-0x4],0x1
05 mov    ecx,DWORD PTR [rbp-0x4]
06 add    ecx,0x1
07 mov    DWORD PTR [rbp-0x4],ecx
08 pop    rbp
09 ret
```

### 初次小试：++i
```
#include <stdio.h>

int main(){
	int i = 1;
	++i;
}
```
```
pbpaste > ++i.c && gcc ++i.c -o ++i &&objdump -d -j .text -M intel ++i|gsed '1,7d ; s/^.\{36\}//'|awk '{printf("%02d %s\n", NR, $0)}'
01 push   rbp
02 mov    rbp,rsp
03 xor    eax,eax
04 mov    DWORD PTR [rbp-0x4],0x1
05 mov    ecx,DWORD PTR [rbp-0x4]
06 add    ecx,0x1
07 mov    DWORD PTR [rbp-0x4],ecx
08 pop    rbp
09 ret
```

### 修改再试：i++
```
#include <stdio.h>

int main(){
	int i = 1;
	i = i++;
}
```
```
pbpaste > i++.c && gcc i++.c -o i++ && objdump -d -j .text -M intel i++|gsed '1,7d ; s/^.\{36\}//'|awk '{printf("%02d %s\n", NR, $0)}'
01 push   rbp
02 mov    rbp,rsp
03 xor    eax,eax
04 mov    DWORD PTR [rbp-0x4],0x1
05 mov    ecx,DWORD PTR [rbp-0x4]
06 mov    edx,ecx
07 add    edx,0x1
08 mov    DWORD PTR [rbp-0x4],edx
09 mov    DWORD PTR [rbp-0x4],ecx
10 pop    rbp
11 ret
```

### 再次小试：++i
```
#include <stdio.h>

int main(){
	int i = 1;
	i = ++i;
}
```
```
pbpaste > ++i.c && gcc ++i.c -o ++i &&objdump -d -j .text -M intel ++i|gsed '1,7d ; s/^.\{36\}//'|awk '{printf("%02d %s\n", NR, $0)}'
01 push   rbp
02 mov    rbp,rsp
03 xor    eax,eax
04 mov    DWORD PTR [rbp-0x4],0x1
05 mov    ecx,DWORD PTR [rbp-0x4]
06 add    ecx,0x1
07 mov    DWORD PTR [rbp-0x4],ecx
08 mov    DWORD PTR [rbp-0x4],ecx
09 pop    rbp
10 ret
```

### 结论
i++ 相比较于 ++i 多了 06 `mov    edx,ecx`，常量 1 先赋值给 [rbp-0x4] 传递给 ecx，ecx 再赋值给 edx，实际操作是对 edx 操作。操作之后看似赋值给了 [rbp-0x4] 但是因为 ecx 的覆盖导致 i 数值不变。
++i 是将常量 1 先赋值给 [rbp-0x4] 传递给 ecx，然后直接对 ecx 操作并赋值回 [rbp-0x4]

### 参考文章
[用这个工具看了i++和++i的汇编代码，小白也能明白它们的区别](https://mp.weixin.qq.com/s/d2TKnw3PYzs2KuFGjkNKoQ)  