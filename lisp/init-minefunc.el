;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 隐藏windows换行符
(defun hidden-dos-eol()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;; 移除windows换行符
(defun remove-dos-eol()
  "Replace DOS eolns CR LR with Unix eolns CR."
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; 增强occur, 抓取选中或者光标的词
(defun occur-dwim ()
    "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))

;; org mode
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "工作安排")
	 "* TODO [#B] %?\n  %i\n"
	 :empty-lines 1)))
	 
;; gnu-global
(defun gtags-update-single(filename)
  "Update Gtags database for changes in a single file"
  (interactive)
  (start-process "update-gtags" "update-gtags" "bash" "-c" (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))

(defun gtags-update-current-file()
  (interactive)
  (defvar filename)
  (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
  (gtags-update-single filename)
  (message "Gtags updated for %s" filename))

(defun gtags-update-hook()
  "Update GTAGS file incrementally upon saving a file"
  (when gtags-mode
    (when (gtags-root-dir)
      (gtags-update-current-file))))

(defun scroll-other-window-up ()
  (interactive)
  (scroll-other-window '-))

;; smex or counsel-M-x?
(defvar my-use-smex nil
  "Use `smex' instead of `counsel-M-x' when press M-x.")
(defun my-M-x ()
  (interactive)
  (cond
   (my-use-smex
    (smex))
   ((fboundp 'counsel-M-x)
    ;; `counsel-M-x' will use `smex' to remember history
    (counsel-M-x))
   ((fboundp 'smex)
    (smex))
   (t
    (execute-extended-command))))

(defun my-append-string-marker (str)
  "Append a string to end of current line, then move cursion to origion position."
  (let* ((cursion-position (point-marker)))
    (end-of-line)
    (insert str)
    (goto-char (marker-position cursion-position)))
  )
(defun my-append-semicolon-marker ()
  "Append a ';' to end of current line, then move cursion to origion position."
  (interactive)
  (my-append-string-marker ";")
  )

(defun my-append-string-excursion (str)
  "Append a string to end of a line, then move cursion to origion position"
  (save-excursion
    (end-of-line)
    (insert str)
    )
  )
(defun my-append-semicolon-excursion ()
  "Append a ';' to end of current line, then move cursion to origion position"
  (interactive)
  (my-append-string-excursion ";")
  )

(defun my-append-string (str)
  "Append a string to end of a line"
  (end-of-line)
  ;;(insert-char str)
  (insert str)
  )
(defun my-append-semicolon ()
  "Append a ';' to end of current line."
  (interactive)
  ;; (my-append-string 59)
  (my-append-string ";")
  )

(defun my-display-full-path-of-current-buffer ()
  "Display the full path of current file"
  (interactive)
  (message (buffer-file-name))
  )

;; Shorter modeline
(defvar mode-line-cleaner-alist
  '((auto-complete-mode . "α")
    ;; Major modes
    (lisp-interaction-mode . "Λ")
    )
  "Alist for `clean-mode-line'.
When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")

(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                  (mode-str (cdr cleaner))
                  (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
               (setcar old-mode-str mode-str))
             ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;; highlight call function exculde (if,else,while,for)
;; https://www.emacswiki.org/emacs/AddKeywords
;; https://www.emacswiki.org/emacs/FontLockKeywords
(font-lock-add-keywords
 'c-mode
 ;; '(("\\<\\(\\sw+\\) ?(" 1 'company-echo-common)))
 '(("\\<\\(\\sw+\\) *(" 1 'font-lock-function-name-face)))

(font-lock-add-keywords
 'c-mode
 '(("\\<\\(if\\|for\\|switch\\|while\\)\\>" . 'font-lock-keyword-face)))

(font-lock-add-keywords
 'c++-mode
 ;; '(("\\<\\(\\sw+\\) ?(" 1 'company-echo-common)))
  '(("\\<\\(\\sw+\\) *(" 1 'font-lock-function-name-face)))

(font-lock-add-keywords
 'c++-mode
 '(("\\<\\(if\\|for\\|switch\\|while\\)\\>" . 'font-lock-keyword-face)))

;; A highlighting printf format specifier like vim
;; https://www.emacswiki.org/emacs/AddKeywords
(defvar font-lock-format-specifier-face		
  'font-lock-format-specifier-face
  "Face name to use for format specifiers.")

(defface font-lock-format-specifier-face
  '((t (:foreground "OrangeRed1")))
  "Font Lock mode face used to highlight format specifiers."
  :group 'font-lock-faces)

(add-hook 'c-mode-common-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("[^%]\\(%\\([[:digit:]]+\\$\\)?[-+' #0*]*\\([[:digit:]]*\\|\\*\\|\\*[[:digit:]]+\\$\\)\\(\\.\\([[:digit:]]*\\|\\*\\|\\*[[:digit:]]+\\$\\)\\)?\\([hlLjzt]\\|ll\\|hh\\)?\\([aAbdiuoxXDOUfFeEgGcCsSpn]\\|\\[\\^?.[^]]*\\]\\)\\)"
                                       1 font-lock-format-specifier-face t)
                                      ("\\(%%\\)" 
                                       1 font-lock-format-specifier-face t)) )))

;; http://maskray.me/blog/2017-12-03-c++-language-server-cquery
;; C/C++ mode hook在项目根目录有compile_commands.json时自动启用`lsp-cquery-enable
(defun my//enable-cquery-if-compile-commands-json ()
  (when
      (and (not (and (boundp 'lsp-mode) lsp-mode))
           (or
            (cl-some (lambda (x) (string-match-p x buffer-file-name)) my-cquery-whitelist)
            (cl-notany (lambda (x) (string-match-p x buffer-file-name)) my-cquery-blacklist))
           (or (locate-dominating-file default-directory "compile_commands.json")
               (locate-dominating-file default-directory ".cquery")))
    (setq eldoc-idle-delay 0.2)
    (lsp-cquery-enable)
    (lsp-enable-imenu)
    (when (>= emacs-major-version 26)
      (lsp-ui-doc-mode 1))))

(defun my-recent-file()
  "open recent file, then set state normal"
  (interactive)
  (recentf-open-files)
  (evil-normal-state)
  )

(provide 'init-minefunc)
