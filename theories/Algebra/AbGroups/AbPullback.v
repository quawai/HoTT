Require Import Basics Types Limits.Pullback Cubical.PathSquare.
Require Import Algebra.Groups Algebra.AbGroups.AbelianGroup.
Require Import WildCat.

(** Pullbacks of abelian groups. *)

Section AbPullback.
  (* Variables are named to correspond with Limits.Pullback. *)
  Context {A B C : AbGroup} (f : B $-> A) (g : C $-> A).

  Global Instance ab_pullback_commutative
    : Commutative (@group_sgop (GrpPullback f g)).
  Proof.
    unfold Commutative.
    intros [b [c p]] [d [e q]].
    apply equiv_path_pullback; simpl.
    refine (commutativity _ _; commutativity _ _; _).
    apply equiv_sq_path.
    apply path_ishprop.
  Defined.

  Global Instance isabgroup_ab_pullback
    : IsAbGroup (GrpPullback f g) := {}.

  Definition AbPullback
    : AbGroup := Build_AbGroup (GrpPullback f g) _ _ _ _.

  Proposition ab_pullback_corec {X : AbGroup}
              (b : X $-> B) (c : X $-> C)
              (p : f o b == g o c)
    : X $-> AbPullback.
  Proof.
    exact ((@grp_pullback_corec A B C f g X) b c p).
  Defined.

  Corollary ab_pullback_corec' {X : AbGroup}
    : {b : X $-> B & {c : X $-> C & f o b == g o c}}
      -> (X $-> AbPullback).
  Proof.
    intros [b [c p]]; exact (ab_pullback_corec b c p).
  Defined.

  Theorem isequiv_ab_pullback_corec {X : AbGroup} `{Funext}
    : IsEquiv (@ab_pullback_corec' X).
  Proof.
    srapply isequiv_grp_pullback_corec.
  Defined.

End AbPullback.
