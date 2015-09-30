(load "/Users/ccQ/Desktop/lispexci/cl-fad/load.lisp")
(load "/Users/ccQ/quicklisp/setup.lisp")
(ql:quickload 'inferior-shell)
(defvar *list-of-files* nil)

(defun get-files-or-dir (dir-input)
  (cl-fad:list-directory dir-input))

(defun push-to-list (dir-input)
  (push (get-files-or-dir dir-input) *list-of-files*))

(defun push-to-list2 (dir-input)
  (dolist (x (get-files-or-dir dir-input)) (push x *list-of-files*)))

(defun open-by-system (file)
  (inferior-shell:run/ss (list "open" file)))

(defun choice-file-to-open ()
  (open-by-system (nth (random (length *list-of-files*)) *list-of-files*)))

(defun main ()
  (push-to-list2 "/Users/ccQ/Desktop/htmlexci")
  (choice-file-to-open )
  )