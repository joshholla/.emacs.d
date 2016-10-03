(defun my/package-upgrade-packages (&optional no-fetch)
  "Upgrade all packages.  No questions asked.
This function is equivalent to `list-packages', followed by a
`package-menu-mark-upgrades' and a `package-menu-execute'.  Except
the user isn't asked to confirm deletion of packages.
The NO-FETCH prefix argument is passed to `list-packages'.  It
prevents re-download of information about new versions.  It does
not prevent downloading the actual packages (obviously)."
  (interactive "P")
  (let ((package-menu-async nil)) ; This variable was introduced in emacs 25.0
    (save-window-excursion
      (package-list-packages no-fetch)
      (package-menu-mark-upgrades)
      (package-menu-execute 'noquery))))

(defun sk/insert-date (prefix)
  "Insert the current date. With prefix-argument, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%Y-%m-%d")
                 ((equal prefix '(4)) "%A, %d %B %Y")
                 ((equal prefix '(16)) "%Y-%m-%d %H:%M:%S"))))
    (insert (format-time-string format))))
(bind-key "C-c i d" 'sk/insert-date)

(use-package erc :defer t
  :config
  (setq erc-hide-list '("PART" "QUIT" "JOIN"))
  (setq erc-server "irc.freenode.net"
	erc-nick "Rag1212"))

(use-package calendar :defer t
  :config
  (progn
    ;; Highlight today's date in the calendar
    (add-hook 'calendar-today-visible-hook 'calendar-mark-today)))

;; remove all trailing whitespaces in a file after saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; enable disabled commands
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region   'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-defun  'disabled nil)
(put 'set-goal-column  'disabled nil)

(bind-keys*
 ("C-?" . help-command)
 ("s-l" . shell-command))

;; set all yes or no prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)
(setq apropos-do-all t)

(provide 'setup-misc)
