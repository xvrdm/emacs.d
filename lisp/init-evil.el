;; evil leader key
(setq evil-leader/in-all-states t)

(global-evil-leader-mode)

(evil-leader/set-key
  "f" 'find-file
  "v" 'switch-to-buffer
  "p" 'switch-to-prev-buffer
  "q" 'evil-buffer
  "a" 'evil-first-non-blank
  "e" 'evil-end-of-line
  "z" 'save-buffer
  "SPC" 'counsel-M-x
  "k" 'kill-buffer)

(evil-leader/set-leader ";")

;; evil setting
(evil-mode)

;; evil-surround setting
(require 'evil-surround)
(global-evil-surround-mode)

;; evil-nerd-commenter
(evilnc-default-hotkeys)

;; evil-escape
(setq-default evil-escape-key-sequence ";g")
(evil-esc-mode 1)

(provide 'init-evil)
