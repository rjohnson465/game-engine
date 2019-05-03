/// maybeMakeItemBasic(itemsAndProbsMap, *chanceToDrop) 
/// @param itemsAndProbsArray
/// @param chanceToDrop*

var itemsAndProbsMap = argument[0];

if !ds_exists(itemsAndProbsMap, ds_type_map) || ds_map_size(itemsAndProbsMap) == 0 exit;

var chanceToDrop = 1;

if argument_count > 1 {
	chanceToDrop = argument[1];
}

// see if we even will drop
randomize();
var rand = random_range(0,1);
if rand > chanceToDrop exit;

var oldItemsAndProbsMap = itemsAndProbsMap;
itemsAndProbsMap = getNormalizedWeightMap(itemsAndProbsMap);
ds_map_destroy(oldItemsAndProbsMap);

var itemsAndProbsMapCum = getCumulativeProbabilitiesMap(itemsAndProbsMap, false);



// find out which itemToMake based on gemNumChanceMap
randomize();
var rand = random_range(0,1);
var lowestSeen = 2; var itemIndex = noone;
var currentItemIndex = ds_map_find_first(itemsAndProbsMapCum);
for (var i = 0; i < ds_map_size(itemsAndProbsMapCum); i++) {
			
	var prob = ds_map_find_value(itemsAndProbsMapCum,currentItemIndex);
	if rand < prob && prob < lowestSeen {
		lowestSeen = prob;
		itemIndex = currentItemIndex;
	}
			
	currentItemIndex = ds_map_find_next(itemsAndProbsMapCum,currentItemIndex);
}

return instance_create_depth(x,y,1,itemIndex);


ds_map_destroy(itemsAndProbsMap); itemsAndProbsMap = -1;
ds_map_destroy(itemsAndProbsMapCum); itemsAndProbsMapCum = -1;
