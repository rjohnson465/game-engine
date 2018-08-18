/// getKeyFromCumulativeProbMap(map)
/// @param map

var map = argument[0];

// first, make list of all probabilties in order
var list = ds_list_create();
var map2 = ds_map_create();

ds_map_copy(map2,map);

while(ds_map_size(map2) > 0) {
	// find smallest value in map, add it to list
	var lowestVal = 2; var lowestValIndex = noone;
	var currentKey = ds_map_find_first(map2);
	for (var i = 0; i < ds_map_size(map2); i++) {
		var prob = ds_map_find_value(map2,currentKey);
		
		if prob < lowestVal {
			lowestVal = prob;
			lowestValIndex = currentKey;
		}
		
		currentKey = ds_map_find_next(map2,currentKey);
	}
	ds_list_add(list,lowestVal);
	ds_map_delete(map2,lowestValIndex);
}

// iterate over all probabilites IN ORDER
// roll 0-1 for each
// if roll < prob, quit and return, 
// else, keep going

var selectedProb = 1;
for (var i = 0; i < ds_list_size(list); i++) {
	var prob = ds_list_find_value(list,i);
	randomize();
	var rand = random_range(0,1);
	if rand < prob {
		selectedProb = prob;
		break;
	}
}

// find the key in map with selectedProb val
var key = noone;
var currentKey = ds_map_find_first(map);
for(var i = 0; i < ds_map_size(map); i++) {

	var prob = ds_map_find_value(map,currentKey);
	if prob == selectedProb {
		key = currentKey;
	}
	
	currentKey = ds_map_find_next(map,currentKey);
}

ds_map_destroy(map2); map2 = -1;
ds_list_destroy(list); list = -1;
return key;