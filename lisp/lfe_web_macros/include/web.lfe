;;; Web Macros on Top of Cowboy 2

;; Macros

(defmacro compile-routes args `(web:compile-routes ,@args))

(defmacro defhandler args `(web:defhandler ,@args))

(defmacro respond args `(web:respond ,@args))

