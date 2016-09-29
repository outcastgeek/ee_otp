(defmodule maths
  ;(export (sum 2) (diff 2))
  (export all))

(include-lib "clj/include/seq.lfe")
;; (include-lib "clj/include/compose.lfe")
;; (include-lib "clj/include/predicates.lfe")

(defun sum (a b)
  "Addition"
  (+ a b))

(defun diff (a b)
  "Substraction"
  (- a b))

(defun gen-seq (low high)
  "Creates Bound Sequence from High Low"
  (clj-seq:seq low high))

;; (defun do-seq-comp (num)
;;   "Does a bunch of computations from input number"
;;   (->> (clj-seq:seq 42)
;;                 (lists:map (lambda (x) (math:pow x 2)))
;;                 (lists:filter (clj-comp:compose #'clj-p:even?/1 #'round/1))
;;                 (clj-seq:take 10)
;;                 (lists:foldl #'+/2 0)))
