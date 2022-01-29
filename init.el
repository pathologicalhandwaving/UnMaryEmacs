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

;; i3-wm
(use-package i3wm)


;; Bars
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode +1)
(scroll-bar-mode -1)

(column-number-mode t)
(global-display-line-numbers-mode)

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

(use-package all-the-icons-dired
  :ensure t
  :defer t
  :hook (dired-mode . all-the-icons-dired-mode))

;; dashboard
(use-package dashboard
  :init
  ;;(setq dashboard-set-heading-icons t)
  ;;(setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Welcome to UnMary Emacs!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.emacs.d/halfunmary.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (bookmarks . 3)
                          (registers . 3)))
  :config
  (dashboard-setup-startup-hook))
  ;;(dashboard-modify-heading-icons '((recents . "file-text")
  ;;				    (bookmarks . "book"))))

;; dashboard in daemon mode
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))



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
(use-package org-ref)
(use-package org-ref-prettify)
(with-eval-after-load 'org
  (add-hook 'org-mode-hook 'org-ref-prettify-mode))

(use-package bibtex)
(require 'bibtex)

(setq bibtex-autokey-year-length 4
	bibtex-autokey-name-year-separator "-"
	bibtex-autokey-year-title-separator "-"
	bibtex-autokey-titleword-separator "-"
	bibtex-autokey-titlewords 2
	bibtex-autokey-titlewords-stretch 1
	bibtex-autokey-titleword-length 5
	org-ref-bibtex-hydra-key-binding (kbd "H-b"))

(define-key bibtex-mode-map (kbd "H-b") 'org-ref-bibtex-hydra/body)

;(use-package org-ref-helm)
;;(use-package doi-utils)
;(use-package org-ref-isbn)
;(use-package org-ref-arxiv)
;(use-package org-ref-bibtex)
;(use-package nist-webbook)
;(use-package org-ref-scifinder)
;(use-package org-ref-pdf)
;(use-package org-ref-url-utils)

(setq bibtex-completion-bibliography '(".bib"
					 "/mnt/bd9dc6ee-d251-406d-8dce-ea714434ee34/Bibliography/default.bib")
	bibtex-completion-library-path '("/mnt/bd9dc6ee-d251-406d-8dce-ea714434ee34/Books/PDFs")
	bibtex-completion-notes-path "/mnt/bd9dc6ee-d251-406d-8dce-ea714434ee34/Notes"
	bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"

	bibtex-completion-additional-search-fields '(keywords)
	bibtex-completion-display-formats
	'((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
	  (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
	  (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
	  (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
	  (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
	bibtex-completion-pdf-open-function
	(lambda (fpath)
	  (call-process "open" nil 0 nil fpath)))
(define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)



(message "Init Loaded!")
(provide 'init)
;;; init.el ends here
