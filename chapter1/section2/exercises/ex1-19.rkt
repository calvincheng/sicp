#lang sicp

; Exercise 1.19


; a <- bq + aq + ap = a'
; b <- bp + aq = b'
; 
; a' <- b'q + a'q + a'p = a''
; b' <- b'p + a'q = b''
; 
; Substitute b', a' into a''
; a' <- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
;    <- aq^2 + bpq + bq^2 + aq^2 + apq + bpq + apq + ap^2
;    <- 2aq^2 + 2bpq + 2apq + ap^2 + bq^2
;    <- 2(aq^2 + bpq + apq) + ap^2 + bq^2
;    <- (2q^2 + p^2 + 2pq)a + (q^2 + 2pq)b
;    <- (q^2 + 2pq)a + (p^2 + q^2)a + (q^2 + 2pq)b
;    <- (q' + p')a + (q')b
;    <- bq' + aq' + ap'
; 
; Similarly, substitue b', a' into b''
; b' <- (bp + aq)p + (bq + aq + ap)q
;    <- bp^2 + apq + bq^2 + aq^2 + apq
;    <- (q^2 + 2pq)a + (p^2 + q^2)b
;    <- (q')a + (p')b
;    <- bp' + aq'
; 
; Therefore,
; 
; q' = q^2 + 2pq
; p' = p^2 + q^2

(define (square x) (* x x))

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0)
         b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))
                   (+ (square q) (* 2 p q))
                   (/ count 2)))
        (else
          (fib-iter (+ (* b q)
                       (* a q)
                       (* a p))
                    (+ (* b p)
                       (* a q))
                    p
                    q
                    (- count 1)))))

; Test
(= (fib 1) 1)
(= (fib 2) 1)
(= (fib 3) 2)
(= (fib 4) 3)
(= (fib 5) 5)
(= (fib 6) 8)
(= (fib 7) 13)
(= (fib 8) 21)
(= (fib 9) 34)
(= (fib 10) 55)
