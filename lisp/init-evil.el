;; evil leader key
;; (setq evil-leader/in-all-states t)

(global-evil-leader-mode)

(evil-leader/set-key
  ;; switch window
  "1" 'select-window-1
  "2" 'select-window-2
  "3" 'select-window-3
  "4" 'select-window-4
  "5" 'select-window-5
  "6" 'select-window-6
  "7" 'select-window-7
  ;;
  "a" 'evil-first-non-blank
  "e" 'evil-end-of-line
  "ff" 'find-file
  "sb" 'switch-to-buffer
  "sp" 'switch-to-prev-buffer
  "qq" 'evil-buffer
  "zz" 'save-buffer
  "SPC" 'counsel-M-x
  "ss" 'ff-find-other-file
  "mm" 'evil-jump-item
  "tt" 'neotree-toggle
  "yy" 'youdao-dictionary-search-at-point
  "yd" 'youdao-dictionary-search-from-input
  "rr" 'er/expand-region
  "tb" 'projectile-speedbar-toggle
  "fs" 'isearch-forward-regexp
  "bs" 'isearch-backward-regexp
  "rs" 'replace-regexp
  "kb" 'kill-buffer)


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
