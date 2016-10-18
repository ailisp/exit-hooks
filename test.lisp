;;;; If tested on *slime-repl*, the output will be in *inferior-lisp*,
;;;; which may seems not correct at first glance. But it's because the
;;;; displace of *inferior-lisp* is not correct for exit, the actual
;;;; function calling is correct. Try to directly tested on
;;;; *inferior-lisp* (paste the following to *inferior-lisp* you will
;;;; see correct result.

(exit-hooks:add-exit-hook #'(lambda () (print -2)))
(exit-hooks:add-exit-hook #'(lambda () (print -1)))
(exit-hooks:add-exit-hook #'(lambda () (print 1)) 1)
(exit-hooks:add-exit-hook #'(lambda () (print 3)) 3)
(exit-hooks:add-exit-hook #'(lambda () (print 2)) 2)

(exit-hooks:delete-exit-hook 2) (exit-hooks:delete-exit-hook 0)
