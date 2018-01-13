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

(provide 'init-org)
