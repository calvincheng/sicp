#lang sicp

; Exercise 1.7

(define (percentage-of dx x)
  (* (/ dx x) 100))

(define (good-enough? last-guess guess)
  (define tolerance 0.1) ; percentage difference from last guess
  (define diff (- guess last-guess))
  (< (percentage-of (abs diff) last-guess) tolerance))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (sqrt-iter last-guess guess x)
  (if (good-enough? last-guess guess)
      guess
      (sqrt-iter guess (improve guess x) x)))

(define (sqrt x)
  ; Calling with float 1.0 as initial guess to avoid exact fractions as results
  (sqrt-iter +inf.0 1.0 x))

; Test
(define (square x) (* x x))
(sqrt (square 3)) ; 3.000000001396984
(sqrt (square 1000)) ; 1000.0001533016629
(sqrt (square 0.014)) ; 0.01400000000000987

