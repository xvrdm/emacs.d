;; encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; 设置垃圾回收，在Windows下，emacs25版本会频繁出发垃圾回收，所以需要设置
(when (eq system-type 'windows-nt)
 (setq gc-cons-threshold (* 512 1024 1024))
 (setq gc-cons-percentage 0.5)
 (run-with-idle-timer 5 t #'garbage-collect)
 ;; 显示垃圾回收信息，这个可以作为调试用
 ;; (setq garbage-collection-messages t)
 )

;; 禁用响铃
(setq ring-bell-function 'ignore)

;; ruler
;; (ruler-mode t)

;; display time in modeline
(display-time-mode 1)

;; auto reload file
(global-auto-revert-mode t)

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
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 行号
(global-linum-mode 1)

;;
(delete-selection-mode 1)

;; abbrev
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(("lf" "liang.feng")))

;; 打开recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

(fset 'yes-or-no-p 'y-or-n-p)

;; dired递归copy delete
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)

(put 'dired-find-alternate-file 'disabled nil)

(require 'dired-x)

(setq dired-dwim-target t)

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
;; (setq c-default-style "linux"); 没有这个 { } 就会瞎搞
(setq default-tab-width 4)

;; http://ergoemacs.org/emacs/emacs_tabs_space_indentation_setup.html
(progn
  ;; make tab key always call a indent command.
  ;; (setq-default tab-always-indent t)
  ;; make tab key call indent command or insert tab character, depending on cursor position
  ;; (setq-default tab-always-indent nil)
  ;; make tab key do indent first then completion.
  ;; (setq-default tab-always-indent 'complete)
  )

;; Underscore "_" is not a word character
;; https://github.com/emacs-evil/evil
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;; 花括号自动换行的问题
;; http://tieba.baidu.com/p/3572057629
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))
(when (eval-when-compile (version< "24.4" emacs-version))
  (electric-indent-mode 1))

(provide 'init-better-default)
