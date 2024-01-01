#lang sicp

(define (pow b n)
  (define (pow-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (pow-iter (* b b) (/ n 2) a))
          (else (pow-iter b (- n 1) (* a b)))))
  (pow-iter b n 1))

; Observe that b^n = (b)^n * a        a = 1
;                  = (b^2)^(n/2) * a  a = 1  (1)
;                  = (b)^(n-1) * a,   a = b  (2)
;
; For equation (1), if n is even, dividing n by 2 will result in an even number.
; For equation (2), if n is odd, subtracting 1 from n will result in an even
; number.
;
; We can translate this as the following transitions for b, n and a:

; if n is even: n -> n / 2
;               b -> b^2
;               a -> a

; if n is odd n -> n - 1
;             b -> b
;             a -> a * b
; 
; We can then repeat the above until n is 0.

; Testing against the built-in function expt
(= (expt 8 2) (pow 8 2))   ; #t
(= (expt 2 10) (pow 2 10)) ; #t
(= (expt 5 0) (pow 5 0))   ; #t
