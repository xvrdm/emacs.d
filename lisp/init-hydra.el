;; -*- coding: utf-8; lexical-binding: t; -*-
(use-package hydra
  :after evil
  :ensure t
  :config)

(defhydra hydar-zoom (global-map "<f2>")
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))

(provide 'init-hydra)
