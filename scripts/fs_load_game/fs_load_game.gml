/// loadGame(*filename)
/// @param filename

var filename = "";
if argument_count == 1 {
	filename = argument[0];
}

var save_data = ds_map_secure_load("Game.sav");

// load all enemies
fs_load_enemies(ds_map_find_value(save_data,"Enemies"));

// load all fountains
fs_load_fountains(ds_map_find_value(save_data,"Fountains"));

// load in player -- TODO
var nextRoomLayer = "instances_floor_1";
var p = global.player;
p.layerToMoveTo = nextRoomLayer;
room_restart();
with obj_weapon {
	refreshParticles = true;
}