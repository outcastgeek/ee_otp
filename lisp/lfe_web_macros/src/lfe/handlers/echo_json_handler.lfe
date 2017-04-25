;;; Echo Posted Json Handler

(include-file "include/web.lfe")

(defhandler echo_json_handler
  #"POST"
  (let ((json (jsx:decode (get-body req))))
    ;; (syslog:info_msg "Request Info: ~p" `(,req))
    ;; (syslog:info_msg "Request Info: ~p" `(,+req_info+))
    ;; (syslog:info_msg "Received: ~p" `(,json))
    (send-json
     (jsx:encode `#m(#"received" ,json)))
    ))

