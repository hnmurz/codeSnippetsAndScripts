#!/usr/local/bin/guile -s
!#

(define-module (snippets getopt))
(use-modules (ice-9 getopt-long))   ; Arg parsing


(define help-string (string-append
                     "\n"
                     "--foo1  -q  - foo1 setting\n"
                     "--foo2  -w  - foo2 setting\n"
                     "--foo3  -e  - foo3 setting\n"
                     "--help  -h  - display this help\n\n"))
(define options '((foo1 (value #t) (single-char #\q) (required? #t))
                  (foo2 (value #t) (single-char #\w))
                  (foo3 (single-char #\e))
                  (help (single-char #\h))))

(define argv (getopt-long (program-arguments) options))

(when (option-ref argv 'help #f)
  (display help-string)
  (exit))

(let ((foo1 (option-ref argv 'foo1 #f))
      (foo2 (option-ref argv 'foo2 #f))
      (foo3 (option-ref argv 'foo3 #f)))
  (display foo1)
  (newline)
  (display foo2)
  (newline)
  (display foo3)
  (newline))
