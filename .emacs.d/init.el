;; (setq socks-noproxy '("127.0.0.1"))
;; (setq socks-server '("Default server" "127.0.0.1" 7891 5))
;; (setq url-gateway-method 'socks)

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

(straight-use-package 'lsp-mode)
(straight-use-package 'company)
(straight-use-package 'company-lsp)
(straight-use-package 'rust-mode)
(straight-use-package 'lsp-ui)
(straight-use-package 'flycheck)
(straight-use-package 'lsp-treemacs)
(straight-use-package 'helm-lsp)
(straight-use-package 'dap-mode)
(straight-use-package 'helm)
(straight-use-package 'evil)
(straight-use-package 'rust-mode)
(straight-use-package 'atom-one-dark-theme)
(straight-use-package 'use-package)
(straight-use-package
  '(leetcode :type git :host github :repo "cp-shen/leetcode.el"))

(require 'leetcode)
(setq leetcode-prefer-language "cpp")
(setq leetcode-prefer-sql "mysql")

(require 'evil)
(evil-mode 1)

(load-theme 'atom-one-dark t)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(recentf-mode 1)
;; (global-display-line-numbers-mode 1)

(set-face-attribute 'default nil
                    :family "Fira Code"
                    :height 110
                    :weight 'normal
                    :width 'normal)

(defun fira-code-mode--make-alist (list)
  "Generate prettify-symbols alist from LIST."
  (let ((idx -1))
    (mapcar
     (lambda (s)
       (setq idx (1+ idx))
       (let* ((code (+ #Xe100 idx))
          (width (string-width s))
          (prefix ())
          (suffix '(?\s (Br . Br)))
          (n 1))
     (while (< n width)
       (setq prefix (append prefix '(?\s (Br . Bl))))
       (setq n (1+ n)))
     (cons s (append prefix suffix (list (decode-char 'ucs code))))))
     list)))

(defconst fira-code-mode--ligatures
  '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
    "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
    "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
    "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
    ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
    "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
    "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
    "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
    ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
    "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
    "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
    "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
    "x" ":" "+" "+" "*"))

(defvar fira-code-mode--old-prettify-alist)

(defun fira-code-mode--enable ()
  "Enable Fira Code ligatures in current buffer."
  (setq-local fira-code-mode--old-prettify-alist prettify-symbols-alist)
  (setq-local prettify-symbols-alist (append (fira-code-mode--make-alist fira-code-mode--ligatures) fira-code-mode--old-prettify-alist))
  (prettify-symbols-mode t))

(defun fira-code-mode--disable ()
  "Disable Fira Code ligatures in current buffer."
  (setq-local prettify-symbols-alist fira-code-mode--old-prettify-alist)
  (prettify-symbols-mode -1))

(define-minor-mode fira-code-mode
  "Fira Code ligatures minor mode"
  :lighter " Fira Code"
  (setq-local prettify-symbols-unprettify-at-point 'right-edge)
  (if fira-code-mode
      (fira-code-mode--enable)
    (fira-code-mode--disable)))

(define-globalized-minor-mode fira-code-global-mode fira-code-mode
  (lambda () (fira-code-mode 1)))

(defun fira-code-mode--setup ()
  "Setup Fira Code Symbols"
  (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol"))

(provide 'fira-code-mode)

(fira-code-global-mode 1)

;; (defvar lsp-language-id-configuration
;;   '(...
;;    (rust-mode . "rust")
;;    ...))
;; if you are adding the support for your language server in separate repo use
;; (add-to-list 'lsp-language-id-configuration '(python-mode . "python"))

;; (lsp-register-client
;;  (make-lsp-client :new-connection (lsp-stdio-connection "rls")
;;                   :major-modes '(rust-mode)
;;                   :server-id 'rls))

(require 'lsp-mode)
(add-hook 'rust-mode-hook #'lsp)

(setq lsp-enable-snippet nil)
(setq lsp-eldoc-render-all t)
(setq lsp-rust-show-hover-context t)

;; (add-hook 'after-init-hook #'global-flycheck-mode)

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
(add-hook 'lsp-mode-hook 'flycheck-mode)

(setq lsp-prefer-flymake nil)
