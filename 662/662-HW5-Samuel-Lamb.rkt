#lang racket
(require (lib "eopl.ss" "eopl"))

; Samuel Lamb
; 2118080

(define scanner-spec 
  '((white-sp (whitespace) skip)
    (comment ("%" (arbno (not #\newline))) skip)
    (symbol (letter (arbno (or "-" letter digit))) symbol)
    (number (digit (arbno digit)) number)
    (number ("-" digit (arbno digit)) number)
    (string ("@"(arbno (not #\@)) "@")string)
    ))

(define grammar
  '((program (expression) prog)
    (expression (number) const-exp)
    (expression (symbol) var-exp)
    (primitive ("add1") add1-prim)
    (primitive ("minus") minus-prim)
    (primitive ("+") +-prim)
    (primitive ("-") --prim)
    (primitive ("*") *-prim)
    (primitive ("/") /-prim)
    (primitive ("zero?") zero-prim)
    (primitive ("=") =-prim)
    (primitive ("<") <-prim)
    (primitive (">") >-prim)
    (primitive ("^") ^-prim)
    (expression ("proc" "(" (separated-list symbol ":" type ",") ")" expression) proc-exp)
    (expression ("(" expression (arbno expression) ")") app-exp)
    (expression (primitive "(" (separated-list expression ",") ")") prim-exp)
    (expression ("let" (arbno type symbol "=" expression) "in" expression) let-exp)
    (expression ("letrec" 
                 (arbno type symbol "(" (separated-list symbol ":" type ",") ")" "=" 
                        expression) "in" expression) rec-exp)
    (expression ("if" expression "then" expression "else" expression) if-exp) 
    (expression ("set" symbol "=" expression) varassign-exp)
    (expression ("begin" expression (arbno ":" expression) "end") begin-exp)
    (expression ("call" "(" expression (arbno expression) ")") call-exp)
    (primitive ("not") not-prim)
    (primitive ("newline") newline-prim)
    (primitive ("display") display-prim)
    (statement (symbol "=" expression) assignment-statement)
    (statement ("print" expression) print-statement)
    (statement ("{" (separated-list statement ":") "}") list-statement)
    (statement ("if" expression statement statement) if-statement)
    (statement ("while" expression statement) while-statement)
    (statement ("var" (separated-list symbol ",") "" statement) var-statement)
    (type ("int") int-type)
    (type ("bool") bool-type)
    (type ("nothing") no-type)
    (type ("(" (separated-list type "*") "->" type ")") proc-type)
    ))

(define (extend-env vars vals e)(cons (cons vars vals)e))

(define (apply-env e v)
  (cond((null? e)('error))
       ((pair? e)
        (let((vars(caar e))(vals(cdar e))(env(cdr e)))
          (if(memq v vars)(list-ref vals(-(length vars)(length(memq v vars))))
             (apply-env env v))))))

(define (extend-env* vars vals env)
  (cons (cons vars vals) env))

(define (empty-env) '())

(define (init-env) (extend-env* '(e i pi)(newrefs(list (exp 1) +i 3.1415))(empty-env)))

(define (newrefs l) (map newref l))

(define (value-of-statement s e)
  (cases statement s
    (assignment-statement (v x) (begin (setref! (apply-env e v) (value-of x e)) 1))
    (var-statement (v o) 
                   (apply ((lambda (ids body e)
                            (lambda vals (value-of-statement body (extend-env ids vals e)))) v o e) (newrefs (make-list (length v) 0))))
    (if-statement (t l r) (if (value-of t e) (value-of-statement l e) (value-of-statement r e)))
    (print-statement (x) (display (value-of x e)))
    (while-statement (x y) (if (value-of x e) 
                               (begin (value-of-statement y e) (value-of-statement s e))
                               '()))
    (list-statement (x) (begin (map (lambda (y)(value-of-statement y e)) x) (display "")))
    ))

(define (extend-env-rec* vars bound-vars bodies env)
    (cons (cons vars (newrefs (map (lambda (x y) (dy-proc x y env)) bound-vars bodies))) env))

(sllgen:make-define-datatypes scanner-spec grammar)
(define string-parser(sllgen:make-string-parser scanner-spec grammar))

(define reference? vector?)
(define newref vector)
(define (deref c) (vector-ref c 0))
(define (setref! c x) (vector-set! c 0 x))

(define (prim-value-of p)
  (cases primitive p
    (add1-prim () (lambda (n) (+ n 1)))
    (minus-prim () (lambda (n) (- n)))
    (+-prim () +)
    (--prim () -)
    (*-prim () *)
    (/-prim () /)
    (zero-prim () zero?)
    (=-prim () =)
    (<-prim () <)
    (>-prim () >)
    (^-prim () expt)
    (not-prim () not)
    (newline-prim () newline)
    (display-prim () display)
    ))

(define (newarray n f)
  (array apply (make-list n f)))

(define (arrayref a x) (deref (list-ref a x)))
(define (arrayset a x v) (setref! (list-ref a x) v))
(define (arraylength a) (length a))
(define (array . x) (newrefs x))

(define (static-proc id body static-e)
  (lambda (K)
  (lambda (dynamic-e) (lambda val (value-of body(extend-env id val static-e)K)))))

(define (dy-proc id body static-e)
  (lambda (K)
  (lambda (dynamic-e) (lambda val (value-of body(extend-env id val dynamic-e)K)))))

(define (RacketK->closure K)
  (lambda (unusedK)(lambda (dyn-e)(lambda vals (apply K(derefs vals))))))

(define (derefs x)
  (map deref x))

(define (value-of x e K)
  (cases expression x
    (const-exp (n) (K n))
    (var-exp (id) (K(deref(apply-env e id))))
    (proc-exp (id types body) (K(static-proc id body e)))
    (app-exp (rator rand) (value-of rator e (lambda (fval) (value-of-list rand e (lambda (vals)(apply((fval K)e) (newrefs vals)))))))
    (prim-exp (prim rand) (value-of-list rand e (lambda (vals)(K(apply (prim-value-of prim) vals)))))
    (let-exp (types id exp body) (value-of-list exp e(lambda (vals)(apply (((static-proc id body e)K) e) (newrefs vals)))))
    (rec-exp (ftypes id ids typess exp body) (value-of body (extend-env-rec* id ids exp e)K))
    (if-exp (t l r) (value-of t e(lambda (val)(value-of(if val l r)e K))))
    (begin-exp(x l) (value-of-sequence(cons x l) e K))
    (varassign-exp(v x) (value-of x e(lambda (val)(K(begin(setref!(apply-env e v)val)val)))))
    (call-exp(x y)(value-of x e (lambda (fval)(apply((fval K)e)(list (newref(RacketK->closure K)))))))
    ))

(define (value-of-list l e K)(mapk(lambda (x K)(value-of x e K))l K))

(define (value-of-sequence l e K)
  (if (pair?(cdr l))
      (value-of (car l) e(lambda (ignore) (value-of-sequence (cdr l)e K)))
      (value-of (car l) e K)))
                            
(define (REF-value-of-list l e)(map(lambda (x)(REF-value-of x e))l))
(define (REF-value-of x e)(cases expression x (var-exp(v)(apply-env e v)) (else (newref(value-of x e)))))

(define (BY-NEED r)
  (let ((x (deref r))) (if (thunk? x)
                           (let ((val (value-of-thunk x))) (setref! r val) val)
                           x) ))
(define-datatype thunk thunk? (a-thunk (exp expression?) (env list?)))
(define (value-of-thunk th) (cases thunk th(a-thunk(x e) (value-of x e))))

(define (NORMAL-REF-value-of-list l e) (map (lambda (x) (NORMAL-REF-value-of x e)) l))
(define (NORMAL-REF-value-of x e)
  (cases expression x
    (var-exp (v) (apply-env e v))
    (else (newref (a-thunk x e)))))

(define (value-of-program p)
  (cases program p 
    (prog(x)(value-of x(init-env) (end-count)))
    ))

(define (mapk f l K)
  (if(pair? l)
     (f(car l)(lambda (val)(mapk f(cdr l)(lambda (vals)(K(cons val vals))))))(K l)))

(define (end-count)(lambda (val)(eopl:printf "End of computation.~%")val))

(define (type-to-external-form t)
  (define (proc-to-external l r)
    (cond((null? l) `(->, r))
          ((null?(cdr l)) `(,(car l)->, r))
          (else `(,(car l)* ,@(proc-to-external(cdr l)r))) ))
    (cases type t
      (int-type() 'int)
      (bool-type() 'bool)
      (proc-type(args result)(proc-to-external(map type-to-external-form args)(type-to-external-form result)))
      (no-type() 'nothing)
      ))

(define (check-equal-type! t1 t2 x)
  (if(not(equal? t1 t2))
     (report-unequal-types t1 t2 x)
     'dummy))

(define (report-unequal-types t1 t2 x)
  (eopl:error 'check-equal-type!
              "Types didn't match ~s != ~a in ~%~a"
              (type-to-external-form t1)
              (type-to-external-form t2)
              x))

(define (type-apply tf tl f l x)
  (cases type tf
    (proc-type (tfl tfr)
               (if(=(length tfl)(length tl))
                  (begin(for-each check-equal-type! tfl tl l) tfr)
                  (eopl:error `type-apply(string-append "wrong number of args in ~s:" "~%expected ~s%got~s")
                              x(map type-to-external-form tl)(map type-to-external-form tfl)) ))
    (else(eopl:error 'type-apply "Rator not a proc type: ~%~s~% had rator type ~s" f (type-to-external-form tf))) ))

(define (type-of-program p)
  (cases program p
    (prog(x) (type-of x (init-type-env)))))

(define (init-type-env)
  (extend-env* '( e i pi)(list (int-type)(int-type)(int-type))(empty-env)))

(define (type-of x e)
  (cases expression x
    (const-exp (n) (int-type))
    (var-exp (id) (apply-env e id))
    (proc-exp (id types body) (proc-type types(type-of body(extend-env* id types e))))
    (prim-exp (rator rands) (type-apply(type-of-primitive rator)(type-of-list rands e)rator rands x))
    (app-exp(rator rands) (type-apply(type-of rator e)(type-of-list rands e)rator rands x))
    (let-exp (types id exps body) (for-each(lambda (t exp)(check-equal-type! t(type-of exp e) exp)) types exps)(type-of body(extend-env* id types e))) 
    (rec-exp (frestypes fids idss typess bodies letrecbody) 
             (let((rec-env (extend-env* fids
                    (map(lambda (frestype types)(proc-type types frestype))frestypes typess)e)))
               (for-each(lambda (frestype ids types body)
                          (check-equal-type! frestype(type-of body(extend-env* ids types rec-env))body))frestypes idss typess bodies)(type-of letrecbody rec-env)))
    (if-exp (p l r) (let((tp (type-of p e))(tl(type-of l e))(tr(type-of r e)))(check-equal-type! tp(bool-type)p)(check-equal-type! tl tr x) tl))
    (begin-exp(exp1 exps) (letrec ((type-of-begins(lambda (e1 es)(let ((v1 (type-of e1 e)))(if(null? es) v1(type-of-begins (car es)(cdr es))))))) (type-of-begins exp1 exps)))
    (varassign-exp(ids rhs)
                  (check-equal-type! (type-of rhs e)(apply-env e ids)x)(int-type))
    (call-exp(rator rands)(type-apply(type-of rator e)(type-of-list rands e)rator rands x))
    ))

(define (type-of-primitive p)
  (cases primitive p
    (add1-prim () (proc-type(list (int-type))(int-type)))
    (minus-prim () (proc-type(list (int-type))(int-type)))
    (+-prim () (proc-type(list (int-type)(int-type))(int-type)))
    (--prim () (proc-type(list (int-type)(int-type))(int-type)))
    (*-prim () (proc-type(list (int-type)(int-type))(int-type)))
    (/-prim () (proc-type(list (int-type)(int-type))(int-type)))
    (zero-prim () (proc-type(list (int-type))(bool-type)))
    (=-prim () (proc-type(list (int-type)(int-type))(bool-type)))
    (<-prim () (proc-type(list (int-type)(int-type))(bool-type)))
    (>-prim () (proc-type(list (int-type)(int-type))(bool-type)))
    (^-prim () (proc-type(list (int-type)(int-type))(int-type)))
    (not-prim () (proc-type(list (bool-type))(bool-type)))
    (newline-prim () (proc-type '()(no-type)))
    (display-prim () (proc-type '()(no-type)))
    ))
                              
(define (type-of-list l e)
  (map(lambda (x)(type-of x e))l))

(define (type-check l) (type-to-external-form(type-of-program(string-parser l))))

(define (run p)(append (list (type-to-external-form(type-of-program(string-parser p))))(list (value-of-program(string-parser p)))))


; Examples!

(display(type-check "(proc (x:int) +(x,1) 5)"))(newline)
;(display(type-check "(proc (x: int)+(x,1) =(0,0))"))(newline)
;(display(type-check "(proc (x: bool) x 5)"))(newline)
;(display(type-check "(proc (x: bool) +(x,1) zzzz)"))(newline)
(display(type-check "if =(0,1) then 7 else 3"))(newline)
;(display(type-check "if 42 then 7 else 3"))(newline)
;(display(type-check "if =(0,1) then =(0,1) else 3"))(newline)
;(display(type-check "(letrec int fact(x:int)=if zero?(x) then 1 else *(x,fact -(x,1))) in fact 5)"))(newline) 
;(display(run "(7 1 2)"))(newline)
;(display (run "+(1,2,3)"))(newline)
(display (run "+(2,3)")) (newline)
(display(run "let int x=2 in x"))(newline)
(display(run "begin 22: = (1,2) end"))(newline)
(display(run "let bool y ==(1,2) in set y ==(1,1)"))(newline)
(display (run "let (int *int -> int) f = proc (n: int, m: int) +(n,m) in (f 2 3)"))(newline)
(display (run "let (int -> (int -> int)) f = proc (n: int) proc (m: int) +(n,m) in ((f 2)3)"))(newline)(newline)
(display (run "letrec (int -> int) FIX(f:((int -> int) -> (int -> int))) = (f proc (x: int)((FIX f)x))
in let ((int -> int)->(int -> int)) fact-maker = proc (f:(int -> int)) proc (x:int) if zero? (x) then 1 else *(x,(f -(x,1)))
in let (int -> int) fact = (FIX fact-maker) in (fact 5)"))(newline)

#|

This will not work!

(display (run "let (((int -> int) -> (int -> int)) -> (int -> int))
Y = proc (f: ((int -> int) -> (int -> int))) 
(proc (h: ?)(h h) proc (g: ?)(fm proc (x: int)((g g) x)))
in let ((int -> int) -> (int -> int)) fact-maker = proc (f: (int -> int)) proc (x: int) if zero?(x) then else *(x,f -(x,1)))
in let (int -> int) fact = (Y fact-maker)
in (fact 5)"))
|#


