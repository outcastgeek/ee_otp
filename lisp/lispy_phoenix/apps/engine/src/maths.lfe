(defmodule maths
  ;(export (sum 2) (diff 2))
  (export all))

(defun sum (a b)
  "Addition"
  (+ a b))

(defun diff (a b)
  "Substraction"
  (- a b))

(defun genseq (low high)
  "Creates Bound Sequence from High Low"
  (lists:seq low high))

(defun doseqcomp (num)
  "Does a bunch of computations from input number"
  (clj:->> (clj:seq 42)
                (lists:map (lambda (x) (math:pow x 2)))
                (lists:filter (clj:comp #'clj:even?/1 #'round/1))
                (clj:take 10)
                (lists:foldl #'+/2 0)))
