/// loadGame(*filename)
/// @param filename

var filename = currentSaveFile;
if argument_count == 1 {
	filename = argument[0];
}
if filename == noone filename = "Game.sav";
currentSaveFile = filename;

var save_data = ds_map_secure_load(filename);

/*
// load all enemies 
fs_load_enemies(ds_map_find_value(save_data,"Enemies"));

// load all persistent room elements (fountains, doors)
fs_load_roomdata(ds_map_find_value(save_data,"RoomData"));



// load inventory -- inventory must load before player for belt items
global.doNotDisplayTutorialMessages = true;
fs_load_inventory(ds_map_find_value(save_data,"Inventory"));
global.doNotDisplayTutorialMessages = false;

with obj_weapon {
	refreshParticles = true;
}
// load in player -- 
fs_load_player(ds_map_find_value(save_data,"Player"));

// load skills 
fs_load_skills(ds_map_find_value(save_data,"Skills"));

// load quests
fs_load_quests(ds_map_find_value(save_data,"Quests"));

// load npcs
fs_load_npcs(ds_map_find_value(save_data,"Npcs"));


with obj_environment_particles_controller {
	event_perform(ev_other,ev_room_end);
} */

ds_map_destroy(save_data); save_data = -1;

