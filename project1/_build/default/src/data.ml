(****************)
(* Part 2: Sets *)
(****************)

let rec elem x a = failwith "unimplemented"

let rec insert x a = failwith "unimplemented"

let rec subset a b = failwith "unimplemented"

let rec eq a b = failwith "unimplemented"

let rec remove x a = failwith "unimplemented"

let rec union a b = failwith "unimplemented"

let rec diff a b = failwith "unimplemented"

(***********************)
(* Part 3: Integer BST *)
(***********************)

type int_tree =
  | IntLeaf
  | IntNode of int_tree * int_tree * int

let empty_int_tree = IntLeaf

let rec int_insert x t =
  match t with
  | IntLeaf -> IntNode(IntLeaf, IntLeaf, x)
  | IntNode (l, r, y) when x > y -> IntNode (l, int_insert x r, y)
  | IntNode (l, r, y) when x = y -> t
  | IntNode (l, r, y) -> IntNode (int_insert x l, r, y)

let rec int_mem x t =
  match t with
  | IntLeaf -> false
  | IntNode (l, r, y) when x > y -> int_mem x r
  | IntNode (l, r, y) when x = y -> true
  | IntNode (l, r, y) -> int_mem x l

(* Implement the functions below. *)

let rec int_size t = failwith "unimplemented"

let rec int_max t = failwith "unimplemented"

let rec int_insert_all lst t = failwith "unimplemented"

let rec int_as_list t = failwith "unimplemented"

(***************************)
(* Part 4: Polymorphic BST *)
(***************************)

type 'a atree =
    Leaf
  | Node of 'a * 'a atree * 'a atree
type 'a compfn = 'a -> 'a -> int
type 'a ptree = 'a compfn * 'a atree

let empty_ptree f : 'a ptree = (f,Leaf)

(* Implement the functions below. *)

let pinsert x t = failwith "unimplemented"

let pmem x t = failwith "unimplemented"

let pinsert_all lst t = failwith "unimplemented"

let rec p_as_list t = failwith "unimplemented"

let pmap f t = failwith "unimplemented"
