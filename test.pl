:- debug.


get_member_list_from_lists(N, I, Lists, Member_List):-
    N == I,
    [Head|_] = Lists,
    Member_List = Head.

get_member_list_from_lists(N, I, Lists, Member_List):-
    N \= I,
    J is (I + 1),
    [_|Tail] = Lists,
    get_member_list_from_lists(N, J, Tail, Member_List).
    %Member_List == R_Member.

get_member_list_from_lists(_, _, [], []):- !.

/* Make list of liss */
makeLofLs([], []):-!.
makeLofLs([Head|Tail], [H|HTail]):-
    list_to_set(Head,H), %H is a List 
    makeLofLs(Tail, HTail).
/* */

