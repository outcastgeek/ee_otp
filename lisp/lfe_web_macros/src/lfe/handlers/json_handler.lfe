;;; Json Handler

(include-file "include/web.lfe")

(defhandler json_handler
  #"GET"
  (send-json
   (jsx:encode #m(#"message" #"Hello LFE DBCopy!!!!"))))

