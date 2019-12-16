;;; module-keys.el ---                                      -*- lexical-binding: t; -*-

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

(global-set-key (kbd "C-l") nil)
(global-set-key (kbd "C-s") nil)
(global-set-key (kbd "C-k") nil)

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))
(global-set-key (kbd "C-k <C-tab>") #'switch-to-last-buffer)

(global-set-key (kbd "C-k C-/") #'comment-line)
(define-key key-translation-map (kbd "<C-return>") (kbd "RET"))

(require 'module-commandcompletion)
(global-set-key (kbd "C-k C-x") #'counsel-M-x)
(global-set-key (kbd "C-k C-f") #'counsel-find-file)
(global-set-key (kbd "C-k C-h") #'counsel-recentf)
(global-set-key (kbd "C-k C-b") #'ivy-switch-buffer)
(global-set-key (kbd "C-k C-s") #'swiper-isearch)

(require 'module-codecompletion)
(define-key company-active-map (kbd "C-n") #'company-select-next)
(define-key company-active-map (kbd "C-p") #'company-select-previous)
(define-key company-search-map (kbd "C-n") #'company-select-next)
(define-key company-search-map (kbd "C-p") #'company-select-previous)

(require 'module-lsp)
(define-key lsp-mode-map (kbd "C-l C-b") #'lsp-find-definition)
(define-key lsp-mode-map (kbd "C-l C-u") #'lsp-find-references)
(define-key lsp-mode-map (kbd "C-l C-f") #'lsp-format-buffer)
(define-key lsp-mode-map (kbd "C-l C-r") #'lsp-rename)

(provide 'module-keys)
;;; module-keys.el ends here
