/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var floorNum = getLayerFloorNumber(layer);
grid = ds_map_find_value(global.grids, floorNum); 

var hh = instance_nearest(x, y, obj_quest_helpinghershel);
if instance_exists(hh) && hh.isFinished {
	var ari = instance_nearest(x, y, obj_npc_ari);
	x = ari.x + 10;
	y = ari.y - 100;
	isWithAri = true;
	isActive = false;
	sprite_index = spr_hershel_idle;
}