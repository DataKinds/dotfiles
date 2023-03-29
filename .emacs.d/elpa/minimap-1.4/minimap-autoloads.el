;;; minimap-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))



;;; Generated autoloads from minimap.el

(defvar minimap-mode nil "\
Non-nil if Minimap mode is enabled.
See the `minimap-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `minimap-mode'.")
(custom-autoload 'minimap-mode "minimap" nil)
(autoload 'minimap-mode "minimap" "\
Toggle minimap mode.

This is a global minor mode.  If called interactively, toggle the
`Minimap mode' mode.  If the prefix argument is positive, enable
the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='minimap-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t)
(register-definition-prefixes "minimap" '("minimap-"))

;;; End of scraped data

(provide 'minimap-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; minimap-autoloads.el ends here
