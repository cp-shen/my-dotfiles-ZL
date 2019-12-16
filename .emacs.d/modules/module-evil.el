;;; module-evil.el ---                               -*- lexical-binding: t; -*-

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

(use-package evil
  :straight t
  :config (progn (setq evil-want-C-u-scroll t)
		 (evil-mode t))
  :init (progn (setq evil-want-C-u-scroll t)))

(use-package vimish-fold :straight t)

(use-package evil-vimish-fold
  :straight t
  :after (vimish-fold evil)
  :config (evil-vimish-fold-mode 1))

(provide 'module-evil)
;;; module-evil.el ends here
