/// addItemPropertiesByRarityAndAct(item,rarity,act,*propsChanceMapAddendums)
/// @param item
/// @param rarity
/// @param act -- determines the intesnity of the item property bonus
/// @param *propsChanceMapAddendums

var item = argument[0];
var rarity = argument[1];
var act = argument[2];
var addendums = noone;
if argument_count >=4 {
	addendums = argument[3];
}

var numPropertiesChanceMap = ds_map_create();

switch rarity {
	// normal Rings can have 1-2 properties
	case ItemRarities.Normal: {
		ds_map_replace(numPropertiesChanceMap,1,0);
		ds_map_replace(numPropertiesChanceMap,2,0);
		ds_map_replace(numPropertiesChanceMap,5,500);
		numPropertiesChanceMap = getNormalizedWeightMap(numPropertiesChanceMap);
		numPropertiesChanceMap = getCumulativeProbabilitiesMap(numPropertiesChanceMap);
		
		break;
	}
}

// decide how many properties to assign
randomize();
var rand = random_range(0,1);
var lowestSeen = 2; var numProps = noone;
var currentNumProps = ds_map_find_first(numPropertiesChanceMap);
for (var i = 0; i < ds_map_size(numPropertiesChanceMap); i++) {
			
	var prob = ds_map_find_value(numPropertiesChanceMap,currentNumProps);
	if rand < prob && prob < lowestSeen {
		lowestSeen = prob;
		numProps = currentNumProps;
	}
			
	currentNumProps = ds_map_find_next(numPropertiesChanceMap,currentNumProps);
}

//show_debug_message(numProps);

var propsChanceMap = getDefaultItemPropertiesChanceMap();
if addendums != noone {
	// TODO allow for addendums to propsChanceMap
	for (var i = 0; i < array_length_1d(addendums); i++) {
		var el = addendums[i];
		var prop = el[0]; var val = el[1];
		ds_map_replace(propsChanceMap,prop,val);
	}
}
propsChanceMap = getNormalizedWeightMap(propsChanceMap);
propsChanceMap = getCumulativeProbabilitiesMap(propsChanceMap);
// add num props properties to item
for (var i = 0; i < numProps; i++) {
	// decide what property it will be
	randomize();
	var rand = random_range(0,1);
	var lowestSeen = 2; var propKey = noone;
	var currentPropKey = ds_map_find_first(propsChanceMap);
	for (var j = 0; j < ds_map_size(propsChanceMap); j++) {
			
		var prob = ds_map_find_value(propsChanceMap,currentPropKey);
		if rand < prob && prob < lowestSeen {
			lowestSeen = prob;
			propKey = currentPropKey;
		}
			
		currentPropKey = ds_map_find_next(propsChanceMap,currentPropKey);
	}
	
	// decide property "intensity" by act
	var propRange = getItemPropertyValueRangeByAct(propKey,act);
	randomize();
	var rand = round(random_range(propRange[0],propRange[1]));
	var propVal = rand;
	
	// might need a macro value
	var macro = getPropertyMacro(propKey);
	if macro != noone {
		//var currentVal = ds_map_find_value(item.itemProperties,propKey);
		//if currentVal == noone || currentVal == undefined {
			ds_map_replace(item.itemProperties,propKey,[macro,propVal]);
		//}
	} else {
		ds_map_replace(item.itemProperties,propKey,propVal);
	}
	
}

ds_map_destroy(numPropertiesChanceMap); // mem leak
ds_map_destroy(propsChanceMap);