;;; init.el ---                                      -*- lexical-binding: t; -*-

;; Copyright (C) 2019  cp_shen

;; Author: cp_shen <cp_shen@cpshen-Lenovo-ideapad-700-15ISK>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; socks5 proxy settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq socks-noproxy '("127.0.0.1"))
;; (setq socks-server '("Default server" "127.0.0.1" 7891 5))
;; (setq url-gateway-method 'socks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; install straight.el and use-package ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'gnutls
  (add-to-list 'gnutls-trustfiles "/etc/libressl/cert.pem"))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(require 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add modules to load-path ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/modules")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; import packages and configure them ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
  :straight t
  :init (add-hook 'after-init-hook 'global-company-mode))

(use-package treemacs
  :straight t
  :config ())

(use-package treemacs-evil
  :after (treemacs evil)
  :straight t
  :config ())

(use-package treemacs-magit
  :after (treemacs)
  :straight t
  :config ())

(use-package treemacs-icons-dired
  :after (treemacs dired)
  :straight t
  :config (treemacs-icons-dired-mode 1))

(use-package lsp-treemacs
  :straight t
  :after (lsp-mode treemacs))

(use-package rust-mode :straight t)

(use-package company-lsp
  :straight t
  :after (lsp-mode company))

(use-package dap-mode :straight t)

(use-package magit :straight t)

(use-package flycheck
  :straight t
  :init (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package leetcode
  :straight (leetcode :type git
		      :host github
		      :repo "kaiwk/leetcode.el"
		      :fork (:host github :repo "cp-shen/leetcode.el"))
  :config (progn (setq leetcode-prefer-language "cpp")
		 (setq leetcode-prefer-sql "mysql")))

(use-package evil
  :straight t
  :config (progn (setq evil-want-C-u-scroll t)
		 (evil-mode t))
  :init (progn (setq evil-want-C-u-scroll t)))

(use-package lsp-mode
  :straight t
  :init (add-hook 'rust-mode-hook #'lsp)
  :config (progn (setq lsp-enable-snippet nil)
		 (setq lsp-eldoc-render-all t)
		 (setq lsp-rust-show-hover-context t)
		 (setq lsp-prefer-flymake nil)))

(use-package lsp-ui
  :straight t
  :init (progn (add-hook 'lsp-mode-hook #'lsp-ui-mode)
	       (add-hook 'lsp-mode-hook #'flycheck-mode)))

(use-package vimish-fold :straight t)

(use-package evil-vimish-fold
  :straight t
  :after (vimish-fold evil)
  :config (evil-vimish-fold-mode 1))

(use-package ivy
  :straight t
  :config (progn (ivy-mode 1)
		 (setq ivy-count-format "(%d/%d) ")
		 (setq ivy-use-virtual-buffers t)
		 (setq enable-recursive-minibuffers t)))

(use-package counsel :straight t)
(use-package swiper :straight t)

;;;;;;;;;;;;;;;;;;;;;;;;
;; load local modules ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(mapc (lambda (name)
        (require (intern (file-name-sans-extension name))))
      (directory-files "~/.emacs.d/modules" nil "\\.el$"))


;; (add-hook 'emacs-lisp-mode-hook (lambda () (flycheck-mode -1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'c-mode-common-hook   (lambda () (display-line-numbers-mode 1)))
(add-hook 'rust-mode-hook       (lambda () (display-line-numbers-mode 1)))

(provide 'init)
;;; init.el ends here
