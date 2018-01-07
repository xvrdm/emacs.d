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
  "SPC" 'counsel-M-x
  ;; highlight-symbol
  "hs" 'highlight-symbol
  "hn" 'highlight-symbol-next
  "hp" 'highlight-symbol-prev
  "hr" 'highlight-symbol-query-replace
  ;;
  "x2" 'split-window-below
  "x3" 'split-window-right
  "do" 'delete-other-windows
  "ff" 'find-file
  "sb" 'switch-to-buffer
  "sp" 'switch-to-prev-buffer
  "qq" 'evil-buffer
  "zz" 'save-buffer
  "ss" 'ff-find-other-file
  "mm" 'evil-jump-item
  "mf" 'mf/mirror-region-in-multifile
  "tt" 'neotree-toggle
  "yy" 'youdao-dictionary-search-at-point
  "yd" 'youdao-dictionary-search-from-input
  "rr" 'er/expand-region
  "rf" 'recentf-open-files
  "tb" 'projectile-speedbar-toggle
  "fs" 'isearch-forward-regexp
  "bs" 'isearch-backward-regexp
  "rs" 'replace-regexp
  "kb" 'kill-buffer
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "."  'evilnc-copy-and-comment-operator
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
  )

(define-key evil-normal-state-map (kbd "ge") 'evil-goto-line)
;; (define-key evil-normal-state-map (kbd "SPC-qq") 'save-buffers-kill-terminal)
(define-key evil-normal-state-map (kbd "M-i") 'fa-show)
(define-key evil-normal-state-map (kbd "M-u") 'fix-word-upcase)
(define-key evil-normal-state-map (kbd "M-l") 'fix-word-downcase)
(define-key evil-normal-state-map (kbd "M-c") 'fix-word-capitalize)
(define-key evil-normal-state-map (kbd "M-g") 'fa-abort)

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

;;evil-easymotion
(evilem-default-keybindings "SPC")


(provide 'init-evil)
