;; -*- lexical-binding: nil; -*- 

;; ------------------------------------------------------------------

;;(add-to-list 'default-frame-alist '(font . "IBM Plex Mono-10" ))
;; (set-face-attribute 'default nil :font "Hasklig-10" )
;; (set-frame-font "Hasklig-10" nil t)

;; for new frames
;;(add-to-list 'default-frame-alist '(font . "IBM Plex Mono Text"))
;(setq default-frame-alist '((width . 100) (height . 60)))
;(setq default-frame-alist '((width . 100) (height . 60)))

;; immediate and future
;(set-face-attribute 'default nil :font "IBM Plex Mono Text" :height 100)
;(set-face-attribute 'default nil :font "IBM Plex Mono Text" :height 100)

;; immediate and future
;; (set-frame-font "IBM Plex Mono Text" nil t)
;; font name (a string),
;; a font object,
;; font entity, or
;; font spec.


;;; list monospace fonts
;; (require 'subr-x)
;; (seq-filter (lambda (font)
;;               (when-let ((info (font-info font)))
;;                 (string-match-p "-mono-" (aref info 0))))
;;             (font-family-list))

;; (seq-filter (lambda (font)
;;               (when-let ((info (font-info font)))
;;                 (string-match-p "spacing=100" (aref info 1))))
;;             (font-family-list))

(defun compare-monospace-font-families ()
  "Display a list of all monospace font faces. Tested on GNU/Linux."
  (interactive)
  (pop-to-buffer "*Monospace Fonts*")
  (erase-buffer)
  (dolist (font-name (seq-filter (lambda (font)
								   (when-let* ((info (font-info font)))
									 (string-match-p "spacing=100" (aref info 1))))
								 (font-family-list)))
	(insert
	 (propertize
	  (concat "1 l; 0 O o [ < = > ] " font-name ")\n")
	  'font-lock-face `((:family
						 ,(format "%s" (font-get (font-spec :name font-name) :family))))))))

(defun change-font ()
  "Documentation."
  (interactive)
  (let* (available-fonts font-name font-size font-setting)
	(dolist (font font-list (setq available-fonts (nreverse available-fonts)))
	  (when (member (car font) (font-family-list))
		(push font available-fonts)))
	(if (not available-fonts)
		(message "No fonts from the chosen set are available")
	  (if (called-interactively-p 'interactive)
		  (let* ((chosen (assoc-string (completing-read "What font to use? " available-fonts nil t) available-fonts)))
			(setq font-name (car chosen) font-size (read-number "Font size: " (cdr chosen))))
		(setq font-name (caar available-fonts) font-size (cdar available-fonts)))
	  (setq font-setting (format "%s-%d" font-name font-size))
	  (set-frame-font font-setting nil t)
	  (add-to-list 'default-frame-alist (cons 'font font-setting)))))


;; Menlo

;(set-frame-font "Menlo 8" nil t)
;(set-frame-font "Menlo 10" nil t)
; dpi (set-frame-font "Menlo 12" nil t)
;;(set-frame-font "Menlo 14" nil t)

;; IBM Plex Mono

;; early-init

;; ;; Set default and backup fonts
;; (push '(font . "Source Code Pro") default-frame-alist)
;; (push '(font . "Hasklug Nerd Font") default-frame-alist)
;; (set-face-font 'default "Source Code Pro")
;; (set-face-font 'default "Hasklug Nerd Font")
;; (set-face-font 'variable-pitch "DejaVu Sans")
;; (set-face-font 'variable-pitch "JetBrainsMono Nerd Font")
;; (copy-face 'default 'fixed-pitch)


;; JetBrains Mono
;; Menlo

;; ;; Ignore X resources.
;; (advice-add #'x-apply-session-resources :override #'ignore)

;; ;; set default and backup fonts
;; (copy-face 'default 'fixed-pitch)


;;   (set-face-attribute 'variable-pitch nil :family "Crimson" :height 140)
;;   ;; (set-face-attribute 'default nil :family "JuliaMono" :height 120)
;;   ;; (set-face-attribute 'fixed-pitch nil :family "JuliaMono" :height 120)
;;   (set-face-attribute 'default nil :family "Fira Code" :height 120)
;;   (set-face-attribute 'fixed-pitch nil :family "Fira Code" :height 120)

;; ;; Text editing
;; (set-face-attribute 'fixed-pitch nil
;;                     :font "Inconsolata")

;; (set-face-attribute 'fixed-pitch-serif nil
;;                     :font "League Mono")

;; (set-face-attribute 'default nil
;;                     :height 100
;;                     :family "Inconsolata LGC")


;; ;; Text editing
;; (set-face-attribute 'fixed-pitch nil
;;                     :font "Inconsolata")

;; (set-face-attribute 'fixed-pitch-serif nil
;;                     :font "League Mono")

;; (set-face-attribute 'default nil
;;                     :height 100
;;                     :family "Inconsolata")



;; fc-list
;; (x-list-fonts "*")
;; "-IBM -IBM Plex Mono-bold-italic-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-extralight-italic-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-extralight-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-light-italic-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-light-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-semibold-italic-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-semibold-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-thin-italic-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-IBM -IBM Plex Mono-thin-normal-normal-*-*-*-*-*-m-0-iso10646-1"

;; (x-family-fonts)
;; [IBM\ Plex\ Mono normal 0 bold italic t "-IBM -IBM Plex Mono-bold-italic-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 bold normal t "-IBM -IBM Plex Mono-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 extra-light italic t "-IBM -IBM Plex Mono-extralight-italic-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 extra-light normal t "-IBM -IBM Plex Mono-extralight-normal-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 light italic t "-IBM -IBM Plex Mono-light-italic-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 light normal t "-IBM -IBM Plex Mono-light-normal-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 normal italic t "-IBM -IBM Plex Mono-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 normal italic t "-IBM -IBM Plex Mono-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 normal italic t "-IBM -IBM Plex Mono-normal-italic-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 normal normal t "-IBM -IBM Plex Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 normal normal t "-IBM -IBM Plex Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 normal normal t "-IBM -IBM Plex Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 semi-bold italic t "-IBM -IBM Plex Mono-semibold-italic-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 semi-bold normal t "-IBM -IBM Plex Mono-semibold-normal-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 thin italic t "-IBM -IBM Plex Mono-thin-italic-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]
;; [IBM\ Plex\ Mono normal 0 thin normal t "-IBM -IBM Plex Mono-thin-normal-normal-*-*-*-*-*-m-0-iso10646-1" iso10646-1]

  ;; -rw-rw-r--  1 david david  69K Nov 20 15:23 IBMPlexMono-BoldItalic.otf
  ;; -rw-rw-r--  1 david david  64K Nov 20 15:23 IBMPlexMono-Bold.otf
  ;; -rw-rw-r--  1 david david  67K Nov 20 15:23 IBMPlexMono-ExtraLightItalic.otf
  ;; -rw-rw-r--  1 david david  62K Nov 20 15:23 IBMPlexMono-ExtraLight.otf
  ;; -rw-rw-r--  1 david david  67K Nov 20 15:23 IBMPlexMono-Italic.otf
  ;; -rw-rw-r--  1 david david  68K Nov 20 15:23 IBMPlexMono-LightItalic.otf
  ;; -rw-rw-r--  1 david david  62K Nov 20 15:23 IBMPlexMono-Light.otf
  ;; -rw-rw-r--  1 david david  69K Nov 20 15:23 IBMPlexMono-MediumItalic.otf
  ;; -rw-rw-r--  1 david david  63K Nov 20 15:23 IBMPlexMono-Medium.otf
  ;; -rw-rw-r--  1 david david  61K Nov 20 15:23 IBMPlexMono-Regular.otf
  ;; -rw-rw-r--  1 david david  69K Nov 20 15:23 IBMPlexMono-SemiBoldItalic.otf
  ;; -rw-rw-r--  1 david david  63K Nov 20 15:23 IBMPlexMono-SemiBold.otf
  ;; -rw-rw-r--  1 david david  71K Nov 20 15:23 IBMPlexMono-TextItalic.otf
  ;; -rw-rw-r--  1 david david  63K Nov 20 15:23 IBMPlexMono-Text.otf
  ;; -rw-rw-r--  1 david david  65K Nov 20 15:23 IBMPlexMono-ThinItalic.otf
  ;; -rw-rw-r--  1 david david  60K Nov 20 15:23 IBMPlexMono-Thin.otf

;; ftcrhb:-IBM -IBM Plex Mono-normal-normal-normal-*-20-*-*-*-m-0-iso10646-1 (#x21)
;; IBM Plex Mono-normal
;; IBM Plex Mono Text IBM Plex Mono Medium


;;(add-to-list 'default-frame-alist '(font . "IBM Plex Mono-10" ))
;; (set-face-attribute 'default nil :font "Hasklig-10" )
;; (set-frame-font "Hasklig-10" nil t)

;; (add-to-list 'default-frame-alist '(font . "-misc-tamsyn-medium-r-normal--14-101-100-100-c-70-iso8859-1"))
;; (add-to-list 'default-frame-alist '(font . "-misc-tamsyn-medium-r-normal--15-108-100-100-c-80-iso8859-1"))
;; (add-to-list 'default-frame-alist '(font . "IBM Plex Mono Text:size=12"))
;; ./wuliuxiansheng/lisp/init-fonts.el 19:  (set-frame-font "-*-Monaco-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
;; ./wuliuxiansheng/lisp/init-fonts.el 26:  (set-frame-font "-unkonwn-Ubuntu Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")
;; ./wuliuxiansheng/lisp/init-fonts.el 32:  (set-frame-font "-outline-Courier New-normal-normal-normal-mono-14-*-*-*-c-*-iso8859-1")
;; ./LefterisJP/lk/load-settings.el 66:  ;;     (set-frame-font "-adobe-Source Code Pro-normal-normal-normal-*-10-*-*-*-m-0-iso10646-1")
;; ./LefterisJP/lk/load-settings.el 68:  ;;   (set-frame-font "-adobe-Source Code Pro-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")))
;; ./LefterisJP/lk/load-settings.el 71:      (set-frame-font "-PfEd-DejaVu Sans Mono-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1")
;; ./LefterisJP/lk/load-settings.el 73:    (set-frame-font "-PfEd-DejaVu Sans Mono-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1")))
	;; (set-face-attribute
	;;  'default nil
	;;  :font (font-spec :name "-PfEd-Fantasque Sans Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
	;;        :weight 'normal
	;;        :slant 'italic
	;;        :size 16.0))


;; for new frames
;;(add-to-list 'default-frame-alist '(font . "IBM Plex Mono Text"))
;(setq default-frame-alist '((width . 100) (height . 60)))
;(setq default-frame-alist '((width . 100) (height . 60)))

;; immediate and future
;(set-face-attribute 'default nil :font "IBM Plex Mono Text" :height 100)
;(set-face-attribute 'default nil :font "IBM Plex Mono Text" :height 100)

;; immediate and future
;; (set-frame-font "IBM Plex Mono Text" nil t)
;; font name (a string),
;; a font object,
;; font entity, or
;; font spec.

;; Use variable width font faces in current buffer
;; (defun my-buffer-face-mode-variable ()
;;   "Set font to a variable width (proportional) fonts in current buffer"
;;   (interactive)
;; ;;  (setq buffer-face-mode-face '(:family "Noto Sans" :height 120 :width semi-condensed))
;;   (setq buffer-face-mode-face '(:family "IBM Plex" :height 180 :width semi-condensed))
;;   (buffer-face-mode))

;; (add-hook 'Info-mode-hook 'my-buffer-face-mode-variable)

;;(require 'info-colors)
;;(add-hook 'Info-mode-hook 'info-colors-fontify-node)
;;(add-hook 'Info-selection-hook 'info-colors-fontify-node)


;;; list monospace fonts
;; (require 'subr-x)
;; (seq-filter (lambda (font)
;;               (when-let ((info (font-info font)))
;;                 (string-match-p "-mono-" (aref info 0))))
;;             (font-family-list))

;; (seq-filter (lambda (font)
;;               (when-let ((info (font-info font)))
;;                 (string-match-p "spacing=100" (aref info 1))))
;;             (font-family-list))

;; See the following for more details
;;     https://emacs.stackexchange.com/a/50215/8887
;; and also see the following on a recent GNU/Linux or similar system:
;;     /usr/share/doc/fontconfig/fontconfig-user.html
;; for the explanation of spacing=100
;; also see the following UNIX StackExchange answer:
;;    https://unix.stackexchange.com/a/363368/13105

;; for windows
;; ;; see also:
;; ;;   https://gist.github.com/emres/917ffc60f4fe209a6a1bad6b3abd4fa1
;; (defun font-is-mono-p (font-name)
;;   (string-match "-mono-" font-name))

;; (defun compare-monospace-fonts ()
;;   "Display a list of all monospace font faces. Tested on MS Windows 10."
;;   (interactive)
;;   (pop-to-buffer "*Monospace Fonts*")
;;   (erase-buffer)
;;   (dolist (font-name (x-list-fonts "*"))
;;     (if (and (font-is-mono-p font-name)
;;              (ignore-errors (font-spec :name font-name)))
;;         (progn
;;           (newline)
;;           (insert
;;            (propertize (concat "1 l; 0 O o [ < = > ] " font-name ")\n")
;;                        'font-lock-face `((:family ,(format "%s" (font-get (font-spec :name font-name) :family)))
;; (:font (font-spec :name font-name)))))))))



;; Input Mono, Monaco Style, Line Height 1.3 download from http://input.fontbureau.com/
;; (defvar font-list '(("Input" . 11) ("SF Mono" . 12) ("Consolas" . 12) ("Love LetterTW" . 12.5))
;;   "List of fonts and sizes.  The first one available will be used.")
;;(defvar font-list '(("IBM Plex Mono" . 10))
;(defvar font-list '(("IBM Plex Mono Text" . 12))
;  "List of fonts and sizes.  The first one available will be used.")

;(defvar font-list '(("IBM Plex Mono" . 12))
;  "List of fonts and sizes.  The first one available will be used.")

;(defvar font-list '(("Menlo" . 16))
;  "List of fonts and sizes.  The first one available will be used.")

;; dpk
;; (when *sys/gui*
;;   (change-font))

(defun set-icon-fonts (CODE-FONT-ALIST)
   "Utility to associate many unicode points with specified fonts."
   (--each CODE-FONT-ALIST
	 (-let (((font . codes) it))
	   (--each codes
		 (set-fontset-font t `(,it . ,it) font)))))

 ;; (defun load-default-fonts ()
 ;;   ;;(setq doom-font (font-spec :family "Fantasque Sans Mono" :size 25))
 ;;   ;;(setq default-frame-alist '((font . "Iosevka-14")))

 ;;   ;; (set-fontset-font "fontset-default" 'unicode "Fantasque Sans Mono-22")
 ;;   ;; (set-face-font 'default "Fantasque Sans Mono-23")



 ;;   ;; The icons you see are not the correct icons until this is evaluated!
 ;;   (set-icon-fonts
 ;;    '(("fontawesome"
 ;;       ;;                         
 ;;       #xf07c #xf0c9 #xf0c4 #xf0cb #xf017 #xf101)

 ;;      ("all-the-icons"
 ;;       ;;    
 ;;       #xe907 #xe928)

 ;;      ("github-octicons"
 ;;       ;;                        
 ;;       #xf091 #xf059 #xf076 #xf075 #xf016 #xf00a)

 ;;      ("Symbola"
 ;;       ;; 𝕊    ⨂      ∅      ⟻    ⟼     ⊙      𝕋       𝔽
 ;;       #x1d54a #x2a02 #x2205 #x27fb #x27fc #x2299 #x1d54b #x1d53d
 ;;       ;; 𝔹    𝔇       𝔗
 ;;       #x1d539 #x1d507 #x1d517))))


 ;; (defun load-fonts (frame)
 ;;   (select-frame frame)
 ;;   (load-default-fonts))

 ;; (if (daemonp)
 ;;     (add-hook 'after-make-frame-functions #'load-fonts)
 ;;   (load-default-fonts))

;(set-frame-font "Menlo 18" nil t)



(defun lemacs/all-available-fonts ()
  "Create and visit a buffer containing a sorted list of available fonts."
  (interactive)
  (let ((font-list (sort (x-list-fonts "*") #'string<))
        (font-buffer (generate-new-buffer "*Font List*")))
    (with-current-buffer font-buffer
      (dolist (font font-list)
        (let* ((font-family (nth 2 (split-string font "-"))))
          (insert (format "%s\n" (propertize font 'face `(:family ,font-family :height 110))))))
      (goto-char (point-min))
      (setq buffer-read-only t))
    (pop-to-buffer font-buffer)))

;;(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font" :height 100)

(defun lemacs/all-fixed-fonts ()
  "List available monospaced font families."
  (interactive)
  (let ((buf (get-buffer-create "*Fixed Fonts*")))
    (with-current-buffer buf
      (erase-buffer)
      (dolist (family (sort (font-family-list) #'string<))
        (when-let* ((font (ignore-errors
                            (find-font (font-spec :family family))))
                    ((= (font-get font :spacing) 100)))
          (insert
           (propertize
            (concat family "\n")
            'face `(:family ,family :height 110)))))
      (goto-char (point-min))
      (special-mode))
    (pop-to-buffer buf)))

;; Andale Mono
;; Courier New
;; Menlo
;; Monaco
;; PT Mono


;; (defun lemacs/all-fixed-fonts ()
;;   "List only fixed-pitch fonts."
;;   (interactive)
;;   (let ((font-list (sort (x-list-fonts "*") #'string<))
;;         (font-buffer (generate-new-buffer "*Fixed Fonts*")))
;;     (with-current-buffer font-buffer
;;       (dolist (font font-list)
;;         (let* ((font-family (nth 2 (split-string font "-")))
;;                (info (ignore-errors (font-info font))))
;;           ;; spacing field: 'M' = monospace
;;           (when (and info
;;                      (eq (aref info 11) 'M))
;;             (insert
;;              (propertize
;;               (format "%s\n" font-family)
;;               'face `(:family ,font-family :height 110))))))
;;       (goto-char (point-min))
;;       (setq buffer-read-only t))
;;     (pop-to-buffer font-buffer)))

;(font-info "Verdana")
;(find-font (font-spec :family "Menlo"))

;(font-get
; (find-font (font-spec :family "Menlo"))
; :spacing)

;(font-get
; (find-font (font-spec :family "Verdana"))
; :spacing)


;; on mac os
;; Andale Mono
;; Courier New
;; Menlo
;; Monaco
;; PT Mono

;; nerd fonts

	;; 0xProto
	;; 3270
	;; AdwaitaMono
	;; Agave
	;; AnnotationMono
	;; AnonymousPro
	;; Arimo
	;; AtkinsonHyperlegibleMono
	;; AurulentSansMono
	;; BigBlueTerminal
	;; BitstreamVeraSansMono
	;; CascadiaCode
	;; CascadiaMono
	;; CodeNewRoman
	;; ComicShannsMono
	;; CommitMono
	;; Cousine
	;; D2Coding
	;; DaddyTimeMono
	;; DejaVuSansMono
	;; DepartureMono
	;; DroidSansMono
	;; EnvyCodeR
	;; FantasqueSansMono
	;; FiraCode
	;; FiraMono
	;; GeistMono
	;; Go-Mono
	;; Gohu
	;; GoogleSansCode
	;; Hack
	;; Hasklig
	;; HeavyData
	;; Hermit
	;; IBMPlexMono
	;; Inconsolata
	;; InconsolataGo
	;; InconsolataLGC
	;; IntelOneMono
	;; Iosevka
	;; IosevkaTerm
	;; IosevkaTermSlab
	;; JetBrainsMono
	;; Lekton
	;; LiberationMono
	;; Lilex
	;; MPlus
	;; MartianMono
	;; Meslo
	;; Monaspace
	;; Monofur
	;; Monoid
	;; Mononoki
	;; NerdFontsSymbolsOnly
	;; # Noto
	;; OpenDyslexic
	;; Overpass
	;; ProFont
	;; ProggyClean
	;; Recursive
	;; RobotoMono
	;; ShareTechMono
	;; SourceCodePro
	;; SpaceMono
	;; Terminus
	;; Tinos
	;; Ubuntu
	;; UbuntuMono
	;; UbuntuSans
	;; VictorMono
	;; ZedMono
	;; iA-Writer

	;; FiraCode
	;; FiraMono
	;; GoogleSansCode
	;; Hack
	;; Hasklig
	;; IBMPlexMono
	;; Inconsolata
	;; IntelOneMono
	;; Iosevka
	;; IosevkaTerm
	;; ProFont
	;; ProggyClean
	;; ShareTechMono
	;; SourceCodePro



;; ?
;; Crimson
;; Hasklug Nerd Font
;; JuliaMono
;; League Mono
;; tamsyn

;; JetBrainsMono Nerd Font
;; CaskaydiaCove Nerd Font (Cascadia Code)
;; MesloLGS Nerd Font
;; Hack Nerd Font
;; FiraCode Nerd Font
;; SauceCodePro Nerd Font
;; RobotoMono Nerd Font
