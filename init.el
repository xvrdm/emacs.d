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

(setq gc-cons-threshold (* 50 1000 1000))

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook (lambda ()
                                (message "Emacs ready in %s with %d garbage collections."
                                         (format "%.2f seconds"
                                                 (float-time
                                                  (time-subtract after-init-time before-init-time)))
                                         gcs-done)))

(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-packages)
(require 'init-minefunc)
(require 'init-ui)
(require 'init-org)
(require 'init-better-default)
(require 'init-keybindings)
(add-hook 'after-init-hook (lambda () (require 'init-evil)))
(add-hook 'after-init-hook (lambda () (require 'init-company)))
(add-hook 'after-init-hook (lambda () (require 'init-tags)))
;; (require 'init-evil)
;; (require 'init-company)
(require 'init-eshell)
(require 'init-dired)
;; (require 'init-tags)
                          
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p (expand-file-name "custom.el"))
    (load-file custom-file))

(setq gc-cons-threshold (* 2 1000 1000))
;; ycmd write 2
