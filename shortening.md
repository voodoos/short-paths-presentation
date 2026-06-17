# [Phase 3: Use it to find path]{.very-big}

During phase 1 and 2 we accumulated a number of paths and substitutions. The rest of the job is fairly straightforward: we apply the substitutions to close the set of paths and then search it for the best one.

However, we much approach this carefully to answer as fast as possible. Here is how we currently proceed:

1. First we apply the substitution to paths' prefixes. For example,  applying substitution `Foo -> Lib_foo.Foo` to path `Lib_foo.Foo.t` adds `Foo.t` to the discourse.

2. Then we verse all the discourse paths into a priority queue sorted by their length.

3. We treat the priority queue one level at a time. For each path, we canonicalize it in the current environment and store it in a table mapping canonical paths to shorter candidates.

```
Env.normalize_module_path Foo.t -> Lib_foo__Foo.t
```

4. At the end of each level, we check if that table now contains a candidate for the path we are trying to shorten. By checking each-of-them validity in the current environement. If it does we stop and return the result. If not we go back to step 3, treating the next level.

To validate our work we run Merlin randomly over hundreds of location in Base and compare the output with the previous version of short paths.

{ up }
```diff
-  val t_of_sexp : Sexp_type.Sexp.t -> t
-  val sexp_of_t : t -> Sexp_type.Sexp.t
-  val sexp_of_t__stack : t @ local -> Sexp_type.Sexp.t @ local
+  val t_of_sexp : Sexp.t -> t
+  val sexp_of_t : t -> Sexp.t
+  val sexp_of_t__stack : t @ local -> Sexp.t @ local

-  val hash_fold_t :
-    Base_internalhash_types.state -> 'a t -> Base_internalhash_types.state @@
-    portable
+  val hash_fold_t : Hash.state -> 'a t -> Hash.state @@ portable

-    functor (T : Base__T.T1__any) ->
+    functor (T : T1__any) ->

-    functor (T : Base__T.T2__any__any) ->
+    functor (T : T2__any__any) ->

-    functor (T : Base__T.T3__any__any__any) ->
+    functor (T : T3__any__any__any) ->

-    functor (T : Base__T.T4__any__any__any__any) ->
+    functor (T : T4__any__any__any__any) ->
```

And many__any__any__any__any others!
