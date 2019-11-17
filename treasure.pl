:- include('tokemon.pl').
:- include('map_move.pl').
:- include('battle.pl').

trasure(3,3,1).
trasure(3,4,1).
trasure(3,5,1).
trasure(3,1,1).
trasure(4,3,1).

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 3,
    B is 0,
    write('gada bray kan td udh diambil'),!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 3,
    B is 1,
    write('+10 normal attack'),
    write('TAPIIII -15 health'),
    write('ambil or skip?'),!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 4,
    B is 0,
    write('gada bray kan td udh diambil'),!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 4,
    B is 1,
    write('+5 normal attack'),
    write('+5 skill')
    write('TAPIIII -10 health'),
    write('ambil or skip?'),!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 5,
    B is 0,
    write('gada bray kan td udh diambil'),!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 5,
    B is 1,
    write('+10 health')
    write('+15 normal attack'),
    write('TAPIIII -15 skill'),
    write('ambil or skip?'),!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 1,
    B is 0,
    write('gada bray kan td udh diambil'),!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 1,
    B is 1,
    write('+5 skill'),
    write('+5 health'),
    write('TAPIIII -5 normal attack'),
    write('ambil or skip?'),!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 4,
    Y is 3,
    B is 0,
    write('gada bray kan td udh diambil'),!.

cekx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 4,
    Y is 3,
    B is 1,
    write('+5 skill'),
    write('+10 normal attack'),
    write('TAPIIII -20 health'),
    write('ambil or skip?'),!.

ambilx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 3,
    B is 1,
    write('ayo pilih tokemon buat gali'),
    get_tokemon_list_from_inventory(Tokemon_List),
    pick(Tokemon),
    /* h-15 */
    health(H,Tokemon),
    new_health is H - 15,
    retract(health(H,Tokemon)),
    assert(health(new_health,Tokemon)),
    /* na+10 */
    na(Tokemon, N),
    new_na is N + 10,
    retract(na(Tokemon, N)),
    assert(na(Tokemon, new_na)),
    /* treasure is taken */
    new_b is B-1,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,new_b)),

    write('hore u just gain more normal attack').

ambilx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 4,
    B is 1,
    write('ayo pilih tokemon buat gali'),
    get_tokemon_list_from_inventory(Tokemon_List),
    pick(Tokemon),
    /* h-10 */
    health(H,Tokemon),
    new_health is H - 10,
    retract(health(H,Tokemon)),
    assert(health(new_health,Tokemon)),
    /* na+5 */
    na(Tokemon, N),
    new_na is N + 5,
    retract(na(Tokemon, N)),
    assert(na(Tokemon, new_na)),
    /* s+5 */
    skill(Tokemon,S),
    new_skill is S + 5,
    retract(skill(Tokemon,S)),
    assert(skill(Tokemon,new_skill)),
    /* treasure is taken */
    new_b is B-1,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,new_b)),

    write('hore u just gain more normal attack and skill'),!.

ambilx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 5,
    B is 1,
    write('ayo pilih tokemon buat gali'),
    get_tokemon_list_from_inventory(Tokemon_List),
    pick(Tokemon),
    /* s-15 */
    skill(Tokemon,S),
    new_skill is S - 15,
    retract(skill(Tokemon,S)),
    assert(skill(Tokemon,new_skill)),
    /* h+10 */
    health(H,Tokemon),
    new_health is H + 10,
    retract(health(H,Tokemon)),
    assert(health(new_health,Tokemon)),
    /* na+15 */
    na(Tokemon, N),
    new_na is N + 15,
    retract(na(Tokemon, N)),
    assert(na(Tokemon, new_na)),
    /* treasure is taken */
    new_b is B-1,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,new_b)),

    write('hore u just gain more normal attack and health'),!.

ambilx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 3,
    Y is 1,
    B is 1,
    write('ayo pilih tokemon buat gali'),
    get_tokemon_list_from_inventory(Tokemon_List),
    pick(Tokemon),
    /* na-5 */
    na(Tokemon, N),
    new_na is N - 5,
    retract(na(Tokemon, N)),
    assert(na(Tokemon, new_na)),
    /* h+5 */
    health(H,Tokemon),
    new_health is H + 5,
    retract(health(H,Tokemon)),
    assert(health(new_health,Tokemon)),
    /* s+5 */
    skill(Tokemon,S),
    new_skill is S + 5,
    retract(skill(Tokemon,S)),
    assert(skill(Tokemon,new_skill)),
    /* treasure is taken */
    new_b is B-1,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,new_b)),

    write('hore u just gain more health and skill'),!.

ambilx:-
    here('x',X,Y),
    treasure(X,Y,B),
    X is 4,
    Y is 3,
    B is 1,
    write('ayo pilih tokemon buat gali'),
    get_tokemon_list_from_inventory(Tokemon_List),
    pick(Tokemon),
    /* h-20 */
    health(H,Tokemon),
    new_health is H - 20,
    retract(health(H,Tokemon)),
    assert(health(new_health,Tokemon)),
    /* na+10 */
    na(Tokemon, N),
    new_na is N + 10,
    retract(na(Tokemon, N)),
    assert(na(Tokemon, new_na)),
    /* s+5 */
    skill(Tokemon,S),
    new_skill is S + 5,
    retract(skill(Tokemon,S)),
    assert(skill(Tokemon,new_skill)),
    /* treasure is taken */
    new_b is B-1,
    retract(treasure(X,Y,B)),
    assert(treasure(X,Y,new_b)),

    write('hore u just gain more normal attack and skill'),!.