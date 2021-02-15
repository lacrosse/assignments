:- multifile system/1, askable/1, explainThis/1, clause_cf/3.
:- dynamic askable/1, clause_cf/3, untrue/1, explain_this/1.

expert :-
  write("Set the goal: "), read(Goal),
  solve(Goal, [], Certainty, Proof), nl,
  write("Proven "), write(Goal), write(" with certainty "), write(Certainty), nl,
  write("Interpretation:"), nl,
  interpret(Proof),
  write("Repeat? "), read(Repeat), expert(Repeat).

expert(yes) :- expert.
expert(no) :- true.

solve(true, _, 1, _) :- !.
solve((A, B), Rules, Certainty, (ProofA, ProofB)) :-
  !,
  solve(A, Rules, CertaintyA, ProofA),
  solve(B, Rules, CertaintyB, ProofB),
  Certainty is min(CertaintyA, CertaintyB).
solve(\+A, Rules, 1, unprovable(A)) :-
  !,
  \+solve(A, Rules, _, _).
solve(A, Rules, Certainty, (A :- Proof)) :-
  \+is_builtin(A),
  clause(A, B),
  solve(B, [rule(A, B) | Rules], Certainty, Proof).
solve(A, Rules, Certainty, (A :- Proof)) :-
  \+is_builtin(A),
  clause_cf(A, B, CertaintyA),
  solve(B, [rule(A, B) | Rules], CertaintyB, Proof),
  Certainty is min(CertaintyA, CertaintyB).
solve(A, _, 1, (A :- true)) :-
  is_builtin(A),
  A.
solve(A, Rules, Certainty, (A :- _)) :-
  askable(A),
  \+known(A),
  ask_respond(A, Rules, Certainty).

is_builtin(is(_, _)).
is_builtin(_ = _).
is_builtin(_ < _).
is_builtin(_ > _).
is_builtin(member(_, _)).
is_builtin(write(_)).
is_builtin(read(_)).
is_builtin(nl).

interpret((ProofA,ProofB)) :- !, interpret(ProofA), interpret(ProofB).
interpret((A :- 'as stated')) :- !, nl, write(A), write(' <= as stated'), nl.
interpret(unprovable(A)) :- !, nl, write(A), write(' <= unprovable'), nl.
interpret(Proof) :- fact(Proof, Fact), explain_fact(Fact).
interpret(Proof) :- rule(Proof, Head, Body, NextProof), explain_rule(Head, Body), interpret(NextProof).

fact((Fact :- true), Fact).
rule((Goal :- Proof), Goal, Body, Proof) :- Proof \= true, extract_body(Proof, Body).

extract_body((ProofA, ProofB), (BodyA, BodyB)) :- !, extract_body(ProofA, BodyA), extract_body(ProofB, BodyB).
extract_body((Goal :- _), Goal).
extract_body(unprovable(B), \+B).

explain_fact(Fact) :- explain_this(Fact), !,nl, write(Fact), write(' is a fact'), nl.
explain_fact(_).

explain_rule(Head, Body) :- explain_this(Head), !, write(Head), write(' proven by the following: '), display_rule(rule(Head, Body)).
explain_rule(_, _).

explain_this(member(_, _)).

ask_respond(A, Rules, C) :- display_query(A), read(Answer), respond(Answer, A, Rules, C).
respond(yes, A, _, 1) :- assertz(A).
respond(no, A, _, 0) :- assertz(untrue(A)), false.
respond(why, A, Rules, C) :- var(Rules), !, write(' trying falsehood of '), write(A), nl, ask_respond(A, [], C).
respond(why, A, [Rule | Rules], C) :- write(' trying the rule:'), nl, display_rule(Rule), ask_respond(A, [Rule | Rules], C).
respond(why, A, [], C) :- write(' <== out of explanations'), nl, ask_respond(A, [], C).
respond(C, A, _, C) :- number(C), C > 0, assertz(clause_cf(A, true, C)).
respond(0, A, _, 0) :- assertz(untrue(A)), false.

known(A) :- clause_cf(A, true, _), !.
known(A) :- A, !.
known(A) :- untrue(A).

display_query(A) :- write(A), write('? ').
display_rule(rule(A, B)) :- nl, write('If '), write_conjunction(B), write('    then '), write(A), nl.
write_conjunction((A, B)) :- !, write_conjunction(A), write(' and '), write_conjunction(B), nl.
write_conjunction(A) :- write(A).
