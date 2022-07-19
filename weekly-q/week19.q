/ 2020.05.11
simulateSpreadBps:{[n]
    maxSpreadBps:10;
    cdf:0,sums {[n;p]n{(0,y*1-x)+x*y,0}[p]/1#1f}[maxSpreadBps-1;0.5];
    seed:-314159;
    mktOpenTime:"t"$09:30;
    mktCloseTime:"t"$16:00;
    system "S ",string seed;
    spreads:1+bin[cdf;n?1f]+n?1f;
    duration:ceiling raze 1?/:500&1%0.01*abs spreads-0.5*maxSpreadBps;
    dur:mktDur*durP:duration%mktDur:`long$mktCloseTime-mktOpenTime;
    times:mktOpenTime+`long$sums dur%sum durP;
    data:([]time:mktOpenTime,times;spreadBps:`float$maxSpreadBps,spreads);
    data:update dur:next[time]-time from data;
    data:update spreadBps:5*spreadBps from data where dur<00:00:00.050;
    select time,spreadBps from data
  };
spreads:simulateSpreadBps[100000];

calcTwaSpread:{[tbl;st;et]
  / exec avg spreadBps from tbl where time within (st;et) / Simple average spread
  tbl:update dur:next[time]-time from tbl;
  exec dur wavg spreadBps from tbl where time within (st;et)};

calcTwaSpread[spreads;10:31;14:35]
