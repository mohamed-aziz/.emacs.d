;; (disable-theme 'zenburn)

(setq frame-resize-pixelwise t)

;; setting dictionary to english
(setq ispell-dictionary "en")

(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet")

(require 'yasnippet)
(yas-global-mode 1)


'(company-global-modes '(not gud-mode))


;; Load path
(setenv "PATH" (concat (getenv "PATH") ":/home/mo/.local/bin/"))
(setq exec-path (append exec-path '("/home/mo/.local/bin/")))


(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))


;; Piss off Vi users

(defconst wq "This is not vi!  Use C-x C-c instead.")
(defconst w "This is not vi!  Use C-x C-s instead.")
(defconst q! "This is EMACS not vi!  Use C-x C-c instead.")
(defconst wq! "This is EMACS not vi!  Use C-x C-c instead.")

(scroll-bar-mode 0)

(setenv "WORKON_HOME" "/home/mo/vEnvs")
(setenv "PROJECT_HOME" "/home/mo/Projects")

(switch-to-buffer (get-buffer-create "*Welcome*"))
(erase-buffer)
(sit-for 0)
(animate-string "Welcome to Emacs, master Mohamed..."
		(/ (window-height) 2) (- (/ (window-width) 2) 12))
(sit-for (* 5 (/ (abs (random)) (float most-positive-fixnum))))

;; term mode set unicode.
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

;; from bastov blog.
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

;; Windmove for org-mode.
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(add-hook 'python-mode-hook
          (lambda ()
            (push '("def" . ?ƒ) prettify-symbols-alist)))

(global-prettify-symbols-mode 1)

(pdf-tools-install)

(el-get-bundle vue-mode
               :url "https://github.com/mohamed-aziz/vue-mode.git")
(require 'vue-mode)


(define-key dired-mode-map "b" 'emms-play-dired)

(global-set-key (kbd "<f5>") 'neotree-toggle)

(darktooth-modeline)
