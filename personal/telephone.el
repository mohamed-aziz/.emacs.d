(require 'use-package)

(use-package telephone-line
  :config
  ;; To create custom segments
  (use-package telephone-line-utils)

  (setq telephone-line-height 20)

   (setq telephone-line-primary-left-separator 'telephone-line-flat)
   (setq telephone-line-primary-right-separator 'telephone-line-flat)

  ;; Set subseparator
  ;;(if window-system
  ;;    (progn
  ;;      (setq telephone-line-secondary-left-separator 'telephone-line-identity-hollow-left)
  ;;      (setq telephone-line-secondary-right-separator 'telephone-line-identity-hollow-right)))


  ;; Display major mode
  (telephone-line-defsegment* my-major-mode-segment ()
    (let ((mode (cond
                  ((string= mode-name "Fundamental") "text")
                  ((string= mode-name "Emacs-Lisp") "elisp")
                  ((string= mode-name "Javascript-IDE") "js")
                  (t (downcase mode-name)))))
      ;;   (icon (all-the-icons-icon-for-buffer)))
      ;; (concat
      ;;   (unless (symbolp icon) ;; This implies it's the major mode
      ;;     (format "%s "
      ;;             (propertize icon
      ;;                         'face `(:height 1.0 :family ,(all-the-icons-icon-family-for-buffer))
      ;;                         'display '(raise -0.1))))
      (propertize mode 'face `(:foreground "#9d81ba"))))
  ;; ;; Display name
  ;;   (propertize mode 'face `(:foreground "#9d81ba")))))

  ;; Display evil state
  (telephone-line-defsegment my-evil-segment ()
    (if (telephone-line-selected-window-active)
      (let ((tag (cond
                  ((string= evil-state "normal") "N")
                  ((string= evil-state "insert") "I")
                  ((string= evil-state "replace") "R")
                  ((string= evil-state "visual") "V")
                  ((string= evil-state "operator") "O")
                  ((string= evil-state "motion") "M")
                  ((string= evil-state "emacs") "E")
                  (t "-"))))
        (concat " " tag))))

  ;; Display buffer name
  (telephone-line-defsegment my-buffer-segment ()
    `(""
      ,(telephone-line-raw mode-line-buffer-identification t)))


  ;; Display current position in a buffer
  (telephone-line-defsegment* my-position-segment ()
    (if (telephone-line-selected-window-active)
        (if (eq major-mode 'paradox-menu-mode)
            (telephone-line-trim (format-mode-line mode-line-front-space))
          '(" %3l,%2c "))))

  ;; Ignore some buffers in modeline
  (defvar modeline-ignored-modes nil
    "List of major modes to ignore in modeline")

  (setq modeline-ignored-modes '("Dashboard"
                                 "Warnings"
                                 "Compilation"
                                 "EShell"
                                 "REPL"
                                 "Messages"))

  ;; Display modified status
  (telephone-line-defsegment my-modified-status-segment ()
    (when (and (buffer-modified-p) (not (member mode-name modeline-ignored-modes)))
        (propertize "+" 'face `(:foreground "#85b654"))))


  ;; Display encoding system
  (telephone-line-defsegment my-coding-segment ()
    (let* ((code (symbol-name buffer-file-coding-system))
           (eol-type (coding-system-eol-type buffer-file-coding-system))
           (eol (cond
                 ((eq 0 eol-type) "unix")
                 ((eq 1 eol-type) "dos")
                 ((eq 2 eol-type) "mac")
                 (t ""))))
      (concat eol " ")))

  ;; Display current branch
  ;; Status
  ;; (vc-state (buffer-file-name (current-buffer)))
  ;; (vc-state buffer-file-name)
  (telephone-line-defsegment my-vc-segment ()
    ;; #6fb593 #4a858c
    (let ((fg-color "#6fb593"))
      (telephone-line-raw
        (format "%s %s"
          (propertize (all-the-icons-octicon "git-branch")
                      'face `(:family ,(all-the-icons-octicon-family) :height 1.0 :foreground ,fg-color)
                      'display '(raise 0.0))
          (propertize
            (substring vc-mode (+ (if (eq (vc-backend buffer-file-name) 'Hg) 2 3) 2))
            'face `(:foreground ,fg-color)))
        t)))

  ;; Left edge
  (setq telephone-line-lhs
        '((evil   . (my-evil-segment))
          (nil    . (my-buffer-segment))
          (nil    . (my-modified-status-segment))))

  ;; Right edge
  (setq telephone-line-rhs
        '((nil     . ((my-vc-segment :active)))
          ;; TODO: (??) delete
          ;; (nil     . (telephone-line-misc-info-segment))
          (accent  . (my-position-segment))
          (nil     . (my-major-mode-segment))
          (accent  . ((my-coding-segment :active)))))

  (telephone-line-mode 1))
