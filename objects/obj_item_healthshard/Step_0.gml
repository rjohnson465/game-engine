/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var p = global.player;
if isInUse {
	
	var hf = instance_nearest(x, y, obj_item_health_flask);
	if hf {
		with hf {
			var currentMaxCharges = ds_map_find_value(customItemProperties, hfs_max_charges);
			ds_map_replace(customItemProperties, hfs_max_charges, currentMaxCharges + 1);
			updateHealthFlaskDescription();
		}
	}
	
	isInUse = false;
}