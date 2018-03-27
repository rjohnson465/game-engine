/// stringCapitalize(s)
/// @param s

var s = argument[0];

var firstLetter = string_char_at(s,0);
var restOfString = string_copy(s,2,string_length(s)-1);
firstLetter = string_upper(firstLetter);
var newString = firstLetter + restOfString;
return newString;