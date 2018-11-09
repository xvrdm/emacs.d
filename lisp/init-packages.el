(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
 (setq package-archives '(("gnu" . "https://elpa.emacs-china.org/gnu/")
                         ("melpa" . "https://elpa.emacs-china.org/melpa/"))))
;;  (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
  ;;                       ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))))
;; (setq package-archives
   ;;   '(;; uncomment below line if you need use GNU ELPA
        ;; ("gnu" . "https://elpa.gnu.org/packages/")
   ;;     ("localelpa" . "~/.emacs.d/localelpa/")
        ;; ("my-js2-mode" . "https://raw.githubusercontent.com/redguardtoo/js2-mode/release/") ; github has some issue
        ;; {{ backup repositories
  ;;      '(("melpa" . "http://mirrors.163.com/elpa/melpa/")
   ;;     ("melpa-stable" . "http://mirrors.163.com/elpa/melpa-stable/"))))
        ;; }}
   ;;     ("melpa" . "https://melpa.org/packages/")
   ;;     ("melpa-stable" . "https://stable.melpa.org/packages/")
   ;;     )))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;; cl - Common List Extension
(require 'cl)

;; packages list
(defvar liang/packages '(
                         use-package
                         company
                         company-statistics
                         company-c-headers
                         company-jedi
                         exec-path-from-shell
                         ;; themes
                         ;; monokai-theme
                         ;; zenburn-theme
                         ample-theme
                         ;; ample-zen-theme
                         ;; atom-one-dark-theme
                         ;; --- Better Editor ---
                         hungry-delete
                         ;;
                         swiper
                         ;;
                         counsel
                         ;; http://blog.binchen.org/#
                         ;; counsel-etags
                         ;;
                         smartparens
                         ;;
                         ;; js2-mode
                         ;;
                         ;; nodejs-repl
                         ;;
                         ;; add-node-modules-path
                         ;; Diminished modes are minor modes with no modeline display 
                         diminish
                         ;;
                         delight
                         ;;
                         popwin
                         ;;
                         smex
                         ;;
                         expand-region
                         ;;
                         iedit
                         ;;
                         org-pomodoro
                         ;;
                         ;; helm-ag
                         ;;
                         ;; auto-yasnippet
                         ;;
                         yasnippet
                         ;;
                         yasnippet-snippets
                         ;;;;;;;;;;;;;;;;;;;;;;;;;;;
                         evil
                         ;;
                         ;; evil-collection
                         ;;
                         ;; replace by general
                         ;; evil-leader
                         ;;
                         evil-org
                         ;;
                         evil-smartparens
                         ;;
                         evil-visualstar
                         ;;
                         evil-escape
                         ;;
                         evil-surround
                         ;;
                         evil-nerd-commenter
                         ;;
                         evil-easymotion
                         ;; easy motion pulgin
                         evil-snipe
                         ;;
                         evil-matchit
                         ;;
                         evil-exchange
                         ;;
                         evil-iedit-state
                         ;;
                         evil-indent-plus
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
                         ;; smart-mode-line
                         ;;
                         ;; smart-mode-line-powerline-theme
                         ;;
                         ;; doom-themes
                         ;; complete too slow....
                         ;; function-args
                         ;;
                         neotree
                         ;;
                         projectile-speedbar
                         ;;
                         sr-speedbar
                         ;;
                         ;; linum-relative
                         ;;
                         rainbow-delimiters
                         ;;
                         focus   
                         ;;
                         beacon
                         ;; A fork of powerline.el (based on an old uncredited version of
                         ;; powerline.el - origin is unclear.) - this fork has multiple separator graphics. 
                         ;; main-line
                         ;;
                         ;; powerline
                         ;; themes for powerline
                         ;; powerline-evil
                         ;; themes for powerline
                         ;; airline-themes
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
                         ;; too slow.......
                         ;; indent-guide
                         ;;
                         ;; irony
                         ;;
                         ;; company-irony
                         ;;
                         ggtags
                         ;;
                         symon
                         ;;
                         markdown-mode
                         ;;
                         ace-window
                         ;;
                         hydra
                         ;; too slow
                         ;; color-identifiers-mode
                         ;;
                         rainbow-identifiers
                         ;;
                         highlight-numbers
                         ;; only for elisp
                         highlight-quoted
                         ;; only for elisp
                         highlight-defined
                         ;;
                         major-mode-icons
                         ;;
                         mode-icons
                         ;;
                         ergoemacs-status
                         ;;
                         ;; dumb-jump
                         ;;
                         ;; nyan-mode
                         ;;
                         highlight-parentheses
                         ;;
                         dired-imenu
                         ;;
                         imenu-anywhere
                         ;;
                         rich-minority
                         ;;
                         ;; tabbar
                         ;;
                         ;;lsp-mode
                         ;;
                         ;; cquery
                         ;;
                         ;;company-lsp
                         ;;
                         ivy-xref
                         ;;
                         ;; git-gutter
                         ;;
                         ace-popup-menu
                         ;;
                         ;; dired-hacks-utils
                         ;;
                         dired-single
                         ;;
                         dired-k
                         ;;
                         ;; company-quickhelp
                         ;;
                         ;; nimbus-theme
                         ;;
                         ;; monokai-theme
                         ;; base16-theme
                         ;;
                         ) "Default packages")

