(setq prelude-theme 'gruvbox)

;; (setq prelude-theme nil)

(setq frame-resize-pixelwise t)


(setq ispell-dictionary "en")

(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)


'(company-global-modes '(not gud-mode))


;; Load path
(setenv "PATH" (concat (getenv "PATH") ":/home/mohamed/.local/bin/"))
(setq exec-path (append exec-path '("/home/mohamed/.local/bin/")))


(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))


;; Piss off Vi users

(defconst wq "This is not vi!  Use C-x C-c instead.")
(defconst w "This is not vi!  Use C-x C-s instead.")
(defconst q! "This is EMACS not vi!  Use C-x C-c instead.")
(defconst wq! "This is EMACS not vi!  Use C-x C-c instead.")

(scroll-bar-mode 0)

(setenv "WORKON_HOME" "/home/mohamed/vEnvs")
(setenv "PROJECT_HOME" "/home/mohamed/Projects")

;; (switch-to-buffer (get-buffer-create "*Welcome*"))
;; (erase-buffer)
;; (sit-for 0)
;; (animate-string "Welcome to Emacs, master Mohamed..."
;; 		(/ (window-height) 2) (- (/ (window-width) 2) 12))
;; (sit-for (* 5 (/ (abs (random)) (float most-positive-fixnum))))

;; term mode set unicode.
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.
With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(global-set-key (kbd "C-x C-r") 'sudo-edit)