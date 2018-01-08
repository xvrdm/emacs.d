(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
;;  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;                           ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
 (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))))
;; (setq package-archives
   ;;   '(;; uncomment below line if you need use GNU ELPA
        ;; ("gnu" . "https://elpa.gnu.org/packages/")
   ;;     ("localelpa" . "~/.emacs.d/localelpa/")
        ;; ("my-js2-mode" . "https://raw.githubusercontent.com/redguardtoo/js2-mode/release/") ; github has some issue
        ;; {{ backup repositories
        ;; ("melpa" . "http://mirrors.163.com/elpa/melpa/")
        ;; ("melpa-stable" . "http://mirrors.163.com/elpa/melpa-stable/")
        ;; }}
   ;;     ("melpa" . "https://melpa.org/packages/")
   ;;     ("melpa-stable" . "https://stable.melpa.org/packages/")
   ;;     )))

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
                         ;; http://blog.binchen.org/#
                         counsel-etags
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
                         ;;
                         helm-ag
                         ;;
                         auto-yasnippet
                         ;;
                         yasnippet
                         ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                         evil
                         ;;
                         evil-leader
                         ;;
                         evil-escape
                         ;;
                         evil-surround
                         ;;
                         evil-nerd-commenter
                         ;;
                         evil-easymotion
                         ;;
                         evil-matchit
                         ;;
                         evil-exchange
                         ;;
                         evil-iedit-state
                         ;;
                         general
                         ;;;;;;;;;;;;;;;;;;;;;;;;;
                         which-key
                         ;;
                         window-numbering
                         ;;
                         youdao-dictionary
                         ;;
                         ycmd
                         ;;
                         company-ycmd
                         ;;
                         counsel-gtags
                         ;;
                         smart-mode-line
                         ;;
                         doom-themes
                         ;;
                         function-args
                         ;;
                         neotree
                         ;;
                         projectile-speedbar
                         ;;
                         linum-relative
                         ;;
                         rainbow-delimiters
                         ;;
                         focus   
                         ;;
                         beacon
                         ;;
                         powerline
                         ;; themes for powerline
                         powerline-evil
                         ;; themes for powerline
                         airline-themes
                         ;; themes for powerline
                         spaceline
                         ;; A new implementation of Powerline for Emacs 
                         telephone-line
                         ;;
                         dashboard
                         ;;
                         highlight-symbol
                         ;;
                         rainbow-mode
                         ;;
                         multifiles
                         ;;
                         fix-word
                         ;;
                         browse-kill-ring
                         ;;
                         indent-guide
                         ;;
                         irony
                         ;;
                         company-irony
                         ;;
                         ggtags
                         ;;
                         symon
                         ;;
                         markdown-mode
                         ;;
                         ace-window
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
;;(load-theme 'wombat t)

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
(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)

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

;; org-pomodoro setting
(require 'org-pomodoro)

;; yasnippet setting
(require 'yasnippet)
(yas-global-mode 1)
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)

;; window-numbering setting
(window-numbering-mode t)

;; emacs-ycmd
(require 'ycmd)
(add-hook 'after-init-hook 'global-ycmd-mode)
;; (add-hook 'c++-mode-hook 'ycmd-mode)
(set-variable 'ycmd-server-command '("python" "/home/liang.feng/.vim/plugged/YouCompleteMe/third_party/ycmd/ycmd"))
;; (set-variable 'ycmd-global-config "/home/liang.feng/dbus2.0/hatmserver2/.ycm_extra_conf.py")
(require 'company-ycmd)
(company-ycmd-setup)
;;;; Set always complete immediately
(setq company-idle-delay 0.1)
;;(add-to-list 'company-backends 'company-ycmd)

;; (require 'ycmd-test)
;; (ert-run-tests-interactively "ycmd-test")

;; youdao-dictionary
;; Enable Cache
(setq url-automatic-caching t)
;; Integrate with popwin-el (https://github.com/m2ym/popwin-el)
(push "*Youdao Dictionary*" popwin:special-display-config)

;; Set file path for saving search history
;; (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao")

;; Enable Chinese word segmentation support (支持中文分词)
;; (setq youdao-dictionary-use-chinese-word-segmentation t)

;; popwin
(require 'popwin)
(popwin-mode t)

;; which-key
(require 'which-key)
(which-key-mode)

;; gtags(global)
(load "/usr/local/share/gtags/gtags.el")
(autoload 'gtags-mode "gtags" "" t)

;; emacs-counsel-gtags
(add-hook 'c-mode-hook 'counsel-gtags-mode)
(add-hook 'c++-mode-hook 'counsel-gtags-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; counsel-etags
(require 'counsel-etags)
;;; auto update tags--->https://github.com/redguardtoo/counsel-etags
;; Don't ask before rereading the TAGS files if they have changed
(setq tags-revert-without-query t)
;; Don't warn when TAGS files are large
(setq large-file-warning-threshold nil)
;; Setup auto update now
(add-hook 'prog-mode-hook
          (lambda ()
            (add-hook 'after-save-hook
                      'counsel-etags-virtual-update-tags 'append 'local)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; update tags file https://www.emacswiki.org/emacs/GnuGlobal
(add-hook 'after-save-hook 'gtags-update-hook) ;; gtags-update-hook --> minefunc

;; note `file-truename' must be used!
;; (setenv "GTAGSLIBPATH" (concat "/usr/include"
;;                                ":"
;;                                "/usr/local/include"
;;                                ":"
;;                                (file-truename "~/proj2")
;;                                ":"
;;                                (file-truename "~/proj1")))
;; (setenv "MAKEOBJDIRPREFIX" (file-truename "~/obj/"))
;; (setq company-backends '((company-dabbrev-code company-gtags)))
;; (add-to-list 'company-backends 'company-gtags)

;; smart-mode-line
;; (setq sml/theme 'dark)
;; (setq sml/theme 'light)
;; (setq sml/theme 'respectful)
;; (sml/setup)
;; (setq sml/no-confirm-load-theme t)

;; doom-themes ;;;;;;;;;;;;;;;;;;;;;
;; (require 'doom-themes)
;; Global settings (defaults)
;; (setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
  ;;    doom-themes-enable-italic nil) ; if nil, italics is universally disabled
;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
;; (load-theme 'doom-nova t)
;; (load-theme 'doom-vibrant t)
;; (load-theme 'doom-one t)
;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)
;; Enable custom neotree theme
;;
;;(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!
;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)
;; end doom-themes ;;;;;;;;;;;;;;;;;;;;;

;; function-args
(require 'function-args)
(fa-config-default)

;; neotree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; projectile-speedbar
(require 'projectile-speedbar)

;; linum-relative
(require 'linum-relative)
;; (linum-relative-toggle)

;; rainbow-delimiters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; beacon
(beacon-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil
(require 'evil)
(require 'evil-leader)
(require 'evil-escape)
(require 'evil-surround)
(require 'evil-nerd-commenter)
(require 'evil-easymotion)
(require 'evil-matchit)
(global-evil-matchit-mode 1)
(require 'evil-exchange)
;; change default key bindings (if you want) HERE
;; (setq evil-exchange-key (kbd "zx"))
(evil-exchange-install)
;; {{ @see https://github.com/syl20bnr/spacemacs/blob/master/doc/DOCUMENTATION.org#replacing-text-with-iedit
;; same keybindgs as spacemacs:
;;  - "SPC s e" to start `iedit-mode'
;;  - "TAB" to toggle current occurrence
;;  - "n" next, "N" previous (obviously we use "p" for yank)
;;  - "gg" the first occurence, "G" the last occurence
;;  - Please note ";;" or `avy-goto-char-timer' is also useful
(require 'evil-iedit-state)
(require 'general)
(general-evil-setup t)
;; }}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; powerline
(require 'powerline)
(powerline-default-theme)
;; (powerline-center-theme)
;; (powerline-center-evil-theme)
;; (powerline-vim-theme)
;; (powerline-evil-center-color-theme)

;; powerline-evil
(require 'powerline-evil)

;; airline-themes
(require 'airline-themes)
;; (load-theme 'airline-light)
;; (load-theme 'airline-dark)
(airline-themes-set-modeline)

;; spaceline
;; (require 'spaceline-config)
;; (spaceline-spacemacs-theme)
;; (spaceline-emacs-theme)

;; telephone-line
;; (require 'telephone-line-config)
;; (telephone-line-evil-config)

;; dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)

;; highlight-symbol
(require 'highlight-symbol)

;; rainbow-mode
(require 'rainbow-mode)
(rainbow-mode 1)

;; multifiles
(require 'multifiles)

;; fix-word
(require 'fix-word)

;; browse-kill-ring
(require 'browse-kill-ring)

;; indent-guide
(require 'indent-guide)
(indent-guide-global-mode)

;; irony
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; company-irony
;; (eval-after-load 'company
  ;;  '(add-to-list 'company-backends 'company-irony))

;; ggtags
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

;; symon
(require 'symon)

;; ace-window
(require 'ace-window)

(provide 'init-packages)
