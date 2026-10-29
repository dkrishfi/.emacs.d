;;; init.el --- -*- lexical-binding: t; -*-

(load custom-file 'noerror 'nomessage)

(setq package-install-upgrade-built-in t)
(setq use-package-always-ensure t)

;; ------------------------------------------------------------------
;; package handling

(defvar dpk-elpaca-config-dir (expand-file-name "config/elpaca/" user-emacs-directory))

;; Packages that should never get a generated file
(defvar dpk-elpaca-skip-packages '("elpaca" "elpaca-use-package"))

(defun dpk--elpaca-config-files ()
  "Return config files in load order: dpk- files first, then the rest."
  (when (file-directory-p dpk-elpaca-config-dir)
    (let* ((files (directory-files dpk-elpaca-config-dir nil "\\.el\\'"))
           (dpk (seq-filter (lambda (f) (string-prefix-p "dpk-" f)) files))
           (other (seq-remove (lambda (f) (string-prefix-p "dpk-" f)) files)))
      (mapcar (lambda (f) (expand-file-name f dpk-elpaca-config-dir))
              (append (sort dpk #'string<) (sort other #'string<))))))

(defun dpk-load-elpaca-configs ()
  "Load every file in `dpk-elpaca-config-dir', dpk- prefixed files first.
An error in one file is reported but does not stop the others."
  (dolist (file (dpk--elpaca-config-files))
    (with-demoted-errors "Error loading %s: %S"
      (load file nil 'nomessage))))

(defun dpk-scaffold-elpaca-configs ()
  "Create a stub config file for each installed package that lacks one."
  (interactive)
  (if (not (file-directory-p elpaca-builds-directory))
      (message "No Elpaca builds yet; run again after packages are built")
    (make-directory dpk-elpaca-config-dir t)
    (dolist (pkg (directory-files elpaca-builds-directory nil "\\`[^.]"))
      (let ((file (expand-file-name (concat pkg ".el") dpk-elpaca-config-dir)))
        (unless (or (file-exists-p file)
                    (member pkg dpk-elpaca-skip-packages))
          (with-temp-file file
            (insert (format ";;; %s.el --- configuration for %s -*- lexical-binding: t; -*-\n\n"
                            pkg pkg)
                    (format "(use-package %s\n  :ensure t\n  :config\n  )\n" pkg))))))))

;; Create stubs for packages installed since the last run
(add-hook 'elpaca-after-init-hook #'dpk-scaffold-elpaca-configs)
(add-hook 'elpaca-post-queue-hook #'dpk-scaffold-elpaca-configs)

;; Load the configs (dpk-0elpaca.el bootstraps Elpaca and loads first)
(dpk-load-elpaca-configs)

;; Wait for Elpaca to install and activate everything queued above
(when (fboundp 'elpaca-wait)
  (elpaca-wait))

(setq desktop-path (list desktop-dirname)
      desktop-auto-save-timeout 300
      desktop-restore-eager 10
      desktop-load-locked-desktop t)

(desktop-save-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(blackout delight diminish magit markdown-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
