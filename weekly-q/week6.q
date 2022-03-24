/ 2020.02.10
genOrders:{[nOrders;seed;openTime;closeTime]
    system "S ",string seed;
    submitTimes:asc closeTime&openTime+nOrders?390*60*1000;

    system "S ",string seed;
    exitTimes:closeTime&submitTimes+nOrders?60*1000;

    ([] orderId:1000+til nOrders;subT:submitTimes;exitT:exitTimes)
  };

openTime:`time$09:30;
closeTime:`time$16:00;
simOrders:genOrders[5000;-314159;openTime;closeTime];

openOrders:{[orders]
	/ No orders right at market open
	mOpen:([] time:enlist openTime;nOrders:enlist 0);
	/ Get all new orders made
	oOrders:select time:subT,nOrders:1 from orders;
	/ Get all closed orders
	cOrders:select time:exitT,nOrders:-1 from orders;
	/ Combine tables into one, ordered based on time
	orders:select startTime:time,nOpenOrders:sums nOrders from `time xasc mOpen,oOrders,cOrders;
	/ Return results only where number of open orders differ
	select from orders where differ nOpenOrders
  }

show openOrders simOrders
