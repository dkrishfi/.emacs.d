;; -*- lexical-binding: nil; -*- 

;; ------------------------------------------------------------------
;; dpk-sysinfo

;; determine: 

;; gui vs terminal 
;; *sys/gui*

;; os 
;; *sys/win32* 
;; *sys/linux* 
;; *sys/mac*

;; user 
;; *sys/root*

;; system-name

;; tools 
;; *rg* 
;; *python* 
;; *python3* 
;; *tr* 
;; *mvn* 
;; *cland* 
;; *gcc* 
;; *git* 
;; *pdflatex*

;; emacs version
;; (setq *emacs24* (>= emacs-major-version 24))
;; (setq *emacs25* (>= emacs-major-version 25))
;; (setq *emacs26* (>= emacs-major-version 26))


;; Consts
(defconst *sys/gui*
  (display-graphic-p)
  "Are we running on a GUI Emacs?")

(defconst *sys/win32*
  (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")

(defconst *sys/linux*
  (eq system-type 'gnu/linux)
  "Are we running on a GNU/Linux system?")

(defconst *sys/mac*
  (eq system-type 'darwin)
  "Are we running on a Mac system?")

(defconst *sys/root*
  (string-equal "root" (getenv "USER"))
  "Are you a ROOT user?")

(defconst *rg*
  (executable-find "rg")
  "Do we have ripgrep?")

(defconst *python*
  (executable-find "python")
  "Do we have python?")

(defconst *python3*
  (executable-find "python3")
  "Do we have python3?")

(defconst *tr*
  (executable-find "tr")
  "Do we have tr?")

(defconst *mvn*
  (executable-find "mvn")
  "Do we have Maven?")

(defconst *clangd*
  (or (executable-find "clangd")  ;; usually
	  (executable-find "/usr/local/opt/llvm/bin/clangd"))  ;; macOS
  "Do we have clangd?")

(defconst *gcc*
  (executable-find "gcc")
  "Do we have gcc?")

(defconst *git*
  (executable-find "git")
  "Do we have git?")

(defconst *pdflatex*
  (executable-find "pdflatex")
  "Do we have pdflatex?")

;; qqq sysinfo

;; (when (>= emacs-major-version 24)
;; )

;; ;;; * System identification
;; ;; Name went from all caps in <= 24.4 to upper/lower case in 24.5.
;; ;; In 24.5 the variable is superseded by a function.  Change later.
;; (defun system-is-mac ()
;;   (interactive)
;;   "Return true if system is darwin-based (Mac OS X)"
;;   (string-equal system-type "darwin"))

;; (defun system-is-windows ()
;;   (interactive)
;;   "Return true if system is windows-based"
;;   (string-equal system-type "windows-nt"))

;; (defun system-is-XPS ()
;; (interactive)
;; "Return true if the system we are running on Fran's Dell XPS 13"
;; (string-equal system-name "FRAN-XPS"))

;; (defun system-is-MBP15 ()
;; (interactive)
;; "Return true if the system we are running on MacBook Pro 15"
;; (string-equal system-name "MacBook-15-NJH.local"))

;; (defun system-is-MBP13R ()
;; (interactive)
;; "Return true if the system we are running on MacBook Pro 13 Retina"
;; ; Not sure why name varies.
;; (or (string-equal system-name "MacBook-13R-NJH.local")
;;     (string-equal system-name "MacBook13-2013") ;; High Sierra update
;;     (string-equal system-name "macbook13-2013") ;; Emacs 24.5.1
;;     (string-equal system-name "MacBook13-2013.local")
;;     (string-equal system-name "Fran-MBP13.local")
;;     (string-equal system-name "Fran-MBP13")
;;     (string-equal system-name "macbook-13r-njh") ))

;; (defun system-is-Dell ()
;; (interactive)
;; "Return true if the system we are running on Dell Xeon"
;; (string-equal system-name "Dell-Nick"))

;; (defun system-is-Chill ()
;; (interactive)
;; "Return true if the system we are running on Chillblast"
;; ;; (string-equal system-name "DESKTOP-II9K04F")) ; OC VII.
;; ;; (string-equal system-name "Nick-Chill")) ; Fusion tranquility.
;; (string-equal system-name "Chillblast-Nick")) ; OC VII.

;; (defun system-is-iMac ()
;; (interactive)
;; "Return true if the system we are running on iMac"
;; (string-equal system-name "Nick-iMac.local"))

