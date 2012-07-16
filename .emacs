;(add-to-list 'load-path "~/.emacs.d/evil-surround/")
    ;(require 'surround)
    ;(global-surround-mode 1)

(add-to-list 'package-archives
                          '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;(require 'evil)
;(evil-mode 1)

;(load "elscreen" "ElScreen" t)

;(define-key evil-normal-state-map (kbd "C-w t") 'elscreen-create) ;create tab
;(define-key evil-normal-state-map (kbd "C-w x") 'elscreen-kill) ;kill tab

;(define-key evil-normal-state-map "gT" 'elscreen-previous) ;previous tab
;(define-key evil-normal-state-map "gt" 'elscreen-next) ;next tab

;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default mode-line-format nil)

(left-fringe . 0); no fringe
(right-fringe . 0)
(border-width . 0)

(global-set-key (kbd "<escape>")      'keyboard-escape-quit)

