/// fs_load_fountains(fountainsDataMap)
/// @param fountainsDataMap
/// creates fountains data objects from save game file

// destroy all current fountain data objs
with obj_fountain_data {
	instance_destroy(id,1);
}

var sd_fountains = argument[0];
var cv = ds_map_find_first(sd_fountains);
for (var i = 0; i < ds_map_size(sd_fountains); i++) {
	
	var sd_fountain = ds_map_find_value(sd_fountains,cv);
	
	var fountainDataObj = noone;
	with obj_fountain_data {
		if key == cv fountainDataObj = id;
	} 
	if fountainDataObj == noone fountainDataObj = instance_create_depth(x,y,1,obj_fountain_data);
	
	fountainDataObj.key = cv;
	fountainDataObj.postX = ds_map_find_value(sd_fountain,"postX");
	fountainDataObj.postY = ds_map_find_value(sd_fountain,"postY");
	fountainDataObj.isDoneFilling = ds_map_find_value(sd_fountain,"isDoneFilling");
	
	// might need to hard-set the fountain being on and give it its light radius
	with obj_fountain {
		if key == cv {
			fountainData = fountainDataObj;
			if fountainDataObj.isDoneFilling {
				sprite_index = asset_get_index("spr_fountain_full");
				isDoneFilling = true;
				isRunning = true;
				with obj_light_radius {
					if owner == other.id {
						instance_destroy(id,1);
					}
				}
				global.owner = id;
				global.makeLightOnCreate = true;
				instance_create_depth(x,y,1,obj_light_radius);
			}
		}
	}
	
	cv = ds_map_find_next(sd_fountains,cv);
}