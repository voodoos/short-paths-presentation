# [Phase 2: The discourse]{.very-big}

![](phase-2.draw){draw}

{pause style=margin-top:556px}

{up}
- **Rule 2**: If a path is in `U`, it is in `D`

```ocaml
type t = A
```

- **Rule 3**: If a module path is in `U` then all the paths of its subcomponents are in `D`.

```ocaml
let map = List.map
```

- **Rule 6**: If a type path is in `U` then any paths used in its equation or representation are in `D`.


```ocaml
(** import.ml *)

type t = Foo of A.B.t | Bar
```

```ocaml
let x : Import.t = Bar
```

- **Rule 11**: If a path is in D and it includes another module path within it, then that
      module path is also in D.

```ocaml
TODO
```

- **Rule 12**: If a module path m in D - note D not U - is a module alias with target n
      and another path p in D includes n within it, then the path obtained by
      substituting the m for n in p is also in D.

```ocaml
TODO
```
