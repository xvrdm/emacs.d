;; encoding
(set-language-environment "UTF-8")

;; 禁用响铃
(setq ring-bell-function 'ignore)

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
(save-place-mode 1)

;; tab settings
(setq-default indent-tabs-mode nil) ; tab 改为插入空格
(setq c-basic-offset 4) ; c c++ 缩进4个空格
;; (setq c-default-style "linux"); 没有这个 { } 就会瞎搞
(setq default-tab-width 4)


(provide 'init-better-default)
