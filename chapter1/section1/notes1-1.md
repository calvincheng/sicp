### Section 1.1

> We conjure the spirits of the computer with our spells.

> The contrast between function and procedure is a reflection of the general
> distinction between describing properties of things and describing how to do
> things, or, as it is sometimes referred to, the distinction between
> declarative knowledge and imperative knowledge.

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

_Lisp uses applicative-order evaluation._

With normal-order, we fully expand first and then reduce:

```scheme
(sum-of-squares (+ 5 1) (* 5 2))
(+ (square (+ 5 1)) (square (* 5 2))
(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2))) ; note repeated calculations (e.g. (+ 5 1))
(+ (* 6 6) (* 10 10))
(+ 36 100)
136
```

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

There are other ways of performing case analyses. One of them is with `else`:

```scheme
(cond ((< x 0) (- x))
      (else x))
```

where we can treat `else` as a predicate that always returns true such that it will
always return its consequent expression if the other cases above are false.

Another way is using `if`:

```scheme
(if (< x 0)
    (- x) ; consequent
    x) ; alternative
```

Note that `if` is a special form, as the alternative is only evaluated if the
predicate is false.

---

Predicates can also be combined into compound predicates, often with logical
operators.

```scheme
(and a b c ... z)
(or a b c ... z)
```

where each sub-predicate is lazily evaluated in order (left to right). Because
of this lazy evaluation, `and` and `or` are also special forms.
