///light_destroy_caster_layer(layerNum)
/*
Destroys a caster
*/
var layerNum = argument0;

var map = ds_map_find_value(global._light_layers, layerNum);
var castersList = ds_map_find_value(map,"_light_casters");
var index = ds_list_find_index(castersList, id)
if index != -1 {
	ds_list_delete(castersList, index)
}