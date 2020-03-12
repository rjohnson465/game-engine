/// light_create_layer(light_sprite, light_scale, light_color, light_alpha, light_angle, shadows)

//Creates a light and the local variables for it.
/// @param sprite: Gradient sprite to use.
/// @param scale: Scale of the sprite.
/// @param color: The light color.
/// @param alpha: Brightness of the light, from 0 to 1.
/// @param angle
/// @param shadows: If this light should draw shadows.
/// Notice: An instance can only have one light attached to it.


_light_sprite = argument0
_light_scale = argument1
_light_color = argument2
_light_alpha = argument3
_light_angle = argument4
_light_shadows = argument5
_light_is_multiscaled = false

_light_max_dist = max(sprite_get_width(_light_sprite),
                      sprite_get_height(_light_sprite)) * _light_scale
					  
var lay = variable_instance_exists(id, "origLayer") ? origLayer : layer;
var layerName = layer_get_name(lay);
var layerNum = real(string_char_at(layerName,string_length(layerName)));


var layerMap = ds_map_find_value(global._light_layers,layerNum);
if layerMap == undefined exit;
var lightsList = ds_map_find_value(layerMap,"_lights");
// add to the lights list iff its not already in there
if ds_list_find_index(lightsList,id) == -1 {
	ds_list_add(lightsList,id);
}
