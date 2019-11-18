%:- debug.

:- include('tokemon.pl').
:- include('inventory.pl').
:- include('dynamics.pl'). 



% These commands are exposed (used by the player in the game).
attack:-
    player_attack.

specialAttack:-
    picked_tokemon_used_skill(PT_skill),
    PT_skill == 0, !,
    %player_battle_tokemon(PBT),
    %format("~p used its skill!", [PBT]),
    player_skill.

specialAttack:-
    picked_tokemon_used_skill(PT_skill),
    PT_skill \= 0, !,
    player_battle_tokemon(PBT),
    format("~p is too tired to use another skill!", [PBT]).

pick(Tokemon):-
    player_tokemon_list(PTL),
    tokemon_picker(Tokemon, PTL, 1).


run:-
    game_state(Current_GAME_STATE),
    Current_GAME_STATE \= encounter,
    write("What are you running away from?"), nl.

run:-
    game_state(Current_GAME_STATE),
    Current_GAME_STATE == encounter,
    random_between(0, 11, Rando),
    format("Rando    : ~p~n", [Rando]),
    Rando > 5 -> (
        reset_dynamics,
        retract(game_state(_)),
        assertz(game_state(move)),
        write("You managed to run away."),
        write("You sighed in relief."));(write("You failed to run away to safety!"), nl,
            write("Better get a Tokemon out quickly before everything is too late!"), nl,
            fight).

fight:-
    game_state(Current_GAME_STATE),
    Current_GAME_STATE == encounter,
    write("You decided to fight the Tokemon."), nl,
    retract(game_state(_)),
    assertz(game_state(forced_pick)).

capture:-
    capturable(TK_Cap),
    TK_Cap == none,
    write("There is NOTHING to capture."), nl, fail.

capture:-
    capturable(TK_Cap),
    TK_Cap \= none,
    player_tokemon_list(PTL),
    list_count(PTL, PTL_LEN),
    PTL_LEN > 5,
    write("You have too Tokemons many with you, drop(TOKEMON_NAME). a Tokemon first to capture this one."), nl, fail.

capture:-
    capturable(TK_Cap),
    TK_Cap \= none,
    player_tokemon_list(PTL),
    list_count(PTL, PTL_LEN),
    PTL_LEN < 6,
    add_to_inventory(TK_Cap),
    format("You captured the Tokemon ~p!~n.", [TK_Cap]), nl,
    retract(capturable(_)),
    assertz(capturable(none)).

drop(TOKEMON):-
    player_tokemon_list(PTL),
    schTK_num(PTL, TOKEMON, TK_NUM),
    TK_NUM < 1,
    write("You cannot drop a Tokemon you don not have!").

drop(TOKEMON):-
    player_tokemon_list(PTL),
    schTK_num(PTL, TOKEMON, TK_NUM),
    TK_NUM > 0,
    TK_NUM < 7,
    get_item_num(PTL, TK_NUM, 1, T_To_Drop),
    format("You and ~p looked sadly at each other, saying goodbyes.", [T_To_Drop]), nl,
    format("After some time ~p finally walked away from you, slowly, sadly.", [T_To_Drop]), nl,
    write("As you lost sight of your Tokemon, a sudden terrible sound could be heard."), nl,
    write("But it went as quickly as it came."), nl,
    remove_TK_num_from_inventory(TK_NUM).


%Use this to first initiate the battle, this 'should' lock the player between choosing to run or fight
encounter_tokemon(Wild_tokemon, Waiting_list):-
    format("~p leapt out and seems ready to attack you!~n", [Wild_tokemon]),
    retract(wild_encountered_tokemon(_)),
    retract(enemy_waiting_list(_)),
    assertz(wild_encountered_tokemon(Wild_tokemon)),
    assertz(enemy_waiting_list(Waiting_list)),
    retract(game_state(_)),
    assertz(game_state(encounter)),
    format("Use fight. to choose a Tokemon you own and fight ~p!~n", [Wild_tokemon]),
    write("or use run. to try to run away to safety."), nl.
    
    

heal_player_tokemons:-
    player_tokemon_list(PTL),
    list_count(PTL, Tokemon_Count),
    healer(Tokemon_Count, 1).

healer(N, I) :-
    I =< N,
    J is I + 1,
    player_tokemon_list(PTL),
    get_item_num(PTL, I, 1, TOKE_I),
    health(Full_Health, TOKE_I),
    player_tokemon_health_list(PTHL),
    replace(I, 1, Full_Health, PTHL, NEO_PTHL),
    retract(player_tokemon_health_list(_)),
    assertz(player_tokemon_health_list(NEO_PTHL)),
    healer(N, J).

