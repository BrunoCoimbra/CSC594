;;; Character class defines a generic Event
(defclass Event (is-a USER)
    (slot eName)            ; Event name
    (slot eKind)            ; Event kind(s)
    (slot eActor)           ; Character(s) provoking the event
    (slot eTarget)          ; Character(s) toward which the event is directed
    (multislot eObservers)   ; Character(s) observing the event
)

;;; Event class constructors
;
; This functions instantiate events according to a template
;

;;; Greet Event
; The actor greets the target
(deffunction make-event-greet (?id)
    (make-instance ?id of Event
        (eName greet)
        (eKind neutral)
    )
)
(defrule greet
    (object (is-a Event) (eName greet) (eActor ?a) (eTarget ?t))
    =>
    (printout t (send ?a get-cName) " greets " (send ?t get-cName) crlf)
)

;;; Attack Event
; The actor attacks the target
(deffunction make-event-attack (?id)
    (make-instance ?id of Event
        (eName attack)
        (eKind aggressive)
    )
)
(defrule attack
    (object (is-a Event) (eName attack) (eActor ?a) (eTarget ?t))
    =>
    (printout t (send ?a get-cName) " attacks " (send ?t get-cName) crlf)
)