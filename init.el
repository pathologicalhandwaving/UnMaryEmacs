;;; init.el --- UnMary Emacs package                     -*- lexical-binding: t; -*-

;; Copyright (C) 2022 UnMary

;; Author: UnMary
;; Keywords: lisp
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; UnMary Emacs init.el

;;; Code:

;; custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Package Archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)


;; git
(use-package git)
(use-package git-commit)

;; el-get
(use-package el-get
  :init
  (require 'el-get)
  (add-to-list 'load-path "~/.emacs.d/el-get"))

;; server
(require 'server)
(if (not (server-running-p)) (server-start))

;; shell variables
(use-package exec-path-from-shell)
(require 'exec-path-from-shell)


;; Bars
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode +1)
(scroll-bar-mode -1)

(column-number-mode t)

;; scroll
(setq scroll-margin 0)
(setq scroll-conservatively 10000)
(setq scroll-preserve-screen-position t)

;; recents
(recentf-mode 1)
(defvar recentf-max-saved-items)
(setq recentf-max-saved-items 200)


;; User Information
(setq user-full-name "UnMary")
(setq user-mail-address "ourladyofunmary@gmail.com")


;; Theme
(use-package doom-themes
  :config (load-theme 'doom-outrun-electric t))


;; icons
(use-package all-the-icons
  :ensure t)

;; delimiters
(use-package rainbow-delimiters
:commands (rainbow-delimiters-mode)
:init
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Open dired in same buffer
(put 'dired-find-alternate-file 'disabled nil)

;; Sort directories first
(setq dired-listing-switches "-agho --group-directories-first")

;; Copy and move files between dired buffers
(setq dired-dwim-target t)

;; Only y/n answers 
(defalias 'yes-or-no-p 'y-or-n-p)

;; Deleted files to trash
(setq delete-by-moving-to-trash t)

;; Keep clean (create new directory if not exist)
(make-directory (expand-file-name "backups/" user-emacs-directory) t)
(setq backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

;; save buffer position
(if (version< emacs-version "25.0")
    (progn (require 'saveplace)
        (setq-default save-place t))
(save-place-mode 1))



;; Helm 
  (use-package helm
    :config
    (require 'helm-config)
    :init
    (helm-mode 1)
    :bind
    (("M-x"     . helm-M-x) ;; Evaluate functions
     ("C-x C-f" . helm-find-files) ;; Open or create files
     ("C-x b"   . helm-mini) ;; Select buffers
     ("C-x C-r" . helm-recentf) ;; Select recently saved files
     ("C-c i"   . helm-imenu) ;; Select document heading
     ("M-y"     . helm-show-kill-ring) ;; Show the kill ring
     :map helm-map
     ("C-z" . helm-select-action)
     ("<tab>" . helm-execute-persistent-action)))


;; Auto complete
(use-package company
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 3
        company-selection-wrap-around t))
(global-company-mode)

;; which-key
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle 0.5
	which-key-idle-dely 50)
  (which-key-setup-minibuffer))

;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)

;; Overwrite selected text
(delete-selection-mode t)

;; Scroll to the first and last line of the buffer
(setq scroll-error-top-bottom t)

;; Org-Mode
(use-package org
  :bind
  (("C-c l" . org-store-link)
   ("C-c c" . org-capture)))

;; Startup
(setq org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300))

;; Show hidden emphasis markers
(use-package org-appear
  :hook (org-mode . org-appear-mode))

;; Bullets
(use-package org-superstar
    :config
    (setq org-superstar-special-todo-items t)
    (add-hook 'org-mode-hook (lambda ()
                               (org-superstar-mode 1))))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 0)
(use-package htmlize)

;; Line spacing
(setq-default line-spacing 6)

;; LaTeX


;; LaTeX fragment previews
(plist-put org-format-latex-options :scale 2)

;; BibTeX






(message "Init Loaded!")
(provide 'init)
;;; init.el ends here
