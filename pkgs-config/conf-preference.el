;;
;; preference
;;

;; set auto-dir-n-file
(let* ((pkg-data-dir (file-name-as-directory
                      (expand-file-name "auto-dir-n-file"
                                        user-emacs-directory))))
  (unless (file-exists-p pkg-data-dir)
    (make-directory pkg-data-dir))
  (setq auto-dir-n-file pkg-data-dir))

;; disable startup message
(setq inhibit-startup-message t)

;; disable menu-bar
(menu-bar-mode -1)

;; disable tool-bar
(tool-bar-mode -1)

;; battery
(display-battery-mode 1)

;; set default fill-column to 78
(setq-default fill-column 78)

;; make indentation command use space only
(setq-default indent-tabs-mode nil)

;; tab-width
(setq-default tab-width 4)

;; tab indent
(setq-default tab-always-indent 'complete)

;; display line number
(setq line-number-mode t)

;; display column number
(setq column-number-mode t)

;; display line number
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;; setup backup dir
(let* ((emacs-backup-dir (file-name-as-directory
                          (expand-file-name "backup" auto-dir-n-file))))
  (unless (file-exists-p emacs-backup-dir)
    (make-directory emacs-backup-dir))
  (setq backup-directory-alist `((".*" . ,emacs-backup-dir))
        backup-by-copying t ;; don't delink hardlinks
        version-control t ;; use version numbers on backups
        delete-old-versions t ;; automatically delete excess backups
        kept-new-versions 100 ;; how many of the newest version to keep
        kept-old-versions 3 ;; how many of the old
        )) ;; end of backup dir setup

;; auto-save dir
(let* ((emacs-auto-save-dir (file-name-as-directory
                             (expand-file-name "auto-save" auto-dir-n-file))))
  (unless (file-exists-p emacs-auto-save-dir)
    (make-directory emacs-auto-save-dir))
  (setq auto-save-file-name-transforms
        `((".*" ,emacs-auto-save-dir t)))
  (setq auto-save-list-file-prefix
        (expand-file-name "emacs-pid-" emacs-auto-save-dir)))

;; move `customize' interface config to .custom.el
(setq custom-file (expand-file-name ".custom.el" auto-dir-n-file))

;; move bookmarks to auto-save dir
(setq bookmark-default-file
      (expand-file-name "bookmarks" auto-dir-n-file))

;; yas-snippet
(eval-after-load 'yasnippet
  `(make-directory ,(file-name-as-directory (expand-file-name "snippets" auto-dir-n-file)) t))
(setq yas-snippet-dirs (list (file-name-as-directory (expand-file-name "snippets" auto-dir-n-file))))

(provide 'conf-preference)
