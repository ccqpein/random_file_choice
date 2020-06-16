(ql:quickload "cl-fad")

(defun get-files-or-dir (dir-input)
  (let (files)
    (cl-fad:walk-directory dir-input
                           #'(lambda (x)
					           (push x files)))
    files))

(defun push-to-list (dir-input)
  (loop
    for x in (get-files-or-dir dir-input)
    if (and (char/= (char (file-namestring x) 0) #\.)
            (member (pathname-type x)
                    '("avi" "rmvb" "MOV" "mp4" "mkv")
                    :test #'string=))
      collect x into result
    finally (return result)))


(defun open-by-system (file)
  (sb-ext:run-program "open" (list file) :search t :wait t))

(defun choice-file-to-open (files)
  (let* ((randomNum (random (length files) (make-random-state t)))
         (file-path (nth randomNum files)))
    (open-by-system (namestring file-path))
    (format t "open ~S~%" (namestring file-path))))


(defun main ()
  (let ((dir-input (nth 1 sb-ext:*posix-argv*)))
    (if (eql dir-input nil)
        (choice-file-to-open (push-to-list (read-line)))
        (choice-file-to-open (push-to-list dir-input)))))

(main)
(sb-ext:exit)
