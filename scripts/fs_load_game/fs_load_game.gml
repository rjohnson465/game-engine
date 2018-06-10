/// loadGame(*filename)
/// @param filename

var filename = "Game.sav";
if argument_count == 1 {
	filename = argument[0];
}

var save_data = ds_map_secure_load(filename);

// load all enemies
fs_load_enemies(ds_map_find_value(save_data,"Enemies"));

// load all fountains
fs_load_fountains(ds_map_find_value(save_data,"Fountains"));

// load in player -- TODO
/*var nextRoomLayer = "instances_floor_1";
var p = global.player;
p.layerToMoveTo = nextRoomLayer;
//room_restart();
with obj_weapon {
	refreshParticles = true;
}*/

fs_load_player(ds_map_find_value(save_data,"Player"));

// load inventory 
fs_load_inventory(ds_map_find_value(save_data,"Inventory"));

// load skills 
fs_load_skills(ds_map_find_value(save_data,"Skills"));

// load quests
fs_load_quests(ds_map_find_value(save_data,"Quests"));

// eh, let player have max hp and stamina
global.player.hp = global.player.maxHp;
global.player.stamina = global.player.maxStamina;