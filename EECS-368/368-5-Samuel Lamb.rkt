#lang web-server/insta
(require mzlib/string)
; Be patient when loading. Some of the formatting takes a bit the first time.

(define-namespace-anchor anchor)
(define env (namespace-anchor->namespace anchor))

(struct blog (posts) #:mutable)
(struct post (n var form simplify? result-body point symderiv-at-pt deriv-at-pt))

(define BLOG
  (blog (list (post "2" "x" "(log x)" "#t" "(/ 1 -1 (expt x 2))" "1" "-1" "-0.999999949513608"))))
; An example post is included, because why not?

(define(blog-insert-post! a-blog a-post)
  (set-blog-posts! a-blog(cons a-post (blog-posts a-blog))))
(define(start unusedrequest)
  (render-blog-page unusedrequest))
(define(render-blog-page unusedrequest)
  (define(response-generator make-url)
    (define lastpost (car(blog-posts BLOG)))
    (response/xexpr
     `(html (head(title "368-5-Samuel Lamb"))
            (meta ((name "ROBOTS")(content "NOINDEX,NOFOLLOW")))
            ; Page will not be indexed by search engines, in case you were worried about that.
            (body
             (h1(center"EECS 368 Program 5"))
             (center
              (img
               ((src "https://upload.wikimedia.org/wikipedia/commons/6/6a/Gottfried_Wilhelm_von_Leibniz.jpg"))))
              (center (h2 "Y'all gon' make "
                          (strong (a 
                                   ((href "https://en.wikipedia.org/wiki/Gottfried_Wilhelm_Leibniz#Mathematician")
                                    (title "I'm here to discover derivatives and chew bubblegum..."))
                                                     "Gottfried Leibniz")) " lose his mind"))
              (center (h2 "Up in here"))
              (center (h3 (str "Up in here")))
              (br)
              ; This joke was hilarious before I had to render the page a thousand times to make everything work.
              (center (a ((href "https://en.wikipedia.org/wiki/Differentiation_%28mathematics%29")
                          (title "Well, go find out."))
                         "What IS a derivative?"))
              (br)
              (hr)
              (br)
              (form ((action ,(make-url insert-post-handler)))
                    ; Forms are of equal length (on primary test machine. YMMV) and a nice, pleasant blue
                    (p "variable of differentiation:"(input((name "variable")(style "background-color: #72A4D2;")
                                         (size "22")(value "x"))))
                    (p "formula to derive :"(input((name "formula")(style "background-color: #72A4D2;")
                                          (size "30")(value "(log (+(tan x)(/(cos x))))"))))
                    (p "derive how many times?"(input((name "n-times")(style "background-color: #72A4D2;")
                                                      (size "24")(value "1"))))
                    (p "simplify? " 
                       "yes"(input((name "simplify")(type "radio")
                                                  (value "#t")
                                                  (onclick "alert('Smart choice.')")
                                                  ,@(if (read-from-string(post-simplify? lastpost))
                                                        '((checked "yes"))'())))
                       "no"(input((name "simplify")(type "radio")
                                                   (value "#f")
                                                   (onclick "alert('Not suggested for multiple derivatives!')")
                                                   ,@(if (not(read-from-string(post-simplify? lastpost)))
                                                         '((checked "yes"))'()))))
                    ; Simplify buttons offer useful or snarky advice and default to last setting.
                    (p "derive at point            :"(input((name "point")(style "background-color: #72A4D2;")
                                      (size "33")(value "1"))))
                    (p (input((type "submit")))(input((type "reset")))))
                    ; Fields are pre-populated and reset to default
              (br)
              (br)
              ,(render-posts)
              (br)
              (p (font ((size "1"))"What? That's it. We're done, here."))))))
    (define(insert-post-handler request)
      (blog-insert-post! BLOG (process (request-bindings request)))
      (render-blog-page request))
    (send/suspend/dispatch response-generator))

(define(process ans)
  (define(readit field)
    (read-from-string(cdr(assq field ans))))
  (match-define(list var form n simplify? point)
    (map readit '(variable formula n-times simplify point)))
  (let*((qf `(λ(,var),form))(Dqf((if simplify? nth-simplify-sym nth-symderiv)qf n))
                            (Dqf-body(caddr Dqf))
                            (symderiv-at-pt ((eval Dqf env)point))
                            (deriv-at-pt ((nth-deriv(eval qf env)n)point)))
    (apply post(map expr->string
                    (list n var form simplify? Dqf-body point symderiv-at-pt deriv-at-pt)))))

(define(render-post p)
  `(div ((class "post")) 
        (p (b "d" (sup (font ((size "1")),(post-n p))) 
                            "/d" ,(post-var p)(sup (font ((size "1")) ,(post-n p)))) " "
                            ,(post-form p) " = " ,(post-result-body p)) "At " ,(post-point p) ", the symbolic value is "
                                                                      ,(post-symderiv-at-pt p) " and numeric value is "
                                                                      ,(post-deriv-at-pt p) 
                                                                      ". Let's derive some more!" (br)(br) ))

(define (render-posts)
  `(div((class "posts")) ,@(map render-post (blog-posts BLOG))))

