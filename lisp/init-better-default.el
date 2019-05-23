;; -*- coding: utf-8; lexical-binding: t; -*-
;; encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; 编码设置 begin
;; (set-language-environment 'Chinese-GB)
;; default-buffer-file-coding-system变量在emacs23.2之后已被废弃，使用buffer-file-coding-system代替
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq-default pathname-coding-system 'euc-cn)
(setq file-name-coding-system 'euc-cn)
;; 另外建议按下面的先后顺序来设置中文编码识别方式。
;; 重要提示:写在最后一行的，实际上最优先使用; 最前面一行，反而放到最后才识别。
;; utf-16le-with-signature 相当于 Windows 下的 Unicode 编码，这里也可写成
;; utf-16 (utf-16 实际上还细分为 utf-16le, utf-16be, utf-16le-with-signature等多种)
(prefer-coding-system 'cp950)
(prefer-coding-system 'gb2312)
(prefer-coding-system 'cp936)
;; (prefer-coding-system 'gb18030)
;; (prefer-coding-system 'utf-16le-with-signature)
(prefer-coding-system 'utf-16)
;; 新建文件使用utf-8-unix方式
;; 如果不写下面两句，只写
;; (prefer-coding-system 'utf-8)
;; 这一句的话，新建文件以utf-8编码，行末结束符平台相关
;; (prefer-coding-system 'utf-8-dos)
(prefer-coding-system 'utf-8-unix)
;; 编码设置 end

;; 设置垃圾回收，在Windows下，emacs25版本会频繁出发垃圾回收，所以需要设置
;; (when (eq system-type 'windows-nt)
;;   (setq gc-cons-threshold (* 512 1024 1024))
;;   (setq gc-cons-percentage 0.5)
;;   (run-with-idle-timer 5 t #'garbage-collect)
;;   ;; 显示垃圾回收信息，这个可以作为调试用
;;   ;; (setq garbage-collection-messages t)
;;   )

(use-package recentf
  :after evil
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-item 10)
  (global-prettify-symbols-mode t)
  ;; 禁用响铃
  (setq ring-bell-function 'ignore)
  ;; display time in modeline
  (display-time-mode 1)
  ;; auto reload file
  (global-auto-revert-mode t)
  ;; 在使用emacs时，一行文字如果不按回车键，那么它就会一直往右延伸，不会自动换行。这是很不方便的。
  (setq work-wrap 'off)
  ;; 禁用备份文件
  (setq make-backup-files nil)
  (setq auto-save-default nil)
  ;; 高亮光标增强
  (define-advice show-paren-function(:around (fn) fix-show-paren-function)
    "Highlight enclosing parens."
    (cond ((looking-at-p "\\s(") (funcall fn))
          (t (save-excursion
               (ignore-errors (backward-up-list))
               (funcall fn)))))
  ;; 括号匹配高亮
  ;; (add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
  (set-cursor-color "red")
  (fset 'yes-or-no-p 'y-or-n-p)
  ;;
  (delete-selection-mode 1)
  )

;; 行号
(if (>= emacs-major-version 26)
    ;; config built-in "display-line-number-mode" (require Emacs >= 26)
    ;; enable line numbering (or "linum-mode")
    (let ((hook-list '(sh-mode-hook
                       cmake-mode-hook
                       emacs-lisp-mode-hook
                       matlab-mode-hook
                       python-mode-hook
                       c-mode-common-hook
                       org-mode-hook
                       package-menu-mode-hook
                       makefile-gmake-mode-hook
                       ;;  Gnome
                       makefile-bsdmake-mode-hook ; OS X
                       ess-mode-hook)))  
      (setq-default display-line-numbers-width 2)
      (setq-default display-line-numbers-width-start t)  ;; 行数右对齐
      ;; (setq-default display-line-numbers-type 'relative)
      (setq display-line-numbers-current-absolute t)
      (dolist (hook-element hook-list)
        (add-hook hook-element 'display-line-numbers-mode)))
  (global-linum-mode 1)
  (when (not (display-graphic-p))
    (setq linum-format "%d "))) ;; 注意%d后面有空格，即用空格将行号和代码隔


;; abbrev
;; (abbrev-mode t)
;; (define-abbrev-table 'global-abbrev-table '(("lf" "liang.feng")))


;; When you visit a file, point goes to the last place where it was when you previously visited the same file.
;; remember cursor position. When file is opened, put cursor at last position
(if (version< emacs-version "25.0")
    (progn
      (require 'saveplace)
      (setq-default save-place t))
  (save-place-mode 1))

;; tab settings
(setq-default indent-tabs-mode nil) ; tab 改为插入空格
(setq c-basic-offset 4) ; c c++ 缩进4个空格

;; https://www.emacswiki.org/emacs/IndentingC
;; https://en.wikipedia.org/wiki/Indent_style
(setq c-default-style "linux")
(setq default-tab-width 4)
;; (add-hook 'python-mode-hook #'(lambda () (setq python-indent-offset 4)))

;; http://ergoemacs.org/emacs/emacs_tabs_space_indentation_setup.html
;; (progn
;;   ;; make tab key always call a indent command.
;;   (setq-default tab-always-indent t)
;;   ;; make tab key call indent command or insert tab character, depending on cursor position
;;   (setq-default tab-always-indent nil)
;;   ;; make tab key do indent first then completion.
;;   (setq-default tab-always-indent 'complete)
;;   )

;; Underscore "_" is not a word character
;; https://github.com/emacs-evil/evil
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))

;; 花括号自动换行的问题
;; http://tieba.baidu.com/p/3572057629
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode t)
  (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit))

;; advice for find-file
;; (defun advice-find-file (filename &optional wildcards)
;;   (interactive)
;;   (if (file-exists-p filename)
;;       t
;;     (y-or-n-p (message "%s not exist! create it?" filename))))
;; (advice-add #'find-file :before-while #'advice-find-file)

(defadvice find-file (around advice-find-file activate)
  (if (file-exists-p filename)
      ad-do-it
    (if (y-or-n-p (message "%s not exist! create it!" filename))
        ad-do-it))
  )

;; advice for evil search
;; (defadvice evil-search-next (after advice-for-evil-search-next activate)
;;   (evil-scroll-line-to-center (line-number-at-pos)))
;; (defadvice evil-search-previous (after advice-for-evil-search-previous activate)
;;   (evil-scroll-line-to-center (line-number-at-pos)))

;; equivalent of 'nnoremap n nzz' in vim
;; https://github.com/noctuid/evil-guide
(defun my-center-line (&rest _)
  (evil-scroll-line-to-center nil))
(advice-add 'evil-search-next :after #'my-center-line)
(advice-add 'evil-search-previous :after #'my-center-line)

;; adjust for work server
(when (or (equal system-name "tms2")
          (equal system-name "ceph1"))
  (add-hook
   'emacs-startup-hook
   #'(lambda ()
       (quit-windows-on
        (get-buffer "*Warnings*")))))

(use-package diff
  :ensure t
  :after evil
  :config
  (evil-define-key 'normal diff-mode-map "q" #'kill-this-buffer)
  (evil-define-key 'normal help-mode-map "q" #'kill-buffer-and-window)
  (evil-define-key 'motion apropos-mode-map "q" #'kill-buffer-and-window)
  ;; create a thread to auto focus on *apropos* window
  (add-hook 'apropos-mode-hook (lambda ()
                                 (make-thread (lambda ()
                                                (while (not (get-buffer-window "*Apropos*"))
                                                  (sleep-for 0 100))
                                                (select-window (get-buffer-window "*Apropos*"))
                                                )))))

(provide 'init-better-default)