healer(N, I):-
    I > N, !.


get_tokemon_list_from_inventory(Tokemon_List):-
    player_inventory([TK_List_1|TK_List_2], [_|_], [_|_]),
    append([TK_List_1], TK_List_2, Tokemon_List).
    

get_health_list_from_inventory(Health_List):-
    player_inventory([_|_], [HL_List_1|HL_List_2], [_|_]),
    append([HL_List_1], HL_List_2, Health_List).

get_enhancement_list_from_inventory(Enhancement_List):-
    player_inventory([_|_], [_|_], [EN_List_1|EN_List_2]),
    append([EN_List_1], EN_List_2, Enhancement_List).


initalize_battle(PTOKEMON, Enemy_tokemon):-
    retract(player_battle_tokemon(_)),
    assertz(player_battle_tokemon(PTOKEMON)),
    retract(picked_tokemon_health(_)),
    health(PTHEALTH, PTOKEMON),
    %format("PHealth    : ~p~n", [PTHEALTH]),
    assertz(picked_tokemon_health(PTHEALTH)),
    retract(opposing_tokemon(_)),
    %write("ROT"),
    assertz(opposing_tokemon(Enemy_tokemon)),
    retract(opposing_tokemon_health(_)),
    health(EHEALTH, Enemy_tokemon),
    %format("EHealth    : ~p~n", [EHEALTH]),
    assertz(opposing_tokemon_health(EHEALTH)),
    show_battle_status.
	
force_player_pick:-
    write("Select a Tokemon to battle with!"),nl,
    write("Use pick([Tokemon_NAME]) to pick a Tokemon!"), nl,
    player_tokemon_list(PLT),
    list_writer(PLT),
    retract(game_state(_)),
    assertz(game_state(forced_pick)).

show_battle_status:-
    nl,
    enemy_waiting_list(EWL),
    list_count(EWL, EWL_Len),
    EWL_Len > 0, nl,
    write("Opposing Tokemon :"), nl,
    opposing_tokemon(OT),
    tipe(OTT, OT),
    opposing_tokemon_health(OTH),
    format("~p~n", [OT]),
    format("Type : ~p~n", [OTT]),
    format("Health : ~p~n", [OTH]), nl,
    format("There seem to be ~p more Tokemon hiding near, ready to attack.~n",[EWL_Len]), nl,

    nl, write("Your Tokemon :"), nl,
    player_tokemon_list(PTL),
    player_battle_tokemon(PBT),
    tipe(PBTT, PBT),
    picked_tokemon_health(PTH),
    format("~p~n", [PBT]),
    format("Type : ~p~n", [PBTT]),
    format("Health : ~p~n", [PTH]), nl,
    write("You own these Tokemons : "),
    list_writer(PTL), nl, nl.

show_battle_status:-
    enemy_waiting_list(EWL),
    list_count(EWL, EWL_Len),
    EWL_Len < 1,
    write("Opposing Tokemon :"), nl,
    opposing_tokemon(OT),
    tipe(OTT, OT),
    opposing_tokemon_health(OTH),
    format("~p~n", [OT]),
    format("Type : ~p~n", [OTT]),
    format("Health : ~p~n", [OTH]),
    format("There are no other Tokemons hiding near, ready to pounce you.~n"),

    write("Your Tokemon :"), nl,
    player_tokemon_list(PTL),
    player_battle_tokemon(PBT),
    tipe(PBTT, PBT),
    picked_tokemon_health(PTH),
    format("~p~n", [PBT]),
    format("Type : ~p~n", [PBTT]),
    format("Health : ~p~n", [PTH]),
    write("You own these Tokemons : "),
    list_writer(PTL).

tokemon_picker(_, [], _):- %Reached end of Tokemon List
    write("You do not have that Tokemon."), nl, !.

tokemon_picker(Tokemon, Inventory_List, N):- %Head is the picked tokemon
    [Head|_] = Inventory_List,
    Tokemon == Head, !,
    retract(picked_tokemon_num(_)),
    assertz(picked_tokemon_num(N)),
    wild_encountered_tokemon(Current_Foekemon),
    format("You called ~p out forth to fight ~p!~n", [Tokemon, Current_Foekemon]),
    initalize_battle(Tokemon,Current_Foekemon).

