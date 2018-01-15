;; swiper setting
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)

;; 下面的这些函数可以让你找到不同函数，变量以及快捷键所定义的文件位置
;; 因为非常常用 所以我们建议将其设置为与查找文档类似的快捷键
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; minefunc 快速打开配置文件
(global-set-key (kbd "C-x C-m") 'open-init-file)

;;
;; (global-set-key (kbd "C-c p f") 'counsel-git)

;; 打开recent files
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; minefunc 增强occur
(global-set-key (kbd "M-s o") 'occur-dwim)

;; counsel-imenu bind
(global-set-key (kbd "M-s i") 'counsel-imenu)

;; expand bind
(require 'expand-region)
(global-set-key (kbd "M-s =") 'er/expand-region)

;; iedit bind
(global-set-key (kbd "M-s e") 'iedit-mode)

;; org bind
(global-set-key (kbd "C-c a") 'org-agenda)

;; minefunc org template
(global-set-key (kbd "C-c r") 'org-capture)

;; dired重用buffer
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; 使用 c-n/c-p 来选择 company 的候选补全项
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; helm-ag bind
;; (global-set-key (kbd "C-c p s") 'helm-ag)

;; auto-yasnippet bind
(global-set-key (kbd "H-w") #'aya-create)
(global-set-key (kbd "H-y") #'aya-expand)

;; set C-w delte a word backward
(global-set-key (kbd "C-w") 'backward-kill-word)


;; youdao-dictionary bindings
;; (global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)


;; switch cpp and h
(global-set-key (kbd "C-x C-o") 'ff-find-other-file)

;; emacs-counsel-gtags
(with-eval-after-load 'counsel-gtags
  (define-key counsel-gtags-mode-map (kbd "M-t") 'counsel-gtags-find-definition)
  (define-key counsel-gtags-mode-map (kbd "M-r") 'counsel-gtags-find-reference)
  (define-key counsel-gtags-mode-map (kbd "M-s") 'counsel-gtags-find-symbol)
  (define-key counsel-gtags-mode-map (kbd "M-,") 'counsel-gtags-go-backward))

;; line begin and end
(global-set-key (kbd "C-a") 'beginning-of-line)
(global-set-key (kbd "C-e") 'end-of-line)

;; projectile-speedbar
(global-set-key (kbd "M-<f2>") 'projectile-speedbar-open-current-buffer-in-tree)

;; browse-kill-ring
(global-set-key "\C-cy" 'browse-kill-ring)

;; fix-word
(global-set-key (kbd "M-u") 'fix-word-upcase)
(global-set-key (kbd "M-l") 'fix-word-downcase)
(global-set-key (kbd "M-c") 'fix-word-capitalize)

;; function-args
;; (global-set-key (kbd "M-g") 'fa-abort)

(global-set-key (kbd "C-.") #'imenu-anywhere)

(provide 'init-keybindings)
