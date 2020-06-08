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

;;; Negotiate Event
; The actor starts a negotiation with the target
(deffunction make-event-negotiate (?id)
    (make-instance ?id of Event
        (eName negotiate)
        (eKind neutral)
    )
)
(defrule negotiate
    (object (is-a Event) (eName negotiate) (eActor ?a) (eTarget ?t))
    =>
    (assert (negotiates ?a ?t))
    (printout t (send ?a get-cName) " starts negotiation with " (send ?t get-cName) crlf)
)

;;; Negotiation Succeeds Event
; The actor's negotiation with the target succeeds
(deffunction make-event-negotiation-succeeds (?id)
    (make-instance ?id of Event
        (eName negotiation-succeeds)
        (eKind positive)
    )
)
(defrule negotiation-succeeds
    (object (is-a Event) (eName negotiation-succeeds) (eActor ?a) (eTarget ?t))
    ?f <- (negotiates ?a ?t)
    =>
    (retract ?f)
    (printout t (send ?a get-cName) "'s negotiation with " (send ?t get-cName) " succeeds" crlf)
    (if (has-standard ?a seller) then
        (printout t (send ?a get-cName) "'s mood improve with the negotiation" crlf)
        (set-mood ?a +0.3)
    )
)

;;; Negotiation Fails Event
; The actor's negotiation with the target succeeds
(deffunction make-event-negotiation-fails (?id)
    (make-instance ?id of Event
        (eName negotiation-fails)
        (eKind negative)
    )
)
(defrule negotiation-fails
    (object (is-a Event) (eName negotiation-fails) (eActor ?a) (eTarget ?t))
    ?f <- (negotiates ?a ?t)
    =>
    (retract ?f)
    (printout t (send ?a get-cName) "'s negotiation with " (send ?t get-cName) " fails" crlf)
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
    (if (has-channel ?a body) then
        (printout t (send ?a get-cName) " attacks " (send ?t get-cName) crlf)
        (return)
    )
    (if (has-channel ?a voice) then
        (printout t (send ?a get-cName) " curses " (send ?t get-cName) crlf)
        (return)
    )
)