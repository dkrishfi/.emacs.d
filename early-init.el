;;; early-init.el --- Early Init File -*- lexical-binding: t; no-byte-compile: t -*-

(defvar dpk-state-dir (expand-file-name "settings/" user-emacs-directory))
(make-directory dpk-state-dir t)

;; no-littering: keep its var/ and etc/ trees under settings/
(setq no-littering-var-directory (expand-file-name "var/" dpk-state-dir)
      no-littering-etc-directory (expand-file-name "etc/" dpk-state-dir))

(setq custom-file (expand-file-name "etc/custom.el" dpk-state-dir))

;; Native compilation cache (must run before startup, so it stays here)
(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (expand-file-name "eln-cache/" no-littering-var-directory)))

;; Create every state directory explicitly
(dolist (dir (list dpk-state-dir
                   (expand-file-name "eln-cache/" dpk-state-dir)
                   (expand-file-name "desktop/" dpk-state-dir)))
  (make-directory dir t))

;; Native compilation cache
(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (expand-file-name "eln-cache/" dpk-state-dir)))

;; Desktop session file
(setq desktop-dirname (expand-file-name "desktop/" dpk-state-dir))

;; Disable package.el in favor of elpaca
(setq package-enable-at-startup nil)

;; Add gcc/libgccjit paths
(defun my-prepend-env-var (var-name value)
  "Prepend VALUE to the environment variable VAR-NAME, avoiding empty entries."
  (let ((current (getenv var-name)))
    (setenv var-name
            (if (and current (not (string-empty-p current)))
                (concat value ":" current)
              value))))

(let ((gccjitpath "/opt/local/bin:/opt/local/lib"))
  (my-prepend-env-var "LIBRARY_PATH" gccjitpath)
  (my-prepend-env-var "LD_LIBRARY_PATH" gccjitpath)
  (my-prepend-env-var "PATH" "/opt/local/bin"))

;; Make Emacs itself see the new executables
(add-to-list 'exec-path "/opt/local/bin")

(with-eval-after-load 'warnings
  (add-to-list 'warning-suppress-types '(files lexical-binding)))
