/ 2020.01.13
simSlippage:{
    n:10000;

    system "S -314159";
    slippage:5-0.01*n?1000;

    system "S -314159";
    notional:10000+n?100000;

    ([] notional:notional;slippage:slippage)
  };
perfData:simSlippage[];

nwsdev:{[w;x]
	n:sum w<>0;
	wx:x - w wavg x;
	sqrt (n%n-1)*w wavg wx*wx % w}

exec nwsdev[notional;slippage] from perfData
