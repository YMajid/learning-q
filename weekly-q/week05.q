/ 2020.02.03
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

noOrderPeriods:{[t]
	t:update latestExitT:maxs exitT from t;
	t:update noOrderDuration:subT-prev latestExitT from t;
	t:update noOrderDuration:subT-openTime from t where null noOrderDuration;
	select startTime:`time$subT-noOrderDuration,periodLength:`time$noOrderDuration
	from t where noOrderDuration>=0
	};

show noOrderPeriods simOrders
