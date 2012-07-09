;(add-to-list 'load-path "~/.emacs.d/evil-surround/")
    ;(require 'surround)
    ;(global-surround-mode 1)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer
    (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)

(require 'evil)
(evil-mode 1)

(load "elscreen" "ElScreen" t)

(define-key evil-normal-state-map (kbd "C-w t") 'elscreen-create) ;create tab
(define-key evil-normal-state-map (kbd "C-w x") 'elscreen-kill) ;kill tab

(define-key evil-normal-state-map "gT" 'elscreen-previous) ;previous tab
(define-key evil-normal-state-map "gt" 'elscreen-next) ;next tab

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