tokemon_picker(Tokemon, Inventory_List, N):- %Head is NOT the picked tokemon
    [Head|Tail] = Inventory_List,
    Tokemon \== Head,
    NeoN is N + 1,
    tokemon_picker(Tokemon, Tail, NeoN).

get_type_modifier(Attacker, Attackee, Modifier):-
    tipe(TAR, Attacker), tipe(TAE, Attackee), lawan(TAR, TAE),!, (Modifier is rational(1.5), write("It is super effective!"), nl); Modifier is rational(1).

player_attack:-
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    na(PBT, PNA),
    %format("PNA    : ~p~n", [PNA]),
    %insert enhancment modifier getter here pls

    get_type_modifier(PBT, OT, Type_Mod),
    %format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(PNA * Type_Mod),
    %format("DMG    : ~p~n", [DMG]),
    opposing_tokemon_health(Old_o_hl),
    Neo_o_hl is (Old_o_hl - DMG),
    %format("Neo_o_hl    : ~p~n", [Neo_o_hl]),
    retract(opposing_tokemon_health(_)),
    assertz(opposing_tokemon_health(Neo_o_hl)),
    format("~p attacked and dealth ~p damage!~n", [PBT, DMG]),
    show_battle_status,
    sleep(1),
    check_enemy.

player_skill:-
    %write("SKILLL"),
    picked_tokemon_used_skill(PTSS),
    PTSS == 0,
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    skill(PBT, PSA),
    %format("PSA    : ~p~n", [PSA]),
    %format("~p used skill!~n", [PBT]),
    %insert enhancment modifier getter here pls

    get_type_modifier(PBT, OT, Type_Mod),
    %format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(PSA * Type_Mod),
    %format("DMG    : ~p~n", [DMG]),
    opposing_tokemon_health(Old_o_hl),
    Neo_o_hl is (Old_o_hl - DMG),
    %format("Neo_o_hl    : ~p~n", [Neo_o_hl]),
    retract(opposing_tokemon_health(_)),
    assertz(opposing_tokemon_health(Neo_o_hl)),
    retract(picked_tokemon_used_skill(_)),
    assertz(picked_tokemon_used_skill(1)),
    format("~p reached deep within and unleashed its skill to deal ~p damage!~n", [PBT, DMG]), sleep(1),
    show_battle_status,
    sleep(1), !,
    check_enemy, !.

check_enemy:-
    %write("CHECK ENEMY TWOOOO!!!"), nl,
    opposing_tokemon_health(Enemy_Health),
    Enemy_Health =< 0, !,
    kill_enemy.

check_enemy:-
    %write("CHECK ENEMY ONE!!!"), nl,
    opposing_tokemon_health(Enemy_Health),
    Enemy_Health > 0, !,
    random_between(0, 11, Rando),!,
    %format("Rando    : ~p~n", [Rando]),
    %write("RANDOMISASI"), nl,
    check_enemy_skill(Rando), !.
    %show_battle_status.

check_player_battle_tokemon :-
    picked_tokemon_health(Player_Battle_Health),
    %show_battle_status,
    Player_Battle_Health < 1, !,
    kill_player_tokemon.

check_player_battle_tokemon :- !.

check_enemy_skill(Random_Number):-
    Random_Number > 8, !,
    opposing_tokemon_used_skill(OTSS),
    OTSS == 0,
    enemy_skill, !,
    retract(opposing_tokemon_used_skill(_)),
    assertz(opposing_tokemon_used_skill(1)).

check_enemy_skill(Random_Number):-
    Random_Number =< 8, !,
    enemy_attack, !.

enemy_attack:-
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    na(OT, OTNA),
    %format("OTNA    : ~p~n", [OTNA]),
    %insert enhancment modifier getter here pls

    get_type_modifier(OT, PBT, Type_Mod),
    %format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(OTNA * Type_Mod),
    %format("DMG    : ~p~n", [DMG]),
    picked_tokemon_health(Old_p_hl),
    Neo_p_hl is (Old_p_hl - DMG),
    %format("Neo_p_hl    : ~p~n", [Neo_p_hl]),
    retract(picked_tokemon_health(_)),
    assertz(picked_tokemon_health(Neo_p_hl)),
    format("~p leered and attacked to deal ~p damage!~n", [OT, DMG]),
    show_battle_status, !, check_player_battle_tokemon, !.
    %check_player_battle_tokemon.

