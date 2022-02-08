days:" "vs"first second third fourth fifth sixth",
  " seventh eighth ninth tenth eleventh twelfth"

stanza:(
  "On the twelfth day of Christmas";
  "My true love gave to me:";
  "Twelve drummers drumming";
  "Eleven pipers piping";
  "Ten lords a-leaping";
  "Nine ladies dancing";
  "Eight maids a-milking";
  "Seven swans a-swimming";
  "Six geese a-laying";
  "Five golden rings";
  "Four calling birds";
  "Three french hens";
  "Two turtle doves";
  "And a partridge in a pear tree.";
  "")

verses:stanza @ 0 1,/:{(reverse x)+2+til each x+2} til 12
lyrics:raze .[;0 2;{"A",5_x}]verses{@[x;0;ssr[;"twelfth";y]]}'days
1"\n"sv lyrics;
