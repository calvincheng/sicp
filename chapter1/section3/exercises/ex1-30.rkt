#lang sicp

; Exercise 1.30

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (+ result (term a)))))
  (iter a 0))

; Test by summing from 1 to 100

(define (id x) x)
(define (incr x) (+ x 1))

(sum id 1 incr 100)
; 5050
