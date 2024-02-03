#lang sicp

; Exercise 1.31

; Linear recursive version
(define (product f a next b)
  (if (> a b)
    1
    (* (f a)
       (product f (next a) next b))))

; Defining `factorial` in terms of `product`
(define (incr x) (+ x 1))
(define (id x) x)
(define (factorial x)
  (product id 1 incr x))

(factorial 10)
; 3628800 which is indeed 10!

; Approximating π:

; produces 2, 4, 4, 6, 6, 8, ...
(define (kth-num k)
  (if (even? k) (+ k 2) (+ k 1)))

; produces 3, 3, 5, 5, 7, 7, ...
(define (kth-denom k)
  (if (odd? k) (+ k 2) (+ k 1)))

(define (pi-approx num-terms)
  (define num (product kth-num 1 incr num-terms))
  (define denom (product kth-denom 1 incr num-terms))
  (* (/ num denom) 4))

(exact->inexact (pi-approx 10))
; 3.2751010413348074
(exact->inexact (pi-approx 100))
; 3.1570301764551676
(exact->inexact (pi-approx 1000))
; 3.1431607055322663
(exact->inexact (pi-approx 10000))
; 3.1417497057380523

; Linear iterative version
(define (product-iter f a next b)
  (define (iter a result)
  (if (> a b)
    result
    (iter (next a) (* result (f a)))))
  (iter a 1))

(product-iter id 1 incr 10) ; 10!
; Also 3628800
