/// getNormalizedWeightMap(probMap)
/// @param probMap -- map with (<enum value>,<prob 0-100>)

var map = argument[0];
var newMap = ds_map_create();

// get total weights
var currentKey = ds_map_find_first(map);
var totalWeight = 0;
for (var i = 0; i < ds_map_size(map); i++) {
	var probability = ds_map_find_value(map,currentKey);
	totalWeight += probability;
	currentKey = ds_map_find_next(map,currentKey);
}

var currentKey = ds_map_find_first(map);
for (var i = 0; i < ds_map_size(map); i++) {
	
	var weight = ds_map_find_value(map,currentKey);
	var newWeight = weight / totalWeight;
	ds_map_replace(newMap,currentKey,newWeight);
	
	currentKey = ds_map_find_next(map,currentKey);
}

return newMap;