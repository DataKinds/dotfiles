;;; solarized-theme-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))



;;; Generated autoloads from solarized.el

(autoload 'solarized-color-blend "solarized" "\
Blends COLOR1 onto COLOR2 with ALPHA.

COLOR1 and COLOR2 should be color names (e.g. \"white\") or RGB
triplet strings (e.g. \"#ff12ec\").

Alpha should be a float between 0 and 1.

Optional argument DIGITS-PER-COMPONENT can be either 4 (the default) or 2;
use the latter if you need a 24-bit specification of a color.

(fn COLOR1 COLOR2 ALPHA &optional DIGITS-PER-COMPONENT)")
(autoload 'solarized-create-color-palette "solarized" "\
Create color-palette from CORE-PALETTE.

The Returned color-palette has the same format as `solarized-color-palette'

(fn CORE-PALETTE)")
(when (and (boundp 'custom-theme-load-path) load-file-name) (add-to-list 'custom-theme-load-path (file-name-as-directory (file-name-directory load-file-name))))
(register-definition-prefixes "solarized" '("solarized-"))


;;; Generated autoloads from solarized-dark-high-contrast-theme.el

(register-definition-prefixes "solarized-dark-high-contrast-theme" '("solarized-dark-high-contrast"))


;;; Generated autoloads from solarized-dark-theme.el

(register-definition-prefixes "solarized-dark-theme" '("solarized-dark"))


;;; Generated autoloads from solarized-faces.el

(register-definition-prefixes "solarized-faces" '("solarized-definition"))


;;; Generated autoloads from solarized-gruvbox-dark-theme.el

(register-definition-prefixes "solarized-gruvbox-dark-theme" '("solarized-gruvbox-dark"))


;;; Generated autoloads from solarized-gruvbox-light-theme.el

(register-definition-prefixes "solarized-gruvbox-light-theme" '("solarized-gruvbox-light"))


;;; Generated autoloads from solarized-light-high-contrast-theme.el

(register-definition-prefixes "solarized-light-high-contrast-theme" '("solarized-light-high-contrast"))


;;; Generated autoloads from solarized-light-theme.el

(register-definition-prefixes "solarized-light-theme" '("solarized-light"))


;;; Generated autoloads from solarized-palettes.el

(register-definition-prefixes "solarized-palettes" '("solarized-"))


;;; Generated autoloads from solarized-selenized-black-theme.el

(register-definition-prefixes "solarized-selenized-black-theme" '("solarized-selenized-black"))


;;; Generated autoloads from solarized-selenized-dark-theme.el

(register-definition-prefixes "solarized-selenized-dark-theme" '("solarized-selenized-dark"))


;;; Generated autoloads from solarized-selenized-light-theme.el

(register-definition-prefixes "solarized-selenized-light-theme" '("solarized-selenized-light"))


;;; Generated autoloads from solarized-selenized-white-theme.el

(register-definition-prefixes "solarized-selenized-white-theme" '("solarized-selenized-white"))


;;; Generated autoloads from solarized-theme-utils.el

(register-definition-prefixes "solarized-theme-utils" '("solarized-import-faces"))


;;; Generated autoloads from solarized-wombat-dark-theme.el

(register-definition-prefixes "solarized-wombat-dark-theme" '("solarized-wombat-dark"))


;;; Generated autoloads from solarized-zenburn-theme.el

(register-definition-prefixes "solarized-zenburn-theme" '("solarized-zenburn"))

;;; End of scraped data

(provide 'solarized-theme-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; solarized-theme-autoloads.el ends here
