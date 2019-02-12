owner = global.owner;


layer = owner.layer;
if owner.object_index == obj_fountain || owner.object_index == obj_sconce {
	layer = owner.origLayer;
}

var il = global.gameManager.isLoading;
if il && owner.object_index == obj_player {

	// do not allow multiple player light radii
	with obj_light_radius {
		if instance_exists(id) && owner == global.player {
			instance_destroy(other);
			exit;
		}
	}

	owner.playerLightRadius = id;
	
}



makeLightOnCreate = global.makeLightOnCreate;
color = owner.lightRadiusColor;
colorAlpha = owner.lightRadiusAlpha;
spr = owner.lightRadiusSprite;
scale = owner.lightRadiusScale;
floorNum = real(string_copy(layer_get_name(layer),string_length(layer_get_name(layer)),1));
if makeLightOnCreate && ds_exists(ds_map_find_value(global._light_layers,floorNum),ds_type_map) {
	light_create_layer(spr, scale, color, colorAlpha, 0, true);
}
rot_inc = 20;
index = 0;