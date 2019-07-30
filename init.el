;;; package --- Emacs's Conf
;;; Commentary:
;; Eli's Emacs config

;;; Code:
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

;; Performance settings
'(jit-lock-stealth-time 1)
'(jit-lock-chunk-size 500)
'(jit-lock-defer-time 0.5)

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(global-auto-revert-mode)
;; Change default font
(add-to-list 'default-frame-alist '(font . "Roboto Mono 11"))
(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width . 80))

;; Ask before closing emacs
(setq confirm-kill-emacs 'y-or-n-p)

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Automatically write matching parens
(electric-pair-mode t)

;; Disable backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; wrap words when reaching end of line
(global-visual-line-mode)

;; Set environment encoding to UTF-8 automatically
(set-language-environment "UTF-8")

;; Set indentation levels
(setq-default indent-tabs-mode nil)
(setq tab-width 2)

;; Set emacs to open an specific folder on start
(setq initial-buffer-choice "~/Documents")

;; Show relative numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Set org-agenda files
(setq org-agenda-files (list "~/documents/org/agenda.org"))
(setq org-catch-invisible-edits 'error)

;; Highlight current line
(global-hl-line-mode +1)

;; Save the cursor position in buffer for future sessions
(save-place-mode 1)

;; Changes how emacs shows when two buffers are named the same
(setq uniquify-buffer-name-style 'forward)

(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      load-prefer-newer t
      ediff-window-setup-function 'ediff-setup-windows-plain
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))

;; Navigate text objects with camelCase or snake_case
(global-subword-mode)

;; Vim style modal editing
(use-package evil
  :ensure t
  :config
  (evil-mode 1))
;; evil surround feature with s
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode))
;; binds "jk" to the escape key in evil mode
(use-package evil-escape
  :ensure t
  :init
  (setq-default evil-escape-key-sequence "jk")
  :config
  (evil-escape-mode 1))
;; evil-matchit improves % behaviour adding lots of languages
(use-package evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode))
;; evil-visualstar
(use-package evil-visualstar
  :ensure t
  :config
  (global-evil-visualstar-mode))
