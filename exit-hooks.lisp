;;;; exit-hooks.lisp

(in-package #:exit-hooks)

(defvar *exit-hooks-alist* nil
  "The exit hook functions alist. each is (FUNC . PRIORITY).")

(defun %exit-hook-controller% ()
  (mapc #'(lambda (fn-pri) (funcall (car fn-pri)))
	(stable-sort *exit-hooks-alist* #'< :key #'cdr)))

(defun add-exit-hook (function &optional (priority 0))
  "Add a no argument function FUNCTION to be called at exit with PRIORITY. PRIORITY is integer, smaller one will be called first when exit. If several functions with same PRIORITY, their calling sequence is the reverse of their adding order. If no PRIORITY set, it will have default priority 0. Return current exit function counts."
  (length (push (cons function priority) *exit-hooks-alist*)))

(defun delete-exit-hook (priority)
  "Delete all functions added by ADD-EXIT-HOOK with priority PRIORITY. Return current exit function counts."
  (length (setf *exit-hooks-alist* (delete priority *exit-hooks-alist* :key #'cdr))))

#+sbcl (progn
	 (setf sb-ext:*exit-hooks* nil)
	 (push #'%exit-hook-controller% sb-ext:*exit-hooks*))
#+ccl (progn
	(setf ccl:*lisp-cleanup-functions* nil)
	(push #'%exit-hook-controller% ccl:*lisp-cleanup-functions*))
#+ecl (progn
	(setf si:*exit-hooks* nil)
	(push #'%exit-hook-controller% si:*exit-hooks*))
#+abcl (progn
	 (defparameter *exit-hook-thread*
	   (java:jnew-runtime-class "ExitHookThread" :superclass "java.lang.Thread"
				    :methods `(("run" :void () ,#'(lambda (this)
								    (declare (ignore this))
								    (funcall #'%exit-hook-controller%))))))
	 (java:jcall "addShutdownHook" (java:jstatic "getRuntime" "java.lang.Runtime")
		     (java:jnew *exit-hook-thread*)))
#-(or sbcl ccl ecl abcl)
(error "Not implement.")
