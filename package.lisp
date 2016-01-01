(load "random-file.lisp")
(defvar *compilerPath* #P"./bin/") 

(save-lisp-and-die (merge-pathnames "random_file_choice" *compilerPath*) :toplevel 'main :executable t :compression t)
