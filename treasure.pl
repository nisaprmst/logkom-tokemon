/*
:- include('map_move.pl').
:- include('battle.pl').
:- include('tokemon.pl'). */

:- dynamic(last_checked_treasure_spot/2). last_checked_treasure_spot(0, 0).
:- dynamic(treasure/3).

treasure(3,3,1).
treasure(3,4,1).
treasure(3,5,1).
treasure(3,1,1).
treasure(4,3,1).



cek_tres(X, Y):-
    treasure(X, Y, B),
    B == 0,
    write('Theres nothing here.You have received the treasure before!'),nl ,
    retract(last_checked_treasure_spot(_, _)),
    assertz(last_checked_treasure_spot(0, 0)), !.

cek_tres(X, Y):-
    treasure(X, Y, B),
    B == 1,
    write('You have found a treasure.'),nl ,
    write('Write "take(Tokemon_Name)" to take it,or "skip" to pass it!'), nl,
    retract(last_checked_treasure_spot(_, _)),
    assertz(last_checked_treasure_spot(X, Y)), !.

cek_tres(X, Y):-
    retract(last_checked_treasure_spot(_, _)),
    assertz(last_checked_treasure_spot(0, 0)), !.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 3,
    Y == 3,
    B == 0,
    write('Theres nothing here.You have received the treasure before!'),nl ,!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 3,
    Y == 3,
    B == 1,
    write('YOU JUST FOUND THE TREASURE!!'),nl,
    write('Do you wish to take it?'),nl,
    write('Effect and Requirements : +10 Health , +15 Normal Attack, -15 Skill'),nl,
    write('Write "take(Tokemon_Name)" to take it,or "skip" to pass it.'),nl, !.
    
cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 3,
    Y == 4,
    B == 0,
    write('Theres nothing here.You have received the treasure before!'),nl ,!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 3,
    Y == 4,
    B == 1,
    write('YOU JUST FOUND THE TREASURE!!'),nl,
    write('Do you wish to take it?'),nl,
    write('Effect and Requirements : +10 Health , +15 Normal Attack, -15 Skill'),nl,
    write('Write "take(Tokemon_Name)" to take it,or "skip" to pass it.'),nl, !.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 3,
    Y == 5,
    B == 0,
    write('Theres nothing here.You have received the treasure before!'),nl ,!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 3,
    Y == 5,
    B == 1,
    write('YOU JUST FOUND THE TREASURE!!'),nl,
    write('Do you wish to take it?'),nl,
    write('Effect and Requirements : +10 Health , +15 Normal Attack, -15 Skill'),nl,
    write('Write "take(Tokemon_Name)" to take it,or "skip" to pass it.'),nl, !.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 3,
    Y == 1,
    B == 0,
    write('Theres nothing here.You have received the treasure before!'),nl ,!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 3,
    Y == 1,
    B == 1,
    write('YOU JUST FOUND THE TREASURE!!'),nl,
    write('Do you wish to take it?'),nl,
    write('Effect and Requirements : +10 Health , +15 Normal Attack, -15 Skill'),nl,
    write('Write "take(Tokemon_Name)" to take it,or "skip" to pass it.'),nl, !.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 4,
    Y == 3,
    B == 0,
    write('Theres nothing here.You have received the treasure before!'),nl ,!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X == 4,
    Y == 3,
    B == 1,
    write('YOU JUST FOUND THE TREASURE!!'),nl,
    write('Do you wish to take it?'),nl,
    write('Effect and Requirements : +10 Health , +15 Normal Attack, -15 Skill'),nl,
    write('Write "take(Tokemon_Name)" to take it,or "skip" to pass it.'),nl, !.

take(Tokemon_Name):-
    player_tokemon_list(PTL),
    treasure_getter(Tokemon_Name, PTL, 1).
    

treasure_getter(_, [], _):- %Reached end of Tokemon List
    write("You do not have that Tokemon."), nl, !.

treasure_getter(Tokemon, Inventory_List, N):- %Head is the picked tokemon
    [Head|_] = Inventory_List,
    Tokemon == Head, !,
    format("You called ~p out forth to grab the treasure!~n", [Tokemon]),
    last_checked_treasure_spot(X, Y),
    ambil(Tokemon, N, X, Y).

treasure_getter(Tokemon, Inventory_List, N):- %Head is NOT the picked tokemon
    [Head|Tail] = Inventory_List,
    Tokemon \== Head,
    NeoN is N + 1,
    treasure_getter(Tokemon, Tail, NeoN).


