#lang sicp

; Exercise 1.29

; term - a function applied to `a` before summing
; next - a function that transforms a_n to a_(n+1)
(define (sum term a next b)
  (define (sum-helper a b)
    (if (> a b)
      0
      (+ (term a)
         (sum-helper (next a) b))))
  (sum-helper a b))

(define (inc x) (+ x 1))

; Calculates the integral using Simpson's Rule
; n -- the accuracy of the approximation. Higher is more accurate.
; NOTE: n must be even!
(define (simp f a b n)
    (define h (/ (- b a) n))
    (define (y k) (f (+ a (* k h))))
    (define (coeff k)
      (cond ((or (= k 0) (= k n)) 1)
            ((even? k) 2)
            ((odd? k) 4)))
    (define (term k) (* (coeff k) (y k)))
    (* (/ h 3) (sum term 0 inc n)))

; Integral as defined in the book
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

; Testing with `cube`

(define (cube n) (* n n n))

(simp cube 0 1 100)      ; 0.25
(integral cube 0 1 0.01) ; 0.2499875

