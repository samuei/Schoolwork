; Samuel Lamb
; 2118080
#lang eopl
(display "Samuel Lamb")(newline)
(display "2118080")(newline)
(require srfi/1)
; I know this stuff is in a jumbled, terrifying order, so good luck.
(define (minus n)(- 0 n))
(define (add1 n)(+ 1 n))
(define proc? procedure?)
(define(empty-env)'())
(define(newrefs l)(map newref l))
(define (setrefs! locs vals)(map setref! locs vals))

(define scanner-spec
  '((white-sp (whitespace) skip)
    (comment ("%" (arbno (not #\newline))) skip)
    (symbol (letter(arbno(or letter digit))) symbol)
    (number (digit(arbno digit)) number)
    (number ("-" digit(arbno digit)) number)
    ))

(define grammar
  '((program(expression)a-program)
    (expression(number)const-exp)
    (expression(symbol)var-exp)
    (expression("proc" "(" (separated-list symbol ",") ")" expression)proc-exp)
    (expression("dy-proc" "(" (separated-list symbol ",") ")" expression)dy-proc-exp)
    (expression("(" expression (arbno expression) ")")app-exp)
    (expression(primitive "("(separated-list expression ",") ")")primapp-exp)
    (expression ("begin" expression (arbno ";" expression) "end") begin-exp)
    (expression ("set" symbol "=" expression) varassign-exp)
    (primitive("add1") add1-prim)
    (primitive("minus")minus-prim)
    (primitive("+") +-prim)
    (primitive("-") --prim)
    (primitive("*") *-prim)
    (primitive("/") /-prim)
    (primitive("^") ^-prim)
    (primitive("=") =-prim)
    (primitive("proc?")proc-prim)
    (primitive("equal?")equal-prim)
    (primitive("zero?")zero-prim)
    (primitive("less?")less-prim)
    (primitive("greater?")greater-prim)
    (primitive("number?")number-prim)
    (primitive("bool?")bool-prim)
    (primitive ("ref?") ref?-prim)
    (primitive ("newref") newref-prim)
    (primitive ("deref") deref-prim)
    (primitive ("setref") setref-prim)
    (primitive("pair?") pair?-prim)
    (primitive("cons") cons-prim)
    (primitive("car") car-prim)
    (primitive("cdr") cdr-prim)
    (primitive("setcar!") setcar!-prim)
    (primitive("setcdr!") setcdr!-prim)
    (primitive("array?") array?-prim)
    (primitive("newarray") newarray-prim)
    (primitive("arrayref") arrayref-prim)
    (primitive("arrayset") arrayset-prim)
    (primitive("arraylength") arraylength-prim)
    (primitive("array") array-prim) 
    (expression("if" expression "then" expression "else" expression)if-exp)
    (expression("let" (arbno symbol "=" expression) "in" expression)let-exp)
    (expression("letrec" (arbno symbol "(" (separated-list symbol ",") ")" "=" expression) "in" expression)letrec-exp)
    ))

(sllgen:make-define-datatypes scanner-spec grammar)
(define string-parser(sllgen:make-string-parser scanner-spec grammar))
(define(value-of-program p)(cases program p(a-program(x)(value-of x (init-env)))))

(define(apply-env e v)
  (cond((null? e)(eopl:error 'enviro "No env!"))
       ((pair? e)
        (let((vars (caar e)) (vals (cdar e))(env (cdr e)))
          (if(memq v vars)
             (list-ref vals(-(length vars)(length(memq v vars))))
             (apply-env env v))))
       ))

(define(extend-env vars vals e)(cons(cons vars vals)e))
(define (extend-env-rec  vars bound-vars bodies env)
  (let* ((l (newrefs vars)))
    (define new-env (extend-env vars l env))
    (setrefs! l(map(lambda(bvs b)(procedure bvs b new-env)) bound-vars bodies))
    new-env))

(define (environment? x)(or (pair? x)(null? x)))
(define(init-env)(extend-env '(e i pi)(newrefs(list (exp 1) +i 3.14))(empty-env)))

(define(value-of x e)
  (cases expression x
    (const-exp(n)n)
    (var-exp(id)(BY-NEED(apply-env e id)))
    (dy-proc-exp(ids body) (dy-procedure ids body e))
    (proc-exp(ids body) (procedure ids body e))
    (app-exp(rator rands) (apply((value-of rator e)e) (NORMAL-REF-value-of-list rands e)))
    (primapp-exp(rator operand)
                  (apply(evalprim rator)(value-of-list operand e)))
    (if-exp(t l r)(if(value-of t e)(value-of l e)(value-of r e)))    
    (let-exp(ids exps body) (apply((procedure ids body e)e) (newrefs(value-of-list exps e))))
    (letrec-exp (fid id fbody body)
                (value-of body (extend-env-rec fid id fbody e)))
    (begin-exp(x l) (value-of-sequence(cons x l)e))
    (varassign-exp(v x) (begin(setref!(apply-env e v)(value-of x e))1))
    ))

(define(REF-value-of-list l e)(map(lambda(x)(REF-value-of x e))l))
(define(NORMAL-REF-value-of-list l e)(map(lambda(x)(NORMAL-REF-value-of x e))l))
(define(NORMAL-REF-value-of x e)
  (cases expression x
    (var-exp(v)(apply-env e v))
    (primapp-exp (prim operand) (cases primitive prim
                                  (arrayref-prim () (apply  (lambda (a i) (list-ref a i)) (value-of-list operand e)))
                                  (else (newref (a-thunk x e)))))
    (else (newref(a-thunk x e)))
    ))

(define-datatype thunk thunk? (a-thunk(exp expression?)(env environment?)))
(define(value-of-thunk th) (cases thunk th(a-thunk(x e)(value-of x e))))

(define (BY-NAME r)
  (let((x (deref r))) (if(thunk? x)
                         (value-of-thunk x)
                         x)))
(define (BY-NEED r)
  (let((x(deref r)))(if(thunk? x)
                       (let((val(value-of-thunk x)))(setref! r val) val)
                       x)))
(define(REF-value-of x e)
  (cases expression x
    (var-exp(v)(apply-env e v))
    (else (newref(value-of x e)))))

(define(value-of-list l e)(map(lambda(x)(value-of x e))l))
(define(value-of-sequence l e)
  (if(pair?(cdr l))
     (begin (value-of(car l)e)(value-of-sequence(cdr l)e))
     (value-of(car l)e)))

(define (procedure ids body e)
  (lambda(ee)(lambda vals(value-of body(extend-env ids vals e)))
    ))

(define (dy-procedure ids body e)
  (lambda(de)(lambda vals(value-of body(extend-env ids vals de)))
    ))
(define reference? vector?)
(define newref vector)
(define(deref c) (vector-ref c 0))
(define(setref! c x)(vector-set! c 0 x))

(define(evalprim x)(cases primitive x
                     (+-prim() +)
                     (*-prim() *)
                     (--prim() -)
                     (/-prim() /)
                     (=-prim() =)
                     (add1-prim() add1)
                     (minus-prim() minus)
                     (zero-prim() zero?)
                     (equal-prim() equal?)
                     (less-prim() <)
                     (greater-prim() >)
                     (number-prim() number?)
                     (bool-prim() boolean?)
                     (proc-prim() proc?)
                     (^-prim() expt)
                     (ref?-prim() reference?)
                     (newref-prim() newref)
                     (deref-prim() deref)
                     (setref-prim() setref!)
                     (pair?-prim() (lambda(p)(and(pair? p)(reference?(car p))(reference?(cdr p)))))
                     (cons-prim() (lambda(x y)(cons(newref x)(newref y))))
                     (car-prim() (lambda(p)(deref(car p))))
                     (cdr-prim() (lambda(p)(deref(cdr p))))
                     (setcar!-prim() (lambda(p x)(setref!(car p)x)))
                     (setcdr!-prim() (lambda(p x)(setref!(cdr p)x)))
                     (newarray-prim() (lambda l(map newref(make-list(car l) (if(pair?(cdr l))(cadr l)0)))))
                     (array?-prim() (lambda(p)(and(list? p)(andmap reference? p))))
                     (arraylength-prim() (lambda(p) (length p)))
                     (array-prim() (lambda(l) (newrefs l)))
                     (arrayref-prim() (lambda(p i) (deref (list-ref p i))))
                     (arrayset-prim() (lambda(p i v) (setref!(list-ref p i) v)))
                     (else(eopl:error 'evalprim "Err: No Primitive"))
                     ))

(define (andmap p l) (if(pair? p) (and(p(car l))(andmap p(cdr l)))#T))

(define(run s)(value-of-program(string-parser s)))

; TEST CASES:
(display "L1, pg 14: ")
(display (run "let a = newarray(2,0)
         p = proc(x) let v = arrayref(x,1)
         in arrayset(x,1,add1(v))
         in begin arrayset(a,1,0);
         (p a);
         (p a);
         arrayref(a,1)
         end"
              ))

(newline)
(display "L2, pg 3: ")
(display (run "let x = 0
         in letrec
         even () = if zero?(x) then 1
         else begin set x = -(x,1) ; (odd) end
         odd () = if zero?(x) then 0
         else begin set x = -(x,1) ; (even) end
         in begin set x = 13 ; (odd) end"
              ))

(newline)
(display "L2, pg 4: ")
(display (run "let g = let count = 0
         in proc() begin set count = +(count,1)
         ;count end
         in -((g),(g))"
              ))

(newline)
(display "2.(b): ")
(display (run "letrec fib(n) = if zero?(n) then 0 else if =(n,1) then 1 else +((fib -(n,1)),(fib -(n,2)))
         in begin set fib = proc(n) let sq5 = ^(5, /(1,2)) in /(-(^(/(+(1,sq5),2),n),^(/(-(1,sq5),2),n)),sq5)
         ; (fib 6) end"
              ))

(newline)
(display "L3, pg 4: ")
(display (run "let a = 33
         b = 44
         swap = proc(x,y) let temp=x
         in begin set x = y ;
         set y = temp end
         in begin (swap a b) ; -(a,b) end"
              ))

(newline)
(display "L3, pg 11: ")
(display (run "let swap = proc(x,y) let temp = x
         in begin set x = y ; set y = temp end
         a = newarray(2,0)
         in begin arrayset(a,0,33);
         arrayset(a,1,44);
         (swap arrayref(a,0) arrayref(a,1));
         -(arrayref(a,0),arrayref(a,1))
         end"
              ))

(newline)
(display "L3, pg 3: ")
(display (run "let a = 3
         p = proc(x) set x = 4
         in begin (p a) ; a end"
              ))

(newline)
(display "L3, pg 5: ")
(display (run "(proc(t,u,v,w)
         (proc(a,b)
         (proc(x,y,z) set y=13
         a b 6)
         3 v)
         5 6 7 8)"
              ))

(newline)
(display "L4, pg 2: ")
(display (run "letrec infiniteloop(x) = (infiniteloop -(x,-1))
         in let f = proc(z) 11
         in (f (infiniteloop 0))"
              ))

(newline)
(display "L4, pg 4: ")
(display (run "let Y = proc(f) (proc(h)(h h) proc(g)(f (g g)))
         in let fact = (Y proc(f) proc(n) if zero?(n) then 1
         else *(n,(f -(n,1))))
         in (fact 5)"
              ))

(newline)
(display "4. (c): ")
(display (run "let g = let count = 0 in proc () begin set count = +(count,1) ; count end in (proc(x) +(x,x) (g))"))
