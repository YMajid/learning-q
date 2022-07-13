s:{c where 0=x mod c:1+til x div 2}          / Proper divisors; naive and CPU intensive
sd:sum s@                                    / Sum of proper divisors
abundant:{x<sd x}                            / Is the integer x abundant?

Filter:{y where x peach y}                               / Peach does the same thing as each, but will divide the work between available seconday tasks
A:Filter[abundant;945+2*til 26000]                       / We know that the first odd abundant numbers is 945, so we start our search here
show "Abundant numbers found: ", string count A          / How many abundant numbers were found?

/
The scan version of the do iterator applies a function f x many times.
  - x f\y (~f\[x;y]) means apply f successively x times to y
1 sd'\25#A:
  - \ applies sd 0 and 1 times to each of the first 25 items in A
  - Gives us two lists: the 25 abundant odd numbers and the sum of their divisors
\
1 sd'\25#A          / First 25 abundant odd numbers and the sum of their divisors; equivalent to (25#A;sd each 25#A)
1 sd\A 99           / 1000th abundant odd number and the sum of its divisors; equivalent to (A 999;sd A 999)

/ 1 sd\(not abundant@)(2+)/(prd 9#10)+1          / Lowest abundant number greater than 1,000,000,000
/ {1 sd\2+x 0}1000000571 0                       / Takes an odd number and its divisor sum, and returns the next odd number and its divisor sum
/ (.[>]){1 sd\2+x 0}/1000000001 0                / Test condition to see if abundant number

{sm:sd n:x+2;(n;$[n<sm;y,enlist n,sm;y])}.(1;())                                   / Returns the next odd number and updates the list of abundant numbers
{sm:sd n:x+2;(n;$[n<sm;y,enlist n,sm;y])}.(943;())
({(x;y,(x<sm)#enlist x,sm:sd x)}. 2 0+) (943;())                                   / Same as above, but composed it with a function that does the incrementing
flip{x 1}r:{25>count x 1}({(x;y,(x<sm)#enlist x,sm:sd x)}. 2 0+)/(1;())            /
