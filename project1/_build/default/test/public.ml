open OUnit2
open P2b.Data
open P2b.Funs
open P2b.Higher
open TestUtils

let test_high_order_1 ctxt =
  assert_equal 0 @@ (len []);
  assert_equal 1 @@ (len [1]);
  assert_equal 5 @@ (len [1; 2; 2; 1; 3]);

  assert_equal 0 @@ (count_greater [] 5);
  assert_equal 0 @@ (count_greater [5] 5);
  assert_equal 3 @@ (count_greater [8; 5; 6; 6; 3] 5);

  assert_equal [] @@ (greater_tuple []);
  assert_equal [(1, 0)] @@ (greater_tuple [1]);
  assert_equal [(1, 3); (2, 1); (2, 1); (1, 3); (3, 0)] @@ (greater_tuple [1; 2; 2; 1; 3])

let test_high_order_2 ctxt =
  assert_equal [] @@ (rm [] 1);
  assert_equal [2] @@ (rm [2] 2);
  assert_equal [3;3] @@ (rm [3; 3] 3);
  assert_equal [1; 3; 1; 2] @@ (rm [1; 3; 1; 2] 5);
  assert_equal [1; 1] @@ (rm [1; 3; 1; 2] 1)

let test_elem ctxt =
  assert_equal false (elem 3 (create_set [])) ~msg:"elem (1)" ~printer:string_of_bool;
  assert_equal true (elem 5 (create_set [2;3;5;7;9])) ~msg:"elem (2)" ~printer:string_of_bool;
  assert_equal false (elem 4 (create_set [2;3;5;7;9])) ~msg:"elem (3)" ~printer:string_of_bool

let test_subset ctxt =
  assert_equal true (subset (create_set [2]) (create_set [2;3;5;7;9])) ~msg:"subset (1)" ~printer:string_of_bool;
  assert_equal true (subset (create_set [3;5]) (create_set [2;3;5;7;9])) ~msg:"subset (2)" ~printer:string_of_bool;
  assert_equal false (subset (create_set [4;5]) (create_set [2;3;5;7;9])) ~msg:"subset (3)" ~printer:string_of_bool

let test_remove ctxt =
  assert_set_equal_msg (create_set []) (remove 5 (create_set [])) ~msg:"remove (1)";
  assert_set_equal_msg (create_set [2;3;7;9]) (remove 5 (create_set [2;3;5;7;9])) ~msg:"remove (2)";
  assert_set_equal_msg (create_set [2;3;5;7;9]) (remove 4 (create_set [2;3;5;7;9])) ~msg:"remove (3)"

let test_union ctxt =
  assert_set_equal_msg (create_set [2;3;5]) (union (create_set []) (create_set [2;3;5])) ~msg:"union (1)";
  assert_set_equal_msg (create_set [2;3;5;7;9]) (union (create_set [2;5]) (create_set [3;7;9])) ~msg:"union (2)";
  assert_set_equal_msg (create_set [2;3;7;9]) (union (create_set [2;3;9]) (create_set [2;7;9])) ~msg:"union (3)"

let test_diff ctxt =
  assert_set_equal_msg (create_set [1]) (diff (create_set [1;2;3]) (create_set [2;3])) ~msg:"diff (1)";
  assert_set_equal_msg (create_set ['b';'c';'d']) (diff (create_set ['a';'b';'c';'d']) (create_set ['a';'e';'i';'o';'u'])) ~msg:"diff (2)";
  assert_set_equal_msg (create_set ["hello";"ocaml"]) (diff (create_set ["hello";"ocaml"]) (create_set ["hi";"ruby"])) ~msg:"diff (3)"

let test_int_tree ctxt =
  let t0 = empty_int_tree in
  let t1 = (int_insert 3 (int_insert 11 t0)) in
  let t2 = (int_insert 13 t1) in
  let t3 = (int_insert 17 (int_insert 3 (int_insert 1 t2))) in

  assert_equal 0 @@ (int_size t0);
  assert_equal 2 @@ (int_size t1);
  assert_equal 3 @@ (int_size t2);
  assert_equal 5 @@ (int_size t3);

  assert_raises (Invalid_argument("int_max")) (fun () -> int_max t0);
  assert_equal 11 @@ int_max t1;
  assert_equal 13 @@ int_max t2;
  assert_equal 17 @@ int_max t3

(* if something is inserted into an empty tree, int_size should return positive value *)
let test_int_tree_qcheck =
  QCheck.Test.make
    ~count:500
    ~name: "test_int_tree_qcheck"
    (QCheck.int)
    (fun i -> int_size (int_insert i (empty_int_tree)) > 0)

