#lang sicp

; -- fermat test

(define (fast-prime? n times)
  (cond ((= times 0) #t)
    ((fermat-test n)
      (fast-prime? n (- times 1)))
    (else #f)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
          (remainder
            (square (expmod base (/ exp 2) m))
            m))
        (else
          (remainder
            (* base (expmod base (- exp 1) m))
            m))))

(define (square x) 
  (* x x))

; -- iterative method

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
          n)
        ((divides? test-divisor n)
          test-divisor)
        (else (find-divisor
               n
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

; -- testing

(equal? (prime? 561) (fast-prime? 561 100))   ; #f
(equal? (prime? 1105) (fast-prime? 1105 100)) ; #f
(equal? (prime? 1729) (fast-prime? 1729 100)) ; #f
(equal? (prime? 2465) (fast-prime? 2465 100)) ; #f
(equal? (prime? 2821) (fast-prime? 2821 100)) ; #f
(equal? (prime? 6601) (fast-prime? 6601 100)) ; #f

; fast-prime? should give the same result as prime? but as observed the
; Carmichael numbers do indeed fool the Fermat test.
