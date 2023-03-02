;; Enable package.el and configure MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Add custom ELisp init script directory to load path
(add-to-list 'load-path "~/.emacs.d/elisp/")
;; Get my code in here :)
(require 'datakinds)

;; Open this file on C-x C-<return>
(global-set-key (kbd "C-x C-<return>") 'datakinds/open-init-file)

;; Line numbers
(global-display-line-numbers-mode)

;; Show the tab bar if more than one tab exists
(setq tab-bar-show 1)

;; Make C-d a prefix key for cursor movement
(define-prefix-command 'ctl-d-map)
(global-set-key (kbd "C-d") 'ctl-d-map)

;; Install use-package if it's missing
(if (not (package-installed-p 'use-package))
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Enable packages!

;; Theming and graphical packages
(use-package solarized-theme ;; Pretty colors
  :config
  (load-theme 'solarized-light t))
;; TODO: I wanna try https://github.com/doomemacs/themes
(use-package solaire-mode
  :config
  (solaire-global-mode +1))

;; Navigation, basic editing, and QoL packages
(use-package multiple-cursors
  :bind (("C-d C-d" . mc/mark-next-like-this-symbol)
	 ("C-d C-g" . mc/edit-lines)
	 ("C-d <return>" . mc/mark-more-like-this-extended)
	 :map mc/keymap
	 ;; Disable Enter key to kill cursors
	 ("<return>" . nil)
	 ))
(use-package expand-region
  :bind (("C-_" . er/contract-region)
	 ("C-+" . er/expand-region)))
(use-package move-text
  :config
  (move-text-default-bindings))
(use-package counsel ;; Also installs Ivy and Swiper
  ;; Recommended Ivy keybindings to standard commands
  ;; https://oremacs.com/swiper/#global-key-bindings
  :bind (("C-s" . swiper-isearch)
	 ("C-S" . swiper-all)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("M-y" . counsel-yank-pop)
	 ("<f1> f" . counsel-describe-function)
	 ("<f1> v" . counsel-describe-variable)
	 ("<f1> l" . counsel-find-library)
	 ("<f2> i" . counsel-info-lookup-symbol)
	 ("<f2> u" . counsel-unicode-char)
	 ("<f2> j" . counsel-set-variable)
	 ("C-x b" . ivy-switch-buffer)
	 ("C-c v" . ivy-push-view)
	 ("C-c V" . ivy-pop-view)
	 ("C-c c" . counsel-compile)
	 ("C-c g" . counsel-git)
	 ("C-c j" . counsel-git-grep)
	 ("C-c L" . counsel-git-log)
	 ("C-c k" . counsel-rg)
	 ("C-c m" . counsel-linux-app)
	 ("C-c n" . counsel-fzf)
	 ("C-c J" . counsel-file-jump)
	 ("C-c w" . counsel-wmctrl)
	 ("C-c C-r" . ivy-resume)
	 ("<f6>" . ivy-resume)
	 ("C-c b" . counsel-bookmark)
	 ("C-c d" . counsel-descbinds)
	 ("C-c o" . counsel-outline)
	 ("C-c t" . counsel-load-theme)
	 ("C-c F" . counsel-org-file))
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (ivy-mode))
(use-package which-key
  :config (which-key-mode))
(use-package undo-tree
  :config (global-undo-tree-mode))
(use-package avy
  :bind (("M-SPC" . avy-goto-char-timer)))

;; Extra language modes
(use-package zig-mode)

;; Autocomplete and LSP stuff
(use-package company
  :bind (("C-i" . company-complete)
         ("TAB" . company-indent-or-complete-common))
  :config
  (global-company-mode))
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-'")
  :hook ((prog-mode . lsp)
	 (lsp-mode . lsp-enable-which-key-integration)))
(use-package lsp-ivy)
(use-package lsp-ui)
(use-package flycheck
  :config (global-flycheck-mode))

;; Syntax highlighting
(use-package tree-sitter
  :config
  (global-tree-sitter-mode))
(use-package tree-sitter-langs
  :hook (tree-sitter-after-on . tree-sitter-hl-mode))

;; Forward all M-x customize-* configuration to custom.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

