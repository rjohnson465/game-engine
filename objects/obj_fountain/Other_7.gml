if isRunning && !isDoneFilling {
	isDoneFilling = true;
	
	ds_map_replace(data.properties, "isDoneFilling", true);
	
	sprite_index = spr_fountain_full;
	
	global.owner = id;
	global.makeLightOnCreate = true;
	instance_create_depth(x,y,1,obj_light_radius);

}