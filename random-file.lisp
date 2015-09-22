(load "/Users/ccQ/Desktop/lispexci/cl-fad/load.lisp")

(defvar *list_of_files* nil)

(defun get_files_or_dir (dir_input)
  (cl-fad:list-directory dir_input))

(defun push_to_list (dir_input)
  (push (get_files_or_dir dir_input) *list_of_files*))

(defun push_to_list2 (dir_input)
  (dolist (x (get_files_or_dir dir_input)) (push x *list_of_files*)))

(defun choice_the_video (*list_of_files*)
  (print (nth (random (length *list_of_files*)) *list_of_files*)))

(defun open_by_system (dir)
  (sb-ext:run-program "/usr/bin/open" (list "-a" "Preview" dir)))
