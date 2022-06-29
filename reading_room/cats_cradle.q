/ How many times does a character y occur in a string x?
charCount:{[x;y] sum x=y}; / Sum over a boolean array

charCount["fhqwhgads";"h"]
charCount["mississippi";"s"]
charCount["life";"."]

/ Is a string a palindrome?
isPalindrome:{[x] x~reverse x}; / ~ compares the lists, = compares the elements

isPalindrome["racecar"]
isPalindrome["wasitaratisaw"]
isPalindrome["palindrome"]

/ Which characters appear more than once in the string?
duplicates:{[x] where 1<count each group x}; / Can use where to filter dict keys/values

duplicates["applause"]
duplicates["foo"]
duplicates["buz"]

/ Do strings x and y contain the same letters?
isAnagram:{[x;y] asc[x]~asc[y]}; / Sort both strings and use the match operator

isAnagram["teapot";"toptea"]
isAnagram["apple";"elap"]
isAnagram["listen";"silent"]

/ Given a string x, find all the unique characters and list them in the same order they appear
uniqueChars:{[x] where 1=count each group x};

uniqueChars["somewhat heterogenous"]
uniqueChars["aaabccddefffgg"]

/ Given strings x and y, is x a rotation of the characters in y?
isRotation:{[x;y]};

isRotation["foobar";"barfoo"]
isRotation["fboaro";"foobar"]
isRotation["abcde";"deabc"]
