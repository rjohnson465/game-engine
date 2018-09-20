///light_create_caster_from_points_layer(points_x, points_y)
/*
Creates a caster from two lists of points.
points_x: ds_list of relative x positions.
points_y: ds_list of relative y positions.
Notice: An instance can only have one caster attached to it.
*/

for (var i = 0; i < ds_list_size(argument0); i++) {
    _light_points_x[i] = ds_list_find_value(argument0, i)
    _light_points_y[i] = ds_list_find_value(argument1, i)
}
ds_list_destroy(argument0); argument0 = -1;
ds_list_destroy(argument1); argument1 = -1;

var layerName = layer_get_name(layer);
var layerNum = real(string_char_at(layerName,string_length(layerName)));

var layerMap = ds_map_find_value(global._light_layers,layerNum);
var castersList = ds_map_find_value(layerMap,"_light_casters");

if ds_list_find_index(castersList, id) == -1 {
	ds_list_add(castersList,id);
}
//ds_list_add(global._light_casters, id)