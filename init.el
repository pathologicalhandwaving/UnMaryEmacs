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
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

(use-package quelpa-use-package)
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)


;; Fix unicode errors
(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")

;; Default Font
;;(use-package fira-code-mode)

;; git
;; (use-package git)
;; (use-package git-commit)
;; (use-package git-gutter-fringe)
;; (setq git-gutter:window-width 2)
;; (setq git-gutter:unchanged-sign "  ")
;; (set-face-foreground 'git-gutter:unchanged "yellow")
;; (setq git-gutter:modified-sign "????")
;; (setq git-gutter:added-sign "++")
;; (setq git-gutter:deleted-sign "??????")
;; (set-face-foreground 'git-gutter-fr:modified "blue")
;; (set-face-foreground 'git-gutter-fr:added "green")
;; (set-face-foreground 'git-gutter-fr:deleted "red")
;; (set-face-foreground 'git-gutter:added "green")
;; (set-face-foreground 'git-gutter:deleted "red")
;; (set-face-foreground 'git-gutter:modified "blue")

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

;; i3-wm
(use-package i3wm)

;; (use-package editorconfig
;;   :ensure t
;;   :config
;;   (editorconfig-mode 1))

;; Bars
(setq inhibit-startup-message t)

(tool-bar-mode -1)
(menu-bar-mode +1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(set-fringe-mode 10)

(setq visible-bell t)

;; Line Numbers
(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		org-agenda-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)

;; Overwrite selected text
(delete-selection-mode t)

;; Scroll to the first and last line of the buffer
(setq scroll-error-top-bottom t)

;; scroll
(setq scroll-margin 0)
(setq scroll-conservatively 10000)
(setq scroll-preserve-screen-position t)

;; recents
(recentf-mode 1)
(defvar recentf-max-saved-items)
(setq recentf-max-saved-items 200)


(use-package load-bash-alias
  :ensure t
  :config
  (setq load-bash-alias-bashrc-file "~/.bashrc")
  (setq load-bash-alias-exclude-aliases-regexp "^alias magit\\|^alias oc"))


;; User Information
(setq user-full-name "UnMary")
(setq user-mail-address "ourladyofunmary@gmail.com")


;; Theme
(use-package doom-themes
  :config (load-theme 'doom-nord t))


;; icons
;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts
(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :defer t
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 25)
	   (doom-modeline-bar-width 4)))

(setq doom-modeline-icon (display-graphic-p))
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(setq doom-modeline-buffer-state-icon t)
(setq doom-modeline-buffer-modification-icon t)


;; Web
;; (use-package inherit-org
;;   :quelpa
;;   (inherit-org :repo "chenyanming/inherit-org" :fetcher github))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/private/inherit-org"))
;; (require 'inherit-org)
;; (with-eval-after-load 'org
;;   (require 'inherit-org))
;; (with-eval-after-load 'info
;;   (add-hook 'Info-mode-hook 'inherit-org-mode))
;; (with-eval-after-load 'helpful
;;   (add-hook 'helpful-mode-hook 'inherit-org-mode))
;; (with-eval-after-load 'w3m
;;   (add-hook 'w3m-fontify-before-hook 'inherit-org-w3m-headline-fontify)
;;   (add-hook 'w3m-fontify-after-hook 'inherit-org-mode))

;; dashboard
(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
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

;; Parrot
(defun my/parrot-animate-when-compile-success (buffer result)
  (if (string-match "^finished" result)
      (parrot-start-animation)))

(use-package parrot
  :ensure t
  :config
  (parrot-mode)
  (parrot-set-parrot-type 'thumbsup)
  (add-hook 'before-save-hook 'parrot-start-animation)
  (add-to-list 'compilation-finish-functions 'my/parrot-animate-when-compile-success))


;; delimiters
(use-package rainbow-delimiters
:commands (rainbow-delimiters-mode)
:init
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(defvar show-paren-delay)
(setq show-paren-delay 0.0)
(show-paren-mode t)


;; Open dired in same buffer
(put 'dired-find-alternate-file 'disabled nil)

;; Sort directories first
(setq dired-listing-switches "-agho --group-directories-first")

;; Copy and move files between dired buffers
(setq dired-dwim-target t)




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

(use-package helm-wikipedia)


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



;; Org-Mode
(use-package org
  :bind
  (("C-c l" . org-store-link)
   ("C-c c" . org-capture)))

;;(require 'org-protocol)
;; Startup
(setq org-startup-indented t
      org-pretty-entities nil
      org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300))

;; Show hidden emphasis markers
;; (use-package org-appear
;;   :hook (org-mode . org-appear-mode))

;; Bullets
(use-package org-superstar
    :config
    (setq org-superstar-special-todo-items t)
    (add-hook 'org-mode-hook (lambda ()
                               (org-superstar-mode 1))))
(setq org-superstar-headline-bullets-list
      '("???" ("????" ????) "???" "???"))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 2)
(use-package htmlize)

;; Line spacing
(setq-default line-spacing 6)




;; (use-package org-sidebar
;;   :quelpa (org-sidebar :fetcher github :repo "alphapapa/org-sidebar"))


;; quickref
;;(use-package quickref)
;;(quickref-global-mode +1)
;;(setq quickref-save-file "/mnt/bd9dc6ee-d251-406d-8dce-ea714434ee34/Notes/quickref.org")

;; org-noter
;;(use-package org-noter)

;; org-roam
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "/mnt/bd9dc6ee-d251-406d-8dce-ea714434ee34/Notes/Org")
  (org-roam-completion-everywhere t)
  :bind
  ((("C-c n l" . org-roam-buffer-toggle)
    ("C-c n f" . org-roam-node-find)
    ("C-c n r" . org-roam-ref-add)
    ("C-c n t" . org-roam-tag-add)
    ("C-c n i" . org-roam-node-insert)
    ("C-c n I" . org-roam-insert-immediate)))
  :config
  (org-roam-setup))


(use-package org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; ;; for org-roam-buffer-toggle
;; ;; Recommendation in the official manual
(add-to-list 'display-buffer-alist
	     '("\\*org-roam\\*"
	       (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.25)
               (window-height . 0.50)))

;; (org-roam-db-autosync-mode)

(setq org-roam-mode-section-functions
      (list #'org-roam-backlinks-section
 	    #'org-roam-reflinks-section))

(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
	 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
			    "#+title: ${title}\n#+category: %?\n#+filetags: \n\n* ${title}\n")
	 :unnarrowed t)
	("w" "work" plain
	 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
			    "#+title: ${title}\n#+category: Work\n#+filetags: :work:\n\n* ${title}\n%?")
	 :unnarrowed t)
	("t" "term" plain
	 :if-new (file+head  "%<%Y%m%d%H%M%S>-${slug}.org"
			     "#+title: ${title}\n#+category: Dictionary\n#+filetags: :dictionary:\n\n* ${title}\n%?")
	 :unnarrowed t)))

;; (setq org-roam-capture-templates
;;       '(("m" "main" plain
;; 	 "%?"
;; 	 :if-new (file+head "${slug}.org"
;; 			    "#+title: ${title}\n")
;; 	 :immediate-finish t
;; 	 :unnarrowed t)
;; 	("c" "card" plain "%?"
;; 	 :if-new (file+head "${slug}.org"
;; 			    "#+title: ${title}\n#+filetags: \n\n* ${title}\n")
;; 	 :unnarrowed t)
;; 	("d" "default" plain "%?"
;; 	 :target
;; 	 (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
;; 		    "#+title: ${title}\n#+date: <%Y%m%d-%H%M>\n#+filetags: \n")
;; 	 :immediate-finish t)
;; 	("a" "article" plain "%?"
;; 	 :if-new
;; 	 (file+head "${title}.org" "#+title: ${title}\n#+filetags: :article:readlater:\n")
;; 	 :immediate-finish t
;; 	 :unnarrowed t))
;       time-stamp-start "#\\+lastmod: [\t]*")

;; (cl-defmethod org-roam-node-type ((node org-roam-node))
;;   "Return the TYPE of NODE."
;;   (condition-case nil
;;       (file-name-nondirectory
;;        (directory-file-name
;;         (file-name-directory
;;          (file-relative-name (org-roam-node-file node) org-roam-directory))))
;;     (error "")))

;; (setq org-roam-node-display-template
;;       (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
;; (setq org-roam-node-display-template
;;       (concat "${title:*} "
;;               (propertize "${tags:10}" 'face 'org-tag)))
;; (use-package vulpea
;;   :ensure t
;;   ;; hook into org-roam-db-autosync-mode you wish to enable
;;   ;; persistence of meta values (see respective section in README to
;;   ;; find out what meta means)
;;   :hook ((org-roam-db-autosync-mode . vulpea-db-autosync-enable)))


;; LaTeX (karthink)
;; (use-package latex
;;   :ensure auctex
;;   :hook ((LaTeX-mode . prettify-symbols-mode))
;;   :bind (:map LaTeX-mode-map
;;          ("C-S-e" . latex-math-from-calc))
;;   :config
;;   ;; Format math as a Latex string with Calc
;;   (defun latex-math-from-calc ()
;;     "Evaluate `calc' on the contents of line at point."
;;     (interactive)
;;     (cond ((region-active-p)
;;            (let* ((beg (region-beginning))
;;                   (end (region-end))
;;                   (string (buffer-substring-no-properties beg end)))
;;              (kill-region beg end)
;;              (insert (calc-eval `(,string calc-language latex
;;                                           calc-prefer-frac t
;;                                           calc-angle-mode rad)))))
;;           (t (let ((l (thing-at-point 'line)))
;;                (end-of-line 1) (kill-line 0) 
;;                (insert (calc-eval `(,l
;;                                     calc-language latex
;;                                     calc-prefer-frac t
;;                                     calc-angle-mode rad))))))))

;; CDLatex settings
;; (use-package cdlatex
;;   :ensure t
;;   :hook (LaTeX-mode . turn-on-cdlatex)
;;   :bind (:map cdlatex-mode-map 
;;               ("<tab>" . cdlatex-tab)))

;; ;; Yasnippet settings
;; (use-package yasnippet
;;   :ensure t
;;   :hook ((LaTeX-mode . yas-minor-mode)
;;          (post-self-insert . my/yas-try-expanding-auto-snippets))
;;   :config
;;   (use-package warnings
;;     :config
;;     (cl-pushnew '(yasnippet backquote-change)
;;                 warning-suppress-types
;;                 :test 'equal))

;;   (setq yas-triggers-in-field t)
  
;;   ;; Function that tries to autoexpand YaSnippets
;;   ;; The double quoting is NOT a typo!
;;   (defun my/yas-try-expanding-auto-snippets ()
;;     (when (and (boundp 'yas-minor-mode) yas-minor-mode)
;;       (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
;;         (yas-expand)))))

;; CDLatex integration with YaSnippet: Allow cdlatex tab to work inside Yas
;; fields
;; (use-package cdlatex
;;   :hook ((cdlatex-tab . yas-expand)
;;          (cdlatex-tab . cdlatex-in-yas-field))
;;   :config
;;   (use-package yasnippet
;;     :bind (:map yas-keymap
;;            ("<tab>" . yas-next-field-or-cdlatex)
;;            ("TAB" . yas-next-field-or-cdlatex))
;;     :config
;;     (defun cdlatex-in-yas-field ()
;;       ;; Check if we're at the end of the Yas field
;;       (when-let* ((_ (overlayp yas--active-field-overlay))
;;                   (end (overlay-end yas--active-field-overlay)))
;;         (if (>= (point) end)
;;             ;; Call yas-next-field if cdlatex can't expand here
;;             (let ((s (thing-at-point 'sexp)))
;;               (unless (and s (assoc (substring-no-properties s)
;;                                     cdlatex-command-alist-comb))
    ;;             (yas-next-field-or-maybe-expand)
    ;;             t))
    ;;       ;; otherwise expand and jump to the correct location
    ;;       (let (cdlatex-tab-hook minp)
    ;;         (setq minp
    ;;               (min (save-excursion (cdlatex-tab)
    ;;                                    (point))
    ;;                    (overlay-end yas--active-field-overlay)))
    ;;         (goto-char minp) t))))

    ;; (defun yas-next-field-or-cdlatex nil
    ;;   (interactive)
    ;;   "Jump to the next Yas field correctly with cdlatex active."
    ;;   (if
    ;;       (or (bound-and-true-p cdlatex-mode)
    ;;           (bound-and-true-p org-cdlatex-mode))
    ;;       (cdlatex-tab)
    ;;     (yas-next-field-or-maybe-expand)))))



;; LaTeX fragment previews
;;(plist-put org-format-latex-options :scale 2)

;; BibTeX
(use-package org-ref)
(use-package org-ref-prettify)
(with-eval-after-load 'org
  (add-hook 'org-mode-hook 'org-ref-prettify-mode))

(use-package bibtex)
(require 'bibtex)

;; (setq bibtex-autokey-year-length 4
;; 	bibtex-autokey-name-year-separator "-"
;; 	bibtex-autokey-year-title-separator "-"
;; 	bibtex-autokey-titleword-separator "-"
;; 	bibtex-autokey-titlewords 2
;; 	bibtex-autokey-titlewords-stretch 1
;; 	bibtex-autokey-titleword-length 5
;; 	org-ref-bibtex-hydra-key-binding (kbd "H-b"))

;; (define-key bibtex-mode-map (kbd "H-b") 'org-ref-bibtex-hydra/body)

;;(use-package vertico)
(use-package orderless)
(use-package embark)
(use-package marginalia)
(use-package consult)

;; (use-package citar
;;   :bind (("C-c b" . citar-insert-citation)
;;          :map minibuffer-local-map
;;          ("M-b" . citar-insert-preset))
;;   :custom
;;   (citar-bibliography '("/mnt/bd9dc6ee-d251-406d-8dce-ea714434ee34/Bibliography/default.bib")))
  
;; (setq citar-symbols
;;       `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
;;         (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
;;         (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
;; (setq citar-symbol-separator "  ")


;; (setq bibtex-completion-bibliography '(".bib"
;; 					 "/mnt/bd9dc6ee-d251-406d-8dce-ea714434ee34/Bibliography/default.bib")
;; 	bibtex-completion-library-path '("/mnt/bd9dc6ee-d251-406d-8dce-ea714434ee34/Books/PDFs")
;; 	bibtex-completion-notes-path "/mnt/bd9dc6ee-d251-406d-8dce-ea714434ee34/Notes"
;; 	bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"

;; 	bibtex-completion-additional-search-fields '(keywords)
;; 	bibtex-completion-display-formats
;; 	'((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
;; 	  (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
;; 	  (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
;; 	  (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
;; 	  (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
;; 	bibtex-completion-pdf-open-function
;; 	(lambda (fpath)
;; 	  (call-process "open" nil 0 nil fpath)))
;; (define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)

;; PDFs
(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-tools-install)
  :bind ("C-c C-g" . pdf-sync-forward-search)
  :defer t
  :config
  (setq mouse-wheel-follow-mouse t)
  (setq pdf-view-resize-factor 1.10))


;; Latex
;; from https://nasseralkmim.github.io/notes/2016/08/21/my-latex-environment/
;; (use-package tex-site
;;   :ensure auctex
;;   :mode ("\\.tex\\'" . latex-mode)
;;   :config
;;   (setq TeX-auto-save t)
;;   (setq TeX-parse-self t)
;;   (setq-default TeX-master nil)
;;   (add-hook 'LaTeX-mode-hook
;;             (lambda ()
;;               ;;(setq TeX-command-default "latexmk")
;;               (rainbow-delimiters-mode)
;;               (company-mode)
;;               (smartparens-mode)
;;               (turn-on-reftex)
;;               (setq reftex-plug-into-AUCTeX t)
;;               (reftex-isearch-minor-mode)
;;               (setq TeX-PDF-mode t)
;;               (setq TeX-source-correlate-method 'synctex)
;;               (setq TeX-source-correlate-start-server t)))

  ;; Update PDF buffers after successful LaTeX runs
  ;; (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
  ;;           #'TeX-revert-document-buffer)

  ;; ;; to use pdfview with auctex
  ;; (add-hook 'LaTeX-mode-hook 'pdf-tools-install)

  ;; ;; to use pdfview with auctex
  ;; (setq TeX-view-program-selection '((output-pdf "pdf-tools"))
  ;;       TeX-source-correlate-start-server t)
  ;; (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view"))))

;; eaf
;; (use-package eaf
;;   :load-path "~/emacs/emacs-application-framework"
;;   :init
;;   (use-package epc :defer t :ensure t)
;;   (use-package ctable :defer t :ensure t)
;;   (use-package deferred :defer t :ensure t)
;;   (use-package s :defer t :ensure t)
;;   :custom
;;   (eaf-browser-continue-where-left-off t)
;;   :config
;;   ;(eaf-setq eaf-browser-enable-adblocker "true")
;;   ;(eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
;;   ;(eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
;;   ;(eaf-bind-key take_photo "p" eaf-camera-keybinding)
;;   ;(eaf-bind-key nil "M-q" eaf-browser-keybinding)
;;   )
;;(require 'eaf)
;;(require 'eaf-mindmap)


;; Writing Tools
(use-package academic-phrases :ensure t)

(use-package synosaurus
  :diminish synosaurus-mode
  :init    (synosaurus-mode)
  :config  (setq synosaurus-choose-method 'popup) ;; 'ido is default.
  (global-set-key (kbd "M-#") 'synosaurus-choose-and-replace))

(use-package wordnut
  :bind ("M-!" . wordnut-lookup-current-word))

(use-package google-translate)
(setq google-translate-default-source-language "auto")
(setq google-translate-default-target-language "en")

(use-package wiki-summary)
(use-package define-it)
(setq define-it-output-choice 'pop)

(use-package wikinforg
  :ensure t)


;; Search Engines
(use-package engine-mode)
(engine-mode t)
;;(setq engine/browser-function 'eww-browse-url)

(defengine github
  "https://github.com/search?ref=simplesearch&q=%s")
(defengine ctan
  "http://www.ctan.org/search/?x=1&PORTAL=on&phrase=%s"
  :docstring "Search the Comprehensive TeX Archive Network (ctan.org)")
(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")
(defengine google-images
  "http://www.google.com/images?hl=en&source=hp&biw=1440&bih=795&gbv=2&aq=f&aqi=&aql=&oq=&q=%s")
(defengine google-maps
  "http://maps.google.com/maps?q=%s"
  :docstring "Mapssss")
(defengine project-gutenberg
  "http://www.gutenberg.org/ebooks/search/?query=%s")
(defengine rfcs
  "http://pretty-rfc.herokuapp.com/search?q=%s")
(defengine stack-overflow
  "https://stackoverflow.com/search?q=%s")
(defengine twitter
  "https://twitter.com/search?q=%s")
(defengine wikipedia
  "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w")
(defengine wiktionary
  "https://www.wikipedia.org/search-redirect.php?family=wiktionary&language=en&go=Go&search=%s")
(defengine wolfram-alpha
  "http://www.wolframalpha.com/input/?i=%s")
(defengine youtube
  "http://www.youtube.com/results?aq=f&oq=&search_query=%s")
(defengine seasoned-advice
  "https://cooking.stackexchange.com/search?q=%s")
(defengine mathematics
  "https://math.stackexchange.com/search?q=%s")
(defengine englang
  "https://english.stackexchange.com/search?q=%s")
(defengine linux
  "https://unix.stackexchange.com/search?q=%s")
(defengine infosec
  "https://security.stackexchange.com/search?q=%s")
(defengine cryptography
  "https://crypto.stackexchange.com/search?q=%s")
(defengine history
  "https://history.stackexchange.com/search?q=%s")
(defengine mathoverflow
  "https://mathoverflow.net/search?q=%s")
(defengine emacs
  "https://emacs.stackexchange.com/search?q=%s")
(defengine law
  "https://law.stackexchange.com/search?q=%s")
(defengine politics
  "https://politics.stackexchange.com/search?q=%s")
(defengine tcs
  "https://cstheory.stackexchange.com/search?q=%s")
(defengine merck
  "https://www.merckmanuals.com/professional/SearchResults?query=%s")
(defengine rosettacode
  "http://rosettacode.org/mw/index.php?title=Special%3ASearch&search=%s")
(defengine arxiv
  "https://arxiv.org/search/?query=%s")
(defengine citeseerx
  "https://citeseerx.ist.psu.edu/search?q=%s")
(defengine dblp
  "https://dblp.org/search?q=%s")
(defengine semanticscholar
  "https://www.semanticscholar.org/search?q=%s")
(defengine worldcat
  "https://www.worldcat.org/search?q=%s")
(defengine scholarpedia
  "http://www.scholarpedia.org/w/index.php?search=%s")
(defengine mathency
  "https://encyclopediaofmath.org/index.php?title=Special%3ASearch&search=%s")
(defengine mathworld
  "https://mathworld.wolfram.com/search/?query=%s")
(defengine oeis
  "https://oeis.org/search?q=%s")
(defengine nlab
  "https://www.google.com/search?as_q=%s&as_sitesearch=https%3A%2F%2Fncatlab.org%2Fnlab%2F")
(defengine sep
  "https://plato.stanford.edu/search/searcher.py?query=%s")
(defengine ballotpedia
  "https://ballotpedia.org/wiki/index.php?search=%s")
(defengine foldoc
  "https://foldoc.org/%s")
(defengine etymolonline
  "https://www.etymonline.com/search?q=%s")
(defengine jurispedia
  "http://www.jurispedia.org/index2.php?cof=FORID%3A11&ie=UTF-8&q=%s")
(defengine wikibooks
  "https://en.wikibooks.org/wiki/Special:Search?search=%s")
(defengine wikidata
  "https://www.wikidata.org/w/index.php?search=sseech&search=%s")
(defengine wikicommons
  "https://commons.wikimedia.org/w/index.php?search=%s")
(defengine wikinews
  "https://en.wikinews.org/wiki/Special:Search?search=%s")
(defengine wikiquote
  "https://en.wikiquote.org/wiki/Special:Search?search=%s")
(defengine wikisource
  "https://wikisource.org/w/index.php?search=%s")
(defengine wikiversity
  "https://en.wikiversity.org/wiki/Special:Search?search=%s")
(defengine wikitionary
  "https://en.wiktionary.org/wiki/Special:Search?search=%s")


(message "Init Loaded!")
(provide 'init)
;;; init.el ends here
