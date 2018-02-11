if color != owner.lightRadiusColor {
	global.owner = owner;
	global.makeLightOnCreate = makeLightOnCreate;
	instance_create_depth(x,y,1,obj_light_radius);
	instance_destroy(id,false);
}