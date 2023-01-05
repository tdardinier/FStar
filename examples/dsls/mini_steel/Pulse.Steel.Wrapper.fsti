module Pulse.Steel.Wrapper

open Steel.ST.Effect
open Steel.Memory
open Steel.ST.Util

unfold 
let eq_vprop (p1 p2:vprop) : prop = Prims.eq2 p1 p2

inline_for_extraction
val stt (a:Type u#a) (pre:vprop) (post:a -> vprop) : Type0

inline_for_extraction
val return_stt (#a:Type u#a) (x:a) : stt a emp (fun r -> pure (r == x))

inline_for_extraction
val return_stt_noeq (#a:Type u#a) (x:a) : stt a emp (fun _ -> emp)

inline_for_extraction
val bind_stt (#a:Type u#a) (#b:Type u#b) (#pre1:vprop) (#post1:a -> vprop) (#post2:b -> vprop)
  (e1:stt a pre1 post1)
  (e2:(x:a -> stt b (post1 x) post2))

  : stt b pre1 post2

inline_for_extraction
val frame_stt (#a:Type u#a) (#pre:vprop) (#post:a -> vprop) (frame:vprop) (e:stt a pre post)
  : stt a (pre `star` frame) (fun x -> post x `star` frame)

val vprop_equiv (p q:vprop) : prop
val vprop_post_equiv (#t:Type u#a) (p q: t -> vprop) : prop

val intro_vprop_post_equiv
       (#t:Type u#a) 
       (p q: t -> vprop)
       (pf: (x:t -> vprop_equiv (p x) (q x)))
  : vprop_post_equiv p q

val elim_vprop_post_equiv (#t:Type u#a)
                          (p q: t -> vprop) 
                          (pf:vprop_post_equiv p q)
                          (x:t) 
    : vprop_equiv (p x) (q x)

inline_for_extraction
val sub_stt (#a:Type u#a)
            (#pre1:vprop)
            (pre2:vprop)
            (#post1:a -> vprop)
            (post2:a -> vprop)
            (pf1 : vprop_equiv pre1 pre2)
            (pf2 : vprop_post_equiv post1 post2)
            (e:stt a pre1 post1)
  : stt a pre2 post2

val vprop_equiv_refl (v0:vprop) : vprop_equiv v0 v0

val vprop_equiv_sym (v0 v1:vprop) (_:vprop_equiv v0 v1)
  : vprop_equiv v1 v0

val vprop_equiv_trans (v0 v1 v2:vprop) (_:vprop_equiv v0 v1) (_:vprop_equiv v1 v2)
  : vprop_equiv v0 v2

val vprop_equiv_unit (x:vprop) : vprop_equiv (emp `star` x) x

val vprop_equiv_comm (p1 p2:vprop)
  : vprop_equiv (p1 `star` p2) (p2 `star` p1)

val vprop_equiv_assoc (p1 p2 p3:vprop)
  : vprop_equiv ((p1 `star` p2) `star` p3) (p1 `star` (p2 `star` p3))

val vprop_equiv_cong (p1 p2 p3 p4:vprop)
                     (_: vprop_equiv p1 p3)
                     (_: vprop_equiv p2 p4)
  : vprop_equiv (p1 `star` p2) (p3 `star` p4)

val vprop_equiv_ext (p1 p2:vprop) (_:eq_vprop p1 p2)
  : vprop_equiv p1 p2

module G = FStar.Ghost
module U32 = FStar.UInt32
module R = Steel.ST.Reference

type u32 : Type0 = U32.t

// val erased : Type0
// val hide (x:u32) : erased
// val reveal (x:erased) : GTot u32

// val hide_reveal (x:u32)
//   : Lemma (reveal (hide x) == x)
//           [SMTPat (reveal (hide x))]

// val reveal_hide (x:erased)
//   : Lemma (hide (reveal x) == x)
//           [SMTPat (hide (reveal x))]

// val ref (a:Type0) : Type0
// val pts_to (r:ref) (n:erased) : vprop
// val ptr (r:ref) : vprop
open FStar.Ghost
val read (n:erased u32) (r:R.ref u32)
  : stt u32 (R.pts_to r full_perm n) (fun x -> R.pts_to r full_perm x)

val read_refine (n:erased u32) (r:R.ref u32)
  : stt (x:u32{reveal n == x}) (R.pts_to r full_perm n) (fun x -> R.pts_to r full_perm n)

val read_alt (n:erased u32) (r:R.ref u32)
  : stt u32 (R.pts_to r full_perm n) (fun x -> R.pts_to r full_perm n)

val write (n:erased u32) (r:R.ref u32) (x:u32)
  : stt unit (R.pts_to r full_perm n) (fun _ -> R.pts_to r full_perm (hide x))

val write_alt (n:erased u32) (r:R.ref u32) (x:u32)
  : stt unit (R.pts_to r full_perm n) (fun _ -> exists_ (R.pts_to r full_perm))
