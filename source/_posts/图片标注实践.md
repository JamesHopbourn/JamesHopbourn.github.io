---
title: 图片标注实践
date: 2019-11-02 11:00:00
tags: OmniGraffle
---

绘图一直以来都是我的弱项，为了弥补这一弱点，在 @scomper 的博客上学习了 OmniGraffle 之后也能做出一张质量上还算及格的图片，本文将用一个我目前做过最复杂的例子来概括一下一些常用的操作。

<!-- more -->

首先，明确需求：在《信息管理收集系统构架思路》一文中有一段话如下：

> 和以往一样，能用键盘解决，就不麻烦到鼠标。于是再次派上 AppleScript + Keyboard Maestro，由于 Bear 官方有 Safari 扩展，所需我们也就无需再去添加 JavaScript 书签了。此处的 AppleScript 代码需要根据你扩展插件摆放的位置自行进行微调。如下图所示：
那么由这段话推出需要配的示例图上应该有以下几个元素：

1. AppleScript 代码
2. Bear 扩展的图标
3. 用数字把扩展插件摆放位置做一个直观的表现

## 本文将会带你达成的目标：
1. 使用 Snagit 或者 Snipaste 进行窗口截图
2. 使用 Snipaste 的钉板功能将图片钉在窗口上
3. 使用 Snagit 进行快速高效的数字标注
4. 使用系统的预览软件删除多余的元素
5. 使用 OmniGraffle 给文本添加高亮
6. 使用 OmniGraffle 连线工具链接两个元素
7. 使用 OmniGraffle 的掩模功能使用图片裁剪

## 软件支持：
1. Snagit 或者 Snipaste：用于局部窗口精确截取以及图片粘贴。
2. 系统自带的预览：用于删除图片多余的元素。
3. Snagit 或者 OmniGraffle：用于给 Safari 扩展添加数字标签。
4. Snagit 或者 OmniGraffle：用于标注。

我的配置：Snagit + Snipaste + 预览 + OmniGraffle。

操作：首先使用 Snagit 在 Keyboard Maestro 窗口中进行截图，本以为可以直接把代码那个窗口截取出来，结果发现最小的窗口只能在动作的区域，所以不得已截取了动作的完整窗口。
![](/media/AppleScriptSafari/1局部截图.png)

那么既然已经截取了这样一个完整的窗口，含有其他多余的元素，就需要使用到系统自带的预览删除这些多余元素。将截图保存下来并使用预览打开。
![](/media/AppleScriptSafari/2删除多余.png)

用鼠标拖动，将多余部分用虚线框框起来，然后按下 delete 回车删除多余元素，对上面分别进行如此操作。
![](/media/AppleScriptSafari/3删除白边.png)

现在上下两部分的多余元素均已被删除干净，还需要将旁边的白边去掉。打开图片编辑工具，选择「即时 Alpha」功能，将外围白边圈起来再次按下 delete 删除，保存最后 command + C 将这张图片复制到剪切板。
![](/media/AppleScriptSafari/4.0粘贴边框.png)

打开 Safari 浏览器，按下 Snipaste 的默认粘贴键：fn + F3 即可把剪切板里面的图片钉在当前的屏幕上，但是此时你会发现旁边有两条黑线，在图片上右键将「Shadow」取消勾选即可实现边缘完全透明。

效果如下图所示，此时你可以单击一下钉住的图片然后使用触控板双指上下滑动可以调整图片的大小并拖动到合适的位置，最后按下 command + shift + 4 进行截屏。
![](/media/AppleScriptSafari/5图片钉住.jpg)

将图片导入 Snagit 进行序号标注，使用 Snagit 进行图片标注的优点就是数字会自动递增，不用一个个编辑过去，更加高效一点。记得使用参考线进行对齐，可以做出更美观的效果。
![](/media/AppleScriptSafari/6扩展序号.png)

数字标注完成后选择右上角的 Copy All 复制到剪切板。
![](/media/AppleScriptSafari/7参考对齐.jpg)

然后打开 OmniGraffle 粘贴一下开始进行下一步编辑，使用矩形框工具在「group 8」上面画上一个高亮的框框，我的设置如下：

纯色填充，颜色使用柠檬黄
填充选项使用「乘」
取消掉矩形边框的描边，形状选择矩形
![](/media/AppleScriptSafari/8边框编辑.jpg)

接下来，再次使用矩形工具在数字 8 下面画出一个非常小的矩形，如图所示
![](/media/AppleScriptSafari/9透明矩形.png)

参数设定：使用白色填充并且将不透明度设置为 0，取消描边。

使用连线工具（默认按键是 3 ）链接这两个矩形框，参数设置：

线条宽度：5
颜色：keyboardFocusIndicatorColor
线条：弯曲并使用一个箭头
![](/media/AppleScriptSafari/10连接元素.png)

点击透明边框，调整一下合适的位置，我是强迫症，要做就一定做的完美。调整到下面的正中间位置（可以使用键盘上的上下左右进行调整）。
![](/media/AppleScriptSafari/11调整位置.png)

终于完成了标注工作，可是这样一张图片直接放在文章里面会有一个问题：我想体现的元素都在上面一部分，跟下面一点关系都没有，这张图片的下半部分完全就是多余的，所以我们还需要对它进行裁剪一下。
![](/media/AppleScriptSafari/14标注完成.jpg)

点击图片，右键选择「掩模图像」。
![](/media/AppleScriptSafari/15裁剪局部.jpg)

调整边角上的小正方形进行裁剪图片，这里只需要截取上半部分即可。选择好后点击一下旁边的空白区域即可推出掩模图像功能。
![](/media/AppleScriptSafari/16掩模图像.jpg)

使用 command + shift +G 合并图层中的所有元素，比如说我们画的两个矩形和一条曲线，然后 command + A 全选，接着右键选择拷贝为 PNG。
![](/media/AppleScriptSafari/17全部导出.jpg)

随便找个聊天窗口粘贴图片，然后右键选择导出，经过十八个步骤终于弄出来一张满意的成品图......


导出图片
示例图迭代：
![](/AppleScriptSafari/原图.jpg)
缺点：
1. 使用圆圈数字标注没有上面的效果优秀
2. 采用了橘色标注，导致「group 8」这几个字符有点要被深色掩盖了
3. 线条没有连接到数字 8 的正下方
4. AppleScript 代码有白边

![](/media/AppleScriptSafari/二图.jpg)
缺点：
1. 使用黄底白字，导致数字根本无法看清，根本无法起到标注的效果
2. 线条使用了橙色，在这种情况下不是非常适合。

![](/media/AppleScriptSafari/19成品图片.png)
优点：
1. 使用黑底白字，数字标注非常显眼，一目了然
2. 线条使用了蓝色并稍微增大了宽度，更加饱满
3. 代码边缘没有白边，非常干净。
4. 使用柠檬黄标注「group 8」字符，非常显眼，能够一下子抓住读者的眼球。

好的设计都不是一次完成的，而是经历过不断的迭代、更新最后精心打磨出来的成品，正如我所写的《信息管理收集系统构架思路》一文，也是我这半年来各种想法的总结、整理。

推荐：@scomper 的 OmniGraffle 的教程《用 OmniGraffle 画一个精美的图示》在少数派上可以进行试读、订阅。这个圈子里面如果要问说谁做图是最优秀的我心中的答案非 scomper 莫属，你可以在这里浏览他曾经做过的各种示例图：http://scomper.me/diagram/