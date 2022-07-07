BOXES:()!()
BOXES[`new]:"AAEEGN ELRTTY AOOTTW ABBJOO EHRTVW CIMOTU DISTTY EIOSST DELRVY ACHOPS HIMNQU EEINSU EEGHNW AFFKPS HLNNRZ DEILRX"
BOXES[`old]:"AACIOT AHMORS EGKLUY ABILTY ACDEMP EGINTV GILRUW ELPSTU DENOSW ACELRS ABJMOQ EEFHIY EHINPS DKNOTU ADENVZ BIFORX"

VERSION:`old

DICE:" "vs BOXES VERSION
BS:"j"$sqrt count DICE                                    / Board size
BP:til[BS] cross til BS                                   / Board positions
SC:0 0 0 1 1 2 3 5,9#11                                   / Scores by word length

URL:"http://wiki.puzzlers.org/pub/wordlists/unixdict.txt"
UD:upper system"curl -s ",URL                             / Unix dictionary
BOGGLEDICT:ssr[;"QU";"Q"]each UD where count each UD < 17 / Replacing "QU" by "Q" and filtering by length

nb:{[c]                                                   / Find all neighbours of a coordinate c in a BS by BS board
	i:(.[cross] -1 0 1+/:c) except enlist c;              / Shift each coordinate by -1, 0, +1 and then cross to enumerate neighbours
	i where all each i within\:0,BS-1}                    / Filter results to only those within the board

NB:{BS sv flip nb[x]} each BP                             / List of the neighbours for each of the 16 positions

throw:{[dice]                                             / 2#BS makes the list (4 4) and (2#BS)#dice gives a 4x4 representation of the dice
	(2#BS)#dice@'count[dice]?6}                           / count[dice] indicies in range [0,6); apply (@) dice at each (') index
BOARD:throw DICE                                          / Throw the dice to get a board

try:{[B;BD;state]
	si:state 0;                                           / Current strings as indecies of B
	wf:state 1;                                           / Words found
	ns:raze {x,/:(NB last x) except x} each si;           / Next strings (indecies) to try
	ns:ns where B[ns] in count[first ns]#'BD;             / Eliminating duds by ensuring ns`s exist as prefix in BD
	wf:distinct wf,{x where x in y}[B ns;BD];             / Append new words found
	(ns;wf)}

solve:{[board]
	b:raze board;                                            / Raze board
	bd:BOGGLEDICT where all each BOGGLEDICT in b;            / Board dictionary
	s:distinct {x 1}try[b;bd;]/[(enlist each til BS*BS;())]; / Solutions
	s:ssr[;"Q";"QU"]each s;                                  / Replace "Q" by "QU"
	s:{x idesc count each x}asc s;                           / Sort asc alpha within desc size
	sc:SC @ count each s;                                    / Scores
	ok:where sc>0;                                           / Discard words that are too short (have a 0 score)
	show "maximum score: ",string sum sc;                    / Show maximum score attainable
	$[`;s]!sc}                                               / Return dictionary with strings as symbols

show BOARD
solve BOARD
