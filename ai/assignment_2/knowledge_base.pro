:- op(100, xfx, [has_personality_type, is_actually, does, has_nationality, has_trait, tested_as]).
:- dynamic has_trait/2, does/2, has_personality_type/2, is_actually/2, has_nationality/2.
:- discontiguous explain_this/1.

:- include('expert_system.pro').

X has_personality_type architect :- X has_trait introverted, X has_trait intuitive, X has_trait thinking, X has_trait judging.
X has_personality_type logician :- X has_trait introverted, X has_trait intuitive, X has_trait thinking, X has_trait prospecting.
X has_personality_type commander :- X has_trait extraverted, X has_trait intuitive, X has_trait thinking, X has_trait judging.
X has_personality_type debater :- X has_trait extraverted, X has_trait intuitive, X has_trait thinking, X has_trait prospecting.
X has_personality_type advocate :- X has_trait introverted, X has_trait intuitive, X has_trait feeling, X has_trait judging.
X has_personality_type mediator :- X has_trait introverted, X has_trait intuitive, X has_trait feeling, X has_trait prospecting.
X has_personality_type protagonist :- X has_trait extraverted, X has_trait intuitive, X has_trait feeling, X has_trait judging.
X has_personality_type campaigner :- X has_trait extraverted, X has_trait intuitive, X has_trait feeling, X has_trait prospecting.
X has_personality_type logistician :- X has_trait introverted, X has_trait observant, X has_trait thinking, X has_trait judging.
X has_personality_type defender :- X has_trait introverted, X has_trait observant, X has_trait feeling, X has_trait judging.
X has_personality_type executive :- X has_trait extraverted, X has_trait observant, X has_trait thinking, X has_trait judging.
X has_personality_type consul :- X has_trait extraverted, X has_trait observant, X has_trait feeling, X has_trait judging.
X has_personality_type virtuoso :- X has_trait introverted, X has_trait observant, X has_trait thinking, X has_trait prospecting.
X has_personality_type adventurer :- X has_trait introverted, X has_trait observant, X has_trait feeling, X has_trait prospecting.
X has_personality_type entrepreneur :- X has_trait extraverted, X has_trait observant, X has_trait thinking, X has_trait prospecting.
X has_personality_type entertainer :- X has_trait extraverted, X has_trait observant, X has_trait feeling, X has_trait prospecting.

clause_cf(X is_actually 'Carl Jung', (X has_personality_type architect, X does psychology, X has_nationality 'Swiss'), 0.9).
clause_cf(X is_actually 'Friedrich Nietzsche', (X has_personality_type architect, X does philosophy, X has_nationality 'German'), 0.6).
clause_cf(X is_actually 'Elon Musk', (X has_personality_type architect, X does entrepreneurship, X has_nationality 'South African'), 0.9).
clause_cf(X is_actually 'Christopher Nolan', (X has_personality_type architect, X does cinema, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Bill Gates', (X has_personality_type logician, X does software, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Albert Einstein', (X has_personality_type logician, X does physics, X has_nationality 'German'), 0.9).
clause_cf(X is_actually 'Steve Jobs', (X has_personality_type commander, X does electronics, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Margaret Thatcher', (X has_personality_type commander, X does politics, X has_nationality 'British'), 0.9).
clause_cf(X is_actually 'Mark Twain', (X has_personality_type debater, X does literature, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Martin Luther King', (X has_personality_type advocate, X does politics, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'J. R. R. Tolkien', (X has_personality_type mediator, X does literature, X has_nationality 'British'), 0.9).
clause_cf(X is_actually 'William Shakespeare', (X has_personality_type mediator, X does literature, X has_nationality 'British'), 0.9).
clause_cf(X is_actually 'Barack Obama', (X has_personality_type protagonist, X does politics, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Robin Williams', (X has_personality_type campaigner, X does cinema, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Quentin Tarantino', (X has_personality_type campaigner, X does cinema, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Sting', (X has_personality_type logistician, X does music, X has_nationality 'British'), 0.9).
clause_cf(X is_actually 'Angela Merkel', (X has_personality_type logistician, X does politics, X has_nationality 'German'), 0.9).
clause_cf(X is_actually 'Elizabeth II', (X has_personality_type defender, X does politics, X has_nationality 'British'), 0.7).
clause_cf(X is_actually 'Dr. James Watson', (X has_personality_type defender, X does adventure, X has_nationality 'British'), 0.5).
clause_cf(X is_actually 'Frank Sinatra', (X has_personality_type executive, X does music, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Bill Clinton', (X has_personality_type consul, X does politics, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Clint Eastwood', (X has_personality_type virtuoso, X does cinema, X has_nationality 'American'), 0.5).
clause_cf(X is_actually 'Tom Cruise', (X has_personality_type virtuoso, X does cinema, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Jesse Pinkman', (X has_personality_type adventurer, X does chemistry, X has_nationality 'American'), 0.2).
clause_cf(X is_actually 'Michael Jackson', (X has_personality_type adventurer, X does music, X has_nationality 'American'), 0.9).
clause_cf(X is_actually 'Jack Nicholson', (X has_personality_type entrepreneur, X does cinema, X has_nationality 'American'), 0.7).
clause_cf(X is_actually 'Nicolas Sarkozy', (X has_personality_type entrepreneur, X does politics, X has_nationality 'French'), 0.9).
clause_cf(X is_actually 'Elton John', (X has_personality_type entertainer, X does music, X has_nationality 'British'), 0.9).

real_name(X, Y) :-
  member(Y, [
    'Friedrich Nietzsche', 'Elon Musk', 'Christopher Nolan', 'Bill Gates', 'Albert Einstein', 'Steve Jobs', 'Margaret Thatcher',
    'Mark Twain', 'Martin Luther King', 'J. R. R. Tolkien', 'William Shakespeare', 'Barack Obama', 'Robin Williams', 'Quentin Tarantino',
    'Sting', 'Angela Merkel', 'Elizabeth II', 'Dr. James Watson', 'Frank Sinatra', 'Bill Clinton', 'Clint Eastwood', 'Tom Cruise',
    'Jesse Pinkman', 'Michael Jackson', 'Jack Nicholson', 'Nicolas Sarkozy', 'Elton John'
  ]),
  X is_actually Y.

askable(_ does _).
askable(_ has_nationality _).
askable(_ has_trait _).

explain_this(_ has_personality_type _).
explain_this(_ is_actually _).
