(in-package :pphtml)

(defparameter *iota0*
  '(defun iota (n)
     (loop for i from 0 to (1- n) collect i)))

(defun output-as-html (body &optional (out *standard-output*))
  (let ((format-string "<html><head><title> pretty print </title></head><body bgcolor=\"000000\" text=\"ffffff\"><p>~%~a~%</p></body></html>" ))
  (if (streamp out)
    (format out format-string body)
    (with-open-file (outstrm out :direction :output :if-does-not-exist :create :if-exists :supersede)
      (format outstrm format-string body)))))

(output-as-html
  (format nil "<pre>~%~a~%</pre>" (format nil "~a" *iota0*))
  "tmp.html")

(defun color (r g b str)
  (format nil "<font color=\"~2,'0x~2,'0x~2,'0x\">~a</font>" r g b str))

(color 0 255 80 "a")

(defun white (str)
  (color 255 255 255 str))

(defun red (str)
  (color 255 0 0 str))

(defun green (str)
  (color 0 255 0 str))

(defun yellow (str)
  (color 255 255 0 str))

;;; I have no idea to dicretly utilize the pretty printed string.
;;; It's not a beautiful idea, but let me break the structure.
;;; Added nodes are marked by braces and removed nodes are marked
;;; by brackets.
(defparameter *bracket-sample*
  '(defun iota (n [&optional (start 0)])
     (loop for i from {0} [start] upto (1- n) collect i)))

(ql:quickload :cl-ppcre)
(use-package :cl-ppcre)

(defun pair-coloring (start end color-fn code)
  (regex-replace-all
    (create-scanner `(:sequence
                       (:sequence ,start (:greedy-repetition 0 nil :whitespace-char-class))
                       (:register
                         (:non-greedy-repetition 0 nil :everything))
                       (:sequence (:greedy-repetition 0 nil :whitespace-char-class) ,end))
                    :single-line-mode t)
    (format nil "~a" code)
    (funcall color-fn "\\1")))

(output-as-html (format nil "<pre>~a</pre>"
                        (pair-coloring "{" "}" #'green
                                      (pair-coloring "[" "]" #'red *bracket-sample*)))
                "tmp.html")
