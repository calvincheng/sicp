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

---

The square root of some number `x` is defined as a positive number `y` where `y`
squared equals `x`. However, this definition of what a square root is doesn't
help us understand how to calculate it. Sometimes, we also want to know how to
calculate it. This is the difference between declarative (what is) knowledge and
imperative (how to) knowledge.

One way of calculating the square root is to use the Newton-Raphson method.

```scheme
(define (sqrt x)
  (sqrt-iter 1.0 x)) ; Always guess from 1.0

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
    guess
    (square-iter (improve guess x) x)))

(define (good-enough? guess x)
  (define tolerance 0.001)
  (< (abs (- (square guess) x)) tolerance))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))
```

Several things to note here. Firstly, `sqrt-iter` is recursive (i.e. it
references itself in its definition).

Secondly, `sqrt` can be decomposed into a number of subproblems (how to average
tow numbers, how to improve a guess, etc.).

```
sqrt
|_ sqrt-iter
  |_ good-enough?
    |_ square
    |_ abs
  |_ improve
    |_ average
```

This highlights the _modularity_ of the procedure, each subproblem or module's
role is tightly defined, along with its inputs and outputs. For example,
`square` is to take in a number, multiply it by itself, and return the result,
which is in turn also another number.

This allows us to abstract away the details of the implementation, such that
each module effectively acts as a black-box. We don't care how it works, we just
need to know that it does.[^1] By doing so, we can suppress detail and allow
ourselves to tackle complex ideas more freely.

Modules acting as black-boxes also imply that they bind some variables in their
scope:

```scheme
(define (square x) (* x x))
(define (double x) (+ x x)) ; The `x` here is unrelated to the `x` in `square`
```

In the above, `x` is a bound variable (to each of their methods `square` and
`double`) and other parameters such as `+` or `*` are free varaibles.

There's final thing to improve here, to make our implementation of `sqrt` more
"black-boxy". Note how currently, our subprocedures such as `good-enough?` are
defined globally. This is a bit of an abstraction leak, as other unrelated
procedures would be able to call them, even though they were implemented solely
for helping us calculate `sqrt`.

To fix this, we can nest the definitions inside `sqrt` so that they are only
available to that procedure:

```scheme
(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))
```

Taking things a step further, we can observe that `x` is already bound by `sqrt`
within its scope, and is therefore also available for all its internal
subprocedures. Therefore, the subprocedures can just refer to `x` directly in
its scope without requiring it to be explicitly passed by its caller.

```scheme
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
```

---

[^1]: Taking performance into consideration though, some implementations _are_
    better (e.g. more time or memory-efficient) than others.
