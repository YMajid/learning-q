/ 2020.03.23
simChildOrders:{[nOrders]
  seed:-314159;
  openTime:`time$09:30;
  closeTime:`time$16:00;
  litVenues:`XNYS`ARCX`XCHI`XASE`XCIS`XNAS`XBOS`XPHL`BATS`BATY`EDGA`EDGX`IEXG;

  system "S ",string seed;
  submitTimes:asc closeTime&openTime+nOrders?390*60*1000;

  system "S ",string seed;
  exDest:nOrders?litVenues;

  system "S ",string seed;
  nExchange:3+nOrders?(count litVenues)-3;

  system "S ",string seed;
  nbbVenues:{y?x}[litVenues;] each nExchange;

  ([] time:submitTimes; side:`BUY; exDest:exDest; nbbVenues:nbbVenues)};
childOrders:simChildOrders[5000];

nbbOrders:{[t]
	exec sum exDest in' nbbVenues from t;                      / Using in and each
	exec count i from t where any each exDest=nbbVenues};      / Using where, any and each

nbbOrders childOrders
