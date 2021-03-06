/// addSocketsAndGemsByRarity(item,rarity)
/// @param item 
/// @param rarity <enum>

var item = argument[0];
var rarity = argument[1];

// The odds of x number of sockets <numOfSockets,prob>
var socketsNumChanceMap = ds_map_create(); 

// The gems to insert into sockets
var gemNumChanceMap = ds_map_create();
var gemConditionChanceMap = ds_map_create();
var GEMS = [obj_gem_aquamarine,obj_gem_hematite,obj_gem_amethyst,obj_gem_emerald,obj_gem_lapis,obj_gem_ruby];

switch rarity {

	case ItemRarities.Normal: {
		// chances of getting 0-3 sockets
		ds_map_replace(socketsNumChanceMap,0,100);
		ds_map_replace(socketsNumChanceMap,1,0);
		ds_map_replace(socketsNumChanceMap,2,0);
		ds_map_replace(socketsNumChanceMap,3,0);
		
		var oldSocketsNumChanceMap = socketsNumChanceMap;
		socketsNumChanceMap = getNormalizedWeightMap(socketsNumChanceMap);
		ds_map_destroy(oldSocketsNumChanceMap); oldSocketsNumChanceMap = -1;
		
		oldSocketsNumChanceMap = socketsNumChanceMap;
		socketsNumChanceMap = getCumulativeProbabilitiesMap(socketsNumChanceMap);
		ds_map_destroy(oldSocketsNumChanceMap); oldSocketsNumChanceMap = -1;
		
		// chances of getting 0-3 gems
		ds_map_replace(gemNumChanceMap,0,100);
		ds_map_replace(gemNumChanceMap,1,0);
		ds_map_replace(gemNumChanceMap,2,0);
		ds_map_replace(gemNumChanceMap,3,0);
		
		var oldGemNumChanceMap = gemNumChanceMap;
		gemNumChanceMap = getNormalizedWeightMap(gemNumChanceMap);
		ds_map_destroy(oldGemNumChanceMap); oldGemNumChanceMap = -1;
		
		oldGemNumChanceMap = gemNumChanceMap;
		gemNumChanceMap = getCumulativeProbabilitiesMap(gemNumChanceMap);
		ds_map_destroy(oldGemNumChanceMap); oldGemNumChanceMap = -1;
		
		// chances of socketed gems' conditions -- TODO -- this should probably depend on act, not rarity
		ds_map_replace(gemConditionChanceMap,CRACKED,100);
		ds_map_replace(gemConditionChanceMap,NORMAL,0);
		ds_map_replace(gemConditionChanceMap,EXQUISITE,0);
		ds_map_replace(gemConditionChanceMap,FLAWLESS,0);
		
		var oldGemConditionChanceMap = gemConditionChanceMap;
		gemConditionChanceMap = getNormalizedWeightMap(gemConditionChanceMap);
		ds_map_destroy(oldGemConditionChanceMap); oldGemConditionChanceMap = -1;
		
		oldGemConditionChanceMap = gemConditionChanceMap;
		gemConditionChanceMap = getCumulativeProbabilitiesMap(gemConditionChanceMap);
		ds_map_destroy(oldGemConditionChanceMap); oldGemConditionChanceMap = -1;
		
		break;
	}
	
	case ItemRarities.Fine: {
		// chances of getting 0-3 sockets
		ds_map_replace(socketsNumChanceMap,0,0);
		ds_map_replace(socketsNumChanceMap,1,80);
		ds_map_replace(socketsNumChanceMap,2,10);
		ds_map_replace(socketsNumChanceMap,3,0);
		var oldSocketsNumChanceMap = socketsNumChanceMap;
		socketsNumChanceMap = getNormalizedWeightMap(socketsNumChanceMap);
		ds_map_destroy(oldSocketsNumChanceMap); oldSocketsNumChanceMap = -1;
		
		oldSocketsNumChanceMap = socketsNumChanceMap;
		socketsNumChanceMap = getCumulativeProbabilitiesMap(socketsNumChanceMap);
		ds_map_destroy(oldSocketsNumChanceMap); oldSocketsNumChanceMap = -1;
		
		// chances of getting 0-3 gems
		ds_map_replace(gemNumChanceMap,0,60);
		ds_map_replace(gemNumChanceMap,1,30);
		ds_map_replace(gemNumChanceMap,2,10);
		ds_map_replace(gemNumChanceMap,3,0);
		
		var oldGemNumChanceMap = gemNumChanceMap;
		gemNumChanceMap = getNormalizedWeightMap(gemNumChanceMap);
		ds_map_destroy(oldGemNumChanceMap); oldGemNumChanceMap = -1;
		
		oldGemNumChanceMap = gemNumChanceMap;
		gemNumChanceMap = getCumulativeProbabilitiesMap(gemNumChanceMap);
		ds_map_destroy(oldGemNumChanceMap); oldGemNumChanceMap = -1;
		
		// chances of socketed gems' conditions -- TODO -- this should probably depend on act, not rarity
		ds_map_replace(gemConditionChanceMap,CRACKED,100);
		ds_map_replace(gemConditionChanceMap,NORMAL,0);
		ds_map_replace(gemConditionChanceMap,EXQUISITE,0);
		ds_map_replace(gemConditionChanceMap,FLAWLESS,0);
		
		var oldGemConditionChanceMap = gemConditionChanceMap;
		gemConditionChanceMap = getNormalizedWeightMap(gemConditionChanceMap);
		ds_map_destroy(oldGemConditionChanceMap); oldGemConditionChanceMap = -1;
		
		oldGemConditionChanceMap = gemConditionChanceMap;
		gemConditionChanceMap = getCumulativeProbabilitiesMap(gemConditionChanceMap);
		ds_map_destroy(oldGemConditionChanceMap); oldGemConditionChanceMap = -1;
		
		break;
	}

} // end switch

