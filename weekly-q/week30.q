/ 2020.07.27
simLimitOrderBook:{
  n:10000;
  system "S -314159";
  syms:n?`AAPL`C`IBM;
  times:asc 09:30+n?"n"$06:30;
  bidPrices:20+0.01*sums?[n?1.<0.5;-1;1];
  bidSizes:n?10000;
  t:([] sym:syms;time:times;bidPrice1:bidPrices;bidSize1:bidSizes);
  t:update bidPrice2:bidPrice1-0.01*1+n?3,bidSize2:n?10000 from t;
  t:update bidPrice3:bidPrice2-0.01*1+n?3,bidSize3:n?10000 from t;
  t:update bidPrice4:bidPrice3-0.01*1+n?3,bidSize4:n?10000 from t;
  t:update bidPrice5:bidPrice4-0.01*1+n?3,bidSize5:n?10000 from t;

  t:update askPrice1:bidPrice1+0.01*1+n?6,askSize1:n?10000 from t;
  t:update askPrice2:askPrice1+0.01*1+n?3,askSize2:n?10000 from t;
  t:update askPrice3:askPrice2+0.01*1+n?3,askSize3:n?10000 from t;
  t:update askPrice4:askPrice3+0.01*1+n?3,askSize4:n?10000 from t;
  t:update askPrice5:askPrice4+0.01*1+n?3,askSize5:n?10000 from t;
  t
  };
lob:simLimitOrderBook[];

calculateQuoteImbl:{[lob]
  lob:update midPx:0.5*bidPrice1+askPrice1 from lob;
  weightedSize:select sym,time
    ,weightedBidSize:(1%midPx-bidPrice1;1%midPx-bidPrice2;1%midPx-bidPrice3;
      1%midPx-bidPrice4;1%midPx-bidPrice5) wavg (bidSize1;bidSize2;bidSize3;bidSize4;bidSize5)
    ,weightedAskSize:(1%midPx-askPrice1;1%midPx-askPrice2;1%midPx-askPrice3;
      1%midPx-askPrice4;1%midPx-askPrice5) wavg (askPrice1;askPrice2;askPrice3;askPrice4;askPrice5)
  from lob;
  select sym,time,quoteImbl:(weightedBidSize-weightedAskSize)%weightedBidSize+weightedAskSize
    from weightedSize};

show calculateQuoteImbl[lob]
