;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; add feauther to load-path
(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'init-minefunc)
(require 'init-packages)
(require 'init-ui)
(require 'init-org)
(require 'init-better-default)
(require 'init-keybindings)

;; cl - Common List Extension
(require 'cl)

(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))

(load-file custom-file)
