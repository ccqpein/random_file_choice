(load "/Users/ccQ/Desktop/lispexci/cl-fad/load.lisp")
(load "/Users/ccQ/quicklisp/setup.lisp")
(ql:quickload 'inferior-shell)

(defvar *list-of-files* nil)
(defvar *list-all-files* nil)

(defun get-files-or-dir (dir-input)
  (cl-fad:walk-directory dir-input #'(lambda (x) (push x *list-all-files*))))

(defun push-to-list (dir-input)
  (push (get-files-or-dir dir-input) *list-of-files*))

(defun push-to-list2 (dir-input)
  (get-files-or-dir dir-input)
  (dolist (x *list-all-files*)
    (loop for i in '("db" "lisp")
       when (equalp (pathname-type x) i)
	 do (push x *list-of-files*))))

(defun open-by-system (file)
  (inferior-shell:run/ss (list "open" file)))

(defun choice-file-to-open ()
  (open-by-system (nth (random (length *list-of-files*)) *list-of-files*)))

(defun main ()
  (push-to-list2 "/Users/ccQ/Desktop/htmlexci")
  (choice-file-to-open )
  )
