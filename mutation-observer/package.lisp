;;; -*- mode:lisp; coding:utf-8  -*-


;;; Mutation - dom mutation observer interface
;;; This file is part of the MOREN Environment
;;; Copyright © 2017 Vladimir Mezentsev
;;;


;;; path for make-new
;;; use for contruct some js functions such as:
;;;    promise, mutation-observer
;;;

(in-package :cl-user)

(eval-when (:compile-toplevel :load-toplevel :execute)
    (unless #j:make_Instance
        (let ((make-instance-proto
                "var make_Instance  =  function () {
                     var args = [].concat(null,Array.prototype.slice.call(arguments,2));
                     var fn = arguments[0][arguments[1]];
                     return new (Function.prototype.bind.apply(fn,args))();
                    };"))
            (#j:eval make-instance-proto))))


;;; package mutation
(eval-when (:compile-toplevel :load-toplevel :execute)
    (unless (find-package :mutation)
        (make-package :mutation :use (list 'cl))))



(in-package :mutation)

(export '(jscl::oget klib::mkjso))

(in-package :cl-user)


;;; EOF
