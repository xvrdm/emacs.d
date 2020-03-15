;; -*- coding: utf-8; lexical-binding: t; -*-
(setq print-font nil)

(when window-system
  ;; 更改光标样式
  ;; (set-default 'cursor-type 'box)
  ;; (set-default 'cursor-type 'bar)
  ;; (setq cursor-type 'bar)
  (setq cursor-type 'box)
  ;; 设置窗口位置为屏库左上角(0,0)
  ;; (set-frame-position (selected-frame) 200 50)
  (set-frame-position (selected-frame) 0 0)
  ;; 设置宽和高
  ;; (set-frame-width (selected-frame) 100)
  ;; (set-frame-height (selected-frame) 35)
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  ;; set a default font
  (cond
   ;; --------------------------------------------------------------------------------------------------
   ((member "Hack" (font-family-list))
    (progn
      (set-face-attribute 'default nil :font "Hack-12" :slant 'Oblique)
      (when print-font (message "Hack"))))
   ;; --------------------------------------------------------------------------------------------------
   ;; ((member "Courier 10 Pitch" (font-family-list))
   ;;  (set-face-attribute 'default nil :height 180 :slant 'Oblique :font "Courier 10 Pitch"))
   ;; --------------------------------------------------------------------------------------------------
   ((member "RobotoMono Nerd Font" (font-family-list))
    (progn
      (set-face-attribute 'default nil :height 120 :font "RobotoMono Nerd Font")
      (when print-font (message "RobotoMono Nerd Font"))))
   ;; --------------------------------------------------------------------------------------------------
   ((member "Courier New" (font-family-list))
    (progn
    (set-face-attribute 'default nil :height 120 :font "Courier New" :weight 'bold)
    (when print-font (message "Courier New"))))
   ;; --------------------------------------------------------------------------------------------------
   ;; ((member "FiraCode Nerd Font Mono" (font-family-list))
   ;;  (set-face-attribute 'default nil :height 120 :font "FiraCode Nerd Font Mono" :weight))
   ;; --------------------------------------------------------------------------------------------------
   ((member "DejaVu Sans Mono" (font-family-list))
    (progn
    (set-face-attribute 'default nil :height 120 :font "DejaVu Sans Mono")
    (when print-font (message "DejaVu Sans Mono"))))
   ;; --------------------------------------------------------------------------------------------------
   ((member "Courier 10 Pitch" (font-family-list))
    (progn
    (set-face-attribute 'default nil :height 120 :font "Courier 10 Pitch" :weight 'bold)
    (when print-font (message "Courier 10 Pitch"))))
   ;; --------------------------------------------------------------------------------------------------
   )

  ;; 中文字体的设置，同时解决中英文字体宽度不一致的问题（org-mode的表格可以中英文对齐）。
  ;; 而且解决了中文字体导致emacs卡的现象。
  (when (equal system-type 'windows-nt)
    (dolist (charset '(kana han cjk-misc bopomofo))
      ;; 台式电脑
      (if (equal (system-name) "DESKTOP-LL8PBC8")
          (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "微软雅黑" :size 18))
        (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "微软雅黑" :size 15)))))

  (when (equal system-type 'gnu/linux)
    (set-fontset-font "fontset-default" 'gb18030 '("Noto Sans CJK SC" . "unicode-bmp")))
  )

;; 高亮当前行
(global-hl-line-mode 1)
;; menu bar
(menu-bar-mode -1)
;; 关闭工具栏
(if (boundp 'tool-bar-mode)
    (tool-bar-mode -1))
;; no scroll bar
(if (fboundp 'set-scroll-bar-mode)
    (set-scroll-bar-mode nil))
;; 关闭启动画面
(setq inhibit-splash-screen 1)

(provide 'init-ui)
