---
title: i++ 和 ++i 区别
date: 2020-12-30 21:40
tags: C语言
categories:
---

以汇编的角度来看 i++ 和 ++i 区别

<!-- more -->

### 工具版本
```
➜ gcc --version
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/4.2.1
Apple clang version 12.0.0 (clang-1200.0.32.28)
Target: x86_64-apple-darwin19.6.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

➜ objdump --version
GNU objdump (GNU Binutils) 2.35.1
Copyright (C) 2020 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) any later version.
This program has absolutely no warranty.

➜ sed --version
sed (GNU sed) 4.8
Copyright (C) 2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Jay Fenlason, Tom Lord, Ken Pizzini,
Paolo Bonzini, Jim Meyering, and Assaf Gordon.

This sed program was built without SELinux support.

GNU sed home page: <https://www.gnu.org/software/sed/>.
General help using GNU software: <https://www.gnu.org/gethelp/>.
E-mail bug reports to: <bug-sed@gnu.org>.

➜ awk --version
GNU Awk 5.1.0, API: 3.0 (GNU MPFR 4.1.0, GNU MP 6.2.1)
Copyright (C) 1989, 1991-2020 Free Software Foundation.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.
```

### 初次小试：i++
```
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
int main(){
	int i = 1;
	++i;
}
```
```
pbpaste > ++i.c && gcc ++i.c -o ++i && objdump -d -j .text -M intel ++i|gsed '1,7d ; s/^.\{36\}//'|awk '{printf("%02d %s\n", NR, $0)}'

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
int main(){
	int i = 1;
	i = ++i;
}
```
```
pbpaste > ++i.c && gcc ++i.c -o ++i && objdump -d -j .text -M intel ++i|gsed '1,7d ; s/^.\{36\}//'|awk '{printf("%02d %s\n", NR, $0)}'

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
i++ 相比较于 ++i 多了 `06 mov    edx,ecx`，常量 `1` 先赋值给 `[rbp-0x4]` 传递给 `ecx`，`ecx` 再赋值给 `edx`，实际操作是对 `edx` 操作。操作之后看似赋值给了 `[rbp-0x4]` 但是因为 `ecx` 的覆盖导致 `i` 数值不变。
++i 是将常量 `1` 先赋值给 `[rbp-0x4]` 传递给 `ecx`，然后直接对 `ecx` 操作并赋值回 `[rbp-0x4]`

### 参考文章
[用这个工具看了i++和++i的汇编代码，小白也能明白它们的区别](https://mp.weixin.qq.com/s/d2TKnw3PYzs2KuFGjkNKoQ)  