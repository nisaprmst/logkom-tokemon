% ukuran peta

row_size(10).
col_size(10).

%here(Prop, Row, Col).
here('G', 1, 1).
here('x', 3, 3).
here('x', 3, 4).
here('x', 3, 5).
here('x', 3, 1).
here('x', 4, 3).
here('-', Row, Col):- here(_, R, C), Row =\= R, Col =\= C.

showmap_col(Row, 1):- here(A, Row, 1), write(A), write(" x"), nl.
showmap_col(Row, N):- N > 1, here(A, Row, N), write(A), N1 is N-1, showmap_col(Row, N1).

showmap_plain(1, Col):- write("x "), showmap_col(1, Col).
showmap_plain(Row, Col):- Row > 1, Row1 is Row-1, showmap_plain(Row1, Col), write("x "), showmap_col(Row, Col).

