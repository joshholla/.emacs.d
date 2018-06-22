;; Time-stamp: <2018-06-22 12:23:11 csraghunandan>

;; Copyright (C) 2016-2018 Chakravarthy Raghunandan
;; Author: Chakravarthy Raghuandan rnraghunandan@gmail.com

;; TODO: Add auctex configuration here
;; LaTeX
;; https://www.gnu.org/software/auctex/
(use-package auctex
  :mode ("\\.tex\\'" . latex-mode)
  :init
  (require 'tex-mode)
  ;; (load "auctex")
  :config
  ;; http://www.gnu.org/software/auctex/manual/auctex/Multifile.html
  (setq TeX-PDF-mode   t)
  (setq TeX-auto-save  t)
  (setq TeX-parse-self t)
  (setq TeX-save-query nil)
  (setq-default TeX-master nil))

(provide 'setup-tex)
