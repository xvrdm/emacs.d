(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  ;; (setq package-archives '(("gnu"   . "https://elpa.emacs-china.org/gnu/")
  ;;                         ("melpa" . "https://elpa.emacs-china.org/melpa/"))))
  (setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                           ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
  )

(defun require-package (package)
  "refresh package archives, check package presence and install if it's not installed"
  (if (null (require package nil t))
      (progn (let* ((ARCHIVES (if (null package-archive-contents)
                                  (progn (package-refresh-contents)
                                         package-archive-contents)
                                package-archive-contents))
                    (AVAIL (assoc package ARCHIVES)))
               (if AVAIL
                   (package-install package)))
             (require package))))

;; use-package
(require-package 'use-package)
(require 'use-package)
;; (setq use-package-always-ensure t)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (require 'package)
  (package-refresh-contents)
  (package-install 'el-get)
  (require 'el-get))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; (el-get 'sync)

;; :el-get keyword for use-package
(use-package use-package-el-get
  :ensure t
  :config 
  (use-package-el-get-setup)
  )

;; chords
(use-package use-package-chords
  :ensure t
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme
(use-package monokai-theme
  :ensure t
  :config
  (if (and (eq system-type 'windows-nt) (> emacs-major-version 24))
      (add-hook 'window-setup-hook '(lambda () (load-theme 'monokai t)))
    (add-hook 'after-init-hook '(lambda () (load-theme 'monokai t))))
  (setq monokai-height-minus-1 0.8
        monokai-height-plus-1 1.0
        monokai-height-plus-2 1.0
        monokai-height-plus-3 1.0
        monokai-height-plus-4 1.0)
  ;; If you would like to use variable-pitch-mode you can enable it with:
  (setq monokai-user-variable-pitch t)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (and (display-graphic-p) (>= emacs-major-version))
  (use-package posframe :ensure t))

(use-package pyim
  :ensure t
  :demand t
  :config
  ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
  (use-package pyim-basedict
    :ensure t
    :config (pyim-basedict-enable))

  (setq default-input-method "pyim")

  ;; 我使用全拼
  ;; (setq pyim-default-scheme 'quanpin)
  ;; (setq pyim-default-scheme 'pyim-shuangpin)
  (setq pyim-default-scheme 'xiaohe-shuangpin)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  ;; 开启拼音搜索功能
  ;; (pyim-isearch-mode 1)

  ;; 使用 pupup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (if (and (display-graphic-p) (>= emacs-major-version 26))
      (setq pyim-page-tooltip 'posframe)
    (setq pyim-page-tooltip 'popup))

  ;; 选词框显示5个候选词
  (setq pyim-page-length 5)

  ;; 让 Emacs 启动时自动加载 pyim 词库
  ;; (add-hook 'emacs-startup-hook
  ;;           #'(lambda() (pyim-restart-1 t)))

  :bind
  (;; ("M-o ;" . pyim-delete-word-from-personal-buffer))
   ("M-o o" . pyim-convert-string-at-point)) ;与 pyim-probe-dynamic-english 配合
  )

;; (setq evil-want-keybinding nil) must put before load evil
;; See https://github.com/emacs-evil/evil-collection/issues/60 for more details.
(setq evil-want-keybinding nil)

;; https://github.com/emacs-evil/evil-collection
;; evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  :config
  (evil-mode 1)
  )

(use-package goto-chg
  :ensure t
  )

;; evil-collection
(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init)
  )

(use-package hungry-delete
  :ensure t
  :defer
  :delight hungry-delete-mode
  :config
  (global-hungry-delete-mode)
  ;; https://emacs-china.org/t/smartparens/2778/7
  ;; fix hungry-delete & smartparents conflict
  (defadvice hungry-delete-backward (before sp-delete-pair-advice activate)
    (save-match-data (sp-delete-pair (ad-get-arg 0))))
  )

(use-package expand-region
  :ensure t
  )

(use-package counsel
  ;; counsel repository contains:
  ;; Ivy, a generic completion mechanism for Emacs.
  ;; Counsel, a collection of Ivy-enhanced versions of common Emacs commands.
  ;; Swiper, an Ivy-enhanced alternative to isearch.
  :ensure t
  ;; :defer
  :bind ([remap switch-to-buffer] . #'ivy-switch-buffer)
  :config
  (setq ivy-initial-inputs-alist nil
        ivy-wrap t
        ivy-height 15
        ivy-fixed-height-minibuffer t
        ivy-format-function #'ivy-format-function-line
        ivy-use-virtual-buffers t)
  (ivy-mode +1) 
  (setq enable-recursive-minibuffers t)
  )

;; smartparens setting
(use-package smartparens
  :ensure t
  :delight smartparens-global-mode
  :delight smartparens-mode
  :config
  (smartparens-global-mode t)
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
  )

;; js2-mode setting
(use-package js2-mode
  :ensure t
  :config
  (setq auto-mode-alist (append '(("\\.js\\'" . js2-mode)) auto-mode-alist))
  )


;; nodejs-repl setting
;; (require 'nodejs-repl)

;; setting add-node-modules-path
;; (eval-after-load 'js2-mode
;;                  '(add-hook 'js2-mode-hook #'add-node-modules-path))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

  (define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
  )

(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
  (add-hook 'html-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  )

;; popwin setting
(use-package popwin
  :ensure t
  :delight popwin-mode
  :config
  (popwin-mode t)
  )

(use-package powershell
  :ensure t
  :if (eq system-type 'windows-nt)
  )

;; 开启全局company
(use-package company
  :ensure t
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

(use-package fzf
  :ensure t
  )

;; org-pomodoro setting
(use-package org-pomodoro
  :ensure t
  :delight org-pomodoro)

(use-package org2jekyll
  :ensure t
  :config
  (custom-set-variables '(org2jekyll-blog-author "feng")
                        ;; '(org2jekyll-source-directory (expand-file-name "~/test/org"))
                        ;; '(org2jekyll-jekyll-directory (expand-file-name "~/test/public_html"))
                        '(org2jekyll-source-directory  "")
                        '(org2jekyll-jekyll-directory  "")
                        '(org2jekyll-jekyll-drafts-dir "")
                        ;; '(org2jekyll-jekyll-posts-dir  "_posts/")
                        '(org2jekyll-jekyll-posts-dir "")
                        '(org-publish-project-alist
                          `(("default"
                             :base-directory ,(org2jekyll-input-directory)
                             :base-extension "org"
                             ;; :publishing-directory "/ssh:user@host:~/html/notebook/"
                             :publishing-directory ,(org2jekyll-output-directory)
                             :publishing-function org-html-publish-to-html
                             :headline-levels 4
                             :section-numbers nil
                             :with-toc nil
                             :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>"
                             :html-preamble t
                             :recursive t
                             :make-index t
                             :html-extension "html"
                             :body-only t)

                            ("post"
                             :base-directory ,(org2jekyll-input-directory)
                             :base-extension "org"
                             :publishing-directory ,(org2jekyll-output-directory org2jekyll-jekyll-posts-dir)
                             :publishing-function org-html-publish-to-html
                             :headline-levels 4
                             :section-numbers nil
                             :with-toc nil
                             :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>"
                             :html-preamble t
                             :recursive t
                             :make-index t
                             :html-extension "html"
                             :body-only t)

                            ("images"
                             :base-directory ,(org2jekyll-input-directory "img")
                             :base-extension "jpg\\|gif\\|png"
                             :publishing-directory ,(org2jekyll-output-directory "img")
                             :publishing-function org-publish-attachment
                             :recursive t)

                            ("js"
                             :base-directory ,(org2jekyll-input-directory "js")
                             :base-extension "js"
                             :publishing-directory ,(org2jekyll-output-directory "js")
                             :publishing-function org-publish-attachment
                             :recursive t)

                            ("css"
                             :base-directory ,(org2jekyll-input-directory "css")
                             :base-extension "css\\|el"
                             :publishing-directory ,(org2jekyll-output-directory "css")
                             :publishing-function org-publish-attachment
                             :recursive t)

                            ;; ("web" :components ("images" "js" "css"))
                            )))
  )

;; magit setting
(use-package magit
  :ensure t
  :delight magit-mode
  :config
  )

;; evil-magit setting
;; (require 'evil-magit)
(use-package evil-magit
  :ensure t
  :delight
  :config
  ;; https://www.helplib.com/GitHub/article_131559
  ;; (evil-define-key evil-magit-state magit-mode-map "?"'evil-search-backward)
  )

(use-package xpm
  :ensure t
  )

;; yasnippet setting
(use-package yasnippet
  :ensure t
  :delight yas-global-mode
  :delight yas-minor-mode
  :config
  (yas-global-mode 1)
  )
;; (yas-reload-all)
;; (add-hook 'prog-mode-hook #'yas-minor-mode)

;; youdao-dictionary
(use-package youdao-dictionary
  :ensure t
  :config
  ;; Enable Cache
  (setq url-automatic-caching t)
  ;; Integrate with popwin-el (https://github.com/m2ym/popwin-el)
  (push "*Youdao Dictionary*" popwin:special-display-config)
  ;; Set file path for saving search history
  (setq youdao-dictionary-search-history-file "~/.emacs.d/.youdao")
  ;; Enable Chinese word segmentation support (支持中文分词)
  (setq youdao-dictionary-use-chinese-word-segmentation t)
  )

(use-package go-mode
  :ensure t
  :config
  (autoload 'go-mode "go-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
  )

(use-package rust-mode
  :ensure t
  :config
  (autoload 'rust-mode "rust-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  ;; The rust-format-buffer function will format your code with rustfmt if installed.
  ;; By default, this is bound to C-c C-f.
  ;; Placing (setq rust-format-on-save t) in your ~/.emacs will enable automatic
  ;; running of rust-format-buffer when you save a buffer.
  (setq rust-format-on-save t)
  )

(use-package which-key
  :ensure t
  :delight which-key-mode
  :init
  (setq which-key-allow-imprecise-window-fit t) ; performance
  (setq which-key-separator ":")
  :config
  (which-key-mode 1)
  )

;; https://www.emacswiki.org/emacs/NeoTree
(use-package neotree
  :ensure t
  :delight neotree-mode
  :config
  (global-set-key [f8] 'neotree-toggle)
  ;; Note: For users who want to use the icons theme. Pls make sure you have
  ;; installed the all-the-icons package and its fonts.
  ;; (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-theme (when (display-graphic-p) 'icons))
  ;; Every time when the neotree window is opened, let it find current file and jump to node.
  (setq neo-smart-open t)
  ;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically.
  (setq projectile-switch-project-action 'neotree-projectile-action)
  ;; Similar to find-file-in-project, NeoTree can be opened (toggled) at projectile project root as follows:
  (defun neotree-project-dir ()
    "Open NeoTree using the git root."
    (interactive)
    (let ((project-dir (projectile-project-root))
          (file-name (buffer-file-name)))
      (neotree-toggle)
      (if project-dir
          (if (neo-global--window-exists-p)
              (progn
                (neotree-dir project-dir)
                (neotree-find file-name)))
        (message "Could not find git project root."))))
  ;; If you use evil-mode, by default some of evil key bindings conflict with neotree-mode keys. For example,
  ;; you cannot use q to hide NeoTree. To make NeoTree key bindings in effect, you can bind those keys
  ;; in evil-normal-state-local-map in neotree-mode-hook, as shown in below code:
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "g") 'neotree-refresh)
              (define-key evil-normal-state-local-map (kbd "n") 'neotree-next-line)
              (define-key evil-normal-state-local-map (kbd "p") 'neotree-previous-line)
              (define-key evil-normal-state-local-map (kbd "A") 'neotree-stretch-toggle)
              (define-key evil-normal-state-local-map (kbd "H") 'neotree-hidden-file-toggle)))
  )

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  )

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  )

(use-package lispy
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
  )

(use-package lispyville
  :ensure t
  :config
  (add-hook 'lispy-mode-hook #'lispyville-mode)
  )

;; linum-relative
;; (use-package linum-relative
;;   :delight linum-relative-mode
;;   :config
;;   ;; (linum-relative-toggle)
;;   )

(use-package rainbow-delimiters
  :ensure t
  :delight rainbow-delimiters-mode
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

;; beacon
(use-package beacon
  :ensure t
  :delight beacon-mode
  :config
  (beacon-mode 1)
  )


;; end https://github.com/jojojames/evil-collection
;; (require 'evil-leader)
(use-package evil-escape
  :ensure t
  :delight evil-escape-mode
  )

(use-package evil-surround
  :ensure t
  :delight evil-surround-mode
  )

(use-package evil-nerd-commenter
  :ensure t
  :delight
  )

(use-package evil-easymotion
  :ensure t
  :delight
  :config
  (evilem-default-keybindings "M-m")
  )

(use-package evil-matchit
  :ensure t
  :delight evil-matchit-mode
  :config
  (global-evil-matchit-mode 1)
  )

(use-package evil-exchange
  :ensure t
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
  :ensure t
  :delight)

(use-package org
  :ensure t
  )
(use-package htmlize
  :ensure t
  )

(use-package ob-go
  :ensure t
  )
(use-package ob-rust
  :ensure t
  )

(use-package general
  :ensure t
  :delight
  :config
  (general-evil-setup t)
  )

(use-package powerline
  :ensure t
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

(set-cursor-color "green")

(use-package telephone-line
  :unless window-system
  :ensure t
  :delight
  :config
  (telephone-line-mode t)
  )

;; spaceline
(use-package spaceline
  :ensure t
  :if window-system
  :config
  ;; When nil, winum-mode will not display window numbers in the mode-line.
  ;; You might want this to be nil if you use a package that already manages window numbers in the mode-line.
  (setq winum-auto-setup-mode-line nil)
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  ;; (spaceline-spacemacs-theme))
  (spaceline-emacs-theme))

(use-package winum
  :ensure t
  :config
  (winum-mode)
  (setq winum-mode-line-position -1)
  )

(use-package highlight-symbol
  :ensure t
  :delight highlight-symbol-mode
  :config
  )

;; rainbow-mode
(use-package rainbow-mode
  :ensure t
  :delight rainbow-mode
  :config
  (rainbow-mode 1)
  )

;; multifiles
(use-package multifiles
  :ensure t
  :delight multifiles-minor-mode
  )

;; fix-word
(use-package fix-word
  :ensure t
  :delight)

;; browse-kill-ring
(use-package browse-kill-ring
  :ensure t
  :delight browse-kill-ring-mode
  )

(defun my-gtags-init()
  (when (executable-find "pygmentize")
    (setenv "GTAGSLABEL" "pygments")
    (if (eq system-type 'windows-nt)
        ;; (setenv "GTAGSCONF" (expand-file-name "~/global/share/gtags/gtags.conf"))
        (setenv "GTAGSCONF"
                (let ((str (executable-find "gtags")))
                  (string-match "global.*" str)
                  (replace-match "global/share/gtags/gtags.conf" nil nil str 0)))
      (setenv "GTAGSCONF" "/usr/local/share/gtags/gtags.conf")))
  )

;; ggtags
(use-package ggtags
  :ensure t
  :init
  (my-gtags-init)
  :delight ggtags-mode
  :config
  (setq ggtags-highlight-tag nil)
  ;; (add-hook 'c-mode-common-hook
  ;;           (lambda()
  ;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
  ;;               (ggtags-mode 1))))
  ;; (add-hook 'python-hook
  ;;           (lambda()
  ;;             (when (derived-mode-p 'python-mode)
  ;;               (ggtags-mode 1))))
  (ggtags-mode 1)
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index)
  )

(use-package symon
  :ensure t
  :delight symon-mode
  )

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  )

;; ace-window
(use-package ace-window
  :ensure t
  :delight
  )

;; hydra
;; (use-package hydra
;;   :delight
;;   )

(use-package rainbow-identifiers
  :ensure t
  :delight rainbow-identifiers-mode
  :config
  (add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
  )

;; highlight-numbers
(use-package highlight-numbers
  :ensure t
  :delight highlight-numbers-mode
  :config
  (add-hook 'prog-mode-hook 'highlight-numbers-mode)
  )

;; highlight-quoted
(use-package highlight-quoted
  :ensure t
  :delight highlight-quoted-mode
  :config
  (add-hook 'emacs-lisp-mode-hook 'highlight-quoted-mode)
  )

;; highlight-defined
(use-package highlight-defined
  :ensure t
  :delight highlight-defined-mode
  :config
  (add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)
  )

(use-package evil-snipe
  :ensure t
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
  :ensure t
  :delight evil-smartparens-mode
  :config
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
  )

;; evil-visualstar
(use-package evil-visualstar
  :ensure t
  :delight evil-visualstar-mode
  :config
  (global-evil-visualstar-mode)
  )

;; evil-indent-plus
(use-package evil-indent-plus
  :ensure t
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

(use-package highlight-parentheses
  :ensure t
  :delight highlight-parentheses-mode
  :config
  ;; (add-hook 'prog-mode-hook 'highlight-parentheses-mode)
  (define-globalized-minor-mode global-highlight-parentheses-mode
    highlight-parentheses-mode
    (lambda()
      (highlight-parentheses-mode t)))
  (global-highlight-parentheses-mode t)
  )

;; direx
(use-package direx
  :ensure t
  :config
  )


;; imenu-list
(use-package imenu-list
  :ensure t
  :delight
  :config
  )

;; rich-minority
(use-package rich-minority
  :ensure t
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
  :ensure t
  :defer
  :delight
  :config
  (smex-initialize)
  )

(use-package ivy-xref
  :ensure t
  :config
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
  )

(use-package fringe-helper
  :ensure t
  :init
  :delight
  :config
  )

(use-package git-gutter
  :ensure t
  :config
  ;; If you enable global minor mode
  (global-git-gutter-mode t)
  ;; If you would like to use git-gutter.el and linum-mode
  (when (not (display-graphic-p)) (git-gutter:linum-setup))
  ;; Use for 'Git'(`git`), 'Mercurial'(`hg`), 'Bazaar'(`bzr`), and 'Subversion'(`svn`) projects
  ;; (custom-set-variables '(git-gutter:handled-backends '(git hg bzr svn)))
  (custom-set-variables '(git-gutter:handled-backends '(git svn)))
  ;; inactivate git-gutter-mode in asm-mode and image-mode
  (custom-set-variables '(git-gutter:disabled-modes '(asm-mode image-mode)))
  ;; Hide gutter when there are no changes if git-gutter:hide-gutter is non-nil. (Default is nil)
  (custom-set-variables '(git-gutter:hide-gutter t))
  ;; diff information is updated at hooks in git-gutter:update-hooks.
  (add-to-list 'git-gutter:update-hooks 'focus-in-hook)
  ;; diff information is updated after command in git-gutter:update-commands executed.
  (add-to-list 'git-gutter:update-commands 'other-window)
  ;; (custom-set-variables
  ;;  '(git-gutter:modified-sign "~") ;; two space
  ;;  '(git-gutter:added-sign "++")    ;; multiple character is OK
  ;;  '(git-gutter:deleted-sign "--"))
  ;; (set-face-background 'git-gutter:modified "purple") ;; background color
  ;; (set-face-foreground 'git-gutter:added "green")
  ;; (set-face-foreground 'git-gutter:deleted "red")
  ;; (set-face-background 'git-gutter:modified "purple") ;; background color
  ;; (set-face-background 'git-gutter:added "green")
  ;; (set-face-background 'git-gutter:deleted "red")
  ;; Jump to next/previous hunk
  ;; (define-key evil-normal-state-map (kbd "[ c") 'git-gutter:previous-hunk)
  ;; (define-key evil-normal-state-map (kbd "] c") 'git-gutter:next-hunk)
  ;; (define-key evil-normal-state-map (kbd "] s") 'git-gutter:stage-hunk)
  )

(use-package git-gutter-fringe
  :ensure t
  :if (display-graphic-p)
  :config
  (set-face-foreground 'git-gutter-fr:modified "purple")
  (set-face-foreground 'git-gutter-fr:added    "green")
  (set-face-foreground 'git-gutter-fr:deleted  "red")
  )

(use-package company-statistics
  :ensure t
  :config
  (add-hook 'after-init-hook 'company-statistics-mode)
  )

(use-package company-c-headers
  :ensure t
  :config
  (add-to-list 'company-backends 'company-c-headers)
  )

(use-package ace-popup-menu
  :ensure t
  :config
  (ace-popup-menu-mode 1)
  )

(use-package company-jedi
  :ensure t
  :config
  (defun my/python-mode-hook ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'my/python-mode-hook)
  )

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; put these at bottom of this file
;; because i put some modes in this use-package code
;; block which not want to display in modeline
(use-package delight
  :ensure t
  :delight
  :delight page-break-lines-mode
  :delight undo-tree-mode
  :delight abbrev-mode
  :delight eldoc-mode
  :delight lsp-mode
  :delight lsp
  )

(provide 'init-packages)
