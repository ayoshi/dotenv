;; No splash screen please ... jeez
(setq inhibit-startup-message t)

(require 'package)
(add-to-list 'package-archives
                          '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-refresh-contents)
(package-initialize)

(defvar my-packages '(evil evil-leader evil-numbers solarized-theme
			   geiser magit paredit rainbow-delimiters slime slime-repl slime-fuzzy
			   anything anything-config anything-match-plugin
			   pretty-lambdada pretty-mode-plus)
		      "A list of packages to ensure are installed at launch." )

(dolist (p my-packages)
    (when (not (package-installed-p p))
          (package-install p)))

(require 'evil)
(evil-mode 1)

;(require 'surround)
;(global-surround-mode 1)

(load-theme 'solarized-dark t)

;(load "elscreen" "ElScreen"
;(define-key evil-normal-state-map (kbd "C-w t") 'elscreen-create) ;create tab
;(define-key evil-normal-state-map (kbd "C-w x") 'elscreen-kill) ;kill 
;(define-key evil-normal-state-map "gT" 'elscreen-previous) ;previous tab
;(define-key evil-normal-state-map "gt" 'elscreen-next) ;next tab

(menu-bar-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default mode-line-format t)

;Toggle line numbers
(global-linum-mode t)

;(left-fringe . 0); no fringe
;(right-fringe . 0)
;(border-width . 0)

;Disable useleess annoyng beeps on scroll
(setq ring-bell-function 'ignore)

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)

(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 150))

(setq geiser-racket-binary "/usr/local/bin/racket")

;; Mode line setup
(setq-default
 mode-line-format
 '(; Position, including warning for 80 columns
   (:propertize "%4l:" face mode-line-position-face)
   (:eval (propertize "%3c" 'face
                      (if (>= (current-column) 80)
                          'mode-line-80col-face
                        'mode-line-position-face)))
   ; emacsclient [default -- keep?]
   mode-line-client
   "  "
   ; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize " RO " 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize " ** " 'face 'mode-line-modified-face))
          (t "      ")))
   "    "
   ; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 30))
                face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)
   ; narrow [default -- keep?]
   " %n "
   ; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (vc-mode vc-mode)
   "  %["
   (:propertize mode-name
                face mode-line-mode-face)
   "%] "
   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process
                face mode-line-process-face)
   (global-mode-string global-mode-string)
   "    "
   ; nyan-mode uses nyan cat as an alternative to %p
   ;(:eval (when nyan-mode (list (nyan-create))))
   ))

;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line nil
    :foreground "gray60" 
    :inverse-video nil
    :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute 'mode-line-inactive nil
    :foreground "gray80" 
    :inverse-video nil
    :box '(:line-width 1 :color "gray10" :style nil))
(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line-face
  ;  :foreground "#4271ae"
    :box '(:line-width 2 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line-face
  ;  :foreground "#c82829"
  ;  :background "#ffffff"
    :box '(:line-width 2 :color "#c82829"))
(set-face-attribute 'mode-line-folder-face nil
    :inherit 'mode-line-face
    :foreground "gray60")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "#eab700"
    :weight 'bold)
(set-face-attribute 'mode-line-position-face nil
    :inherit 'mode-line-face
    :family "Menlo" :height 100)
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line-face
    :foreground "gray80")
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line-mode-face
    :foreground "gray40"
    :height 110)
(set-face-attribute 'mode-line-process-face nil
    :inherit 'mode-line-face
    :foreground "#718c00")
(set-face-attribute 'mode-line-80col-face nil
    :inherit 'mode-line-position-face
    :foreground "black" :background "#eab700")

;; Some stuff for moving lines around, and starting newline
(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)))

(global-set-key (kbd "<C-S-down>") 'move-line-down)
(global-set-key (kbd "<C-S-up>") 'move-line-up)

(defun open-line-below ()
  (interactive)
  (end-of-line)
  (newline)
  (indent-for-tab-command))

(defun open-line-above ()
  (interactive)
  (beginning-of-line)
  (newline)
  (forward-line -1)
  (indent-for-tab-command))

(global-set-key (kbd "<C-return>") 'open-line-below)
(global-set-key (kbd "<C-S-return>") 'open-line-above)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

; Globally enable rainbow delimeters
(global-rainbow-delimiters-mode)

; SLIME setup
;(setq inferior-lisp-program "/usr/local/bin/ccl64")
;(require 'slime-autoloads)
;(eval-after-load 'slime '(setq slime-protocol-version 'ignore))
;(slime-setup '(slime-repl))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(geiser-mode-company-p nil)
 '(geiser-mode-smart-tab-p t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

