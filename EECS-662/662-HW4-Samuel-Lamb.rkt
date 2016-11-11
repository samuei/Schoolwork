#lang eopl
; Samuel Lamb
; 2118080

(define scanner-spec
  '((white-sp (whitespace) skip)
    (comment ("%" (arbno (not #\newline))) skip)
    (symbol (letter (arbno (or letter digit "-"))) symbol)
    (number (digit (arbno digit)) number)
    (string ("@" (arbno (not #\@))"@") string)
    ))

(define grammar
  '((program(expression) a-program)
    (program("$" statement) a-statement-program)
    (expression(number) const-exp)
    (expression(symbol) var-exp)
    (primitive ("add1") add1-prim)
    (primitive ("minus") minus-prim)
    (primitive ("+") +-prim)
    (primitive ("-") --prim)
    (primitive ("*") *-prim)
    (primitive ("/") /-prim)
    (primitive ("zero?") zero?-prim)
    (primitive ("=") =-prim)
    (primitive (">") >-prim)
    (primitive ("<") <-prim)
    (expression("proc""("(separated-list symbol ",")")" expression) proc-exp)
    (expression("dy-proc""("(separated-list symbol ",")")" expression) dy-proc-exp)
    (expression("("expression(arbno expression) ")")app-exp)
    (expression(primitive"("(separated-list expression ",")")") primapp-exp)
    (expression("if" expression "then" expression "else" expression) if-exp)
    (expression("let" (arbno symbol "=" expression) "in" expression) let-exp)
    (expression("letrec" (arbno symbol "(" ( separated-list symbol "," ) ")" "=" expression) "in" expression) letrec-exp)
    (expression("begin" expression (arbno ";" expression) "end") begin-exp)
    (expression("set" symbol "=" expression) varassign-exp)
    (expression("call/cc" "(" expression ")") call/cc-exp)
    (expression(string) string-const-exp)
    (statement(symbol "=" expression) assign-statement)
    (statement("print" expression) print-statement)
    (statement("{" (separated-list statement ";")"}") compound-statement)
    (statement("if" expression statement statement) if-statement)
    (statement("while" expression statement) while-statement)
    (statement("var" (separated-list symbol ",")";" statement) block-statement)
    (statement("read" symbol) read-statement)
    (primitive ("number?") number?-prim)
    (primitive ("boolean?") boolean?-prim)
    (primitive ("proc?") proc?-prim)
    (primitive ("^") ^-prim)
    (primitive ("ref?") ref?-prim)
    (primitive ("newref") newref-prim)
    (primitive ("deref") deref-prim)
    (primitive ("array?") array?-prim)
    (primitive ("newarray") newarray-prim)
    (primitive ("arrayref") arrayref-prim)
    (primitive ("arrayset") arrayset-prim)
    (primitive ("arraylength") arraylength-prim)
    (primitive ("array") array-prim)
    (primitive ("string?") string?-prim)
    (primitive ("pair?") pair?-prim)
    (primitive ("cons") cons-prim)
    (primitive ("cdr") cdr-prim)
    (primitive ("car") car-prim)
    (primitive ("setref") setref-prim)
    (primitive ("setcar!") setcar!-prim)
    (primitive ("setcdr!") setcdr!-prim)
    (primitive ("newline") newline-prim)
    (primitive ("display") display-prim)
    (primitive ("string-equal?") string-equal?-prim)
    (primitive ("null?") null?-prim)
    (primitive ("null") null-prim)
    ))

(sllgen:make-define-datatypes scanner-spec grammar)
(define-datatype thunk thunk? (a-thunk (exp pair?)(env pair?)))
(define string-parser (sllgen:make-string-parser scanner-spec grammar))
(define stream-parser (sllgen:make-stream-parser scanner-spec grammar))

(define (setrefs! locs vals)(map setref! locs vals))

(define (breaker)(lambda (val)(newline)val))

(define (empty-env) '())
(define (extend-env vars vals e)(cons(cons vars vals)e))
(define (extend-env-rec* vars bound-varss bodies env)
  (let*((l(newrefs vars))
        (new-env(extend-env vars l env)))
    (setrefs! l(map(lambda (bvs b)(procedure bvs b new-env))
                   bound-varss bodies))
    new-env))
(define (apply-env e v)
  (cond((null? e)
        ('error))
       ((pair? e)
        (let((vars(caar e))(vals(cdar e))(env(cdr e)))
          (if(memq v vars)
             (list-ref vals(-(length vars)(length(memq v vars))))
             (apply-env env v))))))
(define (init-env)
  (extend-env
   '(e i pi)
   (newrefs(list (exp 1) +i 3.1415))
   (empty-env)))

(define (every v? l)
  (or(null? l)
     (and(pair? l)(v? (car l))(every v? (cdr l)))))

(define (list-of v?)
  (lambda (l)(every v? l)))

(define proc? procedure?)

(define (procedure ids body e)
  (lambda (K)
    (lambda (dye-e)(lambda vals(value-of body(extend-env ids vals e)K)))
  ))
  
(define (dy-procedure ids body e)
  (lambda (K)
    (lambda (dy-e)(lambda vals(value-of body(extend-env ids vals dy-e)K)))
  ))

(define the-store '())
(define empty-store
  (lambda () '()))
(define get-store
  (lambda () the-store))
(define init-store!
 (lambda () (set! the-store (empty-store))))

(define (value-of-program p)
  (init-store!)
  (cases program p
    (a-program(x)(value-of x(init-env)(breaker)))
    (a-statement-program(s)(execute-statement s(init-env))'done)))

(define reference? vector?)
(define newref vector)
(define (deref c) (vector-ref c 0))
(define (setref! c x) (vector-set! c 0 x))

(define (newrefs l) (map newref l))
(define (derefs l) (map deref l))

(define (REF-value-of-list l e)(map(lambda (x)(REF-value-of x e))l))
(define (REF-value-of x e)
  (cases expression x
    (var-exp(v)(apply-env e v))
    (primapp-exp(f l)
                (cases primitive f
                  (arrayref-prim()
                                (list-ref(value-of(car l)e)
                                         (value-of(cadr l)e)))
                  (else(newref(value-of x e)))))
    (else(newref(value-of x e)))))

(define (value-of-thunk th)(cases thunk th(a-thunk(x e)(value-of x e))))

; I'm still only about 45% sure what is even happening here.
(define (NORMAL-REF-value-of-list l e)(map(lambda (x)(NORMAL-REF-value-of x e))l))
(define (NORMAL-REF-value-of x e)
  (cases expression x
    (var-exp(v)(apply e v))
    (primapp-exp(f l)
                (cases primitive f
                  (arrayref-prim()(list-ref(value-of(car l)e)
                                           (value-of(cadr l)e)))
                  (else(newref(a-thunk x e)))))
    (else(newref(a-thunk x e)))))
(define (BY-NEED r)
  (let((x(deref r)))(if(thunk? x)
                       (let((val(value-of-thunk x)))(setref! r val) val)
                       x)))

(define (execute-statement s e)
  (cases statement s
    (assign-statement(v x)(setref!(apply-env e v)(value-of x e)))
    (print-statement (x)(display (value-of x e)))
    (compound-statement (L)(for-each(lambda (s)(execute-statement s e))L))
    (if-statement (p L r)
                 (if(value-of p e) (execute-statement L e) (execute-statement r e)))
    (while-statement (x s)(let loop ()(if (value-of x e)
                                       (begin (execute-statement s e))(loop))))
    (block-statement (vars s)
                    (execute-statement s(extend-env vars (newrefs(map (lambda (v)0) vars)) e)))
    (read-statement (v)(setref!(apply-env e v)(read)))
    ))

(define (RacketK->closure K)
  (lambda (unusedK)(lambda (dy-e)(lambda l(apply K(derefs l))))))

(define (value-of x e K)
  (cases expression x
    (const-exp(n)(K n))
    (var-exp(id)(K(deref(apply-env e id))))
    (proc-exp(ids body)(K (procedure ids body e)))
    (dy-proc-exp(ids body)(K(dy-procedure ids body e)))
    (app-exp(f l)(value-of f e(lambda (fval)(value-of-list l e (lambda (vals)(apply((fval K)e)(newrefs vals)))))))
    (primapp-exp(f l)(value-of-list l e(lambda (vals)(K(apply(value-of-prim f)vals)))))
    (if-exp(t l r)(value-of t e(lambda (val)(value-of(if val l r)e K))))
    (let-exp(ids exps body)
            (value-of-list exps e(lambda (vals)(apply(((procedure ids body e)K)e)(newrefs vals)))))
    (letrec-exp (fids idss bodies body)(value-of body(extend-env-rec* fids idss bodies e)K))
    (begin-exp(x l)(value-of-sequence (cons x l)e K))
    (varassign-exp(v x)(value-of x e(lambda (val)(K(begin(setref! (apply-env e v) val) val)) )))
    (call/cc-exp(x)(value-of x e (lambda (fval)
                                  (apply ((fval K)e)
                                        (list (newref (RacketK->closure K))) ) )))
    (string-const-exp(s)(K (substring s 1 (- (string-length s)1))))
    ))

(define (value-of-list l e K)(mapk(lambda (x K)(value-of x e K))l K))
(define (mapk f l K)
  (if(pair? l)
     (f (car l)(lambda (val) (mapk f(cdr l) (lambda (vals) (K (cons val vals)))))) (K l) ))
(define (value-of-prim p)(cases primitive p
                               (add1-prim() (lambda (x) (+ x 1)))
                               (minus-prim() (lambda (x) (- x)))
                               (+-prim() +)
                               (--prim() -)
                               (*-prim() *)
                               (/-prim() /)
                               (zero?-prim() zero?)
                               (=-prim() eq?)
                               (>-prim() >)
                               (<-prim() <)
                               (^-prim() expt)
                               (number?-prim() number?)
                               (boolean?-prim() (lambda (x) (if (or (eq? x #t)(eq? x #f)) #t #f)))
                               (proc?-prim() proc?)
                               (ref?-prim() reference?)
                               (newref-prim() newref)
                               (deref-prim() deref)
                               (setref-prim() setref!)
                               (array?-prim() (lambda (a) (and (list? a) (andmap reference? a))))
                               (newarray-prim() (lambda l (map newrefs (make-list(car l)(if (pair? (cdr l)) (cadr l)0)))))
                               (arrayref-prim() (lambda (l r) (deref (list-ref l r))))
                               (arrayset-prim() (lambda (l r x) (setref!(list-ref l r)x)))
                               (arraylength-prim() (lambda (l) (length l)))
                               (array-prim() (lambda l (newrefs l)))
                               (newline-prim() newline)
                               (display-prim() display)
                               (string?-prim() string?)
                               (null?-prim() null?)
                               (null-prim() (lambda () '()))
                               (pair?-prim() (lambda (p)(and(pair? p) (reference?(car p))(reference?(cdr p)))))
                               (cons-prim() (lambda (x y) (cons(newref x) (newref y))))
                               (cdr-prim() (lambda (p)(deref (cdr p))))
                               (car-prim() (lambda (p)(deref (car p))))
                               (setcar!-prim() (lambda (p x) (setref! (car p)x)))
                               (setcdr!-prim() (lambda (p x) (setref! (cdr p)x)))
                               (string-equal?-prim() string=?)))

(define (andmap p l)(if (pair? p)(and (p (car l))(andmap p (cdr l)))#t))
(define (make-list n filler)(if(<= n 0)'()(cons filler (make-list (- n 1)filler))))

(define (value-of-sequence l e K)
  (if(pair? (cdr l))
     (value-of (car l)e(lambda (ignore)(value-of-sequence (cdr l)e K)))(value-of (car l)e K)))

(define (run s) (value-of-program (string-parser s)))

(display "1. ")
(display (run "letrec fact-iter-acc(n,a) = if zero? (n) then a else (fact-iter-acc -(n,1) *(a,n))
             fact-iter(n) = (fact-iter-acc n 1)
             in (fact-iter 3)"))
(newline)(newline)

(display "2. ") 
(display (run "car(cdr(cons(1,cons(2,cons(3,null() ))) ))"))
(newline)(newline)

(display "3.") 
(display (run "letrec foreach(p,l) = if pair?(l) then begin(p car(l)); 
    (foreach p cdr(l)) end else null()
    in let first-neg = proc(l) call/cc (proc(K)(foreach proc(x) if <(x,0) then (K x) else zero?(1) l) )
        in cons( (first-neg cons(54,cons(0,cons(37,cons(minus(3),cons(245,cons(19,null()))))))),
                 (first-neg cons(54,cons(0,cons(37,cons( 3,cons(245,cons(19,null()))))))) )"))
(newline)(newline)

(display "4. ") 
(display (run "let x = @Mickey Mouse@ in x"))
(newline)(newline)

(display "5. ") 
(display (run "letrec raise(m) = m
           try-func(handler,thunk)
                 = let old-raise = raise
                   in call/cc(proc (K) begin set raise=proc (m) begin set raise=old-raise;
                   (K (handler m)) end;
                   let x=(thunk) in begin set raise=old-raise;
                   x end end)
        fact(n) = (try-func proc(m)(raise @arg given to fact is not 0 or a positive integer@)
                         proc() letrec fac(n) = if <(n,0) then (raise @arg given to fac is negative@)
                                  else if =(n,0) then 1 else *(n,(fac -(n,1)))
                              in (fac n))
        twofact(n) = (try-func proc(m)(raise @arg given to twofact is probably not an even int@)
                         proc() + ((fact n),(fact/(n,2))))
        in cons((fact 6),cons((fact/(3,2)),cons((twofact 4),cons((twofact 3),null()))))"))
(newline)(newline)

(display "6.")
; As with most things, this is easier in Python:
; j = 1
; while (1):
;      print '*'*j
;      j+=1
(display (run "let
         yin = (proc(x) begin newline() ; x end call/cc(proc(x) call/cc(x)))
         yang = (proc(x) begin display(@*@) ; x end call/cc(proc(x) call/cc(x)))
          in (yin yang)"))
