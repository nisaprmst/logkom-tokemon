w:- 
	/* command to move left : fail condition */

	player_pos(X, Y),
	new is Y + 1,
	world(border, X, new),!,
	write('Seems I can\'t move there....\n'),nl.
	
w:- 
	/* command to move left */
	
	player_pos(X, Y),
	new is Y + 1,
	retract(player_pos(X,Y)),
	assert(player_pos(X,new)),
    write('Anda bergerak ke barat,').

n:- 
	/* command to move up : fail condition */
	
	player_pos(X, Y),
	new is X + 1,
	world(border, new, Y),!,
	write('Seems I can\'t move there....\n'),nl.

n:- 
	/* command to move up */
	
	player_pos(X, Y),
	new is X + 1,
	retract(player_pos(X,Y)),
	assert(player_pos(new,Y)),
    write('Anda bergerak ke utara,').
	
e:- 
	/* command to move right : fail condition */
	
	player_pos(X, Y),
	new is Y - 1,
	world(border, X, new),!,
	write('Seems I can\'t move there....\n'),nl.
 
e:- 
	/* command to move right */
	 
	player_pos(X, Y),
	new is Y - 1,
	retract(player_pos(X,Y)),
	assert(player_pos(X,new)),
    write('Anda bergerak ke timur,').

s:- 
	/* command to move down : fail condition */
	
	player_pos(X, Y),
	new is X - 1,
	world(border, new, Y),!,
	write('Seems I can\'t move there....\n'),nl.
	
s:- 
	/* command to move down */
	
	player_pos(X, Y),
	new is X - 1,
	retract(player_pos(X,Y)),
	assert(player_pos(new,Y)),
    write('Anda bergerak ke selatan,').
