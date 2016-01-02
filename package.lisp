(defvar *compilerPath* *default-pathname-defaults*)
(load "random-file.lisp")

(save-lisp-and-die (merge-pathnames "bin/random_file_choice" *compilerPath*) :toplevel 'main :executable t :compression t)
