;;; General Rules

; A character gets angry at an aggressor
(defrule dislike-suffering-aggression
    (object (is-a Event)
        (eActor ?a) (eTarget ?t) (eKind aggressive))
    =>
    (set-relationship ?t ?a -0.05)
    (printout t
        (send ?t get-cName) " gets angry at " (send ?a get-cName) crlf)
)

; A characters involved in positive interactions get pleased at each other
(defrule likes-positive-interaction
    (object (is-a Event)
        (eActor ?a) (eTarget ?t) (eKind positive))
    =>
    (set-relationship ?a ?t +0.01)
    (printout t
        (send ?t get-cName) " gets pleased at " (send ?a get-cName) crlf)
    (set-relationship ?t ?a +0.01)
    (printout t
        (send ?a get-cName) " gets pleased at " (send ?t get-cName) crlf)
)

; A characters involved in negative interactions get displeased at each other
(defrule dislikes-negative-interaction
    (object (is-a Event)
        (eActor ?a) (eTarget ?t) (eKind negative))
    =>
    (set-relationship ?a ?t -0.01)
    (printout t
        (send ?t get-cName) " gets displeased at " (send ?a get-cName) crlf)
    (set-relationship ?t ?a -0.01)
    (printout t
        (send ?a get-cName) " gets displeased at " (send ?t get-cName) crlf)
)

; A character gets angry at an ally's aggressor
(defrule dislike-allys-aggressor
    (object (is-a Event)
        (eActor ?a) (eTarget ?t) (eObservers $?O) (eKind aggressive))
    =>
    (foreach ?o ?O
        (if (is-ally ?o ?t) then
            (set-relationship ?o ?a -0.03)
            (printout t
                (send ?o get-cName) " gets angry at " (send ?a get-cName)
                " for being aggressive at " (send ?t get-cName) crlf)
        )
    )
)

; A hero attacks aggressors of innocents
(defrule hero-dislikes-innocent-aggressor
    (object (is-a Event)
        (eActor ?a) (eTarget ?t) (eObservers $?O) (eKind aggressive))
    =>
    (foreach ?o ?O
        (if (has-standard ?o heroism) then
            (set-relationship ?o ?a -0.1)
            (printout t
                "Hero " (send ?o get-cName) " gets angry at " (send ?a get-cName)
                " for being aggressive at " (send ?t get-cName) crlf)
            (bind ?i (member$ ?o ?O))
            (bind ?e (make-event-attack (gensym)))
            (send ?e put-eActor ?o)
            (send ?e put-eObservers (delete$ ?O ?i ?i))
            (send ?e put-eTarget ?a)
        )
    )
)

; A vendor offer negotiates with someone who greets them
(defrule vendor-offer-negotiates
    (object (is-a Event) (eActor ?a) (eTarget ?t) (eName greet))
    =>
    (if (has-standard ?t seller) then
        (bind ?e (make-event-negotiate (gensym)))
        (send ?e put-eActor ?t)
        (send ?e put-eTarget ?a)
        (bind ?e (make-event-greet (gensym)))
        (send ?e put-eActor ?t)
        (send ?e put-eTarget ?a)
    )
)

; A coward runs from aggressors
(defrule coward-runs-from-aggressor
    (object (is-a Event)
        (eActor ?a) (eTarget ?t) (eKind aggressive))
    =>
    (if (member$ coward (send ?t get-cStandards)) then
        (printout t (send ?t get-cName) " runs from " (send ?a get-cName) crlf)
    )
)