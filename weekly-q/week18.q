/ 2020.05.04
portions:([]
  priceLevel:`AboveMidQuote`AtMidQuote`BelowMidQuote;
  portion:0.2 0.5 0.3);
atsVolume:([]
  venue:`CROS`JPMX`MSPL;
  qty:384818 130987 177100);

proportionByPriceLevel:{[portions;atsVolume]
  t:atsVolume cross portions;
  select venue,priceLevel,qtyAtPriceLevel:portion*qty from t};

show proportionByPriceLevel[portions;atsVolume]
