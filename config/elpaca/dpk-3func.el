;; -*- lexical-binding: nil; -*- 

;; ------------------------------------------------------------------
;; dpk-func

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy the current line."
  (interactive
   (if mark-active
	   (list (region-beginning) (region-end))
	 (progn
	   (message "Current line is copied.")
	   (list (line-beginning-position) (line-beginning-position 2)) ) ) ))

(defadvice kill-region (before slick-copy activate compile)
  "When called interactively with no active region, cut the current line."
  (interactive
   (if mark-active
	   (list (region-beginning) (region-end))
	 (progn
	   (list (line-beginning-position) (line-beginning-position 2)) ) ) ))

(defun dpk-kill-buffer () "Kills the current buffer ; mostly for keymap support"
	   (interactive)
	   (kill-buffer nil))

(defun uniquify-all-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
	(let ((end (copy-marker end)))
	  (while
		  (progn
			(goto-char start)
			(re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
		(replace-match "\\1\n\\2")))))

(defun uniquify-all-lines-buffer ()
  "Delete duplicate lines in buffer and keep first occurrence."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))

(defun compile-pkg (&optional command startdir)
  "Compile a package, moving up to the parent directory
  containing configure.ac, if it exists. Start in startdir if defined,
  else start in the current directory."
  (interactive)

  (let ((dirname)
		(dir-buffer nil))
	(setq startdir (expand-file-name (if startdir startdir ".")))
	(setq command  (if command command compile-command))

	(setq dirname (upward-find-file "configure.ac" startdir))
	(setq dirname (if dirname dirname (upward-find-file "Makefile" startdir)))
	(setq dirname (if dirname dirname (expand-file-name ".")))
										; We've now worked out where to start. Now we need to worry about
										; calling compile in the right directory
	(save-excursion
	  (setq dir-buffer (find-file-noselect dirname))
	  (set-buffer dir-buffer)
	  (compile command)
	  (kill-buffer dir-buffer))))

(defun upward-find-file (filename &optional startdir)
  "Move up directories until we find a certain filename. If we
  manage to find it, return the containing directory. Else if we
  get to the toplevel directory and still can't find it, return
  nil. Start at startdir or . if startdir not given"

  (let ((dirname (expand-file-name
				  (if startdir startdir ".")))
		(found nil) ; found is set as a flag to leave loop if we find it
		(top nil))  ; top is set when we get
										; to / so that we only check it once

										; While we've neither been at the top last time nor have we found
										; the file.
	(while (not (or found top))
										; If we're at / set top flag.
	  (if (string= (expand-file-name dirname) "/")
		  (setq top t))

										; Check for the file
	  (if (file-exists-p (expand-file-name filename dirname))
		  (setq found t)
										; If not, move up a directory
		(setq dirname (expand-file-name ".." dirname))))
										; return statement
	(if found dirname nil)))

(defun std-compile ()
  "Like 'compile', but uses compile-pkg"
  (interactive)
  (compile-pkg compile-command))

(defun compile-next-makefile ()
  (interactive)
  (let* ((default-directory (or (upward-find-file "Makefile") "."))
		 (compile-command (concat "cd " default-directory " && "
								  compile-command)))
	(compile compile-command)))

(defun sct-dot ()
  "Generate dot file for graphviz from `simple-call-tree-alist'.

After calling `simple-call-tree-analyze', use `sct-dot' in an
empty buffer via `(insert (sct-dot))'.

Then save the file as \"my-file.dot\" and run
\"dot -Tjpg /path/to/my-file.dot -o result.jpg\" from command line."
  (concat "digraph G {\n" ;; default beginning of a dot file
		  (mapconcat 'identity ;; end each line with a ";"
					 (mapcar
					  (lambda (defun-list)
						"Called for each elemet (list) of `simple-call-tree-alist',
						 create all the 'caller -> callee;' strings."
						(let ((caller (car defun-list))
							  (callees (cdr defun-list)))
						  (if (null callees)
							  (concat "\"" caller "\"")
							(mapconcat (lambda (callee)
										 "Called with each callee, create 'caller -> callee' pairs."
										 (concat "\"" caller "\"" " -> " "\"" callee "\""))
									   callees
									   ";\n"))))
				  simple-call-tree-alist)
					 ";\n")
		  ";\n}"))

