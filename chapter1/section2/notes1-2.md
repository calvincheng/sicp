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

### Greatest Common Divisors

Observe that

```
GCD(a, b) = GCD(b, r)
```

where `r` is the remainder if `a` is divided by `b`.

Euclid's algorithm uses this identity to calculate the GCD by applying it
repeatedly to reduce `r` to 0:

```
GCD(206,40) = GCD(40,6)
            = GCD(6,4)
            = GCD(4,2)
            = GCD(2,0) = 2
```

Expressed as a procedure:

```scheme
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

The time complexity of Euclid's algorithm is $O(\log{n})$. This is shown by
Lamé's Theorem:

> If `k` steps are needed to calculate `GCD(a, b)`, then `min(a, b) >= Fib(k)`.

### Testing for prime numbers

#### Iteratively

We can find out if some number `n` is prime by finding its divisors. If `n` is
its own smallest divisor, then it must be prime.

Translating this to a procedure, where we check each number from 2 to `n` to see
if it's the smallest divisor of `n`:

```scheme
(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) ; this condition allows the procedure to be O(sqrt(n))
          n)
        ((divides? test-divisor n)
          test-divisor)
        (else (find-divisor
               n
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))
```

The time complexity of this procedure is `O(sqrt(n))`.

### Probabilistically

According to Fermat's Little Theorem:

> If `n` is a prime number and `a` is any positive integer less than `n`, then
> `a^n` is congruent to `a mod n`.

Congruent means they have the same remainder when divided by `n`. In other
words, `a === a^n (mod n)`.

Knowing this, we can test values of `a`: if all of them satisfy the above
condition, the chances are high that `n` is prime. The more values we test, the
more certain we are. This is called as the Fermat test.

```scheme
(define (fast-prime? n times)
  (cond ((= times 0) #t)
    ((fermat-test n)
      (fast-prime? n (- times 1)))
    (else #f)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

; Compute the exponential of a number modulo another number
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
```

Because the `expmod` procedure uses successful squaring, its time complexity is
$O(\log{n})$.

