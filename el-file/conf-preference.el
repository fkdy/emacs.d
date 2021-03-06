;;
;; preference
;;

;; handy function
(defun mel/mkdir (dir-name)
  "Check if dir-name exists, if not, make a new dir called `dir-name'"
  (unless (file-exists-p dir-name)
    (make-directory (file-name-as-directory dir-name))))

(defun mel/expand-emacs-d (dir-name)
  "Expand dir name relative to `user-emacs-directory'"
  (file-name-as-directory
   (expand-file-name (convert-standard-filename dir-name)
                     user-emacs-directory)))

;; set mel/auto-dir-n-file
(defvar mel/auto-dir-n-file
  (mel/expand-emacs-d "auto-dir-n-file")
  "The directory where packages place their configuration files")

(mel/mkdir mel/auto-dir-n-file)

(defun mel/expand-auto-dir (dir-name)
  "Expand dir name relative to `mel/auto-dir-n-file'"
  (file-name-as-directory
   (expand-file-name (convert-standard-filename dir-name)
                     mel/auto-dir-n-file)))

(defun mel/expand-auto-file (file-name)
  "Expand file name relative to `mel/auto-dir-n-file'"
  (expand-file-name (convert-standard-filename file-name)
                    mel/auto-dir-n-file))

;; disable startup message
(setq inhibit-startup-message t)

;; disable menu-bar
(if (functionp 'menu-bar-mode) (menu-bar-mode -1))

;; disable tool-bar
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))

;; battery
(ignore-errors (display-battery-mode 1))

;; set default fill-column to 75
(setq-default fill-column 75)

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
(let* ((emacs-backup-dir (mel/expand-auto-dir "backup")))
  (mel/mkdir emacs-backup-dir)
  (setq backup-directory-alist `((".*" . ,emacs-backup-dir))
        ;; don't delink hardlinks
        backup-by-copying t
        ;; use version numbers on backups
        version-control t
        ;; automatically delete excess backups
        delete-old-versions t
        ;; how many of the newest version to keep
        kept-new-versions 100
        ;; how many of the old
        kept-old-versions 3
        )) ;; end of backup dir setup

;; auto-save dir
(let* ((emacs-auto-save-dir (mel/expand-auto-dir "auto-save")))
  (mel/mkdir emacs-auto-save-dir)
  (setq auto-save-file-name-transforms
        `((".*" ,emacs-auto-save-dir t)))
  (setq auto-save-list-file-prefix
        (expand-file-name "emacs-pid-" emacs-auto-save-dir)))

;; move `customize' interface config to .custom.el
(setq custom-file (mel/expand-auto-file ".custom.el"))

;; move bookmarks to auto-save dir
(setq bookmark-default-file (mel/expand-auto-file "bookmarks"))

;; move org-id-locations file to auto-file
(setq org-id-locations-file (mel/expand-auto-file "org-id-locations"))

;; yas-snippet
(eval-after-load 'yasnippet
  `(make-directory ,(mel/expand-auto-dir "snippets") t))
(setq yas-snippet-dirs (list (mel/expand-auto-dir "snippets")))

(provide 'conf-preference)
