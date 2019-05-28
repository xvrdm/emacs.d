;; -*- coding: utf-8; lexical-binding: t; -*-
;; encoding
(set-language-environment "UTF-8")
;; (set-default-coding-systems 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

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
  ;; :defer 2
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-item 10)
  (global-prettify-symbols-mode t)
  ;; 禁用响铃
  (setq ring-bell-function 'ignore)
  ;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线
  (mouse-avoidance-mode 'animate)
  ;; 当光标在行尾上下移动的时候，始终保持在行尾
  (setq track-eol t)
  ;; display time in modeline
  (display-time-mode 1)
  ;; auto reload file
  (global-auto-revert-mode t)
  ;; 在使用emacs时，一行文字如果不按回车键，那么它就会一直往右延伸，不会自动换行。这是很不方便的。
  (setq work-wrap 'off)
  ;; 禁用备份文件
  (setq make-backup-files nil)
  (setq auto-save-default nil)

  ;;-------------------------------------------------------------
  ;; paren settings
  ;;-------------------------------------------------------------
  ;; https://www.emacswiki.org/emacs/ShowParenMode#toc1
  (setq show-paren-delay 0)
  (show-paren-mode)
  ;; https://stackoverflow.com/questions/22951181/emacs-parenthesis-match-colors-styling
  ;; "C-u C-x =(aka C-u M-x what-cursor-position)" with the cursor on the highlighted parenthesis,
  ;; you will know what the highlighting face is.

  ;; reference from spacemacs
  (defun true-color-p ()
    (or
     (display-graphic-p)
     (= (tty-display-color-cells) 16777216)))
  ;; (setq variant 'light)
  (setq variant 'dark)
  (setq mat (if (eq variant 'dark) (if (true-color-p) "#86dc2f" "#86dc2f") (if (true-color-p) "#ba2f59" "#af005f")))
  (setq weight-value (if (window-system) 'normal 'extra-bold))
  ;;-------------------------------------------------------------
  ;; set-face-attribute 这个要延时调用才能起作用，没搞清楚原因，难道会被覆盖？
  ;;-------------------------------------------------------------
  ;; (defun custom-face ()
  ;;   (set-face-attribute
  ;;    'show-paren-match
  ;;    nil
  ;;    :foreground mat
  ;;    :underline t
  ;;    :background nil
  ;;    :inverse-video nil
  ;;    :weight weight-value))
  ;; (run-with-idle-timer 2 nil #'custom-face)
  ;;-------------------------------------------------------------
  ;; custom-set-faces
  ;;-------------------------------------------------------------
  (custom-set-faces
   `(show-paren-match ((t (:foreground ,mat :underline t :background nil :inverse-video nil :weight ,weight-value)))))
  ;;-------------------------------------------------------------
  ;; custom-theme-set-faces
  ;;-------------------------------------------------------------
  ;; (custom-theme-set-faces
  ;;  'monokai
  ;;  `(show-paren-match ((t (:foreground ,mat :underline t :background nil :inverse-video nil :weight ,weight-value)))))

  ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Matching.html
  ;; causes highlighting also when point is on the inside of a parenthesis. 
  ;; (setq show-paren-when-point-inside-paren t)

  ;;-------------------------------------------------------------
  ;; 高亮光标增强 advice-add和define-advice,只有延时调用或者禁用evil才起作用,还没搞清楚原因。
  ;; defadvice在windows下就不用延时
  ;;-------------------------------------------------------------
  ;; (define-advice show-paren-function (:around (fn) fix-show-paren-function)
  ;;   "Highlight enclosing parens."
  ;;   (cond ((looking-at-p "(\\|)") (funcall fn))
  ;;         (t (save-excursion
  ;;              (ignore-errors (backward-up-list))
  ;;              (funcall fn)))))
  ;;-------------------------------------------------------------
  ;; (defun advice-show-paren-function (fn)
  ;;   (cond ((looking-at-p "\\s(") (funcall fn))
  ;;         (t (save-excursion
  ;;              (ignore-errors (backward-up-list))
  ;;              (funcall fn)))))
  ;; (advice-add #'show-paren-function :around #'advice-show-paren-function)
  ;;-------------------------------------------------------------
  (defadvice show-paren-function (around advice-show-paren-function activate)
    ;; (cond ((looking-at-p "\\s(") ad-do-it)
    (cond ((looking-at-p "(\\|)") ad-do-it)
          (t (save-excursion
               (ignore-errors (backward-up-list))
               ad-do-it))))

  (defun test-make ()
    (interactive)
    (if (looking-at-p "\\s(")
        (message "found")
      (message "not found")))

  (defun test-back ()
    (interactive)
    (backward-up-list))

  (defun test-remove-advice ()
    (interactive)
    (advice-remove #'show-paren-function #'advice-show-paren-function))


  (set-cursor-color "red")
  (fset 'yes-or-no-p 'y-or-n-p)
  (delete-selection-mode 1))

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

;;-------------------------------------------------------------
;; code format
;;-------------------------------------------------------------
;; tab settings
(setq-default indent-tabs-mode nil) ; tab 改为插入空格
(setq c-basic-offset 4) ; c c++ 缩进4个空格
;; https://www.emacswiki.org/emacs/IndentingC
;; https://en.wikipedia.org/wiki/Indent_style
(setq c-default-style "linux")
(setq default-tab-width 4)
;; https://www.gnu.org/software/emacs/manual/html_node/ccmode/c_002doffsets_002dalist.html#c_002doffsets_002dalist
;; https://www.gnu.org/software/emacs/manual/html_node/ccmode/Style-Variables.html#Style-Variables
;; https://www.gnu.org/software/emacs/manual/html_node/ccmode/Custom-Line_002dUp.html#Custom-Line_002dUp
(c-set-offset 'innamespace 0)
;; disable guess python indent warning
(setq python-indent-guess-indent-offset-verbose nil)

;; Underscore "_" is not a word character
;; https://github.com/emacs-evil/evil
(add-hook 'prog-mode-hook #'(lambda ()
                              (modify-syntax-entry ?_ "w")
                              (modify-syntax-entry ?- "w")))

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

;; after execute shell-command goto bottom of output buffer
(defadvice shell-command (around adivce-shell-command activate)
  ad-do-it
  (switch-to-buffer "*Shell Command Output*")
  (goto-char (point-max)))

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
   (lambda ()
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
  (if (fboundp 'make-thread)
      (add-hook 'apropos-mode-hook (lambda ()
                                     (make-thread (lambda ()
                                                    (while (not (get-buffer-window "*Apropos*"))
                                                      (sleep-for 0 100))
                                                    (select-window (get-buffer-window "*Apropos*")))))))
  )

(provide 'init-better-default)
