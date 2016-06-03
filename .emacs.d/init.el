;; Get the package system setup
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
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

(use-package nyan-mode :ensure t)
(use-package zone-nyan :ensure t)
(use-package icicles :ensure t)


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

; Very important
(nyan-mode)

;; Tidy it up (especially for Gui version)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-set-key (kbd "C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-<down>") 'shrink-window)
(global-set-key (kbd "C-<up>") 'enlarge-window)

(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)
(define-key evil-normal-state-map (kbd "C-n") 'neotree-toggle)

;; https://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
;; I prefer using the "clipboard" selection (the one the
;; typically is used by c-c/c-v) before the primary selection
;; (that uses mouse-select/middle-button-click)
(setq x-select-enable-clipboard t)

(set-face-attribute 'default nil :height 100)

;; If emacs is run in a terminal, the clipboard- functions have no
;; effect. Instead, we use of xsel, see
;; http://www.vergenet.net/~conrad/software/xsel/ -- "a command-line
;; program for getting and setting the contents of the X selection"
(unless window-system
  (when (getenv "DISPLAY")
    ;; Callback for when user cuts
    (defun xsel-cut-function (text &optional push)
      ;; Insert text to temp-buffer, and "send" content to xsel stdin
      (with-temp-buffer
        (insert text)
        ;; I prefer using the "clipboard" selection (the one the
        ;; typically is used by c-c/c-v) before the primary selection
        ;; (that uses mouse-select/middle-button-click)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    ;; Call back for when user pastes
    (defun xsel-paste-function()
      ;; Find out what is current selection by xsel. If it is different
      ;; from the top of the kill-ring (car kill-ring), then return
      ;; it. Else, nil is returned, so whatever is in the top of the
      ;; kill-ring will be used.
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output)
          xsel-output )))
    ;; Attach callbacks to hooks
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)
    ;; Idea from
    ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
    ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
     ))


;; When neotree is opened, find the active file and
;; highlight it
(setq neo-smart-open t)

; It's not resizing but it's better than nothing
(setq neo-window-width 50)

;; Neotree should follow changes to the project root
(setq projectile-switch-project-action 'neotree-projectile-action)

;; I want to not use tags when in edts mode cos emacs tags are a bit pants by default
(add-hook 'edts-mode-hook
      (lambda ()
        (define-key evil-normal-state-map (kbd "C-]") 'edts-find-source-under-point)))

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

;; Some custom shit
;; This is all the functions I was used to using in vim
(defun erlang-tags ()
  (interactive)
  (shell-command-to-string "find ./ -name *.hrl -o -name *.erl | xargs etags"))

;; Jumps to the matching tag in this project
;; TODO: Find project root of current buffer
(defun tag (name)
  (interactive (list
                (characterp :name)))
  (find-tag name))

;; Jumps to the next matching tag
(defun tn ()
  (interactive)
  (next-match))

;; Does a search using 'ag' and puts the list into a (mini) buffer for jumping through
(defun ack (term)
  (interactive)

  )

  
