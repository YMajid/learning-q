/ 2020.04.27
getSplitEvents:{
  ([] sym:`ABC`DEF; date:2020.04.08 2020.04.13; splitRatio:0.2 10)};

getDailyVolume:{
  dates:2020.03.10+til 50;
  weekdays:dates where 1<dates mod 7;
  tradingDays:weekdays except 2020.04.10;
  nDays:count tradingDays;

  seed:-314159;
  system "S ",string seed;
  volABC:([] sym:nDays#`ABC; date:tradingDays; dailyVol:nDays?200000+nDays?300000);
  volABC:update floor dailyVol*0.2 from volABC where date<2020.04.08;

  system "S ",string seed;
  volDEF:([] sym:nDays#`DEF; date:tradingDays; dailyVol:nDays?200000+nDays?300000);
  volDEF:update dailyVol*10 from volDEF where date<2020.04.13;

  `date xasc volABC,volDEF};

events:getSplitEvents[];
volume:getDailyVolume[];

adv:{[events;volume;nDays]
  tradingDays:select distinct date from volume;
  tradingDays:update startDate:date-nDays,
    endDate:date+nDays-1 from tradingDays;
  events:events lj `date xkey tradingDays;
  volume:volume lj `sym xkey select
    sym,effectiveDate:date,startDate,endDate from events;
  volume:update label:?[date<effectiveDate;`before;`after]
	from volume;
  `label`sym xdesc select adv:avg dailyVol by sym,label
    from volume where date within (startDate;endDate)};

show adv[events;volume;5]
