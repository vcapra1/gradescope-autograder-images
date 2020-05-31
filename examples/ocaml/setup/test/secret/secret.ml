open OUnit2
open Example

let test_add _ =
    assert_equal (add (add 1 2) 3) 6

let test_mk_tup _ =
    assert_equal (mk_tup 1 (mk_tup 2 3)) (1, (2, 3))

let suite = "secret" >::: [
    "add" >:: test_add;
    "mk_tup" >:: test_mk_tup
]

let _ = run_test_tt_main suite
