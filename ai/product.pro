product(A, B, C):-
  product(A, B, 0, C).

product(_, 0, C, C).

product(A, B, S, C):-
  B_ is B - 1,
  S_ is S + A,
  product(A, B_, S_, C).
