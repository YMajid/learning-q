/ https://code.kx.com/q/wp/corporate-actions/
/ Applying corporate-action adjustments on the fly to equity data

path:":whitepapers/corporate-actions/"

/ Name Change
sym:`APPL`IBM`GOOG`PLTR`FB`NFLX`AMZN`MSFT`RIM`CCIV
cact:update uid:i, date:2010.10.04 from ([] sym:sym)
/ save `$(path,"cact.csv")

Daily_Cor:([]
	eff_date:2013.02.04 2022.06.08 2022.07.23;
	new_ric:`BB`META`LCID;
	old_ric:`RIM`FB`CCIV;
	uid:8 4 9)

/ cact:`uid`date xkey ("IDS";enlist csv) 0:`$(path,"cact.csv")
cact:`uid`date xkey cact
`cact upsert `uid`date xkey select uid:uid, date:eff_date,
	sym:new_ric from Daily_Cor

cact:`uid`date xasc cact
show select from cact where uid in (4 8 9)

/ save `$(path,"cact.csv")

/ The Data
params:(!) . flip (
  (`symList  ; `BB`FB);          /Requested instruments
  (`startDate; 2013.01.31);      /Only take data from startDate
  (`endDate  ; 2013.02.04);      /Only take data to endDate
  (`startTime; 14:30:00.000);    /Only take data from startTime
  (`endTime  ; 22:00:00.000);    /Only take data to endTime
  (`columns  ; `volume`vwap);    /Requested analytics
  (`applyCact; `NC))             /To apply name change adjustments

cact_adj:{[symList;sD;eD]
	days:1+eD-sD;
	symCount:count symList;
	t where differ t:([] OrigSymList:raze days#/:symList) +
		cact ([]
			uid:raze days#/:((reverse cact)?/:symList)[`uid];
			date:raze symCount#enlist sD+ til days)}

show cact_adj . (`BB`FB;2013.01.31;2013.02.04)

if[params[`applyCact]~`NC;
	params:@[params;`symList`OrigSymList;:;
		(cact_adj . params`symList`startDate`endDate)`sym`OrigSymList]]
show params

/ Stock Split
show trade:([]sym:enlist `XYZ.L;date:2010.09.01;price:200;size:3000)
show scrTbl:([]sym:`XYZ.L;date:2010.10.01 2012.02.16;action:`SS;adj:`float$10 2)

adjscr:{[scrTbl]
	scrTbl:`sym`date`action`padj xcol update sadj:1%adj
		from scrTbl where action in `SS;
	scrTbl:update padj:1%padj from scrTbl where not action in `SS;
	update sadj:1^sadj from scrTbl}
show scrTbl:adjscr[scrTbl]

afact:{reverse reciprocal prds 1, reverse x}

ca:{[cact]
	`s#2!ungroup update
		date:(0Nd,'date),
		padj:afact each padj,
		sadj:afact each sadj from `sym xgroup `sym`date xasc ``action _
			select from scrTbl where date<=.z.d, action in cact}
adjTbl:ca[`SS]

/*.Q.view 2010.06.24 2011.07.12 2014.01.10*/
/*show select sum size, avg price by sym,date from trade where sym=`XYZ.L*/

/*show adjAgg:`size`price!((*;`size;`sadj);(*;`price;`padj))*/
/*adj:{[cact;res]*/
	/*res:update padj:1^padj,sadj:1^sadj*/
		/*from aj[`sym`date;res;$[not count adjTbl:ca[cact];:res;adjTbl]];*/
	/*:`padj`sadj _ 0!![res;();0b;]*/
		/*(c where (c:cols res) in key adjAgg)#adjAgg}*/
/*show select sum size,avg price by sym,date*/
	/*from adj[`SS;] select from trade where sym in `XYZ.L*/

/ Cash Dividend
cd_padj:{[P;X] (P-X)%P}

show scrTbl:([] sym:(),`BP.L;date:2014.02.12;action:`CD;adj:cd_padj[7.00;0.05])
show scrTbl:adjscr[scrTbl]
adjTbl:ca[`CD]

.Q.view 2014.02.11 2014.02.12
0!select last price,last size by sym,date from trade where sym=`BP_.L
adj[`CD;] select last price,last size by sym,date from trade where sym=`BP.L

/ Combining Adjustments
show trade:([]
  date:2013.01.01 2013.04.01 2013.07.01 2014.01.01;
  sym:4#`VOD.L;
  price:4#10;
  size:4#1000 )

show scrTbl:([] 
  sym:`VOD.L;
  date:2012.05.01 2013.02.01 2013.07.01 2013.11.01 2014.06.01;
  action:`SS`CD`CD`SS`CD;
  adj:`float$2 0.95 0.97 10 0.96 )

scrTbl:adjscr[scrTbl]
adj[`;]select from trade         / No adjustments applied
adj[`SS;]select from trade       / Stock split
adj[`CD;]select from trade       / Cash dividend
adj[`SS`CD;]select from trade    / Stock split and cash dividend
