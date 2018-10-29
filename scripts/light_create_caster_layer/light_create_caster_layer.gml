///light_create_caster_layer()
/*
Creates a caster from the size of the object's sprite.
Notice: An instance can only have one caster attached to it.
*/

var xoffset, yoffset, width, height;
xoffset = sprite_get_xoffset(sprite_index)
yoffset = sprite_get_yoffset(sprite_index)
width = sprite_get_width(sprite_index)//*image_xscale;
height = sprite_get_height(sprite_index)//*image_yscale;

//width = bbox_right - bbox_left;
//height = bbox_bottom - bbox_top;

_light_points_x[0] = -xoffset
_light_points_y[0] = -yoffset

_light_points_x[1] = width - xoffset
_light_points_y[1] = -yoffset

_light_points_x[2] = width - xoffset
_light_points_y[2] = height - yoffset

_light_points_x[3] = -xoffset
_light_points_y[3] = height - yoffset

var layerName = layer_get_name(layer);
var layerNum = real(string_char_at(layerName,string_length(layerName)));

var layerMap = ds_map_find_value(global._light_layers,layerNum);
var castersList = ds_map_find_value(layerMap,"_light_casters");
ds_list_add(castersList,id);

//ds_list_add(global._light_casters, id)