ambil(Tokemon, TK_NUM, T_X, T_Y):-
    %write("Checking for 3,3"), nl,
    X = T_X, Y = T_Y,
    X == 3,
    Y == 3,
    treasure(X, Y, B),
    B == 1, !,
    /* na+10 */
    change_modifier(TK_NUM, 10, 0, 0, 0, 0),
    %write("modifier changed 111"), nl,
    /* h-15 */
    player_tokemon_health_list(PTHL),
    get_item_num(PTHL, TK_NUM, 1, OLD_PTH),
    %write("got hp"), nl,
    NEO_PTH = OLD_PTH - 15,
    replace(TK_NUM, 1, NEO_PTH, PTHL, NEO_PTHL),
    %write("replaced hp"), nl,
    retract(player_tokemon_health_list(_)),
    assertz(player_tokemon_health_list(NEO_PTHL)),
    %write("set hp"), nl,
    /* treasure is taken */
    %new_b = B-1,
    %write("new B"), nl,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,0)),

    write('Congratulations! You just gain more normal attack!
        Your Tokemon gained 10 more normal attack power.
        But it lost 15 HP.'),nl ,!.

ambil(Tokemon, TK_NUM, T_X, T_Y):-
    %write("Checking for 3,4"), nl,
    X = T_X, Y = T_Y,
    X == 3,
    Y == 4,
    treasure(X, Y, B),
    B == 1, !,
    %write("CHECK!"),
    /* na+5 */
    /* s+5 */
    change_modifier(TK_NUM, 5, 5, 0, 0, 0),
    %write("modifier changed 222"), nl,

    /* h-10 */
    player_tokemon_health_list(PTHL),
    get_item_num(PTHL, TK_NUM, 1, OLD_PTH),
    %write("got hp"), nl,
    NEO_PTH = OLD_PTH - 10,
    replace(TK_NUM, 1, NEO_PTH, PTHL, NEO_PTHL),
    %write("replaced hp"), nl,
    retract(player_tokemon_health_list(_)),
    assertz(player_tokemon_health_list(NEO_PTHL)),
    %write("set hp"), nl,
    
    /* treasure is taken */
    %write("new b"), nl,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,0)),

    write('Congratulations! You just gain more normal attack and skill!
        Your Tokemon gained 5 more normal attack power, and 5 more skill power.
        But it lost 10 HP.'),nl ,!.

ambil(Tokemon, TK_NUM, T_X, T_Y):-
    %write("Checking for 3,5"), nl,
    X = T_X, Y = T_Y,
    X == 3,
    Y == 5,
    treasure(X, Y, B),
    B == 1, !,
    
    /* s-15 */
    /* na+15 */
    change_modifier(TK_NUM, 15, -15, 0, 0, 0),
    %write("modifier changed 333"), nl,

    /* h+10 */
    player_tokemon_health_list(PTHL),
    get_item_num(PTHL, TK_NUM, 1, OLD_PTH),
    %write("got HP"), nl,
    NEO_PTH = OLD_PTH + 10,
    replace(TK_NUM, 1, NEO_PTH, PTHL, NEO_PTHL),
    %write("replaced hp"), nl,
    retract(player_tokemon_health_list(_)),
    assertz(player_tokemon_health_list(NEO_PTHL)),
    %write("set hp"), nl,

    /* treasure is taken */
    %new_b = B-1,
    %write("nwe n"), nl,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,0)),

    write('Congratulations! You just gain more normal attack and skill!
        Your Tokemon gained 15 more normal attack power, and 15 less skill power.
        But it got 10 HP.'),nl ,!.

ambil(Tokemon, TK_NUM, T_X, T_Y):-
    %write("Checking for 3,1"), nl,
    X = T_X, Y = T_Y,
    X == 3,
    Y == 1,
    treasure(X, Y, B),
    B == 1, !,
    
    /* na-5 */
    /* s+5 */
    change_modifier(TK_NUM, -5, 5, 0, 0, 0),
    %write("modifier changed"), nl,

    /* h+5 */
    player_tokemon_health_list(PTHL),
    get_item_num(PTHL, TK_NUM, 1, OLD_PTH),
    NEO_PTH = OLD_PTH + 5,
    replace(TK_NUM, 1, NEO_PTH, PTHL, NEO_PTHL),
    retract(player_tokemon_health_list(_)),
    assertz(player_tokemon_health_list(NEO_PTHL)),

    /* treasure is taken */
    %new_b = B-1,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,0)),

    write('Congratulations! You just gain more normal attack and skill!
        Your Tokemon gained 5 less normal attack power, and 5 more skill power.
        And it got 5 HP.'),nl ,!.

ambil(Tokemon, TK_NUM, T_X, T_Y):-
    %write("Checking for 4,3"), nl,
    X = T_X, Y = T_Y,
    X == 4,
    Y == 3,
    treasure(X, Y, B),
    B == 1, !,
    
    change_modifier(TK_NUM, 10, 5, 0, 0, 0),
    %write("Modifier chaned!"),

    /* h-20 */
    player_tokemon_health_list(PTHL),
    get_item_num(PTHL, TK_NUM, 1, OLD_PTH),
    %write("Got PTH!"),
    NEO_PTH = OLD_PTH - 20,
    replace(TK_NUM, 1, NEO_PTH, PTHL, NEO_PTHL),
    %write("HP replaced!"),
    retract(player_tokemon_health_list(_)),
    assertz(player_tokemon_health_list(NEO_PTHL)),
    %write("HP SET!"),

    /* treasure is taken */
    %new_b = B-1,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,0)),

    write('Congratulations! You just gain more normal attack and skill!
        Your Tokemon gained 10 more normal attack power, and 5 more skill power.
        But it lost 20 HP.'),nl ,!.
