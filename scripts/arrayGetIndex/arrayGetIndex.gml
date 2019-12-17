/// arrayGetIndex(arr, value)
/// @param arr
/// @param value

// get the index of a value in an array
// if there are multiple entries in array with this value, the index of the last entry is returned

var arr = argument[0];
var value = argument[1];

var index = noone;

for (var i = 0; i < array_length_1d(arr); i++) {
	var val = arr[i];
	if val == value {
		index = i;
	}
}

return index;