# A new implementation of Short-paths

## Introduction

### What is short-paths?

The OCaml type system, and its module system in particular, is eminently
malleable. One of the consequences of their flexibility is that the same
entities can often be referred to by multiple paths in the same environment.

For example, if you consider the following snippet:

```ocaml
module X = struct
   type t = Unix.error
end

module Y = X

open X;;

let err = Unix.EMLINK;;
```

The type of `err`, at the location of its definition, could be referred to as
`Unix.error`, `X.t`, `Y.t`, or `t`. And this set of candidates can grow quickly
in large libraries, especially when they rely heavily on features such as `include`.
The conventional encapsulation of libraries with wrapper modules, named with
double underscores `__`, is also a common source of alternative paths that we should avoid showing to the user.

The mechanism choosing the best type is what we call "short-paths". It is
involved each time a type is printed; this happens for example when the compiler
prints an error, or when Merlin/OCaml-LSP prints the type of an expression as a
result of a user query.

It's not obvious how to define "best path", but the cost function should at least: 1. consider the number of components (separated by dots), prioritizing paths with fewer components, and 2. depreciate components containing a double underscore.

(Many other factors could be taken into account to break ties: favor candidates appearing close in the buffer, favor predefined types, etc.)

### Existing implementations

Short-paths is a feature that is surprisingly tricky to get right, that is, to provide a reasonable answer in a reasonable amount of time. In fact there already exist two implementations in the ecosystem.

One lives in the compiler itself and is used when printing error messages with the option `-short-paths` (enabled by default by Dune while in dev mode). It performs a lazy breadth-first search in the environment, one level at a time, until it finds an adequate candidate. It can miss good candidates by stopping too early (TODO example ?) and is rather costly. This not a problem for compiler output, where only a few types are printed in an error, but it is not acceptable for real-time applications such as Merlin.

For these reasons, there is a different implementation of short-paths in Merlin.
It is an extremely complex machine in comparison with the compiler one, but it
is able to explore deeper in the environment, faster, by smartly cutting
branches when possible. It provides better results, faster, but still misses
some cases, and its complexity makes it quite hard to maintain. The plan was to
upstream it to the compiler but it never happened.

Both have their flaws. This led co-author Leo White, the creator of the current Merlin implementation, to propose a new design, expected to be simpler, faster and more accurate.

## The new design

We introduce a notion of domain of discourse $\mathcal{D}$ which is the set of
paths that should be considered when shortening. One fundamental difference in
the new design is that some preprocessing is done during typing and saved as
part of the type signature in the `cmi` files: each (module, type, value, etc)
declaration is enriched with the set of paths that should be added to the
discourse if it is _used_.

We use a two-step process to build $\mathcal{D}$: we first build $\mathcal{U}$,
the set of paths explicitly appearing in the source file. Then we apply a number
of rules over paths in $\mathcal{U}$ to build the complete domain of discourse
$\mathcal{D}$ for the module. $\mathcal{U}$ is accumulated during typing, but
$\mathcal{U}\rightarrow\mathcal{D}$ is performed only before printing so as not
to slow down compilation.
