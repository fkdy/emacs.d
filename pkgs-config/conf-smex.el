;;
;; config smex
;;

(require-package 'smex)

(use-package smex
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'smex))

(provide 'conf-smex)
