;;; module-lsp.el ---                                -*- lexical-binding: t; -*-

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

(require 'use-package)
(require 'module-filetree)
(require 'module-syntaxcheck)

(use-package lsp-treemacs
  :straight t
  :after (lsp-mode treemacs))

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

(provide 'module-lsp)
;;; module-lsp.el ends here
