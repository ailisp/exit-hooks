;;;; exit-hooks.asd

(asdf:defsystem #:exit-hooks
  :description "Call registered function when Common Lisp Exits."
  :author "Bo Yao <icerove@gmail.com>"
  :license "BSD"
  :serial t
  :components ((:file "package")
	       (:file "util")
               (:file "exit-hooks")))


