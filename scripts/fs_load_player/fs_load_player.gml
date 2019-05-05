/// fs_load_player(player_data)
/// @param player_data
/// load some player properties

var sd_player = argument[0];
with global.player {
	hp = ds_map_find_value(sd_player,"Hp");
	xp = ds_map_find_value(sd_player,"Xp");
	xpTemp = ds_map_find_value(sd_player,"XpTemp");
	xpToNextLevel = ds_map_find_value(sd_player,"XpToNextLevel");
	level = ds_map_find_value(sd_player,"Level");
	skillPoints = ds_map_find_value(sd_player,"SkillPoints");
	currentSpellAttunement = ds_map_find_value(sd_player,"Attunement");
	currentBeltItemIndex = ds_map_find_value(sd_player,"CurrentBeltItemIndex");
	narrativeState = ds_map_find_value(sd_player,"NarrativeState");
	
	var tutFirstsMap = ds_map_find_value(sd_player,"TutorialFirstsMap");
	var mapClone = ds_map_create();
	var ck = ds_map_find_first(tutFirstsMap);
	for (var i = 0; i < ds_map_size(tutFirstsMap); i++) {
		var val = ds_map_find_value(tutFirstsMap, ck);
		var realKey = real(ck);
		ds_map_replace(mapClone, realKey, val);
		
		ck = ds_map_find_next(tutFirstsMap, ck);
	}
	
	// update belt item array
	with obj_item_parent {
		if beltItemIndex >= 0 {
			other.beltItems[beltItemIndex] = id;
		}
	}
	
	//var mapClone = ds_map_deep_clone(tutFirstsMap);
	var oldTutFirstsMap = tutorialFirstsMap;
	tutorialFirstsMap = mapClone;
	if ds_exists(oldTutFirstsMap, ds_type_map) {
		ds_map_destroy(oldTutFirstsMap); oldTutFirstsMap = -1;
	}
	
	// reset player light radius to the persistent player light radius object
	with obj_light_radius {
		if owner == other {
			other.playerLightRadius = id;
		}
	}
	
	updateLightLayer(playerLightRadius, noone, layerToMoveTo);
}