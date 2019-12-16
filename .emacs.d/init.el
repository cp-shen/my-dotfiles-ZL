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

;;;;;;;;;;;;;;;;;;;;;;;;
;; load local modules ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(mapc (lambda (name)
        (require (intern (file-name-sans-extension name))))
      (directory-files "~/.emacs.d/modules" nil "\\.el$"))

(provide 'init)
;;; init.el ends here
