;;; -*- mode:lisp; coding:utf-8  -*-


;;; Mutation - dom mutation observer interface
;;;            system definition file
;;;
;;; This file is part of the MOREN Environment
;;; Copyright © 2018 Vladimir Mezentsev
;;;

(lores:defsys :mutation-observer
    :path "git/web-api"
    :components ((:module "mutation-observer"
                          (:file "package")
                          (:file "observer"))))


;;; EOF
