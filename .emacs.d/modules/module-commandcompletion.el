;;; module-commandcompletion.el ---                  -*- lexical-binding: t; -*-

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

(use-package ivy
  :straight t
  :config (progn (ivy-mode 1)
		 (setq ivy-count-format "(%d/%d) ")
		 (setq ivy-use-virtual-buffers t)
		 (setq enable-recursive-minibuffers t)))

(use-package counsel :straight t)
(use-package swiper :straight t)

(provide 'module-commandcompletion)
;;; module-commandcompletion.el ends here
