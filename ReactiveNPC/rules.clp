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

; A character gets angry at an ally's aggressor
(defrule dislike-allys-aggressor
    (object (is-a Event)
        (eActor ?a) (eTarget ?t) (eObservers $?O) (eKind aggressive))
    (object (is-a Relationship)
        (rCharacter ?c) (rTarget ?t) (rLevel ?level) (rKind binding))
    (test (> ?level 0))
    =>
    (foreach ?o ?O
        (bind ?rel (find-instance 
            ((?r Relationship))
            (and (eq ?r:rCharacter ?o) (eq ?r:rTarget ?t) 
                 (> ?r:rLevel 0)  (eq ?r:rKind binding))
        ))
        (if (> (length$ ?rel) 0) then
            (set-relationship ?o ?a -0.03)
            (printout t
                (send ?o get-cName) " gets angry at " (send ?a get-cName)
                " for being aggressive at " (send ?t get-cName) crlf)
        )
    )
)