/ https://code.kx.com/q/wp/market-depth/
/ Storing and producing views on market depth data

/ Schemas and Data Structures
marketQuotes:([                                    / Format of the data recieved from upstream feeds
	sym:`EURUSD;                                   / Assume data inserted is the application's current snapshot of the market
	src:`FeedA`FeedB;
	level:2]
  time:2013.11.20D19:05:00.849247000 2013.11.20D19:05:00.849247000;
  bid:1.43112 1.43113;
  ask:1.43119 1.4312)
quote:update bok:1b, aok:1b from marketQuotes      / Modified version of marketQuotes; will be used internally and updated on every timer run

show marketQuotes upsert `time`sym`src`level`bid`ask!       / Overwrites previous entry for EURUSD, FeedA with level 2
  (.z.p;`EURUSD;`FeedA;2;1.43113;1.43118)                   / The row index remains the same but the time and price columns are updated

asks:bids:(`u#"s"$())!()                / Stores the row indexes of occurrences of each instrument, sorted from best to worst
validasks:validbids:(`u#"s"$())!()      / Stores the indexes of unexpired prices by instrument

symtogroup:(`u#"s"$())!()          / Maps an instrument to a list of stream groups
grouptosym:(`u#"s"$())!"s"$()      / Maps a group name back to an instrument
streamgroups:(`u#"s"$())!()        / Maps a stream name to a list of feeds/sources
streamindices:(`u#"s"$())!()       / Maps a stream name to a list of row indexes

registerStreamGroup:{[sym;strgrp;strms]      / Create a stream group for an instrument by instantiating the data structures
  sg:` sv (sym;strgrp);
  if[sg in key streamgroups; :(::)];
  @[`symtogroup; sym; union; sg];
  @[`grouptosym; sg; :; sym];
  @[`streamgroups; sg; :; strms];
  @[`streamindices; sg; :; "i"$()];}

updateStreamGroups:{[tab]
  show sg:raze symtogroup distinct exec sym from tab;
  show s:grouptosym sg;
  .[`streamindices; (); ,';] sg!
    {[x;s;srcs]
	  $[count r:exec row from x where sym=s, src in srcs; r; "i"$()]
	}[tab]'[s;streamgroups sg];}

tab:([]
  sym:`EURUSD;
  src:`FeedA`FeedB;
  level:0 2;
  row:5 6)
updateStreamGroups tab
show streamindices

/ Implementation
.z.ts:{[]
  quoteTimer[0!marketQuotes];         / Table is passed into the sorting algorithm
  `marketQuotes:0#marketQuotes;}      / Table is cleared of records after sorting, this is why two schemas are used instead of one

quoteTimer:{[data]      / Sorting algorithm
  qc:count quote;
  `quote upsert updaet bok:1b, aok:1b from data;      / Updated data is inserted in quotes table with the expiry flags set to true

  s:distinct data`sym;
  if[not count s; :()];

  if[qc<count[quote];      / New quote key recieved, needs to update the stream group indexes
    updateStreamGroups[qc _ update row:i from quote];];

  bids,:exec i {idesc x}[bid] by sym from quote where sym in s;      / Append bid in descending order
  asks,:exec i {iasc x}[ask] by sym from quote where sym in s;       / Append ask in ascending order

  checkExpiry[];      / Update the expirty flags on the quoute table and update the valid quote structures
  updSubscribers[s];}

checkExpiry:{[]
  now:.z.p;
  update bok:now<bexptime, aok:now<aexptime from `quote;
  validbids,:exec i where bok by sym from quote;
  validasks,:exec i where aok by sym from quoute;}

updSubscribers:{[s]      / Grouping algorithm
  sg:raze symtogroup[s];
  s:grouptosym[sg];

  aix:getactiveasks[s] inter' streamindices[sg]; 
  bix:getactivebids[s] inter' streamindices[sg];

  qts:(0!quote)[`bid`ask`bsize`asize`src];

  bind:{[amnts;sz;s] s first where amnts[s] >= sz} [qts[2];1000000]'[bix];
  aind:{[amnts;sz;s] s first where amnts[s] >= sz} [qts[3];1000000]'[aix];

  new:([] time:.z.p;
    sym:s; 
    stream:sg; 
    bid:  qts[0;bind]; 
    ask:  qts[1;aind]; 
    bsize:qts[2;bind]; 
    asize:qts[3;aind]; 
    bsrc: qts[4;bind]; 
    asrc: qts[4;aind] );

  pub[`quoteView; new];
};
