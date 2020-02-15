---
title: pandoc 中文支持
subtitle: 《纽约时报》赫本最佳传记
date: 2020-02-14 22:30
tags: pandoc
categories:
---

使用 -V mainfont 参数提供中文支持 
```
pandoc Hepburn.md --pdf-engine=xelatex -V mainfont='Songti SC' -o Hepburn.pdf
```

<!-- more -->

安装 fontconfig
```
brew install fontconfig
```

查看系统已安装的中文支持
```
➜ fc-list :lang=zh-cn
......
/System/Library/Fonts/Supplemental/Songti.ttc: Songti SC,宋體\-簡,宋体\-简:style=Light,細體,细体
/System/Library/Fonts/Supplemental/Songti.ttc: Songti TC,宋體\-繁,宋体\-繁:style=Regular,標準體,常规体
/System/Library/Fonts/Supplemental/Songti.ttc: Songti SC,宋體\-簡,宋体\-简:style=Regular,標準體,常规体
/System/Library/Fonts/PingFang.ttc: .PingFang SC,.蘋方\-簡,.苹方\-简:style=Medium,中黑體,中黑体
/System/Library/Fonts/Supplemental/Songti.ttc: Songti TC,宋體\-繁,宋体\-繁:style=Light,細體,细体
/System/Library/Fonts/PingFang.ttc: .PingFang SC,.蘋方\-簡,.苹方\-简:style=Semibold,中粗體,中粗体
......
```

编辑 Markdown 文本
```
➜ vim Hepburn.md 
---
title: 奥黛丽·赫本
author: 唐纳德·斯伯特
date: January 5, 2020
---

# 第一章：爸爸去哪儿了
# 第二章：战火中起舞
# 第三章：星光乍现
# 第四章：百老汇的金粉世界
# 第五章：公主或新娘
# 第六章：迷人的精灵
# 第七章：崩溃的边缘
# 第八章：甜姐儿童话
```

生成 PDF
```
pandoc Hepburn.md --pdf-engine=xelatex -V mainfont='Songti SC' -o Hepburn.pdf
```

![](/media/200214Hepburn.png)
