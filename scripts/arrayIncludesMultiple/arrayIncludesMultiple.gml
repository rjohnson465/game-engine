/// arrayIncludes(arr,arrValues)
/// @param arr
/// @param arrValues

var arr = argument0;
var arrVals = argument1;

for (var i = 0; i < array_length_1d(arrVals); i++) {
	if !arrayIncludes(arr,arrVals[i]) return false;
}
return true;

