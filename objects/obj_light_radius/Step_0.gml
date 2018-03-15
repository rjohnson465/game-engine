if instance_exists(owner) {
	if color != owner.lightRadiusColor {
		global.owner = owner;
		global.makeLightOnCreate = true;
		instance_create_depth(x,y,1,obj_light_radius);
		instance_destroy(id,false);
	}
	if owner.object_index == obj_fountain {
		layer = layer_get_id(owner.layerName);
	} else {
		layer = owner.layer;
	}
}



if !instance_exists(owner) {
	instance_destroy(id);
}