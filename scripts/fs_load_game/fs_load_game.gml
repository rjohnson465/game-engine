/// loadGame(*filename)
/// @param filename

var filename = currentSaveFile;
if argument_count == 1 {
	filename = argument[0];
}
if filename == noone filename = "Game.sav";
currentSaveFile = filename;

var save_data = ds_map_secure_load(filename);


// load all enemies 
// maps / lists clean
fs_load_enemies(ds_map_find_value(save_data,"Enemies"));

// load all persistent room elements (fountains, doors)
// leaks 1 map
fs_load_roomdata(ds_map_find_value(save_data,"RoomData"));

// load inventory -- inventory must load before player for belt items
global.doNotDisplayTutorialMessages = true;
// Maps / lists clean
fs_load_inventory(ds_map_find_value(save_data,"Inventory")); 
global.doNotDisplayTutorialMessages = false;

with obj_weapon {
	refreshParticles = true;
}

// load in player -- 
// Maps / lists clean
fs_load_player(ds_map_find_value(save_data,"Player"));

// load skills 
// maps / lists clean
fs_load_skills(ds_map_find_value(save_data,"Skills"));

// load quests
// maps / lists clean
fs_load_quests(ds_map_find_value(save_data,"Quests"));

// load npcs
// maps / lists clean, methinks
fs_load_npcs(ds_map_find_value(save_data,"Npcs"));

// load options 
fs_load_options(ds_map_find_value(save_data,"Options"));

with obj_environment_particles_controller {
	event_perform(ev_other,ev_room_end);
} 

updateNarrativeState(global.player.narrativeState);

// give player max poise
with obj_player {
	poiseCurrent = poiseMax;
}

ds_map_destroy(save_data); save_data = -1;