;; evil-commentary adds gcc comment functions to emacs
(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))
(use-package evil-numbers
  :ensure t
  :config
  (define-key evil-normal-state-map (kbd "C-c a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c x") 'evil-numbers/dec-at-pt))

;; When using daemon load things correctly
(defun init-my-config (&optional _frame)
  (load-theme 'solarized-dark t)
  (doom-modeline-refresh-bars))

(defun my-reload-config-in-daemon (frame)
  (when (or (daemonp) (not (display-graphic-p)))
    (with-selected-frame frame
      (run-with-timer 0.1 nil #'init-my-config))))

(add-hook 'after-make-frame-functions #'my-reload-config-in-daemon)

;; Only jump a single visual line when in a multiline sentence
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; Company menu navigation
(define-key evil-insert-state-map (kbd "C-j") 'company-select-next)
(define-key evil-insert-state-map (kbd "C-k") 'company-select-previous)
(define-key evil-insert-state-map (kbd "C-l") 'company-complete-selection)

;; Minibuffer navigation
(define-key minibuffer-local-must-match-map (kbd "C-j") 'next-history-element)
(define-key minibuffer-local-must-match-map (kbd "C-k") 'previous-history-element)

;; Loads path from shell into emacs
(use-package exec-path-from-shell
  :ensure t)
;; Theme

(use-package doom-themes
  :ensure t)

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

(use-package powerline
  :ensure t)
(use-package powerline-evil
  :ensure t
  :config
  (powerline-evil-vim-color-theme))

;; All the icons for doom-modeline
(use-package all-the-icons
  :ensure t)

;; Projectile
(use-package projectile
  :ensure t
  :init
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode 1))

;; Helm projectile
(use-package helm-projectile
  :ensure t)

;; Consistend coding styles for everybody in the same project
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; Magit
(use-package evil-magit
  :ensure t)

(use-package magit
  :ensure t)
;; Origami mode allows blocks of code to be folded
(use-package origami
  :ensure t
  :config
  (global-origami-mode))

(use-package electric-operator
  :ensure t)

;; Replacement to TAGS, no need to mantain a TAGS file, can use ag, ripgrep or git grep
(use-package dumb-jump
  :ensure t
  :config
  (dumb-jump-mode)
  (setq dumb-jump-force-searcher 'rg))

;; RipGrep
(use-package helm-rg :ensure t)

;; Information about current search pattern's results
(use-package anzu
  :ensure t
  :config
  (set-face-attribute 'anzu-mode-line nil :foreground "#ff5555" :weight 'bold)
  (global-anzu-mode))

;; When deleting a whitespace, delete the rest until a non whitespace char
(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))
;; Delete unnecessary whitespace's before saving)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Google this googles what's under cursor
(use-package google-this
  :ensure t)

;; Highlight block delimiters in a rainbow color scheme to differenciate them better
(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(use-package rainbow-mode
  :ensure t)

(use-package expand-region
  :ensure t)

;; Set function to change to previous buffer
(defun er-switch-to-previous-buffer ()
  "Switch to previously open buffer.
  Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun copy-buffer-filepath ()
  "Copy the result of evaluationg `buffer-file-name` to the clipboard."
  (interactive)
  (kill-new (eval buffer-file-name)))

(defun edit-init-el ()
  "Open init file."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(use-package vimrc-mode
  :ensure t
  :mode "\\.vimrc\\'")

(defun edit-vimrc ()
  "Open init file."
  (interactive)
  (find-file "~/.vimrc"))

(defun reload-config ()
  "Reload init.el config file."
  (interactive)
  (load-file "~/.emacs.d/init.el"))

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
        helm-candidate-number-list 80
        helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t
        helm-echo-input-in-header-line t
        helm-autoresize-max-height 0
        helm-autoresize-min-height 20)
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
           "a"   '(:which-key "Autocompletion")
           "af"  '(company-files :which-key "Complete file path")
           ;; Text
           "t"   '(:which-key "Text")
           "tr"  '(string-rectangle :which-key "string rectangle")
           "te"  '(er/expand-region :which-key "expand region")
           ;; Org
           "o"   '(:which-key "Org mode")
           "ox"  '(org-export-dispatch :which-key "export org file")
           ;; Files
           "f"   '(:which-key "File")
           "ff"  '(helm-find-files :which-key "find files")
           "f."  '(find-file-at-point :which-key "find file at point")
           "ft"  '(neotree-toggle :which-key "toggle neotree")
           ;; Buffers
           "b"   '(:which-key "Buffer")
           "bb"  '(switch-to-buffer :which-key "buffers list")
           "bd"  '(evil-delete-buffer :which-key "delete current buffer")
           "bs"  '(avy-goto-char-timer :which-key "find string in current buffer")
           "by"  '(copy-buffer-filepath :which-key "copy buffer filepath")
           ;; Window
           "w"   '(:which-key "Window")
           "wl"  '(windmove-right :which-key "move right")
           "wh"  '(windmove-left :which-key "move left")
           "wk"  '(windmove-up :which-key "move up")
           "wj"  '(windmove-down :which-key "move bottom")
           "w/"  '(split-window-right :which-key "split right")
           "w-"  '(split-window-below :which-key "split bottom")
           "wd"  '(delete-window :which-key "delete window")
           "wo"  '(delete-other-windows :which-key "delete other windows")
           "wm"  '(maximize-window :which-key "toggle maximize window")
           "wb"  '(balance-windows :which-key "equalizes window size")
           ;; Frames
           "mn"  '(new-frame :which-key "New frame")
           "mx"  '(delete-frame :which-key "delete current frame")
           "mm"  '(toggle-frame-maximized :which-key "toggle maximize frame")
           ;; Projectile
           "p"   '(:which-key "Project")
           "pf"  '(helm-projectile-find-file :which-key "find project file")
           "pp"  '(helm-projectile-switch-project :which-key "switch project")
           "pr"  '(projectile-replace :which-key "replace in project")
           "pm"  '(projectile-command-map :which-key "replace in project")
           "p&"  '(async-shell-command :which-key "async shell command")
           "p$"  '(shell-command :which-key "shell command")
           ;; Search
           "s"   '(:which-key "Search")
           "sg"  '(helm-projectile-rg :which-key "grep project")
           ;; Version Control
           "v"   '(:which-key "Version Control")
           "vm"  '(magit :which-key "launch magit")
           "vu"  '(undo-tree-visualize :which-key "visualize undo tree")
           ;; Dotfiles
           "d"   '(:which-key "Dotfiles")
           "de"  '(edit-init-el :which-key "edit emacs\' init.el")
           "dv"  '(edit-vimrc :which-key "edit vim's .vimrc")
           ;; Error checking
           "e"   '(:which-key "Error")
           "el"  '(flycheck-error-list :which-key "List errors")
           "en"  '(flycheck-error-list-next-error :which-key "Go to next error")
           "ep"  '(flycheck-error-list-previous-error :which-key "Go to previous error")
           ;; Go to
           "g"   '(:which-key "Go to")
           "gt"  '(google-this :which-key "google selection")
           "gx"  '(browse-url :which-key "open url")
           ;; Utilities
           "u"   '(:which-key "Utilities")
           "ur"  '(reload-config  :which-key "reload config")))


;; NeoTree
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; Flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config  (setq flycheck-check-syntax-automatically '(save mode-enabled)))
;; Flycheck uses a tooltip below errors to show them
(use-package flycheck-pos-tip
  :ensure t
  :config
  (setq flycheck-pos-tip-timeout 10
        flycheck-display-errors-delay 0.5))

(add-hook 'global-flycheck-mode-hook (lambda ()
                                       (flycheck-pos-tip-mode)))

;; Language Server Protocol integration
(use-package lsp-mode
  :ensure t
  :commands lsp
  :init
  (lsp)
  :config
  (require 'lsp-clients))

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

;; Snippet support
(use-package yasnippet
  :ensure t)

;; Org mode packages and settings
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(use-package evil-org
  :ensure t
  :after ox)
(use-package ox-pandoc
  :after ox
  :ensure t)
(use-package org-bullets
  :after ox
  :ensure t)
(use-package ox-reveal
  :after ox
  :ensure t)
(use-package ox-hugo
  :ensure t
  :after ox)
(use-package ox-clip
  :ensure t
  :after ox)

(add-hook 'org-mode-hook (lambda ()
                           (org-bullets-mode)
                           (evil-org-mode)))
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'gfm-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'auto-fill-mode)
;; allow pdflatex to exec shell code so that we can add syntax highlight to pdf's
(setq org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
(setq org-latex-listings 'minted)

;; PROGRAMMING LANGUAGES
;; rust
(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  :config
  (setq rust-format-on-save t))
(use-package racer
  :ensure t
  :config
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t))

(add-hook 'rust-mode-hook (lambda ()
                            (racer-mode)
                            (flycheck-rust-setup)))
(add-hook 'racer-mode-hook #'eldoc-mode)

(use-package cargo
  :ensure t
  :after rust-mode)

(use-package flycheck-rust
  :ensure t
  :after flycheck
  :commands flycheck-rust-setup)

;; c/c++
(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

;; javascript
(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node"
  :config
  (setq-default js2-basic-offset 2))

(use-package js2-refactor
  :ensure t)

(use-package typescript-mode
  :ensure t)
(use-package tide
  :ensure t
  :after (js2-mode company flycheck)
  :hook ((js2-mode . tide-setup)
         (js2-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save))
  :config
  (setq tide-tsserver-executable "/usr/bin/tsserver"))

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

(use-package web-mode
  :ensure t
  :hook (rainbow-mode)
  :mode "\\.html\\'\\|\\.vue\\'"
  :init
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

;; Markdown mode
(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :config
  (setq markdown-fontify-code-blocks-natively t))

;; Set up completion mode
(use-package company
  :ensure t
  :config
  (company-mode 1)
  (setq company-tooltip-align-annotations t)
  (setq company-minimum-prefix-length 1))

(add-hook 'after-init-hook 'global-company-mode)
(setq company-etags-everywhere '(html-mode web-mode js2-mode))
(setq company-idle-delay 0.1)

(add-hook 'js2-mode-hook (lambda ()
                           (lsp)
                           (electric-operator-mode)
                           (company-mode +1)))
(add-hook 'css-mode-hook (lambda ()
                           (electric-operator-mode)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "eec08f7474a519de14f12bff9eef27a9c2f89422b00a2a37bd7d94ed4fcccae4" "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "8aca557e9a17174d8f847fb02870cb2bb67f3b6e808e46c0e54a44e3e18e1020" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "100e7c5956d7bb3fd0eebff57fde6de8f3b9fafa056a2519f169f85199cc1c96" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" default)))
 '(package-selected-packages
   (quote
    (rjsx-mode lsp-javascript-typescript typescript-mode evil-numbers json-mode yasnippet powerline-evil powerline expand-region racer ox-clip ox-beamer ox-md solarized-theme org-reveal rainbow-delimiters cargo exec-path-from-shell google-this flycheck-rust rust-mode toml neotree helm-ag helm-rg xterm-color evil-matchit anzu ag pt ripgrep company-lsp lsp-mode dumb-jump vimrc-mode evil-vimish-fold evil-commentary flycheck-pos-tip electric-operator origami hungry-delete simple counsel-gtags tide doom-themes company-tern editorconfig spaceline-all-the-icons all-the-icons-dired all-the-icons-gnus all-the-icons-ivy doom-modeline markdown-mode evil-visualstar helm-projectile web-mode web-beautify tern helm-gtags ggtags evil-org proxy-mode counsel-projectile magit evil-magit org-bullets ox-pandoc company general which-key linum-relative helm gruvbox-theme evil-escape use-package-ensure-system-package evil))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
