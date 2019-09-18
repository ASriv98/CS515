open OUnit2
open P2b.Data
open P2b.Funs
open P2b.Higher
open TestUtils

let test_sanity ctxt =
  assert_equal 1 1

let suite =
  "student" >::: [
    "sanity" >:: test_sanity
  ]

let _ = run_test_tt_main suite
