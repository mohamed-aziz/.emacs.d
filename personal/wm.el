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
;; (require 'emms-setup)
;; (require 'emms-player-mplayer)
(emms-standard)
(emms-default-players)
(define-emms-simple-player mplayer '(file url)
  (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
  "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")


(require 'exwm-systemtray)
(exwm-systemtray-enable)

;; duh I have to implement the volume change function for my arch;
;; using amixer maybe
(exwm-input-set-key (kbd "<XF86AudioLowerVolume>") (lambda ()
                                                     (interactive)
                                                     (volume-lower)))

(exwm-input-set-key (kbd "<XF86AudioRaiseVolume>") (lambda ()
                                                     (interactive)
                                                     (volume-raise)))
