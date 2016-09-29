#|
@doc
  cowboy-coding top level supervisor
@end
|#

(defmodule lfe_cowboy_sup
  (behaviour supervisor)

  ;; API
  (export (start_link 0))

  ;; Supervisor callbacks
  (export (init 1)))

;;; API functions

(defun server-name ()
  'lfe_cowboy_sup)

(defun start_link ()
  (supervisor:start_link
    `#(local ,(server-name)) (MODULE) '()))

;;; Supervisor callbacks

(defun init (_args)
  `#(ok #(#(one_for_one 1 5) ())))

;;; Internal functions
