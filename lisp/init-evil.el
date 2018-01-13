;; evil leader key
;; (setq evil-leader/in-all-states t)

;; (global-evil-leader-mode)
;; (evil-leader/set-key
;; (evil-leader/set-leader ";")

;; TAB and C-i is the same
;; (define-key evil-normal-state-map (kbd "TAB") 'other-window)
;; (define-key evil-normal-state-map (kbd "C-i") 'evil-jump-forward)
(define-key evil-normal-state-map (kbd "ge") 'evil-goto-line)
;; (define-key evil-normal-state-map (kbd "SPC-qq") 'save-buffers-kill-terminal)
(define-key evil-normal-state-map (kbd "M-i") 'fa-show)
(define-key evil-normal-state-map (kbd "M-u") 'fix-word-upcase)
(define-key evil-normal-state-map (kbd "M-l") 'fix-word-downcase)
(define-key evil-normal-state-map (kbd "M-c") 'fix-word-capitalize)
(define-key evil-normal-state-map (kbd "M-g") 'fa-abort)


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

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;copy from chenbin.emacs.d;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; As a general RULE, mode specific evil leader keys started
;; with uppercased character or 'g' or special character except "=" and "-"
(evil-declare-key 'normal org-mode-map
  "gh" 'outline-up-heading
  "gl" 'outline-next-visible-heading
  "gj" 'outline-forward-same-level
  "gk" 'outline-backward-same-level
  "$" 'org-end-of-line ; smarter behaviour on headlines etc.
  "^" 'org-beginning-of-line ; ditto
  "<" (lambda () (interactive) (org-demote-or-promote 1)) ; out-dent
  ">" 'org-demote-or-promote ; indent
  (kbd "TAB") 'org-cycle)

(evil-declare-key 'normal markdown-mode-map
  "gh" 'outline-up-heading
  "gl" 'outline-next-visible-heading
  "gj" 'outline-forward-same-level
  "gk" 'outline-backward-same-level
    (kbd "TAB") 'org-cycle)

;; I prefer Emacs way after pressing ":" in evil-mode
(define-key evil-ex-completion-map (kbd "C-a") 'evil-first-non-blank)
(define-key evil-ex-completion-map (kbd "C-b") 'backward-char)
(define-key evil-ex-completion-map (kbd "M-p") 'previous-complete-history-element)
(define-key evil-ex-completion-map (kbd "M-n") 'next-complete-history-element)

(define-key evil-normal-state-map "Y" (kbd "y$"))
;; (define-key evil-normal-state-map (kbd "RET") 'ivy-switch-buffer-by-pinyin) ; RET key is preserved for occur buffer
(define-key evil-normal-state-map "go" 'goto-char)
(define-key evil-normal-state-map (kbd "M-y") 'counsel-browse-kill-ring)
(define-key evil-normal-state-map (kbd "C-]") 'counsel-etags-find-tag-at-point)
(define-key evil-normal-state-map (kbd "C-]") 'counsel-etags-find-tag-at-point)
(define-key evil-insert-state-map (kbd "C-x C-n") 'evil-complete-next-line)
(define-key evil-insert-state-map (kbd "C-x C-p") 'evil-complete-previous-line)

;; I learn this trick from ReneFroger, need latest expand-region
;; @see https://github.com/redguardtoo/evil-matchit/issues/38
(define-key evil-visual-state-map (kbd "v") 'er/expand-region)
(define-key evil-insert-state-map (kbd "C-a") 'evil-first-non-blank)
(define-key evil-insert-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-insert-state-map (kbd "C-u") 'kill-whole-line)
(define-key evil-insert-state-map (kbd "C-k") 'kill-line)
(define-key evil-insert-state-map (kbd "M-j") 'yas-expand)
(define-key evil-emacs-state-map (kbd "M-j") 'yas-expand)
(global-set-key (kbd "C-r") 'undo-tree-redo)

 ;; {{ Use `;` as one leader key
(nvmap :prefix ";"
       ;; switch window
       "1" 'select-window-1
       "2" 'select-window-2
       "3" 'select-window-3
       "4" 'select-window-4
       "5" 'select-window-5
       "6" 'select-window-6
       "7" 'select-window-7
       "x0" 'delete-window
       "x1" 'delete-other-windows
       "x2" 'split-window-below
       "x3" 'split-window-right
       ;;
       "a" 'evil-first-non-blank
       "e" 'evil-end-of-line
       "SPC" 'counsel-M-x
       "TAB" 'other-window
       ;; highlight-symbol
       "hs" 'highlight-symbol
       "hn" 'highlight-symbol-next
       "hp" 'highlight-symbol-prev
       "hr" 'highlight-symbol-query-replace
       ;;
       "pp" 'my-append
       "do" 'delete-other-windows
       "ff" 'find-file
       "fb" 'beginning-of-defun
       "wf" 'popup-which-function
       "ww" 'narrow-or-widen-dwim
       "kk" 'scroll-other-window
       "jj" 'scroll-other-window-up
       "ii" 'counsel-imenu
       "xm" 'my-M-x
       "bk" 'buf-move-up
       "bj" 'buf-move-down
       "bh" 'buf-move-left
       "bl" 'buf-move-right
       "hd" 'describe-function
       "hf" 'find-function
       "hk" 'describe-key
       "sw" 'swiper
       "sa" 'swiper-all
       "hv" 'describe-variable
       "gt" 'counsel-gtags-dwim ; jump from reference to definition or vice versa
       "gr" 'counsel-gtags-find-symbol
       "fr" 'counsel-gtags-find-reference
       "gu" 'counsel-gtags-update-tags
       "qq" 'counsel-etags-grep
       "dd" 'counsel-etags-grep-symbol-at-point
       "fe" 'end-of-defun
       "fm" 'mark-defun
       "sc" 'scratch
       "dj" 'dired-jump ;; open the dired from current file
       "ht" 'counsel-etags-find-tag-at-point ; better than find-tag C-]
       "rt" 'counsel-etags-recent-tag
       "ft" 'counsel-etags-find-tag
       "cmg" 'counsel-bookmark-goto
       "yy" 'counsel-browse-kill-ring
       "cf" 'counsel-grep ; grep current buffer
       "gf" 'counsel-git ; find file
       "gg" 'counsel-git-grep-by-selected ; quickest grep should be easy to press
       "gm" 'counsel-git-find-my-file
       ";" 'evil-ex
  ;;;;; buffer ;;;;;
       "bk" 'kill-buffer
       "bs" 'switch-to-buffer
       "bp" 'switch-to-prev-buffer
       "bb" 'evil-buffer
       "zz" 'save-buffer
  ;;;;;
       "fo" 'ff-find-other-file
       "mm" 'evil-jump-item
       "mf" 'mf/mirror-region-in-multifile
       "tt" 'neotree-toggle
       "yy" 'youdao-dictionary-search-at-point
       "yd" 'youdao-dictionary-search-from-input
       ;; "er" 'er/expand-region
       "rf" 'recentf-open-files
       "ps" 'projectile-speedbar-toggle
       "sf" 'isearch-forward-regexp
       "sb" 'isearch-backward-regexp
       "sr" 'replace-regexp
       "ci" 'evilnc-comment-or-uncomment-lines
       "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
       "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
       "cc" 'evilnc-copy-and-comment-lines
       "cp" 'evilnc-comment-or-uncomment-paragraphs
       "cr" 'comment-or-uncomment-region
       "cv" 'evilnc-toggle-invert-comment-line-by-line
       "."  'evilnc-copy-and-comment-operator
       "\\" 'evilnc-comment-operator ; if you prefer backslash key
       ;; Search character(s) at the beginning of word
       ;; See https://github.com/abo-abo/avy/issues/70
       ;; You can change the avy font-face in ~/.custom.el:
       ;;  (eval-after-load 'avy
       ;;   '(progn
       ;;      (set-face-attribute 'avy-lead-face-0 nil :foreground "black")
       ;;      (set-face-attribute 'avy-lead-face-0 nil :background "#f86bf3")))
       ;; ";" 'avy-goto-char-2
       ;; "w" 'avy-goto-word-or-subword-1
       ;; "a" 'avy-goto-char-timer
       "db" 'sdcv-search-pointer ; in buffer
       "dt" 'sdcv-search-input+ ; in tip
       "dd" 'my-lookup-dict-org
       "lm" 'lookup-doc-in-man
       "gg" 'w3m-google-search
       "gf" 'w3m-google-by-filetype
       "gd" 'w3m-search-financial-dictionary
       "gj" 'w3m-search-js-api-mdn
       "ga" 'w3m-java-search
       "gh" 'w3mext-hacker-search ; code search in all engines with firefox
       "gq" 'w3m-stackoverflow-search
       "mws" 'mpc-which-song
       "ms" 'mpc-next-prev-song
       "mp" '(lambda () (interactive) (mpc-next-prev-song t)))
;; }}

 ;; {{ Use `SPC` as one leader key
(nvmap :prefix "SPC"
       "ss" 'wg-create-workgroup ; save windows layout
       "ei" 'evil-iedit-state/iedit-mode ; start iedit in emacs
       "sc" 'shell-command
       "ll" 'my-wg-switch-workgroup ; load windows layout
       "yy" 'hydra-launcher/body
       "hh" 'multiple-cursors-hydra/body
       "gi" 'gist-region ; only workable on my computer
       "tt" 'my-toggle-indentation
       "gs" 'git-gutter:set-start-revision
       "gh" 'git-gutter-reset-to-head-parent
       "gr" 'git-gutter-reset-to-default
       "ps" 'profiler-start
       "pr" 'profiler-report
       "ud" 'my-gud-gdb
       "uk" 'gud-kill-yes
       "ur" 'gud-remove
       "ub" 'gud-break
       "uu" 'gud-run
       "up" 'gud-print
       "ue" 'gud-cls
       "un" 'gud-next
       "us" 'gud-step
       "ui" 'gud-stepi
       "uc" 'gud-cont
       "uf" 'gud-finish
       "ma" 'mc/mark-all-like-this-dwim
       "md" 'mc/mark-all-like-this-in-defun
       "am" 'ace-mc-add-multiple-cursors
       "aw" 'ace-swap-window
       "af" 'ace-maximize-window
       "mn" 'mc/mark-next-like-this
       "ms" 'mc/skip-to-next-like-this
       "xc" 'save-buffers-kill-terminal
       "xz" 'suspend-frame
       "me" 'mc/edit-lines
       "=" 'increase-default-font-height ; GUI emacs onl
       "-" 'decrease-default-font-height ; GUI emacs only
       ;; liang.feng
       ;; "bu" 'backward-up-list
       ;; liang.feng
       ;; "bb" 'back-to-previous-buffer
       ;; liang.feng
       ;; "em" 'erase-message-buffer
       ;; liang.feng
       ;; "eb" 'eval-buffer
       "sd" 'sudo-edit
       ;; liang.feng
       ;; "ee" 'eval-expression
       "aa" 'copy-to-x-clipboard ; used frequently
       "ac" 'aya-create
       "ae" 'aya-expand
       "zz" 'paste-from-x-clipboard ; used frequently
       "cy" 'strip-convert-lines-into-one-big-string
       ;; liang.feng
       ;; "bs" '(lambda () (interactive) (goto-edge-by-comparing-font-face -1))
       ;; liang.feng
       ;; "es" 'goto-edge-by-comparing-font-face
       "vj" 'my-validate-json-or-js-expression
       ;; liang.feng
       ;; "kc" 'kill-ring-to-clipboard
       "mcr" 'my-create-regex-from-kill-ring
       "ntt" 'neotree-toggle
       "ntf" 'neotree-find ; open file in current buffer in neotree
       "ntd" 'neotree-project-dir
       "nth" 'neotree-hide

       "fn" 'cp-filename-of-current-buffer
       "fp" 'cp-fullpath-of-current-buffer
       "ff" 'toggle-full-window ;; I use WIN+F in i3
       "ip" 'find-file-in-project
       ;; liang.feng
       ;; "kk" 'find-file-in-project-by-selected
       ;; liang.feng
       ;; "kn" 'find-file-with-similar-name ; ffip v5.3.1
       "fd" 'find-directory-in-project-by-selected
       "trm" 'get-term
       "tff" 'toggle-frame-fullscreen
       "tfm" 'toggle-frame-maximized
       "ti" 'fastdef-insert
       "th" 'fastdef-insert-from-history
       ;; liang.feng
       ;; "epy" 'emmet-expand-yas
       ;; liang.feng
       ;; "epl" 'emmet-expand-line
       "rd" 'evilmr-replace-in-defun
       "rb" 'evilmr-replace-in-buffer
       "ts" 'evilmr-tag-selected-region ;; recommended
       "tua" 'artbollocks-mode
       "cby" 'cb-switch-between-controller-and-view
       "cbu" 'cb-get-url-from-controller
       "mk" 'bookmark-set
       "gs" (lambda ()
              (interactive)
              (let* ((ffip-diff-backends
                      '(("Show git commit" . (let* ((git-cmd "git --no-pager log --date=short --pretty=format:'%h|%ad|%s|%an'")
                                                    (collection (split-string (shell-command-to-string git-cmd) "\n" t))
                                                    (item (ffip-completing-read "git log:" collection)))
                                               (when item
                                                 (shell-command-to-string (format "git show %s" (car (split-string item "|" t))))))))))
                (ffip-show-diff 0)))
       "gd" 'ffip-show-diff-by-description ;find-file-in-project 5.3.0+
       "sf" 'counsel-git-show-file
       "sh" 'my-select-from-search-text-history
       "df" 'counsel-git-diff-file
       "rjs" 'run-js
       ;; liang.feng
       ;; "jsr" 'js-send-region
       ;; liang.feng
       ;; "jsb" 'js-clear-send-buffer
       "rmz" 'run-mozilla
       "rpy" 'run-python
       "rlu" 'run-lua
       "tci" 'toggle-company-ispell
       ;; liang.feng
       ;; "kb" 'kill-buffer-and-window ;; "k" is preserved to replace "C-g"
       "it" 'issue-tracker-increment-issue-id-under-cursor
       "ls" 'highlight-symbol
       "lq" 'highlight-symbol-query-replace
       "ln" 'highlight-symbol-nav-mode ; use M-n/M-p to navigation between symbols
       ;;liang.feng
       ;; "bm" 'pomodoro-start ;; beat myself
       "ij" 'rimenu-jump
       ;; @see https://github.com/pidu/git-timemachine
       ;; p: previous; n: next; w:hash; W:complete hash; g:nth version; q:quit
       ;; "tt" 'dumb-jump-go
       ;; "tb" 'dumb-jump-back
       "tm" 'my-git-timemachine
       "tdb" 'tidy-buffer
       "tdl" 'tidy-current-line
       ;; toggle overview,  @see http://emacs.wordpress.com/2007/01/16/quick-and-dirty-code-folding/
       "ov" 'my-overview-of-current-buffer
       "or" 'open-readme-in-git-root-directory
       "oo" 'compile
       "c$" 'org-archive-subtree ; `C-c $'
       ;; org-do-demote/org-do-premote support selected region
       "c<" 'org-do-promote ; `C-c C-<'
       "c>" 'org-do-demote ; `C-c C->'
       "cam" 'org-tags-view ; `C-c a m': search items in org-file-apps by tag
       "cxi" 'org-clock-in ; `C-c C-x C-i'
       "cxo" 'org-clock-out ; `C-c C-x C-o'
       "cxr" 'org-clock-report ; `C-c C-x C-r'
       "rr" 'my-counsel-recentf
       "rh" 'counsel-yank-bash-history ; bash history command => yank-ring
       "rf" 'counsel-goto-recent-directory
       "da" 'diff-region-tag-selected-as-a
       "db" 'diff-region-compare-with-b
       "di" 'evilmi-delete-items
       "si" 'evilmi-select-items
       ;; liang.feng
       ;; "jb" 'js-beautify
       ;; liang.feng
       ;; "jp" 'my-print-json-path
       "sep" 'string-edit-at-point
       "sec" 'string-edit-conclude
       "sea" 'string-edit-abort
       "xe" 'eval-last-sexp
       "x0" 'delete-window
       "x1" 'delete-other-windows
       "x2" 'my-split-window-vertically
       "x3" 'my-split-window-horizontally
       "s2" 'ffip-split-window-vertically
       "s3" 'ffip-split-window-horizontally
       "rw" 'rotate-windows
       "ru" 'undo-tree-save-state-to-register ; C-x r u
       "rU" 'undo-tree-restore-state-from-register ; C-x r U
       "xt" 'toggle-window-split
       "uu" 'winner-undo
       "UU" 'winner-redo
       "to" 'toggle-web-js-offset
       ;; liang.feng
       ;; "sl" 'sort-lines
       "ulr" 'uniquify-all-lines-region
       "ulb" 'uniquify-all-lines-buffer
       "fc" 'cp-ffip-ivy-last
       "ss" 'swiper-the-thing ; http://oremacs.com/2015/03/25/swiper-0.2.0/ for guide
       ;; liang.feng
       ;; "bc" '(lambda () (interactive) (wxhelp-browse-class-or-api (thing-at-point 'symbol)))
       "og" 'org-agenda
       "otl" 'org-toggle-link-display
       "oa" '(lambda ()
               (interactive)
               (unless (featurep 'org) (require 'org))
               (counsel-org-agenda-headlines))
       "om" 'toggle-org-or-message-mode
       "ut" 'undo-tree-visualize
       "ar" 'align-regexp
       ;; "0" 'select-window-0
       "0" 'delete-window
       "1" 'select-window-1
       "2" 'select-window-2
       "3" 'select-window-3
       "4" 'select-window-4
       "5" 'select-window-5
       "6" 'select-window-6
       "7" 'select-window-7
       "8" 'select-window-8
       "9" 'select-window-9
       ;; "xx" 'er/expand-region
       "xf" 'ido-find-file
       "xb" 'ivy-switch-buffer-by-pinyin
       "xh" 'mark-whole-buffer
       "xk" 'ido-kill-buffer
       "xs" 'save-buffer
       "vm" 'vc-rename-file-and-buffer
       "vc" 'vc-copy-file-and-rename-buffer
       "xvv" 'vc-next-action ; 'C-x v v' in original
       "vg" 'vc-annotate ; 'C-x v g' in original
       "vl" 'vc-print-log
       "vv" 'vc-msg-show
       "hh" 'cliphist-paste-item
       "yu" 'cliphist-select-item
       "ih" 'my-goto-git-gutter ; use ivy-mode
       "ir" 'ivy-resume
       "xnw" 'widen
       "xnd" 'narrow-to-defun
       ;; "ycr" 'my-yas-reload-all
       "xnr" 'narrow-to-region)
;; }}
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;end copy from chenbin.emacs.d;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'init-evil)
