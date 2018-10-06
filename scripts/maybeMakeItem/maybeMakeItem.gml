/// maybeMakeItem(dropChance,raritiesMap,*typeMapOrIndexesArray,*act,*gemTypeMap,*itemPropertiesChanceAddendums)
/// @param dropChance number 0-100
/// @param raritiesMap map (<RarityType>, number)
/// @param *typeMapOrIndexesArray map | Array (<ItemType>, [minRange,maxRange]) -- odds of a specific type (i.e. Ring, Hat...)
/// @param *act number (what "act" should this item correspond to?)
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
if argument_count >= 3 && is_array(argument[2]) {
} else {
	var typeMap = getDefaultItemTypeChanceMap();
	if argument_count >=3 && argument[2] != noone {
		typeMap = argument[2];
	}

	var cumSum = 0;
	var currentTypeKey = ds_map_find_first(typeMap);
	for (var i = 0; i < ds_map_size(typeMap); i++) {
		var weight = ds_map_find_value(typeMap,currentTypeKey);
		cumSum += weight;
		currentTypeKey = ds_map_find_next(typeMap,currentTypeKey);
	}

	randomize(); 
	var rand = random_range(0,cumSum);
	
	var currentTypeKey = ds_map_find_first(typeMap);
	var itemType = noone; // the chosen item type based on this roll
	var lowerBound = 0; var upperBound = 0;
	for (var i = 0; i < ds_map_size(typeMap); i++) {
		var weight = ds_map_find_value(typeMap,currentTypeKey);
		upperBound += weight;
		if rand >= lowerBound && rand <= upperBound {
			itemType = currentTypeKey; break;
		}
		
		lowerBound += weight;
		currentTypeKey = ds_map_find_next(typeMap,currentTypeKey);
	}
	if itemType == noone itemType = ItemTypes.HandItem;

	ds_map_destroy(typeMap); typeMap = -1; // prevent mem leak
}

// PART 2: Select object based on "act" || based on indexesArray param
var itemIndex = noone;
if argument_count >= 3 && is_array(argument[2]) {
	var possibleObjIndexes = argument[2];
	randomize();
	var rand = round(random_range(0,array_length_1d(possibleObjIndexes)-1));
	itemIndex = possibleObjIndexes[rand];
} else {
	var act = getRoomAct();
	if argument_count >= 4 && argument[3] != noone {
		act = argument[3];
	}

	itemIndex = getBaseItemFromAct(itemType,act);
}
var item = instance_create_depth(x,y,1,itemIndex);
itemType = item.type;

// TODO -- the item might just be one of a set of possible object indexes provided.
// Add support for an itemIndexMap -- a map of object indexes that might be dropped
// this renders the notion of getting an item from an act unneeded when this param is provided

// if we're making a gem, refine gems to actual gem objects
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
	ds_map_destroy(gemQualityMap); gemQualityMap = -1;
	
	// decide gemType (ruby, hematite, etc)
	randomize();
	var rand = random_range(0,100);
	var gemTypeChanceMap = getDefaultGemTypeChanceMap();
	if argument_count >= 5 && argument[4] != noone {
		gemTypeChanceMap = argument[4];
	}
	var lowestSeen = 100; var gemType = noone;
	var currentItemType = ds_map_find_first(gemTypeChanceMap);
	var allGemTypes = [obj_gem_hematite, obj_gem_lapis, obj_gem_ruby, obj_gem_aquamarine, obj_gem_emerald, obj_gem_amethyst];
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
	ds_map_destroy(gemTypeChanceMap); gemTypeChanceMap = -1;
	
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

if item.type == ItemTypes.Other item.rarity = ItemRarities.Normal;

// modify base item properties based on rarity
if item.rarity != ItemRarities.Normal {
	modifyBasePropertiesByRarity(item,item.rarity);
}

// gems -- hand items and head items
if itemType == ItemTypes.HandItem || itemType == ItemTypes.Head {
	addSocketsAndGemsByRarity(item,rarityType);
}

// item properties -- rings only, for now
if itemType == ItemTypes.Ring {
	var addendums = argument_count >=6 ? argument[5] : noone;
	addItemPropertiesByRarityAndAct(item,rarityType,act,addendums);
}

appraiseItem(item);

return item;

