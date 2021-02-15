goal(state(west, west, west, west)).

deepen(state(east, east, east, east), state(west, east, west, east)) :- !.
deepen(state(A, A, A, B), state(B, B, A, B)).
deepen(state(A, A, A, B), state(B, A, B, B)).
deepen(state(A, A, B, A), state(B, A, B, A)).
deepen(state(A, A, B, A), state(B, B, B, A)).
deepen(state(A, B, A, A), state(B, B, B, A)).
deepen(state(A, B, A, A), state(B, B, A, B)).
deepen(state(A, B, A, B), state(B, B, A, B)).
deepen(state(A, B, A, B), state(B, B, B, B)).

depth(Path, State, [State | Path]) :-
  goal(State), !.

depth(Path, State, Solution) :-
  deepen(State, DeepState),
  \+memberchk(DeepState, Path),
  state(NextFarmer, NextWolf, NextGoat, NextCabbage) = DeepState,
  \+memberchk(state(NextFarmer, NextCabbage, NextGoat, NextWolf), Path),
  depth([State | Path], DeepState, Solution).

solve(State, Solution) :-
  depth([], State, Solution).
