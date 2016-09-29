(defmodule lfe_cowboy_home_handler
  (behaviour cowboy_http_handler)
  (export (init 3)
          (handle 2)
          (terminate 3)))

(defun init (_type req opts)
  `#(ok ,req 'no-state))

(defun handle (req state)
  (let ((`#(ok ,res)
         (cowboy_req:reply
          200
          '(#(#"content-type" #"text/plain"))
          #"Hello LFE Cowboy!!"
          req)))
    `#(ok ,req ,state)))

(defun terminate (_reason _req _state)
  'ok)
