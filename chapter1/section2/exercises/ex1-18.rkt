#lang sicp

(define (slow* a b)
  (if (= b 0)
    0
    (+ a (slow* a (- b 1)))))

; Analogous to the expt method:
;
; (define (expt-iter b counter product)
;   (if (= counter 0)
;       product
;       (expt-iter b
;                  (- counter 1)
;                  (* b product)))

; Observe that a * b = a * b + x,             x = 0
;                    = (a * 2) * (b / 2) + x, x = 0, (b is even)
;                    = a * (b - 1) + x,       x += a (b is odd)

; Tail
(define (fast*-iter a b x)
  (cond ((= b 0) x)
        ((even? b) (fast*-iter (double a) (halve b) x))
        (else (fast*-iter a (- b 1) (+ x a)))))

(define (double x)
  (* x 2))

(define (halve x)
  (/ x 2))


; Test and trace, observing the shape.
; It is now linear in space due to tail recursion.
(#%require racket/trace)

(trace fast*-iter)
(fast*-iter 12 117 0)

; >{fast*-iter 12 117 0}
; >{fast*-iter 12 116 12}
; >{fast*-iter 24 58 12}
; >{fast*-iter 48 29 12}
; >{fast*-iter 48 28 60}
; >{fast*-iter 96 14 60}
; >{fast*-iter 192 7 60}
; >{fast*-iter 192 6 252}
; >{fast*-iter 384 3 252}
; >{fast*-iter 384 2 636}
; >{fast*-iter 768 1 636}
; >{fast*-iter 768 0 1404}
; <1404
; 1404
