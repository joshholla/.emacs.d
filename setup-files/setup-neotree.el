;; Time-stamp: <2018-05-26 12:17:02 joshuaholla>

;; Neotree: a tree layout file explorer for Emacs
;; https://github.com/jaypei/emacs-neotree
(use-package neotree :defer t
  :config
  (progn
    (setq neo-window-width 35
          neo-autorefresh t
          neo-show-hidden-files t
          neo-confirm-change-root t
          neo-smart-open t
          neo-toggle-window-keep-p t
          projectile-switch-project-action 'neotree-projectile-action
          neo-theme (if window-system 'icons 'nerd)) ; 'classic, 'nerd, 'ascii,
                                        ; 'arrow
       ))

  :bind
  (:map global-map
        ("C-c n" . neotree-toggle)
        ("C-c s t" . neotree-find))

(use-package all-the-icons)

(provide 'setup-neotree)
