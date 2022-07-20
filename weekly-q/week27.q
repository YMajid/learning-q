/ 2020.07.06
formatTime:{
  cutoff:12:00:00;
  if[cutoff=x;:string[cutoff], " PM"]
  i:cutoff<x;
  string[x-i*cutoff]," ","AP"[i],"M"};

formatTime[01:58:57]
formatTime[12:00:00]
formatTime[14:34:45]
