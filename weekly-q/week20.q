/ 2020.05.18
genNormalNumber:{
  pi:acos -1;
  $[x=2*n:x div 2;
	raze sqrt[-2*log n?1f]*/:(sin;cos)@\:(2*pi*n?1f);
	-1_.z.s 1+x]};

genNormalNumber[5]
