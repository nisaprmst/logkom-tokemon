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

delTokemon([], _, []) :- !.
	/* Del object from list : basis */

delTokemon([A|B], C, B) :- C == A, !.
	/* Del object from list : recursive - found */

delTokemon([A|B], C, [A|D]) :- C \== A, delTokemon(B, C, D).
	/* Del object from list : recursive - not found */

schTK_num([], _, N) :- N is -96,!.
	%Searches tokemon number in inventory, not found, returns negatives.

schTK_num([A|B], C, N) :- A == C, N is 1,!.
	%Searches tokemon number in inventory, found, returns.

schTK_num([A|B], C, N) :- schTK_num(B, C, M), N is M + 1.
	%Searches tokemon number in inventory, not found, continues searching.

add_to_inventory() :- !.