// must be called by game manager obj
if currentSaveFile == noone currentSaveFile = "Game.sav";
isLoading = true;
alarm[0] = 1;
global.populateInventory = false;
global.ui.isShowingMenus = false;
fs_clear_roomdata_tempfile();

with obj_light_radius {
	if owner == global.player {
		persistent = true;
	}
}

var p = global.player;
p.gamePadIndex = global.gamePadIndex;
var save_data = ds_map_secure_load(currentSaveFile);
var pData = ds_map_find_value(save_data,"Player"); // a map of some relevant player data

// TODO -- load in player (persistent) before moving rooms?
if instance_exists(obj_player) {
	with obj_limb {
		if owner == global.player {
			instance_destroy(id,1);
		}
	}
	
	with global.player {
		freePlayerStructures();
		p.layerToMoveTo = ds_map_find_value(pData,"LastFountainZ");
		event_perform(ev_create,0);
	}
} 


// destroy all items in inventory
with obj_item_parent {
	var _owner = owner == global.player;
	var _is_not_ancestor = !object_is_ancestor(object_index,obj_unarmed_parent);
	var _is_unarmed_parent = object_index != obj_unarmed_parent;
	if _owner && _is_not_ancestor && _is_unarmed_parent {
		event_perform(ev_cleanup, 0); // ds clearing
		instance_destroy(id,1);
	}
}

// destroy all itemdrops
with obj_item_drop {
	instance_destroy(id,1);
}

// move rooms + position player

var newX = ds_map_find_value(pData,"LastX");
var newY = ds_map_find_value(pData,"LastY");
var newZ = ds_map_find_value(pData,"LastZ");
var newRoomName = ds_map_find_value(pData,"LastRoomName");


if newX == undefined {
	newX = ds_map_find_value(pData,"LastFountainX");
	newY = ds_map_find_value(pData,"LastFountainY");
	newZ = ds_map_find_value(pData,"LastFountainZ");
	newRoomName = ds_map_find_value(pData,"LastFountainRoom");
}

// Ensure last fountain variables are configured
p.lastFountainX = ds_map_find_value(pData,"LastFountainX");
p.lastFountainY = ds_map_find_value(pData,"LastFountainY");
p.lastFountainZ =ds_map_find_value(pData,"LastFountainZ");
p.lastFountainRoom = ds_map_find_value(pData,"LastFountainRoom");

// Load in the player's last location / layer / room
p.x = newX;
p.y = newY;
p.layerToMoveTo = newZ; // this is a string value, the name of the layer to move to
roomToGoTo = newRoomName;

// this line leaks one map, why?
room_goto(asset_get_index(roomToGoTo));

audio_stop_all(); 

ds_map_destroy(save_data); save_data = -1;

// reset enviro particles
with obj_environment_particles {
	instance_destroy(id,1);
}

