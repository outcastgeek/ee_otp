;;; Alt Handler

(include-file "include/web.lfe")

(defhandler alt_handler
  #"GET"
  (send-text
   #"Alternate Handler!"))

