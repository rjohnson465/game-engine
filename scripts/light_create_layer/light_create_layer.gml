/// light_create_layer(light_sprite, light_scale, light_color, light_alpha, light_angle, shadows)
/*
Creates a light and the local variables for it.
/// @param sprite: Gradient sprite to use.
/// @param scale: Scale of the sprite.
/// @param color: The light color.
/// @param alpha: Brightness of the light, from 0 to 1.
/// @param shadows: If this light should draw shadows.
Notice: An instance can only have one light attached to it.
*/

_light_sprite = argument0
_light_scale = argument1
_light_color = argument2
_light_alpha = argument3
_light_angle = argument4
_light_shadows = argument5
_light_is_multiscaled = false

_light_max_dist = max(sprite_get_width(_light_sprite),
                      sprite_get_height(_light_sprite)) * _light_scale
					  
var layerName = layer_get_name(layer);
var layerNum = real(string_char_at(layerName,string_length(layerName)));

// do not add if this light is already in the light_layers map anywhere
// this is pretty much just so the player light radius isnt made again every time you die
/*
if persistent {
	var ck = ds_map_find_first(global._light_layers);
	for (var i = 0; i < ds_map_size(global._light_layers); i++) {
		
		var layerMap = ds_map_find_value(global._light_layers, ck);
		var lightsList = ds_map_find_value(layerMap, "_lights");
		
		var index = noone;
		// see if this lights list contains a lightobj whose owner is lightObj.owner, if so delet this cousin
		for (var i = 0; i < ds_list_size(lightsList); i++) {
			var _light = ds_list_find_value(lightsList, i);
			if (_light.object_index == obj_light_radius) {
				var own = _light.owner;
				if own == owner {
					index = i;
				}
			}
		}
		
		//var index = ds_list_find_index(lightsList, lightObj);
		if (index != noone && index >= 0) {
			//ds_list_delete(lightsList, index);
			return;
		}
			
		ck = ds_map_find_next(global._light_layers, ck);
	}
}*/


var layerMap = ds_map_find_value(global._light_layers,layerNum);
var lightsList = ds_map_find_value(layerMap,"_lights");
// add to the lights list iff its not already in there
if ds_list_find_index(lightsList,id) == -1 {
	ds_list_add(lightsList,id);
}
//ds_list_add(global._lights, id)