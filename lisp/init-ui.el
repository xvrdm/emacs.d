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

  ;; font setting start============================================================================================
  ;; http://zhuoqiang.me/torture-emacs.html同样在YoudaoNote中保存
  ;; (x-list-fonts "*")
  ;; (print (font-family-list)) 打印字体

  (require 'cl) ;; find-if is in common list package

  (defvar chinese-font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
  (defun fwar34/font-exist-p (font)
    (if (null (x-list-fonts font))
        nil
      t))

  (defun fwar34/set-fonts (english-fonts englist-font-size &optional chinese-fonts chinese-font-size)
    ;; 英文字体设置
    (set-face-attribute 'default nil
                        :height englist-font-size
                        ;; :weight 'bold
                        ;; :slant 'Oblique
                        :font (find-if #'fwar34/font-exist-p english-fonts)) 
    (message (format "set englist font: %s size: %d" (find-if #'fwar34/font-exist-p english-fonts) englist-font-size))
    ;; 中文字体设置
    ;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
    ;;   ;; (set-fontset-font (frame-parameter nil 'font) charset (font-spec :family "微软雅黑" :size 18))
    ;;   (set-fontset-font (frame-parameter nil 'font)
    ;;                     charset (font-spec :family (find-if #'fwar34/font-exist-p chinese-fonts)
    ;;                                        :size chinese-font-size)))
    )

  ;; 英文设置
  (fwar34/set-fonts '("RobotoMono Nerd Font" "Hack" "Courier 10 Pitch" "Courier New" "DejaVu Sans Mono") 120)
  ;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
  ;;   (set-fontset-font (frame-parameter nil 'font)
  ;;                     charset (font-spec :family "黑体"
  ;;                     ;; charset (font-spec :family "WenQuanYi Zen Hei Mono"
  ;;                                        ;; :size 23 
  ;;                                        )))
  ;;   )
  )

  ;; --------------------------------------------------------------------------------------------------
  ;; (cond
  ;;  ((member "RobotoMono Nerd Font" (font-family-list))
  ;;   (progn
  ;;     (set-face-attribute 'default nil :height 120 :font "RobotoMono Nerd Font")
  ;;     (when print-font (message "RobotoMono Nerd Font")))))
;; font setting end============================================================================================

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
