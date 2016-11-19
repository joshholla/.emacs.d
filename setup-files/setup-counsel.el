;;; -*- lexical-binding: t -*-
;; Time-stamp: <2016-11-19 19:31:37 csraghunandan>

;; counsel
;; https://github.com/abo-abo/swiper
;; provides incremental completion backends for a lot of emacs stuff using ivy
(use-package counsel :defer t
  :bind*
  (("M-x" . counsel-M-x)
   ("C-c r d" . counsel-goto-recent-directory)
   ("C-c d d" . counsel-descbinds)
   ("C-c s s" . counsel-ag)
   ("C-c s d" . rag/counsel-ag-project-at-point)
   ("C-x C-f" . counsel-find-file)
   ("C-c g g" . counsel-git)
   ("C-c g G" . counsel-git-grep)
   ("C-M-y" . counsel-yank-pop)
   ("C-c C-r" . ivy-resume)
   ("C-c f" . counsel-imenu)
   ("C-c F" . ivy-imenu-anywhere)
   ("C-c d s" . describe-symbol)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line-and-call))

  :init
  (with-eval-after-load 'org
    (bind-key "C-c C-q" #'counsel-org-tag org-mode-map))
  (with-eval-after-load 'org-agenda
    (bind-key "C-c C-q" #'counsel-org-tag-agenda org-agenda-mode-map))

  :config
  ;; ignore case sensitivity for counsel grep
  (setq counsel-grep-base-command "grep -nEi \"%s\" %s")

  (defun reloading (cmd)
    (lambda (x)
      (funcall cmd x)
      (ivy--reset-state ivy-last)))
  (defun given-file (cmd prompt) ; needs lexical-binding
    (lambda (source)
      (let ((target
	     (let ((enable-recursive-minibuffers t))
	       (read-file-name
		(format "%s %s to:" prompt source)))))
	(funcall cmd source target 1))))
  (defun confirm-delete-file (x)
    (dired-delete-file x 'confirm-each-subdirectory))

  (ivy-add-actions
   'counsel-find-file
   `(("c" ,(given-file #'copy-file "Copy") "copy")
     ("d" ,(reloading #'confirm-delete-file) "delete")
     ("m" ,(reloading (given-file #'rename-file "Move")) "move")))
  (ivy-add-actions
   'counsel-projectile-find-file
   `(("c" ,(given-file #'copy-file "Copy") "copy")
     ("d" ,(reloading #'confirm-delete-file) "delete")
     ("m" ,(reloading (given-file #'rename-file "Move")) "move")
     ("b" counsel-find-file-cd-bookmark-action "cd bookmark")))

  (defun rag/counsel-ag-project-at-point ()
    "use counsel ag to search for the word at point in the project"
    (interactive)
    (counsel-ag (thing-at-point 'symbol) (projectile-project-root)))

  ;; find file at point
  (setq counsel-find-file-at-point t)

  ;; ignore . files or temporary files
  (setq counsel-find-file-ignore-regexp
	(concat
	 ;; File names beginning with # or .
	 "\\(?:\\`[#.]\\)"
	 ;; File names ending with # or ~
	 "\\|\\(?:\\`.+?[#~]\\'\\)"))
  ;; show parent directory in prompt
  (ivy-set-prompt 'counsel-ag #'counsel-prompt-function-dir)

  (defun counsel-goto-recent-directory ()
    "Open recent directory with dired"
    (interactive)
    (unless recentf-mode (recentf-mode 1))
    (let ((collection
           (delete-dups
            (append (mapcar 'file-name-directory recentf-list)
                    ;; fasd history
                    (if (executable-find "fasd")
                        (split-string (shell-command-to-string "fasd -ld") "\n" t))))))
      (ivy-read "directories:" collection :action 'dired))))

(provide 'setup-counsel)
