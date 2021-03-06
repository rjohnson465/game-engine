/// fs_save_player
/// returns a map of player data

var sd_player = ds_map_create();

with global.player {

	if lastFountainX < 0 {
		lastFountain = instance_nearest(x,y,obj_fountain);
		lastFountainX = lastFountain.spawnX;
		lastFountainY = lastFountain.spawnY;
		lastFountainZ = lastFountain.layerName;
		lastFountainRoom = room_get_name(room);
	}

	ds_map_replace(sd_player,"LastFountainX",lastFountainX);
	ds_map_replace(sd_player,"LastFountainY",lastFountainY);
	ds_map_replace(sd_player,"LastFountainZ",lastFountainZ); // layer name
	ds_map_replace(sd_player,"LastFountainRoom",lastFountainRoom);
	
	ds_map_replace(sd_player,"LastX",x);
	ds_map_replace(sd_player,"LastY",y);
	ds_map_replace(sd_player,"LastZ",layer_get_name(layer));
	ds_map_replace(sd_player,"LastRoomName",room_get_name(room));
	
	ds_map_replace(sd_player,"Hp",hp);
	ds_map_replace(sd_player,"Level",level);
	ds_map_replace(sd_player,"Xp",xp);
	ds_map_replace(sd_player,"XpTemp",xpTemp);
	ds_map_replace(sd_player,"XpToNextLevel",xpToNextLevel);
	ds_map_replace(sd_player,"SkillPoints",skillPoints);
	ds_map_replace(sd_player,"Attunement",currentSpellAttunement);
	ds_map_replace(sd_player,"CurrentBeltItemIndex",currentBeltItemIndex);
	
	ds_map_replace(sd_player,"NarrativeState",narrativeState);
	
	var tutFirstMap = ds_map_deep_clone(tutorialFirstsMap);
	ds_map_add_map(sd_player,"TutorialFirstsMap",tutFirstMap);

}

return sd_player;