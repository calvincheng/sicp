#lang sicp

; -- normal expmod

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

; -- fast-expmod

(define (fast-expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))

; Let's try fast-exptmod with a large prime
(#%require racket/trace)
(trace expmod)
(expmod 920628919 1000000007 1000000007)

; Uncomment to run -- this will never complete (explained below).
; (trace fast-expt)
; (fast-expmod 920628919 1000000007 1000000007)

; Tracing fast-expt, the exponent value blows up during the reduction phase:

; >{fast-expt 920628919 1000000007}
; > {fast-expt 920628919 1000000006}
; ...
; > > > >[44] {fast-expt 920628919 1}
; > > > >[45] {fast-expt 920628919 0}
; < < < <[45] 1
; < < < <[44] 920628919
; < < < <[43] 847557606499108561
; ...
; < < < <[38] 98711820605416563669121296084457050810104908795035756304840098265260299346465112999885130619905126735187361508892583442607161137533408689297633731088929783149363397380461898395042752655233277239081344225529556283452720309324534801896119211923521401441

; For expmod, the exponent is kept at bay through successive halving:

; >{expmod 920628919 1000000007 1000000007}
; > {expmod 920628919 1000000006 1000000007}
; > >{expmod 920628919 500000003 1000000007}
; ...
; > > > >[22] {expmod 920628919 30516 1000000007}
; > > > >[23] {expmod 920628919 15258 1000000007}
; ...
; > > > >[44] {expmod 920628919 1 1000000007}
; > > > >[45] {expmod 920628919 0 1000000007}
; < < < <[45] 1
; < < < <[44] 920628919
; < < < <[43] 566205361
; ...
; < < < <[16] 304981038
; < < < <[15] 364017395
; ...
; < < 700929177
; < <1
; < 1
; <920628919
; 920628919

; As explained from the book:
; > The reduction steps in the cases where the exponent $e$ is greater than 1 are
; > based on the fact that, for any integers $x$, $y$, and $m$, we can find the
; > remainder of $x$ times $y$ modulo $m$ by computing separately the remainders
; > of $x$ modulo $m$ and $y$ modulo $m$, multiplying these, and then taking the
; > remainder of the result modulo $m$. For instance, in the case where $e$ is
; > even, we compute the remainder of $b^{e/2}$ modulo $m$, square this, and take
; > the remainder modulo $m$. This technique is useful because it means we can
; > perform our computation without ever having to deal with numbers much larger
; > than $m$.

; Therefore using fast-expt is unfeasible for testing primality in large numbers.
