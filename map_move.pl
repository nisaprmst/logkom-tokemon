:- include('tokemon.pl').
:- include('treasure.pl').

% ukuran peta = 10 x 10

% variabel pemain
:- dynamic(playerloc/2).
playerloc(1, 10).

% variabel tokemon yang lagi battle
:- dynamic(battletokemon/1).
battletokemon(none).

% here(Prop, Row, Col).
here('G', 5, 5).
here('x', 3, 3).
here('x', 3, 4).
here('x', 3, 5).
here('x', 3, 1).
here('x', 4, 3).
here('P', Row, Col):- playerloc(R, C), R is Row, C is Col.
here('-', Row, Col):- here(_, R, C), Row =\= R, Col =\= C.


printtepi(1):- write("xxxxx"), nl.
printtepi(N):- N > 1, write("xx"), N1 is N-1, printtepi(N1).

showmap_col(Row, 1):- here(A, Row, 1), write(A), write(' '), write("x"), nl.
showmap_col(Row, N):- N > 1, here(A, Row, N), write(A), write(' '), N1 is N-1, showmap_col(Row, N1).

showmap_plain(1, Col):- printtepi(Col), write("x "), showmap_col(1, Col).
showmap_plain(Row, Col):- Row > 1, Row1 is Row-1, showmap_plain(Row1, Col), write("x "), showmap_col(Row, Col).

showmap:- showmap_plain(10, 10), printtepi(10).

left:- 
	/* command to move left : fail condition */

	playerloc(X, Y),
	New is Y + 1,
	New is 11,
	write('Wadigidaw udah mentok nih gan!'), nl, !.

left:- 
	/* command to move left : treasure */

	playerloc(X, Y),
	New is Y + 1,
	here('x', X, New),
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
	cekx, nl, !.

left:- 
	/* command to move left, start battle */
	
	playerloc(X, Y),
	New is Y + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('Kamu bergerak ke kiri yey'), nl, 
	ketemutokemon, !.

left:- 
	/* command to move left */
	
	playerloc(X, Y),
	New is Y + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('Kamu bergerak ke kiri yey'), nl, !.

up:- 
	/* command to move up : fail condition */

	playerloc(X, Y),
	New is X - 1,
	New is 0,
	write('Wadigidaw udah mentok nih gan!'), nl, !.

up:- 
	/* command to move up : treasure */

	playerloc(X, Y),
	New is X - 1,
	here('x', New, Y),
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
	cekx, nl, !.

up:- 
	/* command to move up, start battle */
	
	playerloc(X, Y),
	New is X - 1,
	retract(playerloc(X,Y)),
	assert(playerloc(New,Y)),
    write('Kamu bergerak ke atas yey'), nl, 
	ketemutokemon, !.

up:- 
	/* command to move up */
	
	playerloc(X, Y),
	New is X - 1,
	retract(playerloc(X,Y)),
	assert(playerloc(New,Y)),
    write('Kamu bergerak ke atas yey'), nl, !.

right:- 
	/* command to move down : fail condition */

	playerloc(X, Y),
	New is Y - 1,
	New is 0,
	write('Wadigidaw udah mentok nih gan!'), nl, !.

right:- 
	/* command to move down : treasure */

	playerloc(X, Y),
	New is Y - 1,
	here('x', X, New),
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
	cekx, nl, !.

right:- 
	/* command to move right, start battle */
	
	playerloc(X, Y),
	New is Y - 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('Kamu bergerak ke kanan yey'), nl, 
	ketemutokemon, !.

right:- 
	/* command to move right */
	
	playerloc(X, Y),
	New is Y - 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('Kamu bergerak ke kanan yey'), nl, !.

down:- 
	/* command to move down : fail condition */

	playerloc(X, Y),
	New is X + 1,
	New is 11,
	write('Wadigidaw udah mentok nih gan!'), nl, !.

down:- 
	/* command to move down : treasure */

	playerloc(X, Y),
	New is X + 1,
	here('x', New, Y),
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
	cekx, nl, !.

down:- 
	/* command to move down */
	
	playerloc(X, Y),
	New is X + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(New,Y)),
    write('Kamu bergerak ke bawah yey'), nl, 
	ketemutokemon, !.

down:- 
	/* command to move down */
	
	playerloc(X, Y),
	New is X + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(New,Y)),
    write('Kamu bergerak ke bawah yey'), nl, !.

ketemutokemon:-
	random_between(1, 10, N),
	tokemon(N, A),
	battletokemon(X),
	retract(battletokemon(X)),
	assert(battletokemon(A)),
	write('Ada tokemon '), write(A), write('!'), nl,
	write('Battle/run?'), nl, !.

