/ 2020.01.27
genTrades:{[seed;nTrades]
    / Randomly generate each trade's timestamp
    system "S ",string seed;
    times:`time$09:28:00.000+nTrades?392*60*1000;

    / Randomly generate trade size
    system "S ",string seed;
    volumes:`long$100*1+nTrades?10;

    / Randomly generate each trade's sale condition
    system "S ",string seed;
    saleConditions:{x?`B`C`H`L`N`P`R`T`U`V`X`Z`7`4`5`8} each nTrades?3;

    / Create a table of trades
    trades:([] time:times;volume:volumes;saleCondition:saleConditions);

    / Add the open and close auction trades
    trades:trades upsert (`time$09:30:00.000+rand 60000;24700j;`O`X);
    trades:trades upsert (`time$16:00:00.000+rand 2000;53800j;enlist `6);

    / Sort the trades time by time
    `time xasc trades
  };

simTrades:genTrades[-314159;10000];

/ Find the open and closing times, then sum up the volume of all trades in between
tVolume:{[trades]
	openTime:(exec time from simTrades where saleCondition~\:`O`X)[0];
	closeTime:(exec time from simTrades where saleCondition~\:enlist `6)[0];
	select sum volume from simTrades where time within (openTime; closeTime)
  };

tVolume simTrades

/
In the solutions, they used the like operator for string matching to get the auction times
instead of doing it in two steps like I did. Regardless, the two solutions produce the
same results.

auctionTimes:exec time from simTrades where any each saleCondition like\: "*[O6]*";
select sum volume from simTrades where time within auctionTimes
