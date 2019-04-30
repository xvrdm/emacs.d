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

(package-initialize)

;; add feauther to load-path
(add-to-list 'load-path "~/.emacs.d/lisp")
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/lisp")
(require 'init-packages)
(require 'init-minefunc)
(require 'init-ui)
(require 'init-org)
(require 'init-better-default)
(require 'init-keybindings)
(require 'init-evil)
(require 'init-company)
(require 'init-eshell)
;; (require 'init-modeline)
                          
;; cl - Common List Extension
(require 'cl-lib)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p (expand-file-name "custom.el"))
    (load-file custom-file))

;; ycmd write 2
