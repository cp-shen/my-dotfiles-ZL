;;; keys.el ---                                      -*- lexical-binding: t; -*-

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


(define-key company-active-map (kbd "C-j") #'company-select-next)
(define-key company-active-map (kbd "C-k") #'company-select-previous)
(define-key company-search-map (kbd "C-j") #'company-select-next)
(define-key company-search-map (kbd "C-k") #'company-select-previous)

(use-package helm
  :bind
  (:map helm-map
   ("C-j"   . helm-next-line)
   ("C-k"   . helm-previous-line)
   ("C-z"   . helm-select-action)
   ("TAB"   . helm-execute-persistent-action)
   ("<tab>" . helm-execute-persistent-action)
))

(use-package helm-files
  :bind
  (:map helm-find-files-map
   ("C-h" . helm-find-files-up-one-level)
   ("C-l" . helm-execute-persistent-action)
))

(use-package evil
  :after (helm)
  :bind
  (:map evil-motion-state-map
   ("SPC" . nil)
   ("SPC SPC" . helm-M-x)
   ("SPC C-f" . helm-find-files)
   ("SPC C-b" . helm-buffers-list)
   ("SPC C-h" . helm-recentf)
))

(provide 'keys)
;;; keys.el ends here
