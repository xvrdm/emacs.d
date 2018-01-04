;; evil leader key
(global-evil-leader-mode)
(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
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
