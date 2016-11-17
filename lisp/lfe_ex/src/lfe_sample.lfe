(defmodule lfe_sample
  (export (add 2)))

(defun add (x y)
  (+ x y))

; (defmodule lfe_sample
;   (export (test 0)
;           (decode 1)
;           (encode 1)))
;
; (defun test ()
;   (let* ((x (lfe_sample:decode #"{\"people\": [{\"name\": \"Devin Torres\", \"age\": 27}]}"))
;          (y (lfe_sample:encode x)))
;     (io:format "~p~n" (list x))
;     (io:format "~p~n" (list y))))
;
; (defun decode (data)
;   ('Elixir.Poison':'decode!' data))
;
; (defun encode (data)
;   ('Elixir.Poison':'encode!' data))
