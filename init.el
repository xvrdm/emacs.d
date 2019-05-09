;; (require 'org-install)
;; (require 'ob-tangle)
;; (org-babel-load-file (expand-file-name "liang.org" user-emacs-directory))

;; this is master write
;; master write 2

;;-------------------------------------------------------------
;; reference from zilongshanren
;;-------------------------------------------------------------
;; (setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPaht='tramp.%%C' -o ControlPersist=no")
;; (setq byte-compile-warnings '(not obsolete))

(setq gc-cons-threshold (* 500 1000 1000))

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-packages)
(require 'init-ui)

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

(unless window-system
  (add-hook 'after-init-hook
            (lambda () (require 'init-modeline))))

;; (require 'init-modeline)

(with-eval-after-load 'evil
  (require 'init-evil)
  (require 'init-keybindings))
(add-hook 'after-init-hook (lambda () (require 'init-company)))
(add-hook 'after-init-hook (lambda () (require 'init-tags)))
(add-hook 'after-init-hook (lambda () (require 'init-eshell)))
(add-hook 'after-init-hook (lambda () (require 'init-dired)))
(add-hook 'after-init-hook (lambda () (require 'init-org)))
(add-hook 'after-init-hook (lambda () (require 'init-better-default)))
;; (add-hook 'after-init-hook (lambda () (require 'init-keybindings)))
(add-hook 'after-init-hook (lambda () (require 'init-minefunc)))
(add-hook 'after-init-hook (lambda ()
                             (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
                             (if (file-exists-p (expand-file-name "custom.el"))
                                 (load-file custom-file))))

(setq gc-cons-threshold (* 2 1000 1000))
;; ycmd write 2
