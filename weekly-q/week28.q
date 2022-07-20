/ 2020.07.13
simTrade:{
  n:100000;
  system "S -314159";
  times:asc 09:30+n?"n"$06:30;
  syms:n?`AAPL`C`IBM;
  prices:20+0.01*sums?[n?1.<0.5;-1;1];
  sizes:n?10000;
  :([] time:times;sym:syms;price:prices;volume:sizes);
  };
trades:simTrade[];

rollingVwap:{[trades;n]
	update nTickVWAP:msum[n;price*volume]%msum[n;volume] by sym from trades};

show rollingVwap[trades;10]
