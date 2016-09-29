#|
@doc
  Public API
@end
|#

(defmodule engine_app
  (behaviour application)

  ;; Application callbacks
  (export (start 2)
          (stop 1)))

;;; API

(defun start (_type _args)
  (engine_sup:start_link))

(defun stop (_state)
  'ok)

