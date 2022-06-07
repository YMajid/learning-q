/ 2020.01.13
nwsdev:{[w;x]
	n:sum w<>0;
	wx:x - w wavg x;
	sqrt (n%n-1)*w wavg wx*wx % w}

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
	n:sum 0<>w;
	xd:x-w wavg x;
	sqrt (n%n-1)*w*xd*xd%w};

exec wsdev[notional;slippage] from perfData
