;; -*- coding: utf-8; lexical-binding: t; -*-
;;-------------------------------------------------------------
;; init-modeline
;; https://blog.csdn.net/xh_acmagic/article/details/78939246
;;-------------------------------------------------------------
(use-package powerline
  :disabled
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

(use-package telephone-line
  :disabled
  :unless window-system
  :ensure t
  :delight
  :config
  (telephone-line-mode t)
  )

(unless window-system
  (add-hook 'after-init-hook
            (lambda () (require 'init-my-modeline))))

;; (use-package init-my-modeline
;;   :load-path "lisp"
;;   :unless window-system
;;   )

;; spaceline
(use-package spaceline
  ;; :disabled
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
