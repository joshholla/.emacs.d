;; Time-stamp: <2018-05-02 13:04:12 csraghunandan>

;; a collection of yasnippet snippets for many languages
;; https://github.com/AndreaCrotti/yasnippet-snippets
(use-package yasnippet-snippets)

;; yasnippet: snippets tool for emacs
;; https://github.com/capitaomorte/yasnippet
(use-package yasnippet
  :requires yasnippet-snippets
  :config
  (yas-global-mode)
  (setq yas-triggers-in-field t) ; Enable nested triggering of snippets
  (setq yas-prompt-functions '(yas-completing-prompt))
  (add-hook 'snippet-mode-hook '(lambda () (setq-local require-final-newline nil)))

  (bind-key "C-c y"
            (defhydra hydra-yas (:color blue
                                        :hint nil)
              "
_i_nsert    _n_ew       _v_isit     aya _c_reate
_r_eload    e_x_pand    _?_ list    aya _e_xpand
"
              ("i" yas-insert-snippet)
              ("n" yas-new-snippet)
              ("v" yas-visit-snippet-file)
              ("r" yas-reload-all)
              ("x" yas-expand)
              ("c" aya-create)
              ("e" aya-expand)
              ("?" yas-describe-tables)
              ("q" nil "cancel" :color blue)))

  ;; No need to be so verbose
  (setq yas-verbosity 1)

  ;; Wrap around region
  (setq yas-wrap-around-region t)

  ;; Jump to end of snippet definition
  (define-key yas-keymap (kbd "C-j") 'yas-exit-all-snippets)

  ;; Inter-field navigation
  (defun yas/goto-end-of-active-field ()
    (interactive)
    (let* ((snippet (car (yas--snippets-at-point)))
           (position (yas--field-end (yas--snippet-active-field snippet))))
      (if (= (point) position)
          (move-end-of-line 1)
        (goto-char position))))

  (defun yas/goto-start-of-active-field ()
    (interactive)
    (let* ((snippet (car (yas--snippets-at-point)))
           (position (yas--field-start (yas--snippet-active-field snippet))))
      (if (= (point) position)
          (move-beginning-of-line 1)
        (goto-char position))))

  (define-key yas-keymap (kbd "C-e") 'yas/goto-end-of-active-field)
  (define-key yas-keymap (kbd "C-a") 'yas/goto-start-of-active-field))

;; auto-yasnippet: create disposable snippets on the fly
;; https://github.com/abo-abo/auto-yasnippet
(use-package auto-yasnippet
  :after yasnippet)

(provide 'setup-yas)
