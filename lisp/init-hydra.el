;; -*- coding: utf-8; lexical-binding: t; -*-
;;-------------------------------------------------------------
;; init-hydra
;;-------------------------------------------------------------
(use-package hydra
  :after evil
  :ensure t
  :init
  (define-prefix-command 'M-u-map)
  (global-set-key (kbd "M-u") 'M-u-map)
  :config
  ;; org
  (defhydra hydra-org (:color red :hint nil)
    "
    ^outline^                              ^org^
    ^^^^^^^^--------------------------------------------------------
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
  (define-key evil-normal-state-map (kbd "M-u f") #'hydra-fwar34/body)

  ;; M-um
  (defhydra hydra-M-um (:color pink :hint nil)
    "
    ^kill-ring^                  ^iedit-mode^        ^fix-word^
    ^^^^^^^^-----------------------------------------------------------------------
    _p_: paste from clipboard    _ie_: iedit mode    _u_: fix-word-upcase
    ^ ^                          ^  ^                _d_: fix-word-downcase
    ^ ^                          ^  ^                _c_: fix-word-capitalize
    "
    ("p" clipboard-yank)
    ("ie" iedit-mode)
    ("u" fix-word-upcase)
    ("d" fix-word-downcase)
    ("c" fix-word-capitalize)
    ("q" nil "cancale" :color blue))
  (global-set-key (kbd "M-u m") #'hydra-M-um/body)
  ;; pyim
  (defhydra hydra-pyim (:color pink :hint nil)
    "
    ^pyim^                  
    ^^^^^^^^-----------------
    _se_: set input pyim   
    "
    ("se" (lambda () (set-input-method "pyim")))
    ("q" nil "cancale" :color blue))
  (global-set-key (kbd "M-u y") #'hydra-pyim/body)
  )

(provide 'init-hydra)
