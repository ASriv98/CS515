val elem : 'a -> 'a list -> bool
val insert : 'a -> 'a list -> 'a list
val subset : 'a list -> 'a list -> bool
val eq : 'a list -> 'a list -> bool
val remove : 'a -> 'a list -> 'a list
val union : 'a list -> 'a list -> 'a list
val diff : 'a list -> 'a list -> 'a list

type int_tree =
    IntLeaf
  | IntNode of int_tree * int_tree * int

val empty_int_tree : int_tree


val int_size : int_tree -> int
val int_max : int_tree -> int
val int_insert : int -> int_tree -> int_tree
val int_mem : int -> int_tree -> bool
val int_insert_all : int list -> int_tree -> int_tree
val int_as_list : int_tree -> int list

type 'a atree =
    Leaf
  | Node of 'a * 'a atree * 'a atree
type 'a compfn = 'a -> 'a -> int
type 'a ptree = 'a compfn * 'a atree
val empty_ptree : 'a compfn -> 'a ptree

val pinsert : 'a -> 'a ptree -> 'a ptree
val pmem : 'a -> 'a ptree -> bool
val pinsert_all : 'a list -> 'a ptree -> 'a ptree
val p_as_list : 'a ptree -> 'a list
val pmap : ('a -> 'a) -> 'a ptree -> 'a ptree
