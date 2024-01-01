#lang sicp

; Exercise 1.15

(define (cube x) (* x x x))
(define (p x)
  (display x) (newline)
  (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
  angle
  (p (sine (/ angle 3.0)))))

(sine 12.15)

; (sine 12.15)
; (p (sine (/ 12.15 3.0)))
; (p (sine 4.05))
; (p (p (sine (/ 4.05 3.0))))
; (p (p (sine 1.35)))
; (p (p (p (sine (/ 1.35 3.0)))))
; (p (p (p (sine 0.45))))
; (p (p (p (p (sine (/ 0.45 3))))))
; (p (p (p (p (sine 0.15)))))
; (p (p (p (p (p (sine (/ 0.15 3.0)))))))
; (p (p (p (p (p (sine 0.05))))))
; (p (p (p (p (p 0.05)))))
; (p (p (p (p 1.495))))
; (p (p (p 0.435)))
; (p (p 0.976))
; (p -0.790)
; -0.400

; Procedure `p` is applied 5 times when (sine 12.15) is evaluated.

; `a` is divided by 3 repeatedly until its value is lower than 0.1.
; Its order of growth in both space and time is therefore log(n).

