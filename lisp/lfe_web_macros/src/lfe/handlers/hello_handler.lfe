;;; Hello Handler

(include-file "include/web.lfe")

(defhandler hello_handler
  #"GET"
  (send-text
   #"Hello LFE DBCopy!!!!"))