enemy_skill:-
    player_battle_tokemon(PBT),
    opposing_tokemon(OT),
    skill(OT, OTSA),
    %format("OTSA    : ~p~n", [OTSA]),
    %format("~p used skill!~n", [OT]),
    %insert enhancment modifier getter here pls

    get_type_modifier(OT, PBT, Type_Mod),
    %format("Type Mod    : ~p~n", [Type_Mod]),
    DMG is floor(OTSA * Type_Mod),
    %format("DMG    : ~p~n", [DMG]),
    picked_tokemon_health(Old_p_hl),
    Neo_p_hl is (Old_p_hl - DMG),
    %format("Neo_p_hl    : ~p~n", [Neo_p_hl]),
    retract(picked_tokemon_health(_)),
    assertz(picked_tokemon_health(Neo_p_hl)),
    format("~p made a terrible sound and unleashed its skill to deal ~p damage!~n", [OT, DMG]),
    show_battle_status, !, check_player_battle_tokemon, !.
    
kill_enemy:-
    %Killed a legendary tokemon with no hiders
    enemy_waiting_list(EWL),
    EWL == [],
    write("YOU WON!"), nl,
    opposing_tokemon(OT),
    legendtokemon(_, OT), !,
    format("The Legendary ~p looked at you meekly, its rage subsiding.~n", [OT]),
    write("Quick! capture. the legendary Tokemon!"), nl,
    write("Or you could just walk away and leave it there. A fitting fate, perhaps."), nl,
    player_set_battle_tokemon_to_inventory,
    legend_tokemon_list(RLL),
    schTK_num(RLL, OT, N),
    del_list_num(RLL, N, 1, NEO_RLL),
    retract(legend_tokemon_list(_)),
    assertz(legend_tokemon_list(NEO_RLL)),
    retract(capturable(_)),
    assertz(capturable(OT)),
    player_wins_battle,
    legendary_check.

kill_enemy:-
    % Killed a legendary tokemon with hiders
    enemy_waiting_list(EWL),
    EWL \= [],
    [Next_Foekemon|_] is EWL,
    opposing_tokemon(OT),
    legendtokemon(_, OT), !,
    format("~p leaped out of its hiding place after the legendary was felled!~n", [Next_Foekemon]),
    format("~p looked at you meekly, its rage subsiding.~n", [OT]),
    format("Quick! capture. ~p the legedary to your roster before ~p attacks!~n", [OT, Next_Foekemon]),
    player_set_battle_tokemon_to_inventory,
    retract(capturable(_)),
    assertz(capturable(OT)),
    enemy_go_to_next_tokemon.

kill_enemy:-
    enemy_waiting_list(EWL),
    EWL == [],
    write("YOU WON!"), nl,
    opposing_tokemon(OT),
    format("~p looked at you weakly, seemed like whatever rage that made it attacked you vanished.~n", [OT]),
    write("Quick! capture. it and add it to your roster!"), nl,
    write("Or, you could just walk away and leave it there. Probably to become a toy to the legendaries."), nl,
    player_set_battle_tokemon_to_inventory,
    retract(capturable(_)),
    assertz(capturable(OT)),
    player_wins_battle, legendary_check.

kill_enemy:-
    enemy_waiting_list(EWL),
    EWL \= [],
    [Next_Foekemon|_] is EWL,
    opposing_tokemon(OT),
    format("~p leaped out of its hiding place after its friend was felled!~n", [Next_Foekemon]),
    format("~p looked at you weakly, seemed like whatever rage that made it attacked you vanished.~n", [OT]),
    format("Quick! capture. ~p and add it to your roster before ~p attacks!~n", [OT, Next_Foekemon]),
    player_set_battle_tokemon_to_inventory,
    retract(capturable(_)),
    assertz(capturable(OT)),
    enemy_go_to_next_tokemon.

player_wins_battle:-
    retract(game_state(_)),
    assertz(game_state(move)),
    write("You won the battle."), nl,
    write("You, and your Tokemons, sighed in relief."), nl,
    reset_dynamics.

player_set_battle_tokemon_to_inventory:-
    player_tokemon_health_list(PTHL),
    picked_tokemon_health(PTH),
    picked_tokemon_num(TK_NUM),
    player_tokemon_enhancemnt_list(PTEL),
    replace(TK_NUM, 1, PTH, PTHL, NEO_PTHL),
    retract(player_tokemon_health_list(_)),
    assertz(player_tokemon_health_list(NEO_PTHL)),
    
    replace(TK_NUM, 1, [], PTEL, NEO_PTEL),
    retract(player_tokemon_enhancemnt_list(_)),
    assertz(player_tokemon_enhancemnt_list(NEO_PTEL)).

