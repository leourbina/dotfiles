;;; package -- Summary
;;; Leo's init.el
;;; Code:
;;; Commentary:


(require 'package)
(when (not (assoc "melpa" package-archives))
  (setq package-archives (append '(("stable" . "https://stable.melpa.org/packages/")) package-archives))
  (setq package-archives (append '(("melpa" . "https://melpa.org/packages/")) package-archives))
  (setq package-archives (append '(("gnu" . "https://elpa.gnu.org/packages/")) package-archives)))
(package-initialize)
(package-refresh-contents t)


;; Use-package configuration
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "/Users/leourbina/.emacs.d/lisp/")
  (add-to-list 'load-path "/Users/leourbina/.emacs.d/elpa/use-package-2.4/")
  (add-to-list 'load-path "/Users/leourbina/.emacs.d/elpa/bind-key-20191110.416/")
  (require 'use-package))

;; Install straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(when (not package-archive-contents) (package-refresh-contents))

(when (not (package-installed-p 'use-package))
  (package-install 'use-package))

(use-package use-package-ensure-system-package
  :ensure t)

(add-hook 'after-init-hook 'global-flycheck-mode)
(add-hook 'after-init-hook 'global-company-mode)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package use-package-hydra
  :ensure t)

(use-package editorconfig
  :ensure t)

(use-package ws-butler
  :ensure t
  :init (ws-butler-global-mode))

;;;;;;;;;;;;;;;;;;;;;
;;   Global shit   ;;
;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-screen t)
(put 'set-goal-column 'disabled nil)
(menu-bar-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode 1)
(setq use-dialog-box nil)
;; Show col #'s
(setq column-number-mode t)
(setq indent-tabs-mode nil)


;; Get rid of annoying autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)

(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
	(message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: ")))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(global-set-key (kbd "C-c r") 'rename-file-and-buffer)

;; Global keybinding
(global-set-key (kbd "S-<left>") 'windmove-left)
(global-set-key (kbd "S-<right>") 'windmove-right)
(global-set-key (kbd "S-<up>") 'windmove-up)
(global-set-key (kbd "S-<down>") 'windmove-down)
(global-set-key (kbd "<f1>") 'goto-line)
(global-set-key (kbd "<f2>") 'query-replace-regexp)
(global-set-key (kbd "<f3>") 'ag)
(global-set-key (kbd "C-x C-t") 'projectile-find-file)


;; Bell config
(setq visible-bell nil
      ring-bell-function 'flash-mode-line)
(defun flash-mode-line ()
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil #'invert-face 'mode-line))

;; Get vars from path
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; Put backups in homedir
(setq backup-directory-alist `(("~/.saves")))
(setq backup-by-copying t)


(use-package yasnippet
  :ensure t)

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))


(use-package solarized-theme
  :ensure t
  :init
  (load-theme 'solarized-dark-high-contrast t))

(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))

(use-package whitespace-cleanup-mode
  :ensure t
  :init
  (whitespace-cleanup-mode 1))

(use-package highlight-indent-guides
  :ensure t
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-responsive 'stack)
  (setq highlight-indent-guides-delay 0)

  (set-face-background 'highlight-indent-guides-odd-face "darkgray")
  (set-face-background 'highlight-indent-guides-even-face "dimgray")
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray")

  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))


(use-package company
  :ensure t)

(use-package flycheck
  :defer 2
  :diminish
  :init (global-flycheck-mode)
  :custom
  (flycheck-display-errors-delay .3)
  (flycheck-stylelintrc "~/.stylelintrc.json"))

(use-package flycheck-golangci-lint
  :ensure t)

(use-package paredit
  :ensure t)

(use-package ag
  :ensure t)

(use-package rainbow-mode
  :ensure t)

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (paredit-mode)
	    (rainbow-mode)))

(use-package dockerfile-mode
  :ensure t
  :mode "\\Dockerfile\\'")

(use-package magit
  :ensure t
  :pin melpa
  :bind ("C-x g" . magit))

(use-package git-gutter+
  :ensure t
  :init (global-git-gutter+-mode)
  :bind ("C-x r" . git-gutter+-revert-hunk))

(use-package git-timemachine
  :ensure t)

(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-treemacs
  :ensure t)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :config
  (add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "javascript"))

  (require 'lsp-ui-imenu)
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
  (add-hook 'lsp-after-open-hook (lambda () (yas-minor-mode) (setq indent-tabs-mode nil)))

  (setq lsp-prefer-flymake nil)
  (setq lsp-signature-auto-activate nil)

  :hook ((python-mode . lsp-deferred)
	 (go-mode . lsp-deferred)
	 (web-mode . lsp-deferred))

  :bind ("C-c C-i" . lsp-organize-imports))

(use-package lsp-pyright
  :after lsp-mode
  :custom
  (lsp-pyright-auto-import-completions nil)
  (lsp-pyright-typechecking-mode "off"))

;; go hydra
(use-package hydra
  :demand t
  :config
  (require 'hydra)
  (require 'dap-mode)
  (require 'dap-ui)
  ;;:commands (ace-flyspell-setup)
  :bind
  ;;("M-s" . hydra-go/body)
  :init
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'hydra-go/body)))
  :hydra (hydra-go (:color pink :hint nil :foreign-keys run)
		   "
   _n_: Next       _c_: Continue _g_: goroutines      _i_: break log
   _s_: Step in    _o_: Step out _k_: break condition _h_: break hit condition
   _Q_: Disconnect _q_: quit     _l_: locals
   "
		   ("n" dap-next)
		   ("c" dap-continue)
		   ("s" dap-step-in)
		   ("o" dap-step-out)
		   ("g" dap-ui-sessions)
		   ("l" dap-ui-locals)
		   ("e" dap-eval-thing-at-point)
		   ("h" dap-breakpoint-hit-condition)
		   ("k" dap-breakpoint-condition)
		   ("i" dap-breakpoint-log-message)
		   ("q" nil "quit" :color blue)
		   ("Q" dap-disconnect :color red)))

(use-package graphql-mode
  :ensure t
  :mode (("\\.gql\\'" . graphql-mode)
	 ("\\.graphqls\\'" . graphql-mode)))


(use-package dap-mode
  :ensure t
  :pin melpa
  :config
  (dap-mode 1)
  (dap-tooltip-mode 1)
  (require 'dap-go)
  (require 'dap-hydra)
  (dap-go-setup)

  (use-package dap-ui
    :ensure nil
    :config
    (dap-ui-mode 1)))

(add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra)))
(provide 'gopls-config)

(use-package go-guru
  :ensure t
  :hook (go-mode . go-guru-hl-identifier-mode))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-align-annotations t))

(use-package go-mode
  :ensure t
  :init
  (go-guru-hl-identifier-mode)
  :config
  (yas-minor-mode 1) ; for adding require/use/import statements
  (electric-pair-mode)
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
  (flymake-mode -1)
  :hook (before-save . gofmt-before-save))

(use-package gorepl-mode
  :ensure t)

(add-hook 'go-mode-hook 'yas/minor-mode-on)
(add-hook 'go-mode-hook #'gorepl-mode)

(use-package rainbow-delimiters
  :ensure t)

(defun my-clojure-mode-hook ()
  (cider-mode 1)
  (company-mode 1)
  (paredit-mode 1)
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  (rainbow-delimiters-mode 1)
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-r"))

(use-package clojure-mode
  :ensure t
  :hook
  (clojure-mode . my-clojure-mode-hook))

(use-package cider
  :ensure t)

(use-package clj-refactor
  :ensure t
  :config)

(cljr-add-keybindings-with-prefix "C-c C-r")

(use-package cljr-helm
  :ensure t
  :bind)

(use-package cider-hydra
  :ensure t)

(use-package counsel
  :ensure t
  :bind ("M-<f3>" . counsel-ag))

(use-package ivy
  :ensure t)

(use-package projectile :ensure t
  :init
  (setq projectile-svn-command "find . \\( -path '*/.svn*' -o -path '*/.git*' \\) -prune -o -type f -print0"
        projectile-generic-command "find . \\( -path '*/.svn*' -o -path '*/.git*' \\) -prune -o -type f -print0"
        projectile-git-command "find . \\( -path '*/.svn*' -o -path '*/.git*' \\) -prune -o -type f -print0"
        projectile-require-project-root nil
        projectile-enable-caching t
        projectile-completion-system 'ivy)
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode 1))

(use-package nlinum
  :ensure t)

(use-package multiple-cursors
  :ensure t
  :init
  (global-set-key (kbd "S-C-n") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-c S-C-n") 'mc/mark-all-like-this-dwim))

(use-package restclient
  :ensure t
  :mode ("\\.rest\\'" . restclient-mode))

(use-package typescript-mode
  :ensure t)

(use-package prettier-js
  :ensure t
  :hook ((web-mode . prettier-js-mode)
	 (web-mode . yas-minor-mode)))

(use-package web-mode
  :ensure t
  :config
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-content-types-alist '(("jsx" . "\\.[c]?js[x]?\\'")))
  (setq electric-pair-mode t)
  
  :mode (("\\.js\\'" . web-mode)
	 ("\\.cjs\\'" . web-mode)
	 ("\\.jsx\\'" . web-mode)
	 ("\\.html\\'" . web-mode)
	 ("\\.cts\\'" . web-mode)
	 ("\\.ts\\'" . web-mode)
	 ("\\.tsx\\'" . web-mode)
	 ("\\.vue\\'" . web-mode)))

(use-package json-mode
  :ensure t)

(use-package emojify
  :ensure t
  :config
  ;;(add-hook 'after-init-hook #'global-emojify-mode)
  )

(defun my-rust-mode-hook ()
  (yas-minor-mode)
  (setq tab-width 4
	indent-tabs-mode nil))

(use-package rustic
  :ensure t

  :hook
  (rustic-mode . my-rust-mode-hook)

  :init
  (setq rustic-lsp-server 'rls)
  (setq lsp-rust-analyzer-cargo-watch-command "rustic-clippy")
  (setq lsp-rust-analyzer-server-command '("~/.cargo/bin/rust-analyzer"))
  (setq rustic-format-on-save nil))

(use-package yaml-mode
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cider-prompt-for-symbol nil)
 '(clojure-indent-style 'always-indent)
 '(css-indent-offset 2)
 '(dashboard-center-content nil)
 '(electric-pair-mode t)
 '(electric-pair-pairs '((39 . 39) (34 . 34) (40 . 41)))
 '(emojify-emoji-set "emojione-v2.2.6-22")
 '(flycheck-python-pycompile-executable "python3")
 '(global-whitespace-cleanup-mode t)
 '(gofmt-command "goimports")
 '(js-indent-level 2)
 '(lsp-go-build-flags ["-tags=wireinject"])
 '(lsp-html-format-indent-handlebars t)
 '(lsp-html-format-indent-inner-html t)
 '(lsp-javascript-format-insert-space-after-opening-and-before-closing-jsx-expression-braces t)
 '(lsp-prefer-flymake nil t)
 '(lsp-pyls-plugins-flake8-enabled t)
 '(lsp-pyls-plugins-flake8-max-line-length 160)
 '(lsp-pyls-plugins-pycodestyle-enabled nil)
 '(lsp-pyls-plugins-pycodestyle-ignore '("E701"))
 '(lsp-pyls-plugins-pydocstyle-add-ignore '("E701"))
 '(lsp-pyright-auto-import-completions nil)
 '(lsp-pyright-typechecking-mode "off")
 '(lsp-pyright-venv-directory nil)
 '(lsp-pyright-venv-path "/Users/leourbina/.virtualenvs/")
 '(lsp-rust-analyzer-cargo-watch-command "rustic-clippy")
 '(lsp-rust-analyzer-macro-expansion-method 'rustic-analyzer-macro-expand)
 '(lsp-rust-server 'rls)
 '(lsp-signature-auto-activate nil)
 '(lsp-ui-flycheck-enable t)
 '(lsp-ui-sideline-ignore-duplicate t)
 '(nlinum-highlight-current-line t)
 '(nlinum-widen nil)
 '(package-selected-packages
   '(editorconfig lsp-ui lsp-pyright dired-sidebar gorepl-mode evil lsp-mode dap-ui use-package-hydra company-lsp-mode company-lsp flycheck-golangci-lint company-mode company graphql-mode rustic cargo rust-mode rainbow-delimiters emojify magit-mode json-mode nlinum lsp-treemacs dashboard whitespace-cleanup-mode clojure-lsp cider-hydra cljr-helm clj-refactor cider git-timemachine true dap-mode yaml-mode yaml lsp-python-ms cquery minimap sublimity autopair highlight-parentheses ag prettier-js web-mode restclient multiple-cursors git-gutter+ counsel smex dockerfile-mode projectile ivy go-guru yasnippet flycheck solarized-theme go-mode emacs-lisp f elisp-mode rainbow-mode paredit exec-path-from-shell use-package))
 '(python-indent-offset 2)
 '(rustic-display-spinner nil)
 '(rustic-lsp-format t)
 '(rustic-lsp-server 'rust-analyzer t)
 '(rustic-racer-rust-src-path "/usr/local/src/rust/src")
 '(web-mode-code-indent-offset 8)
 '(web-mode-css-indent-offset 2)
 '(web-mode-enable-auto-closing t)
 '(web-mode-enable-auto-expanding t)
 '(web-mode-enable-auto-quoting nil)
 '(web-mode-enable-html-entities-fontification t)
 '(web-mode-markup-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((t (:background "#163541")))))
