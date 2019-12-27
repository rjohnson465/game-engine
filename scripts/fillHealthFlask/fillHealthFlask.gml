/// fillHealthFlask()


// fill health flask
var p = global.player;
var healthFlask = instance_nearest(x, y, obj_item_health_flask);
if (healthFlask != noone && healthFlask != undefined && healthFlask > 0 && instance_exists(healthFlask) && healthFlask.owner == p) {
	var chargesMax = ds_map_find_value(healthFlask.customItemProperties, hfs_max_charges);
	ds_map_replace(healthFlask.customItemProperties, hfs_charges, chargesMax);
	with healthFlask {
		updateHealthFlaskDescription();
	}
} 