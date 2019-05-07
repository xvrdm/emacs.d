;;-------------------------------------------------------------
;; init-modeline
;; https://blog.csdn.net/xh_acmagic/article/details/78939246
;;-------------------------------------------------------------
(defun mode-line-fill (face reserve)
  "Return empty space using FACE and leaving RESERVE space on the right."
  (unless reserve
    (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
              'display `((space :align-to
                                (- (+ right right-fringe right-margin) ,reserve)))
              'face 'face))
(setq projectile-mode-line
      (quote (:eval (when (projectile-project-p)
                      (propertize (format " P[%s]" (projectile-project-name))
                                  'face 'font-lock-variable-name-face)))))
(setq buffer-name-mode-line
      (quote (:eval (propertize "%b " 'face 'font-lock-string-face))))
(setq major-mode-mode-line
      (quote (:eval (propertize "%m " 'face 'font-lock-keyword-face))))
(setq file-status-mode-line 
  (quote (:eval (concat "["
            (when (buffer-modified-p)
              (propertize "Mod "
                      'face 'font-lock-warning-face
                      'help-echo "Buffer has been modified"))
            (propertize (if overwrite-mode "Ovr" "Ins")
                    'face 'font-lock-preprocessor-face
                    'help-echo (concat "Buffer is in "
                           (if overwrite-mode
                               "overwrite"
                             "insert") " mode"))
            (when buffer-read-only
              (propertize " RO"
                      'face 'font-lock-type-face
                      'help-echo "Buffer is read-only"))
            "]"))))
(setq flycheck-status-mode-line
  (quote (:eval (pcase flycheck-last-status-change
          (`finished
           (let* ((error-counts (flycheck-count-errors flycheck-current-errors))
              (errors (cdr (assq 'error error-counts)))
              (warnings (cdr (assq 'warning error-counts)))
              (face (cond (errors 'error)
                      (warnings 'warn)
                      (t 'success))))
             (propertize (concat "["
                     (cond
                      (errors (format "✗:%s" errors))
                      (warnings (format "❗:%s" warnings))
                      (t "✔"))
                     "]")
                         'face face)))))))
(setq line-column-mode-line
  (concat
   "("
   (propertize "%02l" 'face 'font-lock-type-face)
   ":"
   (propertize "%02c" 'face 'font-lock-type-face)
   ")"))
(setq encoding-mode-line
  (quote (:eval (propertize 
         (concat (pcase (coding-system-eol-type buffer-file-coding-system)
               (0 "LF ")
               (1 "CRLF ")
               (2 "CR "))
             (let ((sys (coding-system-plist buffer-file-coding-system)))
               (if (memq (plist-get sys :category) '(coding-category-undecided coding-category-utf-8))
               "UTF-8"
                 (upcase (symbol-name (plist-get sys :name)))))
             )))))
(setq time-mode-line
      (quote (:eval (propertize (format-time-string "%H:%M")))))
(setq-default mode-line-format
      (list
       " %1"
       major-mode-mode-line
       " %1"
       buffer-name-mode-line
       " %1"
       file-status-mode-line
       " %1"
       projectile-mode-line
       " %1"
       line-column-mode-line
       " "
       flycheck-status-mode-line
       (mode-line-fill 'mode-line 15)
       encoding-mode-line
       " "
       time-mode-line
       ))

(provide 'init-modeline)
