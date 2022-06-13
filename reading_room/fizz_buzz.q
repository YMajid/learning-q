/ Vector containing 1-20 inclusive
x:1+til 20

/ Find fizz and buzz conditions using mod
0=x mod/:3 5

/ Number is divisable by neither, 3, 5, or both
1 2*0=x mod/:3 5
sum 1 2*0=x mod/:3 5

/ Choose from the following list of output symbols depending on value
(`$string x;20#`fizz;20#`buzz;20#`fizzbuzz);

/ Use case iterator to generate results
(sum 1 2*0=x mod/:3 5)'[`$string x;`fizz;`buzz;`fizzbuzz]
