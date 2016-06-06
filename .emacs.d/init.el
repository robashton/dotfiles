;; Get the package system setup
(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

;; textmate
;; ack-and-a-half9
;; isearch??
;; helm-swoop
;; magit
;; ace-window (navigation between windows = much better)
;; rainbow-delimeters
;; jsx-mode
;; smex <-- history

;; confirm-nonexistent...
;; textmate excludes..
;; delete-trailing-whitespaces
;; defalias yes-or-no-p

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)

;; Complete Anything
(use-package company :ensure t)

;; Themes
(use-package railscasts-theme :ensure t)

;; Just why would you do anything else? :D
(use-package evil
  :ensure t
  :init (setq evil-want-C-u-scroll t)
  :config (evil-mode 1))

;; Prettify
(use-package nyan-mode :ensure t)
(use-package zone-nyan :ensure t)
(use-package rainbow-delimiters :ensure t)

;; Git blame
;;(use-package magit :ensure t)

;; Gimme some Erlang!
(use-package erlang :ensure t)
(use-package edts :ensure t)
(use-package lfe-mode :ensure t)
(use-package kerl :ensure t)

;; And some jsx
(use-package jsx-mode :ensure t)

;; And some Elm
(use-package elm-mode :ensure t)

;; run elm inside container
(setq-default elm-compile-command "id3as elm-make")
(setq-default elm-create-package-command "id3as elm make --yes")
(setq-default elm-package-command "id3as elm-package")
(setq-default elm-oracle-command "id3as elm-oracle")
(setq-default elm-interactive-command "id3as elm-repl")
(setq-default elm-reactor-command "id3as -h elm-reactor")
(setq-default elm-format-command "id3as elm-format")
(setq-default elm-tags-on-save t)
(setq-default elm-tags-exclude-elm-stuff nil)

;; And use its tag search too
(add-hook 'elm-mode-hook
      (lambda ()
        (define-key evil-normal-state-map (kbd "C-]") 'elm-mode-goto-tag-at-point)))

;; Navigation
(use-package flx-ido :ensure t)
(use-package projectile
  :ensure t
  :config
  (setq projectile-enable-caching t)
  (projectile-global-mode))
(use-package neotree :ensure t)
(use-package ag :ensure t)
(use-package textmate :ensure t)
(use-package ack-and-a-half :ensure t)
(use-package ace-window :ensure t)
(use-package smex :ensure t)

;; Not sure what this is (Stears?)
(use-package editorconfig
  :ensure t
  :config (editorconfig-mode 1))

;; Relative line numbers...
(use-package linum-relative
  :ensure t
  :config
  (setq linum-relative-format "%3s ")
  (linum-relative-global-mode))

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
(nyan-start-animation)
(nyan-toggle-wavy-trail)

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

  
