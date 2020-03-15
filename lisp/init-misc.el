;; -*- coding: utf-8; lexical-binding: t; -*-

;; {{ auto-save.el
;; reference from https://github.com/redguardtoo/emacs.d
(with-eval-after-load 'evil
  (progn
    (local-require 'auto-save)
    (add-to-list 'auto-save-exclude 'file-too-big-p t)
    (setq auto-save-idle 2) ; 2 seconds
    (auto-save-enable)
    (setq auto-save-slient t)
    ))
;; }}

(provide 'init-misc)
