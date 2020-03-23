(*
   Copyright 2008-2020 Microsoft Research

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

module Relations

open FStar.Tactics.Typeclasses


type relation a = a -> a -> Type

type reflexive #a (r : relation a) = forall x. r x x  

type symmetric #a (r : relation a) = forall x y. r x y -> r y x  

type transitive #a (r : relation a) = forall x y z. r x y -> r y z -> r x z 

class equivalence #a (r : relation a) = { refl : reflexive r; 
                                          symm : symmetric r; 
                                          trans : transitive r } 


(* or (?) *)


class equiv #a (r : relation a) = { refl' : x:a -> Lemma (r x x); 
                                    symm' : x:a -> y:a -> (_ : (squash (r x y))) -> Lemma (r y x); 
                                    trans' : x:a -> y:a -> z:a -> (_ : (squash (r x y))) -> (_ : (squash (r y z))) -> Lemma (r x z) } 


(** The rest is not used *)
(* TODO : generic curry - uncurry operators for dependent pairs *)

let uncurry #a #b (r : a -> b -> a -> b -> Type) : relation (a * b) = 
  fun x1 x2 -> r (fst x1) (snd x1) (fst x2) (snd x2)

let curry #a #b (r : relation (a * b)) : a -> b -> a -> b -> Type  = 
  fun x1 x2 y1 y2 -> r (x1, x2) (y1, y2)

let uncurry3 #a #b #c (r : a -> b -> c -> a -> b -> c -> Type) : relation (a * b * c) = 
  fun (x, y, z) (x', y', z') -> r x y z x' y' z'
  
let curry3 #a #b #c (r : relation (a * b * c)) : a -> b -> c -> a -> b -> c -> Type  = 
  fun x y z x' y' z' -> r (x, y, z) (x', y', z')


