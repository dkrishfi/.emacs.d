;;; copilot.el --- configuration for copilot -*- lexical-binding: t; -*-

(use-package copilot
  :ensure (copilot :host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :bind (:map copilot-completion-map
              ("<tab>" . copilot-accept-completion)
              ("TAB" . copilot-accept-completion)
              ("M-n" . copilot-next-completion)
              ("M-p" . copilot-previous-completion)
              ("C-g" . copilot-clear-overlay))
  :hook ((c-mode c++-mode rust-mode python-mode emacs-lisp-mode) . copilot-mode)
)