let test_ptree_1 ctxt =
  let r0 = empty_ptree Pervasives.compare in
  let r1 = (pinsert 2 (pinsert 1 r0)) in
  let r2 = (pinsert 3 r1) in
  let r3 = (pinsert 5 (pinsert 3 (pinsert 11 r2))) in
  let a = [5;6;8;3;11;7;2;6;5;1]  in
  let x = [5;6;8;3;0] in
  let z = [7;5;6;5;1] in
  let r4a = pinsert_all x r1 in
  let r4b = pinsert_all z r1 in

  let strlen_comp x y = Pervasives.compare (String.length x) (String.length y) in
  let k0 = empty_ptree strlen_comp in
  let k1 = (pinsert "hello" (pinsert "bob" k0)) in
  let k2 = (pinsert "sidney" k1) in
  let k3 = (pinsert "yosemite" (pinsert "ali" (pinsert "alice" k2))) in
  let b = ["hello"; "bob"; "sidney"; "kevin"; "james"; "ali"; "alice"; "xxxxxxxx"] in

  assert_equal [false;false;false;false;false;false;false;false;false;false] @@ map (fun y -> pmem y r0) a;
  assert_equal [false;false;false;false;false;false;true;false;false;true] @@ map (fun y -> pmem y r1) a;
  assert_equal [false;false;false;true;false;false;true;false;false;true] @@ map (fun y -> pmem y r2) a;
  assert_equal [true;false;false;true;true;false;true;false;true;true] @@ map (fun y -> pmem y r3) a;

  assert_equal [false;false;false;false;false;false;false;false] @@ map (fun y -> pmem y k0) b;
  assert_equal [true;true;false;true;true;true;true;false] @@ map (fun y -> pmem y k1) b;
  assert_equal [true;true;true;true;true;true;true;false] @@ map (fun y -> pmem y k2) b;
  assert_equal [true;true;true;true;true;true;true;true] @@ map (fun y -> pmem y k3) b;

  assert_equal [true;true;true;true;true] @@ map (fun y -> pmem y r4a) x;
  assert_equal [true;true;false;false;false] @@ map (fun y -> pmem y r4b) x;
  assert_equal [false;true;true;true;true] @@ map (fun y -> pmem y r4a) z;
  assert_equal [true;true;true;true;true] @@ map (fun y -> pmem y r4b) z

let test_ptree_2 ctxt =
  let q0 = empty_ptree Pervasives.compare in
  let q1 = pinsert 1 (pinsert 2 (pinsert 0 q0)) in
  let q2 = pinsert 5 (pinsert 11 (pinsert (-1) q1)) in
  let q3 = pinsert (-7) (pinsert (-3) (pinsert 9 q2)) in
  let f = (fun x -> x + 10) in
  let g = (fun y -> y * (-1)) in

  assert_equal [] @@ p_as_list q0;
  assert_equal [0;1;2] @@ p_as_list q1;
  assert_equal [-1;0;1;2;5;11] @@ p_as_list q2;
  assert_equal [-7;-3;-1;0;1;2;5;9;11] @@ p_as_list q3;

  assert_equal [] @@ p_as_list (pmap f q0);
  assert_equal [10;11;12] @@ p_as_list (pmap f q1);
  assert_equal [9;10;11;12;15;21] @@ p_as_list (pmap f q2);
  assert_equal [3;7;9;10;11;12;15;19;21] @@ p_as_list (pmap f q3);

  assert_equal [] @@ p_as_list (pmap g q0);
  assert_equal [-2;-1;0] @@ p_as_list (pmap g q1);
  assert_equal [-11;-5;-2;-1;0;1] @@ p_as_list (pmap g q2);
  assert_equal [-11;-9;-5;-2;-1;0;1;3;7] @@ p_as_list (pmap g q3)

let suite =
  "public" >::: [
    "high_order_1" >:: test_high_order_1;
    "high_order_2" >:: test_high_order_2;
    "elem" >:: test_elem;
    "subset" >:: test_subset;
    "remove" >:: test_remove;
    "union" >:: test_union;
    "diff" >:: test_diff;
    "int_tree" >:: test_int_tree;
    QCheck_runner.to_ounit2_test test_int_tree_qcheck;
    "ptree_1" >:: test_ptree_1;
    "ptree_2" >:: test_ptree_2;
  ]

let _ = run_test_tt_main suite
