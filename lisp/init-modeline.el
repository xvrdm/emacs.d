;;-------------------------------------------------------------
;; init-modeline
;; https://blog.csdn.net/xh_acmagic/article/details/78939246
;;-------------------------------------------------------------
(setq my-flycheck-mode-line
      '(:eval
        (when
            (and (bound-and-true-p flycheck-mode)
                 (or flycheck-current-errors
                     (eq 'running flycheck-last-status-change)))
          (pcase flycheck-last-status-change
            ((\` not-checked) nil)
            ((\` no-checker) (propertize " -" 'face 'warning))
            ((\` running) (propertize " ✷" 'face 'success))
            ((\` errored) (propertize " !" 'face 'error))
            ((\` finished)
             (let* ((error-counts (flycheck-count-errors flycheck-current-errors))
                    (no-errors (cdr (assq 'error error-counts)))
                    (no-warnings (cdr (assq 'warning error-counts)))
                    (face (cond (no-errors 'error)
                                (no-warnings 'warning)
                                (t 'success))))
               (propertize (format "[%s/%s]" (or no-errors 0) (or no-warnings 0))
                           'face face)))
            ((\` interrupted) " -")
            ((\` suspicious) '(propertize " ?" 'face 'warning))))))

(defun zilongshanren/display-mode-indent-width ()
  (let ((mode-indent-level
         (catch 'break
           (dolist (test spacemacs--indent-variable-alist)
             (let ((mode (car test))
                   (val (cdr test)))
               (when (or (and (symbolp mode) (derived-mode-p mode))
                         (and (listp mode) (apply 'derived-mode-p mode))
                         (eq 't mode))
                 (when (not (listp val))
                   (setq val (list val)))
                 (dolist (v val)
                   (cond
                    ((integerp v) (throw 'break v))
                    ((and (symbolp v) (boundp v))
                     (throw 'break (symbol-value v))))))))
           (throw 'break (default-value 'evil-shift-width)))))
    (concat "TS:" (int-to-string (or mode-indent-level 0)))))

(defun zilong/modeline--evil-substitute ()
  "Show number of matches for evil-ex substitutions and highlights in real time."
  (when (and (bound-and-true-p evil-local-mode)
             (or (assq 'evil-ex-substitute evil-ex-active-highlights-alist)
                 (assq 'evil-ex-global-match evil-ex-active-highlights-alist)
                 (assq 'evil-ex-buffer-match evil-ex-active-highlights-alist)))
  (propertize
   (let ((range (if evil-ex-range
                    (cons (car evil-ex-range) (cadr evil-ex-range))
                  (cons (line-beginning-position) (line-end-position))))
         (pattern (car-safe (evil-delimited-arguments evil-ex-argument 2))))
     (if pattern
         (format " %s matches " (how-many pattern (car range) (cdr range)))
       " - "))
   'face 'font-lock-preprocessor-face)))

(defun mode-line-fill (face reserve)
  "Return empty space using FACE and leaving RESERVE space on the right."
  (unless reserve (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
              'display `((space :align-to
                                (- (+ right right-fringe right-margin) ,reserve)))
              'face face))
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
  (concat "("
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
(setq time-mode-line (quote (:eval (propertize (format-time-string "%H:%M")))))
(setq-default mode-line-format
      (list
       ;; " %1"
       ;; '(:eval (when (bound-and-true-p winum-mode) (propertize
       ;;                                              (window-number-mode-line)
       ;;                                              'face
       ;;                                              'font-lock-type-face)))

       " "
       '(:eval (zilong/modeline--evil-substitute))
       " %1"
       buffer-name-mode-line
       ;; "%1 "
       ;; ;; the buffer name; the file name as a tool tip
       ;; '(:eval (propertize "%b " 'face 'font-lock-keyword-face
       ;;                     'help-echo (buffer-file-name)))
       ;; relative position, size of file
       "["
       (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
       "/"
       (propertize "%I" 'face 'font-lock-constant-face) ;; size
       "] "

       " "
       ;; git info
       '(:eval (when (> (window-width) 90)
                 `(vc-mode vc-mode)
                 ;; reference from spaceline
                 (s-trim (concat vc-mode
                                 (when (buffer-file-name)
                                   (pcase (vc-state (buffer-file-name))
                                     (`up-to-date " ")
                                     (`edited " Mod")
                                     (`added " Add")
                                     (`unregistered " ??")
                                     (`removed " Del")
                                     (`needs-merge " Con")
                                     (`needs-update " Upd")
                                     (`ignored " Ign")
                                     (_ " Unk")))))
                 ))


       " %1"
       major-mode-mode-line
       ;; ;; minor modes
       ;; '(:eval (when (> (window-width) 90)
       ;;           minor-mode-alist))

       " %1"
       file-status-mode-line
       "%1 "
       ;; evil state
       '(:eval evil-mode-line-tag)
       ;; " "
       ;; '(:eval (zilongshanren/display-mode-indent-width))
       " %1"
       projectile-mode-line
       " %1"
       line-column-mode-line
       ;; " "
       ;; flycheck-status-mode-line
       "%1 "
       my-flycheck-mode-line
       (mode-line-fill 'mode-line 15)
       encoding-mode-line
       " "
       time-mode-line
       ;; mode-line-end-spaces
       ))

;; (set-face-background 'modeline "#4466aa")
;; (set-face-background 'modeline-inactive "#99aaff")
;; (set-face-background 'fringe "#809088")

;; Here 's how I get a box around the active mode-line :
(custom-set-faces
 '(mode-line ((t (:box (:line-width 2 :color "red"))))))

(provide 'init-modeline)
