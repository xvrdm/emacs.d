
# Table of Contents

1.  [标题](#orgf64f6e9)
2.  [段落](#org3f66cf8)
3.  [字体](#org5ba01dd)
4.  [嵌入元数据](#org69713a5)
    1.  [内容元数据](#org03f369d)
    2.  [文档元数据](#orge5a3060)
5.  [列表](#org6d2dd36)
6.  [表格](#org63f5bb0)
7.  [<code>[80%]</code> 超链接](#org4cd84cb)
    1.  [其他链接](#org4be4fad)
8.  [代码块](#org5aaaebe):@待续:
9.  [org-mode](#orgd5f025b)
10. [大纲](#org13c81d7)
    1.  [定义一个标题](#org0266df6)
    2.  [大纲相关的快捷键](#org1adae8c)
    3.  [大纲间移动](#orgb7f368a)
    4.  [基于大纲的编辑](#orgdc45d97)
11. [字体](#org72c4cc8)
12. [段落](#org9269ebc)
13. [表格](#org6f0ae56)
    1.  [cell操作](#org3c5181c)
    2.  [创建和转换表格](#org084bc16)
    3.  [调整和区域移动](#org6aef44c)
    4.  [编辑行和列](#org2cf1206)
14. [列表](#orge77cb28)
    1.  [Org 能够识别有序列表、无序列表和描述列表。](#org5de6bfa)
    2.  [列表操作快捷键](#orgbe099ea)
    3.  [分割线](#orgd7b9f4c)

<a id="orgb2abd9e"></a>


<a id="orgf64f6e9"></a>

# 标题

文章中的标题可以通过 #+TITLE: 来设置标题

    #+TITLE: 神器中的神器org-mode之入门篇


<a id="org3f66cf8"></a>

# 段落

这里与我们想象的很不一样，再win下只要你Enter，就换行成为新的一段了。但是这里要开始新的段落需要回车两次，  
当你回车一次，当你发布时，只相当于中间有个空格而已。还有一种方法就是在需要空格的地方输入\\\\。 

    段落一
    
    段落二\\
    段落三


<a id="org5ba01dd"></a>

# 字体

    *粗体*
    /斜体/
    +删除线+
    _下划线_
    下标： H_2 O(这里必须留一个空格要不然2和O都成为小标，目前还不知道怎么去掉空格)
    上标： E=mc^2
    等宽字：  =git=

效果：  
**粗体**  
*斜体*  
<del>删除线</del>  
<span class="underline">下划线</span>  
下标： H<sub>2</sub> O(这里必须留一个空格要不然2和O都成为小标，目前还不知道怎么去掉空格)  
上标： E=mc<sup>2</sup>  
等宽字：  `git`


<a id="org69713a5"></a>

# 嵌入元数据


<a id="org03f369d"></a>

## 内容元数据

org-mode中有以下几种 

    s    #+begin_src ... #+end_src 
    e    #+begin_example ... #+end_example  : 单行的例子以冒号开头
    q    #+begin_quote ... #+end_quote      通常用于引用，与默认格式相比左右都会留出缩进
    v    #+begin_verse ... #+end_verse      默认内容不换行，需要留出空行才能换行
    c    #+begin_center ... #+end_center 
    l    #+begin_latex ... #+end_latex 
    L    #+latex: 
    h    #+begin_html ... #+end_html 
    H    #+html: 
    a    #+begin_ascii ... #+end_ascii 
    A    #+ascii: 
    i    #+index: line 
    I    #+include: line

-   代码

上面的单字母为快捷键字母，如输入一个<s 然后TAB后就变为：

    #+begin_src 
    
    #+end_src

怎么样，这样是不是就很方便了。 上面的代码我们还可以加入一些参数，如 

    #+begin_src c -n -t -h 7 -w 40
    
    #+end_src
    其中：
    c为所添加的语言
    -n 显示行号
    -t 清除格式
    -h 7 设置高度为7 -w 40设置宽度为40

-   注释

以‘#‘开头的行被看作注释，不会被导出区块注释采用如下写法： 

    #+BEGIN_COMMENT
      块注释
      ...
     #+END_COMMENT

-   表格与图片

对于表格和图片，可以在前面增加标题和标签的说明，以方便交叉引用。比如在表格的前面添加： 

    #+CAPTION: This is the caption for the next table (or link)

则在需要的地方可以通过 

    \ref{table1}

来引用表格

-   嵌入html

对于导出html以及发布，嵌入html代码就很有用。比如下面的例子适用于格式化为cnblogs的代码块： 

    #+BEGIN_HTML
      <div class="cnblogs_Highlighter">
      <pre class="brush:cpp">
      int main()
      {
        return 0;
      }
      </pre>
      </div>

相当于在cnblogs的网页编辑器中插入"c++"代码。 

-   包含文件

当导出文档时，你可以包含其他文件中的内容。比如，想包含你的“.emacs”文件，你可以用： 

    #+INCLUDE: "~/.emacs" src emacs-lisp

可选的第二个第三个参数是组织方式（例如，“quote”，“example”，或者“src”），如果是 “src”，语言用来格式化内容。  
组织方式是可选的，如果不给出，文本会被当作 Org 模式的正常处理。用 C-c ,可以访问包含的文件。 


<a id="orge5a3060"></a>

## 文档元数据

具体的内容可以到文档中查看：Export options 我们除了手动添加上面的元数据外，还可以用快捷键 C-c C-e t 插入选项，其中可能有些选项我们需要经常用到：
H: 	标题层数
num: 	章节(标题)是否自动编号
toc: 	是否生成索引
creator: 	是否生成 "creat by emacs…"
LINKUP: 	UP: 链接
LINKHOME: 	HEME: 链接


<a id="org6d2dd36"></a>

# 列表

-   选项1
-   选项2


<a id="org63f5bb0"></a>

# 表格

<table id="org9ab9a7d" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Name</th>
<th scope="col" class="org-right">Value</th>
<th scope="col" class="org-right">SD</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">T1</td>
<td class="org-right">1.2</td>
<td class="org-right">0.14</td>
</tr>


<tr>
<td class="org-left">T2</td>
<td class="org-right">2.3</td>
<td class="org-right">0.11</td>
</tr>
</tbody>
</table>


<a id="org4cd84cb"></a>

# STARTED <code>[80%]</code> 超链接


<a id="org4be4fad"></a>

## TODO 其他链接


<a id="org5aaaebe"></a>

# 代码块     :@待续:

    (setq-default tab-width 4) ;设置TAB宽度为4字符 


<a id="orgd5f025b"></a>

# org-mode

Org是一个基于快速高效的文本方式来实现做笔记、管理待办事项（TODO list）以及做项目计划的模式。
使用emacs做时间管理正是利用org-mode对文本的强大操作能力，所以我们首先要学习org-mode的基本概念及操作。


<a id="org13c81d7"></a>

# 大纲

org-mode强大的操作能力源于它对大纲的支持。


<a id="org0266df6"></a>

## 定义一个标题

要定义一个大纲，首先要定义标题，定义标题的方式非常简单，使用\*即可：
注意两点：

1.  \*要位于行首
2.  \*后面要有一个空格


<a id="org1adae8c"></a>

## 大纲相关的快捷键

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">功能</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">S-TAB</td>
<td class="org-left">循环切换整个文档的大纲状态（三种状态：折叠，打开下一级，打开全部）</td>
</tr>


<tr>
<td class="org-left">TAB</td>
<td class="org-left">循环切换光标所在大纲的状态</td>
</tr>
</tbody>
</table>


<a id="orgb7f368a"></a>

## 大纲间移动

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">功能</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">C-c C-n/p</td>
<td class="org-left">下/上一标题</td>
</tr>


<tr>
<td class="org-left">C-c C-f/b</td>
<td class="org-left">下/上一标题（仅限同级标题）</td>
</tr>


<tr>
<td class="org-left">C-c C-u</td>
<td class="org-left">跳到上一级标题</td>
</tr>


<tr>
<td class="org-left">C-c C-j</td>
<td class="org-left">切换到大纲浏览状态</td>
</tr>
</tbody>
</table>


<a id="orgdc45d97"></a>

## 基于大纲的编辑

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
<caption class="t-above"><span class="table-number">Table 1:</span> 大纲编辑快捷键</caption>

<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">功能</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">M-RET</td>
<td class="org-left">插入一个同级标题</td>
</tr>


<tr>
<td class="org-left">M-S-RET</td>
<td class="org-left">插入一个同级TODO 标题</td>
</tr>


<tr>
<td class="org-left">M-LEFT/RIGHT</td>
<td class="org-left">将当前标题升/降级</td>
</tr>


<tr>
<td class="org-left">M-S-LEFT/RIGHT</td>
<td class="org-left">将子树升/降级</td>
</tr>


<tr>
<td class="org-left">M-S-UP/DOWN</td>
<td class="org-left">将子树上/下移</td>
</tr>


<tr>
<td class="org-left">C-c \*</td>
<td class="org-left">将本行设为标题/正文</td>
</tr>


<tr>
<td class="org-left">C-c C-w</td>
<td class="org-left">将子树或区域移动到另一标题处（跨缓冲区）</td>
</tr>


<tr>
<td class="org-left">C-x n s/w</td>
<td class="org-left">只显示当前子树/返回</td>
</tr>


<tr>
<td class="org-left">C-c C-x b</td>
<td class="org-left">在新缓冲区显示当前分支（类似C-x n s)</td>
</tr>


<tr>
<td class="org-left">C-c /</td>
<td class="org-left">只列出包含搜索结果的大纲，并高亮，支持多种搜索方式</td>
</tr>


<tr>
<td class="org-left">C-c C-c</td>
<td class="org-left">取消高亮</td>
</tr>
</tbody>
</table>


<a id="org72c4cc8"></a>

# 字体

**粗体**
*斜体*
<del>删除线</del>
<span class="underline">下划线</span>
下标: H<sub>2</sub> O
上标: E=mc<sup>2</sup>
等宽字体 `git` 或者 `git`


<a id="org9269ebc"></a>

# 段落

对于单个回车换行的文本，认为其属于同一个段落。在导出的时候将会转化为不换行的同一段。如果要新起一个段落，需要留出一个空行。 这点与markdown类似。


<a id="org6f0ae56"></a>

# 表格

Org 能够很容易地处理 ASCII 文本表格。任何以‘|’为首个非空字符的行都会被认为是表格的一部分。’|‘也是列分隔符。一个表格是下面的样子：

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Name</th>
<th scope="col" class="org-right">Pone</th>
<th scope="col" class="org-right">Age</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">Peter</td>
<td class="org-right">1234</td>
<td class="org-right">17</td>
</tr>


<tr>
<td class="org-left">Anna</td>
<td class="org-right">4312</td>
<td class="org-right">25</td>
</tr>
</tbody>
</table>

你可能认为要录入这样的表格很繁琐，实际上你只需要输入表头“|Name|Pone|Age”之后，按C-c RET,就可以生成整个表格的结构。类似的快捷键还有很多：

**注意：**
有时候，列的内容特别长，影响到emacs编辑table的时候视觉对齐效果，可以通过增加一行，专门指定各列的宽度。超出宽度的部分会用=>表示. 
如果想看到全部值，需要鼠标移动到该字段会出现文本提示信息。如果想要编辑，需要按下C-c \` ，会打开另一个buffer让你编辑, 用C-c C-c提交编辑内容。
还可以指定列中的文字对齐方式，沿用前面限定宽度的方式，不过需要添加r,c,l字符分别表示右、中和左对齐。这样会改变导出到html table的对齐方式。

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />

<col  class="org-right" />

<col  class="org-center" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right">Name</th>
<th scope="col" class="org-right">Pone</th>
<th scope="col" class="org-center">Age</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-right">Peter</td>
<td class="org-right">1234</td>
<td class="org-center">17</td>
</tr>


<tr>
<td class="org-right">Anna</td>
<td class="org-right">4312</td>
<td class="org-center">25</td>
</tr>
</tbody>
</table>


<a id="org3c5181c"></a>

## cell操作

删除cell文本
C-c SPC
跳到开头或者结尾
M-a 和 M-e

将上一行Cell的文本复制到下一行
S-Enter 可以将上一行cell的数据复制到当前空白的cell中, 
如果是数字自动增加1。 光标可以在上一行的cell,也可以在下一行空白cell中，都一样。
注意,如果文本中有小数点就不行了,因此IP地址是不能这样复制的

添加 | 字符
由于 | 用于表示Field分割符号，如果一个字段里面要显示 | , 需要使用转义字符：&vert;,  
如果要在一个字符串内部加上 | , 需要类似 abc&vert;def, 会显示abc|def


<a id="org084bc16"></a>

## 创建和转换表格

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">说明</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">C-c 竖线</td>
<td class="org-left">创建或转换表格</td>
</tr>
</tbody>
</table>


<a id="org6aef44c"></a>

## 调整和区域移动

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">说明</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">C-c C-c</td>
<td class="org-left">调整表格，不移动光标</td>
</tr>


<tr>
<td class="org-left">TAB</td>
<td class="org-left">移动到下一区域，必要时新建一行</td>
</tr>


<tr>
<td class="org-left">S-TAB</td>
<td class="org-left">移动到上一区域</td>
</tr>


<tr>
<td class="org-left">RET</td>
<td class="org-left">移动到下一行，必要时新建一行</td>
</tr>
</tbody>
</table>


<a id="org2cf1206"></a>

## 编辑行和列

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">说明</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">M-LEFT/RIGHT</td>
<td class="org-left">移动列</td>
</tr>


<tr>
<td class="org-left">M-UP/DOWN</td>
<td class="org-left">移动行</td>
</tr>


<tr>
<td class="org-left">M-S-LEFT/RIGHT</td>
<td class="org-left">删除/插入列</td>
</tr>


<tr>
<td class="org-left">M-S-UP/DOWN</td>
<td class="org-left">删除/插入行</td>
</tr>


<tr>
<td class="org-left">C-c -</td>
<td class="org-left">添加水平分割线</td>
</tr>


<tr>
<td class="org-left">C-c RET</td>
<td class="org-left">添加水平分割线并跳到下一行</td>
</tr>


<tr>
<td class="org-left">C-c ^</td>
<td class="org-left">根据当前列排序，可以选择排序方式</td>
</tr>
</tbody>
</table>


<a id="orge77cb28"></a>

# 列表


<a id="org5de6bfa"></a>

## Org 能够识别有序列表、无序列表和描述列表。

1.  无序列表项以‘-’、‘+’或者‘\*‘开头。
2.  有序列表项以‘1.’或者‘1)’开头。
3.  描述列表用‘::’将项和描述分开。
4.  有序列表和无序列表都以缩进表示层级。只要对齐缩进，不管是换行还是分块都认为是处于当前列表项。

同一列表中的项的第一行必须缩进相同程度。当下一行的缩进与列表项的的开头的符号或者数字相同或者更小时，这一项就结束了。当所有的项都关上时，或者后面有两个空行 时，列表就结束了。例如：
My favorite scenes are (in this order)

1.  The attack of the Rohirrim
2.  Eowyn's fight with the witch king
    -   this was already my favorite scene in the book
    -   I really like Miranda Otto.

Important actors in this film are:

-   **Elijah Wood:** He plays Frodo
-   **Sean Austin:** He plays Sam, Frodo's friend.


<a id="orgbe099ea"></a>

## 列表操作快捷键

为了便利，org-mode也支持很多列表操作的快捷键，大部分都与大纲的快捷键类似：

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">快捷键</th>
<th scope="col" class="org-left">说明</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">TAB</td>
<td class="org-left">折叠列表项</td>
</tr>


<tr>
<td class="org-left">M-RET</td>
<td class="org-left">插入项</td>
</tr>


<tr>
<td class="org-left">M-S-RET</td>
<td class="org-left">插入带复选框的项</td>
</tr>


<tr>
<td class="org-left">M-S-UP/DOWN</td>
<td class="org-left">移动列表项</td>
</tr>


<tr>
<td class="org-left">M-LEFT/RIGHT</td>
<td class="org-left">升/降级列表项，不包括子项</td>
</tr>


<tr>
<td class="org-left">M-S-LEFT/RIGTH</td>
<td class="org-left">M-S-LEFT/RIGTH</td>
</tr>


<tr>
<td class="org-left">C-c C-c</td>
<td class="org-left">改变复选框状态</td>
</tr>


<tr>
<td class="org-left">C-c -</td>
<td class="org-left">更换列表标记（循环切换）</td>
</tr>
</tbody>
</table>


<a id="orgd7b9f4c"></a>

## 分割线

五条短线或以上显示为分隔线。

---

<span class="timestamp-wrapper"><span class="timestamp">&lt;2019-03-26 周二&gt;</span></span>

