// must be called by game manager obj

// fade to load
//global.fadeDuration = 30;
//global.owner = id;
//fade = instance_create_depth(x,y,-100000,obj_fade);

isLoading = true;
alarm[0] = 1;

// TODO -- load in player (persistent) before moving rooms?
if instance_exists(obj_player) {
	with obj_limb {
		if owner == global.player {
			instance_destroy(id,1);
		}
	}
	
	with global.player {
		instance_destroy(playerLightRadius,1);
		
		// prevent mem leak
		ds_map_destroy(attackAgain); attackAgain = -1;
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
		
		event_perform(ev_create,0);
	}
} else {
	//instance_create_depth(x,y,1,obj_player);
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

//if instance_exists(fade) {
	//if fade.frame == .5*fade.fadeDuration {
		

		room_goto(roomToGoTo);
		audio_stop_all();
	//}
//}


