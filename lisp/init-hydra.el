;; -*- coding: utf-8; lexical-binding: t; -*-
;;-------------------------------------------------------------
;; init-hydra
;;-------------------------------------------------------------
(use-package hydra
  :after evil
  :ensure t
  :config
  ;; org
  (defhydra hydra-org (:color red :hint nil)
    "
    ^outline^                              ^org^
    ^^^^^^^^-----------------------------------------------------
    _h_: previous visible heading line     _oa_: org-agenda
    _l_: next visible heading line         _oc_: org-capture
    _j_: same level forward        
    _k_: same level backward
    "
    ("h" outline-previous-visible-heading)
    ("l" outline-next-visible-heading)
    ("j" outline-forward-same-level)
    ("k" outline-backward-same-level)
    ("oa" org-agenda)
    ("oc" org-capture)
    ("q" nil "cancel" :color bule)
    )
  (evil-define-key 'normal org-mode-map ",o" #'hydra-org/body)
  ;; fwar34
  (defhydra hydra-fwar34 (:color blue)
    "fwar34 commands"
    ("li" fwar34/insert-lisp-commit "lisp commit")
    ("py" fwar34/insert-python "python commit")
    ("q" nil "cancale" :color blue))
  (define-key evil-normal-state-map (kbd "M-f") #'hydra-fwar34/body)

  ;; M-m
  (defhydra hydra-M-m (:color pink :hint nil)
    "
    ^kill-ring^                  ^iedit-mode^   
    ^^^^^^^^---------------------------------------
    _p_: paste from clipboard    _ie_: iedit mode
    "
    ("p" clipboard-yank)
    ("ie" iedit-mode)
    ("q" nil "cancale" :color blue))
  (global-set-key (kbd "M-l") #'hydra-M-m/body)
  )

(provide 'init-hydra)


(define-prefix-command 'M-m-map)
(global-set-key (kbd "M-m") 'M-m-map)
;; swiper setting
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-m p") 'clipboard-yank)
(global-set-key (kbd "M-m u") 'eval-last-sexp)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-m M-m") 'counsel-find-file)

;; iedit bind
(global-set-key (kbd "M-m oe") 'iedit-mode)
;; org bind
(global-set-key (kbd "M-m oa") 'org-agenda)
;; minefunc org template
(global-set-key (kbd "M-m oc") 'org-capture)

;; http://ergoemacs.org/emacs/emacs_dired_tips.html
;; (require 'dired )
;; (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
;; (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory

;; dired重用buffer
;; (put 'dired-find-alternate-file 'disabled nil)
;; (with-eval-after-load 'dired
;;   (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;;   (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file ".."))))  ; was dired-up-directory


;; 使用 c-n/c-p 来选择 company 的候选补全项
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "TAB") #'company-select-next-if-tooltip-visible-or-complete-selection)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  )

;; auto-yasnippet bind
(global-set-key (kbd "H-w") #'aya-create)
(global-set-key (kbd "H-y") #'aya-expand)

;; set C-w delte a word backward
;; (global-set-key (kbd "C-w") 'backward-kill-word)
;; browse-kill-ring
(global-set-key (kbd "M-m y") 'browse-kill-ring)

;; fix-word
(global-set-key (kbd "M-u") 'fix-word-upcase)
(global-set-key (kbd "M-l") 'fix-word-downcase)
(global-set-key (kbd "M-c") 'fix-word-capitalize)

;; function-args
;; (global-set-key (kbd "M-g") 'fa-abort)

(global-set-key (kbd "M-m .") #'imenu-anywhere)
(global-set-key (kbd "M-o c") #'(lambda() (interactive) (set-input-method "pyim")))

(provide 'init-keybindings)
