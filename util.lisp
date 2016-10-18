(in-package #:exit-hooks)

(defmacro while (test &body body)
  `(do ()
       ((not ,test))
     ,@body))
