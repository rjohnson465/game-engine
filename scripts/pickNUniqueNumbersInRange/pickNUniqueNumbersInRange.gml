/// pickNUniqueNumbersInRange(n,r1,r2)
/// @param n
/// @param r1
/// @param r2 

var n = argument[0];
var r1 = argument[1];
var r2 = argument[2];

var list = ds_list_create();
for (var i = r1; i < r2; i++) {
	ds_list_add(list,i);
}

ds_list_shuffle(list);

var arr = [];
for (var i = 0; i < n; i++) {
	arr[i] = ds_list_find_value(list,i);
}

ds_list_destroy(list); list = -1;

return arr;