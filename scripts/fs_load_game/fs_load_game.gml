/// loadGame(*filename)
/// @param filename

var filename = currentSaveFile;
if argument_count == 1 {
	filename = argument[0];
}
if filename == noone filename = "Game";
currentSaveFile = filename;

var a = ds_list_create();
var b = ds_map_create();
ds_list_destroy(a); a = -1;
ds_map_destroy(b); b = -1;

var save_data = ds_map_secure_load(filename);

// load all enemies 
fs_load_enemies(ds_map_find_value(save_data,"Enemies"));

// load all persistent room elements (fountains, doors)
fs_load_roomdata(ds_map_find_value(save_data,"RoomData"));

// load in player -- TODO
var nextRoomLayer = "instances_floor_1";
var p = global.player;
p.layerToMoveTo = nextRoomLayer;
with obj_weapon {
	refreshParticles = true;
}
fs_load_player(ds_map_find_value(save_data,"Player"));

// load inventory 
fs_load_inventory(ds_map_find_value(save_data,"Inventory"));

// load skills 
fs_load_skills(ds_map_find_value(save_data,"Skills"));

// load quests
fs_load_quests(ds_map_find_value(save_data,"Quests"));

// load npcs
fs_load_npcs(ds_map_find_value(save_data,"Npcs"));


// eh, let player have max hp and stamina
global.player.hp = global.player.maxHp;
global.player.stamina = global.player.maxStamina;

with obj_environment_particles_controller {
	event_perform(ev_other,ev_room_end);
}

ds_map_destroy(save_data); save_data = -1;

var a = ds_list_create();
var b = ds_map_create();
ds_list_destroy(a); a = -1;
ds_map_destroy(b); b = -1;

