;; Enable package.el and configure MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Add custom ELisp init script directory to load path
(add-to-list 'load-path "~/.emacs.d/elisp/")
;; Get my code in here :)
(require 'datakinds)

;; Open this file on C-x C-<return>
(global-set-key (kbd "C-x C-<return>") 'dk/open-init-file)

;; Line numbers in prog-mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Show the tab bar if more than one tab exists
(setq tab-bar-show 1)

;; Fast scrolling
(setq fast-but-imprecise-scrolling t)

;; Hide the toolbar
(tool-bar-mode 0)

;; Replace the default dired insert command
(with-eval-after-load "dired"
  (define-key dired-mode-map "i" 'dired-subtree-insert)
  (define-key dired-mode-map ";" 'dired-subtree-remove)
  (all-the-icons-dired-mode)
  (require 'dired-x)) ;; For omit mode!

;; Debug on freeze!
;; To debug emacs, run `kill -SIGUSR2 <emacs PID>`
(setq debug-on-event 'sigusr2)

;; Enable horizontal scrolling using the mouse
(global-set-key (kbd "<mouse-6>") (lambda () (interactive)
                                    (if truncate-lines (scroll-right 1))))
(global-set-key (kbd "<mouse-7>") (lambda () (interactive)
                                    (if truncate-lines (scroll-left 1))))

;; She may contain the urge to get away...
;; (global-set-key (kbd "M-j") 'dk/alt-j)

;; Reload files when changed on disk
(global-auto-revert-mode 1)

;; Make C-d a prefix key for cursor movement
(define-prefix-command 'ctl-d-map)
(global-set-key (kbd "C-d") 'ctl-d-map)

;; Duplicate line on C-d C-d
;; (global-set-key (kbd "C-d C-d") 'dk/duplicate-line)
(use-package duplicate-thing
  :bind (("M-S-<down>" . duplicate-thing)))

;; Unbind (suspend-frame), which crashes Emacs under i3 lol
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

;; It's useful!
(global-set-key (kbd "C-c C-e") 'sgml-close-tag)
(global-set-key (kbd "C-S-b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x x r") 'rename-visited-file)


;; Install use-package if it's missing
(if (not (package-installed-p 'use-package))
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-always-demand (daemonp))

;; Enable packages!
;; Everything that comes with emacs
(use-package emacs
  :init
  (setq completion-cycle-threshold 1)
  (electric-pair-mode)
  (setq tab-always-indent 'complete)
  (pixel-scroll-precision-mode)
  (setq jit-lock-defer-time 0.25))
(use-package org
  :bind
  (:map org-mode-map
        ("C-c C-M-l" . org-store-link)))
(use-package org)

;; Theming and graphical packages
(use-package solarized-theme ;; Pretty colors
  :config
  (load-theme 'solarized-light t))
;; TODO: I wanna try https://github.com/doomemacs/themes
(use-package solaire-mode
  :config
  (solaire-global-mode +1))
;; (use-package beacon
;;   :config
;;   (beacon-mode 1))
(use-package dashboard
  :ensure t
  :config
  (setq
   dashboard-projects-backend 'project-el
   dashboard-startup-banner 'logo
   dashboard-items '((recents  . 15)
                     ;; (bookmarks . 5)
                     (projects . 5)
                     (registers . 5)))
  (dashboard-setup-startup-hook))
(use-package highlight-indent-guides
  :config
  (setq highlight-indent-guides-method 'column)
  :init
;;  (add-hook 'haskell-mode-hook #'(highlight-indent-guides-mode 0))
  :hook ((yaml-mode . highlight-indent-guides-mode)
         (prog-mode . highlight-indent-guides-mode)))


;; Window nav
(use-package ace-window
  :bind (("C-S-o" . (lambda () (interactive)
                      (ace-window 0)
                      (golden-ratio)))))
(use-package golden-ratio
  :init
  (golden-ratio-mode 1))

;; Navigation and basic editing
;(use-package minimap
;  :bind (("C-c m m" . minimap-mode)
;         ("C-c m k" . minimap-kill)))
(use-package multiple-cursors
  :bind (("C-d C-d" . mc/mark-next-like-this-symbol)
	     ("C-d g" . mc/edit-lines)
	     ("C-d <return>" . mc/mark-more-like-this-extended)
	     :map mc/keymap
	     ;; Disable Enter key to kill cursors
	     ("<return>" . nil)))
(use-package expand-region
  :bind (("C-_" . er/contract-region)
	     ("C-+" . er/expand-region)))
(use-package move-text
  :config
  (move-text-default-bindings))
(use-package magit
  :bind (("C-c g" . magit-file-dispatch)))
(use-package undo-tree
  :config (global-undo-tree-mode))

;; QoL packages
(use-package counsel ;; Also installs Ivy and Swiper
  ;; Recommended Ivy keybindings to standard commands
  ;; https://oremacs.com/swiper/#global-key-bindings
  :bind (("C-s" . swiper-isearch)
         ("C-c C-s" . swiper-all)
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
	     ("C-c M-g" . counsel-git)
	     ("C-c j" . counsel-git-grep)
	     ("C-c L" . counsel-git-log)
	     ("C-c s" . counsel-rg)
	     ("C-c r" . counsel-linux-app)
	     ("C-c j" . counsel-fzf)
	     ("C-c J" . counsel-file-jump)
	     ("C-c w" . counsel-wmctrl)
	     ("C-c M-p" . ivy-resume)
	     ("<f6>" . ivy-resume)
	     ("C-c b" . counsel-bookmark)
	     ("C-c d" . counsel-descbinds)
	     ;; ("C-c o" . counsel-outline)
	     ("C-c t" . counsel-load-theme)
	     ("C-c F" . counsel-org-file))
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t) ;; Fix a bug with Treemacs crashing emacs on rename
  (ivy-mode 1))
(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))
(use-package which-key
  :config (which-key-mode))
(use-package avy
  :bind (("M-SPC" . avy-goto-char-timer)))
(use-package breadcrumb
  :config
  (breadcrumb-mode))

;; Sidebar shtuff
;; Treemacs and its infinite config
;; (use-package treemacs
;;   :bind (("C-c t" . treemacs-select-window)
;;          ("C-x p t" . treemacs-add-and-display-current-project-exclusively))
;;   :config
;;   (treemacs-resize-icons 22)
;;   (treemacs-follow-mode t)
;;   (treemacs-filewatch-mode t)
;;   (treemacs-fringe-indicator-mode 'always)
;;   (treemacs-git-mode 'deferred)
;;   (treemacs-hide-gitignored-files-mode nil))
;; (use-package treemacs-icons-dired
;;   :after (treemacs)
;;   :hook (dired-mode . treemacs-icons-dired-enable-once))
;; Treemacs is so totally broken lol
(use-package dired-sidebar
  :bind (("C-c t" . dired-sidebar-jump-to-sidebar)
         ("C-x p t" . dired-sidebar-toggle-with-current-directory)))
(use-package ibuffer-sidebar
  :bind (("C-x p b" . ibuffer-sidebar-toggle-sidebar))
  :config
  (setq ibuffer-sidebar-use-custom-font t)
  (setq ibuffer-sidebar-face `(:family "Helvetica" :height 140)))
(use-package all-the-icons
  :if (display-graphic-p)
  :ensure t)
(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

;; Extra language modes
(use-package zig-mode)
(use-package haskell-mode)
(use-package bqn-mode
  :bind (:map bqn-mode-map
              ("C-c C-e" . bqn-comint-send-buffer)
              ("C-x C-e" . bqn-comint-send-region))
  :hook (bqn-mode . bqn-comint-buffer)
  :config
  (require 'bqn-keymap-mode)
  (require 'bqn-glyph-mode))
;; (add-to-list 'load-path "~/personal-projects/haskell-mode/")
;; (require 'haskell-mode-autoloads)
;; (add-to-list 'Info-default-directory-list "~/personal-projects/haskell-mode/")

;; Autocomplete
(use-package corfu
  ;; Optional customizations
  ;; :custom
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto nil)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `global-corfu-modes'.
  ;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :init
  (global-corfu-mode))
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block))

;; LSP Stuff
(use-package pyvenv
  :hook (pyvenv-post-activate . eglot)
  :init
  (add-hook 'python-mode-hook (lambda () (pyvenv-activate "./env/"))))
(use-package eglot)
(use-package vterm)



;; Syntax highlighting
(use-package tree-sitter
  :defer t
  :config
  (global-tree-sitter-mode))
(use-package tree-sitter-langs
  :after (tree-sitter)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode))


;; Fun packages
;; RSS feed reader
(use-package elfeed
  :config ;; Doing this here because my config scripts don't pull in custom.el
  (setq elfeed-feeds '("https://eli.thegreenplace.net/feeds/all.atom.xml"
                       "https://datakinds.github.io/feed.xml"
                       "https://www.ecosophia.net/feed/"
                       "https://xkcd.com/rss.xml"
                       "https://www.webtoons.com/en/comedy/safely-endangered/rss?title_no=352"
                       "https://pluralistic.net/feed/"
                       "https://craphound.com/feed"
                       "https://rocknerd.co.uk/feed/"
                       "https://davidgerard.co.uk/blockchain/feed/"
                       "https://devurandom.xyz/blog/main.rss"
                       "https://toaqlanguage.wordpress.com/feed"
                       "https://writings.stephenwolfram.com/feed/"
                       "https://johnwhiles.com/atom.xml"
                       "https://fasterthanli.me/index.xml"
                       "https://verdagon.dev/rss.xml"
                       "https://kseo.github.io/rss.xml"
                       "https://acko.net/atom.xml"
                       "https://ziglang.org/news/index.xml"
                       "https://www.greaterwrong.com/users/eliezer_yudkowsky?show=posts&format=rss"
                       "https://www.greaterwrong.com/users/scottalexander?show=posts&format=rss"
                       "https://nim-lang.org/feed.xml")))

;; Forward all M-x customize-* configuration to custom.el
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Sometimes (ivy-mode 1) in the :config block doesn't work
(if (featurep 'ivy)
    (ivy-mode 1))

;; Raven mode
(define-minor-mode raven-mode
  "Toggle Raven mode. Makes Ivy less lonely."
  :init-value nil
  :lighter " raven")
(put 'scroll-left 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'magit-edit-line-commit 'disabled nil)
