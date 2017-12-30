
;; 高亮当前行
;; (global-hl-line-mode 1)

;; 关闭工具栏
;; (tool-bar-mode -1)

;; 关闭滚动条
;; (scroll-bar-mode -1)

;; 更改光标样式
;; (setq cursor-type 'bar)

;; 关闭启动画面
(setq inhibit-splash-screen 1)

;; 更改字体大小
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 160)

(provide 'init-ui)
