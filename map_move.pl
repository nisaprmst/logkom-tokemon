% ukuran peta = 10 x 10

% variabel pemain
:- dynamic(playerloc/2).
playerloc(1, 1).

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

kiri:- 
	/* command to move left : fail condition */

	playerloc(X, Y),
	New is Y + 1,
	New is 11,
	write('Wadigidaw udah mentok nih gan!'), nl, !.

kiri:- 
	/* command to move left : treasure */

	playerloc(X, Y),
	New is Y + 1,
	here('x', X, New),
	write('Wah ada treasure nih, ambil gak ya?'), nl, !.

kiri:- 
	/* command to move left */
	
	playerloc(X, Y),
	New is Y + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('Kamu bergerak ke kiri yey'), nl, !.

atas:- 
	/* command to move left : fail condition */

	playerloc(X, Y),
	New is X - 1,
	New is 0,
	write('Wadigidaw udah mentok nih gan!'), nl, !.

atas:- 
	/* command to move left : treasure */

	playerloc(X, Y),
	New is X - 1,
	here('x', New, Y),
	write('Wah ada treasure nih, ambil gak ya?'), nl, !.

atas:- 
	/* command to move left */
	
	playerloc(X, Y),
	New is X - 1,
	retract(playerloc(X,Y)),
	assert(playerloc(New,Y)),
    write('Kamu bergerak ke atas yey'), nl, !.

kanan:- 
	/* command to move left : fail condition */

	playerloc(X, Y),
	New is Y - 1,
	New is 0,
	write('Wadigidaw udah mentok nih gan!'), nl, !.

kanan:- 
	/* command to move left : treasure */

	playerloc(X, Y),
	New is Y - 1,
	here('x', X, New),
	write('Wah ada treasure nih, ambil gak ya?'), nl, !.

kanan:- 
	/* command to move left */
	
	playerloc(X, Y),
	New is Y - 1,
	retract(playerloc(X,Y)),
	assert(playerloc(X,New)),
    write('Kamu bergerak ke kanan yey'), nl, !.

bawah:- 
	/* command to move left : fail condition */

	playerloc(X, Y),
	New is X + 1,
	New is 11,
	write('Wadigidaw udah mentok nih gan!'), nl, !.

bawah:- 
	/* command to move left : treasure */

	playerloc(X, Y),
	New is X + 1,
	here('x', New, Y),
	write('Wah ada treasure nih, ambil gak ya?'), nl, !.

bawah:- 
	/* command to move left */
	
	playerloc(X, Y),
	New is X + 1,
	retract(playerloc(X,Y)),
	assert(playerloc(New,Y)),
    write('Kamu bergerak ke bawah yey'), nl, !.