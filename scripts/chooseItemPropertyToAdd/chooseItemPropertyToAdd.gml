/// chooseItemPropertyToAdd(item,propsChanceMap)
/// @param item
/// @param propsChanceMap

/// returns an item property not yet added to this item

var item = argument[0];
var propsChanceMap = argument[1];

// decide what property it will be 
// if we've already added this property, choose a different one (roll again)
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
	}*/
	propKey = getKeyFromCumulativeProbMap(propsChanceMap);
	show_debug_message(propKey);
	
	var currentVal = ds_map_find_value(item.itemProperties,propKey);
	
} until (currentVal == undefined)

return propKey;