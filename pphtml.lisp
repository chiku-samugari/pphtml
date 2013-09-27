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

(defun colored (r g b str)
  (format nil "<font color=\"~2,'0x~2,'0x~2,'0x\">~a</font>" r g b str))

(colored 0 255 80 "a")

(defun white (str)
  (colored 255 255 255 str))

(defun red (str)
  (colored 255 0 0 str))

(defun green (str)
  (colored 0 255 0 str))

;;; I have no idea to dicretly utilize the pretty printed string.
;;; It's not a beautiful idea, but let me break the structure.
;;; Added nodes are marked by brackets and removed nodes are marked
;;; by braces.
(defparameter *bracket-sample*
  '(defun iota (n [&optional (start 0)])
     (loop for i from {0} [start] upto (1- n) collect i)))

(ql:quickload :cl-ppcre)
(use-package :cl-ppcre)

(defun replace-pair (start end color-fn codestr)
  (regex-replace-all `(:sequence ,start (:register ,(parse-string ".*")) ,end)
                                           (format nil "~a" codestr)
                                           (funcall color-fn "\\1")))

(output-as-html (format nil "<pre>~a</pre>"
                        (replace-pair "[" "]" #'green
                                      (replace-pair "{" "}" #'red *bracket-sample*)))
                "tmp.html")
