(in-package :pphtml)

(defun output-as-html (body &optional (out *standard-output*))
  (let ((format-string "<html><head><title> pretty print </title></head><body bgcolor=\"000000\" text=\"ffffff\"><p>~%~a~%</p></body></html>" ))
  (if (streamp out)
    (format out format-string body)
    (with-open-file (outstrm out :direction :output :if-does-not-exist :create :if-exists :supersede)
      (format outstrm format-string body)))))

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
