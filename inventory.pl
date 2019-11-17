/*Inventory*/
%:- include(tokemon).
%:- include(battle).


add_to_back_of_list([], TK, [TK]) :- !.
	/* Basis */

add_to_back_of_list([Head|Tail], TK, [Head|Tail2]) :- add_to_back_of_list(Tail, TK, Tail2).
	/* Recurrens */
	
list_count([], X) :- X is 0, !.
	/* Basis */

list_count([_|TAIL], X) :- list_count(TAIL, Y), X is Y + 1.
	/* Recurrens */

inv_full(Inventory) :- list_count(Inventory, X), !, X > 5.

delTokemon([], _, []) :- !.
	/* Del object from list : basis */

delTokemon([A|B], C, B) :- C == A, !.
	/* Del object from list : recursive - found */

delTokemon([A|B], C, [A|D]) :- C \== A, delTokemon(B, C, D).
	/* Del object from list : recursive - not found */

del_list_num([A|B], N, I, [A|BB]) :- I \== N, J is I + 1, del_list_num(B, N, J, BB).
	/* Del idx N from a list , not found and continuing */

del_list_num([A|B], N, I, B) :- I == N, !.
	/* Del idx N from a list , found and stopping */

del_list_num([], N, I, []) :- !.
	/* Del idx N from a list , not found*/

get_item_num([], N, I, none) :- !.
get_item_num([H|T], N, I, H) :- I == N.
get_item_num([H|T], N, I, X) :- I \= N, J is I + 1, get_item_num(T, N, J, X).


/* replaces the info of idx N in list to R*/
replace(_, _, _, [], []).
replace(N, I, R, [H|T], [R|T2]) :- I == N, replace(N, 999, R, T, T2).
replace(N, I, R, [H|T], [H|T2]) :- I \= N, J is I + 1, replace(N, J, R, T, T2).

schTK_num([], _, N) :- N is -96,!.
	%Searches tokemon number in inventory, not found, returns negatives.

schTK_num([A|B], C, N) :- A == C, N is 1,!.
	%Searches tokemon number in inventory, found, returns.

schTK_num([A|B], C, N) :- schTK_num(B, C, M), N is M + 1.
	%Searches tokemon number in inventory, not found, continues searching.

add_to_inventory(TOKEMON) :-
	player_tokemon_list(PTL),
	player_tokemon_health_list(PTHL),
	player_tokemon_enhancemnt_list(PTEL),
	add_to_back_of_list(PTL, TOKEMON, NEO_PTL),
	retract(player_tokemon_list(_)),
	assertz(player_tokemon_list(NEO_PTL)),
	health(TKHEL, TOKEMON),
	add_to_back_of_list(PTHL, TKHEL, NEO_PTHL),
	retract(player_tokemon_health_list(_)),
	assertz(player_tokemon_health_list(NEO_PTHL)),
	add_to_back_of_list(PTEL, [], NEO_PTEL),
	retract(player_tokemon_enhancemnt_list(_)),
	assertz(player_tokemon_enhancemnt_list(NEO_PTEL)).

remove_TK_num_from_inventory(TK_NUM) :-
	player_tokemon_list(PTL),
	player_tokemon_health_list(PTHL),
	player_tokemon_enhancemnt_list(PTEL),
	del_list_num(PTL, TK_NUM, 1, NEO_PTL),
	retract(player_tokemon_list(_)),
	assertz(player_tokemon_list(NEO_PTL)),
	del_list_num(PTHL, TK_NUM, 1, NEO_PTHL),
	retract(player_tokemon_health_list(_)),
	assertz(player_tokemon_health_list(NEO_PTHL)),
	del_list_num(PTEL, TK_NUM, 1, NEO_PTEL),
	retract(player_tokemon_enhancemnt_list(_)),
	assertz(player_tokemon_enhancemnt_list(NEO_PTEL)).