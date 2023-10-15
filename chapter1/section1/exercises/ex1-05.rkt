#lang sicp

; Exercise 1.5

(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

; (test 0 (p)) ; Running this will result in an infinite-loop.
               ; Uncomment and run to try.

/opt/homebrew/bin/raco: Unrecognized command: fmt

Usage: raco <command> <option> ... <arg> ...

Frequently used commands:
  docs                 search and view documentation
  make                 compile source to bytecode
  setup                install and build libraries and documentation
  pkg                  manage packages
  exe                  create executable
  test                 run tests associated with files/directories

A command can be specified by an unambiguous prefix.
See `raco help' for a complete list of commands.
See `raco help <command>' for help on a command.
; forever.

; In applicative-order evaluation, the interpreter will eagerly evaluate the
; operator `test` as well as the operands `0` and `p`. But because p evalutes to
; itself, the expansion will never complete and the interpreter will be stuck in
; an infinite loop.
; 
; ```scheme
; (test 0 (p))
; (test 0 (p))
; (test 0 (p))
; ; ...
; ```
;
; In normal-order evaluation, expressions are more lazily evaluated. By expanding
; everything first before evaluating, the special form `if` can be used and its 
; condition `(= 0 0)` can be evaluated. Because the condition returns true, we 
; can return the consequent expression (0) directly without needing to evaluate 
; (p).

; ```scheme
; (test 0 (p))
; (if (= 0 0) 0 (p))
; ; 0
; ```
