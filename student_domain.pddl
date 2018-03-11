(define (domain nosliw)
  (:requirements :strips :typing)
  (:types town mountain cave - location
  sword pen diamond - item
  hero dragon wizard - agent
  sorceress - wizard
  item agent location - object

  )
  (:predicates (at ?o - object ?l - location)
  (different ?d1 - diamond ?d2 - diamond)
  (possesses ?a - agent ?i - item)
  (path-from-to ?l1 - location ?l2 - location)
  (dead ?a - agent)
  (asleep ?a - agent)
  (strong ?h - hero)
  (alive ?a - agent)
  (safe ?t - town)
  )

  (:action move
	     :parameters (?h - hero ?l1 - location ?l2 - location)
	     :precondition (and (at ?h ?l1) (path-from-to ?l1 ?l2))
	     :effect (and (at ?h ?l2 ) (not (at ?h ?l1))))

  (:action trade
	     :parameters (?a1 - agent ?a2 - agent ?i1 - item ?i2 - item ?l - location)
	     :precondition (and (at ?a1 ?l) (at ?a2 ?l ) (possesses ?a1 ?i1) (possesses ?a2 ?i2) (not (possesses ?a2 ?i1)) (not (possesses ?a1 ?i2)))
	     :effect (and (possesses ?a1 ?i2) (possesses ?a2 ?i1) (not (possesses ?a1 ?i1)) (not (possesses ?a2 ?i2))))

  (:action pickup
	     :parameters (?a - agent ?l - location ?i - item)
	     :precondition (and (at ?a ?l) (at ?i ?l) (not (possesses ?a ?i)) )
	     :effect (and (possesses ?a ?i) (not (at ?i ?l))))

  (:action slay
	     :parameters (?h - hero ?l - location ?d - dragon ?t - town)
	     :precondition (and (at ?h ?l) (at ?d ?l) (strong ?h))
	     :effect (and (dead ?d) (safe ?t) (not (alive ?d))))

  (:action get_strength
	     :parameters (?h - hero ?w - wizard ?l - location ?d - diamond ?dd - diamond ?ddd - diamond)
	     :precondition (and (at ?h ?l) (at ?w ?l) (possesses ?h ?d) (possesses ?h ?dd) (possesses ?h ?ddd)
	     (different ?d ?dd)
	     (different ?dd ?ddd)
	     (different ?d ?ddd)
	     )
	     :effect (and (strong ?h) (possesses ?w ?d) (possesses ?w ?dd) (possesses ?w ?ddd) (not (possesses ?h ?d)) (not (possesses ?h ?dd)) (not (possesses ?h ?ddd))))

  (:action write_song
	     :parameters (?h - hero ?d - dragon ?p - pen ?t - town)
	     :precondition (and (possesses ?h ?p) (not (dead ?d)))
	     :effect (and (asleep ?d) (safe ?t)))

)