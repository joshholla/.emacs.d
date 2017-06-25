;; Time-stamp: <2017-06-26 03:33:04 csraghunandan>

;; JavaScript configuration

;; js2-mode: enhanced JavaScript editing mode
;; https://github.com/mooz/js2-mode
(use-package js2-mode
  :mode
  (("\\.js$" . js2-mode)
   ("\\.json$" . js2-jsx-mode)
   ("\\.jsx$" . js2-jsx-mode))
  :bind (:map js2-mode-map
              ("C-c C-l" . indium-eval-buffer))
  :config
  ;; extra features for imenu
  (add-hook 'js2-mode-hook (lambda ()
                             (js2-imenu-extras-mode)))

  ;; tern: IDE like features for javascript and completion
  ;; http://ternjs.net/doc/manual.html#emacs
  (use-package tern
    :diminish tern-mode "𝐓𝐞"
    :config
    (defun my-js-mode-hook ()
      "Hook for `js-mode'."
      (set (make-local-variable 'company-backends)
           '((company-tern company-files company-yasnippet))))
    (add-hook 'js2-mode-hook 'my-js-mode-hook)
    (add-hook 'js2-mode-hook 'company-mode))

  (add-hook 'js2-mode-hook 'tern-mode)

  ;; turn off all warnings in js2-mode
  (setq js2-mode-show-parse-errors t)
  (setq js2-mode-show-strict-warnings nil)

  ;; enable flycheck in js2-mode
  (add-hook 'js2-mode-hook 'flycheck-mode)
  (when (executable-find "eslind_d")
    (setq flycheck-javascript-eslint-executable "eslint_d"))

  ;; company-tern: company backend for tern
  ;; http://ternjs.net/doc/manual.html#emacs
  (use-package company-tern
    :config
    ;; Disable completion keybindings, as we use xref-js2 instead
    (define-key tern-mode-keymap (kbd "M-.") nil)
    (define-key tern-mode-keymap (kbd "M-,") nil))

  ;; js2-refactor: refactoring options for emacs
  ;; https://github.com/magnars/js2-refactor.el
  (use-package js2-refactor
    :diminish js2-refactor-mode "𝐉𝐫"
    :bind
    (:map js2-mode-map
          ("C-k" . js2r-kill))
    :config (js2r-add-keybindings-with-prefix "C-c C-r"))

  (add-hook 'js2-mode-hook 'js2-refactor-mode)

  ;; prettier-emacs: minor-mode to prettify javascript files on save
  ;; https://github.com/prettier/prettier-emacs
  (when (executable-find "prettier")
    (use-package prettier-js
      :config
      (add-hook 'js2-mode-hook 'prettier-js-mode)))

  ;; xref-js2: Jump to references/definitions using ag & js2-mode's AST in Emacs
  ;; https://github.com/nicolaspetton/xref-js2
  (use-package xref-js2
    :config

    ;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
    ;; unbind it.
    (define-key js-mode-map (kbd "M-.") nil)

    (add-hook 'js2-mode-hook (lambda ()
      (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))))

  ;; json-snatcher: get the path of any JSON element easily
  ;; https://github.com/Sterlingg/json-snatcher
  (use-package json-snatcher
    :config
    (defun js-mode-bindings ()
      "Sets a hotkey for using the json-snatcher plugin"
      (when (string-match  "\\.json$" (buffer-name))
        (local-set-key (kbd "C-c C-g") 'jsons-print-path)))
    (add-hook 'js2-mode-hook 'js-mode-bindings))

  ;; indium: javascript awesome development environment
  ;; https://github.com/NicolasPetton/indium
  (use-package indium
    :config (add-hook 'js2-mode-hook 'indium-interaction-mode))

  ;; mocha: emacs mode for running mocha tests
  ;; https://github.com/scottaj/mocha.el
  (use-package mocha
    :bind
    (("C-c m P" . mocha-test-project)
     ("C-c m f" . mocha-test-file)
     ("C-c m p" . mocha-test-at-point)))

  ;; mocha-snippets: snippets for mocha test framework
  ;; https://github.com/cowboyd/mocha-snippets.el
  (use-package mocha-snippets))

(provide 'setup-js)
