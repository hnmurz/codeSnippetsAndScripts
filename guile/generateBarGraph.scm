#!/usr/local/bin/guile -s
!#

(define-module (snippets plotting))
(use-modules (ice-9 textual-ports))
(use-modules (ice-9 format))
(use-modules (ice-9 popen))

;; Another good example of this can be seen here:
;; https://github.com/djcb/mu/blob/master/guile/mu/plot.scm
(define (plot-data filename sampling-rate)
  (let ((gnuplot (open-pipe "gnuplot -p" OPEN_WRITE)))
    (display (string-append
              "set boxwidth 0.6\n"
              "set style fill solid\n"
              "set xlabel \"Seconds For Stats to Update\"\n"
              "set ylabel \"Frequency\"\n"
              "set title  \"Time Taken for Counters to Update in SW, SamplingRate=" sampling-rate "\"\n"
              "set xtics 0,2\n"
              "set key off\n"
              "plot \"" filename "\" with boxes\n")
             gnuplot)
    (close-pipe gnuplot)))

(define (write-data-to-file out-file data)
  "Write data to file in format of: x y"
  (let ((len (array-length data))
        (out-data-port (open-output-file out-file)))
    (do ((i 0 (+ i 1))) ((= i len))
      (format out-data-port "~d ~d\n" i (array-ref data i)))
    (close-port out-data-port)
    (display (format #f "Wrote data to file=~s\n" out-file))))

(define (read-data-from-file in-file)
  "Read in the data file and count the occurence of each number"
  (if (not (file-exists? in-file))
      ((error (format #f "Input file ~s does not exist" in-file))))
  (let* ((in-data-port (open-input-file in-file))
         (data (make-array 0 64))
         (line (get-line in-data-port)))
    (while (not (eof-object? line))
      (let ((data-point (array-ref data (string->number line))))
        (set! data-point (+ data-point 1))
        (array-set! data data-point (string->number line)))
      (set! line (get-line in-data-port)))
    (close-port in-data-port)
    data))

;; Main script
(let* ((argv (command-line)))
  (if (= (length argv) 4)
      (let ((in-file (list-ref argv 1))
            (out-file (list-ref argv 2))
            (sampling-rate (list-ref argv 3)))
        (begin (write-data-to-file out-file (read-data-from-file in-file))
               (plot-data out-file sampling-rate)))
      (display "Not enough arguments\n")))
