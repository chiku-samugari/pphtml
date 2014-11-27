(in-package :cl-user)

(defpackage :pphtml
  (:use :cl :cl-ppcre)
  (:export :output-as-html :color :pair-coloring
           :white :red :green :yellow))
