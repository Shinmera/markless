(asdf:load-system :cl-markless-plump)
(asdf:load-system :clip)

(defvar *here* (make-pathname :name NIL :type NIL
                              :defaults #.(or *load-pathname*
                                              (error "Please simply LOAD this file."))))

(defun file (name type)
  (make-pathname :name name :type type :defaults *here*))

(clip:define-tag-processor "main" (node)
  (cl-markless:output (file "README" "mess")
                      :target node :format :plump))

(with-open-file (output (file "index" "html") :direction :output
                                              :if-exists :supersede)
  (plump:serialize (clip:process (file "template" "ctml")) output))
