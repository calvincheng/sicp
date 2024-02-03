### Section 1.3

> [Not using procedures] would place us at a serious disadvantage, forcing us to
> work always at the level of the particular operations that happen to be
> primitives in the language.

> One of the things we should demand from a powerful programming language is the
> ability to build abstractions by assigning names to common patterns and then
> to work in terms of the abstractions directly.

---

Procedures that manipulate other procedures are called _higher-order
procedures_. They help us abstract certain programming patterns so that we can
_express_ such patterns as concepts, and work with them _directly_ without
having to worry about any lower level details.

Consider these methods that sum different numbers together:

```scheme
; Sums the numbers between a and b
(define (sum-integers a b)
  (if (> a b)
    0
    (+ a
       (sum-integers (+ a 1) b))))

; Sums the cube of the terms from a to b
(define (sum-cubes a b)
  (if (> a b)
    0
    (+ (cube a)
       (sum-cubes (+ a 1) b))))

; Sum terms in the series
; 1/(1*3) + 1/(5*7) + 1/(9*11) + ... = pi/8
(define (sum-terms a b)
  (if (> a b)
    0
    (+ (/ 1.0 (* a (+ a 2)))
       (pi-sum (+ a 4) b))))
```

Noticing the underlying pattern,

```scheme
(define (<name> a b)
  (if (> a b)
    0
    (+ (<term> a)
       (<name> (<next> a) b))))
```

we can leverage it to define a general procedure for summing things together:

```scheme
; term - a function applied to `a` before summing
; next - a function that transforms a_n to a_(n+1)
(define (sum term a next b)
  (define (sum-helper a b)
    (if (> a b)
      0
      (+ (term a)
         (sum-helper (next a) b))))
  (sum-helper a b))
```

This is in a way similar for how mathematicians generally express sums using
sigma notation:

$$
\Sigma
$$

Redefining `sum-integers` using our new procedure is quite easy:

```scheme
(define (inc x) (+ x 1))
(define (id x) x)
(define (sum-integers a b)
  (sum id a inc x))
(sum-integers 1 10) ; 55
```
