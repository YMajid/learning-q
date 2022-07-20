/ 2020.06.08
simPrices:{
  n:100000;
  system "S -314159";
  ([] time:asc 09:30+n?"n"$06:30;price:20+0.01*sums?[n?1.<0.5;-1;1])};
prices:simPrices[];

priceReturn:{[p;n]
  retHorizon:(,'/) {[d;i]
	t:d`time;
	w:(t;t+"v"$i);
	r:wj[w;`time;d;(d;({p0:first x;p1:last x;-1+p1%p0};`price))];
	?[r;();0b;enlist[`$"r",string i]!enlist `price]}[p;] each 1+til 5;
  p,'retHorizon};
show priceReturn[prices;3]
