#lang racket
(require racket/class)

(define make-account%
  (class object%
    (super-new) ; Last surviving object% from #lang Krypton...
    (init-field (balance 0))
    (define/public(view) balance)
    (define/public(deposit x) (set! balance (+ balance x)) balance)
    (define/public(withdraw y)
      (if(>= balance y)
          (begin (set! balance (- balance y)) balance)
          "Insufficient funds"))
    )
  )

(define make-accountl%
  (class make-account%
    (super-new) ; With methods and inheritances far beyond those of mortal objects!
    (inherit-field balance)
    (init-field (l (list 'start '= balance)))
    (define/public(show) l)
    (define/override(deposit x) 
      (begin (super deposit x) (set! l (cons l `((+ ,x = ,balance )))) balance))
    (define/override(withdraw x) 
      (begin 
        (define oldbal balance) 
        (super withdraw x) 
        (if (not (= oldbal balance)) 
            (begin (set! l (cons l `((- ,x = ,balance )))) balance) 
            balance)))
    )
  )

(define make-accountlp%
  (class make-accountl%
    (super-new) ; Disguised as 368-3-Samuel-Lamb.rkt, mild-mannered assignment for a great metropolitan EECS course...
    (init-field password 'password)
    (define/override(deposit pass val) (if (pquery pass) (super deposit val) "Incorrect password"))
    (define/override(withdraw pass val) (if (pquery pass) (super withdraw val) "Incorrect password"))
    (define/override(show pass) (if (pquery pass) (super show) "Incorrect password"))
    (define/override(view pass) (if (pquery pass) (super view) "Incorrect password"))
    (define/public(pquery pass)
      (if (eq? pass password) #t #f))
    )
  )

(define make-accountlpa%
  (class make-accountlp%
    (super-new) ; Fights a never-ending battle for OOP, tail-recursion, and the American Way!
    (inherit-field password)
    (init-field (attempts 0))
    (define/override(pquery pass)
      (if (eq? pass password) (begin (set! attempts 0) #t) (begin (set! attempts (+ attempts 1)) #f)))
    (define/override(deposit pass val) 
      ;I decided to err on the side of security:
      ;If the user uses too many attempts, I also lock out the account.
      ;Checking the password before checking the attempts would work, but is less secure.
      (if (> attempts 7) "Cops called."
          (if (pquery pass) 
              (super deposit pass val)
              "Incorrect password"
              )
          )
      )
     (define/override(withdraw pass val)
      (if (> attempts 6) "Cops called." 
          (if (pquery pass)
              (super withdraw pass val)
              "Incorrect password"
              )
          )
      )
    (define/override(show pass)
      (if (> attempts 7) "Cops called."
          (if (pquery pass) 
              (super show pass)
              "Incorrect password"
              )
          )
      )
    (define/override(view pass)
      (if (> attempts 7) "Cops called." 
          (if (pquery pass) 
              (super view pass) 
              "Incorrect password"
              )
          )
      )
    )
  )

(define make-accountlpat%
  (class make-accountlpa%
    (super-new)
    (inherit-field balance)
    (inherit-field password)
    (inherit-field attempts)
    (inherit pquery)
    (inherit withdraw)
    (define/public(transfer passme dest passdest)
      (if (> attempts 7) "Cops called."
          (if (pquery passme)
              ;My earlier security decision makes this a little scary.
              ;If somebody tries and fails to give you money enough times,
              ;your account may get locked.
              ;I'm not sure how to solve that problem without completely
              ;compromising the account's security, so the user will just
              ;have to live with it.
              (if (send dest pquery passdest)
                  (begin
                    (send dest deposit passdest balance)
                    (withdraw passme balance)
                    )
                  "Incorrect password")
              "Incorrect password")
          )
      )
    )
  )

(define make-accountlpats%
  (class make-accountlpat%
    (super-new)
    (inherit-field balance)
    (inherit-field l)
    (inherit-field attempts)
    (inherit pquery)
    (init-field rate)
    (define/public(interest pass)
      (if (> attempts 7) "Cops called."
          (if (pquery pass)
              (begin (set! l (cons l `((+ ,(* balance rate) = ,(* balance (+ 1 rate))))))
                     (set! balance (* balance (+ 1 rate)))
                     balance)
              "Incorrect password.")
          )
      )
    )
  )
              
              

(define acc (new make-account% [balance 100]))
(send acc view)
(send acc withdraw 50)
(send acc withdraw 60)
(send acc deposit 40)
(send acc withdraw 60)
(define acc2 (new make-account%))
(send acc2 deposit 17)

(define accl (new make-accountl% [balance 100]))
(send accl view)
(send accl withdraw 40)
(send accl deposit 55)
(send accl show)

(define acclp (new make-accountlp% [balance 100][password 'secret]))
(send acclp view 'secret)
(send acclp withdraw 'secret 40)
(send acclp deposit 'rosebud 60)
(send acclp show 'secret)
    
(define acclpa(new make-accountlpa% [balance 100][password 'secret]))
(send acclpa withdraw 'secret 60)
(send acclpa withdraw 'rosebud 60)
(send acclpa withdraw 'rosebud 60)
(send acclpa withdraw 'rosebud 60)
(send acclpa withdraw 'rosebud 60)
(send acclpa withdraw 'rosebud 60)
(send acclpa withdraw 'rosebud 60)
(send acclpa withdraw 'rosebud 60)
(send acclpa withdraw 'rosebud 60)

(define from-acc (new make-accountlpat% [balance 300][password 'secret]))
(define to-acc (new make-accountlpat% [balance 200][password 'rosebud]))
(send from-acc transfer 'secret to-acc 'secret)
(send from-acc show 'secret)
(send from-acc transfer 'secret to-acc 'rosebud)
(send from-acc show 'secret)
(send to-acc show 'rosebud)

(define sav
  (new make-accountlpats% [balance 100][password 'rosebud][rate 5/100]))
(send sav interest 'bananas)
(send sav interest 'rosebud)
(send sav deposit 'rosebud 0)