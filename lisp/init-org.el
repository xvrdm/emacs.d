;; org-mode
(with-eval-after-load 'org
  (setq org-agenda-files '("~/.emacs.d"))

  (setq org-capture-templates
	'(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "工作安排")
	   "* TODO [#B] %?\n  %i\n"
	   :empty-lines 1)))
  
  (setq org-src-fontify-natively t))

(add-hook 'org-mode-hook 'evil-org-mode)
;; (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)
;; https://github.com/Somelauw/evil-org-mode#common-issues
(setq evil-want-C-i-jump nil)

;; 默认情况下，Org Mode没有打开Markdown文档的转换功能，需要将下面的小代码放到Emacs 的启动配置文件中：
(setq org-export-backends (quote (ascii html icalendar latex md)))

;; 在配置文件中（我使用的是模块化的配置，所以我的配置在 init-org.el 文件中）增加如下程序，就可实现 org-mode 中的自动换行。
(add-hook 'org-mode-hook 
	  (lambda () (setq truncate-lines nil)))

(provide 'init-org)
