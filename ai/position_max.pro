position_max([X | T], M, N):-
  position_max(T, 1, X, 1, M, N).

position_max([], _, M, N, M, N).

position_max([A | T], I, X, _, M, N):-
  A > X,
  K is I + 1,
  position_max(T, K, A, K, M, N).

position_max([A | T], I, X, Y, M, N):-
  A =< X,
  K is I + 1,
  position_max(T, K, X, Y, M, N).
