owner = global.owner;

layer = owner.layer;
if owner.object_index == obj_fountain || owner.object_index == obj_sconce {
	layer = owner.origLayer;
}

ownerKey = noone;
ownerAssetName = noone;

with owner {
	if variable_instance_exists(id, "origLayer") {
		other.layer = origLayer;
	}
	
	if variable_instance_exists(id, "key") {
		other.ownerKey = key;
	}
	
	other.ownerAssetName = object_get_name(object_index);
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

	global.player.playerLightRadius = id;
	
}



makeLightOnCreate = global.makeLightOnCreate;
color = owner.lightRadiusColor;
colorAlpha = owner.lightRadiusAlpha;
spr = owner.lightRadiusSprite;
scale = owner.lightRadiusScale;
floorNum = real(string_copy(layer_get_name(layer),string_length(layer_get_name(layer)),1));
_light_sprite = spr;
_light_scale = scale;
_light_color = color;
_light_alpha = colorAlpha;
_light_angle = 0;
_light_shadows = true;
_light_is_multiscaled = false
_light_max_dist = max(sprite_get_width(_light_sprite),
                      sprite_get_height(_light_sprite)) * _light_scale
					  
if makeLightOnCreate && ds_exists(ds_map_find_value(global._light_layers,floorNum),ds_type_map) {
	light_create_layer(spr, scale, color, colorAlpha, 0, true);
}
rot_inc = 20;
index = 0;