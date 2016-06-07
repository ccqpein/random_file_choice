(load "/Users/ccQ/Desktop/lispexci/cl-fad/load.lisp")
(load "/Users/ccQ/quicklisp/setup.lisp")
(ql:quickload 'inferior-shell)

(defun get-files-or-dir (dir-input)
  (let (files)
    (cl-fad:walk-directory dir-input #'(lambda (x)
					 (push x files)))
    files))

(defun push-to-list (dir-input)
  (let (listoffiles)
    (dolist (x (get-files-or-dir dir-input))
      (if (char/= (char (file-namestring x) 0) #\.)
      (loop for i in '("avi" "rmvb" "MOV" "mp4" "mkv")
	 when (equalp (pathname-type x) i)
         do (push x listoffiles))))
;    (print listoffiles)
    listoffiles))

(defun open-by-system (file)
  (inferior-shell:run/ss (list "open" file)))

(defun choice-file-to-open (files)
  (let* ((randomNum (random (length files) (make-random-state t)))
         (filePath (nth randomNum files)))
    (open-by-system filePath)
    (with-open-file (filelog (merge-pathnames "logs" *compilerPath*)
                          :direction :output
                          :if-does-not-exist :create
                          :if-exists :append
                          :external-format '(:utf-8 :replacement #\?))
      (format filelog "~S~%" (namestring filePath)))))


(defun main ()
  (let ((dir-input (nth 1 sb-ext:*posix-argv*)))
    (if (eql dir-input nil)
        (choice-file-to-open (push-to-list (read-line)))
        (choice-file-to-open (push-to-list dir-input)))))
