:-include('map_move.pl').
%:-include('battle.pl').
%:-include('dynamics.pl').
%:- include('tokemon.pl').
%:- include('inventory.pl').
%:- include('dynamics.pl').

:- dynamic(game_running/1).
game_running(0).

start :-
	nl,nl,nl,
	write('
___________________   ____  __.___________   _____   ________    _______   
\__    ___/\_____  \ |    |/ _|\_   _____/  /     \  \_____  \   \      \  
  |    |    /   |   \|      <   |    __)_  /  \ /  \  /   |   \  /   |   \ 
  |    |   /    |    \    |  \  |        \/    Y    \/    |    \/    |    \
  |____|   \_______  /____|__ \/_______  /\____|__  /\_______  /\____|__  /
                   \/        \/        \/         \/         \/         \/  '),nl,
	write('
 __      __________ __________.____     ________        
/  \    /  \_____  \\______   \    |    \______ \    /\ 
\   \/\/   //   |   \|       _/    |     |    |  \   \/ 
 \        //    |    \    |   \    |___  |    `   \  /\ 
  \__/\  / \_______  /____|_  /_______ \/_______  /  \/ 
       \/          \/       \/        \/        \/      '),nl,
       
       write('
__________    ___________________________.____     ___________
\______   \  /  _  \__    ___/\__    ___/|    |    \_   _____/
 |    |  _/ /  /_\  \|    |     |    |   |    |     |    __)_ 
 |    |   \/    |    \    |     |    |   |    |___  |        \
 |______  /\____|__  /____|     |____|   |_______ \/_______  /
        \/         \/                            \/        \/ '),nl,
	
	write('
  _________________   ____ ___  _____  ________   
 /   _____/\_____  \ |    |   \/  _  \ \______ \  
 \_____  \  /  / \  \|    |   /  /_\  \ |    |  \ 
 /        \/   \_/.  \    |  /    |    \|    `   \
/_______  /\_____\ \_/______/\____|__  /_______  / '),nl,nl,nl,
	write('Welcome To The Tokemon World : Battle Squad'),nl,nl,nl,
	write('Introduce me! My name is Josh and i am on a big mission here'),nl,
	write('As a Tokemon Keeper,it is my job to protect my Tokemon at all costs.'),nl,
	write('Recently,i have 4 Tokemon,but i just realized that i lost all of my 3 Tokemon at once.'),nl,
	write('I actually knew the threat earlier because of those Legendary Monsters rumours,but i did not believe it'),nl,
	write('Now that my Tokemon has gone,i have to bring back all my Tokemon to my Ball,by going through the Legendary`s'),nl,
	write('Those Legends i heard has the name of harlilimon,infallmon,and judhimon if not mistaken.'),nl,
	write('My quests now is to go to their Headquarters and Territories,and defeat them to return back my Tokemon.'),nl,
	write('Please help me accomplish my mission,because if it fails,i would be captured alive and got killed by those Legends.'),nl,
	write('Goodluck saving me and my Tokemons! I hope i will not end up being a slave of those Prick Legend.'),nl,nl,nl,
	write('Commands: '),nl,
	write('     start. -- Start game'),nl,
	write('     help. -- Show all available commands'),nl,
	write('     quit. -- Quit Game'),nl,
	write('     up. down. left. right. -- Move Player Position'),nl,
	write('     map. -- Open Map'),nl,
	write('     heal. -- Heal your Tokemon (Available only in Gym Center)'),nl,
	write('     status. -- Show player status'),nl,
	write('     save(Filename). -- Save Game'),nl,
	write('     load(Filename). -- Load Game'),nl,nl,nl,
	write('Legends: '),nl,
	write('     X = Treasure / Gate '),nl,
	write('     P = Player '),nl,
	write('     G = Gym Center '),nl,
	retract(game_running(0)),
	assert(game_running(1)),
	restartplayer,
	restarttokemonbattle,
	assert(battletokemon(none)),
	add_to_inventory(dagomon),
	restart_legend_tokemon.

help :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.

help :- 
	/* Rules to show help */
	nl,nl,
	write('Having a trouble finding valid commands? Here is it'),nl,nl,nl,
	write('Commands: '),nl,
	write('     start. -- Start game'),nl,
	write('     help. -- Show all available commands'),nl,
	write('     quit. -- Quit Game'),nl,
	write('     up. down. left. right. -- Move Player Position'),nl,
	write('     map. -- Open Map'),nl,
	write('     heal. -- Heal your Tokemon (Available only in Gym Center)'),nl,
	write('     status. -- Show player status'),nl,
	write('     save(Filename). -- Save Game'),nl,
	write('     load(Filename). -- Load Game'),nl,nl,nl,
	write('Legends: '),nl,
	write('     X = Treasure / Gate '),nl,
	write('     P = Player '),nl,
	write('     G = Gym Center '),nl.

map :-
	/* If the game has not started yet */
	game_running(0),
	write('Please start the game first before using this command.'),nl,nl,!.

map :-
	/* If the game has not started yet */
	game_running(1),
	showmap.


restartplayer:-
	playerloc(X, Y),
	X is 1,
	Y =\= 10,
	retract(playerloc(X,Y)).
restartplayer:-
	playerloc(X, Y),
	X =\= 1,
	Y is 10,
	retract(playerloc(X,Y)).
restartplayer:-
	playerloc(X, Y),
	X =\= 1,
	Y =\= 10,
	retract(playerloc(X,Y)).
restartplayer:-
	playerloc(X, Y),
	X is 1,
	Y is 10.

restarttokemonbattle:-
	battletokemon(X), retract(battletokemon(X)).

restart_legend_tokemon:-
	retract(legend_tokemon_list(_)),
	append([], [harlilimon], Lgd_tkmn_1),
	append(Lgd_tkmn_1, [infallmon], Lgd_tkmn_2),
	append(Lgd_tkmn_2, [judhimon], Lgd_tkmn_3),
	assertz(legend_tokemon_list(Lgd_tkmn_3)).
	
