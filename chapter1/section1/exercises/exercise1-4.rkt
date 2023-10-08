#lang sicp

; Exercise 1.4

(define (a-plus-abs-b a b)   
  ((if (> b 0) + -) a b))

; The above procedure will first evaluate if b is a positive non-zero value. If 
; so, it will add `b` to `a` (as the + operator will be returned). Otherwise, it
; will subtract `b` from `a` (as the - operator will be returned as the 
; alternative).

; Mathematically, this works because:
; If b is negative, we have a - -abs(b) == a + abs(b).
; If b is positive we have a + abs(b).
