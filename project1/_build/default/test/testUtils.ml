open OUnit2

let assert_true x = assert_equal true x;;
let assert_false x = assert_equal false x;;

let create_set l =
  let rec create_set_helper acc = function
    | [] -> acc
    | h::t -> create_set_helper (P2b.Data.insert h acc) t
  in
  create_set_helper [] l

let assert_set_equal_msg x y ~msg =
  assert_equal true (P2b.Data.eq x y) ~msg:msg
let assert_set_equal x y = assert_equal true (P2b.Data.eq x y)

let string_of_list f xs =
  "[" ^ (String.concat "; " (List.map f xs)) ^ "]"

let string_of_int_pair (x, y) =
  "(" ^ (string_of_int x) ^ ", " ^ (string_of_int y) ^ ")"

let string_of_int_list = string_of_list string_of_int
let string_of_int_pair_list = string_of_list string_of_int_pair
