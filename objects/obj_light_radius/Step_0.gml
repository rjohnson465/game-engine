if instance_exists(owner) {
	if color != owner.lightRadiusColor {
		global.owner = owner;
		global.makeLightOnCreate = true;
		instance_create_depth(x,y,1,obj_light_radius);
		instance_destroy(id,false);
	}
	if owner.object_index == obj_fountain || owner.object_index == obj_sconce {
		layer = owner.origLayer;
		depth = layer_get_depth(layer);
	} else {
		layer = owner.layer;
		// updateLightLayer(id,noone, layer);
	}
}



if !instance_exists(owner) {
	instance_destroy(id);
}