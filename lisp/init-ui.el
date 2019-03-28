;; set a default font
(cond
 ;; ((member "Hack" (font-family-list)) (set-face-attribute 'default nil :font "Hack-12" :slant 'Oblique))
 ;; ((member "Courier New" (font-family-list)) (set-face-attribute 'default nil :font "Courier New-12" :slant 'Oblique))
 ;; ((member "Hack" (font-family-list)) (set-face-attribute 'default nil :font "Hack-12"))
 ((member "Hack" (font-family-list)) (set-face-attribute 'default nil :font "Hack-12" :slant 'Oblique))
 ((member "Courier New" (font-family-list)) (set-face-attribute 'default nil :font "Courier New-12"))
 ) 

;; 中文字体的设置，同时解决中英文字体宽度不一致的问题（org-mode的表格可以中英文对齐）。
;; 而且解决了中文字体导致emacs卡的现象。
(when (equal system-type 'windows-nt)
  (progn
    (dolist (charset '(kana han cjk-misc bopomofo))
      ;; 台式电脑
      (if (equal system-name "DESKTOP-LL8PBC8")
          (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "微软雅黑" :size 18))
        (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "微软雅黑" :size 15)))))
  )

;; (add-hook 'after-init-hook '(set-face-attribute 'default (selected-frame) :height 100))

;; highlight source code in org mode
(setq org-src-fontify-natively t)

;; 高亮当前行
(global-hl-line-mode 1)

;; menu bar
(menu-bar-mode -1)

;; 关闭工具栏
(tool-bar-mode -1)

;; no scroll bar
(if (fboundp 'set-scroll-bar-mode)
   (set-scroll-bar-mode nil))

;; 更改光标样式
;; (set-default 'cursor-type 'hbar)
(set-default 'cursor-type 'bar)
;; (setq cursor-type 'bar)

;; 关闭启动画面
(setq inhibit-splash-screen 1)

;; 更改字体大小
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;; (set-face-attribute 'default nil :height 120)

;;设置窗口位置为屏库左上角(0,0)
(set-frame-position (selected-frame) 200 50)
;;设置宽和高
(set-frame-width (selected-frame) 100)
(set-frame-height (selected-frame) 35)

(provide 'init-ui)
