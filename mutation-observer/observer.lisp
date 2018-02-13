;;; -*- mode:lisp; coding:utf-8  -*-


;;; Mutation - dom mutation observer interface
;;; This file is part of the MOREN Environment
;;; Copyright © 2018 Vladimir Mezentsev
;;;


(in-package :mutation)


;;; Constructor for instantiating new DOM mutation observers
;;; (setq *fm (new-observer
;;;        (lambda (mut)
;;;            (let ((len (oget mut "length")))
;;;                 (dotimes (idx len)
;;;                    (format t "Mutant ~a~%" (oget (aref mut idx) "target" "data")))))))
(defun new-observer (fun)
    "Constructor for instantiating new DOM mutation observers"
    (#j:make_Instance #j:window "MutationObserver"
                      (lambda (mutations observer)
                          ;; mutations - array of MutationRecord
                          ;; observer  - some mutant observer
                          (funcall fun mutations))))
(export '(new-observer))



;;; Registers the MutationObserver instance to receive notifications
;;; of DOM mutations on the specified node.
(defun observe (inst obj &key (char t) attr child)
    "Registers the MutationObserver instance to receive notifications"
    (let ((mop))
        (if char (push (list "characterData" t) mop))
        (if attr (push (list "attributes" t) mop))
        (if child (push (list "childList" t) mop))
        ;;(#j:console:log (apply #'mkjso (apply #'append mop)))
        (funcall ((oget inst "observe" "bind") inst obj (apply #'mkjso (apply #'append mop))))))

(export '(observe))


;;; Stops the MutationObserver instance from receiving notifications
(defun disconnect (instance)
    "Stops the MutationObserver instance from receiving notifications"
    (funcall ((oget instance "disconnect" "bind") instance))
    (values))

(export '(disconnect))


;;; Empties the MutationObserver instance's record queue and returns what was in there
;;; => array
(defun take-Records (instance)
    "Empties the MutationObserver instance's record queue and returns what was in there"
    (funcall ((oget instance "takeRecords" "bind") instance)))

(export '(take-Records))


(in-package :cl-user)

;;; EOF
