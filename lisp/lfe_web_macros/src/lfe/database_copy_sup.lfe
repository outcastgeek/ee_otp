#|
@doc
  Top level supervisor
@end
|#

(defmodule database_copy_sup
  (behaviour supervisor)
  ;;; Supervisor Callbacks
  (export (start_link 0)
          (init 1)))

;;; API

(defun server-name ()
  'database_copy_sup)

(defun start_link ()
  (supervisor:start_link
   `#(local ,(server-name)) (MODULE) '()))

(defun init (_args)
  `#(ok #(#(one_for_one 10 10) ())))

