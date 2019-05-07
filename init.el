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

(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'init-packages)
(require 'init-minefunc)
(require 'init-ui)
(require 'init-org)
(require 'init-better-default)
(require 'init-keybindings)
(require 'init-evil)
(require 'init-company)
(require 'init-eshell)
(require 'init-dired)
(require 'init-tags)
                          
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p (expand-file-name "custom.el"))
    (load-file custom-file))

;; ycmd write 2
