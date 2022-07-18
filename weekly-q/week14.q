/ 2020.04.06
simOrdersTIF:{
  nOrders:10000;
  seed:-314159;
  openTime:`time$09:30;
  closeTime:`time$16:00;
  listTifs:`Day,20#`IOC;
  
  system "S ",string seed;
  times:asc closeTime&openTime+nOrders?390*60*1000;

  system "S ",string seed;
  tifs:nOrders?listTifs;

  ([] time:times;tif:tifs)};
orders:simOrdersTIF[];

clusters:{[t]
  t:update isIOC:`IOC=tif from t;
  t:update clusterNo:sums 1_(>)prior (0, isIOC) from t;
  t:update duration:last time-first time by clusterNo from t where isIOC;
  select from t where duration=max duration};

show clusters orders
