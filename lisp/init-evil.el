;; evil leader key
;; (setq evil-leader/in-all-states t)

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
  "ss" 'ff-find-other-file
  "mm" 'evil-jump-item
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "4" 'select-window-4
  "5" 'select-window-5
  "6" 'select-window-6
  "7" 'select-window-7
  "tt" 'neotree-toggle
  "yy" 'youdao-dictionary-search-at-point
  "yd" 'youdao-dictionary-search
  "rr" 'er/expand-region
  "tb" 'projectile-speedbar-toggle
  "k" 'kill-buffer)


 ;; (define-key evil-insert-state-map (kbd ";g") 'evil-normal-state)
 ;; (define-key evil-insert-state-map (kbd ";a") 'evil-first-non-blank)
 ;; (define-key evil-insert-state-map (kbd ";e") 'evil-end-of-line)
 ;; (define-key evil-insert-state-map (kbd ";w") 'evil-delete-backward-word)

(evil-leader/set-leader ";")

;; evil setting
(evil-mode)

;; evil-surround setting
(global-evil-surround-mode)

;; evil-nerd-commenter
(evilnc-default-hotkeys)

;; evil-escape
(evil-escape-mode 1)
(setq-default evil-escape-delay 0.3)
(setq-default evil-escape-key-sequence ";g")

(provide 'init-evil)
