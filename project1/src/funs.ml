let rec map f xs = match xs with
| [] -> []
| x :: xt -> (f x)::(map f xt)

let rec fold f a xs = match xs with
| [] -> a
| x :: xt -> fold f (f a x) xt

let rec fold_right f xs a = match xs with
| [] -> a
| x :: xt -> f x (fold_right f xt a)

let rev xs = fold (fun a x -> x :: a) [] xs

let append x y =
  fold_right (fun z a -> z::a) x y