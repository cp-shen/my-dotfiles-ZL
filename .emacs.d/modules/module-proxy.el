;;; module-proxy.el ---                              -*- lexical-binding: t; -*-

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; socks5 proxy settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun enable-socks5-proxy ()
  (interactive)
  (progn
    (setq socks-noproxy '("127.0.0.1"))
    (setq socks-server '("Default server" "127.0.0.1" 7891 5))
    (setq url-gateway-method 'socks)))

(provide 'module-proxy)
;;; module-proxy.el ends here
