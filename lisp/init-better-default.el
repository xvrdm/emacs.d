;; 禁用响铃
(setq ring-bell-function 'ignore)

;; auto reload file
(global-auto-revert-mode t)

;; 禁用备份文件
(setq make-backup-files nil)
(setq auto-save-default nil)

;;
(delete-selection-mode 1)

;; abbrev
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("lf" "liang.feng")
					    ))

(provide 'init-better-default)
