if instance_exists(owner) {
	if color != owner.lightRadiusColor {
		global.owner = owner;
		global.makeLightOnCreate = true;
		var newLr = instance_create_depth(x,y,1,obj_light_radius);
		if owner == global.player {
			owner.playerLightRadius = newLr;
			newLr.persistent = true;
		}
		instance_destroy(id,false);
		
		
		//light_set_color(owner.lightRadiusColor);
	}
	if owner.object_index == obj_fountain || owner.object_index == obj_sconce {
		layer = owner.origLayer;
		depth = layer_get_depth(layer);
	} else {
		layer = owner.layer;
		// updateLightLayer(id,noone, layer);
	}
}