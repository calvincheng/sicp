#lang sicp

; Exercise 1.8

(define (square x) (* x x))

(define (percentage-of dx x)
  (* (/ dx x) 100))

(define (good-enough? last-guess guess)
  (define tolerance 0.1) ; percentage difference from last guess
  (define diff (- guess last-guess))
  (< (percentage-of (abs diff) last-guess) tolerance))

(define (improve guess x)
  (/ (+ (/ x (square guess)) 
        (* 2 guess))
     3))

(define (cbrt-iter last-guess guess x)
  (if (good-enough? last-guess guess)
      guess
      (cbrt-iter guess (improve guess x) x)))

(define (cbrt x) 
  ; Calling with float 1.0 as initial guess to avoid exact fractions as results
  (cbrt-iter +inf.0 1.0 x))

; Test
(define (cube x) (* x x x))
(cbrt (cube 4)) ; 4.000000000076121
(cbrt (cube 120)) ; 120.00003149337859
(cbrt (cube 0.025)) ; 0.02500000000007599

