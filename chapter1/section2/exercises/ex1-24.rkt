#lang sicp

(#%require racket/base)
(define (runtime) (* 100 (current-inexact-milliseconds)))
(require (planet williams/science/random-source))

; -- fast prime

(define (fast-prime? n times)
  (cond ((= times 0) #t)
    ((fermat-test n)
      (fast-prime? n (- times 1)))
    (else #f)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random-integer (- n 1)))))

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

; -- prime tests

(define (timed-prime-test n times)
  (start-prime-test n (runtime) times))

(define (start-prime-test n start-time times)
  (if (fast-prime? n times)
      (report-prime n (- (runtime) start-time))
      null))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time)
  null)


; (I used some smaller primes in the end because Racket uses a different
; representation for numbers over 2^30)
; Source: https://docs.racket-lang.org/inside/Bignums__Rationals__and_Complex_Numbers.html

; Baseline
(timed-prime-test 1000003 100)
(timed-prime-test 1000033 100)
(timed-prime-test 1000037 100)
(timed-prime-test 1000039 100)
; 1000003 *** 3.09375
; 1000033 *** 2.8125
; 1000037 *** 2.90625
; 1000039 *** 3.09375
; Average: 2.9765625

; Baseline * 10
(timed-prime-test 10000019 100)
(timed-prime-test 10000079 100)
(timed-prime-test 10000103 100)
(timed-prime-test 10000121 100)
; 10000019 *** 3.5
; 10000079 *** 3.6875
; 10000103 *** 3.6875
; 10000121 *** 3.6875
; Average: 3.640625

; 3.6406 / 2.9766 = 1.223

; Baseline * 100
(timed-prime-test 100000007 100)
(timed-prime-test 100000037 100)
(timed-prime-test 100000039 100)
(timed-prime-test 100000049 100)
; 100000007 *** 4.09375
; 100000037 *** 5.71875
; 100000039 *** 4.1875
; 100000049 *** 4.09375
; Average: 4.5234375

; 4.5234 / 2.9766 = 1.520

; To be honest, these numbers don't make too much sense to me. We're expecting
; O(log(n)) complexity, but log(10) is 1 and log(100) is 10. It's actually
; scaling even slower than expected.
;
; TODO: Revisit and find out what is happening.
