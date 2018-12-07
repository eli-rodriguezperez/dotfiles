;; Eli emacs config

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; Change default font
(add-to-list 'default-frame-alist '(font . "mononoki-12"))
(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width . 80))

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Disable backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; WINDOWS
;; Set emacs shell to use bash
(setq shell-file-name "C:\\msys64\\usr\\bin\\bash.exe")
;; Set external tools for windows indexing
(setq projectile-indexing-method (quote turbo-alien))
;;

;; WORK
;;set proxy
(setq url-proxy-services '(("no_proxy" . "work\\.com")
			   ("http" . "127.0.0.1:8081")
			   ("https" . "127.0.0.1:8081")))
;;

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Theme
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-hard t))

;; Powerline
(use-package powerline
  :ensure t
  :config
  (setq powerline-default-separator "wave")
  )

(use-package powerline-evil
  :ensure t
  :config
  :init
  (powerline-evil-center-color-theme)
  )

;; Vim mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))
;; evil surround feature with s
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))
;; binds "jk" to the escape key in evil mode
(use-package evil-escape
  :ensure t
  :init
  (setq-default evil-escape-key-sequence "jk")
  :config
  (evil-escape-mode 1))
;; Magit
(use-package evil-magit
  :ensure t)
(use-package magit
  :ensure t)

;; Show relative numbers
(use-package linum-relative
  :ensure t
  :config
  (linum-relative-global-mode))
(setq linum-relative-current-symbol "")
;; Only jump a single visual line when in a multiline sentence
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;; Set ñ to do the same as ;
(define-key evil-motion-state-map "ñ" 'evil-repeat-find-char)

;; Set function to change to previous buffer
(defun er-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; Helm
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
	helm-mode-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-locate-fuzzy-match t
	helm-semantic-fuzzy-match t
	helm-imenu-fuzzy-match t
	helm-completion-in-region-fuzzy-match t
	helm-candidate-number-list 50
	helm-split-window-in-side-p t
	helm-move-to-line-cycle-in-source t
	helm-echo-input-in-header-line t
	helm-display-buffer-height 10
	helm-autoresize-max-height 0
	helm-autoresize-min-height 10)
  :config
  (helm-mode 1))

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode 1))

;; Custom keybinding
(use-package general
  :ensure t
  :config (general-define-key
	   :states '(normal visual insert emacs)
	   :prefix "SPC"
	   :non-normal-prefix "M-SPC"
	   "TAB" '(er-switch-to-previous-buffer :which-key "previous buffer")
	   "SPC" '(helm-M-x :which-key "M-x")
	   ;; Company
	   "a"   '(:which-key "Company")
	   "aa"  '(company-complete :which-key "complete current word")
	   ;; Files
	   "f"   '(:which-key "File")
	   "ff"  '(helm-find-files :which-key "find files")
	   ;; Buffers
	   "b"   '(:which-key "Buffer")
	   "bb"  '(switch-to-buffer :which-key "buffers list")
	   "bd"  '(evil-delete-buffer :which-key "delete current buffer")
	   ;; Window
	   "w"   '(:which-key "Window")
	   "wl"  '(windmove-right :which-key "move right")
	   "wh"  '(windmove-left :which-key "move left")
	   "wk"  '(windmove-up :which-key "move up")
	   "wj"  '(windmove-down :which-key "move bottom")
	   "w/"  '(split-window-right :which-key "split right")
	   "w-"  '(split-window-below :which-key "split bottom")
	   "wd"  '(delete-window :which-key "delete window")
	   ;; Projectile
	   "p"   '(:which-key "Project")
	   "pf"  '(counsel-projectile-find-file :which-key "find project file")
	   "pp"  '(counsel-projectile-switch-project :which-key "switch project")
	   "p&"  '(async-shell-command :which-key "async shell command")
	   "p$"  '(shell-command :which-key "shell command")
	   ;; Search
	   "s" '(:which-key "Search")
	   "sg"  '(counsel-projectile-git-grep :which-key "grep project")
	   ))

;; Projectile
(use-package projectile
  :ensure t
  :init
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode 1))
;; Set up completion mode
(use-package company
  :ensure t
  :config
  (company-mode 1))

;; Org mode packages
(use-package ox-pandoc
  :ensure t)
(use-package org-bullets
  :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


;; PROGRAMMING LANGUAGES
(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node"
  :init
  (use-package json-mode
    :ensure json-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-org proxy-mode counsel-projectile magit evil-magit org-bullets ox-pandoc company projectile general which-key linum-relative helm gruvbox-theme evil-escape use-package-ensure-system-package evil))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
