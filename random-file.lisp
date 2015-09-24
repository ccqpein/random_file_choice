(load "/Users/ccQ/Desktop/lispexci/cl-fad/load.lisp")

(defvar *list-of-files* nil)

(defun get-files-or-dir (dir-input)
  (cl-fad:list-directory dir-input))

(defun push-to-list (dir-input)
  (push (get-files-or-dir dir-input) *list-of-files*))

(defun push-to-list2 (dir-input)
  (dolist (x (get-files-or-dir dir-input)) (push x *list-of-files*)))

(defun choice-the-video (*list-of-files*)
  (print (nth (random (length *list-of-files*)) *list-of-files*)))

(defun open-by-system (dir)
  (sb-ext:run-program "/usr/bin/open" (list "-a" "Preview" dir)))
