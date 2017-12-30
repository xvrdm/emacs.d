(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			   ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;; cl - Common List Extension
(require 'cl)

;; packages list
(defvar liang/packages '(
			 company
			 ;; themes
			 monokai-theme
			 ;; --- Better Editor ---
			 hungry-delete
			 ;;
			 swiper
			 ;;
			 counsel
			 ;;
			 smartparens
			 ;;
			 js2-mode
			 ;;
			 nodejs-repl
			 ;;
			 add-node-modules-path
			 ) "Default packages")

(setq package-selected-packages liang/packages)

(defun liang/packages-installed-p()
  (loop for pkg in liang/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (liang/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg liang/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))
;; hungry-delete seting
(global-hungry-delete-mode)
(require 'hungry-delete)

;; swiper setting
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)

;; smartparens setting
(require 'smartparens-config)
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

;; js2-mode setting
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; nodejs-repl setting
(require 'nodejs-repl)

;; setting add-node-modules-path
(eval-after-load 'js2-mode
    '(add-hook 'js2-mode-hook #'add-node-modules-path))

;; Theme
(load-theme 'monokai t)

;; 括号匹配高亮
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 高亮当前行
;; (global-hl-line-mode 1)

;; 关闭工具栏
;; (tool-bar-mode -1)

;; 关闭滚动条
;; (scroll-bar-mode -1)

;; 行号
(global-linum-mode 1)

;; 更改光标样式
;; (setq cursor-type 'bar)

;; 关闭启动画面
(setq inhibit-splash-screen 1)

;; 更改字体大小
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 160)

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-x C-m") 'open-init-file)

;; 开启全局company
(global-company-mode 1)

;; 禁用备份文件
(setq make-backup-files nil)

;; org-mode
(setq org-agenda-files '("~/org"))
(global-set-key (kbd "C-c a") 'org-agenda)

;; 打开recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;;
(delete-selection-mode 1)

;; 下面的这些函数可以让你找到不同函数，变量以及快捷键所定义的文件位置
;; 因为非常常用 所以我们建议将其设置为与查找文档类似的快捷键
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" default)))
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
