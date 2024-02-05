(defun dk/open-init-file ()
  "Opens ~/.emacs.d/init.el."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun dk/alt-j ()
  "Grace made me do it."
  (interactive)
  (browse-url-of-file "https://www.youtube.com/watch?v=rVeMiVU77wo"))

(defun dk/old-duplicate-line ()
  "If no region is selected, copy the whole line."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (forward-line 1)
  (yank))
(defalias 'dk/duplicate-line
   (kmacro "C-a C-u 1 C-k C-y C-y"))

(defun pyeglot ()
  "Opens a venv then eglot in order."
  (interactive)
  (call-interactively 'pyvenv-activate)
  (call-interactively 'eglot))

(provide 'datakinds)
;;; datakinds.el ends here
