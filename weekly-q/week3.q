/ 2020.01.20
genCO:{[parentId;waveId;side]
	n:-5;

	system "S -314159";
	ids:`long$.z.N+n?1000; / .z.N local time, .z.n UTC time

	system "S -314159";
	prices:100+0.01*n?100;

	system "S -314159";
	sizes:100*1+n?10';

	([] poid:parentId;wid:waveId;coid:ids;side:side;price:prices;size:sizes)
	};

genOrders:{
    buyOrders:raze {poid:`long$22:32:12.163;genCO[poid;x;`BUY]} each 101+til 20;
    sellOrders:raze {poid:`long$23:32:12.163;genCO[poid;x;`SELL]} each 101+til 20;
    buyOrders,sellOrders
	};

orders:genOrders[];

aggOrder:{[s]
	f:$[s=`BUY;max;min];
	select from orders where side=s,price=(f;price) fby ([] poid;wid)
	};

show raze aggOrder each `BUY`SELL
