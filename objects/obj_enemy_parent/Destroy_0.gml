/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if ds_exists(persistentProperties, ds_type_map) {
	ds_map_destroy(persistentProperties); persistentProperties = -1;
}
if ds_exists(droppedItems, ds_type_list) {
	ds_list_destroy(droppedItems); droppedItems = -1;
}
if ds_exists(droppedItemsMandatory, ds_type_list) {
	ds_list_destroy(droppedItemsMandatory); droppedItemsMandatory = -1;
}
if ds_exists(droppedItemsReplacement, ds_type_list) {
	ds_list_destroy(droppedItemsReplacement); droppedItemsReplacement = -1;
}

if ds_exists(handItems, ds_type_map) {
	var ck = ds_map_find_first(handItems);
	for (var i = 0; i < ds_map_size(handItems); i++) {
		var item = ds_map_find_value(handItems,ck);
		if item != undefined && item >= 0 && instance_exists(item) {
			instance_destroy(item, 1); item = -1;
		}
		ck = ds_map_find_next(handItems,ck);
	}
	ds_map_destroy(handItems); handItems = -1;
}

if ds_exists(equippedLimbItems, ds_type_map) {
	var ck = ds_map_find_first(equippedLimbItems);
	for (var i = 0; i < ds_map_size(equippedLimbItems); i++) {
		var item = ds_map_find_value(equippedLimbItems,ck);
		if item != undefined && item >= 0 && instance_exists(item) {
			instance_destroy(item, 1); item = -1;
		}
		ck = ds_map_find_next(equippedLimbItems,ck);
	}
	ds_map_destroy(equippedLimbItems); equippedLimbItems = -1;
}

if ds_exists(droppedItems, ds_type_list) {
	ds_list_destroy(droppedItems); droppedItems = -1;
}
if ds_exists(beenHitWith, ds_type_list) {
	ds_list_destroy(beenHitWith); beenHitWith = -1;
}

if ds_exists(preparingLimbs, ds_type_map) {
	ds_map_destroy(preparingLimbs); preparingLimbs = -1;
}
if ds_exists(attackingLimbs, ds_type_map) {
	ds_map_destroy(attackingLimbs); attackingLimbs = -1;
}
if ds_exists(recoveringLimbs, ds_type_map) {
	ds_map_destroy(recoveringLimbs); recoveringLimbs = -1;
}
if ds_exists(prepFrames, ds_type_map) {
	ds_map_destroy(prepFrames); prepFrames = -1;
}
if ds_exists(attackFrames, ds_type_map) {
	ds_map_destroy(attackFrames); attackFrames = -1;
}
if ds_exists(recoverFrames, ds_type_map) {
	ds_map_destroy(recoverFrames); recoverFrames = -1;
}
if ds_exists(prepFrameTotals, ds_type_map) {
	ds_map_destroy(prepFrameTotals); prepFrameTotals = -1;
}
if ds_exists(recoverFrameTotals, ds_type_map) {
	ds_map_destroy(recoverFrameTotals); recoverFrameTotals = -1;
}

if ds_exists(conditionPercentages, ds_type_map) {
	ds_map_destroy(conditionPercentages); conditionPercentages = -1;
}
if ds_exists(conditionLevels, ds_type_map) {
	ds_map_destroy(conditionLevels); conditionLevels = -1;
}