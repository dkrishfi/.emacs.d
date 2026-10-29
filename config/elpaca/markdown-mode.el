;;; markdown-mode.el --- configuration for markdown-mode -*- lexical-binding: t; -*-

;; preview with C-C C-c p

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown")) 
