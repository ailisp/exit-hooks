;;;; package.lisp
(in-package :cl-user)

(defpackage #:exit-hooks
  (:use #:cl)
  (:export #:add-exit-hook
	   #:*exit-hooks*))

