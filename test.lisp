(in-package :cl-user)
(ql:quickload :exit-hooks)

;;; note when testing for sbcl via slime, you need to directly enter (quit) in *inferior-lisp*,
;;; or directly use kill from shell, not *slime-repl sbcl* (which will has no effect. For ccl
;;; and abcl there is no this issue. For ecl, I only tested directly from it's repl, because I
;;; have problem in configuring it for slime.
(defun save-to-file (to-save filename)
  (with-open-file (s filename
		     :direction :output
		     :if-exists :append
		     :if-does-not-exist :create)
    (write to-save :stream s)))

(exit-hooks:add-exit-hook #'(lambda () (save-to-file -2 #P"/tmp/test-exit-hooks.txt")))
(exit-hooks:add-exit-hook #'(lambda () (save-to-file -1 #P"/tmp/test-exit-hooks.txt")) -1)
(exit-hooks:add-exit-hook #'(lambda () (save-to-file 1 #P"/tmp/test-exit-hooks.txt")) 1)
(exit-hooks:add-exit-hook #'(lambda () (save-to-file 3 #P"/tmp/test-exit-hooks.txt")) 3)
(exit-hooks:add-exit-hook #'(lambda () (save-to-file 2 #P"/tmp/test-exit-hooks.txt")) 2)

(exit-hooks:delete-exit-hook 2) (exit-hooks:delete-exit-hook 0)

;;;; The text in /tmp/test-exit-hooks.txt should be the following after exit Lisp.
;;;; -113
