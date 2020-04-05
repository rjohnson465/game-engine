/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	
	var hf = instance_nearest(x, y, obj_item_health_flask);
	if hf {
		with hf {
			var currentChargeStrength = ds_map_find_value(customItemProperties, hfs_charge_strength);
			ds_map_replace(customItemProperties, hfs_charge_strength, currentChargeStrength + 10);
			updateHealthFlaskDescription();
		}
	}
	
	isInUse = false;
}