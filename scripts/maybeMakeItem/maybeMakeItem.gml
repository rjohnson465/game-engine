/// maybeMakeItem(dropChance,raritiesMap,*typeMap,*act,*gemTypeMap,*itemPropertiesChanceAddendums)
/// @param dropChance number 0-100
/// @param raritiesMap map (<RarityType>, [minRange,maxRange])
/// @param *typeMap map (<ItemType>, [minRange,maxRange])
/// @param *act number
/// @param *gemTypeMap map stating drop chances for each Gem 
/// @param *itemPropertiesChanceAddendums 
/// ^ this property lets one modify the odds of ModifiableProperties attached to the generated item
/// pass a map of form (<ModifiableProperty>,<prob>) -- the default propertyChanceMap will be updated with 
/// this new probability for that ModifiableProperty

// return item or noone

var dropChance = argument[0];
randomize();
var rand1 = random_range(0,100);
if rand1 >= dropChance return noone;

// PART 1: Select base item type
var typeMap = getDefaultItemTypeChanceMap();
if argument_count >=3 && argument[2] != noone {
	typeMap = argument[2];
}

var lowestSeen = 100; var itemType = noone;
var currentItemType = ds_map_find_first(typeMap);
for (var i = 0; i < ds_map_size(typeMap); i++) {
	var chanceRange = ds_map_find_value(typeMap,i);
	var chanceMin = chanceRange[0]; var chanceMax = chanceRange[1];
	if chanceMin <= lowestSeen && (rand1 <= chanceMax && rand1 > chanceMin) {
		lowestSeen = chanceMin;
		itemType = i;
	}
	currentItemType = ds_map_find_next(typeMap,currentItemType);
}
if itemType == noone itemType = ItemTypes.HandItem;
ds_map_destroy(typeMap); // prevent mem leak

// PART 2: Select object based on "act"
var act = getRoomAct();
if argument_count >= 4 && argument[3] != noone {
	act = argument[3];
}

var itemIndex = getBaseItemFromAct(itemType,act);
var item = instance_create_depth(x,y,1,itemIndex);

// refine gems to actual gem objects
if item.object_index == obj_gem_parent {
	// decide quality based on act
	randomize();
	var rand = random_range(0,100);
	var gemQualityMap = getGemQualityChanceMapFromAct(act);
	var lowestSeen = 100; var qualityType = noone;
	var currentItemType = ds_map_find_first(gemQualityMap);
	var qualityTypes = [CRACKED,NORMAL,EXQUISITE,FLAWLESS];
	for (var i = 0; i < array_length_1d(qualityTypes); i++) {
		var qt = qualityTypes[i];
		var chanceRange = ds_map_find_value(gemQualityMap,qt);
		var chanceMin = chanceRange[0]; var chanceMax = chanceRange[1];
		if chanceMin <= lowestSeen && (rand <= chanceMax && rand > chanceMin) {
			lowestSeen = chanceMin;
			qualityType = qt;
		}
		currentItemType = ds_map_find_next(gemQualityMap,currentItemType);
	}
	ds_map_destroy(gemQualityMap);
	
	// decide gemType (ruby, hematite, etc)
	randomize();
	var rand = random_range(0,100);
	var gemTypeChanceMap = getDefaultGemTypeChanceMap();
	if argument_count >= 5 && argument[4] != noone {
		gemTypeChanceMap = argument[4];
	}
	var lowestSeen = 100; var gemType = noone;
	var currentItemType = ds_map_find_first(gemTypeChanceMap);
	var allGemTypes = [obj_gem_hematite, obj_gem_lapis, obj_gem_ruby, obj_gem_aquamarine, obj_gem_emerald, obj_gem_topaz];
	for (var i = 0; i < array_length_1d(allGemTypes); i++) {
		var gt = allGemTypes[i];
		var chanceRange = ds_map_find_value(gemTypeChanceMap,gt);
		var chanceMin = chanceRange[0]; var chanceMax = chanceRange[1];
		if chanceMin <= lowestSeen && (rand <= chanceMax && rand > chanceMin) {
			lowestSeen = chanceMin;
			gemType = gt;
		}
		currentItemType = ds_map_find_next(gemTypeChanceMap,currentItemType);
	}
	ds_map_destroy(gemTypeChanceMap);
	
	item = makeGem(gemType,qualityType);
}

// PART 3: Decide Rarity, apply gems and / or item properties
var rarityMap = getDefaultItemRarityMap();
if argument[1] != noone {
	rarityMap = argument[1];
}

// set item rarity from rarityMap
var cumSum = 0;
var currentRarityKey = ds_map_find_first(rarityMap);
for (var i = 0; i < ds_map_size(rarityMap); i++) {
	var weight = ds_map_find_value(rarityMap,currentRarityKey);
	cumSum += weight;
	currentRarityKey = ds_map_find_next(rarityMap,currentRarityKey);
}

randomize(); 
var rand = random_range(0,cumSum);
	
var currentRarityKey = ds_map_find_first(rarityMap);
var rarityType = noone; // the chosen rarityType based on this roll
var lowerBound = 0; var upperBound = 0;
for (var i = 0; i < ds_map_size(rarityMap); i++) {
	var weight = ds_map_find_value(rarityMap,currentRarityKey);
	upperBound += weight;
	if rand >= lowerBound && rand <= upperBound {
		rarityType = currentRarityKey; break;
	}
		
	lowerBound += weight;
	currentRarityKey = ds_map_find_next(rarityMap,currentRarityKey);
}

item.rarity = rarityType;

// gems -- hand items and head items
if itemType == ItemTypes.HandItem || itemType == ItemTypes.Head {
	addSocketsAndGemsByRarity(item,rarityType);
}

// item properties -- rings only, for now
if itemType == ItemTypes.Ring {
	var addendums = argument_count >=6 ? argument[5] : noone;
	addItemPropertiesByRarityAndAct(item,rarityType,act,addendums);
}

return item;

