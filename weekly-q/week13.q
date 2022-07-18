/ 2020.03.30
simQuote:{[venueList;nRows]
  priceList:30+0.01*til 10;
  prices:asc -3?priceList;                    / Negative ensures items selected are unique; a deal
  venues:3?venueList;
  bidPrices:(count each venues)#'prices;
  bidExchanges:raze venues;
  (bidPrices;bidExchanges)};

simLob:{
  nRows:20;
  seed:-314159;
  openTime:`time$09:30;
  closeTime:`time$16:00;
  litVenues:`XNYS`ARCX`XCHI`XASE`XCIS`XNAS`XBOS`XPHL`BATS`BATY`EDGA`EDGX`IEXG;

  system "S ",string seed;
  times:asc closeTime&openTime+nRows?390*60*1000;
  nExchange:2+nRows?(count litVenues)-8;
  bidVenues:{y?x}[litVenues;] each nExchange;
  quotes:simQuote[bidVenues;] each til nRows;

  ([] time:times; bidPrices:raze each quotes[;0]; bidExchanges:quotes[;1])};
lob:simLob[];

bidBook:{[t]
  t:update nyseLoc:where each `XNYS=bidExchanges from t;
  select time, bidPrices:bidPrices@'nyseLoc from t};

show bidBook lob
