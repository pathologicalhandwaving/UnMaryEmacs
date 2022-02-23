;;; lister-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "lister" "lister.el" (0 0 0 0))
;;; Generated autoloads from lister.el

(autoload 'lister-setup "lister" "\
Set up buffer BUF-OR-NAME for lister lists.  Return an ewoc object.
If BUF-OR-NAME is a buffer object, erase this buffer's content.
Else create a new buffer with the name BUF-OR-NAME.  You can
access this buffer with (ewoc-buffer).

Store MAPPER as a buffer local variable in BUF.

Optionally pass a HEADER or FOOTER string, or lists of strings,
or a function with no arguments returning a string or a lists of
strings.

\(fn BUF-OR-NAME MAPPER &optional HEADER FOOTER)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lister" '("lister-")))

;;;***

;;;### (autoloads nil "lister-mode" "lister-mode.el" (0 0 0 0))
;;; Generated autoloads from lister-mode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lister-mode" '("lister-mode")))

;;;***

(provide 'lister-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; lister-autoloads.el ends here
