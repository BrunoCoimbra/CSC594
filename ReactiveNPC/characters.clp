;;; Character class defines a generic character
(defclass Character (is-a USER)
    (slot cName)                ; Character name
    (slot cMood (default 0))    ; Character current mood
    (multislot cStandards)      ; Principles and beliefs
    (multislot cGoals)          ; Current objectives
    (multislot cActionChannels) ; Channels through which the character acts
)

;;; Relationship class represents the opinion of a character towards another
(defclass Relationship (is-a USER)
    (slot rCharacter)                           ; Character to whom the relationship belongs
    (slot rTarget)                              ; Target character of the relationship
    (slot rLevel (default 0) (range -1.0 1.0))  ; Intensity of the relationship
    (slot rKind (default non-binding))          ; Binding or non-binding
)


;;; Utility functions
(deffunction set-relationship (?c ?t ?n)
    (bind ?cName (send ?c get-cName))
    (bind ?tName (send ?t get-cName))
    (bind ?rel (find-instance 
        ((?r Relationship))
        (and (eq ?r:rCharacter ?c) (eq ?r:rTarget ?t))
    ))
    (if (> (length$ ?rel) 0) then
        (send (nth$ 1 ?rel) put-rLevel (+ (send (nth$ 1 ?rel) get-rLevel) ?n))
     else
        (make-instance of Relationship
            (rCharacter ?c) (rTarget ?t) (rLevel ?n)
        )
    )
)

(deffunction is-ally (?c ?t)
    (bind ?rel (find-instance 
        ((?r Relationship))
        (and (eq ?r:rCharacter ?c) (eq ?r:rTarget ?t) 
                (> ?r:rLevel 0)  (eq ?r:rKind binding))
    ))
    (return (> (length$ ?rel) 0))
)


;;; Character class constructors
;
; This functions instantiate characters according to a template
;

;; Pre-defined standards:
;   heroism:
;       - Aggressive to aggressors of innocents (non-enemies)

(deffunction make-character-commoner (?id)
    (make-instance ?id of Character
        (cName Commoner)
        (cActionChannels voice body)
    )
)

(deffunction make-character-hero (?id)
    (make-instance ?id of Character
        (cName Hero)
        (cStandards heroism)
        (cActionChannels voice body)
    )
)