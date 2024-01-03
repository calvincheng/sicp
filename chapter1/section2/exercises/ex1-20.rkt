#lang sicp

; Exercise 1.20

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

; Normal order
(gcd 206 40)

(if (= 40 0)
  206
  (gcd
    40
    (remainder 206 40)))

(gcd
  40
  (remainder 206 40))

(if (= (remainder 206 40) 0)
  40
  (gcd
    (remainder 206 40)
    (remainder 40 (remainder 206 40))))

; 1 evaluated for the condition

(if (= 6 0)
  40
  (gcd
    (remainder 206 40)
    (remainder 40 (remainder 206 40))))

(gcd
  (remainder 206 40)
  (remainder 40 (remainder 206 40)))

(if (= (remainder 40 (remainder 206 40)) 0)
  (remainder 40 (remainder 206 40))
  (gcd
    (remainder 40 (remainder 206 40))
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

; 2 evaluated for the condition

(if (= 4 0)
  (remainder 40 (remainder 206 40))
  (gcd
    (remainder 40 (remainder 206 40))
    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

(gcd
  (remainder 40 (remainder 206 40))
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
  (remainder 40 (remainder 206 40))
  (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
       (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))

; 4 evaluated for the condition

(if (= 2 0)
  (remainder 40 (remainder 206 40))
  (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
       (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))

(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
     (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

(if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
  (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
       (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))

; 7 evaluated for the condition

(if (= 0 0)
  (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
  (gcd (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
       (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))

(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))

; 4 evaluated for the consequent

2

; Total = 1 + 2 + 4 + 7 + 4 = 18 times


(gcd 206 40)

(if (= 40 0)
  206
  (gcd
    40
    (remainder 206 40)))

(gcd 40 (remainder 206 40))

; Evaluated 1 time

(gcd 40 6)

(if (= 6 0)
  40
  (gcd
    6
    (remainder 40 6)))

(gcd 6 (remainder 40 6))

; Evaluated 1 time

(gcd 6 4)

(if (= 4 0)
  6
  (gcd 4 (remainder 6 4)))

(gcd 4 (remainder 6 4))

; Evaluated 1 time

(gcd 4 2)

(if (= 2 0)
  4
  (gcd 2 (remainder 4 2)))

(gcd 2 (remainder 4 2))

; Evaluated 1 time

(gcd 2 0)

(if (= 0 0)
  2
  (gcd 0 (remainder 2 0)))

2

; Total = 1 + 1 + 1 + 1 = 4 times

; Moral of the story:
; https://stackoverflow.com/a/62322932
