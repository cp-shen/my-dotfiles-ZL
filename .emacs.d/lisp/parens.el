;;; parens.el ---                                    -*- lexical-binding: t; -*-

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

(use-package smartparens
  :straight t
  :config (require 'smartparens-config)
  :init (add-hook 'after-init-hook #'smartparens-global-mode))

(use-package highlight-parentheses :straight t)

(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(provide 'parens)
;;; parens.el ends here
