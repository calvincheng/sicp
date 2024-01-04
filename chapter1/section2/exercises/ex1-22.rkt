#lang sicp

(#%require racket/base)
(define (runtime) (* 100 (current-inexact-milliseconds)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))
      #f))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time)
  #t)

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

(define (square x)
  (* x x))


(define (search-for-primes from to)
  (sfp-iter from to 0))

(define (sfp-iter cand limit numFound)
  (if (and (< numFound 4) (< cand limit))
    (if (timed-prime-test cand)
       (sfp-iter (+ cand 2) limit (+ numFound 1))
       (sfp-iter (+ cand 2) limit numFound))
    (newline)))

; Baseline
(search-for-primes 1000000001 100000000000)
; 1000000007 *** 11.375 μs
; 1000000009 *** 9.6875 μs
; 1000000021 *** 9.5 μs
; 1000000033 *** 11.03125 μs
; Runtime = ~10 μs

; Baseline * 10
(search-for-primes 10000000001 1000000000000)
; 10000000019 *** 31.375
; 10000000033 *** 31.3125
; 10000000061 *** 31.40625
; 10000000069 *** 31.3125
; Runtime = ~31 μs

; 31 / 10 = 3.1
; sqrt(10) = 3.16
; Aligns with expected O(sqrt(n))

(search-for-primes 100000000001 10000000000000)
; 100000000003 *** 98.1875
; 100000000019 *** 101.09375
; 100000000057 *** 98.8125
; 100000000063 *** 99.40625
; Runtime = ~99 μs

; 99 / 10 = 9.9
; sqrt(100) = 10
; Aligns with expected O(sqrt(n))

