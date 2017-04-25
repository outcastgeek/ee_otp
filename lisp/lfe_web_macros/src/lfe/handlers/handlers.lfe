#|
@doc
  Web API
@end
|#

;;; Include Web Macros
(include-file "include/web.lfe")

(defmodule handlers
  (export all))

;;; Generate Routes

(defun routes ()
  "Returns the match spec we will be using for our router"
  (compile-routes
   #("/" hello_handler ())
   #("/alt" alt_handler ())
   #("/json" json_handler ())
   #("/toppage" toppage_handler ())
   #("/copy" echo_json_handler ())
   ))

