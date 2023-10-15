#lang sicp

; Exercise 1.12

; 1
; 1 1
; 1 2 1
; 1 3 3 1
; 1 4 6 4 1

(define (p row col)
  (if (or (= col 0) (= col row)) ; First or last column
    1
    (+ 
      (p (- row 1) (- col 1)) 
      (p (- row 1) col))))

(p 4 0) ; 1
(p 4 1) ; 4
(p 4 2) ; 6
(p 4 3) ; 4
(p 4 4) ; 1

; Alternate solution that "iterates" for you
(define (pascal row)
  (define (p-iter i n)
    (display (p row i))
    (display " ")
    (if (= i n)
      (newline) ; end of iteration symbol
      (p-iter (+ i 1) n)))
  (p-iter 0 row))

(pascal 4)
; 1 4 6 4 1
