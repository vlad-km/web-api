# Mutation-observable interface for Morem environment

## API

### Namespace mutation

(mutation:new-observer fun) - Constructor for instantiating new DOM mutation observers
```
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
              (cond ((equal type "characterData") (format t "Data ~a~%" (oget target "data")))
                    ((equal type "attributes") (format t "Attribute ~a ~a~%"
                                                       (oget (aref mutation idx) "attributeName")
                                                       (dom:get-attribute target (oget (aref mutation idx) "attributeName"))))
                    ((equal type "childList") (format t "childs~%"))
                    (t (error "wtf mutation type ~a?" type)))))))
```


(observe inst obj &key (char t) attr child) - Registers the MutationObserver instance to receive notifications

```
(defvar *regdata (dom:createTextNode ""))
(defvar *other-node (dom:div)) 
(mutation:observe *eisign-fn *regdata)
(mutation:observe *eisign-fn *other-node :attr t :child t)
```


(disconnect mutation-observer-instance) - Stops the MutationObserver instance from receiving notifications

```
(mutation:disconnect *mutant)

```


# Copyright
Copyright © 2018 Vladimir Mezentsev

## License
GNU General Public License v3.0
