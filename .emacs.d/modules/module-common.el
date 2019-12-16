;;; module-common.el ---                             -*- lexical-binding: t; -*-

;; Copyright (C) 2019  scp

;; Author: scp <scp@scp-pc>
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

;;;;;;;;;;;;;;
;; packages ;;
;;;;;;;;;;;;;;

(require 'use-package)
(require 'module-commandcompletion)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; common appearance settins ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;
;; common misc settins ;;
;;;;;;;;;;;;;;;;;;;;;;;;;

(recentf-mode 1)
(global-hl-line-mode 1)

(setq initial-buffer-choice 'counsel-recentf)
(setq gdb-show-main t)
(setq gdb-many-windows t)

;;;;;;;;;;;
;; hooks ;;
;;;;;;;;;;;

(add-hook 'emacs-lisp-mode-hook (lambda () (display-line-numbers-mode 1)))
(add-hook 'c-mode-common-hook   (lambda () (display-line-numbers-mode 1)))
(add-hook 'rust-mode-hook       (lambda () (display-line-numbers-mode 1)))

(provide 'module-common)
;;; module-common.el ends here
