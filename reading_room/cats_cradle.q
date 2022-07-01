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
isRotation:{[x;y] x in ((1 rotate)\) y}; / Generate a list of all possible rotations of y, and check if x is in that list

isRotation["foobar";"barfoo"]
isRotation["fboaro";"foobar"]
isRotation["abcde";"deabc"]

/ Given a list of strings, sort the list by length in ascending order
sortList:{[x] iasc x!(count each x)}; / Make a dictionary where the keys are the words and values are the lengths, sort the keys by the values and show
sortList:{[x] x iasc count each x} / Don't need to make a dictionary; use the binary version of iasc

sortList[("books";"apple";"peanut";"aardvark";"melon";"pie")]

/ Given a string x, return the character that appears the most. If there's a tie, return one of the characters randomly.
popChar:{[x] first idesc count each group x}; / Make a dictionary where keys are the chars and values are the counts, sort in desc order and pick the first

popChar["abdbbac"]
popChar["CCCBBBAA"]
popChar["CCCBBBBAA"]

/ Given a string x, reverse each word in place
revSentance:{[x] " " sv reverse each " " vs x};

revSentance["a few words in a sentence"]
revSentance["zoop"]
revSentance["one two three four"]

/ Given a string x and a boolean vector y of the same length, extract the characters of x corresponding to a 1 in y
compressString:{[x;y] where 1=x!y}; / Hacky way
compressString:{[x;y] x where y}; / Use binary where!

compressString["foobar";100101b]
compressString["embiggener";0011110011b]