(setq package-selected-packages liang/packages)

(defun liang/packages-installed-p()
  (cl-loop for pkg in liang/packages
        when (not (package-installed-p pkg)) do (cl-return nil)
        finally (cl-return t)))

(unless (liang/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg liang/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))
	  
(require 'use-package)


;;;;;;;;;;;;;;;;;;;;;;windows envirment variable;;;;;;;;;;;;;
;; (setenv "PATH" "C:/emacs24.5_win32")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme
;; (load-theme 'monokai t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defvar zenburn-override-colors-alist
;;   '(("zenburn-bg+05" . "#282828")
;;     ("zenburn-bg+1"  . "#2F2F2F")
;;     ("zenburn-bg+2"  . "#3F3F3F")
;;     ("zenburn-bg+3"  . "#4F4F4F")))
;; (load-theme 'zenburn t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (load-theme 'wombat t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; then in your init you can load all of the themes
;; without enabling theme (or just load one)
(load-theme 'ample t t)
;; (load-theme 'ample-light t t)
;; (load-theme 'ample-flat t t)
;; choose one to enable
(enable-theme 'ample)
;; (enable-theme 'ample-flat)
;; (enable-theme 'ample-light)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (load-theme 'ample-zen t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (load-theme 'atom-one-dark t)


;; hungry-delete seting
(use-package hungry-delete
  :delight hungry-delete-mode
  :config
  (global-hungry-delete-mode)
  ;; https://emacs-china.org/t/smartparens/2778/7
  ;; fix hungry-delete & smartparents conflict
  (defadvice hungry-delete-backward (before sp-delete-pair-advice activate)
    (save-match-data (sp-delete-pair (ad-get-arg 0))))
  )

(use-package swiper
  :delight ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  ;; swiper setting
  (setq enable-recursive-minibuffers t)
  )

;; smartparens setting
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(use-package smartparens-config
  :delight smartparens-global-mode
  :delight smartparens-mode
  :config
  (smartparens-global-mode t)
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
  )

;; js2-mode setting
;; (setq auto-mode-alist
;;       (append
;;         '(("\\.js\\'" . js2-mode))
;;         auto-mode-alist))

;; nodejs-repl setting
;; (require 'nodejs-repl)

;; setting add-node-modules-path
;; (eval-after-load 'js2-mode
;;                  '(add-hook 'js2-mode-hook #'add-node-modules-path))

;; popwin setting
(use-package popwin
  :delight popwin-mode
  :config
  (popwin-mode t)
  )

;; 开启全局company
(use-package company
  :init
  :delight global-company-mode
  :delight company-mode
  :config
  (global-company-mode 1)
  ;; (add-hook 'after-init-hook 'global-company-mode)
  ;; 显示候选项的数字号。根据数字号选择候选项
  (setq company-show-numbers t)
  ;; make previous/next selection in the popup cycles
  (setq company-selection-wrap-around t) 
  ;; Some languages use camel case naming convention,
  ;; so company should be case sensitive.
  (setq company-dabbrev-ignore-case nil)
  (setq company-idle-delay 0.2)
  )

;; org-pomodoro setting
(use-package org-pomodoro
  :delight org-pomodoro)

;; yasnippet setting
(use-package yasnippet
  :delight yas-global-mode
  :delight yas-minor-mode
  :config
  (yas-global-mode 1)
  )
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)

(use-package window-numbering
  :delight window-numbering-mode
  :config
  (window-numbering-mode t)
  )

;; emacs-ycmd
(use-package ycmd
  :delight ycmd-mode
  :config
  ;; (add-hook 'after-init-hook 'global-ycmd-mode)
  (add-hook 'c++-mode-hook 'ycmd-mode)
  (add-hook 'python-mode-hook 'ycmd-mode)
  (set-variable 'ycmd-server-command '("python" "~/mine/ycmd"))
  ;; (set-variable 'ycmd-global-config "/home/liang.feng/dbus2.0/hatmserver2/.ycm_extra_conf.py")
  (setq ycmd-extra-conf-handler 'load)
  )

(use-package company-ycmd
  :delight company-ycmd
  :config
  (company-ycmd-setup)
  ;; Set always complete immediately
  (setq company-idle-delay 0.1)
  ;;(add-to-list 'company-backends 'company-ycmd)
  )


;; (require 'ycmd-test)
;; (ert-run-tests-interactively "ycmd-test")

;; youdao-dictionary
(use-package youdao-dictionary
  :config
  ;; Enable Cache
  (setq url-automatic-caching t)
  ;; Integrate with popwin-el (https://github.com/m2ym/popwin-el)
  (push "*Youdao Dictionary*" popwin:special-display-config)
  ;; Set file path for saving search history
  ;; (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao")
  ;; Enable Chinese word segmentation support (支持中文分词)
  ;; (setq youdao-dictionary-use-chinese-word-segmentation t)
  )

;; {{ which-key-mode
(use-package which-key
  :delight which-key-mode
  :init
  (setq which-key-allow-imprecise-window-fit t) ; performance
  (setq which-key-separator ":")
  :config
  (which-key-mode 1)
  )
;; }}

;; gtags(global)
(use-package gtags
  :delight gtags-mode
  :init
  (if (not (equal 'windows-nt system-type))
      (load "/usr/local/share/gtags/gtags.el")
    (load "gtags.el"))
  ;; (load "/usr/local/share/gtags/gtags.el")
  :config
  (autoload 'gtags-mode "gtags" "" t)
  (add-hook 'gtags-select-mode-hook
            '(lambda ()
               (setq hl-line-face 'underline)
               (hl-line-mode 1)
               )
            )
  ;; update tags file https://www.emacswiki.org/emacs/GnuGlobal
  ;; (add-hook 'after-save-hook 'gtags-update-hook) ;; gtags-update-hook --> minefunc
  (setq gtags-auto-update t)
  )

;; emacs-counsel-gtags
(use-package counsel-gtags
  :delight counsel-gtags-mode
  :config
  (add-hook 'c-mode-hook 'counsel-gtags-mode)
  (add-hook 'c++-mode-hook 'counsel-gtags-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; counsel-etags
;; (use-package counsel-etags
;;   :delight
;;   :config
;;   (eval-after-load 'counsel-etags
;;     '(progn
;;        ;; counsel-etags-ignore-directories does NOT support wildcast
;;        (add-to-list 'counsel-etags-ignore-directories "build_clang")
;;        (add-to-list 'counsel-etags-ignore-directories "build_clang")
;;        ;; counsel-etags-ignore-filenames supports wildcast
;;        (add-to-list 'counsel-etags-ignore-filenames "TAGS")
;;        ;; (add-to-list 'counsel-etags-ignore-filenames "*.html")
;;        ;; (add-to-list 'counsel-etags-ignore-filenames "*.map")
;;        ;; (add-to-list 'counsel-etags-ignore-filenames "*.json")
;;        )) 
;;   ;; auto update tags--->https://github.com/redguardtoo/counsel-etags
;;   ;; Don't ask before rereading the TAGS files if they have changed
;;   (setq tags-revert-without-query t)
;;   ;; Don't warn when TAGS files are large
;;   (setq large-file-warning-threshold nil)
;;   ;; Setup auto update now
;;   (add-hook 'prog-mode-hook
;;             (lambda ()
;;               (add-hook 'after-save-hook
;;                         'counsel-etags-virtual-update-tags 'append 'local)))
;;   )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;; (load-theme 'doom-molokai t)
;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)
;; Enable custom neotree theme
;;
;;(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!
;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)
;; end doom-themes ;;;;;;;;;;;;;;;;;;;;;

;; function-args
;; (use-package function-args
;;   :delight function-args-mode
;;   :config
;;   (fa-config-default)
;;   )

;; neotree
(use-package neotree
  :delight neotree-mode
  :config
  (global-set-key [f8] 'neotree-toggle)
  )

;; projectile-speedbar
(use-package projectile-speedbar
  :delight)

;; linum-relative
;; (use-package linum-relative
;;   :delight linum-relative-mode
;;   :config
;;   ;; (linum-relative-toggle)
;;   )

;; rainbow-delimiters
(use-package rainbow-delimiters
  :delight rainbow-delimiters-mode
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

;; beacon
(use-package beacon
  :delight beacon-mode
  :config
  (beacon-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil
;; https://github.com/jojojames/evil-collection
;; (use-package evil
;;   :delight evil-mode
;;   :init
;;   (setq evil-want-integration nil)
;;   :config
;;   )

;; (use-package evil-collection
;;   :delight
;;   :config
;;   (evil-collection-init)
;;   )

;; end https://github.com/jojojames/evil-collection
;; (require 'evil-leader)
(use-package evil-escape
  :delight evil-escape-mode
  )

(use-package evil-surround
  :delight evil-surround-mode
  )

(use-package evil-nerd-commenter
  :delight
  )

(use-package evil-easymotion
  :delight
  )
(use-package evil-matchit
  :delight evil-matchit-mode
  :config
  (global-evil-matchit-mode 1)
  )

(use-package evil-exchange
  :delight
  :config
  ;; change default key bindings (if you want) HERE
  ;; (setq evil-exchange-key (kbd "zx"))
  (evil-exchange-install)
  )

;; {{ @see https://github.com/syl20bnr/spacemacs/blob/master/doc/DOCUMENTATION.org#replacing-text-with-iedit
;; same keybindgs as spacemacs:
;;  - "SPC s e" to start `iedit-mode'
;;  - "TAB" to toggle current occurrence
;;  - "n" next, "N" previous (obviously we use "p" for yank)
;;  - "gg" the first occurence, "G" the last occurence
;;  - Please note ";;" or `avy-goto-char-timer' is also useful
(use-package evil-iedit-state
  :delight)

(use-package general
  :delight
  :config
  (general-evil-setup t)
  )
;; }}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'main-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; powerline
(use-package powerline
  :delight
  :config
  ;; (powerline-default-theme)
  ;; (powerline-center-theme)
  ;; (powerline-center-evil-theme)
  ;; (powerline-vim-theme)
  ;; (powerline-evil-center-color-theme)
  ;; (powerline-evil-vim-theme)
  ;; (powerline-evil-vim-color-theme)
  ;; (powerline-nano-theme)
  )

;; smart-mode-line
;; (use-package smart-mode-line
;;   :delight
;;   :init
;;   ;; (setq sml/theme 'dark)
;;   ;; (setq sml/theme 'light)
;;   (setq sml/no-confirm-load-theme t)
;;   (setq sml/theme 'powerline)
;;   ;; (setq sml/theme 'respectful)
;;   :config
;;   (sml/setup)
;;   )
 

;; powerline-evil
;; (use-package poweline-evil
;;   :delight
;;   )

;; airline-themes
;; (use-package airline-themes
;;   :config
;;   ;; (load-theme 'airline-light)
;;   ;; (load-theme 'airline-da dark)
;;   (airline-themes-set-modeline)
;;   )

;; spaceline
;; (use-package spaceline-config
;;   :config
;;   ;; (require 'spaceline-config)
;;   (spaceline-spacemacs-theme)
;;   ;; (spaceline-emacs-theme)
;;   )

;; telephone-line
(use-package telephone-line-config
  :delight telephone-line-mode
  :config
  (telephone-line-evil-config)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dashboard
(use-package dashboard
  :delight dashboard-mode
  :config
  (dashboard-setup-startup-hook)
  ;; Set the title
  (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
  ;; Set the banner
  (setq dashboard-startup-banner nil)
  ;; Value can be
  ;; 'official which displays the official emacs logo
  ;; 'logo which displays an alternative emacs logo
  ;; 1, 2 or 3 which displays one of the text banners
  ;; "path/to/your/image.png which displays whatever image you would prefer
  )

;; highlight-symbol
(require 'highlight-symbol)
(use-package highlight-symbol
  :delight highlight-symbol-mode
  :config
  )

;; rainbow-mode
(use-package rainbow-mode
  :delight rainbow-mode
  :config
  (rainbow-mode 1)
  )

;; multifiles
(use-package multifiles
  :delight multifiles-minor-mode
  )

;; fix-word
(use-package fix-word
  :delight)

;; browse-kill-ring
(use-package browse-kill-ring
  :delight browse-kill-ring-mode
  )

;; indent-guide
;; (use-package indent-guide
;;   :delight indent-guide-mode
;;   :config
;;   (indent-guide-global-mode)
;;   )

;; irony
;; (when (equal system-type 'windows-nt)
;;   (progn
;;     (use-package irony
;;       :delight irony-mode
;;       :config
;;       (add-hook 'c++-mode-hook 'irony-mode)
;;       (add-hook 'c-mode-hook 'irony-mode)
;;       (add-hook 'objc-mode-hook 'irony-mode)
;;       (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;       ;; Windows performance tweaks
;;       ;;
;;       (when (boundp 'w32-pipe-read-delay)
;;         (setq w32-pipe-read-delay 0))
;;       ;; Set the buffer size to 64K on Windows (from the original 4K)
;;       (when (boundp 'w32-pipe-buffer-size)
;;         (setq irony-server-w32-pipe-buffer-size (* 64 1024)))
;;       )

;;     ;; company-irony
;;     (use-package company-irony
;;       :delight
;;       :config
;;       (eval-after-load 'company
;;         '(add-to-list 'company-backends 'company-irony))
;;       )
;;     )
;;   )

;; ggtags
(use-package ggtags
  :delight ggtags-mode
  :config
  (setq ggtags-highlight-tag nil)
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
                (ggtags-mode 1))))
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index)
  )

;; symon
(use-package symon
  :delight symon-mode
  )

;; ace-window
(use-package ace-window
  :delight
  )

;; hydra
(use-package hydra
  :delight
  )

;; color-identifiers-mode--->too slow to parse files
;; (require 'color-identifiers-mode)
;; (add-hook 'after-init-hook 'global-color-identifiers-mode)
;; (run-with-idle-timer 1 t 'color-identifiers:refresh)

;; rainbow-identifiers
(use-package rainbow-identifiers
  :delight rainbow-identifiers-mode
  :config
  (add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
  )

;; highlight-numbers
(use-package highlight-numbers
  :delight highlight-numbers-mode
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode)
  )

;; highlight-quoted
(use-package highlight-quoted
  :delight highlight-quoted-mode
  :config
  (add-hook 'emacs-lisp-mode-hook 'highlight-quoted-mode)
  )

;; highlight-defined
(use-package highlight-defined
  :delight highlight-defined-mode
  :config
  (add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)
  )

;; major-mode-icons
;; (require major-mode-icons)
;; (major-mode-icons-mode 1)

;; mode-icons
;; (require mode-icons)
;; (mode-icons-mode)

;; ergoemacs-status
;; (require 'ergoemacs-status)
;; (ergoemacs-status-mode)

;; diminish
;; (use-package diminish
;;   :delight diminished-mode
;;   :config
;;   Hide jiggle-mode lighter from mode line
;;   (diminish 'CounselGtags)
;;   (diminish 'Global-Semantic-Idle-Scheduler)
;;   (diminish 'Abbrev)
;;   (diminish 'Global-Evil-Matchit)
;;   (diminish 'Global-Undo-Tree)
;;   (diminish 'Global-Hungry-Delete)
;;   (diminish 'Global-Evil-Surround)
;;   (diminish 'ycmd)
;;   Replace abbrev-mode lighter with "Abv"
;;   (diminish 'abbrev-mode "Abv")
;;   )

;;
(use-package evil-snipe
  :delight evil-snipe-mode
  :delight evil-snipe-local-mode
  :config
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1)
  ;; Evil-snipe can override evil-mode's native motions with 1-char sniping:
  ;; https://github.com/hlissner/evil-snipe
  (evil-snipe-override-mode 1)
  ;; https://github.com/hlissner/evil-snipe#integration-into-avy/evil-easymotion
  ;; (define-key evil-snipe-parent-transient-map (kbd "C-;")
  ;;  (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)
  ;;  (evilem-create 'evil-snipe-repeat
  ;;                 :bind ((evil-snipe-scope 'buffer)
  ;;                        (evil-snipe-enable-highlight)
  ;;                        (evil-snipe-enable-incremental-highlight))))
  ;; https://github.com/hlissner/evil-snipe#conflicts-with-other-plugins
  ;; It seems evil-snipe-override-mode causes problems in Magit buffers, to fix this:
  (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)
  )

;; evil-smartparens
(use-package evil-smartparens
  :delight evil-smartparens-mode
  :config
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
  )

;; evil-visualstar
(use-package evil-visualstar
  :delight evil-visualstar-mode
  :config
  (global-evil-visualstar-mode)
  )

;; evil-indent-plus
(use-package evil-indent-plus
  :delight
  :config
  ;; This is a continuation of evil-indent-textobject. It provides six new text objects to evil based on indentation:
  ;; ii: A block of text with the same or higher indentation.
  ;; ai: The same as ii, plus whitespace.
  ;; iI: A block of text with the same or higher indentation, including the first line above with less indentation.
  ;; aI: The same as iI, plus whitespace.
  ;; iJ: A block of text with the same or higher indentation, including the first line above and below with less indentation.
  ;; aJ: The same as iJ, plus whitespace.
  (define-key evil-inner-text-objects-map "i" 'evil-indent-plus-i-indent)
  (define-key evil-outer-text-objects-map "i" 'evil-indent-plus-a-indent)
  (define-key evil-inner-text-objects-map "I" 'evil-indent-plus-i-indent-up)
  (define-key evil-outer-text-objects-map "I" 'evil-indent-plus-a-indent-up)
  (define-key evil-inner-text-objects-map "J" 'evil-indent-plus-i-indent-up-down)
  (define-key evil-outer-text-objects-map "J" 'evil-indent-plus-a-indent-up-down)
  )

;; dumb jump
;; (dumb-jump-mode)

;; nyan-mode
;; (require 'nyan-mode)

;; (setq mode-line-format
;;       (list
;;        '(:eval (list (nyan-create)))
;;        ))
;; (nyan-mode t)
;; (nyan-start-animation)

;; highlight-parentheses
(use-package highlight-parentheses
  :delight highlight-parentheses-mode
  :config
  ;; (add-hook 'prog-mode-hook 'highlight-parentheses-mode)
  (define-globalized-minor-mode global-highlight-parentheses-mode
    highlight-parentheses-mode
    (lambda ()
      (highlight-parentheses-mode t)))
  (global-highlight-parentheses-mode t)  
  )

;; dired-imenu
(use-package dired-imenu
  :delight
  )

;; rich-minority
(use-package rich-minority
  :delight rich-minority-mode
  :config
  (rich-minority-mode 1)
  (setq rm-blacklist
        (format "^ \\(%s\\)$"
                (mapconcat #'identity
                           '(".*" "Projectile.*" "PgLn")
                           "\\|")))
  )

;; smex
(use-package smex
  :delight
  )

;; (use-package tabbar
;;   :delight
;;   :config
;;   )

;; (when (not (equal 'windows-nt system-type))
;;   (use-package lsp-mode
;;     :config
;;     (setq lsp-highlight-symbol-at-point nil)
;;     (require 'lsp-imenu)
;;     (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
;;     )

  ;; (use-package cquery
  ;;   :load-path
  ;;   "~/downloads/emacs-cquery/"
  ;;   :config
  ;;   (setq cquery-enable-sem-highlight nil)
  ;;   ;; put your config here
  ;;   ;; (setq cquery-resource-dir (expand-file-name "/home/liang.feng/downloads/cquery/build/clang+llvm-5.0.1-x86_64-linux-gnu-ubuntu-14.04/lib/clang/5.0.1"))
  ;;   (setq cquery-executable "/usr/local/bin/cquery")
  ;;   ;; (add-hook 'c++-mode-hook 'my//enable-cquery-if-compile-commands-json)
  ;;   (add-hook 'c++-mode-hook 'lsp-cquery-enable)
  ;;   (add-hook 'c-mode-hook 'lsp-cquery-enable)
  ;;   )

  ;; (use-package company-lsp
  ;;   :config
  ;;   (push 'company-lsp company-backends)
  ;;   )
  ;; )

(use-package ivy-xref
  :config
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
  )

;; (use-package git-gutter
;;   :config
;;   ;; If you enable global minor mode
;;   (global-git-gutter-mode t)
;;   ;; If you would like to use git-gutter.el and linum-mode
;;   ;; (git-gutter:linum-setup)
;;   )

;; (use-package company-statistics
;;   :config
;;   (add-hook 'after-init-hook 'company-statistics-mode)
;;   )

;; (use-package company-c-headers
;;   :config
;;   (add-to-list 'company-backends 'company-c-headers)
;;   )

(use-package ace-popup-menu
  :config
  (ace-popup-menu-mode 1)
  )

;; (use-package dired+
;;   :init
;;   (load "dired+.el")
;;   :config
;;   )

(use-package dired-single
  :config
  ;; if dired's already loaded, then the keymap will be bound
  (if (boundp 'dired-mode-map)
      ;; we're good to go; just add our bindings
      (my-dired-init)
    ;; it's not loaded yet, so add our bindings to the load-hook
    (add-hook 'dired-load-hook 'my-dired-init))
  )

(use-package dired-k
  :config
  ;; always execute dired-k when dired buffer is opened
  (add-hook 'dired-initial-position-hook 'dired-k)

  (add-hook 'dired-after-readin-hook #'dired-k-no-revert)
  (setq dired-k-style 'git)
  (setq dired-k-padding 1)
  )

(use-package sr-speedbar
  :config
  )

(use-package company-jedi
  :config
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'my/python-mode-hook)
  )

;; (use-package company-quickhelp
;;   :config
;;   (company-quickhelp-mode)
;;   )

;; (use-package nimbus-theme)

;; (use-package monokai-theme)

;; (use-package base16-theme
;;   :ensure t
;;   :config
;;   (load-theme 'base16-default-dark t)
;;   )

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; put these at bottom of this file
;; because i put some modes in this use-package code
;; block which not want to display in modeline
(use-package delight
  :delight
  :delight page-break-lines-mode
  :delight undo-tree-mode
  :delight abbrev-mode
  :delight eldoc-mode
  :delight lsp-mode
  :delight lsp
  )

(provide 'init-packages)
