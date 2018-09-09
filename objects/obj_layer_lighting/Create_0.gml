floorNum = global.floorNum;
depth = layer_get_depth(layer_get_name("instances_floor_"+string(floorNum)))-1;

with obj_layer_lighting {
	if floorNum == other.floorNum && id != other.id {
		instance_destroy(id,1);
	}
}

isActive = false;
var lightLayerMap = ds_map_find_value(global._light_layers,floorNum);
lightColor = ds_map_find_value(lightLayerMap, "_light_color");