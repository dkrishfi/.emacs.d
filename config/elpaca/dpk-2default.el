;; -*- lexical-binding: t; -*- 

;; ------------------------------------------------------------------
;; restore old defaults
(require 'facemenu)

;; ;;----------------------------------------------------------------------------
;; ;; Which functionality to enable (use t or nil for true and false)
;; ;;----------------------------------------------------------------------------
;; (setq *is-a-mac* (eq system-type 'darwin))
;; (setq *win64* (eq system-type 'windows-nt))
;; (setq *cygwin* (eq system-type 'cygwin) )
;; (setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
;; (setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
;; (setq *emacs24* (>= emacs-major-version 24))
;; (setq *emacs25* (>= emacs-major-version 25))
;; (setq *emacs26* (>= emacs-major-version 26))
;; (setq *no-memory* (cond
;;                    (*is-a-mac*
;;                     (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
;;                    (*linux* nil)
;;                    (t nil)))

;; ;; @see https://www.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/
;; ;; Emacs 25 does gc too frequently
;; (when *emacs25*
;;   ;; (setq garbage-collection-messages t) ; for debug
;;   (setq best-gc-cons-threshold (* 64 1024 1024))
;;   (setq gc-cons-percentage 0.5)
;;   (run-with-idle-timer 5 t #'garbage-collect))

;; (let* ((minver "24.4"))
;;   (when (version< emacs-version minver)
;;     (error "Emacs v%s or higher is required." minver)))

;; (let ((minver "24.3"))
;;   (when (version< emacs-version minver)
;;     (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
;; (when (version< emacs-version "24.5")
;;   (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

;; ;; OSX specific settings
;; (when (eq system-type 'darwin)
;;   (require 'emacs-osx))

;; ;;; first of all any OS dependent paths has to be set
;; (when on-ms
;;   (load! "init-ms"))

;; ------------------------------------------------------------------
;; emacs internals
;; Increase undo limit
(setq undo-limit (* 10 1024 1024))

;; Don't limit *Messages* to 1000 lines only
(setq message-log-max 16384)

;; Don't limit mark-ring to 16 places only
(setq mark-ring-max 999)

(setq max-lisp-eval-depth 12000
	  max-specpdl-size    3000)

;; ------------------------------------------------------------------
;;** internals
;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
;;(setq gc-cons-threshold 50000000)
(setq gc-cons-threshold (* 10 1024 1024))
(setq ad-redefinition-action 'accept)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-idle-delay 0.500)

;; The new JSON
;; functions 'json-serialize', 'json-insert', 'json-parse-string', and
;; 'json-parse-buffer' are typically much faster than their Lisp
;; counterparts from json.el.
;; (functionp 'json-serialize)


;; isn't needed in 24.5
(setq cache-long-scans t)

;; make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; ------------------------------------------------------------------
;; dpk-files
;; ------------------------------------------------------------------

;; ==========================================================================
;; paths and directories
;; ==========================================================================
(setq make-backup-files nil)

;;---------------------------------------------------------------------------------------
;; Discard customizations
;; Emacs has a comprehensive customization system that allows configuration changes interactively. Personally, I opt to ensure all the configuration I use for my environment is fully declarative. As such, the following configuration sets the custom-file to be a random temporary file created each time Emacs starts. This means any customizations made interactively are discarded entirely.

;;;qqq(setq custom-file (make-temp-file ""))

;;---------------------------------------------------------------------------------------
;; Use separate custom file
;; (setq custom-file "/home/david/.emacs.d/dpk/settings/custom.el")
;; (if (file-exists-p custom-file)
;;     (load custom-file))

;; Save history - no
(setq savehist-mode nil)

;;---------------------------------------------------------------------------------------
;; Manage Backup and autosave files
;; Backup files are created on save in the same directory as the file and end in ~. They can be numbered which makes most sense combined with a different save location and automatic pruning.

;;(setq backup-directory-alist '((".*" . "~/.emacs.d/backup")))
(setq version-control t)
(setq delete-old-versions t)

;; Autosave files are created between saves after a sufficient timeout in the current directory for crash detection, they begin and end with #. Let’s change their save location as well.
;;(setq auto-save-list-file-prefix "~/.emacs.d/autosave/")
;;(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t)))

;; Keep in mind that there is nothing you can do regarding lock files except deactivating them completely (which robs you of the ability to detect session clashes). They are symlinks that are created upon modification of the file in question in its directory and are prefixed by .#. Saving the file makes them disappear (unlike autosave files).

;;---------------------------------------------------------------------------------------
;; save-place
;; I didn’t expect to like this functionality, but it’s pretty neat to start from the last place you were in a file the next time you visit it. Asides from putting the save file somewhere else, I have to enable this behaviour for every buffer since it’s buffer-local.
;; (setq-default save-place t)
;; (setq save-place-file "~/.emacs.d/etc/saveplace")

;;(with-eval-after-load 'saveplace
;;  (setq save-place-file (expand-file-name "places.eld" no-littering-var-directory)))

(save-place-mode)

;; keep the installed packages in .emacs.d
;(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
;(package-initialize)

;;qqq(setq abbrev-file-name "~/.emacs.d/dpk/settings/abbrev_defs")
;;(setq auto-save-list-file-prefix "~/.emacs.d/dpk/settings/auto-save-list/.saves-")
;;qqq
;; (setq custom-theme-directory "~/.emacs.d/dpk/settings")

;; (setq amx-save-file "~/.emacs.d/dpk/settings/amx-items")
;; (setq lsp-session-file "~/.emacs.d/dpk/settings/.lsp-session-v1")
;; (setq transient-values-file "~/.emacs.d/dpk/settings/values.el")
;; (setq transient-levels-file "~/.emacs.d/dpk/settings/levels.el")
;; (setq transient-history-file "~/.emacs.d/dpk/settings/history.el")
;;(csetq yas-snippet-dirs "~/.emacs.d/dpk/settings/history.el")

;; idlwave

;; .cache/
;; .cacheamx-items
;; .emacs.desktop
;; places
;; recentf
;; srecode-map.el
;; tramp
;; var/


;;tramp-backup-directory-alist
;;tramp-auto-save-directory

;; ------------------------------------------------------------------
;; file handling

;; ------------------------------------------------------------------
;; Default file encoding
(prefer-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq org-export-coding-system 'utf-8)
(set-charset-priority 'unicode)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))
(set-default-coding-systems 'utf-8)

;; Always require a newline at end of files
(setq require-final-newline t)

;; Stop prompting for local variables when opening files
(setq enable-local-variables :safe)
(setq enable-local-eval nil)

;; Allow find-file to open ftp/http/etc links
(url-handler-mode)

;; Save copied items from external programs in kill ring
(setq save-interprogram-paste-before-kill t)

;; Right alt is not meta
(setq ns-right-alternate-modifier nil)

(setq find-grep-options "-q -i") ; make case insensitive
(setq kill-whole-line t)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; ------------------------------------------------------------------

;; Don't combine tag tables thanks
(setq tags-add-tables nil)

;; Automatically load changed tags files
(setq tags-revert-without-query t)

;; Use system trash
(setq delete-by-moving-to-trash t)

;; Check (on save) whether the file edited contains a shebang, if yes,
;; make it executable from
;; http://mbork.pl/2015-01-10_A_few_random_Emacs_tips
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

;; ==========================================================================

;;** finding files
(setq vc-follow-symlinks t)
(setq find-file-suppress-same-file-warnings t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
;; dup (prefer-coding-system 'utf-8)

;;** minibuffer interaction
(setq enable-recursive-minibuffers t)
(setq minibuffer-message-timeout 1)
(minibuffer-depth-indicate-mode 1)
(setq read-quoted-char-radix 16)

;;** editor behavior
;;(setq indent-tabs-mode nil)
;;(csetq truncate-lines t)
(setq highlight-nonselected-windows nil)
;;(defalias 'yes-or-no-p 'y-or-n-p)
(setq kill-buffer-query-functions nil)
(add-hook 'server-switch-hook 'raise-frame)
(defadvice set-window-dedicated-p (around no-dedicated-windows activate))
(remove-hook 'post-self-insert-hook 'blink-paren-post-self-insert-function)
(setq eval-expression-print-length nil)
(setq eval-expression-print-level nil)
(setq print-gensym nil)
(setq print-circle nil)
(setq byte-compile--use-old-handlers nil)

;; http://debbugs.gnu.org/cgi/bugreport.cgi?bug=16737
(setq x-selection-timeout 10)

;; improves copying from a ssh -X Emacs.
(setq x-selection-timeout 100)
(setq lpr-command "gtklp")

;; ------------------------------------------------------------------
;; personal info
;;(setq user-full-name "Bozhidar Batsov"
;;      user-mail-address "bozhidar@batsov.com")

;; ;; http://www.jmdeldin.com/posts/2016/sunrise-and-sunsets-in-emacs.html
;; (setq calendar-latitude 53.482449)
;; (setq calendar-longitude -2.340598)
;; (setq calendar-location-name "Eccles, UK")

;; (setq user-full-name "Rodrigo Lazoti")
;; (setq user-mail-address "rodrigolazoti@gmail.com")

;; ------------------------------------------------------------------
;; Always load newest byte code
(setq load-prefer-newer t)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; Newline at end of file
(setq require-final-newline t)

;; delete the selection with a keypress
(delete-selection-mode t)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; ==========================================================================
;; open .h files as cpp file (not c file)
;; ==========================================================================
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))

;; Display as hex instead of octal
(setq display-raw-bytes-as-hex t)

;; ------------------------------------------------------------------
;; Scrolling
(setq scroll-step 1)
(setq scroll-conservatively 0)

;; nice scrolling
(setq scroll-margin 0
	  scroll-conservatively 100000
	  scroll-preserve-screen-position 1)

;; Vertical Scroll
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
;; Horizontal Scroll
(setq hscroll-step 1)
(setq hscroll-margin 1)

;; ------------------------------------------------------------------
;; bars
;;(menu-bar-mode -1)
;;(setq menu-bar-mode nil)
(setq tool-bar-mode nil)
;;(setq scroll-bar-mode nil)
;; the toolbar is just a waste of valuable screen estate
;; in a tty tool-bar-mode does not properly auto-load, and is
;; already disabled anyway
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Disable on the fly reindentation
(electric-indent-mode -1)

;; When something is selected, replace content when you type
(pending-delete-mode t)

;; ------------------------------------------------------------------
;; Better buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

;; Make files with the same name have unique buffer names
(setq uniquify-buffer-name-style 'forward)

;; ------------------------------------------------------------------
;; frames
;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
	  '((:eval (if (buffer-file-name)
				   (abbreviate-file-name (buffer-file-name))
				 "%b"))))

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;; Don't stop on hyphen in foo-bar
;;qqq(global-superword-mode)

;; Enable disabled commands (narrow-to-region, erase-buffer, etc)
(setq disabled-command-function nil)

;; ------------------------------------------------------------------
;; highlight matching parenthesis
(show-paren-mode t)
(setq show-paren-delay 0.0)

;; highlight selection
(transient-mark-mode t)

;; Immediatly display pending commands
(setq echo-keystrokes 0.01)

;; No blinking cursor
(blink-cursor-mode -1)

;; No bell thanks
(setq ring-bell-function #'ignore)
(setq visible-bell nil)

(setq font-lock-maximum-decoration t)
(setq color-theme-is-global t)
(setq truncate-partial-width-windows nil)

;; Max 100 chars (instead of 80)
(setq fill-column 300)

;; Show line/column numbers
(line-number-mode 1)
(column-number-mode 1)
(size-indication-mode t)

;; ------------------------------------------------------------------
;; update the mode line to have line number and column number
(setq mode-line-position '("%p (%l," (:eval (format "%d)" (1+ (current-column))))))

(global-hl-line-mode +1)
(global-display-line-numbers-mode 1)

;;Remove the ugly shadows around the modeline.
(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)

(setq inhibit-startup-screen t)

;; ------------------------------------------------------------------
;; tabs
;;(setq tab-width 4)
;;(setq indent-tabs-mode nil)

;; Emacs modes typically provide a standard means to change the
;; indentation width -- eg. c-basic-offset: use that to adjust your
;; personal indentation width, while maintaining the style (and
;; meaning) of any files you load.
;;(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 4)            ;; but maintain correct appearance

;; (setq-default tab-width 4
;;               indent-tabs-mode nil)

;; ------------------------------------------------------------------
;;(add-hook 'before-save-hook 'whitespace-cleanup)

;; ------------------------------------------------------------------
;; Don't pop up new frames on each call to open
(setq ns-pop-up-frames nil)

;; Non-nil means draw block cursor as wide as the glyph under it.
;; For example, if a block cursor is over a tab, it will be drawn as
;; wide as that tab on the display.
(setq x-stretch-cursor t)

(setq initial-scratch-message "")
(setq text-quoting-style 'grave)

;;** navigation within buffer
(setq next-screen-context-lines 5)
(setq recenter-positions '(top middle bottom))

;; Install a package via the elpaca macro
;; See the "recipes" section of the manual for more details.

;; (elpaca example-package)


;;When installing a package used in the init file itself,
;;e.g. a package which adds a use-package key word,
;;use the :wait recipe keyword to block until that package is installed/configured.
;;For example:
;;(use-package general :ensure (:wait t) :demand t)

;; Expands to: (elpaca evil (use-package evil :demand t))
;;(use-package evil :ensure t :demand t)

;;; do these first so keywords are recognized

;;   compat        >= 30.1
  ;; llama         >= 1.0.0
  ;; magit-section >= 4.3.8
  ;; seq           >= 2.24
  ;; transient     >= 0.9.3
  ;; with-editor   >= 3.4.4

;; dpk qqq configure stuff builtin to emacs

;; toggle hidden - dpk-4keys maps to M-o
(use-package dired-x
  :ensure nil
  :after dired
  :config
  (setq dired-omit-files
        (concat dired-omit-files "\\|^\\..+$")))

(add-hook 'dired-mode-hook #'dired-omit-mode)



(setq custom-safe-themes t)

;;; fix Timed out waiting for property-notify event
(setq select-active-regions nil)

;;; fix column width for list packages
;; (require 'cl-lib)
;; (defun godeater/set-tabulated-list-column-width (col-name width)
;;   "Set any column with the name COL-NAME to the given WIDTH."
;;   (cl-loop for column across tabulated-list-format
;;        when (string= col-name (car column))
;;        do (setf (elt column 1) width)))

;; (defun godeater/maybe-widen-package-menu-columns ()
;;   "Widen some columns of the package menu table to avoid truncation."
;;   (when (boundp 'tabulated-list-format)
;;     (godeater/set-tabulated-list-column-width "Version" 13 )
;;     (let ((longest-package-name (apply 'max (mapcar 'length (mapcar 'symbol-name (mapcar 'car package-archive-contents))))))
;;       (godeater/set-tabulated-list-column-width "Package" longest-package-name))))

;; (add-hook 'package-menu-mode-hook 'godeater/maybe-widen-package-menu-columns)

;;(global-visual-line-mode t)
;;(setq-default show-trailing-whitespace t)

;; (with-current-buffer "*clangd::stderr*"
;;    (emacs-lock-mode 'kill))
;; (with-current-buffer "*clangd*"
;;    (emacs-lock-mode 'kill))

;; *lsp-log*
;; *lsp-log: clangd:16101


;; (defun my-setup-indent (n)
;;   ;; java/c/c++
;;   (setq-local c-basic-offset n)
;;   ;; web development
;;   (setq-local coffee-tab-width n) ; coffeescript
;;   (setq-local javascript-indent-level n) ; javascript-mode
;;   (setq-local js-indent-level n) ; js-mode
;;   (setq-local js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
;;   (setq-local web-mode-markup-indent-offset n) ; web-mode, html tag in html file
;;   (setq-local web-mode-css-indent-offset n) ; web-mode, css in html file
;;   (setq-local web-mode-code-indent-offset n) ; web-mode, js code in html file
;;   (setq-local css-indent-offset n) ; css-mode
;;   )

;; (defun my-office-code-style ()
;;   (interactive)
;;   (message "Office code style!")
;;   ;; use tab instead of space
;;   (setq-local indent-tabs-mode t)
;;   ;; indent 4 spaces width
;;   (my-setup-indent 4))

;; (defun my-personal-code-style ()
;;   (interactive)
;;   (message "My personal code style!")
;;   ;; use space instead of tab
;;   (setq indent-tabs-mode nil)
;;   ;; indent 2 spaces width
;;   (my-setup-indent 2))

;; (defun my-setup-develop-environment ()
;;   (interactive)
;;   (let ((proj-dir (file-name-directory (buffer-file-name))))
;;     ;; if hobby project path contains string "hobby-proj1"
;;     (if (string-match-p "hobby-proj1" proj-dir)
;;         (my-personal-code-style))

;;     ;; if commericial project path contains string "commerical-proj"
;;     (if (string-match-p "commerical-proj" proj-dir)
;;         (my-office-code-style))))

;; ;; prog-mode-hook requires emacs24+
;; (add-hook 'prog-mode-hook 'my-setup-develop-environment)
;; ;; a few major-modes does NOT inherited from prog-mode
;; (add-hook 'lua-mode-hook 'my-setup-develop-environment)
;; (add-hook 'web-mode-hook 'my-setup-develop-environment)

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

;; messages

;; angular 
;; bash 
;; c cpp ccls clangd 
;; css 
;; dockerfile 
;; go gopls
;; html 
;; java lsp-java
;; javascript deno sourcegraph theia-ide flow
;; json 
;; perl pls perl::languageserver navigator
;; php 
;; python pylsp jedi pyright microsoft ruff
;; r 
;; rust rust-analyzer rls
;; xml 
;; yaml 

;lsp-java



;; rs

;; go

;; qqq packages unused
;; Highlight-Indentation.el
;; ace-window.el
;; actionscript-mode.el
;; adoc-mode.el

;; all-the-icons-dired.el
;; all-the-icons-ivy.el
;; all-the-icons.el.el

;; anaconda-mode.el
;; android-mode.el
;; angular-mode.el
;; antlr-mode.el
;; apache-mode.el
;; asn1-mode.el
;; avy-flycheck.el
;; avy.el
;; bazel-mode.el
;; beacon.el
;; bison-mode.el
;; bnf-mode.el
;; c-eldoc.el
;; cc-mode.el
;; cider.el
;; cl-font-lock.el
;; cl-libify.el
;; clang-format.el
;; clojure-mode-extra-font-locking.el
;; clojure-mode.el
;; cmake-font-lock.el
;; cmake-mode.el
;; cmake.el
;; common-lisp-snippets.el

;; company-anaconda.el
;; company-box.el
;; company-c-headers.el
;; company-ctags.el
;; company-fuzzy.el
;; company-go.el
;; company-jedi.el
;; company-lsp.el
;; company-lua.el
;; company-mode.el
;; company-nginx.el
;; company-php.el
;; company-prescient.el
;; company-qml.el
;; company-quickhelp.el

;; counsel-dash.el
;; counsel-etags.el
;; counsel-projectile.el
;; counsel.el

;; cpanfile-mode.el
;; cpp-capf.el
;; crontab-mode.el
;; csharp-mode.el
;; csproj-mode.el
;; csv-mode.el
;; cycle-themes.el.el
;; d-mode.el
;; dap-mode.el
;; dart-mode.el
;; dash-docs.el
;; dash.el.el
;; deadgrep.el
;; delight.el
;; demangle-mode.el
;; desktop.el
;; diminish.el.el
;; dired-single.el
;; dired.el
;; disaster.el
;; docker-compose-mode.el
;; doom-modeline.el
;; dotenv-mode.el
;; dtrt-indent.el
;; dts-mode.el
;; dylan-mode.el
;; ecb.el
;; eglot.el

;; eldoc-box.el
;; eldoc-cmake.el
;; eldoc-overlay.el

;; elf-mode.el
;; elisp-refs.el
;; elixir-mode.el
;; elm-mode.el
;; elpy.el
;; emacs-anzu.el
;; emacs-async.el
;; emacs-clang-format-plus.el
;; emacs-counsel-gtags.el
;; emacs-counsel-tramp.el
;; emacs-display-theme.el
;; emacs-htmlize.el
;; emacs-memoize.el
;; emacs-qtcreator-theme.el
;; emacs-which-key.el
;; emacsmirror-mirror.el
;; epl.el
;; ess.el
;; eww.el
;; eyebrowse.el
;; fill-column-indicator.el

;; flycheck-checkbashisms.el
;; flycheck-checkpatch.el
;; flycheck-clang-analyzer.el
;; flycheck-clang-tidy.el
;; flycheck-clojure.el
;; flycheck-google-cpplint.el
;; flycheck-posframe.el
;; flycheck-rust.el
;; flycheck-status-emoji.el
;; flycheck.el

;; flymake-diagnostic-at-point.el
;; flymake.el

;; general.el
;; ggtags.el
;; git-gutter-fringe.el
;; git-modes.el
;; git-timemachine.el
;; gitconfig-mode.el
;; gnu-elpa-mirror.el
;; go-eldoc.el
;; go-mode.el
;; goto-line-preview.el
;; groovy-mode.el
;; gxref.el
;; haskell-mode.el
;; helpful.el
;; hercules.el
;; hide-lines.el
;; hydra-posframe.el
;; hydra.el
;; ido-at-point.el
;; ido.el
;; imenu-list.el
;; info-colors.el
;; info-rename-buffer.el
;; ini-mode.el

;; ivy-explorer.el
;; ivy-hydra.el
;; ivy-posframe.el
;; ivy-prescient.el
;; ivy-rich.el
;; ivy-xref.el
;; ivy-yasnippet.el
;; ivy.el

;; jedi.el
;; js.el
;; julia-mode.el
;; kconfig-mode.el
;; kotlin-mode.el
;; let-alist.el
;; lisp-extra-font-lock.el
;; lispy.el
;; llvm-mode.el
;; loop.el.el

;; lsp-ada.el
;; lsp-angular.el
;; lsp-bash.el
;; lsp-clojure.el
;; lsp-cmake.el
;; lsp-cpp.el
;; lsp-crystal.el
;; lsp-csharp.el
;; lsp-css.el
;; lsp-d.el
;; lsp-dart.el
;; lsp-dhall.el
;; lsp-dockerfile.el
;; lsp-dylan.el
;; lsp-elixir.el
;; lsp-elm.el
;; lsp-erlang.el
;; lsp-flow.el
;; lsp-fortran.el
;; lsp-go.el
;; lsp-groovy.el
;; lsp-hack.el
;; lsp-haskell.el
;; lsp-html.el
;; lsp-ivy.el
;; lsp-java-treemacs.el
;; lsp-java.el
;; lsp-javascript.el
;; lsp-json.el
;; lsp-julia.el
;; lsp-kotlin.el
;; lsp-lua.el
;; lsp-m4.el
;; lsp-nim.el
;; lsp-ocaml.el
;; lsp-perl.el
;; lsp-php.el
;; lsp-pyls.el
;; lsp-qsharp.el
;; lsp-r.el
;; lsp-racket.el
;; lsp-ruby.el
;; lsp-rust.el
;; lsp-solargraph.el
;; lsp-sourcekit.el
;; lsp-tcl.el
;; lsp-tex.el
;; lsp-treemacs.el
;; lsp-typescript.el
;; lsp-ui.el
;; lsp-vim.el
;; lsp-xml.el
;; lsp-yaml.el

;; lua-mode.el
;; magithub.el
;; major-mode-hydra.el
;; melpa.el
;; minions.el
;; mode-icons.el
;; modern-cpp-font-lock.el
;; moody.el
;; msvc.el
;; multiple-cursors.el.el
;; nasm-lsp.el
;; nasm-mode.el
;; nginx-mode.el
;; ninja-mode.el
;; org.el
;; paren-face.el
;; pdf-tools.el

;; persp-mode.el
;; persp-projectile.el

;; perspective-el.el
;; perspective.el

;; pfuture.el
;; php-mode.el
;; pipenv.el
;; pkg-info.el
;; pos-tip.el
;; posframe.el
;; powerline.el
;; prescient.el.el
;; project.el

;; projectile-speedbar.el
;; projectile.el

;; pydoc.el
;; pyenv-mode.el
;; python-mode.el
;; python.el
;; pyvenv.el
;; qml-mode.el
;; qt-pro-mode.el
;; rainbow-blocks.el
;; redshank.el
;; rfc-mode.el
;; rmsbolt.el
;; robe.el
;; rpm-spec-mode.el
;; ruby-mode.el
;; rustic.el
;; saveplace.el
;; scala-mode.el
;; sed-mode.el
;; select-themes.el

;; slime-company.el
;; slime-repl-ansi-color.el
;; slime.el

;; sly-asdf.el
;; sly-hello-world.el
;; sly-macrostep.el
;; sly-named-readtables.el
;; sly-repl-ansi-colors.el
;; sly.el

;; smart-mode-line.el
;; spaceline-all-the-icons.el
;; spaceline.el
;; sr-speedbar.el
;; ssh-config-mode.el
;; straight.el.el
;; swift-helpful.el
;; swift-mode.el
;; swiper.el
;; syslog-mode.el
;; systemd.el
;; systemtap-mode.el
;; tcl.el
;; telephone-line.el

;; treemacs-icons-dired.el
;; treemacs-magit.el
;; treemacs-projectile.el
;; treemacs.el

;; tuareg.el
;; use-package-hydra.el
;; use-package.el
;; use-ttf.el
;; vlf.el
;; which-func.el
;; which-key-posframe.el
;; which-key.el
;; whitespace.el
;; x86-lookup.el
;; yaml-mode.el
;; yasnippet-snippets.el
;; yasnippet.el
;; zoutline.el

;; treesitter
;; ns-auto-titlebar
;; anzu
;; diredfl
;; uniquify
;; ibuffer
;; minibuffer
;; orderless
;; vertico
;; window
;; recentf
;; desktop
;; savehist
;; saveplace
;; sudo-edit

;; qqq fonts

;; ------------------------------------------------------------------
;; qqq fonts

;; face font 
;; default-frame-alist

;; (add-to-list 'default-frame-alist '(font . "IBM Plex Mono-10" ))

;; (set-face-attribute 'default nil :font "Hasklig-10" ) internal only ?
;; (set-frame-font "Hasklig-10" nil t) t means all frames
;; (setq default-frame-alist '((width . 100) (height . 60)))

;; font-name font-info font-lock-face font-get font-spec
;; available-fonts font-size font-setting

;; buffer-face-mode face-remap.el 
;; (setq buffer-face-mode-face '(:family "IBM Plex" :height 140 :width semi-condensed))

;; ~/.emacs.d/early-init.el
;; ~/.config/emacs/early-init.el

;; We do not recommend that you move into ‘early-init.el’ customizations
;; that can be left in the normal init files.  That is because the early
;; init file is read before the GUI is initialized, so customizations
;; related to GUI features will not work reliably in ‘early-init.el’.  By
;; contrast, the normal init files are read after the GUI is initialized.
;; If you must have customizations in the early init file that rely on GUI
;; features, make them run off hooks provided by the Emacs startup, such as
;; ‘window-setup-hook’ or ‘tty-setup-hook’.  *Note Hooks::.

;; Some Emacs packages, which connect to other services, require
;; authentication (*note Passwords::), e.g., see *note Gnus: (gnus)Top, or
;; *note Tramp: (tramp)Top.  Because it might be annoying to provide the
;; same user name and password again and again, Emacs offers to keep this
;; information persistent via the ‘auth-source’ library.

;;    By default, the authentication information is taken from the file
;; ‘~/.authinfo’ or ‘~/.authinfo.gpg’ or ‘~/.netrc’.  These files have a
;; syntax similar to netrc files as known from the ‘ftp’ program, like
;; this:

;;      machine MYMACHINE login MYLOGINNAME password MYPASSWORD port MYPORT

;;    Similarly, the ‘auth-source’ library supports multiple storage
;; backend, currently either the classic netrc backend, JSON files, the
;; Secret Service API, and pass, the standard unix password manager.

;;    All these alternatives can be customized via the user option
;; ‘auth-sources’, see *note Emacs auth-source: (auth)Help for users.

;;    When a password is entered interactively, which is not found via the
;; configured backend, some of the backends offer to save it persistently.
;; This can be changed by customizing the user option
;; ‘auth-source-save-behavior’.


;; ~/.emacs.el
;; ~/.emacs
;; ~/.emacs.d/init.el
;; ~/.config/emacs/init.el XDG-compatible XDG_CONFIG_HOME
;; user-emacs-directory

;; default.el - loaded after init, in lib path
;; site-start.el loaded before init, in lib path

;; load-path
;; /usr/local/share/emacs/site-lisp

;; /Library/Application Support/Emacs/29.1/site-lisp"
;; /Library/Application Support/Emacs/site-lisp"

;; /Applications/Emacs.app/Contents/Resources/lisp"
;; /Applications/Emacs.app/Contents/Resources/lisp/vc"
;; /Applications/Emacs.app/Contents/Resources/lisp/use-package"
;; /Applications/Emacs.app/Contents/Resources/lisp/url"
;; /Applications/Emacs.app/Contents/Resources/lisp/textmodes"
;; /Applications/Emacs.app/Contents/Resources/lisp/progmodes"
;; /Applications/Emacs.app/Contents/Resources/lisp/play"
;; /Applications/Emacs.app/Contents/Resources/lisp/org"
;; /Applications/Emacs.app/Contents/Resources/lisp/nxml"
;; /Applications/Emacs.app/Contents/Resources/lisp/net"
;; /Applications/Emacs.app/Contents/Resources/lisp/mh-e"
;; /Applications/Emacs.app/Contents/Resources/lisp/mail"
;; /Applications/Emacs.app/Contents/Resources/lisp/leim"
;; /Applications/Emacs.app/Contents/Resources/lisp/language"
;; /Applications/Emacs.app/Contents/Resources/lisp/international"
;; /Applications/Emacs.app/Contents/Resources/lisp/image"
;; /Applications/Emacs.app/Contents/Resources/lisp/gnus"
;; /Applications/Emacs.app/Contents/Resources/lisp/eshell"
;; /Applications/Emacs.app/Contents/Resources/lisp/erc"
;; /Applications/Emacs.app/Contents/Resources/lisp/emulation"
;; /Applications/Emacs.app/Contents/Resources/lisp/emacs-lisp"
;; /Applications/Emacs.app/Contents/Resources/lisp/cedet"
;; /Applications/Emacs.app/Contents/Resources/lisp/calendar"
;; /Applications/Emacs.app/Contents/Resources/lisp/calc"
;; /Applications/Emacs.app/Contents/Resources/lisp/obsolete"

;; /Users/dkrishfield/.emacs.d/dpk")

;;term/lk201.el
;;term-file-aliases
;; xterm vt100


;; tramp
;;(customize-set-variable 'tramp-verbose 6 "Enable remote command traces")
;;(with-eval-after-load 'tramp (tramp-change-syntax 'simplified))




;; lsp

;; frame size
(add-to-list 'default-frame-alist '(width . 120))
(add-to-list 'default-frame-alist '(height . 68))


