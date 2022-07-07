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

/ Given a string x and a boolean vector y, spread the characters of x to the positions of 1s in y, filling intervening characters with underscores
expansionMansion:{[x;y] ("_",x) y*sums y}; / Insert "_" at the beginning of the string, select character to be displayed

expansionMansion["fbr";100101b]
expansionMansion["bigger";0011110011b]

/ Given a string x, replace all vowels by an underscore
replaceVowels:{[x]
	v:"aeiouyAEIOUY";
	?[x in v;"_";x]}; / Instead of having lower and uppercase vowels, we can use (lower x) in v

replaceVowels["FLAPJACKS"]
replaceVowels["Several normal words"]

/ Given a string x, remove all the vowels entirely
removeVowels:{[x]
	v:"aeiouyAEIOUY";
	x except v};

removeVowels["FLAPJACKS"]
removeVowels["Several normal words"]

/ Given strings x and y, replace all words in x which are the same as y with a series of x's
redactTitle:{[x;y] ssr[x;y;(count y)#"X"]}; / Search for pattern y in string x and replace it

redactTitle["a few words in a sentence";"words"]
redactTitle["one fish two fish";"fish"]
redactTitle["I don't give a care";"care"]

/ Given a string x, give all possible permutations
permutations:{[x]};

permutations["xyz"]

/ Remove whitespace from beginning and end of strings
removeWhitespace:{[x] (neg ?[reverse " "=x;0b]) _ ?[" "=x;0b]_x}; / Use ? to give us the index of the first non-space character and the last, and use _ to remove the excess whitespace

removeWhitespace["   abc def  "]
