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
                         ;;
                         popwin
			 ;;
			 expand-region
			 ;;
			 iedit
			 ;;
			 org-pomodoro
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme
(load-theme 'monokai t)

;; hungry-delete seting
(global-hungry-delete-mode)
(require 'hungry-delete)

;; swiper setting
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; smartparens setting
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

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

;; popwin setting
(require 'popwin)
(popwin-mode t)

;; 开启全局company
(global-company-mode 1)

(require 'org-pomodoro)

(provide 'init-packages)
