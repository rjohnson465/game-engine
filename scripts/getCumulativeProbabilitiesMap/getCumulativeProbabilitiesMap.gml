/// getCumulativeProbabiltiiesMap(probMap, usesEnums*)
/// @param probMap -- normalized probabiltiy array (each val is 0-1 probabiliy, all elements add to 1)
/// @param usesEnums*

var probMap = argument[0];

var usesEnums = true;
if argument_count > 1 {
	usesEnums = argument[1];
}

var newMap = ds_map_create();

var currentKey = ds_map_find_first(probMap);
var cumProduct = 1;
var prevSum = 0;
for (var i = 0; i < ds_map_size(probMap); i++) {

	var prob = ds_map_find_value(probMap,currentKey);
	
	if i == 0 {
		ds_map_replace(newMap,currentKey,prob);
		prevSum = prob;
	} else if usesEnums {
		var newVal = prob;
		var currentKey2 = ds_map_find_last(newMap);
		for (var j = i-1; j >= 0; j--) {
			// fuck j is not necesarily defined, j is 0-indexed, enum value might not include 0
			//var cumProb = ds_map_find_value(newMap,j);
			var cumProb = ds_map_find_value(newMap,currentKey2);
			newVal = newVal * (1/(1-cumProb));
			currentKey2 = ds_map_find_previous(newMap,currentKey2);	
		}
		ds_map_replace(newMap,currentKey,newVal);
		
		if i == ds_map_size(probMap)-1 {
			ds_map_replace(newMap,currentKey,1);
		}
	} else {
		prevSum += prob;
		ds_map_replace(newMap, currentKey, prevSum);
	}
	
	currentKey = ds_map_find_next(probMap,currentKey);
}

return newMap;


