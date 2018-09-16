/// light_create_layer_multiscaled(light_sprite, light_xscale, light_yscale, light_color, light_alpha, light_angle, shadows)

/// Creates a light and the local variables for it.
/// @param sprite: Gradient sprite to use.
/// @param xscale: Scale of the sprite.
/// @param yscale
/// @param color: The light color.
/// @param alpha: Brightness of the light, from 0 to 1.
/// @param angle
/// @param shadows: If this light should draw shadows.
/// Notice: An instance can only have one light attached to it.


_light_sprite = argument0
_light_is_multiscaled = true;
_light_scale = 1;
_light_xscale = argument1
_light_yscale = argument2
_light_color = argument3
_light_alpha = argument4
_light_angle = argument5
_light_shadows = argument6

var ls = max(_light_xscale, _light_yscale);

_light_max_dist = max(sprite_get_width(_light_sprite),
                      sprite_get_height(_light_sprite)) * ls
					  
var layerName = layer_get_name(layer);
var layerNum = real(string_char_at(layerName,string_length(layerName)));

var layerMap = ds_map_find_value(global._light_layers,layerNum);
var lightsList = ds_map_find_value(layerMap,"_lights");
// add to the lights list iff its not already in there
if ds_list_find_index(lightsList,id) == -1 {
	ds_list_add(lightsList,id);
}
//ds_list_add(global._lights, id)