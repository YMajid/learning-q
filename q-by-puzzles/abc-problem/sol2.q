BLOCKS:string`BO`XK`DQ`CP`NA`GT`RE`TG`QD`FS`JW`HU`VI`AN`OB`ER`FS`LY`PC`ZM
WORDS:string`A`BARK`BOOK`TREAT`COMMON`SQUAD`CONFUSE

abc:{[w;b]
	.done::0b;
	{[w;b]
		$[.done; 1b;
			.done::0=count w; 1b;
			any .z.s[1_w;] each b _/:where (first w) in/:b]}[w;b]}

WORDS abc\:BLOCKS
