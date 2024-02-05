#lang sicp

; Exercise 1.33

(define (filtered-accumulate combiner null-value term a next b use?)
  (define (iter a result)
    (cond ((> a b) result)
          ((not (use? a)) (iter (next a) (combiner result null-value)))
          (else (iter (next a) (combiner result (term a))))))
  (iter a null-value))

; Part 1

; (from Exercise 1.28)
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

(define (square n) (* n n))
(define (incr n) (+ n 1))

(define (sum-squared-primes a b)
  (filtered-accumulate + 0 square a incr b prime?))

(sum-squared-primes 0 10) ; 88
(sum-squared-primes 0 100) ; 65797

; Part 2

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (id n) n)

(define (prod-relative-primes n)
  (define (relatively-prime? i)
    (= 1 (gcd i n)))
  (filtered-accumulate * 1 id 1 incr n relatively-prime?))

(prod-relative-primes 10) ; 189
