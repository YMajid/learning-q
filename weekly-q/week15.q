/ 2020.04.13
parseFixMsg:{[msg] (!)."S=|"0:msg};

fixMsg:"35=D|22=RIC|48=MS.N|54=1|44=33.85|53=500|30=XNYS";
show parseFixMsg fixMsg
