/ 2020.03.09
dataList:(
   "date,sym,order type,orderQty"
  ;"2020.03.09,AAPL.OQ,MID QUOTE,80000"
  ;"2020.03.09,AAPL.OQ,FAR TOUCH,50000"
  ;"2020.03.09,AAPL.OQ,NEAR TOUCH,120000"
  ;"2020.03.10,AAPL.OQ,MID QUOTE,100000"
  ;"2020.03.10,AAPL.OQ,FAR TOUCH,70000"
  ;"2020.03.10,AAPL.OQ,NEAR TOUCH,170000"
  ;"2020.03.09,IBM.N,MID QUOTE,83000"
  ;"2020.03.09,IBM.N,FAR TOUCH,54000"
  ;"2020.03.09,IBM.N,NEAR TOUCH,129000"
  ;"2020.03.10,IBM.N,MID QUOTE,130000"
  ;"2020.03.10,IBM.N,FAR TOUCH,79000"
  ;"2020.03.10,IBM.N,NEAR TOUCH,175000"
  ;"2020.03.09,BABA.N,MID QUOTE,120000"
  ;"2020.03.09,BABA.N,FAR TOUCH,68000"
  ;"2020.03.09,BABA.N,NEAR TOUCH,930000"
  ;"2020.03.10,BABA.N,MID QUOTE,150000"
  ;"2020.03.10,BABA.N,FAR TOUCH,96000"
  ;"2020.03.10,BABA.N,NEAR TOUCH,2030000");
dataTbl:("DSSJ"; enlist ",") 0:dataList

/ Rename badly named column
clnDataTbl:`date`sym`orderType`orderQty xcol dataTbl;

/ Total order quantity across all dates grouped by order type
show select totalOrderQty:sum orderQty by orderType from clnDataTbl

/ Total order quantity for order type "MID QUOTE" grouped by sym
/ Can also use the "like" operator in the where clause, but it's slower
show select totalOrderQty:sum orderQty by sym from clnDataTbl where orderType=`$"MID QUOTE"
