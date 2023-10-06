### Section 1.1

> We conjure the spirits of the computer with our spells.

---

A good programming languages can help us manage the complexity of our ideas by
allowing us to combine and abstract primitive things to form bigger ones.

These "things" can be expressions:

```scheme
3 ; a primitive expression
(* 3 2) ; combining expressions
(define x (* 3 2)) ; abstracting compound expressions
```

or even procedures:

```scheme
(* 3 1) ; '*' is a primitive procedure
(define (square x) (* x x)) ; combining procedures and abstracting it as 'square'
```

To imagine how interpreters evaluate procedures, we can apply _the substitution
model_:

> To apply a compound procedure to arguments, evaluate the body of the procedure
> with each formal parameter replaced by the correspoding argument.

```scheme
(define (square x) (* x x))
(square 5)
(* 5 5) ; substitute x with the argument 5
```

---

Evaluation can happen in two different ways, via applicative-order evaluation or
normal-order evaluation. 

Applicative-order means to repeatedly evaluate and apply:

```scheme
(sum-of-squares (+ 5 1) (* 5 2))
(+ (square 6) (square 10))
(+ (* 6 6) (* 10 10))
(+ 36 100)
136
```

With normal-order, we fully expand first and then reduce:

```scheme
(sum-of-squares (+ 5 1) (* 5 2))
(+ (square (+ 5 1)) (square (* 5 2))
(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2))) ; note repeated calculations (e.g. (+ 5 1))
(+ (* 6 6) (* 10 10))
(+ 36 100)
136
```

_Lisp uses applicative-order evaluation._

---

To perform processes depending on some result, we can perform a _case analysis_.

```scheme
(cond ((> x 0) x)      ; clause 1
      ((= x 0) 0)      ; clause 2
      ((< x 0) (- x))) ; clause 3
```

In Lisp, case analyses are done using `cond` followed by a list of clauses. A
clause is composed of a _predicate_ (a procedure or application that returns a
boolean) and a _consequent expression_ (the corresponding value).

Some other forms of the above:

```scheme
(cond ((< x 0) (- x))
      (else x))

(if (< x 0) ; special form
    (- x)
    x)
```

We can treat `else` as a predicate that always returns true such that it will
always return its consequent expression if the other cases above are false.

