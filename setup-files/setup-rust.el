(use-package rust-mode
  :config
  (add-hook 'rust-mode-hook 'flycheck-mode)
  (add-hook 'rust-mode-hook 'electric-operator-mode)
  (add-hook 'rust-mode-hook
	    (lambda () (local-set-key (kbd "C-c <tab>") #'rust-format-buffer))))

(use-package cargo
  :diminish cargo-mode
  :config (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package racer
  :diminish racer-mode
  :config
  (setq racer-cmd "~/.cargo/bin/racer") ;; Rustup binaries PATH
  ;; place the rustc source directory in your HOME.
  (setq racer-rust-src-path "~/rustc-1.11.0/src")
  (defun my-racer-mode-hook ()
    (set (make-local-variable 'company-backends)
         '((company-capf company-dabbrev-code company-yasnippet company-files))))
  (add-hook 'racer-mode-hook 'my-racer-mode-hook)
  (add-hook 'racer-mode-hook #'company-mode)
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode))

(provide 'setup-rust)
