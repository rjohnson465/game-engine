/// freePlayerStructures()
/// this is dumb af but for whatever reason the cleanup event won't fire when called in loadGame
/// so here's a custom script to do that
/// must be called by player obj

instance_destroy(unarmed,1);
		
// prevent mem leak
ds_map_destroy(tutorialFirstsMap); tutorialFirstsMap = -1;
ds_map_destroy(attackAgain); attackAgain = -1;

//88 is a criticalsChanceMap at start
var a = 88;

ds_map_destroy(propertiesBaseValues); propertiesBaseValues = -1;
ds_map_destroy(itemPropertyBonuses); itemPropertyBonuses = -1;
ds_map_destroy(skillPropertyBonuses); skillPropertyBonuses = -1;
ds_map_destroy(physicalDamageTypesMultipliers); physicalDamageTypesMultipliers = -1;
ds_map_destroy(elementalDamageTypesMultipliers); elementalDamageTypesMultipliers = -1;
ds_map_destroy(criticalsChance); criticalsChance = -1;
ds_map_destroy(criticalsDamage); criticalsDamage = -1;
ds_map_destroy(weaponTypesDamage); weaponTypesDamage = -1;
ds_map_destroy(comboHitsToNextLevelMap); comboHitsToNextLevelMap = -1;
		
ds_list_destroy(inventory); inventory = -1;
ds_list_destroy(quests); quests = -1;
ds_list_destroy(equippedItems); equippedItems = -1;
ds_list_destroy(lockOnList); lockOnList = -1;
ds_list_destroy(lockOnListSeen); lockOnListSeen = -1;
ds_list_destroy(beenHitWith); beenHitWith = -1;

if ds_exists(nonPriorityInteractionPrompts, ds_type_list) {
	ds_list_destroy(nonPriorityInteractionPrompts); nonPriorityInteractionPrompts = -1;
}

if (personalGrid != undefined && ds_exists(personalGrid, ds_type_grid)) {
	mp_grid_destroy(personalGrid); personalGrid = -1;
}
path_delete(gridPath); gridPath = -1;
path_delete(path); path = -1;
		
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
		
ds_map_destroy(knownSpells); knownSpells = -1;
ds_map_destroy(defenses); defenses = -1;
ds_map_destroy(conditionPercentages); conditionPercentages = -1;
ds_map_destroy(conditionLevels); conditionLevels = -1;
var ck = ds_map_find_first(conditionsEmittersMap);
for (var i = 0; i < ds_map_size(conditionsEmittersMap); i++) {
	var emitter = ds_map_find_value(conditionsEmittersMap,ck);
	audio_emitter_free(emitter); emitter = -1;
	ck = ds_map_find_next(conditionsEmittersMap,ck);
}
ds_map_destroy(conditionsEmittersMap); conditionsEmittersMap = -1;
audio_emitter_free(walkingInWaterEmitter); walkingInWaterEmitter = -1;

audio_stop_sound(walkingSoundIndex); walkingSoundIndex = -1;
audio_stop_sound(walkingInWaterSoundId); walkingInWaterSoundId = -1;
// sprint particles system destroy
if part_emitter_exists(sprintParticleSystem, sprintParticleEmitter) {
	part_emitter_destroy(sprintParticleSystem, sprintParticleEmitter);
	sprintParticle = -1;
}
if part_system_exists(sprintParticleSystem) {
	part_system_destroy(sprintParticleSystem); sprintParticleSystem = -1;
}
if part_type_exists(sprintParticle) {
	part_type_destroy(sprintParticle); sprintParticle = -1;
}

if ds_exists(guessPathPts, ds_type_list) {
	ds_list_destroy(guessPathPts); guessPathPts = -1;
}

if ds_exists(knownSpells, ds_type_map) {
	ds_map_destroy(knownSpells); knownSpells = -1;
}
if ds_exists(defenses, ds_type_map) {
	ds_map_destroy(defenses); defenses = -1;
}
if (personalGrid != undefined && ds_exists(personalGrid, ds_type_grid)) {
	mp_grid_destroy(personalGrid); personalGrid = -1;
}
if path_exists(gridPath) {
	path_delete(gridPath); gridPath = -1;
}
if path_exists(path) {
	path_delete(path); path = -1;
}

if ds_exists(conditionsEmittersMap, ds_type_map) {
	var ck = ds_map_find_first(conditionsEmittersMap);
	for (var i = 0; i < ds_map_size(conditionsEmittersMap); i++) {
		var emitter = ds_map_find_value(conditionsEmittersMap,ck);
		audio_emitter_free(emitter); emitter = -1;
		ck = ds_map_find_next(conditionsEmittersMap,ck);
	}
	ds_map_destroy(conditionsEmittersMap); conditionsEmittersMap = -1;
}

if ds_exists(conditionSoundsMap, ds_type_map) {
	ds_map_destroy(conditionSoundsMap); conditionSoundsMap = -1;
}
if audio_emitter_exists(walkingInWaterEmitter) {
	audio_emitter_free(walkingInWaterEmitter); walkingInWaterEmitter = -1;
}

if audio_emitter_exists(walkingEmitter) {
	audio_emitter_free(walkingEmitter); walkingEmitter = -1;
}

// sprint particles system destroy
if part_emitter_exists(sprintParticleSystem, sprintParticleEmitter) {
	part_emitter_destroy(sprintParticleSystem, sprintParticleEmitter);
	sprintParticle = -1;
}
if part_system_exists(sprintParticleSystem) {
	part_system_destroy(sprintParticleSystem); sprintParticleSystem = -1;
}
if part_type_exists(sprintParticle) {
	part_type_destroy(sprintParticle); sprintParticle = -1;
}

// attack prep particle system destroy
if part_emitter_exists(appSystem, appEmitter) {
	part_emitter_destroy(appSystem, appEmitter); appEmitter = -1;
}
if part_system_exists(appSystem) {
	part_system_destroy(appSystem); appSystem = -1;
}

if audio_emitter_exists(attackPrepSoundEmitter) {
	audio_emitter_free(attackPrepSoundEmitter); attackPrepSoundEmitter = -1;
}

var hf = instance_nearest(x, y, obj_item_health_flask);
if hf > 0 {
	with hf {
		instance_destroy(id, 1);
	}
}

audio_stop_sound(walkingSoundIndex); walkingSoundIndex = -1;

ds_map_destroy(inventoryCapacityMap); inventoryCapacityMap = -1;
if ds_exists(temporaryDefenses, ds_type_list) {
	ds_list_destroy(temporaryDefenses); temporaryDefenses = -1;
}