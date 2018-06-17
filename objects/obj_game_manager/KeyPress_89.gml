/*isLoading = true;
alarm[0] = 1;

// TODO -- load in player (persistent) before moving rooms?
if instance_exists(global.player) {
	with obj_limb {
		if owner == global.player {
			instance_destroy(id,1);
		}
	}
	
	with global.player {
		instance_destroy(playerLightRadius,1);
		
		// prevent mem leak
		ds_map_destroy(attackAgain);
		ds_map_destroy(itemPropertyBonuses);
		ds_map_destroy(skillPropertyBonuses);
		ds_map_destroy(physicalDamageTypesMultipliers);
		ds_map_destroy(elementalDamageTypesMultipliers);
		ds_map_destroy(criticalsChance);
		ds_map_destroy(criticalsDamage);
		ds_map_destroy(weaponTypesDamage);
		ds_map_destroy(comboHitsToNextLevelMap);
		
		ds_list_destroy(inventory);
		ds_list_destroy(quests);
		ds_list_destroy(equippedItems);
		ds_list_destroy(lockOnList);
		ds_list_destroy(lockOnListSeen);
		ds_list_destroy(beenHitWith);
		
		event_perform(ev_create,0);
	}
} else {
	instance_create_depth(x,y,1,obj_player);
}
var p = global.player;
p.gamePadIndex = global.gamePadIndex;
var save_data = ds_map_secure_load(currentSaveFile);
var pData = ds_map_find_value(save_data,"Player"); // a map of some relevant player data
p.x = ds_map_find_value(pData,"LastFountainX");
p.y = ds_map_find_value(pData,"LastFountainY");
p.layerToMoveTo = ds_map_find_value(pData,"LastFountainZ");
roomToGoTo = ds_map_find_value(pData,"LastFountainRoom");

// destroy all itemdrops
with obj_item_drop {
	instance_destroy(id,1);
}

room_goto(roomToGoTo);