(static-files-path (current-directory))
; Shouldn't be necessary, but Professor Brown said to keep it in.


(define(nthcomp a n)
  (if (<= n 0) (λ(a)a)
      (compose a (nthcomp a(- n 1)))))
(define(nth-deriv f n)
  ((nthcomp deriv n)f))
(define(nth-symderiv f n )
  ((nthcomp symderiv n)f))
(define(nth-simplify-sym f n)
  ((nthcomp simplify-sym n)f))
(define(simplify-sym qf)
  `(λ ,(cadr qf) ,(simplify-symat(caadr qf) (caddr qf))))
(define(simplify-symat v e)
  (simplify-eval(symderivat v e)))

;From here down, it's just Program 2 again

(define dx .00000001)
(define (deriv f)
  (lambda (x)
    (/ (- (f (+ x dx)) (f x))
       dx)))
(define (symderiv qf)
  `(λ ,(cadr qf) ,(symderivat(caadr qf)(caddr qf))))

(define (symderivat v x)
  (cond ((symbol? x) (if(eq? v x)1 0))
        ((not(pair? x))0)
        ((not(pair?(cdr x)))0)
        (else (let((f(cadr x)))
                (case (car x)
                  ((+ -) (cons(car x) (map(λ(y)(symderivat v y))(cdr x))))
                  ((*) (cons '+(map(λ(y)`(* ,(symderivat v y) ,@(remv y(cdr x))))(cdr x))))
                  ((/) (if (pair? (cddr x))
                           (symderivat v `(* ,f(/(* ,@(cddr x) ))))
                           `(/ ,(symderivat v f)-1(expt ,f 2))))
                  ((expt) `(* ,x ,(symderivat v `(* ,(caddr x)(log ,f)))))
                  ((exp) (list '* (list 'exp (cadr x)) (car(map (λ(vi)(symderivat v vi))(cdr x)))))
                  ((log) (list '* (list '/ (cadr x)) (car(map (λ(vi)(symderivat v vi))(cdr x)))))
                  ((sin) (list '* (cons 'cos (cdr x)) (car(map (λ(vi)(symderivat v vi))(cdr x)))))
                  ((cos) (list '* (list '- (cons 'sin (cdr x))) (car(map (λ(vi)(symderivat v vi))(cdr x)))))
                  ((tan) (list '* (list '/ (cons '* (list (cons 'cos(cdr x)) 
                                                          (cons 'cos(cdr x))))) 
                               (car(map(λ(vi)(symderivat v vi))(cdr x)))))
                  ((asin)(list '* (list '/ (list 'sqrt (list '- 1 (list 'expt (cadr x) 2))) 
                                        (car(map (λ(vi)(symderivat v vi))(cdr x))))))
                  ((acos)(list '* (list '/ (cons '- (list 'sqrt (list '- 1 (list 'expt 
                                                                                 (cadr x) 2)))) 
                                        (car(map (λ(vi)(symderivat v vi))(cdr x))))))
                  ((atan)(list '*  (list '/ (list '+ (cons 'expt (list (list (cadr x) 2))) 1))
                               (car(map (λ(vi)(symderivat v vi))(cdr x)))))
                  ((abs)(list '* (list '/ (cadr x) 
                                       (cons 'sqrt (list(cons 'expt (list (cadr x) 2)))))
                              (car(map (λ(vi)(symderivat v vi))(cdr x)))))
                  )
                )
              )
        ))

(define(simplify qf) `(λ ,(cadr qf) ,(simplify-eval(caddr qf))))
(define(simplify-eval e)
  (if(pair? e) (simplify-apply(cons(car e)(map simplify-eval(cdr e)))) e))
(define(simplify-apply e)
  (case(car e)
    ((+) (s+ e))
    ((-) (s- e))
    ((*) (s* e))
    ((/) (s/ e))
    (else e)))
(define(s+ x)(let((p (remove* '(0)(cdr x))))
               (case(length p)((0) 0)((1)(car p))(else (cons '+ p)))))
(define(s- x)(if(=(length(cdr x))1)
                (if(equal?(cadr x)0)0 x)
                (if(equal?(cadr x)0)
                   (s+(cons '+(remove* '(0)(cddr x))))
                   (let((p (s+(cons '+(remove* '(0)(cddr x))))))
                     (if(equal? p 0)(cadr x) `(- ,(cadr x),p))))))
(define(s* x)(if(member 0(cdr x))0
                (let((p(remove* '(1)(cdr x))))
                  (case(length p)((0) 1)((1)(car p))(else (cons '* p))))))
(define(s/ x)(if(equal?(cadr x)0)0 x))