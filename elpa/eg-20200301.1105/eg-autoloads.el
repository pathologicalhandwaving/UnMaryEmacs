;;; eg-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "eg" "eg.el" (0 0 0 0))
;;; Generated autoloads from eg.el

(autoload 'eg "eg" "\
Run `eg' to look up COMMAND and display it beautifully.

\(fn COMMAND)" t nil)

(autoload 'eg-at-point "eg" "\
Use `eg' to look up the command at POS.

\(fn POS)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "eg" 'nil))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; eg-autoloads.el ends here
