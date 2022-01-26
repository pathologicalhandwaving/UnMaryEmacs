;;; init.el --- a simple package                     -*- lexical-binding: t; -*-

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
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Bars
(setq inhibit-startup-message t)
(tool-bar-mode +1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Theme
(use-package doom-themes
  :config (load-theme 'doom-outrun-electric t))

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

;; Line spacing
(setq-default line-spacing 6)

;; LaTeX


;; LaTeX fragment previews
(plist-put org-format-latex-options :scale 2)

;; BibTeX

;; FIXME
(setq bib-files-directory (directory-files
                           (concat (getenv "HOME") "/Documents/bibliography") t
                           "^[A-Z|a-z].+.bib$")
      pdf-files-directory (concat (getenv "HOME") "/Documents/pdf"))


(use-package helm-bibtex
  :config
  (require 'helm-config)
  (setq bibtex-completion-bibliography bib-files-directory
        bibtex-completion-library-path pdf-files-directory
        bibtex-completion-pdf-field "File"
        bibtex-completion-notes-path org-directory))

(use-package org-ref
  :config
  (setq org-ref-completion-library 'org-ref-helm-cite
        org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
        org-ref-default-bibliography bib-files-directory
        org-ref-notes-directory org-directory
        org-ref-notes-function 'orb-edit-notes))





(message "Init Loaded!")
(provide 'init)
;;; init.el ends here