/ 2020.04.20

calculateLULD:{[p]
  p:"f"$(),p;
  bandPctCutoff:0.75 0.2 0.05;
  lBound:0.15 0w 0w;
  idx:0.75 3f binr p;		/ binr, binary search, is faster than the linear find operator, ?
  diff:lBound[idx]&p*bandPctCutoff[idx];
  flip (p-diff;p+diff)};

/ Using the sorted attribute to turn the dictionary d into a stepped function
calculateLULD:{
  d:`s#0 0.2 0.75 3.0001!(0.75;0n;0.2;0.05);
  p:0.15^x*d "f"$(),x;
  flip(x-p;x+p)};

calculateLULD 3
calculateLULD 3 10
calculateLULD 0.1 0.5 3 10
