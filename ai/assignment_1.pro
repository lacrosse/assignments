% 1

p([], []).
p([VH | VT], [VH | LT]) :-
  member(VH, VT),
  delete(VT, VH, VTWithoutVH),
  p(VTWithoutVH, LT).
p([VH | VT], L) :-
  \+member(VH, VT),
  p(VT, L).

% 2

subst([], _, _, []).
subst([X | VTail], X, Y, [Y | LTail]) :-
  subst(VTail, X, Y, LTail).
subst([Z | VTail], X, Y, [Z | LTail]) :-
  Z \= X,
  subst(VTail, X, Y, LTail).

% 3

number_partition(X, Y, Z):-
  Z_ is Z - 1,
  between(1, Z_, X),
  between(1, Z_, Y),
  plus(X, Y, Z).

% 4

list_partition(L1, N, L2, L3):-
  Comp = >(N),
  include(Comp, L1, L2),
  exclude(Comp, L1, L3).

% 5

consonant(C):- name("bcdfghjklmnpqrstvwxz", Consonants), memberchk(C, Consonants).
consonant_and_char(A, B, C):- consonant(A), name(C, [B]).
consonant_and_o(A, B):- consonant_and_char(A, B, "o").
consonant_and_y(A, B):- consonant_and_char(A, B, "y").
consonant_and_o_or_y(A, B):- consonant_and_y(A, B).
consonant_and_o_or_y(A, B):- consonant_and_o(A, B).

list_string_concat(L, S1, S2):-
  name(P, L),
  string_concat(P, S1, S2).

inflect([SecondToLast, Last], Inflection):-
  consonant_and_o(SecondToLast, Last),
  list_string_concat([SecondToLast], "oes", Inflection).

inflect([SecondToLast, Last], Inflection):-
  consonant_and_y(SecondToLast, Last),
  list_string_concat([SecondToLast], "ies", Inflection).

inflect([SecondToLast, Last], Inflection):-
  \+consonant_and_o_or_y(SecondToLast, Last),
  list_string_concat([SecondToLast, Last], "s", Inflection).

inflect([Last], Inflection):-
  list_string_concat([Last], "s", Inflection).

pluralize(Singular, Plural):-
  name(Singular, List),
  append(Init, [SecondToLast, Last], List),
  name(InitString, Init),
  inflect([SecondToLast, Last], Inflection),
  string_concat(InitString, Inflection, Plural).

pluralize(Singular, Plural):-
  name(Singular, List),
  [_] = List,
  inflect(List, Plural).
