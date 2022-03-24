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

emptyPeriods:{[orders]
	/ Get the maximum exit times
	t:update maxExitT:maxs exitT from orders;
	/ Positive durations indicate that there is a gap between the max exit time and next submit time
	t:update noOrderDur:subT - prev maxExitT from t;
	/ To account for time between market open and first submit time
	t:update noOrderDur:subT - openTime from t where null noOrderDur;
	/ Returning results
	select startTime:`time$subT - noOrderDur, periodLength:`time$noOrderDur from t where noOrderDur > 0
  };

show emptyPeriods simOrders

/
Since times and dates are integers in q, when looking for positive periods we
can use the condition "> 0" instead of "> 00:00:00.000".
\

