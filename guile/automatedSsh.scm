#!/usr/local/bin/guile -s
!#

(define-module (snippets ssh))
(use-modules (ice-9 popen))
(use-modules (ice-9 textual-ports)) ; Maybe not needed

(let* ((argv (command-line))
       (ip   (list-ref argv 1)) ; Verify if IP is reachable maybe
       (ssh (open-input-output-pipe (string-append "ssh diag@" ip " -p 225 -T"))))
  (if (port? ssh)
      ((put-string "touch test.sh\n" ssh))
      (display "Nothing to do"))
  (close-pipe ssh))


