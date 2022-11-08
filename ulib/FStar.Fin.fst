(*
   Copyright 2008-2022 Microsoft Research

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)

module FStar.Fin

/// This module is supposed to contain various lemmas about
/// finiteness. For now, it mainly provides a basic pigeonhole
/// principle
///
/// TODO: We might generalize this to also support general utilities
/// for reasoning about cardinality, relation with injections and
/// surjections, etc.
///
/// UPD. November 8, 2022 -- added support for custom equivalence relation-aware
/// pigeon principle lemma.
///
/// Now I'll be able to prove that any finite commutative domain is a field, with ease :)

module L = FStar.List.Tot
module S = FStar.Seq

(** The type of natural numbers bounded by [n] *)
let fin (n: nat) = k: int {0 <= k /\ k < n} 
(** Newer synonym. We perhaps should choose one over another globally.
    [under] is also defined in IntegerIntervals.fst, along with other 
    often used finite intervals. *)
let under (p:nat) = x:nat {x<p}

(** Length-indexed list *)
let vect (n: nat) (a: Type) = l: list a {L.length l = n}

(** Length-indexed sequence *)
let seqn (n: nat) (a: Type) = s: S.seq a {S.length s = n}

(** [in_ s] is the type of a valid index into the sequence [s] *)
let in_ (#a: Type) (s: S.seq a) = n: nat{n < S.length s}

(** Find an index of an element in [s] starting from [i] that validates [p]  *)
let rec find (#a: Type) (s: S.seq a) (p: (a -> bool)) (i: under (S.length s))
    : Pure (option (in_ s))
      (requires True)
      (ensures (function
                | None -> (forall (k: nat{i <= k /\ k < S.length s}). p (S.index s k) == false)
                | Some j -> i <= j /\ p (S.index s j)))
      (decreases (S.length s - i)) =
  if p (S.index s i) 
  then Some i 
  else if i + 1 < S.length s 
       then find #a s p (i + 1) 
       else None

(** Given a sequence [s] all of whose elements are at most [n], if the
    length of [s] is greater than [n], then there are two distinct
    indexes in [s] that contain the same element *)
let rec pigeonhole (#n: pos) (s: S.seq (under n))
    : Pure (in_ s * in_ s)
      (requires S.length s = n + 1)
      (ensures (fun (i1, i2) -> i1 < i2 /\ S.index s i1 = S.index s i2))
      (decreases n) = 
   if n = 1 then (0, 1)
   else let k0 = S.index s 0 in
     match find s (fun k -> k = k0) 1 with
     | Some i -> 0, i
     | None -> let (i1,i2) = 
                pigeonhole (S.init #(under (n-1)) n
                                   (fun i -> let k = S.index s (i+1) in
                                          if k<k0 then k else k-1))
              in (i1+1, i2+1)
   
(** Here we prepare to prove pigeonhole principle for a finite sequence
    with a custom equivalence relation (as opposed to eqtype).
    
    Think setoids. *)

(** Following code is extracted from CuteCAS, which will eventually make 
    its way into F* -- when I wrap things up with most important notions
    of abstract algebra. 
    
    As I port more code from my CAS project to F*, such things will be
    moved to separate modules. -- Alex Rozanov *)
 
type binary_relation (a: Type) = a -> a -> bool
 
(** For performance reasons, forall definitions are best kept hidden from SMT.
    Use reveal_opaque when you really need it. Or use refl/trans/symm lemmas
    below to keep the context clean. *)
    
[@@"opaque_to_smt"]
let is_reflexive  (#a:Type) (r: binary_relation a) = forall (x:a).     x `r` x
[@@"opaque_to_smt"]
let is_symmetric  (#a:Type) (r: binary_relation a) = forall (x y:a).   x `r` y == y `r` x
[@@"opaque_to_smt"]
let is_transitive (#a:Type) (r: binary_relation a) = forall (x y z:a). x `r` y /\ y `r` z ==> x `r` z 

(** Textbook stuff on equivalence relations *)
type equivalence_relation (a: Type) 
  = r:binary_relation a { is_reflexive r /\ is_symmetric r /\ is_transitive r }

let refl_lemma #a (eq: equivalence_relation a) (x:a) : Lemma (eq x x)
  = reveal_opaque (`%is_reflexive) (is_reflexive eq)

let trans_lemma (#a:Type) (eq: equivalence_relation a) (x y z:a)
  : Lemma (requires (eq x y \/ eq y x) /\ (eq y z \/ eq z y))  
          (ensures (x `eq` z) && (z `eq` x))   
  = reveal_opaque (`%is_transitive) (is_transitive eq);
    reveal_opaque (`%is_symmetric) (is_symmetric eq)
 
let symm_lemma (#a:Type) (eq:equivalence_relation a) (x y:a) 
  : Lemma (eq x y == eq y x) 
  = reveal_opaque (`%is_symmetric) (is_symmetric eq) 

(** (contains) predicate, but with custom comparison operation (a->a->bool) *) 
[@@"opaque_to_smt"]
let contains_eq #a (eq: equivalence_relation a) (s: S.seq a) (x:a)
  = exists (i:under (S.length s)). eq x (S.index s i)

let contains_eq_means_nonempty #a (eq:equivalence_relation a) (s: S.seq a) (x:a)
  : Lemma (requires contains_eq eq s x) 
          (ensures S.length s > 0) 
          [SMTPat(contains_eq eq s x)] 
  = reveal_opaque (`%contains_eq) (contains_eq eq) 

(** a type of all elements present in a given sequence *)
let items_of #a (eq: equivalence_relation a) (s: S.seq a) = x:a { contains_eq eq s x } 
 
let tail_contains_eq #a (eq: equivalence_relation a) (s:S.seq a) 
                        (x:a { contains_eq eq s x /\ ~(eq x (S.head s)) })
  : Lemma (contains_eq eq (S.tail s) x) 
  = let t = S.tail s in  
    reveal_opaque (`%contains_eq) (contains_eq eq);  
    eliminate exists (i: under (S.length s)). eq x (S.index s i)
    returns exists (k: under (S.length t)). eq x (S.index t k) 
    with _. assert (S.index s i == S.index t (i-1))

(** retrieves the index of an element given prior knowledge of its presense 
    unlike find function above, that returns option, this one guarantees
    success, thus returning bare index instead. *)
let rec find_eq #a (eq:equivalence_relation a) (s: S.seq a) (x:a { contains_eq eq s x })
  : Tot (i: nat { (i < S.length s) /\ 
                (x `eq` S.index s i) /\ 
                (forall (j: under i). not (x `eq` S.index s j)) }) 
        (decreases S.length s) 
  = reveal_opaque (`%contains_eq) (contains_eq eq);  
    if S.length s = 1 then 0
    else if x `eq` S.index s 0 then 0 
         else begin
           tail_contains_eq eq s x; 
           let ieq = find_eq eq (S.tail s) x in 
           let aux (i: under (1 + ieq)) 
             : Lemma (not (x `eq` S.index s i)) 
             = if i > 0 
               then assert (S.index (S.tail s) (i-1) == S.index s i) 
           in Classical.forall_intro aux;
           1 + ieq
         end  
  
(** pigeonhole principle for setoids:
    If we have a nonempty sequence (all), and a sequence (s),
    and we know in advance that each item of (s) equals some 
    item in (all), equals meaning (eq), not (==),
    then we automatically know that there are at least
    2 equivalent elements in (s).
  
    This procedure returns the first such pair. *)

let rec pigeonhole_eq (#a:Type) (eq: equivalence_relation a) 
                      (holes: S.seq a{S.length holes > 0}) 
                      (pigeons: S.seq (items_of eq holes))
  : Pure (under (S.length pigeons) * under (S.length pigeons))
         (requires S.length pigeons > S.length holes)
         (ensures (fun (i1, i2) -> i1 < i2 /\ (S.index pigeons i1 `eq` S.index pigeons i2)))
         (decreases S.length holes) =   
  if S.length holes = 1 
  then begin 
    reveal_opaque (`%contains_eq) (contains_eq eq);  
    trans_lemma eq (S.index pigeons 0) (S.index holes 0) (S.index pigeons 1); 
    (0,1)
  end
  else let first_pigeon = S.index pigeons 0 in 
    match find pigeons (fun k -> eq k first_pigeon) 1 with
    | Some i -> (symm_lemma eq (S.index pigeons 0) (S.index pigeons i); (0,i))
    | None ->
      let index_of_first_pigeon = find_eq eq holes first_pigeon in //we carefully carve first_pigeon from (holes)
      let holes_except_first_pigeon = S.append (S.slice holes 0 (index_of_first_pigeon)) 
                                             (S.slice holes (index_of_first_pigeon+1) (S.length holes)) in 
      let all_but_first_pigeon_remain_in_reduced (x: items_of eq holes { not (eq x first_pigeon) }) 
        : Lemma (contains_eq eq holes_except_first_pigeon x) 
        = let index_of_x_in_holes = find_eq eq holes x in 
          reveal_opaque (`%contains_eq) (contains_eq eq);  
          if index_of_x_in_holes < index_of_first_pigeon 
          then assert (S.index holes index_of_x_in_holes == S.index holes_except_first_pigeon index_of_x_in_holes)
          else begin     
            // this serves to prove index_of_x_in_holes > index_of_first_pigeon (no equality!)
            Classical.move_requires (trans_lemma eq x (S.index holes index_of_x_in_holes)) first_pigeon; 
            // append/slice smtpat hint
            assert (S.index holes index_of_x_in_holes == S.index holes_except_first_pigeon (index_of_x_in_holes-1))
          end 
      in Classical.forall_intro all_but_first_pigeon_remain_in_reduced; 
      let i1, i2 = pigeonhole_eq (eq) (holes_except_first_pigeon)  
                                      (S.init #(items_of eq holes_except_first_pigeon)
                                              (S.length pigeons - 1) 
                                              (fun i -> S.index pigeons (i+1)))
      in (i1+1, i2+1)
  
