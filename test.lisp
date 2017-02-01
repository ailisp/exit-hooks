(in-package :cl-user)

; (ql:quickload :exit-hooks)

(defun save-to-file (to-save filename)
  (with-open-file (s filename
		     :direction :output
		     :if-exists :append
		     :if-does-not-exist :create)
    (write to-save :stream s :pretty t)))

(exit-hooks:add-exit-hook #'(lambda () (save-to-file "some content" #P"/tmp/test-exit-hooks.txt")))
