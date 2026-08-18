
# [Phase 1: Collect used path]{.very-big}

![](used-path-1.draw){#used-path-exp}

{style=width:50% carousel .carousel-fixed-size #use-path-ex}
----
```ocaml
module X = struct
  module Y = struct
    type t = A

    let f A = A
  end
end
```
```ocaml
module X = struct
  module Y = struct
    type t = A

    let f A = A
  end
end



let map_f = List.map X.Y.f
```
```ocaml
module X = struct
  module Y = struct
    type t = A

    let f A = A
  end
end

open List

let map_f =      map X.Y.f
```
----

{ draw=used-path-exp}

{pause=u-rule1 draw=used-path-exp}

{change-page="use-path-ex" draw=used-path-exp}

{pause=u-rule2 draw=used-path-exp}

{change-page="use-path-ex" draw=used-path-exp}

{pause=u-rule3 draw=used-path-exp}

{#u-rule1}

- **Rule 1:** Paths defined in the file are in `U`, {#u-rule2}

- **Rule 2:** Paths used in the file are in `U`, {#u-rule3}

- **Rule 3:** Paths defined via an `open` are in `U`
