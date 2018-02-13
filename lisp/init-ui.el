;; set a default font
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono-9" :slant 'Oblique))
;; (when (member "DejaVu Sans Mono" (font-family-list))
;;     (add-to-list 'initial-frame-alist '(font . "DejaVu Sans Mono-10"))
;;     (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10")))

;; 高亮当前行
;; (global-hl-line-mode 1)

;; menu bar
(menu-bar-mode -1)

;; 关闭工具栏
(tool-bar-mode -1)

;; no scroll bar
(if (fboundp 'set-scroll-bar-mode)
   (set-scroll-bar-mode nil))

;; 更改光标样式
(set-default 'cursor-type 'hbar)
;; (setq cursor-type 'bar)

;; 关闭启动画面
(setq inhibit-splash-screen 1)

;; 更改字体大小
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 120)

;;设置窗口位置为屏库左上角(0,0)
(set-frame-position (selected-frame) 200 50)
;;设置宽和高
(set-frame-width (selected-frame) 100)
(set-frame-height (selected-frame) 35)

(provide 'init-ui)
