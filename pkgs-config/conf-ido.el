;;
;; ido mode
;;

(require 'ido)

(use-package ido
  :ensure t
  :defer t
  :init
  (setq ido-save-directory-list-file (mel/expand-auto-file "ido.last"))
  (ido-mode t)
  :config
  ;; show any name that has the chars you typed
  (setq ido-enable-flex-matching t)
  ;; show any name that has the chars you typed
  (setq ido-enable-flex-matching t)
  ;; use current pane for newly opened file
  (setq ido-default-file-method 'selected-window)
  ;; use current pane for newly switched buffer
  (setq ido-default-buffer-method 'selected-window)
  ;; stop ido from suggesting when naming new file
  (define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil))

;; show choices vertically
; (if (version< emacs-version "25")
;     (progn
;       (make-local-variable 'ido-separator)
;       (setq ido-separator "\n"))
;   (progn
;     (make-local-variable 'ido-decorations)
;     (setf (nth 2 ido-decorations) "\n")))

(provide 'conf-ido)
