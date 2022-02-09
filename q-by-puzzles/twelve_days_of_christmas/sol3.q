days:" "vs"first second third fourth fifth sixth",
  " seventh eighth ninth tenth eleventh twelfth"

gifts:(
  "A partridge in a pear tree.";
  "Two turtle doves";
  "Three french hens";
  "Four calling birds";
  "Five golden rings";
  "Six geese a-laying";
  "Seven swans a-swimming";
  "Eight maids a-milking";
  "Nine ladies dancing";
  "Ten lords a-leaping";
  "Eleven pipers piping";
  "Twelve drummers drumming")

intro:"On the day of Christmas, my true love gave to me:"
lyrics:{[day] enlist[{[x;y] ((7#x),days[y],6_x)}[intro;2]],"  ",/:
    reverse (day+1)#@[gifts;0;{y,1_x};$[day;"And a";"A"]]} each til count days


1 "\n" sv raze lyrics;
