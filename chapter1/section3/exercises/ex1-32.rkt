#lang sicp

; Excercise 1.32

(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (combiner result (term a)))))
  (iter a null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (id x) x)
(define (incr x) (+ x 1))

(sum id 1 incr 10) ; 1 + 2 + ... + 9 + 10
; 55
(product id 1 incr 10) ; 10!
; 3628800

(define (accumulate-rec combiner null-value term a next b)
    (if (> a b)
      null-value
      (combiner a (accumulate-rec combiner null-value term (next a) next b))))

(define (sum-rec term a next b)
  (accumulate-rec + 0 term a next b))

(define (product-rec term a next b)
  (accumulate-rec * 1 term a next b))

(sum-rec id 1 incr 10) ; 1 + 2 + ... + 9 + 10
; 55
(product-rec id 1 incr 10) ; 10!
; 3628800
