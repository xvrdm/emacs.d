;; -*- coding: utf-8; lexical-binding: t; -*-
;; 快速打开配置文件
(define-namespace fwar34-)
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
  (cl-loop for cleaner in mode-line-cleaner-alist
           do (let* ((mode (car cleaner))
                     (mode-str (cdr cleaner))
                     (old-mode-str (cdr (assq mode minor-mode-alist))))
                (when old-mode-str
                  (setcar old-mode-str mode-str))
                ;; major mode
                (when (eq mode major-mode)
                  (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

(defun fwar34/recent-file()
  "open recent file, then set state normal"
  (interactive)
  (recentf-open-files)
  (evil-normal-state)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; http://blog.binchen.org/index-21.html, Use ivy to open recent directories
(require 'ivy) ; swiper 7.0+ should be installed
(defun fwar34/counsel-goto-recent-directory ()
  "Open recent directory with dired"
  (interactive)
  (unless recentf-mode (recentf-mode 1))
  (let ((collection
         (delete-dups
          (append (mapcar 'file-name-directory recentf-list)
                  ;; fasd history
                  (if (executable-find "fasd")
                      (split-string (shell-command-to-string "fasd -ld") "\n" t))))))
    (ivy-read "directories:" collection :action 'dired)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://blog.csdn.net/loushuai/article/details/51648924
;; (defun list-funcs (arg)
;;   "List functions in buffer."
;;   (interactive "p")
;;   (message "functions")
;;   ;;;  (list-matching-lines "^\\bstatic\\b*\\binline\\b*[ ]*[A-Za-z_<>]+[ ]+[A-Za-z0-9_:]+[\(]"))
;;     (list-matching-lines "^[A-Za-z0-9_]+[ ]+[A-Za-z0-9_<>: ]*[\(]"))

;; #!/usr/bin/env python3
;; #-*- coding: utf-8 -*-

;; # File Name: file_test1.py
;; # Author: Feng
;; # Created Time: Fri 24 Mar 2017 02:27:39 PM CST
;; # Content: 使用pickle模块将数据对象保存到文件
(defun fwar34/insert-python()
  "Insert file describe for python file"
  (interactive)
  (unless (equal system-type 'windows-nt)
    (insert "#!/usr/bin/env python3\n"))
  (insert "#-*- coding: utf-8 -*-\n\n")
  (insert "# File Name: ")
  (insert (buffer-name))
  (insert "\n# Author: Feng\n")
  (insert "# Created Time: ")
  (insert (current-time-string))
  (insert "\n# Content: ")
  )

(defun fwar34/insert-lisp-commit ()
  "Insert lisp commit"
  (interactive)
  (insert ";;-------------------------------------------------------------\n")
  (insert ";; \n")
  (insert ";;-------------------------------------------------------------")
  )

;; reference from http://ergoemacs.org/emacs/elisp_run_current_file.html
(defvar fwar34-run-current-file-before-hook nil "Hook for `fwar34/run-current-file'. Before the file is run.")
(defvar fwar34-run-current-file-after-hook nil "Hook for `fwar34/run-current-file'. After the file is run.")
(defun fwar34/run-current-go-file ()
  "Run or build current golang file.
To build, call `universal-argument' first."
  (interactive)
  (unless (buffer-file-name) (save-buffer))
  (when (buffer-modified-p) (save-buffer))
  (let ((resize-mini-window-internal nil)
        ($filename (buffer-file-name))
        ($prog-name "go")
        $cmd-str)
    (setq $cmd-str (concat $prog-name " \"" $filename "\""))
    (if current-prefix-arg
        (setq $cmd-str (format "%s build \"%s\" " $prog-name $filename))
      (setq $cmd-str (format "%s run \"%s\"" $prog-name $filename)))
    (message "running %s" $filename)
    (message "%s" $cmd-str)
    (shell-command $cmd-str))
  )
(defun fwar34/run-current-file ()
  "Execute the current file.

For example, if the current buffer is x.py, then it'll call 「python x.py」 in a shell.
Output is printed to buffer “*Shell Command Output*”.

The file can be Emacs Lisp, Python, golang, Bash.
File suffix is used to determine what program to run.

If the file is modified or not saved, save it automatically before run.

URL `http://ergoemacs.org/emacs/elisp_run_current_file.html'"
  (interactive)
  (let ((resize-mini-window-internal nil)
        ($suffix-map
         ;; (‹extension› . ‹shell program name›)
         `(("sh" . "bash")
           ("go" . "go run")
           ("py" . ,(if (string-equal system-type "windows-nt") "python" "python3"))
           ("rs" . "cargo run")
           ("cpp" . "g++")
           ("java" . "javac")
           ("c". "gcc")))
        $filename
        $file-suffix
        $prog-name
        $cmd-str)
    (unless (buffer-file-name) (save-buffer))
    (when (buffer-modified-p) (save-buffer))
    (setq $filename (buffer-file-name))
    (setq $file-suffix (file-name-extension $filename))
    (setq $prog-name (cdr (assoc $file-suffix $suffix-map)))
    (setq $cmd-str (concat $prog-name " \"" $filename "\""))
    (run-hooks 'fwar34-run-current-file-before-hook)
    (cond
     ((string-equal $file-suffix "el")
      (load $filename))
     ((string-equal $file-suffix "go")
      (fwar34-run-current-go-file))
     ((string-equal $file-suffix "java")
      (shell-command (format "java %s" (file-name-sans-extension (file-name-nondirectory $filename)))))
     (t (if $prog-name
            (progn
              (message "Running")
              (shell-command $cmd-str))
          (error "No recognized program file suffix for this file.")))
     )
    (run-hooks 'fwar34-run-current-file-after-hook)))

;; 重新载入emacs配置
(defun mage-reload-config()
  (interactive)
  (load user-init-file nil t))

;; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(provide 'init-minefunc)
