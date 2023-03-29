(defun datakinds/open-init-file ()
  "Opens ~/.emacs.d/init.el."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun datakinds/alt-j ()
  "Grace made me do it."
  (interactive)
  (browse-url-of-file "https://www.youtube.com/watch?v=rVeMiVU77wo"))

(defun datakinds/old-duplicate-line ()
  "If no region is selected, copy the whole line."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (forward-line 1)
  (yank))
(defalias 'datakinds/duplicate-line
   (kmacro "C-a C-k C-y <return> C-a C-y C-SPC C-e <backspace>"))

(provide 'datakinds)
;;; datakinds.el ends here
