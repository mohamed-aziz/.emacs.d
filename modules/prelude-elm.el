;;; package -- summary
;;; Commentary:
;;; Code:

(require 'prelude-programming)
(prelude-require-package 'elm-mode)

(setq elm-format-on-save t)

(add-to-list 'company-backends 'company-elm)

(provide 'prelude-elm)
