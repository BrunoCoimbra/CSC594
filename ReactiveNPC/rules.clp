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
        (eActor ?a) (eTarget ?t) (eObserver ?o) (eKind aggressive))
    (object (is-a Relationship)
        (rCharacter ?o) (rTarget ?t) (rLevel ?level) (rKind binding))
    (test (> ?level 0))
    =>
    (set-relationship ?o ?a -0.03)
    (printout t
         (send ?o get-cName) " gets angry at " (send ?a get-cName)
          " for being aggressive at " (send ?t get-cName) crlf)
)