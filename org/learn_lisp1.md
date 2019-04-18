
# Table of Contents

1.  [learn function](#org6fb923c)
    1.  [symbol #' and symbol-value symbol-function](#orgff946c1)
    2.  [function call](#orge0ad07e)
    3.  [#' mapcar](#org42c5396)
    4.  [lambda](#org883353d)
2.  [learn variable](#orga3111e6)
    1.  [setq and defvar](#org52ec03f)
    2.  [let and let\*](#orgf636a5b)
3.  [控制结构](#orga76a298)
    1.  [progn](#org089ce32)
    2.  [if 和 cond](#org135a3b8)
    3.  [while](#orgb9c33de)
4.  [逻辑运算](#org29f765c)
5.  [函数列表](#org132f2f3)
6.  [基本数据类型](#org8cd33ba)
    1.  [函数列表](#org311a364)
    2.  [变量列表](#orgdcd6801)
7.  [字符和字符串](#org2cdba58)
    1.  [测试函数](#org409a318)
    2.  [函数列表](#org02dbba2)
8.  [cons cell 和列表](#orgfbaf88f)
    1.  [测试函数](#org96aea9c)
    2.  [构造函数](#orgc49d7a1)
    3.  [属性列表（property list，plist）](#orge0e029a)



<a id="org6fb923c"></a>

# learn function


<a id="orgff946c1"></a>

## symbol #' and symbol-value symbol-function

    (defun double(x) (* x 2))
    (double 1)
    (equal #'double (car (list #'double)))
    ((lambda(x) (* x 2)) 3)
    (setq double 2)
    (symbol-value 'double)
    (symbol-function 'double)
    (setq fun1 #'double)
    (setq x #'append)
    (equal (symbol-value 'x) (symbol-function 'append))
    (setf (symbol-function #'double) #'(lambda(x) (* x 3)))
    (double 3)


<a id="orge0ad07e"></a>

## function call

下面几个函数调用都是相同的作用，调用了函数+

    (+ 1 2)
    (apply #'+ '(1 2))
    (apply (symbol-function '+) '(1 2))
    (apply #'(lambda(x y) (+ x y)) '(1 2))
    (apply #'+ 1 '(2))
    (funcall #'* 1 2)


<a id="org42c5396"></a>

## #' mapcar

    (mapcar #'(lambda(x) (+ x 10)) '(1 2 3))
    (mapcar #'+
            '(1 2 3)
            '(10 100 1000))
    
    (sort '(1 4 2 5 7 3) #'<)
    (apply #'< (sort '(1 5 2 3 7) #'<))
    
    (remove-if #'evenp '(1 2 3 4 5 6 7))
    
    (defun our-remove-if(fn lst)
    (if (null lst)
        nil
        (if (funcall fn (car lst))
            (our-remove-if fn (cdr lst))
        (cons (car lst) (our-remove-if fn (cdr lst))))))
    (our-remove-if #'evenp '(1 3 4 5 2))

    (setq org-src-fontify-natively t)
    (w32-version)


<a id="org883353d"></a>

## lambda

用funcall调用lambda表达式，还可以把lambda赋给一个变量然后在用funcall调用

    (funcall (lambda(name) (message "Hello %s!" name)) "Emacs")
    (funcall #'(lambda(name) (message "Hello %s!" name)) "Emacs")
    (setq foo (lambda(name) (message "Hello %s!" name)))
    (setq foo #'(lambda(name) (message "Hello %s!" name)))
    (funcall foo "Emacs")


<a id="orga3111e6"></a>

# learn variable


<a id="org52ec03f"></a>

## setq and defvar

defvar 与 setq 所不同的是，如果变量在声明之前，这个变量已经有一个值的话， 用 defvar 
声明的变量值不会改变成声明的那个值。另一个区别是 defvar 可以为变量提供文档字符串， 
当变量是在文件中定义的话，C-h v 后能给出变量定义的位置。

    (setq foo "I am foo")
    (defvar foo "Did I have a value?"
     "A demo variable")


<a id="orgf636a5b"></a>

## let and let\*

如果没有局部作用域的变量，都使用全局变量，函数会相当难写。elisp 里可以用 let 和 let\* 进行局部变量的绑定。let 使用的形式是：
(let (bindings) body) bingdings 可以是 (var value) 这样对 var 赋初始值的形式，或者用 var 声明一个初始值为 nil 的变量

    (defun circle-area(radix)
      (let ((pi 3.1415926) area)
        (setq area (* pi radix radix))
        (message "直径为 %.2f 的圆的面积是 %.2f" radix area)))
    (circle-area 3)
    ;; let* 和 let 的使用形式完全相同，唯一的区别是在 let* 声明中就能使用前面声明的变量
    (defun circle-area2(radix)
      (let* ((pi 3.1415926) (area (* pi radix radix)))
      (message "直径为 %.2f 的圆的面积是 %.2f" radix area)))
    (circle-area2 3)


<a id="orga76a298"></a>

# 控制结构


<a id="org089ce32"></a>

## progn

    (progn (setq foo 3) (message "foo set to 3"))


<a id="org135a3b8"></a>

## if 和 cond

    (if condition
      then
     else)
    
    (cond (case1 do-when-case1)
    (case2 do-when-case2)
    ...
    (t do-when-none-meet))

还有两个宏 when 和 unless，从它们的名字也就能知道它们是作什么用的。
使用这两个宏的好处是使代码可读性提高，when 能省去 if 里的 progn 结构，unless 省去条件为真子句需要的的 nil 表达式。


<a id="orgb9c33de"></a>

## while

    (while condition
      body)


<a id="org29f765c"></a>

# 逻辑运算

条件的逻辑运算和其它语言都是很类似的， 使用 and、or、not。and 和 or 也同样具有短路性质。
很多人喜欢在表达式短时，用 and 代替 when，or 代替 unless。 
当然这时一般不关心它们的返回值，而是在于表达式其它子句的副作用。 比如 or 经常用于设置函数的缺省值，而 and 常用于参数检查：

    (defun hello-world(&optional name)
      (or name (setq name "Emacs"))
      (message "Hello %s!" name))
    (hello-world)
    (hello-world "Elisp")


<a id="org132f2f3"></a>

# 函数列表

    (defun NAME ARGLIST [DOCSTRING] BODY...)
    (defvar SYMBOL &optional INITVALUE DOCSTRING)
    (setq SYM VAL SYM VAL ...)
    (let VARLIST BODY...)
    (let* VARLIST BODY...)
    (lambda ARGS [DOCSTRING] [INTERACTIVE] BODY)
    (progn BODY ...)
    (if COND THEN ELSE...)
    (cond CLAUSES...)
    (when COND BODY ...)
    (unless COND BODY ...)
    (when COND BODY ...)
    (or CONDITIONS ...)
    (and CONDITIONS ...)
    (not OBJECT)


<a id="org8cd33ba"></a>

# 基本数据类型


<a id="org311a364"></a>

## 函数列表

    ;; 测试函数
    (integerp OBJECT)
    (floatp OBJECT)
    (numberp OBJECT)
    (zerop NUMBER)
    (wholenump OBJECT)
    ;; 比较函数
    (> NUM1 NUM2)
    (< NUM1 NUM2)
    (>= NUM1 NUM2)
    (<= NUM1 NUM2)
    (= NUM1 NUM2)
    (eql OBJ1 OBJ2)
    (/= NUM1 NUM2)
    ;; 转换函数
    (float ARG)
    (truncate ARG &optional DIVISOR)
    (floor ARG &optional DIVISOR)
    (ceiling ARG &optional DIVISOR)
    (round ARG &optional DIVISOR)
    ;; 运算
    (+ &rest NUMBERS-OR-MARKERS)
    (- &optional NUMBER-OR-MARKER &rest MORE-NUMBERS-OR-MARKERS)
    (* &rest NUMBERS-OR-MARKERS)
    (/ DIVIDEND DIVISOR &rest DIVISORS)
    (1+ NUMBER)
    (1- NUMBER)
    (abs ARG)
    (% X Y)
    (mod X Y)
    (sin ARG)
    (cos ARG)
    (tan ARG)
    (asin ARG)
    (acos ARG)
    (atan Y &optional X)
    (sqrt ARG)
    (exp ARG)
    (expt ARG1 ARG2)
    (log ARG &optional BASE)
    (log10 ARG)
    (logb ARG)
    ;; 随机数
    (random &optional N)


<a id="orgdcd6801"></a>

## 变量列表

    most-positive-fixnum
    most-negative-fixnum


<a id="org2cdba58"></a>

# 字符和字符串

<http://www.woola.net/detail/2016-08-23-elisp-string.html>


<a id="org409a318"></a>

## 测试函数

字符串测试使用 stringp，没有 charp，因为字符就是整数。 string-or-null-p 当对象是一个字符或 
nil 时返回 t。 char-or-string-p 测试是否是字符串或者字符类型。
比较头疼的是 emacs 没有测试字符串是否为空的函数。这是我用的这个测试函数，使用前要测试字符串是否为 nil：

    (defun string-emptyp(str)
      (not (string< "" str)))


<a id="org02dbba2"></a>

## 函数列表

<http://www.woola.net/detail/2016-08-23-elisp-string.html>

    ;; 测试函数
    (stringp OBJECT)
    (string-or-null-p OBJECT)
    (char-or-string-p OBJECT)
    ;; 构建函数
    (make-string LENGTH INIT)
    (string &rest CHARACTERS)
    (substring STRING FROM &optional TO)
    (concat &rest SEQUENCES)
    ;; 比较函数
    (char-equal C1 C2)
    (string= S1 S2)
    (string-equal S1 S2)
    (string< S1 S2)
    ;; 转换函数
    (char-to-string CHAR)
    (string-to-char STRING)
    (number-to-string NUMBER)
    (string-to-number STRING &optional BASE)
    (downcase OBJ)
    (upcase OBJ)
    (capitalize OBJ)
    (upcase-initials OBJ)
    (format STRING &rest OBJECTS)
    ;; 查找与替换
    (string-match REGEXP STRING &optional START)
    (replace-match NEWTEXT &optional FIXEDCASE LITERAL STRING SUBEXP)
    (replace-regexp-in-string REGEXP REP STRING &optional FIXEDCASE LITERAL SUBEXP START)
    (subst-char-in-string FROMCHAR TOCHAR STRING &optional INPLACE)


<a id="orgfbaf88f"></a>

# cons cell 和列表

<http://www.woola.net/detail/2016-08-23-elisp-cons-cell.html>

如果从概念上来说，cons cell 其实非常简单的，就是两个有顺序的元素。第一个叫 CAR，第二个就 CDR。CAR 和 CDR 
名字来自于 Lisp。它最初在IBM 704机器上的实现。在这种机器有一种取址模式，使人可以访问一个存储地址中的
“地址（address）”部分和“减量（decrement）”部分。CAR 指令用于取出地址部分，表示(Contents of Address part of Register)，
CDR 指令用于取出地址的减量部分(Contents of the Decrement part of Register)。cons cell 也就是 construction of 
cells。car 函数用于取得 cons cell 的 CAR 部分，cdr 取得cons cell 的 CDR 部分。cons cell 如此简单，但是它却能衍生出许多高级的数据结构，
比如链表，树，关联表等等。

cons cell 的读入语法是用 . 分开两个部分，比如：

    '(1 . 2)                                ; => (1 . 2)
    '(?a . 1)                               ; => (97 . 1)
    '(1 . "a")                              ; => (1 . "a")
    '(1 . nil)                              ; => (1)
    '(nil . nil)                            ; => (nil)

注意到前面的表达式中都有一个 ' 号，这是什么意思呢？其实理解了 eval-last-sexp 的作用就能明白了。eval-last-sexp 
其实包含了两个步骤，一是读入前一个 S-表达式，二是对读入的 S-表达式求值。这样如果读入的 S-表达式是一个 cons cell 的话，
求值时会把这个 cons cell 的第一个元素作为一个函数来调用。而事实上，前面这些例子的第一个元素都不是一个函数，这样就会产生一个错误 
invalid-function。之所以前面没有遇到这个问题，那是因为前面数字和字符串是一类特殊的 S-表达式，它们求值后和求值前是不变，
称为自求值表达式（self-evaluating form）。' 号其实是一个特殊的函数 quote，它的作用是将它的参数返回而不作求值。'(1 . 2) 等价于 
(quote (1 . 2))。为了证明 cons cell 的读入语法确实就是它的输出形式，可以看下面这个语句：

    (read "(1 . 2)")                        ; => (1 . 2)

列表包括了 cons cell。但是列表中有一个特殊的元素──空表 nil。

    nil                                     ; => nil
    '()                                     ; => nil

**注意**
按列表最后一个 cons cell 的 CDR 部分的类型分，可以把列表分为三类。

1.  如果它是 nil 的话，这个列表也称为“真列表”(true list)。
2.  如果既不是 nil 也不是一个 cons cell，则这个列表称为“点列表”(dotted list)。
3.  还有一种可能，它指向列表中之前的一个 cons cell， 则称为环形列表(circular list)。

这里分别给出一个例子：

    '(1 2 3)                                  ; => (1 2 3) cdr->nil
    '(1 2 . 3)                                ; => (1 2 . 3) cdr-> 3, 是不nil也不是cons cell
    '(1 . #1=(2 3 . #1#))                     ; => (1 2 3 . #1) cdr->指向之前的一个cons cell

从这个例子可以看出前两种列表的读入语法和输出形式都是相同的，而环形列表的读入语法是很古怪的，输出形式不能作为环形列表的读入形式。

如果把真列表最后一个 cons cell 的 nil 省略不写，也就是 (1 . nil) 简写成 (1)，把 ( obj1 . ( obj2 . list)) 
简写成 (obj1 obj2 . list)，那么列表最后可以写成一个用括号括起的元素列表：

    '(1 . (2 . (3 . nil)))                  ; => (1 2 3)

尽管这样写是清爽多了，但是，我觉得看一个列表时还是在脑子里反映的前面的形式，这样在和复杂的 cons cell 打交道时就不会搞不清楚这个 
cons cell 的 CDR 是一个列表呢，还是一个元素或者是嵌套的列表。


<a id="org96aea9c"></a>

## 测试函数

测试一个对象是否是 cons cell 用 consp，是否是列表用 listp。

    (consp '(1 . 2))                        ; => t
    (consp '(1 . (2 . nil)))                ; => t
    (consp nil)                             ; => nil
    (listp '(1 . 2))                        ; => t
    (listp '(1 . (2 . nil)))                ; => t
    (listp nil)                             ; => t

没有内建的方法测试一个列表是不是一个真列表。通常如果一个函数需要一个真列表作为参数，都是在运行时发出错误，而不是进行参数检查，因为检查一个列表是真列表的代价比较高。
测试一个对象是否是 nil 用 null 函数。只有当对象是空表时，null 才返回空值。


<a id="orgc49d7a1"></a>

## 构造函数

生成一个 cons cell 可以用 cons 函数。比如：

    (cons 1 2)                              ; => (1 . 2)
    (cons 1 '())                            ; => (1)

也是在列表前面增加元素的方法。比如：

    (setq foo '(a b))                       ; => (a b)
    (cons 'x foo)                           ; => (x a b)

值得注意的是前面这个例子的 foo 值并没有改变。事实上有一个宏 push 可以加入元素的同时改变列表的值：

    (push 'x foo)                           ; => (x a b)
    foo                                     ; => (x a b)

生成一个列表的函数是 list。比如：

    (list 1 2 3)                            ; => (1 2 3)

可能这时你有一个疑惑，前面产生一个列表，我常用 quote（也就是 ' 符号）这个函数，它和这个 cons 和 list 函数有什么区别呢？
其实区别是很明显的，quote 是把参数直接返回不进行求值，而 list 和 cons 是对参数求值后再生成一个列表或者 cons cell。看下面这个例子：

    '((+ 1 2) 3)                            ; => ((+ 1 2) 3)
    (list (+ 1 2) 3)                        ; => (3 3)

前一个生成的列表的 CAR 部分是 (+ 1 2) 这个列表，而后一个是先对 (+ 1 2) 求值得到 3 后再生成列表。

<span class="timestamp-wrapper"><span class="timestamp">&lt;2019-03-26 周二&gt;</span></span>


<a id="orge0e029a"></a>

## 属性列表（property list，plist）

<https://blog.csdn.net/whackw/article/details/51542457>
这种列表中的第1个元素用来描述第2个元素，第3个元素用来描述第4个元素，以此类推，第奇数个元素都是用来描述相邻的第偶数个元素的，
换句话说就是： 从第一个元素开始的所有相间元素都是一个用来描述接下来那个元素的符号（原文引用 ：）），在 plist 
里奇数个元素的写法使用一种特殊的符号&#x2013;关键字符号（keyword）。

    (list :书名 "人间词话" :作者 "王国维" :价格 100 :是否有电子版 t)

这里要提到一个属性表的函数 getf ，它可以根据一个 plist 中的某个字段名（属性名）来查询对应的属性值，如下所示，
我们想要查询刚才建立的 plist 中的 :书名 属性名所对应的属性值：

    (getf (list :书名 "人间词话" :作者 "王国维" :价格 100 :是否有电子版 t) :作者)

