/ Cards Information
SUITS:"SHCD"
NUMBERS:"A23456789TJQK"                     / We're using "T" instead of 10 here
SYM:`$NUMBERS cross SUITS                   / Get numbers for each suit
SYM,:`$("[]";"__")                          / Hidden card; empty stack
HC:52                                       / Hidden card index
ES:53                                       / Empty stack index
SP:54                                       / Blank space index

/
Given a list of non-negative integers, where returns a vector containing, for each item x, that number of copies of its index
So,
  13#4       gives us 4       4       4       4       4       4       4 4 4 4 4 4
  where 13#4 gives us 0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 ...
Original assignment of NUMBER had an unnecessary til[13]:
  q)(1+til[13]where 13#4)~(1+where 13#4)
  1b
\
NUMBER:1+where 13#4                         / Card numbers
SUIT:52#SUITS                               / Card suits
COLOUR:"RB" SUIT in "SC"                    / Card colours

/ Helpers
ce:count each
le:last each
tc:('[til;count])                           / A composition; equivalent to the lambda {til count x}

/ Layout
TURN:3                                      / # of cards to turn
STOCK:0
WASTE:1
FOUNDATION:2+til 4
TABLEAU:6+til 7

/
g    game dictionary
p    number of passes through the stock
pm   possible moves, a list of triples: # cards, from pile, to pile
s    score
x    cards exposed on the tableau
\
deal:{[]                                    / Produces dictionary that represents the game state
	g:()!();                                / Initialize dictionary
	deck:-52?52;                            / 52 integers [0, 52)
	/ Columns: stock, waste, 4 foundations, 7 piles
	g[`c]:13#enlist 0#0;                    / Representing the layout as thirteen lists
	g[`c;TABLEAU]:(sums til 7)_ 28#deck;    / Tableau
	g[`x]:le g[`c;TABLEAU];                 / Exposed
	g[`c;STOCK]:28_ deck;                   / Deck without the first 28 items
	g[`s]:0;                                / Score
	g[`p]:0;                                / Passes
	turn g}

/ Display
/
First line; tope:
  - le g[`c]STOCK,WASTE,FOUNDATION
    - Finds the top card from six piles, returning nulls from empty piles
  - ES^
    - Replace the nulls with index for an empty stack
  - @[;0;HC|]
    - Substitutes in the stock pile for anything but an empty stack
	- Third argument is a unary; in this case its the projection HC|
	- This entire statement is also projected in order to seperate the apply at from the much longer expression that calculates the first argument
	  - @[;0;HC|] is a unary projection and it can be read as "apply HC| to the first item of the argument"
Second line:
  - Applies the card symbols, composes a 2x7 table and prefixes it with the number of cards in the stock pile and the number of passes made
Third line:
  - Composes the display of the tableau
  - Work is done by 3 lambdas but could have also been written using three lines; there's a tradeoff:
    - The longer the line the harder it is to read
	- Using intermediate variables asks the reader to remember it for later, even if its never used again
  - First lambda flags the exposed cards in the tableau columns and replaces the others with the hidden card index
  - Second lambda replaces the empty piles with the empty stack symbol
    - For a long list with few 1s in the boolean, Apply At would be more efficient as it would only act where 0=ce x
  - Third lambda provides us with the flip transformation that we're looking for
Fourth line:
  - Split display into 2 parts
Fifth line:
  - Display the player's score
Sixth line:
  - Displays the possible moves
  - Uses a quanternary lambda which is projected on one argument; the Apply operator and the Each iterator
\
display:{[g]                                                                    / Display game
	/ Stock, waste, foundations
	top:@[;0;HC|]ES^le g[`c]STOCK,WASTE,FOUNDATION;
	show (`$string count[g[`c;STOCK]],g[`p]),'SYM 2 7#(2#top),SP,(2_ top),7#SP;
	/ Tableau
	show SYM {flip x[;til max ce x]} {@[x; where 0=ce x; ES,]}
		{[g;c] g[`c;c]|HC*not g[`c;c] in g[`x]}[g] TABLEAU;
	show 21#"_";
	/ Score, possible moves
	show "Score: ",string g[`s];
	show $[0=count g[`pm]; "No moves possible";
		{[g;n;f;t] SYM first each neg[n,1]#'g[`c;f,t]}[g;].'g[`pm]];}

/ Possible Moves
/
Only exposed cards may be moved
On the waste and foundation only the last card in the column is exposed
On the tableau, g`x lists exposed cards
There are two possible moves:
  1. To the foundation from the waste or the tableau, a card of the same suit and next higher value to the target and any ace may move to an empty column
  2. To the tableau from the waste, tableau or foundation, a card of different colour and one lower value to the target card, and any king may move to an empty column
rpm:
  - top:
    - Unary function that finds the position of the top (last) cards in its argument columns, with no result items for empty columns
    - 
  - fm:
    - Function input are the game columns, and the candidate moves to the foundation
	  - The cross gives a list of triples: from-column, from-index and to-column
	- Given the list of triples, the first line selects the cards to be moved
	- For the triplet 1 2 2, c ./:m[;0 1] ~ c[1;2]
	  - Using Apply here with an iterator highlights a founding insight of q: a list is a function of its indexes
	- nof finds the corresponding card that could be placed on that foundation pile
	  - Third column of m holds the indexes of the target columns for the candidate move
	    - The first index of m[;2] is the first foundation index
	- xit:
	  - A list of the cards exposed in the tableau
	- tm:
	  - Target cards must be a different colour and the next higher value, or 0N if the move caard is an ace
	  - Note how Apply is used to apply operators between pairs of lists:
	    - .[-]NUMBER(tgts;cards) ~ NUMBER[tgts] - NUMBER[cards]
\
rpm:{[g]                                                  / Record possible moves
	/ Positions of top cards
	top:{(y,'i-1) where 0<i:ce x y}[g[`c]];
	/ Moves cards to foundation from waste or tableau
	fm:{[c;m]
		show top[WASTE,TABLEAU];
		cards:c ./:m[;0 1];                               / Cards to move; scattered indexing
		nof:SYM?`${(NUMBERS NUMBER x),'SUIT x}le c m[;2]; / Next cards on foundation
		m where (cards=nof) or (NUMBER[cards]=1)
			and SUIT[cards]=SUITS FOUNDATION?m[;2]
		}[g[`c]] top[WASTE,TABLEAU] cross FOUNDATION;
	/ Moves cards to tableau from waste, foundation, or tableau
	xit:raze TABLEAU cross'where each g[`c;TABLEAU] in g[`x];
	tm:{[c;m]
		cards:c ./:m[;0 1];
		tgts:le c m[;2];
		m where (.[<>;COLOUR(cards;tgts)] and 1=.[-]NUMBER(tgts;cards))
			or (tgts=0N) and NUMBER[cards]=13
		}[g[`c]] (top[WASTE,FOUNDATION],xit) cross TABLEAU;
	/ # of cards to move
	g[`pm]:{(ce[x y[;0]]-y[;1]),'y[;0 2]}[g[`c]] fm,tm;
	g}

/ Move and Turn
move:{[g;y]                                 / Move y (symbol atom or pair)
	if[not 99h~type g; '"not a game"];
	if[not all `c`p`x`pm in key g; '"not a game"];
	if[abs[type y]<>11; '"type"];
	if[(type[y]>0) and 2<>count y; '"length"];
	if[not all b:y in SYM; '"invalid card: "," "sv string y where not b];
	/ Map cards to n,f,t
	cards:SYM?y;
	cl:ce g[`c];                            / Column lengths
	f:first where cl>i:g[`c]?'first cards;  / From column
	n:cl[f]-i[f];                           / Cards to move
	t:$[2=count cards; first where cl>g[`c]?'cards 1;
		$[1=NUMBER first cards; first[FOUNDATION]+SUITS?SUIT first cards; 
		first[TABLEAU]+first where 0=ce g[`c;TABLEAU]]];
	if[not(n,f,t) in g[`pm]; '"invalid move"];
	move_[g;n;f;t]}

move_:{[g;n;f;t]                            / Move n cards in g from g[`c;f] to g[`c;t]; move cards between columns
	g[`c;t],:neg[n]#g[`c;f];                / Moving the cards
	g[`c;f]:neg[n]_ g[`c;f];                / Moving the cards
	let:le g[`c;TABLEAU];
	g[`s]+:5 0@all let in g[`x];            / Turned over tableau card?
	g[`x]:distinct g[`x],let;
	g[`s]+:$[f=WASTE; 5 10@t in FOUNDATION; / Score
		f in TABLEAU; 0 10@t in FOUNDATION;
		f in FOUNDATION; -15;
		0];
	rpm g}

turn:{[g;n]                                 / Turns TURN cards from the stock pile onto the waste pile and returns the game dictionary 
	trn:0=count g[`c;STOCK];
	g[`c;STOCK,WASTE]:g[`c;trn rotate STOCK,WASTE];
	g[`p]+:trn;
	move_[g; n&count g[`c;STOCK]; STOCK; WASTE]}[;TURN]

display g:deal[]
