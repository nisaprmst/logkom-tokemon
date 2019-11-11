/*Inventory*/

addTokemon([], TK, [TK]) :- !.
	/* Basis */

addTokemon([Head|Tail], TK, [Head|Tail2]) :- addTokemon(Tail, TK, Tail2).
	/* Recurrens */
	
inv_count([], X) :- X is 0, !.
	/* Basis */

inv_count([_|TAIL], X) :- inv_count(TAIL, Y), X is Y + 1.
	/* Recurrens */

inv_full(Inventory) :- inv_count(Inventory, X), !, X > 5.