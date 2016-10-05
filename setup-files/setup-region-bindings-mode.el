;; Region Bindings Mode
;; https://github.com/fgallina/region-bindings-mode

;; Minor mode that enables the ability of having a custom keys for working with
;; regions. This is a pretty good way to keep the global bindings clean.

(use-package region-bindings-mode
  :config
  (progn
    (region-bindings-mode-enable)

    (bind-keys
     :map region-bindings-mode-map
     ("w" . xah-cut-line-or-region)
     ("c" . xah-copy-line-or-region)
     ("(" . wrap-wth-parens)
     ("{" . wrap-with-braces)
     ("'" . wrap-with-single-quotes)
     ("\"" . wrap-with-double-quotes)
     ("d" . duplicate-current-line-or-region)
     ("n" . rag/narrow-or-widen-dwim)
     ("e" . eval-region)
     ("q" . query-replace))))


(provide 'setup-region-bindings-mode)