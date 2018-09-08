floorNum = global.floorNum;
depth = layer_get_depth(layer_get_name("instances_floor_"+string(floorNum)))-1;

with obj_layer_lighting {
	if floorNum == other.floorNum && id != other.id {
		instance_destroy(id,1);
	}
}