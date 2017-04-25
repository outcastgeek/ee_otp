;;; Web Macros on Top of Cowboy 2

(defmodule web
  (export all)
  (export-macros compile-routes defhandler respond))

;; Helper Functions

;; (defun send-content (status headers body)
;;         `#m(
;;             status ,status
;;             headers ,headers
;;             body ,body
;;             ))

;; (defun send-html (body)
;;   (send-content
;;    200
;;    #m(#"content-type" #"text/html; charset=utf-8") body))

;; (defun send-text (body)
;;   (send-content
;;    200
;;    #m(#"content-type" #"text/plain; charset=utf-8") body))

;; (defun send-json (body)
;;   (send-content
;;    200
;;    #m(#"content-type" #"application/json; charset=utf-8") body))

;; (defun send-xml (body)
;;   (send-content
;;    200
;;    #m(#"content-type" #"application/xml; charset=utf-8") body))

(defun get-body (req)
  (let ((`#(ok ,body ,_)
         (cowboy_req:read_body req)))
    body))

;; (defun build-request-map (req)
;;   "Build request Map"
;;   `#m(+req_http_version+ ,(cowboy_req:version req)
;;       +req_headers+ ,(cowboy_req:headers req)
;;       +req_cookies+ ,(cowboy_req:parse_cookies req)
;;       +req_host+ ,(cowboy_req:host req)
;;       +req_host_info+ ,(cowboy_req:host_info req)
;;       ;; +req_host_url+ ,(cowboy_req:host_url req)
;;       ;; +req_url+ ,(cowboy_req:url req)
;;       +req_path+ ,(cowboy_req:path req)
;;       +req_path_info+ ,(cowboy_req:path_info req)
;;       +req_qs+ ,(cowboy_req:parse_qs req)
;;       +req_port+ ,(cowboy_req:port req)
;;       +req_peer+ ,(cowboy_req:peer req)
;;       +req_method+ ,(cowboy_req:method req)
;;       +req_has_body+ ,(cowboy_req:has_body req)
;;       +req_body_length+ ,(cowboy_req:body_length req)
;;       ))

;; Macros

(defmacro compile-routes args
  "Compiles the routes"
  `(cowboy_router:compile
    (list #(_ (,@args)))))

(defmacro respond args
  "Assumes that both req and state are in scope"
  `(let ((res (cowboy_req:reply
              ,@args
              req)))
    `#(ok ,res ,state)
    ))

;; (defmacro with-request req
;;   "Destructures the Request"
;;   `(let* (())))

(defmacro defhandler
  "Defines a new handler"
  ((name . (method . body))
   `(progn
      (defmodule ,name
        (export (init 2)))

      (defun init (req state)
        (let* ((+html_content_type+ #m(#"content-type" #"text/html; charset=utf-8"))
               (+plaintext_content_type+ #m(#"content-type" #"text/plain; charset=utf-8"))
               (+json_content_type+ #m(#"content-type" #"application/json; charset=utf-8"))
               (+xml_content_type+ #m(#"content-type" #"application/xml; charset=utf-8"))
               (+request+ (build-request-map req))
               (`#m(+req_method+ ,req_method +req_has_body+ ,has_body) +request+)
               (`#m(status ,status headers ,headers body ,body)
                   (funcall
                    (lambda ()
                      (cond [(not
                              (=:= ,method req_method)) (send-content
                                                        405 +plaintext_content_type+
                                                        #"Method Not Allowed.")]
                            [(and
                              (=:= #"POST" req_method)
                              (=:= 'false has_body)) (send-content
                                                      400 +plaintext_content_type+
                                                      #"Missing Body.")]
                            [(and
                              (=:= #"PUT" req_method)
                              (=:= 'false has_body)) (send-content
                                                      400 +plaintext_content_type+
                                                      #"Missing Body.")]
                            ['true
                             ,@body])))
                   )
               )
          (respond
           status headers body)
          )))))

