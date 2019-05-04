;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;; (require 'org-install)
;; (require 'ob-tangle)
;; (org-babel-load-file (expand-file-name "liang.org" user-emacs-directory))

;; this is master write
;; master write 2

;;-------------------------------------------------------------
;; reference from zilongshanren
;;-------------------------------------------------------------
(setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPaht='tramp.%%C' -o ControlPersist=no")
(setq byte-compile-warnings '(not obsolete))

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
;; (require 'init-modeline)
                          
;; cl - Common List Extension
(require 'cl-lib)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p (expand-file-name "custom.el"))
    (load-file custom-file))

;; ycmd write 2