(defun find-first-non-ascii-char ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
	(save-excursion
	  (setq point
			(catch 'non-ascii
			  (while (not (eobp))
				(or (eq (char-charset (following-char))
						'ascii)
					(throw 'non-ascii (point)))
				(forward-char 1)))))
	(if point
		(goto-char point)
	  (message "No non-ascii characters."))))

										; search for [:nonascii:]  windows-1252
(defun occur-non-ascii ()
  "Find any non-ascii characters in the current buffer."
  (interactive)
  (occur "[^[:ascii:]]"))

;; toggle header source
(defun ccc-toggle-header-source (&optional arg)
  (interactive "P")
  (let* ((fname (file-name-nondirectory (buffer-file-name)))
		 (name (file-name-sans-extension fname))
		 (cur-ext (file-name-extension fname))
		 (new-ext (if (string= cur-ext "h")
					  "cpp"
					"h"))
		 (new-fname (concat name "." new-ext))
		 files)
	(let ((default-directory (locate-dominating-file default-directory ".git")))
	  (setq files
			(mapcar #'expand-file-name
					(split-string
					 (shell-command-to-string
					  (format "git ls-files */%s" new-fname)) "\n" t))))
	(cl-case (length files)
	  (0
	   (error "%s not found in project" new-fname))
	  (1
	   (if arg
		   (find-file-other-window (car files))
		 (find-file (car files))))
	  (t
	   (ivy-read "file: " files
				 :action 'find-file)))))

  ;; ;; @see http://stackoverflow.com/questions/3509919/ \
  ;; ;; emacs-c-opening-corresponding-header-file
  ;; (local-set-key (kbd "C-x C-o") 'ff-find-other-file)

  ;; (setq cc-search-directories '("." "/usr/include" "/usr/local/include/*" "../*/include" "$WXWIN/include"))

;; ;; open header file under cursor
;; (global-set-key (kbd "C-x C-o") 'ffap)


;; list packages and versions for straight
;; (map-keys straight--recipe-cache)
;; (let ((magit-repository-directories
;;        (list (cons (straight--repos-dir) 1))))
;;   (magit-list-repositories))

;; (defun dpk-list-packages ()
;;   "List installed packages via straight."
;;   (interactive)
;;   (map-keys straight--recipe-cache)
;;   (let ((magit-repository-directories
;; 		 (list (cons (straight--repos-dir) 1))))
;; 	(magit-list-repositories))
;; )

(setq dpk-apollo1 "/ssh:dkrishfield@172.27.4.40:~")
(setq dpk-apollo2 "/ssh:dkrishfield@172.27.4.41:~")
(setq dpk-apollo3 "/ssh:dkrishfield@172.27.4.42:~")

(setq dpk-sdrgv21 "/ssh:dkrishfield@172.27.19.17:~")
(setq dpk-sdrgv22 "/ssh:dkrishfield@172.27.19.18:~")
(setq dpk-sdrgv23 "/ssh:dkrishfield@172.27.19.19:~")

;; sdklink1, 2
;; avance ...





;; apobld1	edchicilapllo01.gogodc.net	10.219.10.7
;;  	edchicilapllo02.gogodc.net	10.219.10.10
;;  	edchicilapllo03.gogodc.net	10.219.10.11b

(defun dpk-home ()
   (interactive)
   (find-file "~")
)

(defun dpk-remote1 ()
   (interactive)
   (find-file dpk-apollo3)
)

(defun dpk-remote2 ()
   (interactive)
   (find-file dpk-sdrgv21)
)

(defun dpk-remote3 ()
   (interactive)
   (find-file dpk-apollo2)
)

(defun dpk-show-frames () "Make all the frames visible"
	   (interactive)
	   (dolist (make-frame-visible (frame-list)))
	   (dolist (raise-frame (frame-list)))
	   (dolist (x-focus-frame (frame-list))))

;; ------------------------------------------------------------------
;; dpk-essentials
;; macro for saving settings in custom.el
;; (defmacro csetq (variable value)
;;   `(funcall (or (get ',variable 'custom-set) 'set-default) ',variable ,value))


;;(setq dired-omit-files
;;      (concat dired-omit-files "\\|^\\..+$"))

;; (defun toggle-omit ()
;;   "Toggle between hide and show."
;;   (interactive)
;;   (setq my-dired-switch (- my-dired-switch))
;;   (if (= my-dired-switch 1)
;;       (dired-sort-other my-dired-ls-switches)
;;     (dired-sort-other "-lBh")))


;; o toggle omitting files in Dired:
;; Ensure dired-x is loaded: dired-omit-mode is part of dired-x, so you need to (require 'dired-x) in your Emacs configuration.
;; Toggle dired-omit-mode:
;; Navigate to a Dired buffer.
;; Type M-x dired-omit-mode and press RET. This will toggle the mode on or off.
;; Alternatively, you can bind dired-omit-mode to a key in dired-mode-map for quicker access. For example:
;; Code

;;         (eval-after-load 'dired
;;           '(define-key dired-mode-map (kbd "M-o") #'dired-omit-mode))


;; (use-package dired
;;   :init
;;    (require 'dired-x) ;; I think this is required for dired-omit-mode

;;   :bind
;;   (:map dired-mode-map
;; 	("s->" . dired-omit-mode)) ;; toggle using Command-Shift-.  same as macOS Finder

;;   :hook
;;   (dired-mode . (lambda () (dired-omit-mode))) ;; hide .dot files by default

;;   :config
;;   (setq dired-omit-files   ;; hide .dot files when in dired-omit-mode
;;       (concat dired-omit-files "\\|^\\..+$")))





;; (defun dired-dotfiles-toggle ()
;;     "Show/hide dot-files"
;;     (interactive)
;;     (when (equal major-mode 'dired-mode)
;;       (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
;; 	  (progn 
;; 	    (set (make-local-variable 'dired-dotfiles-show-p) nil)
;; 	    (message "h")
;; 	    (dired-mark-files-regexp "^\\\.")
;; 	    (dired-do-kill-lines))
;; 	(progn (revert-buffer) ; otherwise just revert to re-show
;; 	       (set (make-local-variable 'dired-dotfiles-show-p) t)))))

;; ;; dired-listing-switches -al

;; ;; dired-omit-files
;; ;; dired-omit-extensions

;; (add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))

;; (add-hook 'dired-mode-hook
;;            (lambda ()
;;              (define-key dired-mode-map (kbd "M-o")
;;                (lambda ()
;;                  "Toggle between hide and show."
;;                  (interactive)
;;                  (setq my-dired-switch (- my-dired-switch))
;;                  (if (= my-dired-switch 1)
;;                      (dired-sort-other my-dired-ls-switches)
;;                    (dired-sort-other "-lBh"))))))

;; ;;                   (dired-sort-other "-alh"))))))

;; (setq my-dired-ls-switches "-alh --ignore=.* --ignore=\\#* --ignore=*~")
;; (setq my-dired-switch 1)

;; ;; (add-hook 'dired-mode-hook
;; ;;            (lambda ()
;; ;;              "Set the right mode for new dired buffers."
;; ;;              (when (= my-dired-switch 1)
;; ;;                (dired-sort-other my-dired-ls-switches))))


;; (defun toggle-omit ()
;;   "Toggle between hide and show."
;;   (interactive)
;;   (setq my-dired-switch (- my-dired-switch))
;;   (if (= my-dired-switch 1)
;;       (dired-sort-other my-dired-ls-switches)
;;     (dired-sort-other "-lBh")))

;; (use-package dired
;;   :ensure nil
;;   :commands dired
;;   :hook
;;   (dired-mode . dired-hide-details-mode)
;;   ;; (dired-mode . (lambda () (toggle-truncate-lines)))
;;   :general
;;   (dired-mode-map "C-c C-d" 'mkdir
;;                   "C-," 'dired-omit-mode)
;;   ('normal dired-mode-map "h" 'dired-up-directory)
;;   (dired-mode-map "M-o" 'dired-omit-mode)
;;   ('normal dired-mode-map "l" 'dired-find-alternate-file)
;;   ('normal dired-mode-map "C-<return>" 'dired-find-file-other-window)
;;   ("C-x C-j" 'dired-jump-other-window)
;;   ("C-x j" 'dired-jump)
;;   (dired-jump-map "j" nil)             ; remove repeat with "j"
;;   (dired-mode-map "SPC" nil)             ; use for easymotion
;;   ('normal image-dired-thumbnail-mode-map "+" 'image-increase-size)
;;   ('normal image-dired-thumbnail-mode-map "g r" 'image-dired-refresh-thumb)
;;   :config
;;   (setq dired-omit-files "^\\.\\|^#.#$\\|.~$"
;;         dired-auto-revert-buffer t
;;         dired-listing-switches "-AGhlv -lt --group-directories-first --time-style=long-iso"	; human readable format when in detail
;;         dired-kill-when-opening-new-dired-buffer t ; kill when changing dir
;;         dired-recursive-copies 'always
;;         dired-recursive-deletes 'always
;;         ;; manjaro: ~/.local/share/Trash/
;;         delete-by-moving-to-trash t	; move to trash (problem with naming and tramp)
;;         remote-file-name-inhibit-delete-by-moving-to-trash t ; when in remote, just delete
;;         )

;;   ;; kill the dired buffer and enters the current line file or directory
;;   (put 'dired-find-alternate-file 'disabled nil)

;;   ;; after 'evil-collection'
;;   ;; because general uses `after-load-functions' and evil-collection uses `eval-after-load'
;;   (general-def 'normal dired-mode-map "SPC" nil)

;;   ;; Open pdf in dired with `!` and the default application 
;;   (setq dired-guess-shell-alist-user
;;         '(("\\.pdf\\'" "okular")
;;           ("\\.png\\'" "feh --auto-reload")
;;           ("\\.svg\\'" "feh --auto-reload"))))
