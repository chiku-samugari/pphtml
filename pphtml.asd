(in-package :cl-user)

(defpackage :pphtml.asd
  (:use :cl :asdf))

(in-package :pphtml.asd)

(defsystem :pphtml
  :name "PPHTML"
  :version "0.1.0"
  :maintainer "Takehiko Nawata"
  :author "Takehiko Nawata"
  :license "MIT License"
  :description "Pretty printing output as HTML"
  :long-description "Pretty printing colored by pair replication and output as HTML"
  :serial t
  :components ((:file "packages")
              (:file "pphtml"))
  :defsystem-depends-on (:cl-ppcre))
