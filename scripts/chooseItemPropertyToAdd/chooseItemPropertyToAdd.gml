/// chooseItemPropertyToAdd(item,propsChanceMap)
/// @param item
/// @param propsChanceMap

/// returns an item property key not yet added to this item

var item = argument[0];
var propsChanceMap = argument[1];

// decide what property it will be 
// if we've already added this property, choose a different one (roll again)
/*
var propKey = noone;
do {
	/*randomize();
	var rand = random_range(0,1);
	var lowestSeen = 2; 
	var currentPropKey = ds_map_find_first(propsChanceMap);
	for (var j = 0; j < ds_map_size(propsChanceMap); j++) {
			
		var prob = ds_map_find_value(propsChanceMap,currentPropKey);
		if rand < prob && prob < lowestSeen {
			lowestSeen = prob;
			propKey = currentPropKey;
		}
			
		currentPropKey = ds_map_find_next(propsChanceMap,currentPropKey);
	}
	propKey = getKeyFromCumulativeProbMap(propsChanceMap);
	
	var currentVal = ds_map_find_value(item.itemProperties,propKey);
	
} until (currentVal == undefined)
*/

var cumSum = 0;
var currentPropKey = ds_map_find_first(propsChanceMap);
for (var i = 0; i < ds_map_size(propsChanceMap); i++) {
	var weight = ds_map_find_value(propsChanceMap,currentPropKey);
	cumSum += weight;
	currentPropKey = ds_map_find_next(propsChanceMap,currentPropKey);
}

//
do {
	randomize(); 
	var rand = random_range(0,cumSum);
	
	var currentPropKey = ds_map_find_first(propsChanceMap);
	var propKey = noone; // the chosen propKey based on this roll
	var lowerBound = 0; var upperBound = 0;
	for (var i = 0; i < ds_map_size(propsChanceMap); i++) {
		var weight = ds_map_find_value(propsChanceMap,currentPropKey);
		upperBound += weight;
		if rand >= lowerBound && rand <= upperBound {
			propKey = currentPropKey; break;
		}
		
		lowerBound += weight;
		currentPropKey = ds_map_find_next(propsChanceMap,currentPropKey);
	}
	
	var currentVal = ds_map_find_value(item.itemProperties,propKey);
	
} until (currentVal == undefined)

return propKey;