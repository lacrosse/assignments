% 1

p([], []).
p([VH | VT], [VH | LT]) :-
  member(VH, VT),
  delete(VT, VH, VTWithoutVH),
  p(VTWithoutVH, LT),
  !.
p([VH | VT], L) :-
  \+member(VH, VT),
  p(VT, L).

% 2

subst([], _, _, []).
subst([X | VTail], X, Y, [Y | LTail]) :-
  subst(VTail, X, Y, LTail),
  !.
subst([Z | VTail], X, Y, [Z | LTail]) :-
  Z \= X,
  subst(VTail, X, Y, LTail).

% 3

plus(X, Y, Z) :-
  number(Z),
  between(0, Z, Y),
  X is Z - Y.

plus(X, Y, Z) :-
  number(X),
  number(Y),
  Z is X + Y.

% 4

:- use_module(library(apply)).

list_partition(L1, N, L2, L3) :-
  partition(>(N), L1, L2, L3).

% 4'

list_partition_([], _, [], []).
list_partition_([H | T], N, [H | TL2], L3) :-
  H < N, !,
  list_partition_(T, N, TL2, L3).
list_partition_([H | T], N, L2, [H | TL3]) :-
  list_partition_(T, N, L2, TL3).

% 5

is_lowercase_consonant(C) :- sub_string("bcdfghjklmnpqrstvwxz", _, 1, _, C), !.

pluralize(Singular, Inflection) :-
  sub_string(Singular, _, 1, 1, Penultimate)
  -> (
    is_lowercase_consonant(Penultimate)
    -> (
      sub_string(Singular, _, _, 0, "o")
      ->  string_concat(Singular, "es", Inflection)
      ;   sub_string(Singular, _, _, 0, "y")
      ->  sub_string(Singular, 0, _, 1, Init),
          string_concat(Init, "ies", Inflection)
      ;   string_concat(Singular, "s", Inflection)
    )
    ; string_concat(Singular, "s", Inflection)
  )
  ; string_concat(Singular, "s", Inflection).
