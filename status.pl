status:-
	write("+====================+"), nl,
	write('|       STATUS       |'), nl,
	write("+====================+"), nl,

	write('+====Your Tokemon====+'), nl,
	write_tokemon_list(inventory), nl,
	write('+=Roaming Legendaries=+'), nl,
	write_tokemon_list(roaming_legend_list), nl.



/* Tokemon List writers */

/* Basis */
write_tokemon_list(Tokemon_List):-
	Tokemon_List = [], !.

/* Recurrens */
write_tokemon_list(Tokemon_List):-
	[Head|Tail] = Tokemon_List,
	write_tokemon_info(Head), nl,
	write_tokemon_list(Tail).


/* Tokemon info writer */

write_tokemon_info(Tokemon):-

	health(HEALTH, Tokemon),
	tipe(TYPE, Tokemon),

	format("~p~n", [Tokemon]),
	format("Health    : ~p~n", [HEALTH]),
	format("Type      : ~p~n", [TYPE]), nl.

