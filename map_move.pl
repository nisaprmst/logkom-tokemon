
:- include('treasure.pl').
:- include('tokemon.pl'). 
:- include('battle.pl').

% ukuran peta = 10 x 10

% variabel pemain
:- dynamic(playerloc/2).
playerloc(1, 10).

% variabel tokemon yang lagi battle
:- dynamic(battletokemon/1).
battletokemon(none).

:- dynamic(has_healed/1).
has_healed(none).

% here(Prop, Row, Col).
here(g, 5, 5).
here(x, 3, 3).
here(x, 3, 4).
here(x, 3, 5).
here(x, 3, 1).
here(x, 4, 3).
here(p, Row, Col):- playerloc(R, C), R is Row, C is Col.
here(-, Row, Col):- here(_, R, C), Row \= R, Col \= C.


printtepi(1):- write("xxxxx"), nl.
printtepi(N):- N > 1, write("xx"), N1 is N-1, printtepi(N1).

showmap_col(Row, 1):- here(A, Row, 1), write(A), write(' '), write("x"), nl.
showmap_col(Row, N):- N > 1, here(A, Row, N), write(A), write(' '), N1 is N-1, showmap_col(Row, N1).

showmap_plain(1, Col):- printtepi(Col), write("x "), showmap_col(1, Col).
showmap_plain(Row, Col):- Row > 1, Row1 is Row-1, showmap_plain(Row1, Col), write("x "), showmap_col(Row, Col).

showmap:- showmap_plain(10, 10), printtepi(10).

left :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.
right :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.
down :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.
up :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.
heal :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.

left :-
	/* lagi di battle */
	game_battle(1),
	write('The battle has started, you cannot move now!.'),nl,nl,!.
right :-
	/* lagi di battle */
	game_battle(1),
	write('The battle has started, you cannot move now!.'),nl,nl,!.
down :-
	/* lagi di battle */
	game_battle(1),
	write('The battle has started, you cannot move now!.'),nl,nl,!.
up :-
	/* lagi di battle */
	game_battle(1),
	write('The battle has started, you cannot move now!.'),nl,nl,!.


left:- 
	/* command to move left : fail condition */

	playerloc(X, Y),
	New is Y + 1,
	New is 11,
	write('You cannot move left,you are on the edge of the map!'), nl, !.

left:- 
	/* command to move left : treasure */

	playerloc(X, Y),
	New is Y + 1,
	here('x', X, New),
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
	cek_tres(X, New), !.

left:- 
	/* command to move left, start battle */
	ketemutokemon, !,
	playerloc(X, Y),
	New is Y + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('You have succeed to move left!'), nl, 
    write('REMEMBER!!! When you are in the battle you CANNOT MOVE anywhere else. Take the Battle or Run !'),nl.

left:- 
	/* command to move left */
	
	playerloc(X, Y),
	New is Y + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('You have succed to move left!'), nl, !.

up:- 
	/* command to move up : fail condition */

	playerloc(X, Y),
	New is X - 1,
	New is 0,
	write('You cannot move up,you are on the edge of the map!'), nl, !.

up:- 
	/* command to move up : treasure */

	playerloc(X, Y),
	New is X - 1,
	here('x', New, Y),
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
	cek_tres(New, Y), !.

up:- 
	/* command to move up, start battle */
	ketemutokemon, !,
	playerloc(X, Y),
	New is X - 1,
	assert(playerloc(New,Y)),
    write('You have succeed to move up!'), nl, 
    write('REMEMBER!!! When you are in the battle you CANNOT MOVE anywhere else. Take the Battle or Run !'),nl.

up:- 
	/* command to move up */
	
	playerloc(X, Y),
	New is X - 1,
	retract(playerloc(X,Y)),
	assert(playerloc(New,Y)),
    write('You have succeed to move up!'), nl, !.

right:- 
	/* command to move down : fail condition */

	playerloc(X, Y),
	New is Y - 1,
	New is 0,
	write('You cannot move right,you are on the edge of the map'), nl, !.

right:- 
	/* command to move down : treasure */

	playerloc(X, Y),
	New is Y - 1,
	here('x', X, New),
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
	cek_tres(X, New), !.

right:- 
	/* command to move right, start battle */
	ketemutokemon, !,
	playerloc(X, Y),
	New is Y - 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('You have succeed to move right!'), nl, 
    write('REMEMBER!!! When you are in the battle you CANNOT MOVE anywhere else. Take the Battle or Run !'),nl.

right:- 
	/* command to move right */
	
	playerloc(X, Y),
	New is Y - 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('You have succeed to move right!'), nl, !.

down:- 
	/* command to move down : fail condition */

	playerloc(X, Y),
	New is X + 1,
	New is 11,
	write('You cannot move down,you are on the edge of the map!'), nl, !.

down:- 
	/* command to move down : treasure */

	playerloc(X, Y),
	New is X + 1,
	here('x', New, Y),
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
	cek_tres(New, Y), !.

down:- 
	/* command to move down */
	ketemutokemon, !,
	playerloc(X, Y),
	New is X + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(New,Y)),
    write('You have succeed to move down!'), nl, 
    write('REMEMBER!!! When you are in the battle you CANNOT MOVE anywhere else. Take the Battle or Run !'),nl.

down:- 
	/* command to move down */
	
	playerloc(X, Y),
	New is X + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(New,Y)),
    write('You have succeed to move down!'), nl, !.

ketemutokemon:-
	random_between(1, 30, N),
	N > 25, !,
	legend_tokemon_list(LTL),
	list_count(LTL, LTL_LEN),
	random_between(1, LTL_LEN, LegToke_to_encounter),
	battletokemon(X),
	retract(battletokemon(X)),
	assert(battletokemon(LegToke_to_encounter)),
	retract(game_state(_)),
    assertz(game_state(encounter)),
	encounter_tokemon(LegToke_to_encounter, []).
	/* write('Ada tokemon '), write(A), write('!'), nl,
	write('Battle/run?'), nl, !. */

ketemutokemon:-
	random_between(1, 30, N),
	tokemon(N, A),
	battletokemon(X),
	retract(battletokemon(X)),
	assert(battletokemon(A)),
	retract(game_state(_)),
	assertz(game_state(encounter)),
	encounter_tokemon(A, []).

heal:-
	playerloc(PX, PY),
	PX == 5, PY ==5,
	%here(MAP_OBJECT, PX, PY),
	%MAP_OBJECT == g,
	has_healed(Heal_Bool),
	Heal_Bool == none, !,
	write("You stepped inside the Tokemon Gym in the middle of nowhere."), nl,
	write("It was derelict, but you found some useful supplies to heal your Tokemons."), nl,
	write("You quickly healed your Tokemons and left the Gym post-haste."), nl,
	write("As you did, a terrible low rumbling sound was heard."), nl,
	write("And the Gym collapsed."), nl,
	heal_player_tokemons,
	retract(has_healed(_)),
	assertz(has_healed(yes)).

heal:-
	playerloc(PX, PY),
	PX \= 5, PY \=5,
	write("You must be at the Tokemon Gym to heal."), nl.

heal:-
	has_healed(Heal_Bool),
	Heal_Bool \= none,
	write("The Tokemon Gym has collapsed, you cannot heal within it any longer."), nl.