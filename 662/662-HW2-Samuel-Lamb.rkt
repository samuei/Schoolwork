; Samuel Lamb
; 2118080
#lang eopl

(define (add1 x)(+ 1 x))

(define (value-of-primitive p)(cases primitive p
                                (subtract-prim() -)
                                (zero?-prim() zero?)
                                (mult-prim() *)
                                (add-prim() +)
                                (div-prim() /)
                                (equal?-prim() equal?)
                                (<-prim() <)
                                (>-prim() >)
                                (^-prim() expt)
                                (proc?-prim() procedure?)
                                (add1-prim() add1)
                                (num?-prim() number?)
                                (bool?-prim() boolean?)))

; Scanner spec defined here
(define scanner-spec
  '((white-sp (whitespace)                         skip)
    (comment ("%"(arbno (not #\newline)))          skip)
    (identifier (letter (arbno (or letter digit))) symbol)
    (number (digit (arbno digit))                  number)))

; Grammar defined here
(define grammar
  '((program(expression)a-program)
    (expression(identifier)var-exp)
    (expression(number)const-exp)
    (expression("proc" "(" (separated-list identifier ",") ")" expression)proc-exp)
    (expression("dy-proc" "(" (separated-list identifier ",") ")" expression)dy-proc-exp)
    (expression("(" expression (arbno expression)")")call-exp)
    (expression(primitive "("(separated-list expression ",")")")primapp-exp)
    (expression("if" expression "then" expression "else" expression)if-exp)
    (expression("let" (arbno identifier "=" expression) "in" expression)let-exp)
    (expression("letrec"
                (arbno identifier "(" (separated-list identifier ",") ")" "=" expression )
                "in" expression)letrec-exp)
    (primitive("-")subtract-prim)
    (primitive("zero?")zero?-prim)
    (primitive("*")mult-prim)
    (primitive("+")add-prim)
    (primitive("/")div-prim)
    (primitive("equal?")equal?-prim)
    (primitive("<")<-prim)
    (primitive(">")>-prim)
    (primitive("^")^-prim)
    (primitive("proc?")proc?-prim)
    (primitive("minus")subtract-prim)
    (primitive("number?")num?-prim)
    (primitive("boolean?")bool?-prim)
    (primitive("add1")add1-prim)))

(sllgen:make-define-datatypes scanner-spec grammar)

(define string-parser(sllgen:make-string-parser scanner-spec grammar))

(define stream-parser(sllgen:make-stream-parser scanner-spec grammar))

(define(empty-env)(lambda(v)(write (list v 'is 'unbound))))

(define(extend-env* vars vals env)
       (lambda(v)(if(memq v vars)
                    (list-ref vals(-(length vars)(length(memq v vars))))
                    (apply-env env v))))

(define(extend-env-rec* vars bound-varss bodies env)
  (define e(lambda(v) (if(memq v vars)
           (procedure(list-ref bound-varss(-(length vars)(length(memq v vars))))
                     (list-ref bodies(-(length vars)(length(memq v vars))))e)
           (apply-env env v)))) e)

(define(apply-env e v) (e v))

(define(procedure ids body e)
  (lambda(dy-e)
   (lambda vals(value-of body(extend-env* ids vals e)))))

(define(dy-procedure ids body static-e)
  (lambda(dy-e)
    (lambda vals (value-of body(extend-env* ids vals dy-e)))))

(define (value-of-program p)
  (cases program p (a-program(x)(value-of x(init-env)))))
  
; E, I, PI DEFINED HERE
(define(init-env)
  (extend-env*
   '(e i pi) 
   (list (exp 1) +i 3.1415)
   (empty-env)))

(define(value-of x e)(cases expression x
  (const-exp(n) n)
  (var-exp(id)(apply-env e id))
  (proc-exp(ids body)(procedure ids body e))
  (dy-proc-exp(ids body)(dy-procedure ids body e))
  (call-exp(rator rands)(apply((value-of rator e)e)(value-of-list rands e)))
  (primapp-exp(rator rands)
              (apply(value-of-primitive rator)(value-of-list rands e)))
  (if-exp(t l r) (if(value-of t e)(value-of l e)(value-of r e)))
  (let-exp(ids exps body)
          (apply((procedure ids body e)e)(value-of-list exps e)))
  (letrec-exp(fid id body1 body)
             (value-of body(extend-env-rec* fid id body1 e)))))

(define(value-of-list l e)(map(lambda(x)(value-of x e))l))

(define(run s)(value-of-program(string-parser s)))

; Output:
(display (run "^(e,*(i,pi))")) (newline)
(display (run "+(1,2)")) (newline)
(display (run "letrec fac(x) = if zero?(x) then 1 else *(x,(fac -(x,1))) in (fac 5)")) (newline)
(display (run "let fac = proc(g,n) if zero?(n) then 1 else *(n,(g g -(n,1))) in (fac fac 5)")) 
(newline)
(display (run "let Y = proc(ff)(proc(h)(h h) proc(g)(ff proc(x)((g g) x))) in
               let fac = (Y proc(f) proc(n) if zero?(n) then 1 else *(n,(f -(n,1)))) in (fac 5)")) 
(newline)
(display (run "let fact = proc (n) add1(n) in let fact = proc (n) if zero?(n) then 1
else *(n,(fact -(n,1))) in (fact 5)")) (newline)
(display (run "letrec even(x) = if zero?(x) then 1 else (odd -(x,1))
odd(x) = if zero?(x) then 0 else (even -(x,1)) in (odd 13)")) (newline)
(display (run "let a = 3 in let p = proc (x) -(x,a) a = 5
in -(a,(p 2))"))
