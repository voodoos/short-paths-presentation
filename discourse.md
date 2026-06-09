# [Phase 2: The discourse]{.very-big}

{pause}

We are only going to see _some_ of the rules.

```ocaml
(** import.ml *)

type t = Foo of A.B.t | Bar
```

```ocaml
let x : Import.t = Bar
```

{pause}

```ocaml
open Import

let x = Bar
```

{pause}

```ocaml
let x = Import.Bar
```
