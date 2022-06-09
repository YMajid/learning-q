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

noOrders:{[t]
	t:update latestExitT:maxs exitT from t;
	t:update emptyDuration:subT-prev latestExitT from t;
	t:update emptyDuration:subT-openTime from t where null emptyDuration;
	select startTime:`time$subT-emptyDuration,periodLength:`time$emptyDuration
	from t where emptyDuration>=0
	};

show noOrders simOrders