player_switch_tokemon(NEO_TKMN_NUMBER):-
    player_tokemon_list(PTL),
    player_tokemon_health_list(PTHL),
    player_tokemon_enhancemnt_list(PTEL),
    player_battle_tokemon(OLD_PTokemon),
    format("You called ~p back to you.", [OLD_PTokemon]),

    get_item_num(PTL, NEO_TKMN_NUMBER, 1, PTOKEMON),
    format("And then you called ~p out into battle!", [PTOKEMON]),

    retract(player_battle_tokemon(_)),
    assertz(player_battle_tokemon(PTOKEMON)),

    get_item_num(PTHL, NEO_TKMN_NUMBER, 1, PTHEALTH),
    retract(picked_tokemon_health(_)),
    %format("PHealth    : ~p~n", [PTHEALTH]),
    assertz(picked_tokemon_health(PTHEALTH)),

    get_item_num(PTEL, NEO_TKMN_NUMBER, 1, PENHANCEMNT),
    retract(picked_tokemon_enhancment(_)),
    assertz(picked_tokemon_enhancment(PENHANCEMNT)).

enemy_go_to_next_tokemon:-
    enemy_waiting_list(EWL),
    [Head|_] is EWL,
    
    retract(opposing_tokemon(_)),
    assertz(opposing_tokemon(Head)),

    health(OTHealth, Head),
    retract(opposing_tokemon_health(_)),
    assertz(opposing_tokemon_health(OTHealth)),

    retract(opposing_tokemon_used_skill(_)),
    assertz(opposing_tokemon_used_skill(0)).

kill_player_tokemon:-
    picked_tokemon_num(TK_NUM),
    remove_TK_num_from_inventory(TK_NUM), nl,
    write("Your Tokemon crippled and, after a terrible sound bombarded your senses, it dissolved into the air."), nl,
    write("The Tokemon you had been fighting smiled menacingly."), nl,
    write("A terrible buzzing sound began to fill the silence after the death of your Tokemon."), nl,
    write("Quick! pick. another Tokemon to call forth before everything is too late!"), nl,
    write("Or is it already too late for you?"), nl,

    player_tokemon_list(PTL),
    list_writer(PTL),
    
    list_count(PTL, NUM_OF_TOKEMON_LEFT),
    NUM_OF_TOKEMON_LEFT > 0 -> force_player_pick; player_die.

player_die:-
    reset_dynamics,
    write("A terrible sound filled the air, everything was spinning, everything was dark."), nl,
    write("You are helpless, all your Tokemons gone to the screeching air."), nl,
    write("You felt a presence beside you"), nl,
    write("... but you felt absolute, unadulterated fear."), nl,
    write("In a flash of light, all you saw was black and ribbons of gleaming red"), nl,
    write("and then"), nl,
    write("..."), nl,
    write("NOTHING"), nl,
    write("YOU DIED"),
    halt(0).

remove_capturable_Tokemon:-
    retract(capturable(_)),
    assertz(capturable(none)).

reset_dynamics:-
    retract(player_battle_tokemon(_)),
    retract(picked_tokemon_num(_)),
    retract(picked_tokemon_health(_)),
    retract(picked_tokemon_enhancment(_)),
    retract(picked_tokemon_used_skill(_)),
    retract(opposing_tokemon(_)),
    retract(opposing_tokemon_health(_)),
    retract(wild_encountered_tokemon(_)),
    retract(opposing_tokemon_used_skill(_)),
    retract(enemy_waiting_list(_)),
    %retract(capturable(_)),

    assertz(player_battle_tokemon(none)),
    assertz(picked_tokemon_num(0)),
    assertz(picked_tokemon_health(0)),
    assertz(picked_tokemon_enhancment([])),
    assertz(picked_tokemon_used_skill(0)),
    assertz(opposing_tokemon(none)),
    assertz(opposing_tokemon_health(0)),
    assertz(wild_encountered_tokemon(none)),
    assertz(opposing_tokemon_used_skill(0)),
    assertz(enemy_waiting_list([])).
    %assertz(capturable(none)).

back_to_movement:-
    reset_dynamics,
    remove_capturable_Tokemon.

legendary_check:-
    legend_tokemon_list(RLL),
    RLL == [],
    write("You have successfully defeated the legendaries."), nl,
    write("Congratultations."), nl, halt(0).

legendary_check:- !.