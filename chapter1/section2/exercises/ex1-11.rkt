#lang sicp

; Exercise 1.11

; f(n) = n                          , if n < 3
; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) , if n >= 3

(define (f-r n)
  (if (< n 3) 
    n
    (+ 
      (f-r (- n 1)) 
      (* 2 (f-r (- n 2))) 
      (* 3 (f-r (- n 3))))))

(define (f-i n)
  ; Arguments: 
  ;   a: f(n-1),
  ;   b: f(n-2)
  ;   c: f(n-3)
  ;   i: current n to be calculated
  (define (f-iter a b c i)
    (if (> i n)
      a
      (f-iter (+ a (* 2 b) (* 3 c)) a b (+ i 1))))
  (if (< n 3)
    n
    (f-iter 2 1 0 3)))

; Tests
(= (f-r 3) (f-i 3))
(= (f-r 10) (f-i 10))
(= (f-r (- 5)) (f-i (- 5)))
(= (f-r 0) (f-i 0))
