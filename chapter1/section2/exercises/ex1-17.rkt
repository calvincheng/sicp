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

; Observe that a * b = a * b,
;                    = (a * 2) * (b / 2), (b is even)
;                    = a * (b - 1) + a,   (b is odd)

(define (fast* a b)
  (cond ((= b 0) 0)
        ((even? b) (fast* (double a) (halve b)))
        (else (+ (fast* a (- b 1)) a))))

(define (double x)
  (* x 2))

(define (halve x)
  (/ x 2))


; Test and trace, observing the shape
(#%require racket/trace)

(trace fast*)
(fast* 12 9)

; >{fast*-iter 12 9}
; > {fast*-iter 12 8}
; > {fast*-iter 24 4}
; > {fast*-iter 48 2}
; > {fast*-iter 96 1}
; > >{fast*-iter 96 0}
; < <0
; < 96
; <108
; 108

(trace slow*)
(slow* 12 9)

; >{slow* 12 9}
; > {slow* 12 8}
; > >{slow* 12 7}
; > > {slow* 12 6}
; > > >{slow* 12 5}
; > > > {slow* 12 4}
; > > > >{slow* 12 3}
; > > > > {slow* 12 2}
; > > > > >{slow* 12 1}
; > > > > > {slow* 12 0}
; < < < < < 0
; < < < < <12
; < < < < 24
; < < < <36
; < < < 48
; < < <60
; < < 72
; < <84
; < 96
; <108
; 108

