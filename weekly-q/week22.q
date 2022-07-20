/ 2020.06.01
calcPercentile:{[p;v]
  n:count v;
  asc[v] 0|-1+ceiling p*n};

nums:100000?100f;
calcPercentile[0.1 0.25 0.5 0.75 1f;nums]
calcPercentile[0.1 0.25 0.5 0.75 1f;1+til 100]
