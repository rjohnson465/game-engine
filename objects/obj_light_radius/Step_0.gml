if instance_exists(owner) {
	if color != owner.lightRadiusColor {
		global.owner = owner;
		global.makeLightOnCreate = true;
		instance_create_depth(x,y,1,obj_light_radius);
		instance_destroy(id,false);
	}
	layer = owner.layer;
}



if !instance_exists(owner) {
	instance_destroy(id);
}