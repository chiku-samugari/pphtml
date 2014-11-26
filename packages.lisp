(in-package :cl-user)

(defpackage :pphtml
  (:use :cl :cl-ppcre :chiku.util)
  (:export :output-as-html :color :pair-coloring
           :white :red :green :yellow))
