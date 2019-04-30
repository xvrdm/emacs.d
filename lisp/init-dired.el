;; init dired
;; (use-package dired+
;;   :init
;;   (load "dired+.el")
;;   :config
;;   reuse single buffer in dired
;;   (diredp-toggle-find-file-reuse-dir 1)
;;   )

;; (use-package dired+
;;   :ensure t
;;   :el-get t
;;   :config
;;   ;; reuse single buffer in dired
;;   (diredp-toggle-find-file-reuse-dir 1)
;;   )
(el-get-bundle dired+
  ;; reuse single buffer in dired
  (require 'dired+)
  (diredp-toggle-find-file-reuse-dir 1)
  )

;; dired-imenu
(use-package dired-imenu
  :ensure t
  :delight
  )

(use-package dired-rainbow
  :ensure t
  :commands dired-rainbow-define dired-rainbow-define-chmod
  :init
  (dired-rainbow-define dotfiles "gray" "\\..*")
  ;; (dired-rainbow-define web "#4e9a06" ("htm" "html" "xhtml" "xml" "xaml" "css" "js"
  ;;                                      "json" "asp" "aspx" "haml" "php" "jsp" "ts"
  ;;                                      "coffee" "scss" "less" "phtml"))
  ;; (dired-rainbow-define prog "green yellow3" (".*\\.el" "l" "ml" "py" "rb" "pl" "pm" "c"
  ;;                                       "cpp" "cxx" "c++" "h" "hpp" "hxx" "h++"
  ;;                                       "m" "cs" "mk" "make" "swift" "go" "java"
  ;;                                       "asm" "robot" "yml" "yaml" "rake" "lua"))
  ;; (dired-rainbow-define sh "yellow" ("sh" "bash" "zsh" "fish" "csh" "ksh"
  ;;                                          "awk" "ps1" "psm1" "psd1" "bat" "cmd"))
  ;; (dired-rainbow-define text "yellow green" ("txt" "md" "org" "ini" "conf" "rc"
  ;;                                            "vim" "vimrc" "exrc"))
  ;; (dired-rainbow-define doc "spring green" ("doc" "docx" "ppt" "pptx" "xls" "xlsx"
  ;;                                           "csv" "rtf" "wps" "pdf" "texi" "tex"
  ;;                                           "odt" "ott" "odp" "otp" "ods" "ots"
  ;;                                           "odg" "otg"))
  ;; (dired-rainbow-define misc "gray50" ("DS_Store" "projectile" "cache" "elc"
  ;;                                      "dat" "meta"))
  ;; (dired-rainbow-define media "#ce5c00" ("mp3" "mp4" "MP3" "MP4" "wav" "wma"
  ;;                                        "wmv" "mov" "3gp" "avi" "mpg" "mkv"
  ;;                                        "flv" "ogg" "rm" "rmvb"))
  ;; (dired-rainbow-define picture "purple3" ("bmp" "jpg" "jpeg" "gif" "png" "tiff"
  ;;                                          "ico" "svg" "psd" "pcd" "raw" "exif"
  ;;                                          "BMP" "JPG" "PNG"))
  ;; (dired-rainbow-define archive "saddle brown" ("zip" "tar" "gz" "tgz" "7z" "rar"
  ;;                                               "gzip" "xz" "001" "ace" "bz2" "lz"
  ;;                                               "lzma" "bzip2" "cab" "jar" "iso"))
  ;; boring regexp due to lack of imagination
  (dired-rainbow-define log (:inherit default :italic t) ".*\\.log")
  ;; highlight executable files, but not directories
  (dired-rainbow-define-chmod executable-unix "green" "-[rw-]+x.*")
  )

(use-package dired-k
  :ensure t
  :config
  ;; always execute dired-k when dired buffer is opened
  (add-hook 'dired-initial-position-hook 'dired-k)
  (add-hook 'dired-after-readin-hook #'dired-k-no-revert)
  ;; (setq dired-k-style 'git)
  (setq dired-k-style 'k.zsh)
  (setq dired-k-padding 1)
  ;; (define-key dired-mode-map (kbd "K") 'dired-k)
  ;; ;; You can use dired-k alternative to revert-buffer
  ;; (define-key dired-mode-map (kbd "g") 'dired-k)
  )

;; didn't work for me
;; (use-package dired-single
;;   :ensure t
;;   :config
;;   ;; https://github.com/crocket/dired-single
;;   ;; dired-single
;;   (defun my-dired-init ()
;;     "Bunch of stuff to run for dired, either immediately or when it's
;;    loaded."
;;     ;; <add other stuff here>
;;     (save-excursion
;;       (switch-to-buffer "*scratch*")
;;       (goto-char (point-max))
;;       (insert "xxxxxxxxx"))
;;     (define-key dired-mode-map [return] 'dired-single-buffer)
;;     (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
;;     (define-key dired-mode-map "^"
;;       (function
;;        (lambda nil (interactive) (dired-single-buffer "..")))))
;;   ;; if dired's already loaded, then the keymap will be bound
;;   (if (boundp 'dired-mode-map)
;;       ;; we're good to go; just add our bindings
;;       (my-dired-init)
;;     ;; it's not loaded yet, so add our bindings to the load-hook
;;     (add-hook 'dired-load-hook 'my-dired-init))
;;   )

(provide 'init-dired)
