(require 'exwm)
(require 'exwm-config)
(require 'volume)

(exwm-config-default)

(exwm-input-set-key (kbd "M-r") 'exwm-reset)

(exwm-input-set-key (kbd "S-<up>") 'windmove-up)
(exwm-input-set-key (kbd "S-<down>") 'windmove-down)
(exwm-input-set-key (kbd "S-<left>") 'windmove-left)
(exwm-input-set-key (kbd "S-<right>") 'windmove-right)

;; Emms stuff

;; requires mplayer
(require 'emms-setup)
(require 'emms-player-mplayer)
(emms-standard)
(emms-default-players)
(define-emms-simple-player mplayer '(file url)
  (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma" ".webm"
                ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
  "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")


(require 'emms-player-mpv)
(add-to-list 'emms-player-list 'emms-player-mpv)


(require 'exwm-systemtray)
(exwm-systemtray-enable)

;; change volume using volume.el
(exwm-input-set-key (kbd "<XF86AudioLowerVolume>") (lambda ()
                                                     (interactive)
                                                     (volume-lower)))

(exwm-input-set-key (kbd "<XF86AudioRaiseVolume>") (lambda ()
                                                     (interactive)
                                                     (volume-raise)))

;; change brightness using the xbacklight program
(defun xbacklight (percentage)
  (interactive)
  (progn
      (shell-command (concat "xbacklight " percentage))
      (message (concat "Brightness is: "
                       (replace-regexp-in-string "\n" "" (shell-command-to-string "xbacklight"))))))

(exwm-input-set-key (kbd "<XF86MonBrightnessUp>") (lambda ()
                                                     (interactive)
                                                     (xbacklight "+5")))

(exwm-input-set-key (kbd "<XF86MonBrightnessDown>") (lambda ()
                                                    (interactive)
                                                    (xbacklight "-5")))


(emms-play-file "~/moognu.mp4")


(shell-command "setxkbmap fr")

(shell-command "xset r rate 200 60")


(add-hook 'exwm-exit-hook (lambda ()
                            (shell-command "killall xfce4-session")))
