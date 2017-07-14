(require 'use-package)

(use-package linum
  :init

  (setq linum-format "%3d \u2502 ")
  ;; (define-global-minor-mode my-global-linum-mode linum-mode
  ;;   (lambda ()
  ;;     (when (not (memq major-mode
  ;;                      (list 'shell-mode
  ;;                            'org-mode
  ;;                            'term-mode
  ;;                            'image-mode
  ;;                            'dired-mode
  ;;                            'helm-mode
  ;;                            'help-mode
  ;;                            )))
  ;;       (linum-mode))))
  (require 'linum-off)

  (defconst linum-disabled-modes-list
        '(eshell-mode
          wl-summary-mode
          compilation-mode
          org-mode
          text-mode
          dired-mode
          term-mode
          shell-mode
          doc-view-mode
          image-mode
          helm-mode
          helm-migemo-mode
          helm-top-poll-mode
          epresent-mode
          minibuffer-inactive-mode
          helm-adaptive-mode))

  :config
  (global-linum-mode 1))
