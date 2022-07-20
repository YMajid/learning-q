/ 2021.06.22
simTrade:{
  n:100000;
  system "S -314159";
  :`date`sym xasc ([]date:n?2020.06.22+til 5;sym:n?`IBM`MSFT`AAPL`MS`GS`C`EDU;volume:n?10000);
  };
trades:simTrade[];

lrgstVol:{[t]
	select from t where volume=(max;volume) fby ([] date;sym)};

show lrgstVol[trades]
