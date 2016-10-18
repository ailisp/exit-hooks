(in-package #:exit-hooks)

#+sbcl (progn
	 (setf *exit-hooks* nil)
	 (push *exit-hooks* #'%exit-hook-controller%))
#-sbcl (error "exit-hooks not implemented in this implementation.")
