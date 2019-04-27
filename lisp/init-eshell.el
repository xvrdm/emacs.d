;; init eshell

;; https://emacs-china.org/t/topic/4579
(defun fwar34/esh-history ()
  "Interactive search eshell history."
  (interactive)
  (require 'em-hist)
  (save-excursion
    (let* ((start-pos (eshell-bol))
           (end-pos (point-at-eol))
           (input (buffer-substring-no-properties start-pos end-pos)))
      (let* ((command (ivy-read "Command: "
                                (delete-dups
                                 (when (> (ring-size eshell-history-ring) 0)
                                   (ring-elements eshell-history-ring)))
                                :preselect input
                                :action #'ivy-completion-in-region-action))
             (cursor-move (length command)))
        (kill-region (+ start-pos cursor-move) (+ end-pos cursor-move))
        )))
  ;; move cursor to eol
  (end-of-line)
  )

(defun fwar34/ivy-eshell-history ()
  "Interactive search eshell history."
  (interactive)
  (require 'em-hist)
  (let* ((start-pos (save-excursion (eshell-bol) (point)))
         (end-pos (point))
         (input (buffer-substring-no-properties start-pos end-pos))
         (command (ivy-read "Command: "
                            (delete-dups
                             (when (> (ring-size eshell-history-ring) 0)
                               (ring-elements eshell-history-ring)))
                            :initial-input input)))
    (setf (buffer-substring start-pos end-pos) command)
    (end-of-line))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://github.com/samrayleung/emacs.d/blob/master/lisp/init-eshell.el
;;; Inspire by http://blog.binchen.org/posts/use-ivy-mode-to-search-bash-history.html
(defun samray/parse-bash-history ()
  "Parse the bash history."
  (interactive)
  (let (collection bash_history)
    (shell-command "history -r") ; reload history
    (setq collection
          (nreverse
           (split-string (with-temp-buffer (insert-file-contents (file-truename "~/.bash_history"))
                                           (buffer-string))
                         "\n"
                         t)))
    (when (and collection (> (length collection) 0)
               (setq bash_history collection))
      bash_history)))

(defun samray/parse-zsh-history ()
  "Parse the bash history."
  (interactive)
  (let (collection zsh_history)
    (shell-command "history -r") ; reload history
    (setq collection
          (nreverse
           (split-string (with-temp-buffer (insert-file-contents (file-truename "~/.zsh_history"))
                                           (replace-regexp-in-string "^:[^;]*;" "" (buffer-string)))
                         "\n"
                         t)))
    (when (and collection (> (length collection) 0)
               (setq zsh_history collection))
      zsh_history)))

(defun samray/esh-history ()
  "Interactive search eshell history."
  (interactive)
  (require 'em-hist)
  (save-excursion
    (let* ((start-pos (eshell-beginning-of-input))
           (input (eshell-get-old-input))
           (esh-history (when (> (ring-size eshell-history-ring) 0)
                          (ring-elements eshell-history-ring)))
           (all-shell-history (append esh-history (samray/parse-zsh-history) (samray/parse-bash-history)))
           )
      (let* ((command (ivy-read "Command: "
                                (delete-dups all-shell-history)
                                :initial-input input
                                :require-match t
                                :action #'ivy-completion-in-region-action))
             )
        (eshell-kill-input)
        (insert command)
        )))
  ;; move cursor to eol
  (end-of-line))

(defun fwar34/eshell-clear-buffer ()
  "Clear terminal."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(use-package eshell
  :commands eshell
  :hook
  (eshell-mode . company-mode)
  :config
  (progn
    (when (not (functionp 'eshell/rgrep))
      (defun eshell/rgrep (&rest args)
        "Use Emacs grep facility instead of calling external grep."
        (eshell-grep "rgrep" args t)))
    (add-hook 'eshell-mode-hook
              (lambda ()(eshell-cmpl-initialize)))
    (add-hook 'eshell-mode-hook (lambda ()
                                  (setq-local global-hl-line-mode nil)))
    )
  ;; (add-hook 'eshell-mode-hook 'company-mode)
  :bind
  (;; ([remap samray/smarter-move-beginning-of-line] . eshell-bol)
   ;; ("C-a" . eshell-bol)
   ;; ([remap kill-region] . samray/kill-word-backward)
   ;; ("C-w" . samray/kill-word-backward)
   ;; ([remap evil-insert-digraph] . paredit-kill)
   ;; ("C-k" . paredit-kill)
   ([remap evil-paste-from-register] . samray/esh-history)
   ("C-r" . samray/esh-history)
   ;; ("C-l" . fwar34/eshell-clear-buffer))
   ))

(use-package esh-autosuggest
  :hook
  (eshell-mode . esh-autosuggest-mode)
  ;; If you have use-package-hook-name-suffix set to nil, uncomment and use the
  ;; line below instead:
  ;; :hook (eshell-mode-hook . esh-autosuggest-mode)
  :ensure t
  )

(use-package eshell-prompt-extras
  :ensure t
  :after eshell
  :init (progn
          (setq eshell-highlight-prompt nil
                eshell-prompt-function 'epe-theme-lambda)
          ))

(provide 'init-eshell)
