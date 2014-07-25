#lang racket
(define (enumerate-interval l h)
  (if (> l h) 
      '() 
      (cons l (enumerate-interval (+ l 1) h))))

(define (iperms s a)
  (if (null? s)
  (list a)
  (append-map (lambda (x) (iperms (remove x s) (cons x a)))s)))

(define (iqueens s a)
  (if (null? s)
      (list a)
      (append-map (lambda(x)
                    (if (diagonal? x a)
                    '()
                    (iqueens (remove x s)(cons x a))))s)))
  
(define (q n)
     (define qout (iqueens (enumerate-interval 1 n) '()))qout)

(define (test n)
   (define testout (map length (map q (enumerate-interval 0 n))))
     testout)
  
(define (diagonal? col a)
  (if (null? a) #f
  (or (diagup? col a 1) (diagdwn? col a 1))))

(define (diagup? col a n)
  (if (null? a) #f
  (if (= (abs (- col (car a))) n) #t
      (diagup? col (cdr a) (+ n 1)))))

(define (diagdwn? col a n)
  (if (null? a) #f
  (if (= (abs (- col (car a))) n) #t
      (diagdwn? col (cdr a) (- n 1)))))

(test 14)