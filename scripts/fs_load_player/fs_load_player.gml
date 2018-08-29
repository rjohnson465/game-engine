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
}

//ds_map_destroy(sd_player); sd_player = -1;