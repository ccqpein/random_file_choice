(load "random-file.lisp")

(save-lisp-and-die "./bin/random_file_choice" :toplevel 'main :executable t :compression t)