// assign sockets to item based on socketsNumChanceMap
randomize();
var rand = random_range(0,1);
var lowestSeen = 2; var numSockets = 0;
var currentSockets = ds_map_find_first(socketsNumChanceMap);
for (var i = 0; i < ds_map_size(socketsNumChanceMap); i++) {
			
	var prob = ds_map_find_value(socketsNumChanceMap,currentSockets);
	if rand < prob && prob < lowestSeen {
		lowestSeen = prob;
		numSockets = currentSockets;
	}
			
	currentSockets = ds_map_find_next(socketsNumChanceMap,currentSockets);
}
		
item.numberOfSockets = numSockets;

// if we've socketed item at least once, see what gems we gonna insert into sockets
if numSockets != 0 {
			
	// find out how many gems to put in item based on gemNumChanceMap
	randomize();
	var rand = random_range(0,1);
	var lowestSeen = 2; var numGems = noone;
	var currentNumGems = ds_map_find_first(gemNumChanceMap);
	for (var i = 0; i < ds_map_size(gemNumChanceMap); i++) {
			
		var prob = ds_map_find_value(gemNumChanceMap,currentNumGems);
		if rand < prob && prob < lowestSeen {
			lowestSeen = prob;
			numGems = currentNumGems;
		}
			
		currentNumGems = ds_map_find_next(gemNumChanceMap,currentNumGems);
	}
	
	if numGems > numSockets numGems = numSockets;
	
	// choose numGems gems to insert (though this number may be lowert than numGems if numSockets < numGems)
	if numGems != 0 {
		
		for (var i = 0; i < numGems; i++) {
			randomize();
			var rand = round(random_range(0,array_length_1d(GEMS)-1));
			var gemBase = GEMS[rand];
			
			// assign gem condition (Cracked,Normal...) based on act
			randomize();
			var rand = random_range(0,1);
			var lowestSeen = 2; var gemCondition = noone;
			var currentGemCondition = ds_map_find_first(gemConditionChanceMap);
			for (var j = 0; j < ds_map_size(gemConditionChanceMap); j++) {
			
				var prob = ds_map_find_value(gemConditionChanceMap,currentGemCondition);
				if rand < prob && prob < lowestSeen {
					lowestSeen = prob;
					gemCondition = currentGemCondition;
				}
			
				currentGemCondition = ds_map_find_next(gemConditionChanceMap,currentGemCondition);
			}
			
			// create a gem and insert it into the item
			insertGemIntoItem(makeGem(gemBase,gemCondition),item);
		}		
	} // end gem insertion
			
}
// no sockets? this is a normal item
/*else {
	item.rarity = ItemRarities.Normal;
}*/
ds_map_destroy(socketsNumChanceMap); socketsNumChanceMap = -1;
ds_map_destroy(gemNumChanceMap); gemNumChanceMap = -1;
ds_map_destroy(gemConditionChanceMap); gemConditionChanceMap = -1;