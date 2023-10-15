#lang sicp

; Exercise 1.3

; Define a procedure that takes three numbers
; as arguments and returns the sum of the squares of the two
; larger numbers.

; Helper functions
(define (square x) (* x x))
(define (sum-of-squares x y) (+ (square x) (square y)))

; Main function
(define 
  (foo x y z)
  (cond ((and (<= x y) (<= x z)) (sum-of-squares y z))
        ((and (<= y x) (<= y z)) (sum-of-squares x z))
        ((and (<= z x) (<= z y)) (sum-of-squares x y))))


; Tests
(= (foo 3 2 1) (sum-of-squares 3 2))
(= (foo 3 5 4) (sum-of-squares 5 4))
(= (foo 9 2 8) (sum-of-squares 9 8))
(= (foo 5 5 5) (sum-of-squares 5 5))
(= (foo 9 8 8) (sum-of-squares 9 8))
