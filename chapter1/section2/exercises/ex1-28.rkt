#lang sicp

; -- miller-rabin test

(define (miller-rabin-prime? n) 
  (fast-prime? n 100))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
    ((miller-rabin-test n)
      (fast-prime? n (- times 1)))
    (else #f)))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
          (remainder-with-check
            (expmod base (/ exp 2) m) 
            m))
        (else
          (remainder
            (* base (expmod base (- exp 1) m))
            m))))

(define (remainder-with-check a b)
  (if (nontrivial-sqrt? a b)
    0
    (remainder (square a) b)))

(define (nontrivial-sqrt? a n)
  (and (not (= a (- n 1)))
       (not (= a 1))
       (= (remainder (square a) n) 1)))

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

; carmichael numbers
(equal? (prime? 561) (miller-rabin-prime? 561))   ; #t
(equal? (prime? 1105) (miller-rabin-prime? 1105)) ; #t
(equal? (prime? 1729) (miller-rabin-prime? 1729)) ; #t
(equal? (prime? 2465) (miller-rabin-prime? 2465)) ; #t
(equal? (prime? 2821) (miller-rabin-prime? 2821)) ; #t
(equal? (prime? 6601) (miller-rabin-prime? 6601)) ; #t
; Carmichael numbers cannot fool the Miller-Rabin test.

; trying some primes found before:
(equal? (prime? 1000000007) (miller-rabin-prime? 1000000007)) ; #t
(equal? (prime? 1000000009) (miller-rabin-prime? 1000000009)) ; #t
(equal? (prime? 1000000021) (miller-rabin-prime? 1000000021)) ; #t
(equal? (prime? 1000000033) (miller-rabin-prime? 1000000033)) ; #t

