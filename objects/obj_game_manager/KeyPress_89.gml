isLoading = true;
alarm[0] = 1;

// TODO -- load in player (persistent) before moving rooms?
var p = global.player;
var pData = fs_save_player(); // a map of some relevant player data
p.x = ds_map_find_value(pData,"LastFountainX");
p.y = ds_map_find_value(pData,"LastFountainY");
p.layerToMoveTo = ds_map_find_value(pData,"LastFountainZ");
roomToGoTo = ds_map_find_value(pData,"LastFountainRoom");

// destroy all itemdrops
with obj_item_drop {
	instance_destroy(id,1);
}

room_goto(roomToGoTo);
