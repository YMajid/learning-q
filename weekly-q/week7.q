/ 2020.02.17
paramTbl:([]time:`time$();orderQty:`long$();limitPrice:`float$();params:());
`paramTbl insert (09:30:56.123;500000;0n;`StartTime`PovRate!(10:00:00.000;0.08));
`paramTbl insert (09:35:44.735;500000;0n;`StartTime`PovRate!(09:40:00.000;0.08));
`paramTbl insert (10:01:25.941;500000;0n;`StartTime`PovRate!(09:40:00.000;0.12));
`paramTbl insert (10:10:32.356;500000;0n;`StartTime`PovRate`MinPovRate`MaxPovRate!(09:40:00.000;0.12;0.10;0.14));
`paramTbl insert (10:30:39.475;500000;45.23;`StartTime`PovRate`MinPovRate`MaxPovRate!(09:40:00.000;0.12;0.10;0.14));
`paramTbl insert (11:00:52.092;600000;45.27;`StartTime`PovRate`MinPovRate`MaxPovRate!(09:40:00.000;0.12;0.10;0.14));
`paramTbl insert (11:00:52.092;1000000;0n;`StartTime`PovRate!(09:40:00.000;0.15));

paramHistory:{[t]
	params:raze exec params from t;
	params:(key params)!(enlist each value params)[;1];
	params1:select time,OrderQty:orderQty,LimitPrice:limitPrice from t;
	params2:exec {x,y}[params;] each params from t;
	params1,'params2};

show paramHistory paramTbl
