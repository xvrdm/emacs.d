;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;; (require 'org-install)
;; (require 'ob-tangle)
;; (org-babel-load-file (expand-file-name "liang.org" user-emacs-directory))

;; this is master write
;; master write 2

(package-initialize)

;; add feauther to load-path
(add-to-list 'load-path "~/.emacs.d/lisp")
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/lisp")
(require 'init-packages)
(require 'init-minefunc)
(require 'init-ui)
(require 'init-org)
(require 'init-better-default)
(require 'init-keybindings)
(require 'init-evil)
(require 'init-company)
(require 'init-eshell)
;; (require 'init-modeline)
                          
;; cl - Common List Extension
(require 'cl-lib)

;; (setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
;; (load-file custom-file)

;; ycmd write 2
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:disabled-modes (quote (asm-mode image-mode)))
 '(git-gutter:handled-backends (quote (git svn)))
 '(git-gutter:hide-gutter t)
 '(org-publish-project-alist
   (\`
    (("default" :base-directory
      (\,
       (org2jekyll-input-directory))
      :base-extension "org" :publishing-directory
      (\,
       (org2jekyll-output-directory))
      :publishing-function org-html-publish-to-html :headline-levels 4 :section-numbers nil :with-toc nil :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>" :html-preamble t :recursive t :make-index t :html-extension "html" :body-only t)
     ("post" :base-directory
      (\,
       (org2jekyll-input-directory))
      :base-extension "org" :publishing-directory
      (\,
       (org2jekyll-output-directory org2jekyll-jekyll-posts-dir))
      :publishing-function org-html-publish-to-html :headline-levels 4 :section-numbers nil :with-toc nil :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>" :html-preamble t :recursive t :make-index t :html-extension "html" :body-only t)
     ("images" :base-directory
      (\,
       (org2jekyll-input-directory "img"))
      :base-extension "jpg\\|gif\\|png" :publishing-directory
      (\,
       (org2jekyll-output-directory "img"))
      :publishing-function org-publish-attachment :recursive t)
     ("js" :base-directory
      (\,
       (org2jekyll-input-directory "js"))
      :base-extension "js" :publishing-directory
      (\,
       (org2jekyll-output-directory "js"))
      :publishing-function org-publish-attachment :recursive t)
     ("css" :base-directory
      (\,
       (org2jekyll-input-directory "css"))
      :base-extension "css\\|el" :publishing-directory
      (\,
       (org2jekyll-output-directory "css"))
      :publishing-function org-publish-attachment :recursive t))))
 '(org2jekyll-blog-author "feng" nil (org2jekyll))
 '(org2jekyll-jekyll-directory "" nil (org2jekyll))
 '(org2jekyll-jekyll-drafts-dir "" nil (org2jekyll))
 '(org2jekyll-jekyll-posts-dir "" nil (org2jekyll))
 '(org2jekyll-source-directory "" nil (org2jekyll))
 '(package-selected-packages
   (quote
    (esh-autosuggest use-package company company-statistics company-c-headers company-jedi exec-path-from-shell monokai-theme darkokai-theme ample-theme pyim-basedict pyim evil goto-chg ivy swiper counsel hungry-delete smartparens js2-mode web-mode emmet-mode diminish delight popwin powershell smex expand-region iedit fzf org ob-go ob-rust htmlize org-pomodoro org2jekyll magit evil-magit xpm yasnippet yasnippet-snippets evil-collection evil-org evil-smartparens evil-visualstar evil-escape evil-surround evil-nerd-commenter evil-easymotion evil-snipe evil-matchit evil-exchange evil-iedit-state evil-indent-plus general which-key winum youdao-dictionary go-mode rust-mode smart-mode-line smart-mode-line-powerline-theme neotree all-the-icons projectile eshell-prompt-extras linum-relative rainbow-delimiters focus beacon powerline powerline-evil airline-themes spaceline spaceline-all-the-icons telephone-line doom-modeline highlight-symbol rainbow-mode multifiles fix-word browse-kill-ring ggtags symon markdown-mode ace-window rainbow-identifiers highlight-numbers highlight-quoted highlight-defined major-mode-icons mode-icons ergoemacs-status highlight-parentheses direx dired-imenu imenu-anywhere imenu-list rich-minority ivy-xref fringe-helper git-gutter git-gutter-fringe ace-popup-menu dired-k dired-rainbow))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
