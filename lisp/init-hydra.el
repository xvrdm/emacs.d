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

  ;; test
  (defun hydra-vi/pre ()
    (set-cursor-color "#e52b50"))

  (defun hydra-vi/post ()
    (set-cursor-color "#ffffff"))
  (global-set-key
   (kbd "M-u z")
   (defhydra hydra-vi (:pre hydra-vi/pre :post hydra-vi/post :color amaranth)
     "vi"
     ("l" forward-char)
     ("h" backward-char)
     ("j" next-line)
     ("k" previous-line)
     ("m" set-mark-command "mark")
     ("a" move-beginning-of-line "beg")
     ("e" move-end-of-line "end")
     ("d" delete-region "del" :color blue)
     ("y" kill-ring-save "yank" :color blue)
     ("q" nil "quit")))
    (hydra-set-property 'hydra-vi :verbosity 1)
    
  ;; window
  (defhydra hydra-window
    (:color red :hint nil)
    "
                               -- WINDOW MENU --
    "
    
    ("z" ace-window "ace" :color blue :column "1-Switch")
    ("h" windmove-left "← window")
    ("j" windmove-down "↓ window")
    ("k" windmove-up "↑ window")
    ("l" windmove-right "→ window")
    ("s" split-window-below "split window" :color blue :column "2-Split Management")
    ("v" split-window-right "split window vertically" :color blue)
    ("d" delete-window "delete current window")
    ("f" follow-mode "toogle follow mode")
    ("u" winner-undo "undo window conf" :column "3-Undo/Redo")
    ("r" winner-redo "redo window conf")
    ("b" balance-windows "balance window height" :column "4-Sizing")
    ("m" maximize-window "maximize current window")
    ("M" minimize-window "minimize current window")
    ("q" nil "quit menu" :color blue :column nil))
  (global-set-key (kbd "M-u w") #'hydra-window/body)

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
  (defhydra hydra-fwar34 (:color blue :columns 3)
    "
            -- MY COMMANDS --
    "
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
  (global-set-key (kbd "M-u y") #'hydra-pyim/body))

(provide 'init-hydra)
