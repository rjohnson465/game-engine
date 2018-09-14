/*var ck = ds_map_find_first(conditionsEmittersMap);
for (var i = 0; i < ds_map_size(conditionsEmittersMap); i++) {
	var emitter = ds_map_find_value(conditionsEmittersMap,ck);
	audio_emitter_free(emitter); emitter = -1;
	ck = ds_map_find_next(conditionsEmittersMap,ck);
}
ds_map_destroy(conditionsEmittersMap); conditionsEmittersMap = -1;*/

//ds_map_destroy(attackAgain); attackAgain = -1;
//ds_map_destroy(propertiesBaseValues); propertiesBaseValues = -1;
//ds_map_destroy(itemPropertyBonuses); itemPropertyBonuses = -1;
//ds_map_destroy(skillPropertyBonuses); skillPropertyBonuses = -1;
//ds_map_destroy(physicalDamageTypesMultipliers); physicalDamageTypesMultipliers = -1;
//ds_map_destroy(elementalDamageTypesMultipliers); elementalDamageTypesMultipliers = -1;
//ds_map_destroy(criticalsChance); criticalsChance = -1;
//ds_map_destroy(criticalsDamage); criticalsDamage = -1;
//ds_map_destroy(weaponTypesDamage); weaponTypesDamage = -1;
//ds_map_destroy(comboHitsToNextLevelMap); comboHitsToNextLevelMap = -1;
		
//ds_list_destroy(inventory); inventory = -1;
//ds_list_destroy(quests); quests = -1;
//ds_list_destroy(equippedItems); equippedItems = -1;
//ds_list_destroy(lockOnList); lockOnList = -1;
//ds_list_destroy(lockOnListSeen); lockOnListSeen = -1;
//ds_list_destroy(beenHitWith); beenHitWith = -1;

ds_map_destroy(knownSpells); knownSpells = -1;
ds_map_destroy(defenses); defenses = -1;
mp_grid_destroy(personalGrid); personalGrid = -1;
if path_exists(gridPath) {
	path_delete(gridPath); gridPath = -1;
}
if path_exists(path) {
	path_delete(path); path = -1;
}
	/*	
ds_map_destroy(preparingLimbs); preparingLimbs = -1;
ds_map_destroy(attackingLimbs); attackingLimbs = -1;
ds_map_destroy(recoveringLimbs); recoveringLimbs = -1;
ds_map_destroy(prepFrames); prepFrames = -1;
ds_map_destroy(prepFrameTotals); prepFrameTotals = -1;
ds_map_destroy(attackFrames); attackFrames = -1;
ds_map_destroy(recoverFrames); recoverFrames = -1;
ds_map_destroy(recoverFrameTotals); recoverFrameTotals = -1;
ds_map_destroy(handItems); handItems = -1;
ds_map_destroy(equippedLimbItems); equippedLimbItems = -1;
		

ds_map_destroy(conditionPercentages); conditionPercentages = -1;
ds_map_destroy(conditionLevels); conditionLevels = -1;
*/

var ck = ds_map_find_first(conditionsEmittersMap);
for (var i = 0; i < ds_map_size(conditionsEmittersMap); i++) {
	var emitter = ds_map_find_value(conditionsEmittersMap,ck);
	audio_emitter_free(emitter); emitter = -1;
	ck = ds_map_find_next(conditionsEmittersMap,ck);
}
ds_map_destroy(conditionsEmittersMap); conditionsEmittersMap = -1;
audio_emitter_free(walkingInWaterEmitter); walkingInWaterEmitter = -1;