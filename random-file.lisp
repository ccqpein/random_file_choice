(load "/Users/ccQ/Desktop/lispexci/cl-fad/load.lisp")
(load "/Users/ccQ/quicklisp/setup.lisp")
(ql:quickload 'inferior-shell)

;(setf *random-state* (make-random-state t))
;(defvar *list-of-files* nil)

(defun get-files-or-dir (dir-input)
  (let (files)
    (cl-fad:walk-directory dir-input #'(lambda (x)
					 (push x files)))
    files))

(defun push-to-list (dir-input)
  (let (listoffiles)
    (dolist (x (get-files-or-dir dir-input))
      (loop for i in '("avi" "rmvb" "MOV" "mp4" "mkv")
	 when (equalp (pathname-type x) i)
         do (push x listoffiles)))
;    (print listoffiles)
    listoffiles))

;(defun push-to-list2 (dir-input)
;  (dolist (x (get-files-or-dir dir-input))
;    (loop for i in '("avi" "rmvb")
;       when (equalp (pathname-type x) i)
;	 do (push x *list-of-files*))))

(defun open-by-system (file)
  (inferior-shell:run/ss (list "open" file)))

(defun choice-file-to-open (files)
  (let* ((randomNum (random (length files) (make-random-state t)))
         (filePath (nth randomNum files)))
    (open-by-system filePath)
    (with-open-file (file "/Users/ccQ/Desktop/logs" :direction :output
                          :if-does-not-exist :create
                          :if-exists :append
                          :external-format '(:utf-8 :replacement #\?))
      (format file "~S~%" (namestring filePath)))))


(defun main ()
  (choice-file-to-open (push-to-list (read-line)))
  )
