/ 2020.06.15
simTrade:{
  n:100000;
  system "S -314159";
  :([]time:asc 09:30+n?"n"$06:30;price:20+0.01*sums?[n?1.<0.5;-1;1]);
  };
trades:simTrade[];

calcTwap:{[data;secs]
  w:neg[`second$(secs;0)]+\:exec time from data;
  t:wj[w;`time;data;(
	(select time,times:time,prices:price from data);
	({1_x};`times);
	({-1_x};`prices)
    )];
  t:update times:(first[w],'times) from t;
  t:update durs:{1_ deltas x} each times from t;
  t:update twap:durs wavg' prices from t;
  select time,price,twap from t};

show calcTwap[trades;300]
