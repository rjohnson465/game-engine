if isRunning && !isDoneFilling {
	isDoneFilling = true;
	sprite_index = asset_get_index("spr_fountain_full");
	
	global.owner = id;
	global.makeLightOnCreate = true;
	var lr = instance_create_depth(x,y,1,obj_light_radius);
	lr.persistent = true;
}