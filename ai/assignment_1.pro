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

consonant(C) :- name("bcdfghjklmnpqrstvwxz", Consonants), memberchk(C, Consonants).
consonant_and_char(A, B, C) :- consonant(A), name(C, [B]).
consonant_and_o(A, B) :- consonant_and_char(A, B, "o").
consonant_and_y(A, B) :- consonant_and_char(A, B, "y").
consonant_and_o_or_y(A, B) :- consonant_and_y(A, B).
consonant_and_o_or_y(A, B) :- consonant_and_o(A, B).

list_string_concat(L, S1, S2) :-
  name(P, L),
  string_concat(P, S1, S2).

inflect([SecondToLast, Last], Inflection) :-
  consonant_and_o(SecondToLast, Last),
  list_string_concat([SecondToLast], "oes", Inflection).

inflect([SecondToLast, Last], Inflection) :-
  consonant_and_y(SecondToLast, Last),
  list_string_concat([SecondToLast], "ies", Inflection).

inflect([SecondToLast, Last], Inflection) :-
  \+consonant_and_o_or_y(SecondToLast, Last),
  list_string_concat([SecondToLast, Last], "s", Inflection).

inflect([Last], Inflection) :-
  list_string_concat([Last], "s", Inflection).

pluralize(Singular, Plural) :-
  name(Singular, List),
  append(Init, [SecondToLast, Last], List),
  name(InitString, Init),
  inflect([SecondToLast, Last], Inflection),
  string_concat(InitString, Inflection, Plural).

pluralize(Singular, Plural) :-
  name(Singular, List),
  [_] = List,
  inflect(List, Plural).
