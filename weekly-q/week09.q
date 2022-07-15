/ 2020.03.02
getTradingDays:{
  firstDate:2020.03.01;
  lastDate:2020.03.31;
  dates:firstDate+til (lastDate-firstDate)+1;
  dates where not (dates mod 7) in 0 1};

simulateTrades:{[seed;nTrades]
  tradingDays:getTradingDays[];

  system "S ",string seed;
  dates:nTrades?tradingDays;

  system "S ",string seed;
  tickers:nTrades?`3;

  system "S ",string seed;
  volumes:100*nTrades?1+til 100;

  ([] date:dates; ticker:tickers; volume:volumes)};
trades:simulateTrades[-314159;500000]

/ Calculate volume for each ticker for each date, sort on date and daily volume in descending order
trades:`date`dailyVol xdesc 0!select dailyVol:sum volume by date,ticker from trades;

/ Find first 10 indices on each day and then filter out those rows
show `date xasc select from trades where ({x in 10#x};i) fby date

/ Take top 10 tickers and daily volumes for each date
show ungroup select 10#ticker, 10#dailyVol by date from trades

/ Fastest approach, and cleanest if multiple columns are present in the table
show `date xasc select from trades where i in raze 10#/:group date
