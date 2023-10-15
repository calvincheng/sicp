#lang sicp

; Exercise 1.6

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))


; sqrt-iter helper functions
(define (square x) (* x x))

(define (good-enough? guess x)
  (define tolerance 0.001)
  (< (abs (- (square guess) x)) tolerance))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

; Using sqrt-iter with new-if
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))


; The procedure will never terminate if `sqrt-itet` is used with `new-if`,
; because Lisp follows applicative-order evaluation. `new-if` is not a special
; form, so both the consequent (`then-clause`) and the alternative
; (`else-clause`) will be evaluated when the procedure is called.
;
; (sqrt-iter 1 9)
; (new-if (good-enough? 1 9)
;         1
;         (sqrt-iter (improve 1 9) 9))
; (new-if (good-enough? 1 9)
;         1
;         (new-if (good-enough? 5 9)
;                 5
;                 (sqrt-iter (improve 5 9) 9)))
; ; ...etc
;
; In contrast, `if` will only evaluate the consequent if its predicate is true,
; skipping the evaluation of the alternative.
;
; (sqrt-iter 1 9)   ; initial call
; (sqrt-iter 5 9)   ; alternate is evaluated as good-enough? is false
; (sqrt-iter 3.4 9) ; alternate is evaluated as good-enough? is false
; ...
; 3.0001            ; guess is evaluated as good-enough? is true

