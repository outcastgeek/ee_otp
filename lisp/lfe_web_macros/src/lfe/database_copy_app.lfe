#|
@doc
  Public API
@end
|#

(defmodule database_copy_app
  (behaviour application)
  ;;; Application Callbacks
  (export (start 2)
          (stop 1)))

;;; API

(defun start (_type _args)
  (let* ((dispatch (handlers:routes))
         (listen_port (list_to_integer (os:getenv "PORT")))
         (`#(ok ,pid)
          (cowboy:start_clear
           'dbcopy_http_listener
           100
           `(#(ip #(0 0 0 0)) #(port ,listen_port))
           `#m(env #m(dispatch ,dispatch)))
          ))
    (database_copy_sup:start_link)
    ))

(defun stop (_state)
  'ok)

