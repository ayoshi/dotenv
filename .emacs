;(add-to-list 'load-path "~/.emacs.d/evil-surround/")
    ;(require 'surround):
    ;(global-surround-mode 1)

(require 'package)
(add-to-list 'package-archives
                          '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-refresh-contents)
(package-initialize)

(defvar my-packages '(evil evil-leader evil-numbers solarized-theme)
		      "A list of packages to ensure are installed at launch." )

(dolist (p my-packages)
    (when (not (package-installed-p p))
          (package-install p)))

(require 'evil)
(evil-mode 1)

;(load "elscreen" "ElScreen"
;(define-key evil-normal-state-map (kbd "C-w t") 'elscreen-create) ;create tab
;(define-key evil-normal-state-map (kbd "C-w x") 'elscreen-kill) ;kill 
;(define-key evil-normal-state-map "gT" 'elscreen-previous) ;previous tab
;(define-key evil-normal-state-map "gt" 'elscreen-next) ;next tab

(menu-bar-mode t)
(tool-bar-mode nil)
(scroll-bar-mode nil)
(setq-default mode-line-format nil)

;Toggle line numbers
(global-linum-mode t)

;(left-fringe . 0); no fringe
;(right-fringe . 0)
;(border-width . 0)

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)
