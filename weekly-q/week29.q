/ 2020.07.20
simTrade:{
  n:100000;
  system "S -314159";
  syms:n?`AAPL`C`IBM;
  times:asc 09:30+n?"n"$06:30;
  prices:20+0.01*sums?[n?1.<0.5;-1;1];
  sizes:n?10000;
  :([] sym:syms;time:times;price:prices;volume:sizes);
  };
trades:simTrade[];

rollingTimeWindowVWAP:{[trades;wl]
  t1:`sym`time xasc trades;
  times:exec time from t1;
  w:(neg[wl]+\:times;times);
  t2:select sym,time,notionalTraded:price*volume,sharesTraded:volume from t1;
  res:wj[w;`sym`time;t1;(t2;(sum;`notionalTraded);(sum;`sharesTraded))];
  select sym,time,price,volume,rollingVWAP:notionalTraded%sharesTraded from res};

show rollingTimeWindowVWAP[trades;00:05]
