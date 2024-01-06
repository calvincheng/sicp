#lang sicp

; SICP version

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

; Louis Reasoner's version

(define (expmod2 base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
          (remainder
            (* 
              (expmod2 base (/ exp 2) m)
              (expmod2 base (/ exp 2) m))
            m))
        (else
          (remainder
            (* base (expmod2 base (- exp 1) m))
            m))))

; Tracing
(#%require racket/trace)

(trace expmod)
(expmod 30 4 8)

; >{expmod 30 4 8}
; > {expmod 30 2 8}
; > >{expmod 30 1 8}
; > > {expmod 30 0 8}
; < < 1
; < <6
; < 4
; <0
; 0

; As observed, the above is a linear recursive process.
; expmod only creates one additional invocation of itself, therefore the number
; of invocations can be determined by 1^n, where n is the depth of recursion.

(newline)

(trace expmod2)
(expmod2 30 4 8)

; >{expmod2 30 4 8}
; > {expmod2 30 2 8}
; > >{expmod2 30 1 8}
; > > {expmod2 30 0 8}
; < < 1
; < <6
; > >{expmod2 30 1 8}
; > > {expmod2 30 0 8}
; < < 1
; < <6
; < 4
; > {expmod2 30 2 8}
; > >{expmod2 30 1 8}
; > > {expmod2 30 0 8}
; < < 1
; < <6
; > >{expmod2 30 1 8}
; > > {expmod2 30 0 8}
; < < 1
; < <6
; < 4
; <0
; 0

; Recall that Lisp follows applicative-order evaluation, where the arguments 
; are evaluated before they are applied. 

; Therefore each invocation of expmod2 creates additional invocations of itself
; and this number grows exponentially. The rate of growth is O(2^n), since each
; expmod2 creates two child processes.

; The overall time complexity therefore is O(log(2^n)) = O(nlog(2)) = O(n).
