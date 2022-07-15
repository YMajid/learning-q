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

openOrders:{[t]
	initOrder:([]time:enlist openTime;nOpenOrders:0);
	newOrders:select time:subT, nOpenOrders:1 from t;
	oldOrders:select time:exitT, nOpenOrders:-1 from t;
	orders:select time, sums nOpenOrders from `time xasc initOrder, newOrders, oldOrders;
	select startTime:time, nOpenOrders from orders where differ nOpenOrders
	};

show openOrders simOrders
