/ 2020.03.16
file:hsym `$":weekly-q/data/nasdaqlisted.txt"
nasdaqlisted:("SSSB JB "; enlist "|") 0:-1_ read0 file;
nasdaqlisted:`symbol`securityName`marketCategory`isTestIssue`lotSize`isETF
  xcol nasdaqlisted
show meta nasdaqlisted
