## Section 1.2

> Like the novice chess player, we don’t yet know the common patterns of usage
> in the domain.  We lack the knowledge of which moves are worth making (which
> procedures are worth defining). We lack the experience to predict the
> consequences of making a move (executing a procedure).

---

Processes that evolve according to some procedure use up computational resources
like time and space at different rates.

Consider the factorial of a number, defined by:

```
n! = n * (n - 1) * (n - 2) * ... * 3 * 2 * 1
   = n * (n - 1)!
```

Translating the above into a procedure:

```scheme
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

Evaluating this with the substitution model:

```scheme
(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (factorial 3))))
(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
720
```

Another way to calculate the factorial is to keep some running product, and
multiply it with value that we increment at each step.

```
product <- counter * product
counter <- counter - 1
```

In Scheme:

```scheme
(define (factorial n)
  (fact-iter 1 n))

(define (fact-iter product counter)
  (if (<= counter 0)
      product
      (fact-iter (* product counter) (- counter 1))))
```

Expanding with the substitution model again gives

```scheme
(factorial 6)
(fact-iter 1 6)
(fact-iter (* 1 6) (- 6 1))
(fact-iter 6 5)
(fact-iter (* 6 5) (- 5 1))
(fact-iter 30 4)
(fact-iter (* 30 4) (- 4 1))
(fact-iter 120 3)
(fact-iter (* 120 3) (- 3 1))
(fact-iter 360 5)
(fact-iter (* 360 2) (- 2 1))
(fact-iter 720 1)
(fact-iter (* 720 1) (- 1 1))
(fact-iter 720 0)
720
```

