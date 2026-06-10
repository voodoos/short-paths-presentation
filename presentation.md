---
dimension: 16:9
css: style.css
---

# Short path

{.block #slipshow pause}
**Disclaimer**: This time, **I am not** going to speak about slipshow. It is not going to happen.

{unstatic=slipshow pause}

Demo.

{pause up .carousel-fixed-size carousel #examples}
----

```ocaml
type t = string

let x = "How was the party yesterday?"
```

What is the type of `x`: `t`{.option} or `string`{.option}?

---

```ocaml
module X = struct
  type t = string
end

let x = "I'm so tired!"
```

What is the type of `x`: `X.t`{.option} or `string`{.option}?

---

```ocaml
module X = struct
  type t = string
end

open X

let x = "Me too"
```

What is the type of `x`: `t`{.option} or `string`{.option} or `X.t`{.option}?

---

```ocaml
module X = struct
  type t = string
end

let x = "I hope this talk is not too long"
```

What is the type of `x`: `string`{.option} or `X.t`{.option}?

---

```ocaml
open X (* Defines type [t = string] *)

let x = "I can't make sense of what the speaker says..."
```

What is the type of `x`: `string`{.option} or `t`{.option} or `X.t`{.option}?

---

```ocaml
(* X is in scope and defines [type t = string] *)

let x = "I'm only able to read the strings"
```

What is the type of `x`: `string`{.option} or `X.t`{.option}?

---

```ocaml
module X = struct
  type t = A
end

module Y = struct
  module X = X
end

let x = X.A
```

What is the type of `x`: `X.t`{.option} or `Y.X.t`{.option}?

---

```ocaml
module X = struct
  type t = A
end

module Y = struct
  module X = X
end

let x = Y.X.A
```

What is the type of `x`: `X.t`{.option} or `Y.X.t`{.option}?

---

```ocaml
module Y = struct
  module X = struct
    type t = A
  end
end

module X = Y.X

let x = X.A
```

What is the type of `x`: `X.t`{.option} or `Y.X.t`{.option}?

---

```ocaml
module Y = struct
  module X = struct
    type t = A
  end
end

module X = Y.X

let x = Y.X.A
```

What is the type of `x`: `X.t`{.option} or `Y.X.t`{.option}?

---

```ocaml
module X__ = struct
  type t = A
end

module Y = struct
  module X = X__
end

let x = Y.X.A
```

What is the type of `x`: `Y.X.t`{.option} or `X__.t`{.option}?

---

{include src=base-is-a-beast.md #beast .unstatic}

----

{pause=takeaways}

{change-page='examples'}

{change-page='~n:"2-5" examples'}

{pause=tkw1}

{change-page='~n:"6-9" examples'}

{pause=tkw2}

{change-page='examples'}

{pause=tkw3}

{pause=tkw4}

{change-page='examples' static=beast}

{focus=beast}

{unfocus down=takeaways}

{pause=tkw5}

{.block #takeaways}
> - **Takeaway 0**: Can't be always good. {#tkw1}
>
> - **Takeaway 1**: The path we want to show depends on what is in scope/how it is put in scope. {#tkw2}
>
> - **Takeaway 2**: The length of the path matters. {#tkw3}
>
> - **Takeaway 3**: We want to avoid paths including hidden modules.  {#tkw4}
>
> - **Takeaway 4**: We may have combinatorial explosion in the candidates. (Ulysse tu as un exemple de ça ?)  {#tkw5}
>
> - **Takeaway 5**: Base is a beast. [Completely fucked up]{.blinking-text}

{pause up=takeaways}

- **Conclusion 0**: We shouldn't list all possibilities.

- **Conclusion 1**: Between possibilities, we must find a heuristic.

  - Hidden is worse
  - Shorter is better
  - ...

- **Conclusion 3**: The path should be correct.

{pause up}
## The history of printing paths

{pause up}
## What's your solution?

{pause}

{.block}
[« The correct path is probably somewhere in the file. »]{style=font-size:1.1em;}
[(Leo, Gérard, Paul-Elliot, ICFP 2027 (Best paper award))]{style=float:right;font-size:0.8em}

{pause}

{style="display:flex" #mapper}
---
```ocaml
open Import

module M = Mapper

type t = Z of Zed.t

let x : X.t =
  List.map M.B.bourglify C.deprecated
```
---

![](d-cloud.draw){#d-cloud}

{draw=d-cloud}

{draw=d-cloud}

{draw=d-cloud}

{draw=d-cloud}

{draw=d-cloud}

{up="~margin:-60 mapper"}

{pause}

{up}
{.flex style="margin-top:400px"}
---

{include slip src="used-paths.md"}


{step}

{include slip src="discourse.md"}

{step}

{include slip src="shortening.md"}

---

{pause}

## Conclusion
