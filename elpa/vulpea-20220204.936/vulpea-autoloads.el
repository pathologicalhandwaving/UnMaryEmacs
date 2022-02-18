;;; vulpea-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "vulpea" "vulpea.el" (0 0 0 0))
;;; Generated autoloads from vulpea.el

(autoload 'vulpea-find "vulpea" "\
Select and find a note.

If OTHER-WINDOW, visit the NOTE in another window.

CANDIDATES-FN is the function to query candidates for selection,
which takes as its argument a filtering function (see FILTER-FN).
Unless specified, `vulpea-find-default-candidates-source' is
used.

FILTER-FN is the function to apply on the candidates, which takes
as its argument a `vulpea-note'. Unless specified,
`vulpea-find-default-filter' is used.

When REQUIRE-MATCH is nil user may select a non-existent note and
start the capture process.

\(fn &key OTHER-WINDOW FILTER-FN CANDIDATES-FN REQUIRE-MATCH)" t nil)

(autoload 'vulpea-find-backlink "vulpea" "\
Select and find a note linked to current note." t nil)

(autoload 'vulpea-insert "vulpea" "\
Select a note and insert a link to it.

Allows capturing new notes. After link is inserted,
`vulpea-insert-handle-functions' are called with the inserted
note as the only argument regardless involvement of capture
process.

FILTER-FN is the function to apply on the candidates, which takes
as its argument a `vulpea-note'. Unless specified,
`vulpea-insert-default-filter' is used.

\(fn &optional FILTER-FN)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vulpea" '("vulpea-")))

;;;***

;;;### (autoloads nil "vulpea-buffer" "vulpea-buffer.el" (0 0 0 0))
;;; Generated autoloads from vulpea-buffer.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vulpea-buffer" '("vulpea-buffer-")))

;;;***

;;;### (autoloads nil "vulpea-db" "vulpea-db.el" (0 0 0 0))
;;; Generated autoloads from vulpea-db.el

(defvar vulpea-db-autosync-mode nil "\
Non-nil if Vulpea-Db-Autosync mode is enabled.
See the `vulpea-db-autosync-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `vulpea-db-autosync-mode'.")

(custom-autoload 'vulpea-db-autosync-mode "vulpea-db" nil)

(autoload 'vulpea-db-autosync-mode "vulpea-db" "\
Global minor mode to automatically synchronise vulpea db.

If called interactively, enable Vulpea-Db-Autosync mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'vulpea-db-autosync-enable "vulpea-db" "\
Activate function `vulpea-db-autosync-mode'." nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vulpea-db" '("vulpea-db-")))

;;;***

;;;### (autoloads nil "vulpea-meta" "vulpea-meta.el" (0 0 0 0))
;;; Generated autoloads from vulpea-meta.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vulpea-meta" '("vulpea-meta")))

;;;***

;;;### (autoloads nil "vulpea-note" "vulpea-note.el" (0 0 0 0))
;;; Generated autoloads from vulpea-note.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vulpea-note" '("vulpea-note-meta-get")))

;;;***

;;;### (autoloads nil "vulpea-select" "vulpea-select.el" (0 0 0 0))
;;; Generated autoloads from vulpea-select.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vulpea-select" '("vulpea-select-")))

;;;***

;;;### (autoloads nil "vulpea-utils" "vulpea-utils.el" (0 0 0 0))
;;; Generated autoloads from vulpea-utils.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "vulpea-utils" '("vulpea-utils-")))

;;;***

;;;### (autoloads nil nil ("vulpea-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; vulpea-autoloads.el ends here
