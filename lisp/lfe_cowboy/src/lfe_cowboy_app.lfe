#|
@doc
  Public API
@end
|#

(defmodule lfe_cowboy_app
  (behaviour application)

  ;; Application callbacks
  (export (start 2)
          (stop 1)))

;;; API

(defun start (_type _args)
  (let* ((dispatch (cowboy_router:compile (router-match-spec)))
         (listen_port (list_to_integer (os:getenv "PORT")))
         (`#(ok ,pid)
          (cowboy:start_http
           'lfe_http_listener
           100
           `(#(ip #(0 0 0 0)) #(port ,listen_port))
           `(#(env (#(dispatch ,dispatch)))))))
    (lfe_cowboy_sup:start_link)))

(defun stop (_state)
  'ok)

;;; Internal functions

(defun router-match-spec ()
  "Returns the match spec we will be using for our router"
  '(#(_ (#("/" lfe_cowboy_home_handler ())))))
