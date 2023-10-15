#lang sicp

; Exercise 1.10

(define (A x y)
  ; (display (list x y)) (newline)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 1 10)
; 1024

(A 2 4)
; 65536

(A 3 3)
; 65536

(define (f n) (A 0 n)) ; f(n) = 2n
(define (g n) (A 1 n)) ; g(n) = 2^n
(define (h n) (A 2 n)) ; h(n) = 2^(h(n-1))
(define (k n) (* 5 n n)) ; k(n) = 5n^2

; f(n) and g(n) are fairly straightforward -- we can derive it directly from the
; definition of Ackermann's function.

; h(n) is a little trickier. Expanding it first using the substitution method:

;   (A 2 n)
;   (A 1 (A 2 (- n 1)))

; Observing from g(n) that (A 1 n) is 2^n, and (A 2 (- n 1)) is h(n-1), we can
; therefore define h(n) recursively as:
;
;   h(n) = g(h(n-1)) = 2^(h(n-1)) = 2^2^2... (n times)
