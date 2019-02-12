// must be called by game manager obj
if currentSaveFile == noone currentSaveFile = "Game";
isLoading = true;
alarm[0] = 1;
global.populateInventory = false;
global.ui.isShowingMenus = false;
fs_clear_roomdata_tempfile();

var p = global.player;
p.gamePadIndex = global.gamePadIndex;
var save_data = ds_map_secure_load(currentSaveFile);
var pData = ds_map_find_value(save_data,"Player"); // a map of some relevant player data

// TODO -- load in player (persistent) before moving rooms?
if instance_exists(obj_player) {
	with obj_limb {
		if owner == global.player {
			instance_destroy(id,1);
		}
	}
	
	with global.player {
		//light_destroy_layer(getLayerFloorNumber(layer), playerLightRadius);
		//instance_destroy(playerLightRadius,1);
		instance_destroy(unarmed,1);
		
		// prevent mem leak
		ds_map_destroy(tutorialFirstsMap); tutorialFirstsMap = -1;
		ds_map_destroy(attackAgain); attackAgain = -1;
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

		
		mp_grid_destroy(personalGrid); personalGrid = -1;
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
		
		p.layerToMoveTo = ds_map_find_value(pData,"LastFountainZ");
		event_perform(ev_create,0);
	}
} 
// destroy all items in inventory
with obj_item_parent {
	var _name = object_get_name(object_index);
	var _owner = owner == global.player;
	var _is_not_ancestor = !object_is_ancestor(object_index,obj_unarmed_parent);
	var _is_unarmed_parent = object_index != obj_unarmed_parent;
	if _owner && _is_not_ancestor && _is_unarmed_parent {
		event_perform(ev_cleanup, 0); // ds clearing
		instance_destroy(id,1);
	}
}

// destroy all itemdrops
with obj_item_drop {
	instance_destroy(id,1);
}

// move rooms

p.x = ds_map_find_value(pData,"LastFountainX");
p.y = ds_map_find_value(pData,"LastFountainY");
p.layerToMoveTo = ds_map_find_value(pData,"LastFountainZ");
roomToGoTo = ds_map_find_value(pData,"LastFountainRoom");
room_goto(asset_get_index(roomToGoTo));
audio_stop_all();

ds_map_destroy(save_data); save_data = -1;

// reset enviro particles
with obj_environment_particles {
	instance_destroy(id,1);
}

