(load "/Users/ccQ/Desktop/lispexci/cl-fad/load.lisp")
(load "/Users/ccQ/quicklisp/setup.lisp")
(ql:quickload 'inferior-shell)

;(defvar *list-of-files* nil)

(defun get-files-or-dir (dir-input)
  (let (files)
    (cl-fad:walk-directory dir-input #'(lambda (x)
					 (push x files)))
    files))

(defun push-to-list (dir-input)
  (let (listoffiles)
    (dolist (x (get-files-or-dir dir-input))
      (loop for i in '("avi" "rmvb" "MOV")
	 when (equalp (pathname-type x) i)
	   do (push x listoffiles)))
    listoffiles))

;(defun push-to-list2 (dir-input)
;  (dolist (x (get-files-or-dir dir-input))
;    (loop for i in '("avi" "rmvb")
;       when (equalp (pathname-type x) i)
;	 do (push x *list-of-files*))))

(defun open-by-system (file)
  (inferior-shell:run/ss (list "open" file)))

(defun choice-file-to-open (files)
  (open-by-system (nth (random (length files)) files)))

(defun main ()
  (choice-file-to-open (push-to-list (read-line)))
  )
