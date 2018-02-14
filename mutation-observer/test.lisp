;;; -*- mode:lisp; coding:windows-1251  -*-


(defparameter *mutant (html:div))
(defparameter *mutant-child (html:div))
(defparameter *datareg (#j:document:createTextNode ""))

(defparameter *ensign-fn
  (lambda (mutation)
      (let ((type)
            (len (oget mutation "length"))
            (data )
            (target))
          ;; type =>
          ;; "attributes" if the mutation was an attribute mutation,
          ;; "characterData" if it was a mutation to a CharacterData node,
          ;; "childList" if it was a mutation to the tree of nodes.
          (dotimes (idx len)
              (setq type (oget (aref mutation idx) "type"))
              (setq target (oget (aref mutation idx) "target"))
              (format t "Mutation #~a type ~a ~%" idx type)
              (cond ((equal type "characterData")
                     (format t "Data ~a~%" (oget target "data")))
                    ((equal type "attributes")
                     (format t "Attribute ~a ~a~%"
                             (oget (aref mutation idx) "attributeName")
                             (dom:get-attribute target (oget (aref mutation idx) "attributeName"))))
                    ((equal type "childList")
                     (format t "childs~%"))
                    (t (error "wtf mutation type ~a?" type)))))))


(defparameter *ensign (mutation:new-observer *ensign-fn))


(mutation:observe *ensign *datareg)
(mutation:observe *ensign *mutant :attr t :child t)

(defun test1 (time)
    (let* ((evolution-data (lambda (txt) (setf (oget *datareg  "data") txt)))
           (evolution-attr (lambda (attr val)
                               (dom:set-attribute *mutant attr val)))
           (evolution-child (lambda (op child)
                                (case op
                                  (:add (dom:append-child *mutant child))
                                  (:remove (dom:remove-child child) )))))
        (#j:setTimeout (lambda () (funcall evolution-data "born")) time)
        (#j:setTimeout (lambda () (funcall evolution-attr "place" "downtown")) time)
        (#j:setTimeout (lambda () (funcall evolution-child :add *mutant-child)) time)
        (#j:setTimeout (lambda () (funcall evolution-data "new population")) time)
        (#j:setTimeout (lambda () (funcall evolution-child :remove *mutant-child)) time)
        (#j:setTimeout (lambda () (funcall evolution-data "de population")) time)
        (#j:setTimeout (lambda () (funcall evolution-data "the end")) time)
        (values)  ))


(test1 10)


;;; EOF
