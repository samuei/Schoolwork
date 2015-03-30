#lang eopl
;Samuel Lamb
;2118080

(define (add1 x)(+ 1 x))
(define (minus x)(- x))

(define-datatype expression expression?
  (var-exp (var symbol?))
  (lambda-exp (bound-var (list-of symbol?))
              (body expression?))
  (app-exp (rator expression?)
           (rands (list-of expression?)))
  (const-exp (id number?))
  (primapp (primitive prim?)
           (rands (list-of expression?))))

(define-datatype Prim prim?
  (addprim)
  (multprim)
  (subtprim)
  (incrprim)
  (negprim)
  (divprim))

(define (empty-env) '())

(define (extend-env vars vals env)
  (cons (cons vars vals) env))

(define (apply-env e v)
  (cond ((null? e) (write (list e 'is 'unbound)))
        ((pair? e)
         (let ((vars (caar e)) (vals (cdar e))(env (cdr e)))
           (if (memq v vars)
               (list-ref vals(-(length vars)(length(memq v vars))))
               (apply-env env v))))))

(define (value-of x e)
  (cases expression x
    (var-exp(id) (apply-env e id))
    (lambda-exp(ids body) x)
    (app-exp(rator rands) (beta(value-of rator e)
                               (map(lambda(x)(value-of x e))rands)e))
    (const-exp(n) n)
    (primapp(p rands) (apply(evalprim p)
                            (map(lambda(x)(value-of x e))rands)))))

(define (beta rator rands e)
  (cases expression rator
    (lambda-exp(ids body)
               (value-of body(extend-env ids rands e)))
    (else (eopl:error 'beta
                      "error! (operator not a lambda exp)"))))

(define(evalprim p) (cases Prim p
                      (addprim() +)
                      (multprim() *)
                      (subtprim() -)
                      (incrprim() add1)
                      (negprim() minus)
                      (divprim() /)
                      (else (eopl:error 'evalprim "not a primitive"))))

(define (parse-expression x)
  (cond 
    ((number? x) (const-exp x))
    ((symbol? x) (var-exp x))
    ((and (pair? x)(eqv?(car x) 'lambda))
     (lambda-exp(cadr x)(parse-expression(caddr x))))
    ((and (pair? x)(memv(car x) '(+ * - / add1 minus)))
     (primapp(parse-prim (car x))
             (map parse-expression(cdr x))))
    ((pair? x)
     (app-exp (parse-expression(car x))
              (map parse-expression (cdr x))))
    (else (eopl:error 'parse "Invalid concrete syntax ~s" x))))

(define (parse-prim x) 
  (cond
    ((eq? x '+) (addprim))
    ((eq? x '*) (multprim))
    ((eq? x '-) (subtprim))
    ((eq? x '/) (divprim))
    ((eq? x 'add1) (incrprim))
    ((eq? x 'minus) (negprim))))

(display(value-of (parse-expression '((lambda(n)(add1 n))(minus 2))) '()))(newline)
(display(value-of (parse-expression '((lambda(n)(((lambda(n)(lambda(x)(add1 n)))2)10))3)) '())) (newline)
(display(value-of (parse-expression '((lambda(n)(((lambda(n)(lambda(x)(minus n)))2)10))3)) '())) (newline)
(display(value-of (parse-expression '((lambda(x)((lambda(a b c)(+ (* a x x)(* b x) c))1 2 3))10))'())) (newline)
(display(value-of (parse-expression '((lambda(z)((lambda( x y)(+(* 100 z)(* 10 x)(* 1 y)))3 z))4))'())) (newline)
(display(value-of (parse-expression '((lambda(n)(((lambda(n)(lambda(x)(+ n x)))2)1000))3)) '())) (newline)
