;; -*- lexical-binding: nil; -*- 

;; ------------------------------------------------------------------
;; dpk-keys
;; ------------------------------------------------------------------

;; ------------------------------------------------------------------
;; key bindings
;; ------------------------------------------------------------------

(global-set-key [f1] 'info)
(global-set-key [f2] 'save-buffer)
(global-set-key [f3] 'query-replace)
(global-set-key [f4] 'make-frame)
(global-set-key [f5] 'find-file)
(global-set-key [f6] 'split-window-horizontally)
(global-set-key [f7] 'find-grep-dired)
(global-set-key [f8] 'dpk-kill-buffer)
(global-set-key [f9] 'delete-other-windows)
(global-set-key [f10] 'comment-or-uncomment-region)
(global-set-key [f11] 'eval-last-sexp)
(global-set-key [f12] 'find-name-dired)

(global-set-key [S-f4] 'delete-frame)
;; (global-set-key [S-f8] 'make-frame)
;; (global-set-key [S-f9] 'make-frame)



;; lsp-ui-flycheck-list)
;; lsp-ui-doc-glance)
(global-set-key [(control tab)] 'next-buffer)
(global-set-key [(shift right)] 'other-window)
(global-set-key [(shift left)] 'other-window)
(global-set-key [(shift up)] 'other-window)
(global-set-key [(shift down)] 'other-window)
(global-set-key [kp-subtract] 'kill-region)   ; cut
(global-set-key [kp-add] 'kill-ring-save) ; copy
(global-set-key [kp-multiply] 'yank)           ; paste
;;;qqq(global-set-key [(meta o)] 'dired-omit-mode)           ;
;(global-set-key [(meta o)] 'toggle-omit)           ;
(global-set-key (kbd "C-x k") 'kill-this-buffer)

(eval-after-load 'dired
    '(define-key dired-mode-map (kbd "M-o") #'dired-omit-mode))

;;(global-set-key [(f10)] 'compile)
;;(global-set-key [(shift f10)] 'compile-next-makefile)
;; (global-set-key [f11] 'delete-other-windows)
										;(global-set-key (kp-minus) 'kill-whole-line)
;; (global-set-key [kp-minus] 'clipboard-kill-region)   ; cut
;; (global-set-key [kp-plus] 'clipboard-kill-ring-save) ; copy
;; (global-set-key [kp-star] 'clipboard-yank)           ; paste
;; (global-set-key [kp-0] 'clipboard-kill-region)   ; cut
										;(global-set-key [kp-minus] 'kill-region)   ; cut
										;(global-set-key [kp-plus] 'kill-ring-save) ; copy
										;(global-set-key [kp-star] 'yank)           ; paste



;; (global-set-key [(alt f1)] 'info)
;; (setq ns-function-modifier 'hyper)  ; make Fn key do Hyper
;; (global-set-key [(hyper f1)] 'split-window-vertically)

;; ------------------------------------------------------------------
;; dpk-ui
;; ------------------------------------------------------------------
;; minimap
;; sublimity or minimap

;; ------------------------------------------------------------------
;; project class outline browser
;; treemacs or neotree

;; ------------------------------------------------------------------
;; project file browser

;; ------------------------------------------------------------------
;; show overview/progress pane

;; ------------------------------------------------------------------
;; show git status

;; ------------------------------------------------------------------
;; display current funtion name
;; qqq (which-function-mode)

(global-set-key (kbd "C-=") 'uniquify-all-lines-region)


;; control     control
;; hyper       option
;; meta == alt command
;; alt == meta
;; super       not set
;; none

(setq mac-command-modifier 'meta) ; aka alt
(setq mac-option-modifier 'hyper)


; shift stays shift
(global-set-key (kbd "S-<f12>") 'dpk-home)

;(global-set-key [(control <f12>)] 'dpk-remote)
; control stays control
(global-set-key (kbd "C-<f12>") 'dpk-remote1)

; hyper mapped to option
(global-set-key (kbd "H-<f12>") 'dpk-remote2)

; command meta aka alt mapped to command
(global-set-key (kbd "M-<f12>") 'dpk-remote3)

; fn ? super
;(global-set-key (kbd "s-<f12>") 'dpk-remote1)

;; plain Shift Control Hyper  Meta     Super
;;       Shift control option command


;; (setopt mac-option-modifier nil) ns-alternate-modifier ns-option-modifier
;; (setopt mac-right-option-modifier 'alt)
;; (setopt mac-command-modifier 'meta)
;; (setopt mac-right-command-modifier 'super)



