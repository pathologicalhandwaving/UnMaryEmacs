;;; shrface-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "shrface" "shrface.el" (0 0 0 0))
;;; Generated autoloads from shrface.el

(autoload 'shrface-shr-fontize-dom "shrface" "\
Fontize the sub Optional argument DOM PROPS and FACE.

\(fn DOM PROPS FACE)" nil nil)

(autoload 'shrface-shr-add-props "shrface" "\
Fontize the string.
Argument START start point.
Argument END end point.
Argument PROPS text properties.

\(fn START END PROPS)" nil nil)

(autoload 'shrface-shr-add-face "shrface" "\
Fontize the string.
Argument START start point.
Argument END end point.
Argument FACE face.

\(fn START END FACE)" nil nil)

(autoload 'shrface-shr-urlify "shrface" "\
Fontize the URL.
Argument START start point.
Argument END the url.

\(fn START URL &optional TITLE)" nil nil)

(autoload 'shrface-bullets-level-string "shrface" "\
Return the bullets in cycle way.
Argument LEVEL the headline level.

\(fn LEVEL)" nil nil)

(autoload 'shrface-imenu-get-tree "shrface" "\
Produce the index for Imenu." nil nil)

(autoload 'shrface-occur "shrface" "\
Use `occur' to find all `shrface-tag-h1' to `shrface-tag-h6'.
`shrface-occur' will disable if variable `shrface-toggle-bullets' is Non-nil." t nil)

(autoload 'shrface-mode "shrface" "\
Toggle shr minor mode.
1. imenu
2. outline-minor-mode
3. org-indent-mode

If called interactively, enable Shrface mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "shrface" '("shrface-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; shrface-autoloads.el ends here
