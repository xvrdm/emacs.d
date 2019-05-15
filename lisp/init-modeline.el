;; -*- coding: utf-8; lexical-binding: t; -*-
;;-------------------------------------------------------------
;; init-modeline
;; https://blog.csdn.net/xh_acmagic/article/details/78939246
;;-------------------------------------------------------------

(use-package telephone-line
  :disabled
  :unless window-system
  :ensure t
  :delight
  :config
  (telephone-line-mode t)
  )


;; (use-package init-my-modeline
;;   :load-path "lisp"
;;   ;; :unless window-system
;;   )

(add-hook 'after-init-hook (lambda () (require 'init-my-modeline)))

;; spaceline
(use-package spaceline
  :disabled
  :ensure t
  :if window-system
  :config
  ;; When nil, winum-mode will not display window numbers in the mode-line.
  ;; You might want this to be nil if you use a package that already manages window numbers in the mode-line.
  (setq winum-auto-setup-mode-line nil)
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  ;; (spaceline-spacemacs-theme))
  (spaceline-emacs-theme))


(provide 'init-modeline)
