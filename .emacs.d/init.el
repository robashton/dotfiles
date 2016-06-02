
;; Get the package system setup
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-refresh-contents)
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Complete Anything
(use-package company :ensure t)

;; Themes
(use-package railscasts-theme :ensure t)

;; Just why would you do anything else? :D
(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t)
  :config (evil-mode 1)
  )

;; Gimme some Erlang!
(use-package erlang :ensure t)
(use-package edts :ensure t)
(use-package lfe-mode :ensure t)
(use-package kerl :ensure t)


;; Other packages
(use-package flx-ido :ensure t)
(use-package projectile
  :ensure t
  :config
  (setq projectile-enable-caching t)
  (projectile-global-mode)
  )
(use-package neotree :ensure t)
(use-package editorconfig
  :ensure t
  :config (editorconfig-mode 1)
  )
(use-package ag :ensure t)

(use-package linum-relative
  :ensure t
  :config
  (setq linum-relative-format "%3s ")
  (linum-relative-global-mode)
  )



;; Configure identation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(defvaralias 'erlang-indent-level 'tab-width)
(defvaralias 'js-indent-level 'tab-width)



;; Get EDTS Started
(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  (require 'edts-start))



;; Random Stuff
(setq inhibit-startup-screen t)
(menu-bar-mode -1)


(global-set-key [f9] 'projectile-find-file)
(global-set-key (kbd "C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-<down>") 'shrink-window)
(global-set-key (kbd "C-<up>") 'enlarge-window)
(define-key evil-normal-state-map (kbd "C-n") 'neotree-toggle)

;; When neotree is opened, find the active file and
;; highlight it
(setq neo-smart-open t)

;; Neotree should follow changes to the project root
(setq projectile-switch-project-action 'neotree-projectile-action)

(add-hook 'neotree-mode-hook
          (lambda ()

            ;; Line numbers are pointless in neovim
            (linum-mode 0)

            ;; Neotree keybindings to override evil mode
            (define-key evil-normal-state-local-map (kbd "C-n") 'neotree-toggle)
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
